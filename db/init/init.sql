--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5 (Debian 17.5-1.pgdg120+1)
-- Dumped by pg_dump version 17.5 (Debian 17.5-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64),
    details_json text
);


ALTER TABLE public.admin_event_entity OWNER TO mealwurm;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO mealwurm;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO mealwurm;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO mealwurm;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO mealwurm;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO mealwurm;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO mealwurm;

--
-- Name: client; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO mealwurm;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO mealwurm;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO mealwurm;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO mealwurm;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO mealwurm;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO mealwurm;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO mealwurm;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO mealwurm;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO mealwurm;

--
-- Name: component; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO mealwurm;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.component_config OWNER TO mealwurm;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO mealwurm;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO mealwurm;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO mealwurm;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO mealwurm;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO mealwurm;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


ALTER TABLE public.event_entity OWNER TO mealwurm;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024),
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.fed_user_attribute OWNER TO mealwurm;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO mealwurm;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO mealwurm;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO mealwurm;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO mealwurm;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO mealwurm;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO mealwurm;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO mealwurm;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO mealwurm;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO mealwurm;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO mealwurm;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL,
    organization_id character varying(255),
    hide_on_login boolean DEFAULT false
);


ALTER TABLE public.identity_provider OWNER TO mealwurm;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO mealwurm;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO mealwurm;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO mealwurm;

--
-- Name: ingredient; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.ingredient (
    id uuid NOT NULL,
    created_at timestamp(6) without time zone,
    created_by character varying(255),
    last_modified_at timestamp(6) without time zone,
    last_modified_by character varying(255),
    ingredient_order integer NOT NULL,
    text character varying(255),
    recipe_id uuid
);


ALTER TABLE public.ingredient OWNER TO mealwurm;

--
-- Name: jgroups_ping; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.jgroups_ping (
    address character varying(200) NOT NULL,
    name character varying(200),
    cluster_name character varying(200) NOT NULL,
    ip character varying(200) NOT NULL,
    coord boolean
);


ALTER TABLE public.jgroups_ping OWNER TO mealwurm;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36),
    type integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.keycloak_group OWNER TO mealwurm;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO mealwurm;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO mealwurm;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL,
    version integer DEFAULT 0
);


ALTER TABLE public.offline_client_session OWNER TO mealwurm;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL,
    broker_session_id character varying(1024),
    version integer DEFAULT 0
);


ALTER TABLE public.offline_user_session OWNER TO mealwurm;

--
-- Name: org; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.org (
    id character varying(255) NOT NULL,
    enabled boolean NOT NULL,
    realm_id character varying(255) NOT NULL,
    group_id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(4000),
    alias character varying(255) NOT NULL,
    redirect_url character varying(2048)
);


ALTER TABLE public.org OWNER TO mealwurm;

--
-- Name: org_domain; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.org_domain (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    verified boolean NOT NULL,
    org_id character varying(255) NOT NULL
);


ALTER TABLE public.org_domain OWNER TO mealwurm;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO mealwurm;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO mealwurm;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO mealwurm;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO mealwurm;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO mealwurm;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO mealwurm;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO mealwurm;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO mealwurm;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO mealwurm;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO mealwurm;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO mealwurm;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO mealwurm;

--
-- Name: recipe; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.recipe (
    id uuid NOT NULL,
    created_at timestamp(6) without time zone,
    created_by character varying(255),
    last_modified_at timestamp(6) without time zone,
    last_modified_by character varying(255),
    cook_time integer NOT NULL,
    instructions text,
    prep_time integer NOT NULL,
    title character varying(255),
    user_id uuid
);


ALTER TABLE public.recipe OWNER TO mealwurm;

--
-- Name: recipes_tags; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.recipes_tags (
    tag_id uuid NOT NULL,
    recipe_id uuid NOT NULL
);


ALTER TABLE public.recipes_tags OWNER TO mealwurm;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO mealwurm;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO mealwurm;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO mealwurm;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO mealwurm;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO mealwurm;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO mealwurm;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO mealwurm;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO mealwurm;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO mealwurm;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO mealwurm;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO mealwurm;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO mealwurm;

--
-- Name: revoked_token; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.revoked_token (
    id character varying(255) NOT NULL,
    expire bigint NOT NULL
);


ALTER TABLE public.revoked_token OWNER TO mealwurm;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO mealwurm;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO mealwurm;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO mealwurm;

--
-- Name: tag; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.tag (
    id uuid NOT NULL,
    created_at timestamp(6) without time zone,
    created_by character varying(255),
    last_modified_at timestamp(6) without time zone,
    last_modified_by character varying(255),
    name character varying(255),
    user_id uuid
);


ALTER TABLE public.tag OWNER TO mealwurm;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.user_attribute OWNER TO mealwurm;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO mealwurm;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO mealwurm;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO mealwurm;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO mealwurm;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO mealwurm;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO mealwurm;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO mealwurm;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL,
    membership_type character varying(255) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO mealwurm;

--
-- Name: user_mealwyrm; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.user_mealwyrm (
    id uuid NOT NULL,
    created_at timestamp(6) without time zone,
    email character varying(255),
    last_modified_at timestamp(6) without time zone,
    username character varying(255)
);


ALTER TABLE public.user_mealwyrm OWNER TO mealwurm;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO mealwurm;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO mealwurm;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO mealwurm;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type, details_json) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
94a710fd-4757-4891-b8b9-735766442577	\N	auth-cookie	d173fb4f-af6c-4c50-bd78-301237d5f821	a986bd6f-0d25-47b9-93bc-2f535c61c98e	2	10	f	\N	\N
cf622622-1e17-4222-9e02-0affe4ed91de	\N	auth-spnego	d173fb4f-af6c-4c50-bd78-301237d5f821	a986bd6f-0d25-47b9-93bc-2f535c61c98e	3	20	f	\N	\N
2d9c0147-88a0-4ebf-8bc6-84e25a8d224c	\N	identity-provider-redirector	d173fb4f-af6c-4c50-bd78-301237d5f821	a986bd6f-0d25-47b9-93bc-2f535c61c98e	2	25	f	\N	\N
b769329b-0874-4da7-983c-f4c7f3ac6b53	\N	\N	d173fb4f-af6c-4c50-bd78-301237d5f821	a986bd6f-0d25-47b9-93bc-2f535c61c98e	2	30	t	c2ecff36-f9e2-49ff-b396-a21b46090f38	\N
da24060e-231d-48e9-8769-2f43b7781c87	\N	auth-username-password-form	d173fb4f-af6c-4c50-bd78-301237d5f821	c2ecff36-f9e2-49ff-b396-a21b46090f38	0	10	f	\N	\N
983e5a2c-3076-4bb5-a43e-6ae7c623a003	\N	\N	d173fb4f-af6c-4c50-bd78-301237d5f821	c2ecff36-f9e2-49ff-b396-a21b46090f38	1	20	t	c0147ca4-c885-497f-b98a-83fcb4ba47a3	\N
0630adb2-312e-455c-b8db-df09d72d87c4	\N	conditional-user-configured	d173fb4f-af6c-4c50-bd78-301237d5f821	c0147ca4-c885-497f-b98a-83fcb4ba47a3	0	10	f	\N	\N
88bf535a-096c-40c4-8cd4-c48337d7b3d1	\N	auth-otp-form	d173fb4f-af6c-4c50-bd78-301237d5f821	c0147ca4-c885-497f-b98a-83fcb4ba47a3	0	20	f	\N	\N
8ee8bdbe-9373-4273-88bb-899c6c28c544	\N	direct-grant-validate-username	d173fb4f-af6c-4c50-bd78-301237d5f821	3d45feb7-fbb0-415e-879b-95eb6ade8d37	0	10	f	\N	\N
eb889d37-97f8-46ca-8067-bbe3617e430d	\N	direct-grant-validate-password	d173fb4f-af6c-4c50-bd78-301237d5f821	3d45feb7-fbb0-415e-879b-95eb6ade8d37	0	20	f	\N	\N
40530409-bd66-4c51-b407-b9ad18924988	\N	\N	d173fb4f-af6c-4c50-bd78-301237d5f821	3d45feb7-fbb0-415e-879b-95eb6ade8d37	1	30	t	b2097953-1250-4108-a6ca-e42aa2600a31	\N
72ad9b29-01de-4668-ae70-7ea386711113	\N	conditional-user-configured	d173fb4f-af6c-4c50-bd78-301237d5f821	b2097953-1250-4108-a6ca-e42aa2600a31	0	10	f	\N	\N
d268b743-f921-49a7-990d-f688af885c34	\N	direct-grant-validate-otp	d173fb4f-af6c-4c50-bd78-301237d5f821	b2097953-1250-4108-a6ca-e42aa2600a31	0	20	f	\N	\N
0498dcb1-4230-46b4-b0ef-c9d3cc2c74d8	\N	registration-page-form	d173fb4f-af6c-4c50-bd78-301237d5f821	5dbfddb3-35f7-467d-99a5-f0853034d0e2	0	10	t	6ae5928d-a870-4b23-8100-aade6b232cdc	\N
df762758-0e16-437e-963d-19eb2b3e79f6	\N	registration-user-creation	d173fb4f-af6c-4c50-bd78-301237d5f821	6ae5928d-a870-4b23-8100-aade6b232cdc	0	20	f	\N	\N
2e7046b2-6b51-4f41-b3ff-b106c0bd4aad	\N	registration-password-action	d173fb4f-af6c-4c50-bd78-301237d5f821	6ae5928d-a870-4b23-8100-aade6b232cdc	0	50	f	\N	\N
8cb960a1-5c74-4447-9196-6a7b9bd02fa5	\N	registration-recaptcha-action	d173fb4f-af6c-4c50-bd78-301237d5f821	6ae5928d-a870-4b23-8100-aade6b232cdc	3	60	f	\N	\N
37fd89ac-5035-4e29-94c2-8fa8c7ba2b15	\N	registration-terms-and-conditions	d173fb4f-af6c-4c50-bd78-301237d5f821	6ae5928d-a870-4b23-8100-aade6b232cdc	3	70	f	\N	\N
6c9761d1-1ea9-4dc3-91d0-f678103b3b05	\N	reset-credentials-choose-user	d173fb4f-af6c-4c50-bd78-301237d5f821	522e3d5d-7819-40c3-a56f-0f9ad25f5c34	0	10	f	\N	\N
caa8c3a8-f2e6-434e-afaf-1b02984064dc	\N	reset-credential-email	d173fb4f-af6c-4c50-bd78-301237d5f821	522e3d5d-7819-40c3-a56f-0f9ad25f5c34	0	20	f	\N	\N
0996a89c-d88f-42d6-896c-e1a528958514	\N	reset-password	d173fb4f-af6c-4c50-bd78-301237d5f821	522e3d5d-7819-40c3-a56f-0f9ad25f5c34	0	30	f	\N	\N
a43b42f9-03b0-4b15-b898-7e6e7b019835	\N	\N	d173fb4f-af6c-4c50-bd78-301237d5f821	522e3d5d-7819-40c3-a56f-0f9ad25f5c34	1	40	t	dc94dc28-7023-4475-9010-e6ab7d10a7c0	\N
827d3f3a-24dc-4c9b-9a55-d3becf49e19a	\N	conditional-user-configured	d173fb4f-af6c-4c50-bd78-301237d5f821	dc94dc28-7023-4475-9010-e6ab7d10a7c0	0	10	f	\N	\N
be51d99c-3f58-4328-bd28-7299a8c4acd4	\N	reset-otp	d173fb4f-af6c-4c50-bd78-301237d5f821	dc94dc28-7023-4475-9010-e6ab7d10a7c0	0	20	f	\N	\N
947c2331-a51b-44e6-a20a-81f41f030e05	\N	client-secret	d173fb4f-af6c-4c50-bd78-301237d5f821	810465db-f104-4ce9-bbd1-a34860ff98ab	2	10	f	\N	\N
3d4afb97-e0ec-4818-b980-0b383f27043e	\N	client-jwt	d173fb4f-af6c-4c50-bd78-301237d5f821	810465db-f104-4ce9-bbd1-a34860ff98ab	2	20	f	\N	\N
7fd68338-b1b3-465c-9c38-5a55b76bfe9d	\N	client-secret-jwt	d173fb4f-af6c-4c50-bd78-301237d5f821	810465db-f104-4ce9-bbd1-a34860ff98ab	2	30	f	\N	\N
c6301994-e1da-4eac-b0c5-83d96a8428a1	\N	client-x509	d173fb4f-af6c-4c50-bd78-301237d5f821	810465db-f104-4ce9-bbd1-a34860ff98ab	2	40	f	\N	\N
4b46a4e9-9f4b-4082-869a-f98f1056796e	\N	idp-review-profile	d173fb4f-af6c-4c50-bd78-301237d5f821	261831b1-f7ea-43c1-8b3e-2e6b9140c82a	0	10	f	\N	3306fa23-acbd-4f5b-8202-0b8ad0cba19b
9331fe9d-1932-4fb8-bbab-f30e7bcf92c3	\N	\N	d173fb4f-af6c-4c50-bd78-301237d5f821	261831b1-f7ea-43c1-8b3e-2e6b9140c82a	0	20	t	daa050c2-4536-4b2c-8b91-32adaab0fa77	\N
4627423a-cd4f-4e76-a423-c0b0b7c8c43e	\N	idp-create-user-if-unique	d173fb4f-af6c-4c50-bd78-301237d5f821	daa050c2-4536-4b2c-8b91-32adaab0fa77	2	10	f	\N	00890eb4-2fd6-4de4-bf83-da5bb4390c58
5380ae25-87dc-4456-8f85-966d0cb9e4bf	\N	\N	d173fb4f-af6c-4c50-bd78-301237d5f821	daa050c2-4536-4b2c-8b91-32adaab0fa77	2	20	t	7921eac2-aa8f-4c64-b4d7-d4deae95888d	\N
f2ee2dc4-15af-4ea9-adc2-ff962eba3945	\N	idp-confirm-link	d173fb4f-af6c-4c50-bd78-301237d5f821	7921eac2-aa8f-4c64-b4d7-d4deae95888d	0	10	f	\N	\N
7d7f7aea-2f5a-4709-b5e7-e88ba5fe2396	\N	\N	d173fb4f-af6c-4c50-bd78-301237d5f821	7921eac2-aa8f-4c64-b4d7-d4deae95888d	0	20	t	3bd45c65-10c4-413f-ab30-08d43c39f911	\N
b469ee8d-d383-43aa-8ab2-30db58100ca8	\N	idp-email-verification	d173fb4f-af6c-4c50-bd78-301237d5f821	3bd45c65-10c4-413f-ab30-08d43c39f911	2	10	f	\N	\N
9c9b0b86-5893-44f9-88b9-aaaa1a87d77a	\N	\N	d173fb4f-af6c-4c50-bd78-301237d5f821	3bd45c65-10c4-413f-ab30-08d43c39f911	2	20	t	cdf6808d-7e01-4a3d-9400-eb0b08c07f47	\N
96bfb694-702f-48f4-968d-1645e4e16ccf	\N	idp-username-password-form	d173fb4f-af6c-4c50-bd78-301237d5f821	cdf6808d-7e01-4a3d-9400-eb0b08c07f47	0	10	f	\N	\N
27739def-ed10-4a85-aebc-76ae7772084f	\N	\N	d173fb4f-af6c-4c50-bd78-301237d5f821	cdf6808d-7e01-4a3d-9400-eb0b08c07f47	1	20	t	79c3e158-c6af-4810-9d53-e58ff53f0931	\N
6a11d01e-8a5f-470d-8b48-5f9fcbb9f59b	\N	conditional-user-configured	d173fb4f-af6c-4c50-bd78-301237d5f821	79c3e158-c6af-4810-9d53-e58ff53f0931	0	10	f	\N	\N
7d62bdb3-6b41-487f-b5f4-1ad7db85c7ef	\N	auth-otp-form	d173fb4f-af6c-4c50-bd78-301237d5f821	79c3e158-c6af-4810-9d53-e58ff53f0931	0	20	f	\N	\N
7289a13a-f51f-48bb-b259-e949f3936f08	\N	http-basic-authenticator	d173fb4f-af6c-4c50-bd78-301237d5f821	a83a48a0-214d-4064-8a96-1c5cc1083ba3	0	10	f	\N	\N
2ac1b785-eda7-4a60-bf8a-392c27c865be	\N	docker-http-basic-authenticator	d173fb4f-af6c-4c50-bd78-301237d5f821	32480b84-20de-484f-9eaf-f6f0caebcb27	0	10	f	\N	\N
4fe26365-440f-4466-8da5-ec89c2da60f4	\N	auth-cookie	59e3dfd1-7985-4568-9573-4084337fc1d1	dc169c3a-9ce8-493b-832e-7d4af992b664	2	10	f	\N	\N
a3a05d74-2109-496a-8186-9d14cd7cc625	\N	auth-spnego	59e3dfd1-7985-4568-9573-4084337fc1d1	dc169c3a-9ce8-493b-832e-7d4af992b664	3	20	f	\N	\N
784c9db9-9621-4925-a903-f832a37e3386	\N	identity-provider-redirector	59e3dfd1-7985-4568-9573-4084337fc1d1	dc169c3a-9ce8-493b-832e-7d4af992b664	2	25	f	\N	\N
a8521c96-e4fc-4422-a992-cf6a104ed8e4	\N	\N	59e3dfd1-7985-4568-9573-4084337fc1d1	dc169c3a-9ce8-493b-832e-7d4af992b664	2	30	t	f84d77d2-d4db-4d4c-b743-d2dbbb407818	\N
9bab23b8-a15c-46d2-b2a4-98285b21b85c	\N	auth-username-password-form	59e3dfd1-7985-4568-9573-4084337fc1d1	f84d77d2-d4db-4d4c-b743-d2dbbb407818	0	10	f	\N	\N
04a33d4b-dde2-4d21-a5c2-5700dbc02d85	\N	\N	59e3dfd1-7985-4568-9573-4084337fc1d1	f84d77d2-d4db-4d4c-b743-d2dbbb407818	1	20	t	7d80d7bc-4772-4785-982e-8c82ab0a60d8	\N
d0ebd8a6-0341-4347-864c-943f2b11fd2d	\N	conditional-user-configured	59e3dfd1-7985-4568-9573-4084337fc1d1	7d80d7bc-4772-4785-982e-8c82ab0a60d8	0	10	f	\N	\N
724bfd27-9451-4100-abf7-57ae397c19af	\N	auth-otp-form	59e3dfd1-7985-4568-9573-4084337fc1d1	7d80d7bc-4772-4785-982e-8c82ab0a60d8	0	20	f	\N	\N
59cd4f88-73aa-4a18-bddd-950ae068275b	\N	\N	59e3dfd1-7985-4568-9573-4084337fc1d1	dc169c3a-9ce8-493b-832e-7d4af992b664	2	26	t	ba62cceb-fa48-46fd-8b65-aa85ebc6c0fc	\N
5d014d04-28a9-495d-b64a-0fe4c20df0be	\N	\N	59e3dfd1-7985-4568-9573-4084337fc1d1	ba62cceb-fa48-46fd-8b65-aa85ebc6c0fc	1	10	t	deae08cd-7b4d-4379-9589-1ec581bc80ee	\N
b6f6c2d3-1d2f-4b50-aff5-eaeb03d11729	\N	conditional-user-configured	59e3dfd1-7985-4568-9573-4084337fc1d1	deae08cd-7b4d-4379-9589-1ec581bc80ee	0	10	f	\N	\N
5676befb-1e2e-4adf-8c76-41a761b57f31	\N	organization	59e3dfd1-7985-4568-9573-4084337fc1d1	deae08cd-7b4d-4379-9589-1ec581bc80ee	2	20	f	\N	\N
3e1eeb5c-a8fa-4ec9-b9e4-f1b8225601ce	\N	direct-grant-validate-username	59e3dfd1-7985-4568-9573-4084337fc1d1	a5e0b5ef-a769-4a6f-a19d-8a0d6506d2a6	0	10	f	\N	\N
59e120c5-5885-44a8-899c-744edcfe461e	\N	direct-grant-validate-password	59e3dfd1-7985-4568-9573-4084337fc1d1	a5e0b5ef-a769-4a6f-a19d-8a0d6506d2a6	0	20	f	\N	\N
aab906c7-9e09-4eb3-b72a-0dbf78659c44	\N	\N	59e3dfd1-7985-4568-9573-4084337fc1d1	a5e0b5ef-a769-4a6f-a19d-8a0d6506d2a6	1	30	t	cf38839d-daf8-4276-9a74-747b136d5f10	\N
c6fa4b72-4175-4a19-a9ac-d426455d90d0	\N	conditional-user-configured	59e3dfd1-7985-4568-9573-4084337fc1d1	cf38839d-daf8-4276-9a74-747b136d5f10	0	10	f	\N	\N
f201b250-a52a-485b-8e01-3ba4316f0e1f	\N	direct-grant-validate-otp	59e3dfd1-7985-4568-9573-4084337fc1d1	cf38839d-daf8-4276-9a74-747b136d5f10	0	20	f	\N	\N
d782dbb1-4054-4adf-8179-02a11741b3ea	\N	registration-page-form	59e3dfd1-7985-4568-9573-4084337fc1d1	5afd3e03-4fe6-4338-8a59-edce2c74e3f2	0	10	t	05f14480-0c95-467d-9b76-4a0b4ec415d6	\N
305a234e-1a78-4a9b-94e8-eb2b55855834	\N	registration-user-creation	59e3dfd1-7985-4568-9573-4084337fc1d1	05f14480-0c95-467d-9b76-4a0b4ec415d6	0	20	f	\N	\N
82f41975-052a-4fb6-baa2-cec1af281d0c	\N	registration-password-action	59e3dfd1-7985-4568-9573-4084337fc1d1	05f14480-0c95-467d-9b76-4a0b4ec415d6	0	50	f	\N	\N
dac7d728-ca4f-484a-a5da-791032028d23	\N	registration-recaptcha-action	59e3dfd1-7985-4568-9573-4084337fc1d1	05f14480-0c95-467d-9b76-4a0b4ec415d6	3	60	f	\N	\N
f2746d72-a912-4aca-8555-3f49c22b11cf	\N	registration-terms-and-conditions	59e3dfd1-7985-4568-9573-4084337fc1d1	05f14480-0c95-467d-9b76-4a0b4ec415d6	3	70	f	\N	\N
2a8d28ab-9b7e-48b1-8064-a0343aa86005	\N	reset-credentials-choose-user	59e3dfd1-7985-4568-9573-4084337fc1d1	4ca48059-e7ba-40ee-9ee3-40afe67a8c71	0	10	f	\N	\N
77779276-ed67-4ea8-a1b7-8eef61a1a0e5	\N	reset-credential-email	59e3dfd1-7985-4568-9573-4084337fc1d1	4ca48059-e7ba-40ee-9ee3-40afe67a8c71	0	20	f	\N	\N
d3ae00d0-6aff-4027-a377-bb9035b77b0f	\N	reset-password	59e3dfd1-7985-4568-9573-4084337fc1d1	4ca48059-e7ba-40ee-9ee3-40afe67a8c71	0	30	f	\N	\N
46ec57ac-c963-4002-8545-bffdd80a2394	\N	\N	59e3dfd1-7985-4568-9573-4084337fc1d1	4ca48059-e7ba-40ee-9ee3-40afe67a8c71	1	40	t	b4f5a03e-f964-4234-896d-49b21179735d	\N
bc82f338-7fbe-465a-9fab-00f51884c387	\N	conditional-user-configured	59e3dfd1-7985-4568-9573-4084337fc1d1	b4f5a03e-f964-4234-896d-49b21179735d	0	10	f	\N	\N
039c058c-4979-4e0a-ac5a-686cf0bc8dd1	\N	reset-otp	59e3dfd1-7985-4568-9573-4084337fc1d1	b4f5a03e-f964-4234-896d-49b21179735d	0	20	f	\N	\N
4fa92c51-2db7-452e-9659-2bc533fbfed6	\N	client-secret	59e3dfd1-7985-4568-9573-4084337fc1d1	18a96f4d-26ef-4776-86fd-00ab7628713a	2	10	f	\N	\N
ea6d6c84-af06-45a0-86e4-d91cc87edcdf	\N	client-jwt	59e3dfd1-7985-4568-9573-4084337fc1d1	18a96f4d-26ef-4776-86fd-00ab7628713a	2	20	f	\N	\N
a0d4d60a-ed4d-41ca-bdb6-8bf69a7a2291	\N	client-secret-jwt	59e3dfd1-7985-4568-9573-4084337fc1d1	18a96f4d-26ef-4776-86fd-00ab7628713a	2	30	f	\N	\N
552a2195-d38f-4587-8f95-af6c24e80681	\N	client-x509	59e3dfd1-7985-4568-9573-4084337fc1d1	18a96f4d-26ef-4776-86fd-00ab7628713a	2	40	f	\N	\N
7301a88f-f159-479c-861a-ab34c56291fa	\N	idp-review-profile	59e3dfd1-7985-4568-9573-4084337fc1d1	3125af29-b88e-43dc-8cde-33f0249fa274	0	10	f	\N	0cf0e0c9-7409-44dc-9993-2eee266e9bd2
6c155122-6c3a-45a1-a4ab-75eef933d012	\N	\N	59e3dfd1-7985-4568-9573-4084337fc1d1	3125af29-b88e-43dc-8cde-33f0249fa274	0	20	t	a1906d37-e523-4dee-8709-64580c9909f5	\N
0ae7718c-55ef-49fe-b6c2-2a661a7f065c	\N	idp-create-user-if-unique	59e3dfd1-7985-4568-9573-4084337fc1d1	a1906d37-e523-4dee-8709-64580c9909f5	2	10	f	\N	6ad2ef04-172d-44f7-ad5d-803bf3250d30
6207cefc-c3a3-446e-b646-4aed079f9962	\N	\N	59e3dfd1-7985-4568-9573-4084337fc1d1	a1906d37-e523-4dee-8709-64580c9909f5	2	20	t	3b80dbf5-6f5e-41cc-bcc4-eacd2a0b4d65	\N
4130fb28-585f-4296-85df-d070c8a26f56	\N	idp-confirm-link	59e3dfd1-7985-4568-9573-4084337fc1d1	3b80dbf5-6f5e-41cc-bcc4-eacd2a0b4d65	0	10	f	\N	\N
cebb4e55-5eba-4a0a-9fe7-b2f9e758c3bc	\N	\N	59e3dfd1-7985-4568-9573-4084337fc1d1	3b80dbf5-6f5e-41cc-bcc4-eacd2a0b4d65	0	20	t	e8f11583-5a26-4282-956e-20cb6d5411bb	\N
d8b06cfb-a2de-427c-ad2a-b59ed6e2213b	\N	idp-email-verification	59e3dfd1-7985-4568-9573-4084337fc1d1	e8f11583-5a26-4282-956e-20cb6d5411bb	2	10	f	\N	\N
01cdb356-1c6c-4162-8e97-4ddbdf40bbd6	\N	\N	59e3dfd1-7985-4568-9573-4084337fc1d1	e8f11583-5a26-4282-956e-20cb6d5411bb	2	20	t	9e943fce-60a0-4607-82c7-ff29ab1fb7a9	\N
e35df56c-9dc5-4b29-9408-b22e26e8dd0f	\N	idp-username-password-form	59e3dfd1-7985-4568-9573-4084337fc1d1	9e943fce-60a0-4607-82c7-ff29ab1fb7a9	0	10	f	\N	\N
a512f6cb-e7db-4342-be82-cbc3754415e2	\N	\N	59e3dfd1-7985-4568-9573-4084337fc1d1	9e943fce-60a0-4607-82c7-ff29ab1fb7a9	1	20	t	14312b85-5582-47c9-b36f-e4c2bdf44eaa	\N
d42de5a8-72eb-4ac1-a49d-fb49e30feff5	\N	conditional-user-configured	59e3dfd1-7985-4568-9573-4084337fc1d1	14312b85-5582-47c9-b36f-e4c2bdf44eaa	0	10	f	\N	\N
aff61982-ad32-44ad-83f0-576bbcd7471a	\N	auth-otp-form	59e3dfd1-7985-4568-9573-4084337fc1d1	14312b85-5582-47c9-b36f-e4c2bdf44eaa	0	20	f	\N	\N
a9f1bf61-56c7-4622-9752-c16e91c71d73	\N	\N	59e3dfd1-7985-4568-9573-4084337fc1d1	3125af29-b88e-43dc-8cde-33f0249fa274	1	50	t	03e1c212-b711-4b87-90e8-1f569d94dee3	\N
dad666ee-90bb-48a7-8afa-7f9efbbe5090	\N	conditional-user-configured	59e3dfd1-7985-4568-9573-4084337fc1d1	03e1c212-b711-4b87-90e8-1f569d94dee3	0	10	f	\N	\N
be0e89aa-cf81-400a-9d77-82d51b492dd8	\N	idp-add-organization-member	59e3dfd1-7985-4568-9573-4084337fc1d1	03e1c212-b711-4b87-90e8-1f569d94dee3	0	20	f	\N	\N
86ec1324-6cc0-4e00-bbc6-ab775b2da5b9	\N	http-basic-authenticator	59e3dfd1-7985-4568-9573-4084337fc1d1	baf13786-2e74-43b0-af2e-947e3aeeba61	0	10	f	\N	\N
a0af53fe-ced2-43ff-8c02-e172fce1d28b	\N	docker-http-basic-authenticator	59e3dfd1-7985-4568-9573-4084337fc1d1	a52a0a93-cbc9-4bc7-bff0-e80ba2ac25d6	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
a986bd6f-0d25-47b9-93bc-2f535c61c98e	browser	Browser based authentication	d173fb4f-af6c-4c50-bd78-301237d5f821	basic-flow	t	t
c2ecff36-f9e2-49ff-b396-a21b46090f38	forms	Username, password, otp and other auth forms.	d173fb4f-af6c-4c50-bd78-301237d5f821	basic-flow	f	t
c0147ca4-c885-497f-b98a-83fcb4ba47a3	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	d173fb4f-af6c-4c50-bd78-301237d5f821	basic-flow	f	t
3d45feb7-fbb0-415e-879b-95eb6ade8d37	direct grant	OpenID Connect Resource Owner Grant	d173fb4f-af6c-4c50-bd78-301237d5f821	basic-flow	t	t
b2097953-1250-4108-a6ca-e42aa2600a31	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	d173fb4f-af6c-4c50-bd78-301237d5f821	basic-flow	f	t
5dbfddb3-35f7-467d-99a5-f0853034d0e2	registration	Registration flow	d173fb4f-af6c-4c50-bd78-301237d5f821	basic-flow	t	t
6ae5928d-a870-4b23-8100-aade6b232cdc	registration form	Registration form	d173fb4f-af6c-4c50-bd78-301237d5f821	form-flow	f	t
522e3d5d-7819-40c3-a56f-0f9ad25f5c34	reset credentials	Reset credentials for a user if they forgot their password or something	d173fb4f-af6c-4c50-bd78-301237d5f821	basic-flow	t	t
dc94dc28-7023-4475-9010-e6ab7d10a7c0	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	d173fb4f-af6c-4c50-bd78-301237d5f821	basic-flow	f	t
810465db-f104-4ce9-bbd1-a34860ff98ab	clients	Base authentication for clients	d173fb4f-af6c-4c50-bd78-301237d5f821	client-flow	t	t
261831b1-f7ea-43c1-8b3e-2e6b9140c82a	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	d173fb4f-af6c-4c50-bd78-301237d5f821	basic-flow	t	t
daa050c2-4536-4b2c-8b91-32adaab0fa77	User creation or linking	Flow for the existing/non-existing user alternatives	d173fb4f-af6c-4c50-bd78-301237d5f821	basic-flow	f	t
7921eac2-aa8f-4c64-b4d7-d4deae95888d	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	d173fb4f-af6c-4c50-bd78-301237d5f821	basic-flow	f	t
3bd45c65-10c4-413f-ab30-08d43c39f911	Account verification options	Method with which to verity the existing account	d173fb4f-af6c-4c50-bd78-301237d5f821	basic-flow	f	t
cdf6808d-7e01-4a3d-9400-eb0b08c07f47	Verify Existing Account by Re-authentication	Reauthentication of existing account	d173fb4f-af6c-4c50-bd78-301237d5f821	basic-flow	f	t
79c3e158-c6af-4810-9d53-e58ff53f0931	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	d173fb4f-af6c-4c50-bd78-301237d5f821	basic-flow	f	t
a83a48a0-214d-4064-8a96-1c5cc1083ba3	saml ecp	SAML ECP Profile Authentication Flow	d173fb4f-af6c-4c50-bd78-301237d5f821	basic-flow	t	t
32480b84-20de-484f-9eaf-f6f0caebcb27	docker auth	Used by Docker clients to authenticate against the IDP	d173fb4f-af6c-4c50-bd78-301237d5f821	basic-flow	t	t
dc169c3a-9ce8-493b-832e-7d4af992b664	browser	Browser based authentication	59e3dfd1-7985-4568-9573-4084337fc1d1	basic-flow	t	t
f84d77d2-d4db-4d4c-b743-d2dbbb407818	forms	Username, password, otp and other auth forms.	59e3dfd1-7985-4568-9573-4084337fc1d1	basic-flow	f	t
7d80d7bc-4772-4785-982e-8c82ab0a60d8	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	59e3dfd1-7985-4568-9573-4084337fc1d1	basic-flow	f	t
ba62cceb-fa48-46fd-8b65-aa85ebc6c0fc	Organization	\N	59e3dfd1-7985-4568-9573-4084337fc1d1	basic-flow	f	t
deae08cd-7b4d-4379-9589-1ec581bc80ee	Browser - Conditional Organization	Flow to determine if the organization identity-first login is to be used	59e3dfd1-7985-4568-9573-4084337fc1d1	basic-flow	f	t
a5e0b5ef-a769-4a6f-a19d-8a0d6506d2a6	direct grant	OpenID Connect Resource Owner Grant	59e3dfd1-7985-4568-9573-4084337fc1d1	basic-flow	t	t
cf38839d-daf8-4276-9a74-747b136d5f10	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	59e3dfd1-7985-4568-9573-4084337fc1d1	basic-flow	f	t
5afd3e03-4fe6-4338-8a59-edce2c74e3f2	registration	Registration flow	59e3dfd1-7985-4568-9573-4084337fc1d1	basic-flow	t	t
05f14480-0c95-467d-9b76-4a0b4ec415d6	registration form	Registration form	59e3dfd1-7985-4568-9573-4084337fc1d1	form-flow	f	t
4ca48059-e7ba-40ee-9ee3-40afe67a8c71	reset credentials	Reset credentials for a user if they forgot their password or something	59e3dfd1-7985-4568-9573-4084337fc1d1	basic-flow	t	t
b4f5a03e-f964-4234-896d-49b21179735d	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	59e3dfd1-7985-4568-9573-4084337fc1d1	basic-flow	f	t
18a96f4d-26ef-4776-86fd-00ab7628713a	clients	Base authentication for clients	59e3dfd1-7985-4568-9573-4084337fc1d1	client-flow	t	t
3125af29-b88e-43dc-8cde-33f0249fa274	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	59e3dfd1-7985-4568-9573-4084337fc1d1	basic-flow	t	t
a1906d37-e523-4dee-8709-64580c9909f5	User creation or linking	Flow for the existing/non-existing user alternatives	59e3dfd1-7985-4568-9573-4084337fc1d1	basic-flow	f	t
3b80dbf5-6f5e-41cc-bcc4-eacd2a0b4d65	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	59e3dfd1-7985-4568-9573-4084337fc1d1	basic-flow	f	t
e8f11583-5a26-4282-956e-20cb6d5411bb	Account verification options	Method with which to verity the existing account	59e3dfd1-7985-4568-9573-4084337fc1d1	basic-flow	f	t
9e943fce-60a0-4607-82c7-ff29ab1fb7a9	Verify Existing Account by Re-authentication	Reauthentication of existing account	59e3dfd1-7985-4568-9573-4084337fc1d1	basic-flow	f	t
14312b85-5582-47c9-b36f-e4c2bdf44eaa	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	59e3dfd1-7985-4568-9573-4084337fc1d1	basic-flow	f	t
03e1c212-b711-4b87-90e8-1f569d94dee3	First Broker Login - Conditional Organization	Flow to determine if the authenticator that adds organization members is to be used	59e3dfd1-7985-4568-9573-4084337fc1d1	basic-flow	f	t
baf13786-2e74-43b0-af2e-947e3aeeba61	saml ecp	SAML ECP Profile Authentication Flow	59e3dfd1-7985-4568-9573-4084337fc1d1	basic-flow	t	t
a52a0a93-cbc9-4bc7-bff0-e80ba2ac25d6	docker auth	Used by Docker clients to authenticate against the IDP	59e3dfd1-7985-4568-9573-4084337fc1d1	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
3306fa23-acbd-4f5b-8202-0b8ad0cba19b	review profile config	d173fb4f-af6c-4c50-bd78-301237d5f821
00890eb4-2fd6-4de4-bf83-da5bb4390c58	create unique user config	d173fb4f-af6c-4c50-bd78-301237d5f821
0cf0e0c9-7409-44dc-9993-2eee266e9bd2	review profile config	59e3dfd1-7985-4568-9573-4084337fc1d1
6ad2ef04-172d-44f7-ad5d-803bf3250d30	create unique user config	59e3dfd1-7985-4568-9573-4084337fc1d1
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
00890eb4-2fd6-4de4-bf83-da5bb4390c58	false	require.password.update.after.registration
3306fa23-acbd-4f5b-8202-0b8ad0cba19b	missing	update.profile.on.first.login
0cf0e0c9-7409-44dc-9993-2eee266e9bd2	missing	update.profile.on.first.login
6ad2ef04-172d-44f7-ad5d-803bf3250d30	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	t	f	master-realm	0	f	\N	\N	t	\N	f	d173fb4f-af6c-4c50-bd78-301237d5f821	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
592457f4-a68f-45f3-afaf-0654dbe57d2e	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	d173fb4f-af6c-4c50-bd78-301237d5f821	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
01d6fa70-0341-4466-a5b9-3307c640576d	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	d173fb4f-af6c-4c50-bd78-301237d5f821	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
21a46612-c085-41c9-88ef-b65b41523fed	t	f	broker	0	f	\N	\N	t	\N	f	d173fb4f-af6c-4c50-bd78-301237d5f821	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
ad57c361-819a-46bd-8c9e-d7d6b90482bc	t	t	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	d173fb4f-af6c-4c50-bd78-301237d5f821	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
d3dbc5c2-c6a4-464c-a2ff-aba63e3b7389	t	t	admin-cli	0	t	\N	\N	f	\N	f	d173fb4f-af6c-4c50-bd78-301237d5f821	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
91186b3f-f806-4cb0-a766-a2d142007df0	t	f	mealwurm-realm	0	f	\N	\N	t	\N	f	d173fb4f-af6c-4c50-bd78-301237d5f821	\N	0	f	f	mealwurm Realm	f	client-secret	\N	\N	\N	t	f	f	f
73709d32-73c9-48b5-bdcd-c1838f679a64	t	f	realm-management	0	f	\N	\N	t	\N	f	59e3dfd1-7985-4568-9573-4084337fc1d1	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
f1cf0338-5613-46d5-ae30-182027f6c52a	t	f	account	0	t	\N	/realms/mealwurm/account/	f	\N	f	59e3dfd1-7985-4568-9573-4084337fc1d1	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
516bb66b-5bd7-4c4b-9d12-b8a88c7f010c	t	f	account-console	0	t	\N	/realms/mealwurm/account/	f	\N	f	59e3dfd1-7985-4568-9573-4084337fc1d1	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
de2c6113-b63a-442c-9f13-065c02d7f77c	t	f	broker	0	f	\N	\N	t	\N	f	59e3dfd1-7985-4568-9573-4084337fc1d1	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
33071a57-6cad-4a45-a1e9-17a7df75f18e	t	t	security-admin-console	0	t	\N	/admin/mealwurm/console/	f	\N	f	59e3dfd1-7985-4568-9573-4084337fc1d1	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
9467c2cd-7f31-4ab0-943a-7e5ae15b9aee	t	t	admin-cli	0	t	\N	\N	f	\N	f	59e3dfd1-7985-4568-9573-4084337fc1d1	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
e45acc0e-3df5-4b55-83ec-9beeaef25c04	t	t	mealwurm	0	t	\N	http://localhost:3000	f	http://localhost:3000	f	59e3dfd1-7985-4568-9573-4084337fc1d1	openid-connect	-1	t	f	mealwurm	f	client-secret	http://localhost:3000		\N	t	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
592457f4-a68f-45f3-afaf-0654dbe57d2e	post.logout.redirect.uris	+
01d6fa70-0341-4466-a5b9-3307c640576d	post.logout.redirect.uris	+
01d6fa70-0341-4466-a5b9-3307c640576d	pkce.code.challenge.method	S256
ad57c361-819a-46bd-8c9e-d7d6b90482bc	post.logout.redirect.uris	+
ad57c361-819a-46bd-8c9e-d7d6b90482bc	pkce.code.challenge.method	S256
ad57c361-819a-46bd-8c9e-d7d6b90482bc	client.use.lightweight.access.token.enabled	true
d3dbc5c2-c6a4-464c-a2ff-aba63e3b7389	client.use.lightweight.access.token.enabled	true
f1cf0338-5613-46d5-ae30-182027f6c52a	post.logout.redirect.uris	+
516bb66b-5bd7-4c4b-9d12-b8a88c7f010c	post.logout.redirect.uris	+
516bb66b-5bd7-4c4b-9d12-b8a88c7f010c	pkce.code.challenge.method	S256
33071a57-6cad-4a45-a1e9-17a7df75f18e	post.logout.redirect.uris	+
33071a57-6cad-4a45-a1e9-17a7df75f18e	pkce.code.challenge.method	S256
33071a57-6cad-4a45-a1e9-17a7df75f18e	client.use.lightweight.access.token.enabled	true
9467c2cd-7f31-4ab0-943a-7e5ae15b9aee	client.use.lightweight.access.token.enabled	true
e45acc0e-3df5-4b55-83ec-9beeaef25c04	oauth2.device.authorization.grant.enabled	false
e45acc0e-3df5-4b55-83ec-9beeaef25c04	oidc.ciba.grant.enabled	false
e45acc0e-3df5-4b55-83ec-9beeaef25c04	post.logout.redirect.uris	http://localhost:3000/*
e45acc0e-3df5-4b55-83ec-9beeaef25c04	backchannel.logout.session.required	true
e45acc0e-3df5-4b55-83ec-9beeaef25c04	backchannel.logout.revoke.offline.tokens	false
e45acc0e-3df5-4b55-83ec-9beeaef25c04	realm_client	false
e45acc0e-3df5-4b55-83ec-9beeaef25c04	display.on.consent.screen	false
e45acc0e-3df5-4b55-83ec-9beeaef25c04	frontchannel.logout.session.required	true
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
d1f2fa14-2f81-4487-946e-076068441946	offline_access	d173fb4f-af6c-4c50-bd78-301237d5f821	OpenID Connect built-in scope: offline_access	openid-connect
3c2a4942-8476-4044-9eb4-d0f62f515aab	role_list	d173fb4f-af6c-4c50-bd78-301237d5f821	SAML role list	saml
95b2d39b-5aa5-4ace-9418-cc7af550a3c6	saml_organization	d173fb4f-af6c-4c50-bd78-301237d5f821	Organization Membership	saml
d899830f-5e51-48b2-ba3d-ad58e4f8c69d	profile	d173fb4f-af6c-4c50-bd78-301237d5f821	OpenID Connect built-in scope: profile	openid-connect
7547d42e-d172-4463-bae8-71b882e3b1ca	email	d173fb4f-af6c-4c50-bd78-301237d5f821	OpenID Connect built-in scope: email	openid-connect
ad1b25c8-bff8-41fe-aba4-286af672c64f	address	d173fb4f-af6c-4c50-bd78-301237d5f821	OpenID Connect built-in scope: address	openid-connect
e1423732-12cd-4b83-b339-f1e38f03df5d	phone	d173fb4f-af6c-4c50-bd78-301237d5f821	OpenID Connect built-in scope: phone	openid-connect
2a638ed3-b5bb-409c-a112-e13bff69c33f	roles	d173fb4f-af6c-4c50-bd78-301237d5f821	OpenID Connect scope for add user roles to the access token	openid-connect
08cc2e81-7d54-45e8-be80-ed80013fb686	web-origins	d173fb4f-af6c-4c50-bd78-301237d5f821	OpenID Connect scope for add allowed web origins to the access token	openid-connect
cf78551b-6051-4128-a3da-940eccbe08c6	microprofile-jwt	d173fb4f-af6c-4c50-bd78-301237d5f821	Microprofile - JWT built-in scope	openid-connect
08c0e400-285f-495b-9895-b8dcc97aa7c8	acr	d173fb4f-af6c-4c50-bd78-301237d5f821	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
faf64e1f-0738-4686-ab97-1be9898c177b	basic	d173fb4f-af6c-4c50-bd78-301237d5f821	OpenID Connect scope for add all basic claims to the token	openid-connect
02a4c2b3-9e2c-4c29-bf25-c84ed7ed3175	service_account	d173fb4f-af6c-4c50-bd78-301237d5f821	Specific scope for a client enabled for service accounts	openid-connect
fd4cee54-2846-4e8f-9607-0abb410d4cb8	organization	d173fb4f-af6c-4c50-bd78-301237d5f821	Additional claims about the organization a subject belongs to	openid-connect
3f9f4854-6bb1-43f3-aac6-9c0685ff042c	offline_access	59e3dfd1-7985-4568-9573-4084337fc1d1	OpenID Connect built-in scope: offline_access	openid-connect
274fbafb-7e29-4834-a9b5-3469cfde7ad5	role_list	59e3dfd1-7985-4568-9573-4084337fc1d1	SAML role list	saml
b793744b-f5ff-477d-976f-61d8ba2ebb5d	saml_organization	59e3dfd1-7985-4568-9573-4084337fc1d1	Organization Membership	saml
5e2b6eda-8009-4a08-9e99-92bf4cf5980c	profile	59e3dfd1-7985-4568-9573-4084337fc1d1	OpenID Connect built-in scope: profile	openid-connect
3f13e525-d348-4787-80af-9256386f4670	email	59e3dfd1-7985-4568-9573-4084337fc1d1	OpenID Connect built-in scope: email	openid-connect
d2ee2a14-7e55-4c28-9dad-21065c9d27be	address	59e3dfd1-7985-4568-9573-4084337fc1d1	OpenID Connect built-in scope: address	openid-connect
02c90be0-1dd3-42b7-8c14-24d8b196bd9e	phone	59e3dfd1-7985-4568-9573-4084337fc1d1	OpenID Connect built-in scope: phone	openid-connect
7cb3f141-f297-4261-b891-68c93b24a563	roles	59e3dfd1-7985-4568-9573-4084337fc1d1	OpenID Connect scope for add user roles to the access token	openid-connect
2dba8ad0-29cb-4e27-ae6b-e67854ac19c6	web-origins	59e3dfd1-7985-4568-9573-4084337fc1d1	OpenID Connect scope for add allowed web origins to the access token	openid-connect
0689b937-49e7-460f-b544-0be503611a49	microprofile-jwt	59e3dfd1-7985-4568-9573-4084337fc1d1	Microprofile - JWT built-in scope	openid-connect
cc7d193a-1e69-4ca2-9266-79ab8a8b2124	acr	59e3dfd1-7985-4568-9573-4084337fc1d1	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
13f07e3d-3bab-4476-96ec-b4333ded9400	basic	59e3dfd1-7985-4568-9573-4084337fc1d1	OpenID Connect scope for add all basic claims to the token	openid-connect
7697941d-d55a-4449-a14f-927e18a96712	service_account	59e3dfd1-7985-4568-9573-4084337fc1d1	Specific scope for a client enabled for service accounts	openid-connect
914ed35b-5b06-45c0-a147-5b1421d67457	organization	59e3dfd1-7985-4568-9573-4084337fc1d1	Additional claims about the organization a subject belongs to	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
d1f2fa14-2f81-4487-946e-076068441946	true	display.on.consent.screen
d1f2fa14-2f81-4487-946e-076068441946	${offlineAccessScopeConsentText}	consent.screen.text
3c2a4942-8476-4044-9eb4-d0f62f515aab	true	display.on.consent.screen
3c2a4942-8476-4044-9eb4-d0f62f515aab	${samlRoleListScopeConsentText}	consent.screen.text
95b2d39b-5aa5-4ace-9418-cc7af550a3c6	false	display.on.consent.screen
d899830f-5e51-48b2-ba3d-ad58e4f8c69d	true	display.on.consent.screen
d899830f-5e51-48b2-ba3d-ad58e4f8c69d	${profileScopeConsentText}	consent.screen.text
d899830f-5e51-48b2-ba3d-ad58e4f8c69d	true	include.in.token.scope
7547d42e-d172-4463-bae8-71b882e3b1ca	true	display.on.consent.screen
7547d42e-d172-4463-bae8-71b882e3b1ca	${emailScopeConsentText}	consent.screen.text
7547d42e-d172-4463-bae8-71b882e3b1ca	true	include.in.token.scope
ad1b25c8-bff8-41fe-aba4-286af672c64f	true	display.on.consent.screen
ad1b25c8-bff8-41fe-aba4-286af672c64f	${addressScopeConsentText}	consent.screen.text
ad1b25c8-bff8-41fe-aba4-286af672c64f	true	include.in.token.scope
e1423732-12cd-4b83-b339-f1e38f03df5d	true	display.on.consent.screen
e1423732-12cd-4b83-b339-f1e38f03df5d	${phoneScopeConsentText}	consent.screen.text
e1423732-12cd-4b83-b339-f1e38f03df5d	true	include.in.token.scope
2a638ed3-b5bb-409c-a112-e13bff69c33f	true	display.on.consent.screen
2a638ed3-b5bb-409c-a112-e13bff69c33f	${rolesScopeConsentText}	consent.screen.text
2a638ed3-b5bb-409c-a112-e13bff69c33f	false	include.in.token.scope
08cc2e81-7d54-45e8-be80-ed80013fb686	false	display.on.consent.screen
08cc2e81-7d54-45e8-be80-ed80013fb686		consent.screen.text
08cc2e81-7d54-45e8-be80-ed80013fb686	false	include.in.token.scope
cf78551b-6051-4128-a3da-940eccbe08c6	false	display.on.consent.screen
cf78551b-6051-4128-a3da-940eccbe08c6	true	include.in.token.scope
08c0e400-285f-495b-9895-b8dcc97aa7c8	false	display.on.consent.screen
08c0e400-285f-495b-9895-b8dcc97aa7c8	false	include.in.token.scope
faf64e1f-0738-4686-ab97-1be9898c177b	false	display.on.consent.screen
faf64e1f-0738-4686-ab97-1be9898c177b	false	include.in.token.scope
02a4c2b3-9e2c-4c29-bf25-c84ed7ed3175	false	display.on.consent.screen
02a4c2b3-9e2c-4c29-bf25-c84ed7ed3175	false	include.in.token.scope
fd4cee54-2846-4e8f-9607-0abb410d4cb8	true	display.on.consent.screen
fd4cee54-2846-4e8f-9607-0abb410d4cb8	${organizationScopeConsentText}	consent.screen.text
fd4cee54-2846-4e8f-9607-0abb410d4cb8	true	include.in.token.scope
3f9f4854-6bb1-43f3-aac6-9c0685ff042c	true	display.on.consent.screen
3f9f4854-6bb1-43f3-aac6-9c0685ff042c	${offlineAccessScopeConsentText}	consent.screen.text
274fbafb-7e29-4834-a9b5-3469cfde7ad5	true	display.on.consent.screen
274fbafb-7e29-4834-a9b5-3469cfde7ad5	${samlRoleListScopeConsentText}	consent.screen.text
b793744b-f5ff-477d-976f-61d8ba2ebb5d	false	display.on.consent.screen
5e2b6eda-8009-4a08-9e99-92bf4cf5980c	true	display.on.consent.screen
5e2b6eda-8009-4a08-9e99-92bf4cf5980c	${profileScopeConsentText}	consent.screen.text
5e2b6eda-8009-4a08-9e99-92bf4cf5980c	true	include.in.token.scope
3f13e525-d348-4787-80af-9256386f4670	true	display.on.consent.screen
3f13e525-d348-4787-80af-9256386f4670	${emailScopeConsentText}	consent.screen.text
3f13e525-d348-4787-80af-9256386f4670	true	include.in.token.scope
d2ee2a14-7e55-4c28-9dad-21065c9d27be	true	display.on.consent.screen
d2ee2a14-7e55-4c28-9dad-21065c9d27be	${addressScopeConsentText}	consent.screen.text
d2ee2a14-7e55-4c28-9dad-21065c9d27be	true	include.in.token.scope
02c90be0-1dd3-42b7-8c14-24d8b196bd9e	true	display.on.consent.screen
02c90be0-1dd3-42b7-8c14-24d8b196bd9e	${phoneScopeConsentText}	consent.screen.text
02c90be0-1dd3-42b7-8c14-24d8b196bd9e	true	include.in.token.scope
7cb3f141-f297-4261-b891-68c93b24a563	true	display.on.consent.screen
7cb3f141-f297-4261-b891-68c93b24a563	${rolesScopeConsentText}	consent.screen.text
7cb3f141-f297-4261-b891-68c93b24a563	false	include.in.token.scope
2dba8ad0-29cb-4e27-ae6b-e67854ac19c6	false	display.on.consent.screen
2dba8ad0-29cb-4e27-ae6b-e67854ac19c6		consent.screen.text
2dba8ad0-29cb-4e27-ae6b-e67854ac19c6	false	include.in.token.scope
0689b937-49e7-460f-b544-0be503611a49	false	display.on.consent.screen
0689b937-49e7-460f-b544-0be503611a49	true	include.in.token.scope
cc7d193a-1e69-4ca2-9266-79ab8a8b2124	false	display.on.consent.screen
cc7d193a-1e69-4ca2-9266-79ab8a8b2124	false	include.in.token.scope
13f07e3d-3bab-4476-96ec-b4333ded9400	false	display.on.consent.screen
13f07e3d-3bab-4476-96ec-b4333ded9400	false	include.in.token.scope
7697941d-d55a-4449-a14f-927e18a96712	false	display.on.consent.screen
7697941d-d55a-4449-a14f-927e18a96712	false	include.in.token.scope
914ed35b-5b06-45c0-a147-5b1421d67457	true	display.on.consent.screen
914ed35b-5b06-45c0-a147-5b1421d67457	${organizationScopeConsentText}	consent.screen.text
914ed35b-5b06-45c0-a147-5b1421d67457	true	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
592457f4-a68f-45f3-afaf-0654dbe57d2e	7547d42e-d172-4463-bae8-71b882e3b1ca	t
592457f4-a68f-45f3-afaf-0654dbe57d2e	faf64e1f-0738-4686-ab97-1be9898c177b	t
592457f4-a68f-45f3-afaf-0654dbe57d2e	08cc2e81-7d54-45e8-be80-ed80013fb686	t
592457f4-a68f-45f3-afaf-0654dbe57d2e	2a638ed3-b5bb-409c-a112-e13bff69c33f	t
592457f4-a68f-45f3-afaf-0654dbe57d2e	d899830f-5e51-48b2-ba3d-ad58e4f8c69d	t
592457f4-a68f-45f3-afaf-0654dbe57d2e	08c0e400-285f-495b-9895-b8dcc97aa7c8	t
592457f4-a68f-45f3-afaf-0654dbe57d2e	fd4cee54-2846-4e8f-9607-0abb410d4cb8	f
592457f4-a68f-45f3-afaf-0654dbe57d2e	d1f2fa14-2f81-4487-946e-076068441946	f
592457f4-a68f-45f3-afaf-0654dbe57d2e	e1423732-12cd-4b83-b339-f1e38f03df5d	f
592457f4-a68f-45f3-afaf-0654dbe57d2e	cf78551b-6051-4128-a3da-940eccbe08c6	f
592457f4-a68f-45f3-afaf-0654dbe57d2e	ad1b25c8-bff8-41fe-aba4-286af672c64f	f
01d6fa70-0341-4466-a5b9-3307c640576d	7547d42e-d172-4463-bae8-71b882e3b1ca	t
01d6fa70-0341-4466-a5b9-3307c640576d	faf64e1f-0738-4686-ab97-1be9898c177b	t
01d6fa70-0341-4466-a5b9-3307c640576d	08cc2e81-7d54-45e8-be80-ed80013fb686	t
01d6fa70-0341-4466-a5b9-3307c640576d	2a638ed3-b5bb-409c-a112-e13bff69c33f	t
01d6fa70-0341-4466-a5b9-3307c640576d	d899830f-5e51-48b2-ba3d-ad58e4f8c69d	t
01d6fa70-0341-4466-a5b9-3307c640576d	08c0e400-285f-495b-9895-b8dcc97aa7c8	t
01d6fa70-0341-4466-a5b9-3307c640576d	fd4cee54-2846-4e8f-9607-0abb410d4cb8	f
01d6fa70-0341-4466-a5b9-3307c640576d	d1f2fa14-2f81-4487-946e-076068441946	f
01d6fa70-0341-4466-a5b9-3307c640576d	e1423732-12cd-4b83-b339-f1e38f03df5d	f
01d6fa70-0341-4466-a5b9-3307c640576d	cf78551b-6051-4128-a3da-940eccbe08c6	f
01d6fa70-0341-4466-a5b9-3307c640576d	ad1b25c8-bff8-41fe-aba4-286af672c64f	f
d3dbc5c2-c6a4-464c-a2ff-aba63e3b7389	7547d42e-d172-4463-bae8-71b882e3b1ca	t
d3dbc5c2-c6a4-464c-a2ff-aba63e3b7389	faf64e1f-0738-4686-ab97-1be9898c177b	t
d3dbc5c2-c6a4-464c-a2ff-aba63e3b7389	08cc2e81-7d54-45e8-be80-ed80013fb686	t
d3dbc5c2-c6a4-464c-a2ff-aba63e3b7389	2a638ed3-b5bb-409c-a112-e13bff69c33f	t
d3dbc5c2-c6a4-464c-a2ff-aba63e3b7389	d899830f-5e51-48b2-ba3d-ad58e4f8c69d	t
d3dbc5c2-c6a4-464c-a2ff-aba63e3b7389	08c0e400-285f-495b-9895-b8dcc97aa7c8	t
d3dbc5c2-c6a4-464c-a2ff-aba63e3b7389	fd4cee54-2846-4e8f-9607-0abb410d4cb8	f
d3dbc5c2-c6a4-464c-a2ff-aba63e3b7389	d1f2fa14-2f81-4487-946e-076068441946	f
d3dbc5c2-c6a4-464c-a2ff-aba63e3b7389	e1423732-12cd-4b83-b339-f1e38f03df5d	f
d3dbc5c2-c6a4-464c-a2ff-aba63e3b7389	cf78551b-6051-4128-a3da-940eccbe08c6	f
d3dbc5c2-c6a4-464c-a2ff-aba63e3b7389	ad1b25c8-bff8-41fe-aba4-286af672c64f	f
21a46612-c085-41c9-88ef-b65b41523fed	7547d42e-d172-4463-bae8-71b882e3b1ca	t
21a46612-c085-41c9-88ef-b65b41523fed	faf64e1f-0738-4686-ab97-1be9898c177b	t
21a46612-c085-41c9-88ef-b65b41523fed	08cc2e81-7d54-45e8-be80-ed80013fb686	t
21a46612-c085-41c9-88ef-b65b41523fed	2a638ed3-b5bb-409c-a112-e13bff69c33f	t
21a46612-c085-41c9-88ef-b65b41523fed	d899830f-5e51-48b2-ba3d-ad58e4f8c69d	t
21a46612-c085-41c9-88ef-b65b41523fed	08c0e400-285f-495b-9895-b8dcc97aa7c8	t
21a46612-c085-41c9-88ef-b65b41523fed	fd4cee54-2846-4e8f-9607-0abb410d4cb8	f
21a46612-c085-41c9-88ef-b65b41523fed	d1f2fa14-2f81-4487-946e-076068441946	f
21a46612-c085-41c9-88ef-b65b41523fed	e1423732-12cd-4b83-b339-f1e38f03df5d	f
21a46612-c085-41c9-88ef-b65b41523fed	cf78551b-6051-4128-a3da-940eccbe08c6	f
21a46612-c085-41c9-88ef-b65b41523fed	ad1b25c8-bff8-41fe-aba4-286af672c64f	f
2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	7547d42e-d172-4463-bae8-71b882e3b1ca	t
2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	faf64e1f-0738-4686-ab97-1be9898c177b	t
2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	08cc2e81-7d54-45e8-be80-ed80013fb686	t
2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	2a638ed3-b5bb-409c-a112-e13bff69c33f	t
2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	d899830f-5e51-48b2-ba3d-ad58e4f8c69d	t
2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	08c0e400-285f-495b-9895-b8dcc97aa7c8	t
2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	fd4cee54-2846-4e8f-9607-0abb410d4cb8	f
2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	d1f2fa14-2f81-4487-946e-076068441946	f
2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	e1423732-12cd-4b83-b339-f1e38f03df5d	f
2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	cf78551b-6051-4128-a3da-940eccbe08c6	f
2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	ad1b25c8-bff8-41fe-aba4-286af672c64f	f
ad57c361-819a-46bd-8c9e-d7d6b90482bc	7547d42e-d172-4463-bae8-71b882e3b1ca	t
ad57c361-819a-46bd-8c9e-d7d6b90482bc	faf64e1f-0738-4686-ab97-1be9898c177b	t
ad57c361-819a-46bd-8c9e-d7d6b90482bc	08cc2e81-7d54-45e8-be80-ed80013fb686	t
ad57c361-819a-46bd-8c9e-d7d6b90482bc	2a638ed3-b5bb-409c-a112-e13bff69c33f	t
ad57c361-819a-46bd-8c9e-d7d6b90482bc	d899830f-5e51-48b2-ba3d-ad58e4f8c69d	t
ad57c361-819a-46bd-8c9e-d7d6b90482bc	08c0e400-285f-495b-9895-b8dcc97aa7c8	t
ad57c361-819a-46bd-8c9e-d7d6b90482bc	fd4cee54-2846-4e8f-9607-0abb410d4cb8	f
ad57c361-819a-46bd-8c9e-d7d6b90482bc	d1f2fa14-2f81-4487-946e-076068441946	f
ad57c361-819a-46bd-8c9e-d7d6b90482bc	e1423732-12cd-4b83-b339-f1e38f03df5d	f
ad57c361-819a-46bd-8c9e-d7d6b90482bc	cf78551b-6051-4128-a3da-940eccbe08c6	f
ad57c361-819a-46bd-8c9e-d7d6b90482bc	ad1b25c8-bff8-41fe-aba4-286af672c64f	f
f1cf0338-5613-46d5-ae30-182027f6c52a	13f07e3d-3bab-4476-96ec-b4333ded9400	t
f1cf0338-5613-46d5-ae30-182027f6c52a	5e2b6eda-8009-4a08-9e99-92bf4cf5980c	t
f1cf0338-5613-46d5-ae30-182027f6c52a	2dba8ad0-29cb-4e27-ae6b-e67854ac19c6	t
f1cf0338-5613-46d5-ae30-182027f6c52a	cc7d193a-1e69-4ca2-9266-79ab8a8b2124	t
f1cf0338-5613-46d5-ae30-182027f6c52a	3f13e525-d348-4787-80af-9256386f4670	t
f1cf0338-5613-46d5-ae30-182027f6c52a	7cb3f141-f297-4261-b891-68c93b24a563	t
f1cf0338-5613-46d5-ae30-182027f6c52a	0689b937-49e7-460f-b544-0be503611a49	f
f1cf0338-5613-46d5-ae30-182027f6c52a	914ed35b-5b06-45c0-a147-5b1421d67457	f
f1cf0338-5613-46d5-ae30-182027f6c52a	d2ee2a14-7e55-4c28-9dad-21065c9d27be	f
f1cf0338-5613-46d5-ae30-182027f6c52a	02c90be0-1dd3-42b7-8c14-24d8b196bd9e	f
f1cf0338-5613-46d5-ae30-182027f6c52a	3f9f4854-6bb1-43f3-aac6-9c0685ff042c	f
516bb66b-5bd7-4c4b-9d12-b8a88c7f010c	13f07e3d-3bab-4476-96ec-b4333ded9400	t
516bb66b-5bd7-4c4b-9d12-b8a88c7f010c	5e2b6eda-8009-4a08-9e99-92bf4cf5980c	t
516bb66b-5bd7-4c4b-9d12-b8a88c7f010c	2dba8ad0-29cb-4e27-ae6b-e67854ac19c6	t
516bb66b-5bd7-4c4b-9d12-b8a88c7f010c	cc7d193a-1e69-4ca2-9266-79ab8a8b2124	t
516bb66b-5bd7-4c4b-9d12-b8a88c7f010c	3f13e525-d348-4787-80af-9256386f4670	t
516bb66b-5bd7-4c4b-9d12-b8a88c7f010c	7cb3f141-f297-4261-b891-68c93b24a563	t
516bb66b-5bd7-4c4b-9d12-b8a88c7f010c	0689b937-49e7-460f-b544-0be503611a49	f
516bb66b-5bd7-4c4b-9d12-b8a88c7f010c	914ed35b-5b06-45c0-a147-5b1421d67457	f
516bb66b-5bd7-4c4b-9d12-b8a88c7f010c	d2ee2a14-7e55-4c28-9dad-21065c9d27be	f
516bb66b-5bd7-4c4b-9d12-b8a88c7f010c	02c90be0-1dd3-42b7-8c14-24d8b196bd9e	f
516bb66b-5bd7-4c4b-9d12-b8a88c7f010c	3f9f4854-6bb1-43f3-aac6-9c0685ff042c	f
9467c2cd-7f31-4ab0-943a-7e5ae15b9aee	13f07e3d-3bab-4476-96ec-b4333ded9400	t
9467c2cd-7f31-4ab0-943a-7e5ae15b9aee	5e2b6eda-8009-4a08-9e99-92bf4cf5980c	t
9467c2cd-7f31-4ab0-943a-7e5ae15b9aee	2dba8ad0-29cb-4e27-ae6b-e67854ac19c6	t
9467c2cd-7f31-4ab0-943a-7e5ae15b9aee	cc7d193a-1e69-4ca2-9266-79ab8a8b2124	t
9467c2cd-7f31-4ab0-943a-7e5ae15b9aee	3f13e525-d348-4787-80af-9256386f4670	t
9467c2cd-7f31-4ab0-943a-7e5ae15b9aee	7cb3f141-f297-4261-b891-68c93b24a563	t
9467c2cd-7f31-4ab0-943a-7e5ae15b9aee	0689b937-49e7-460f-b544-0be503611a49	f
9467c2cd-7f31-4ab0-943a-7e5ae15b9aee	914ed35b-5b06-45c0-a147-5b1421d67457	f
9467c2cd-7f31-4ab0-943a-7e5ae15b9aee	d2ee2a14-7e55-4c28-9dad-21065c9d27be	f
9467c2cd-7f31-4ab0-943a-7e5ae15b9aee	02c90be0-1dd3-42b7-8c14-24d8b196bd9e	f
9467c2cd-7f31-4ab0-943a-7e5ae15b9aee	3f9f4854-6bb1-43f3-aac6-9c0685ff042c	f
de2c6113-b63a-442c-9f13-065c02d7f77c	13f07e3d-3bab-4476-96ec-b4333ded9400	t
de2c6113-b63a-442c-9f13-065c02d7f77c	5e2b6eda-8009-4a08-9e99-92bf4cf5980c	t
de2c6113-b63a-442c-9f13-065c02d7f77c	2dba8ad0-29cb-4e27-ae6b-e67854ac19c6	t
de2c6113-b63a-442c-9f13-065c02d7f77c	cc7d193a-1e69-4ca2-9266-79ab8a8b2124	t
de2c6113-b63a-442c-9f13-065c02d7f77c	3f13e525-d348-4787-80af-9256386f4670	t
de2c6113-b63a-442c-9f13-065c02d7f77c	7cb3f141-f297-4261-b891-68c93b24a563	t
de2c6113-b63a-442c-9f13-065c02d7f77c	0689b937-49e7-460f-b544-0be503611a49	f
de2c6113-b63a-442c-9f13-065c02d7f77c	914ed35b-5b06-45c0-a147-5b1421d67457	f
de2c6113-b63a-442c-9f13-065c02d7f77c	d2ee2a14-7e55-4c28-9dad-21065c9d27be	f
de2c6113-b63a-442c-9f13-065c02d7f77c	02c90be0-1dd3-42b7-8c14-24d8b196bd9e	f
de2c6113-b63a-442c-9f13-065c02d7f77c	3f9f4854-6bb1-43f3-aac6-9c0685ff042c	f
73709d32-73c9-48b5-bdcd-c1838f679a64	13f07e3d-3bab-4476-96ec-b4333ded9400	t
73709d32-73c9-48b5-bdcd-c1838f679a64	5e2b6eda-8009-4a08-9e99-92bf4cf5980c	t
73709d32-73c9-48b5-bdcd-c1838f679a64	2dba8ad0-29cb-4e27-ae6b-e67854ac19c6	t
73709d32-73c9-48b5-bdcd-c1838f679a64	cc7d193a-1e69-4ca2-9266-79ab8a8b2124	t
73709d32-73c9-48b5-bdcd-c1838f679a64	3f13e525-d348-4787-80af-9256386f4670	t
73709d32-73c9-48b5-bdcd-c1838f679a64	7cb3f141-f297-4261-b891-68c93b24a563	t
73709d32-73c9-48b5-bdcd-c1838f679a64	0689b937-49e7-460f-b544-0be503611a49	f
73709d32-73c9-48b5-bdcd-c1838f679a64	914ed35b-5b06-45c0-a147-5b1421d67457	f
73709d32-73c9-48b5-bdcd-c1838f679a64	d2ee2a14-7e55-4c28-9dad-21065c9d27be	f
73709d32-73c9-48b5-bdcd-c1838f679a64	02c90be0-1dd3-42b7-8c14-24d8b196bd9e	f
73709d32-73c9-48b5-bdcd-c1838f679a64	3f9f4854-6bb1-43f3-aac6-9c0685ff042c	f
33071a57-6cad-4a45-a1e9-17a7df75f18e	13f07e3d-3bab-4476-96ec-b4333ded9400	t
33071a57-6cad-4a45-a1e9-17a7df75f18e	5e2b6eda-8009-4a08-9e99-92bf4cf5980c	t
33071a57-6cad-4a45-a1e9-17a7df75f18e	2dba8ad0-29cb-4e27-ae6b-e67854ac19c6	t
33071a57-6cad-4a45-a1e9-17a7df75f18e	cc7d193a-1e69-4ca2-9266-79ab8a8b2124	t
33071a57-6cad-4a45-a1e9-17a7df75f18e	3f13e525-d348-4787-80af-9256386f4670	t
33071a57-6cad-4a45-a1e9-17a7df75f18e	7cb3f141-f297-4261-b891-68c93b24a563	t
33071a57-6cad-4a45-a1e9-17a7df75f18e	0689b937-49e7-460f-b544-0be503611a49	f
33071a57-6cad-4a45-a1e9-17a7df75f18e	914ed35b-5b06-45c0-a147-5b1421d67457	f
33071a57-6cad-4a45-a1e9-17a7df75f18e	d2ee2a14-7e55-4c28-9dad-21065c9d27be	f
33071a57-6cad-4a45-a1e9-17a7df75f18e	02c90be0-1dd3-42b7-8c14-24d8b196bd9e	f
33071a57-6cad-4a45-a1e9-17a7df75f18e	3f9f4854-6bb1-43f3-aac6-9c0685ff042c	f
e45acc0e-3df5-4b55-83ec-9beeaef25c04	13f07e3d-3bab-4476-96ec-b4333ded9400	t
e45acc0e-3df5-4b55-83ec-9beeaef25c04	5e2b6eda-8009-4a08-9e99-92bf4cf5980c	t
e45acc0e-3df5-4b55-83ec-9beeaef25c04	2dba8ad0-29cb-4e27-ae6b-e67854ac19c6	t
e45acc0e-3df5-4b55-83ec-9beeaef25c04	cc7d193a-1e69-4ca2-9266-79ab8a8b2124	t
e45acc0e-3df5-4b55-83ec-9beeaef25c04	3f13e525-d348-4787-80af-9256386f4670	t
e45acc0e-3df5-4b55-83ec-9beeaef25c04	7cb3f141-f297-4261-b891-68c93b24a563	t
e45acc0e-3df5-4b55-83ec-9beeaef25c04	0689b937-49e7-460f-b544-0be503611a49	f
e45acc0e-3df5-4b55-83ec-9beeaef25c04	914ed35b-5b06-45c0-a147-5b1421d67457	f
e45acc0e-3df5-4b55-83ec-9beeaef25c04	d2ee2a14-7e55-4c28-9dad-21065c9d27be	f
e45acc0e-3df5-4b55-83ec-9beeaef25c04	02c90be0-1dd3-42b7-8c14-24d8b196bd9e	f
e45acc0e-3df5-4b55-83ec-9beeaef25c04	3f9f4854-6bb1-43f3-aac6-9c0685ff042c	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
d1f2fa14-2f81-4487-946e-076068441946	c6fbf5e4-ff9f-4f5c-bb7f-9f8bb5a087a0
3f9f4854-6bb1-43f3-aac6-9c0685ff042c	dfd13434-2081-49e8-a774-c5ee71b96ec5
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
ec5bc306-360a-4da3-9606-191cc76f7db4	Trusted Hosts	d173fb4f-af6c-4c50-bd78-301237d5f821	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d173fb4f-af6c-4c50-bd78-301237d5f821	anonymous
d64c0193-9f11-4557-9519-79ff7565501f	Consent Required	d173fb4f-af6c-4c50-bd78-301237d5f821	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d173fb4f-af6c-4c50-bd78-301237d5f821	anonymous
1167da1d-c96e-4f57-bbca-d05cd834a853	Full Scope Disabled	d173fb4f-af6c-4c50-bd78-301237d5f821	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d173fb4f-af6c-4c50-bd78-301237d5f821	anonymous
84924434-7d39-4d7a-8bfd-a4bf6c29f712	Max Clients Limit	d173fb4f-af6c-4c50-bd78-301237d5f821	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d173fb4f-af6c-4c50-bd78-301237d5f821	anonymous
ec6e94e0-3fc9-486b-8b60-22379e909c89	Allowed Protocol Mapper Types	d173fb4f-af6c-4c50-bd78-301237d5f821	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d173fb4f-af6c-4c50-bd78-301237d5f821	anonymous
2bebd7cc-4d27-40c0-935d-d4cd8b3b102b	Allowed Client Scopes	d173fb4f-af6c-4c50-bd78-301237d5f821	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d173fb4f-af6c-4c50-bd78-301237d5f821	anonymous
f3f06355-ae09-4dac-9f86-d625fec21972	Allowed Protocol Mapper Types	d173fb4f-af6c-4c50-bd78-301237d5f821	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d173fb4f-af6c-4c50-bd78-301237d5f821	authenticated
955896a6-e234-46b2-9f18-4a5077a8af37	Allowed Client Scopes	d173fb4f-af6c-4c50-bd78-301237d5f821	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d173fb4f-af6c-4c50-bd78-301237d5f821	authenticated
a1ddd907-3ec4-47af-8aa3-021178f58b37	rsa-generated	d173fb4f-af6c-4c50-bd78-301237d5f821	rsa-generated	org.keycloak.keys.KeyProvider	d173fb4f-af6c-4c50-bd78-301237d5f821	\N
3faa3cd8-a4f6-431e-8366-727ad38c2c02	rsa-enc-generated	d173fb4f-af6c-4c50-bd78-301237d5f821	rsa-enc-generated	org.keycloak.keys.KeyProvider	d173fb4f-af6c-4c50-bd78-301237d5f821	\N
a98d3232-11ae-4344-8096-bbc1511d8aba	hmac-generated-hs512	d173fb4f-af6c-4c50-bd78-301237d5f821	hmac-generated	org.keycloak.keys.KeyProvider	d173fb4f-af6c-4c50-bd78-301237d5f821	\N
262e0038-f962-46b2-a321-810bc2baf32e	aes-generated	d173fb4f-af6c-4c50-bd78-301237d5f821	aes-generated	org.keycloak.keys.KeyProvider	d173fb4f-af6c-4c50-bd78-301237d5f821	\N
1e23521d-a2a4-495b-b763-53f2226177cf	\N	d173fb4f-af6c-4c50-bd78-301237d5f821	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	d173fb4f-af6c-4c50-bd78-301237d5f821	\N
bf461107-4ddc-41b1-89e6-76e94172c51f	rsa-generated	59e3dfd1-7985-4568-9573-4084337fc1d1	rsa-generated	org.keycloak.keys.KeyProvider	59e3dfd1-7985-4568-9573-4084337fc1d1	\N
d167ef04-d8d8-4c20-bc2b-988e63071210	rsa-enc-generated	59e3dfd1-7985-4568-9573-4084337fc1d1	rsa-enc-generated	org.keycloak.keys.KeyProvider	59e3dfd1-7985-4568-9573-4084337fc1d1	\N
59f1cf06-5c0a-4db8-89e3-4035862c965e	hmac-generated-hs512	59e3dfd1-7985-4568-9573-4084337fc1d1	hmac-generated	org.keycloak.keys.KeyProvider	59e3dfd1-7985-4568-9573-4084337fc1d1	\N
8cedf8f0-4f8a-422d-b457-d3c425c52235	aes-generated	59e3dfd1-7985-4568-9573-4084337fc1d1	aes-generated	org.keycloak.keys.KeyProvider	59e3dfd1-7985-4568-9573-4084337fc1d1	\N
eff0056b-03c9-45d3-ab3e-58b5a9b4d3eb	Trusted Hosts	59e3dfd1-7985-4568-9573-4084337fc1d1	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	59e3dfd1-7985-4568-9573-4084337fc1d1	anonymous
894b1e93-9b91-4272-8488-b8b2fbcfdeab	Consent Required	59e3dfd1-7985-4568-9573-4084337fc1d1	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	59e3dfd1-7985-4568-9573-4084337fc1d1	anonymous
ab44682d-14e6-4910-999f-903e5018933e	Full Scope Disabled	59e3dfd1-7985-4568-9573-4084337fc1d1	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	59e3dfd1-7985-4568-9573-4084337fc1d1	anonymous
0fa67608-f67a-4f64-8c00-f07e8dac7f5d	Max Clients Limit	59e3dfd1-7985-4568-9573-4084337fc1d1	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	59e3dfd1-7985-4568-9573-4084337fc1d1	anonymous
e55b2e81-125b-450c-8198-23cbbccb4faf	Allowed Protocol Mapper Types	59e3dfd1-7985-4568-9573-4084337fc1d1	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	59e3dfd1-7985-4568-9573-4084337fc1d1	anonymous
33e41c52-3f82-402f-8979-349b73657018	Allowed Client Scopes	59e3dfd1-7985-4568-9573-4084337fc1d1	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	59e3dfd1-7985-4568-9573-4084337fc1d1	anonymous
265a2be6-47a7-432d-8435-037399c62e7d	Allowed Protocol Mapper Types	59e3dfd1-7985-4568-9573-4084337fc1d1	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	59e3dfd1-7985-4568-9573-4084337fc1d1	authenticated
7aa56cd7-87c3-4a24-966f-d792cbf409bd	Allowed Client Scopes	59e3dfd1-7985-4568-9573-4084337fc1d1	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	59e3dfd1-7985-4568-9573-4084337fc1d1	authenticated
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
3ec9e2bc-a90e-4594-b97e-cb8d6abbb04b	84924434-7d39-4d7a-8bfd-a4bf6c29f712	max-clients	200
023a29e5-a488-4f8d-9fef-d742672eb306	2bebd7cc-4d27-40c0-935d-d4cd8b3b102b	allow-default-scopes	true
aaf9b2a3-b5ba-48d0-a539-95e505973295	955896a6-e234-46b2-9f18-4a5077a8af37	allow-default-scopes	true
6952d1b5-b835-4a13-8f31-b2e0aa51e670	f3f06355-ae09-4dac-9f86-d625fec21972	allowed-protocol-mapper-types	oidc-full-name-mapper
a5f78da0-4c49-4b2a-bbae-62e2291d4a48	f3f06355-ae09-4dac-9f86-d625fec21972	allowed-protocol-mapper-types	saml-role-list-mapper
059bf898-692c-4368-a493-ce84ef111370	f3f06355-ae09-4dac-9f86-d625fec21972	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
cceefcc4-d734-4b39-be15-0a8f7208acf7	f3f06355-ae09-4dac-9f86-d625fec21972	allowed-protocol-mapper-types	saml-user-attribute-mapper
db1640c8-ba0a-483a-8d99-018323757a6d	f3f06355-ae09-4dac-9f86-d625fec21972	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
51b70b13-aac8-4d1c-8932-9a13e59411dd	f3f06355-ae09-4dac-9f86-d625fec21972	allowed-protocol-mapper-types	oidc-address-mapper
0731a143-6038-43e9-9504-0e3a987b9ee6	f3f06355-ae09-4dac-9f86-d625fec21972	allowed-protocol-mapper-types	saml-user-property-mapper
a5d2aeab-2e33-4476-abd5-6b1313372cfb	f3f06355-ae09-4dac-9f86-d625fec21972	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
5a7d9e6a-5e9e-47f7-bafc-8a67df820b9b	ec5bc306-360a-4da3-9606-191cc76f7db4	host-sending-registration-request-must-match	true
a2133e11-622f-46c7-ae76-f090d81763dd	ec5bc306-360a-4da3-9606-191cc76f7db4	client-uris-must-match	true
9632ea89-0224-40bf-9e12-d3f959b5b671	ec6e94e0-3fc9-486b-8b60-22379e909c89	allowed-protocol-mapper-types	saml-user-attribute-mapper
2a59ada0-50c8-4860-a36a-e1fc5fea16c1	ec6e94e0-3fc9-486b-8b60-22379e909c89	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
14976d34-60ad-4bfb-8ff1-4bd17f59a5a3	ec6e94e0-3fc9-486b-8b60-22379e909c89	allowed-protocol-mapper-types	oidc-full-name-mapper
c1acab79-0a9a-4472-9ff7-30323037b451	ec6e94e0-3fc9-486b-8b60-22379e909c89	allowed-protocol-mapper-types	saml-user-property-mapper
274038b3-aa7f-4584-81ce-7b031182e828	ec6e94e0-3fc9-486b-8b60-22379e909c89	allowed-protocol-mapper-types	saml-role-list-mapper
8bb837b6-53a4-4078-8d3d-1e7b632e550e	ec6e94e0-3fc9-486b-8b60-22379e909c89	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
41d85e2e-b03c-4ae4-bf03-2eeb360673fe	ec6e94e0-3fc9-486b-8b60-22379e909c89	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
4166833b-07ef-465e-84d5-98896f117d30	ec6e94e0-3fc9-486b-8b60-22379e909c89	allowed-protocol-mapper-types	oidc-address-mapper
caa511ee-a741-4e8c-9904-722fb10684cf	a98d3232-11ae-4344-8096-bbc1511d8aba	priority	100
526a28c2-d175-4e9a-b412-3d81d6b5adc9	a98d3232-11ae-4344-8096-bbc1511d8aba	kid	d0a7fe83-a41c-436a-afd3-519696382a7a
f929f42e-10b6-4c82-a19f-1a6704bc2563	a98d3232-11ae-4344-8096-bbc1511d8aba	algorithm	HS512
e0c9d254-77ba-4dd6-9732-d58998c18b37	a98d3232-11ae-4344-8096-bbc1511d8aba	secret	tsQ-C15S2ddk4hpNbUa5oxVbGYQKkwGcfPWH4Ha2OekJX_FyUdb4dJ8CPC4dNCWIazS2Rrs5CiIKHihSV9IO627ohLFAzSR0nihmWONchvDBs_BxDCzTKm5isPm-S6GATNN6z-9J4V2v_t4Cqpt4EFPQqGyfBTkVtl1kQbsLntU
9e78668b-f981-4898-83aa-c702142ad0b7	3faa3cd8-a4f6-431e-8366-727ad38c2c02	priority	100
30caf55f-91df-4fd3-80ab-e935358ee457	3faa3cd8-a4f6-431e-8366-727ad38c2c02	keyUse	ENC
550f3c22-6d38-4882-866f-956f0cd2a01a	3faa3cd8-a4f6-431e-8366-727ad38c2c02	certificate	MIICmzCCAYMCBgGYnyH2izANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwODEyMTYzMjM5WhcNMzUwODEyMTYzNDE5WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDnhWiMqfgGqNBE5Hezm1tMbtQIv2neBcIrVq49QjxbUMNMHWDB4tQ/0H+5BPWEOd/5JVqoR1YCvqI5g6xdPX6WJkx8Di7Lx9iXD6bBOB5zcIKvHd4ART8QEV18cGNl5hYBrJpAXZfqGgake9oQ1b2LeJpfREnNS1WRkVj/CctT5q0JtrRdd2SxIEsDAlj9yZyrUX7CJHqS8szI/WVn2aqwBKcvfhp8Ay/QDHfEmM3IAXRFQ1sTXqJl0U/nc731lf3MAuZ1rW4Nj8hLwV5MFLvKzx4lFoSbdeyHT/Sc6UWxXlakrSW1W+utaZP/1EOKpe1YzmMiFOzFtiPCaDij00ftAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAOahabbkLk8mjOnI8xLTVSHaLO/ZNc2lA/v7bpvNRX+hrzEtSNjAC7HegRRkAcGqyp2li7NY/aAgKpRNQ737SsBg8mIwv8U+SEO+4K71hxHbHxZrhY3qUhHkZ99YpyqUtLmf5FvuWrG/2Z9KBVrNl9MZ3OF6pjySypvcOoQfkEN7b3N72UqoV9ArCCStIR/nH21eZqZjJByUN0UcBYIYFDI+RqtrHrf4ZvYWdw0GDfnFDiq+h6KzQnLkcGhxsEOlDmFotDVQE0FawjJEFmcp6Nnpvsw4HnLzLC09T3IwjeWJP4uH/JsDr5dQqUoKLdsgDLR1sbx6T+J2G5d0ou2lXww=
2b2e2fe9-5dc7-494a-ba4c-4b0cf62d5acf	3faa3cd8-a4f6-431e-8366-727ad38c2c02	algorithm	RSA-OAEP
72901592-9a30-45c0-b2e7-f330c4cd0a40	3faa3cd8-a4f6-431e-8366-727ad38c2c02	privateKey	MIIEowIBAAKCAQEA54VojKn4BqjQROR3s5tbTG7UCL9p3gXCK1auPUI8W1DDTB1gweLUP9B/uQT1hDnf+SVaqEdWAr6iOYOsXT1+liZMfA4uy8fYlw+mwTgec3CCrx3eAEU/EBFdfHBjZeYWAayaQF2X6hoGpHvaENW9i3iaX0RJzUtVkZFY/wnLU+atCba0XXdksSBLAwJY/cmcq1F+wiR6kvLMyP1lZ9mqsASnL34afAMv0Ax3xJjNyAF0RUNbE16iZdFP53O99ZX9zALmda1uDY/IS8FeTBS7ys8eJRaEm3Xsh0/0nOlFsV5WpK0ltVvrrWmT/9RDiqXtWM5jIhTsxbYjwmg4o9NH7QIDAQABAoIBAAdY2rdCCpKth0R0ap8KwlQz3Ss05ddrn9yPuOJNSIyOTNBMy14DxIAM7gyxTVhHnOWza4PVFbPrGEtSdCUWVz7NEtbJ/W6ulh8/GifeD8tSifckL8Aa8nQgVPLmvyTD7zVY5KE/xxsg/c549rPbkJMNPfrheCUZa6r9rZEUXr04EJZe8ADhzqKVBw7cvOAGJA2GRAhGhMzX+xRJ+z43f41dhC+ThBPr9UgNjBARkGjGBTIe1I3n0YygGDqnPkpEuYUdbilCi8lqto2GR85t+jc79Rm5ZBqfctRoAXRMs8GvAIUHswYa9x3zZfeo8QZ777iRN7WoJ635rm/dYCbWRUECgYEA+7FamNjskepJjYLZ5MkECJZ88dNCBartiIL1/VwZ0enuVNu6lDDJy5+i40Yz02hIySDclQfEYCGEe9Y+CnwmtzqIq/CFBR55c/GEC75g6WNntxVsNQ4ej4sKfQ5lPdHq0opA26xg1XqszYdUPSFANNQzISZvYBxtdipGDbwV8EECgYEA63uvHhgXTLZyln59mqu86/qyE+3NHyi7c7E0HZTvqmKPITuky1NAYfD60GT13BUi7mT9mdtthUQwqIYWuD4iJ2o/griF7E7iJHDJLOxTNTCTdYCKmuHt+Mafphv9i896oV1EADQ/trhaARYB1U6pDrZnljF0VTkiOQVO4O6E7K0CgYATjURvaTJ/Z0bNcmPAzQi+LgqIspOHYy7OkvXO96+dyeFUwDjvOBcE9WKu6w4tlwVIcoAQJ6lOmmvzPsJVCC3tv+NMEAQVULe4lQNf8isPFkTBSS29tVoUZoWrD0o4Ei1+q3S8W9it3Li9wox9ry6QrAdIxPaT7cFnE4Obn4fIwQKBgQDP5vocAr8HbolKj1DLrtZ0LXjtmWUhHnApW4kcmPLkJnIhsCv1i4HrNrvqI0jhzxNxEF7KaO2P3D1tfD0w20KCNA7wlYM/uAF2lNE4xUlNS57U/fDhf5j/rDUljc7TkhG9x78Sww6Bfs+P5+MkdXdS0v4vn2gLGg858pLKiit3XQKBgBAlM5EGj1V7wwRQLTa71cfKoloy3/n+k3z992QS8eVwGIpaLKmM+gg39lWH5n35ZhzHuZtdxojpZkYtekvFWDtIMYhclsff6OEJrxOPD07PFAkX7XSS2U7c2iraBByWtXBa6ZKTKgix6lsMdmwLyxXvIQG6LI4NPyY366LU7MpX
6d33c47c-c44f-4448-9837-afc5eb921e56	262e0038-f962-46b2-a321-810bc2baf32e	kid	0ec0ffbc-a2d2-4ee5-86df-09ebd84f90f4
12d23bd4-0c64-459c-97df-78e00ab72196	262e0038-f962-46b2-a321-810bc2baf32e	secret	Ja4h7PVTJBo8sqYAUb842w
959fff71-7394-4362-b566-158a869b4539	262e0038-f962-46b2-a321-810bc2baf32e	priority	100
9af2f3eb-7bbb-4fd0-bb82-237457addeba	a1ddd907-3ec4-47af-8aa3-021178f58b37	keyUse	SIG
e08a4a7a-ae38-4dc0-9878-f0df62d5f872	a1ddd907-3ec4-47af-8aa3-021178f58b37	priority	100
cc5f89c9-6ba7-4912-bf10-016648463811	a1ddd907-3ec4-47af-8aa3-021178f58b37	certificate	MIICmzCCAYMCBgGYnyH1sDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwODEyMTYzMjM5WhcNMzUwODEyMTYzNDE5WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDNfaCb+vQLpPWRAlc2mn+68QpNMncw5PvpgqjLlm7eqjBzuNWgWw+eTiuFnnXg5hTt4C4YTLlaJli1L70BKlp7Xbog8CFc7GvON++flEyIL4zlXAikjpDTYS9egcKJsx0Oa7mLuO3j0T8CYt9cv+XklAVtIoQf2Lj81nJWZnnEge4a40iJAnZZLeND2dnNt503lkiUBm34fdU6DLOKvi04p0EiNn6gcxvcItYwi99h4XsTWKZ3GkiUMlX/wS55cJeHkot/+cgafZLVR4xxKwI6L0DvqHV2pP6ZGEEnJ9B+rft+JgzU4r0mobCMpBTSzOElUSXO9yTFNMCc0dhBQD/XAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAHwlENqgIaYPg16l4BqFxVLHkWx2YH0Q7Ao9PnAss50SySBcVmUMnl6hlkkwzSKrrSaJoFaRJigU7ma0wCiOq+EOVop0QJAY/KY7TVn6g4KVwRxPPAR7pb8VwK5m2VRaG2CL1f8rAjwdAPxkEIcJA0fp/IMPp0zVYcj9NB+P4nzvIzEu8Hh4+ryXX9EdM3YZIn//0Q2SSN6BGGRETgoUXfvUXyIS+wt8n2Y7Cg4DRyWcV5b2PqtafCK+pLWwO2L/+j7arp2XWDQXSr0zz6lspcjJlXY1WcdjxauoM+YbpIWEDFUvmJhtJv2BQW0OkBp1aLms6YVSFirPfPXIQHu1Y6M=
5711b79f-43ad-4159-925d-e5f2e7940e59	a1ddd907-3ec4-47af-8aa3-021178f58b37	privateKey	MIIEogIBAAKCAQEAzX2gm/r0C6T1kQJXNpp/uvEKTTJ3MOT76YKoy5Zu3qowc7jVoFsPnk4rhZ514OYU7eAuGEy5WiZYtS+9ASpae126IPAhXOxrzjfvn5RMiC+M5VwIpI6Q02EvXoHCibMdDmu5i7jt49E/AmLfXL/l5JQFbSKEH9i4/NZyVmZ5xIHuGuNIiQJ2WS3jQ9nZzbedN5ZIlAZt+H3VOgyzir4tOKdBIjZ+oHMb3CLWMIvfYeF7E1imdxpIlDJV/8EueXCXh5KLf/nIGn2S1UeMcSsCOi9A76h1dqT+mRhBJyfQfq37fiYM1OK9JqGwjKQU0szhJVElzvckxTTAnNHYQUA/1wIDAQABAoIBACDeSfpTwbAQdVb50N64XQXsgtamOSUQ+1pLvplnOS9UeZDeV7fhLjZcD99ni+NVP15tJUetvgK1b4BLtSeikVEk73NP9YYvgBmUHjf1jehFSCbHpHpDHiyGtv+e3HG6Ee5kkgvPS1Mip7lx/ILmuZbo4OqmmAugAWGFIPTA9L6Biyd3yrY/BIMT4EA+vAH0ULgS5yjBlYqcj1tH1eNY61U1izInSM3/VXhsDi2nUjXZMaO97FURX2ZVze9XNwd07bp4KxqgVZnaYUqAgwmm4GXp73G5brFrERrsMXPLybv6kdpec00kLweq8yMYDZb/vPALPMFDpqy+mSJb/CTyYsECgYEA5V4qPyjXcZTnnj0GJcl393TYuuDf5g28jwsmu5UR+dIafnzgzvwXzQm9nu0xGdMcUeqrAmN9mlcSfvVPwrViJv0ycDtQqoi5BqadPnsWrOjP1OMc0xiJirKPWbZx51j8Z+rdI/KzNnptuAs3aScr9//ynabcUuEXtPXlUvRwnFMCgYEA5Vm6ezGxXayPYxQBtOlYQ5Pkth3/9E9iaA0ed5bAfIPE0lkUbORN8CNvzM9M+AhFuhFwnlZ8Ey/oUNN7wBFkNfG2Y539tIl/X/l7BRm4ZOVGrLE4l3zNcDzS+QYbG471SuhDbl0mspodkJ3ONW309Djm6cwCqR06ZyCDtWdJfe0CgYB/PVGqX/nEZJpoyemTJMSMXiGs6frLIGut3r3J6dRjBg70hEoiCO8bK4ApneNTNC3Ns6TSWmbfK9Zy35szpHOitWs5n24MbHRYIC2y742QtkY1Dxh6cm46pvunBPMDJ/Y9n6i1vHl2i0w6gN5oUvatSStKEbq/r2b7WD2zWy7tSQKBgG5a5F3OpVc7Zqr3v3J7LNsnWE9A1B2L7P/AAD7urKO9C4FjF27l05KOmobj4FcgM9y584RcfMsGrDPn7o2WUK+cJHR+Wsr5te5KLqVfoNf7ciw6Ac7yYC93NNRZ2cVC3kgyxe9epvYdLcieBdCznb+9eW5ZmZYh2C4y+OzaTARpAoGAcJk/4Xk0TfT6HQfFSPxkwD/+7j3Jt7PjDxhXLPPav5doRWl1O7jrRbm0Re970rqWBA0jTVjHfTteTJxu5xq2/6MSg0TWo0O4x6qQOMqSk4XMhAi7x/Ek1soJ/NskMZsOyaZcfPqPS33XfnhUDBwSQVas7DZL17Bc1UCLhjE59WU=
dfa43c47-2cc4-47a7-b776-f0b609e2ca50	1e23521d-a2a4-495b-b763-53f2226177cf	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
22272aad-5bc9-40dc-b054-51497940f650	d167ef04-d8d8-4c20-bc2b-988e63071210	priority	100
9689ceb2-feed-4ca5-80f3-91dd2bd41949	d167ef04-d8d8-4c20-bc2b-988e63071210	algorithm	RSA-OAEP
1275fcd6-9f68-4933-ad1a-640a8bc860e6	d167ef04-d8d8-4c20-bc2b-988e63071210	keyUse	ENC
20fecad5-0d46-42fd-90e0-e1bae5eacb30	d167ef04-d8d8-4c20-bc2b-988e63071210	privateKey	MIIEowIBAAKCAQEAtEvjs/yYBThrHStS3rKTvbVD5LeX7bkGv12Ge28VRrpYQ0ab3bEswKo64ZO/TyRpGmBdY7KyyvPggfTYJey2zzbNdlbAFfY8uO1ALMVZFAgvld3Cb7efMGXB6//8ZaNtlhrF88xW1o+/t1tXan/BktV+3/FyhcdtHqOG+UU87igKbH91fk2AZpRIUFJukyvx6q1dnYcM6I7SVO0HL3V6jJtH/PyApOtX1sd2ZrdvepOH/lQWR/27xYp1ZHr+FAQsSzCt1bA21X/njjdIC1oZOSug4Yfh9SrbmHblclIuFU4+VXtLyEuzbyNbUhjI2/U/TA7XKdmz8hNsPEAgU7LpcwIDAQABAoIBADUcrgVVgcr35cX//zePT6pw/YEg/GaRPQWenYE7Jf9h4aJf6IaULOTMwO+2wIKl7ThR7vDxsW3MDfT6lboGU4wTTs9vmsJdeWHYsjD+KdGW3728SAz1ALYXI9tL26RtUlkHpgy9w08NpaJ0C/pZjEKfFfMOg3gZWXHPJnHEDcDyFoRNMcPlci/V0fEqQSco0Sp8oERkumsGMUAPBdRhOgtestA/FmDi+JcdpBbWaGT3QfxR2ea9PqKQJEMxh/b7r2SQ7AAzp2bimIjHAbIMsDUyvNRkWk2aystrfT5q8V2AyxfwbAKXC/V806MPscQ7G6eshSk/ycN2wNOdbcvmG+ECgYEA+71xZ9q/XruDe4UMVSfWhhoDymbcbV8Ps812cTneTrdJYjObNLr1kTbQSMJe9hw4ZaEk8KShW2a9KMhWYEVAPeqnFwGRcwRcb1Mgr6V9baTuNCC/+BZRk3kJwaG0ESwDpW+5+n+bZ0jr0cPlPK5Dzb+qjwBdlcsgMiJvARvabAsCgYEAt1jyjQcYnoIypIy8iNawJILoZDuPPlf5o6GHbXiIlFd4sb3KwmFWGrgs6zqaTrt5JH3A0eEcf1k47xu8FbLsecOjtEBNBYAehJ/D5h1ghogiWOai2wUMx102+gv3rLmGvL4/E8UiWpG4OabEmjVs6q67rnrxRVUdcX8shL8gcTkCgYEA8/Uv7JxRbqW7kr1qKTAVNhoJ6GDsZtWD6xRHHw0cgh4fcJpgY6Z3CkYbbRdoXYsVoG+c09RHRsN2twoGov8ZdadsS+BKKzNjvMLLX0y6E8KM0VmXj/1ZCth2ev6Q+T81PWLb0YVOfbZuSfdUtQyQStjemfyZtOuHhO5XsrRiZOcCgYB+irVdAHjNba7mQvwctY/8ox0hkLncnXt+pA2EUJxzRavXgNZgMi3rYxIdh+TYUivaM7DRKj0w57OT0+CMWWE86Pojff2qvjJR9rKOL9hfAbYzBXuBDoszTfKTwY6/d4y219dRHc4IFGrB34fxps31a4O9eLzszUH1A4EGXaNWgQKBgBb8L9NKF8ZgZ02RP5qDUmQjQ8bZrYOvm4vMxpBhGTxytGL5bmelvssRfeAFI44O86fX2QmZBMzIeJCFamMo4XuMfUJtyc/dUCR42RWy46mUc4QEkiSNUrKTJGTgIWZJ//YqewUyt6pR8mli8+TkxS4dFximAPOW14rMO+YH6zZ7
c7ae65de-c113-4d1e-902d-08939e4e184a	d167ef04-d8d8-4c20-bc2b-988e63071210	certificate	MIICnzCCAYcCBgGYnyNUNjANBgkqhkiG9w0BAQsFADATMREwDwYDVQQDDAhtZWFsd3VybTAeFw0yNTA4MTIxNjM0MDlaFw0zNTA4MTIxNjM1NDlaMBMxETAPBgNVBAMMCG1lYWx3dXJtMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtEvjs/yYBThrHStS3rKTvbVD5LeX7bkGv12Ge28VRrpYQ0ab3bEswKo64ZO/TyRpGmBdY7KyyvPggfTYJey2zzbNdlbAFfY8uO1ALMVZFAgvld3Cb7efMGXB6//8ZaNtlhrF88xW1o+/t1tXan/BktV+3/FyhcdtHqOG+UU87igKbH91fk2AZpRIUFJukyvx6q1dnYcM6I7SVO0HL3V6jJtH/PyApOtX1sd2ZrdvepOH/lQWR/27xYp1ZHr+FAQsSzCt1bA21X/njjdIC1oZOSug4Yfh9SrbmHblclIuFU4+VXtLyEuzbyNbUhjI2/U/TA7XKdmz8hNsPEAgU7LpcwIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQBCvKD9S/GWZ0ihGY1cpl85EaURiKcvijQ3CXFdOCY8wbven4oPmwsKC5rPP+t9M6ITEkBvqFO5cV7AzeRBk5q/4QKGa1kYCLwXfe9g24jKQv8ALbL7a2EmDP9UcgLhCWeEQa5pe4EbYGH/6YAXPU0sBvorR5FYrRiw5EY/o5ad7AyGaY7/FqEf1MbcoZFOxj6AGFx075SKMC7o7jjt6l4KLCMGOUgIgo9CyZwVK3yH+aZL1lIT0neKgaCfYi7hlWq+8OMH3DXXIfphKBTO3wfRiHIdhGISwEyi4eqzc0mxZpmWS6RtVJrARQN4h5+nUPl6e0hUgSRf/uL701gPullR
4e30b021-c515-4983-9102-b2ae90402933	59f1cf06-5c0a-4db8-89e3-4035862c965e	priority	100
aefd633e-dbf7-4ff1-9ea1-57471e2afe87	59f1cf06-5c0a-4db8-89e3-4035862c965e	algorithm	HS512
99a7afb7-063a-487d-afd7-f10fecf347ab	59f1cf06-5c0a-4db8-89e3-4035862c965e	kid	55774493-74d1-4a3b-af77-680fddae6786
23baee3c-7096-402a-8ca7-2a080a3526a9	59f1cf06-5c0a-4db8-89e3-4035862c965e	secret	TjZYVlYe1fk9H1IMcEzGD481aTGpEXFszflPZoxj4lkuNBFbbPEprKEXc9zDBI-YUBHmYMc59KYysz8HJcmoEWQ24iyVuAb_diBM0Vo9RFMVWV_VYB_gTvFZOjaIQpbJUz7iYG-CZ2GKWSYcoiKNQvoA5gYU0jty-w_XIVVzous
9ec5c9c3-4e0f-4c0f-a363-5c56e255f2dd	8cedf8f0-4f8a-422d-b457-d3c425c52235	secret	ajGyEFxMtMbHEGHFsVH3tA
7dd71a26-2528-49fd-8dfa-ca319a00d717	8cedf8f0-4f8a-422d-b457-d3c425c52235	priority	100
0033f8c5-85a3-45f2-9f14-d2ad9f14b537	8cedf8f0-4f8a-422d-b457-d3c425c52235	kid	bd57585d-e209-442c-81c7-1721f9113aef
499bfec1-d56e-44de-b245-4acfcdb37610	bf461107-4ddc-41b1-89e6-76e94172c51f	keyUse	SIG
838e9e99-65bc-43a5-87b6-1f989644e7fe	bf461107-4ddc-41b1-89e6-76e94172c51f	certificate	MIICnzCCAYcCBgGYnyNTpDANBgkqhkiG9w0BAQsFADATMREwDwYDVQQDDAhtZWFsd3VybTAeFw0yNTA4MTIxNjM0MDlaFw0zNTA4MTIxNjM1NDlaMBMxETAPBgNVBAMMCG1lYWx3dXJtMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0/NMP+0PnA8V3V8yMAIqO5VqC3y4Y+L54/k54CT7YeEEatCgMBLLLpJf+eJPhfBGxcCjoQzdzD3/K5m+E4FFltUATq5U7rAI7jty5ZDINXXoRFcfqx5WudQ5zK2i6VZUYMmkQQFBEMSl6ZaATUBsSObActhVPtd2I5DZN3Hwh92irdLeGzXVQOWvcdzbyQCUr3XT/vyFEl4XRYiO/VtDBNKrwuLFXdf7Z7ekTc8QBRi90qNczv7kFkH1emSvLTBKU47qRHuOevybO5jidPV/cMg5n09k2sy3gWQs8YDyXEZQLvByhh/lcOxTMU8t6Q/o7slWtfYEj7QumAXMU0DFSQIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQDQXMujixxBZ8Wih/Hw3t9p0gB7J0iF5s4/rvyvXhSKZClodJ0iElPbtwpxk6rGw3/WWCGVP5KFi+zadP5pFol6TWT31csSmKgLvuxNVEtjR2FYYSIwrtv6Ra5U4jWk5wmiGjKrdZ10403yMwjpKJYbvme+Sf9H72eKS09hbn/rqVP3hJ20PSm8cQ2Nvl+Pb8i3gmnCE8Zcw9w3OcGRJ+EU7AJlj6gzyjb0Q7CMI5TlT1J9wzkx5UPzPoCqmrjyVyiAvL5VPU/SVkm+PK8sn64ySqm9F3KIOVbZx+180duRpMIoQ4yQijvFfE7ElfwZq1peH6wJAVU0Qfv+v1Y8tgCT
226fedd0-724f-4967-884a-3189802add68	bf461107-4ddc-41b1-89e6-76e94172c51f	privateKey	MIIEpAIBAAKCAQEA0/NMP+0PnA8V3V8yMAIqO5VqC3y4Y+L54/k54CT7YeEEatCgMBLLLpJf+eJPhfBGxcCjoQzdzD3/K5m+E4FFltUATq5U7rAI7jty5ZDINXXoRFcfqx5WudQ5zK2i6VZUYMmkQQFBEMSl6ZaATUBsSObActhVPtd2I5DZN3Hwh92irdLeGzXVQOWvcdzbyQCUr3XT/vyFEl4XRYiO/VtDBNKrwuLFXdf7Z7ekTc8QBRi90qNczv7kFkH1emSvLTBKU47qRHuOevybO5jidPV/cMg5n09k2sy3gWQs8YDyXEZQLvByhh/lcOxTMU8t6Q/o7slWtfYEj7QumAXMU0DFSQIDAQABAoIBABCJqjxOMWK8SBjX89TsZFJ2HfpDuuj7VcOAp7AKPq2kVrmFagxaOQ2bGP9I1erl5MXLGlFnjTphp4KFyl+f/Xevisi44FJn/KhnDdflAEQwnSUQ9bz+vuZczX4/maeyh16ueSEj2Yl3CJmVd1Efyts02xUS9XLT8clEZPiHLM0S/PtTTzHzJvN7OPExEmCbO7evHFZpJZZwC7kmdwjbXT0YzttTgBIaK8duo1kkJI0LmNLiIY8pGfu9PmH79mT/KxYDxGyoVTZX81HmdMjvp7ExbJ7Vkr07hcmku6Q8rhzksc6KQ0dju14OI3+BsYjUhP7H8ctIEgbgVP8ys3ZXhSECgYEA/7QG1Jw+LMxPXk1Ij9R5JQNyGibblNpOXU3p5+cddxeaDtHwtV73qRKk0YWaVyptlxEVQ1mkH5KHmCEeWo3lBlyNDrLmS2rlry/ui4CXUclJK0tV8uazpVrdWGFeyLWTojGZQybEZ4QHilCML8l1MY7LP+L9mb96g51zgQI7fykCgYEA1DJFgyc6cjZjeFCQid+VvnyYaPYSruVbqBw36MV1V5vXrQkoaQnyWzNhJPU5llh2J4oOllluNatvUKpQiweO5UNHP0PsahvgmKL9cKxX/T01STNuMW03hszIXDPAmUYjKnuei6LQ2z723fWfMJXJS6g14T7/yTb/btcEbaUDeSECgYEA0BZcPKdNvb0ildaEx2+ciq+MKpYWucMSZMHkKTGee+08FPVqUt8O4otmj4+PM4I2nuprCF0pv/vJ1taU0hKJH60vqZeS7Cr48aErGmGyQv9wSQhM0JhH97fDS4opzWJe225LkCc7TBZY4Il+G+FxOrw+0SXTRUxa0kLO3VzIuEkCgYBiu9l4QyKAzinOa741SOGGNrc773OWCYZyXF7vYiFNWGgsTVyOM2CfavLCnY/kEtk3YJeVAZu0QUaURAsiBaxJpNpb56DzZnFE1GIUsTxnyrkmjFWzjdwOTu7TaAkvyGDIfaix1FpWCaAYexdNJgT5vRUE76lY2MxVqJqY4fURwQKBgQD9es09d62VxkM07KelsDLFMMNzRLjBBeyHmFuddixk0StB62kl6j5cy04iJx/gvODzArpCCT1TB8Fkyl9vuhOpSnBp2h98KqpTBJvy/B57NDa2DpqUL2I3AwHvJtE30xWUrxMxKgpX84jVfl2IGovcHhrqw6ZE4kNQg9HZma48ig==
10e7da34-01bb-4db9-9d68-3b1076592517	bf461107-4ddc-41b1-89e6-76e94172c51f	priority	100
af25c7ae-3aec-4f5e-a76d-d29e7884f390	265a2be6-47a7-432d-8435-037399c62e7d	allowed-protocol-mapper-types	saml-role-list-mapper
c40e2346-2008-4ccc-9504-772e24465b9d	265a2be6-47a7-432d-8435-037399c62e7d	allowed-protocol-mapper-types	saml-user-attribute-mapper
8897d4a0-95a9-423a-b0c1-78b220c45084	265a2be6-47a7-432d-8435-037399c62e7d	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
43c48b1d-898b-43a9-9c32-d70ffbdc7e39	265a2be6-47a7-432d-8435-037399c62e7d	allowed-protocol-mapper-types	oidc-full-name-mapper
330806d2-af61-48a1-85ff-3d7bab2313bc	265a2be6-47a7-432d-8435-037399c62e7d	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
5fbae0de-b0d2-4d11-a656-86dd1eb7ff33	265a2be6-47a7-432d-8435-037399c62e7d	allowed-protocol-mapper-types	saml-user-property-mapper
6ec5398d-f125-4afd-8cc9-b820b4537c29	265a2be6-47a7-432d-8435-037399c62e7d	allowed-protocol-mapper-types	oidc-address-mapper
1ba9bde2-75ea-4bb8-9f77-03cea2c33bfa	265a2be6-47a7-432d-8435-037399c62e7d	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
50e6d5de-953e-41c5-86cb-7fb14fb395f6	eff0056b-03c9-45d3-ab3e-58b5a9b4d3eb	client-uris-must-match	true
8634dbf7-b71d-43f2-9940-59cb12370e69	eff0056b-03c9-45d3-ab3e-58b5a9b4d3eb	host-sending-registration-request-must-match	true
8d962df5-75c7-46b4-8708-f0e5a5853f58	e55b2e81-125b-450c-8198-23cbbccb4faf	allowed-protocol-mapper-types	oidc-full-name-mapper
5747d803-bb86-4bca-8a24-9949f69c50c0	e55b2e81-125b-450c-8198-23cbbccb4faf	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
755101b2-0add-4438-8ca1-4caaddc7bbec	e55b2e81-125b-450c-8198-23cbbccb4faf	allowed-protocol-mapper-types	oidc-address-mapper
030defc4-1093-4b9c-b215-050eeb822d84	e55b2e81-125b-450c-8198-23cbbccb4faf	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
60bf7174-fb36-4b35-bcee-ca716537520f	e55b2e81-125b-450c-8198-23cbbccb4faf	allowed-protocol-mapper-types	saml-role-list-mapper
a9ad5c61-ecbb-46a3-af2d-e66af48b7171	e55b2e81-125b-450c-8198-23cbbccb4faf	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
848b6334-95c6-4f63-af7b-b638ccc3266c	e55b2e81-125b-450c-8198-23cbbccb4faf	allowed-protocol-mapper-types	saml-user-attribute-mapper
676b82b6-a8e1-4aed-a42a-eb1cd1f2f660	e55b2e81-125b-450c-8198-23cbbccb4faf	allowed-protocol-mapper-types	saml-user-property-mapper
3972fba3-daa7-48d1-a48b-fb89ed078a25	7aa56cd7-87c3-4a24-966f-d792cbf409bd	allow-default-scopes	true
f8cd4502-3332-4403-8913-a1169036ba7d	33e41c52-3f82-402f-8979-349b73657018	allow-default-scopes	true
237217f3-159f-4095-95cf-b542d84ac78a	0fa67608-f67a-4f64-8c00-f07e8dac7f5d	max-clients	200
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.composite_role (composite, child_role) FROM stdin;
2c8866c2-dc17-4b3e-8f71-e73da9b7dd4e	5b8b4356-668e-4b7e-970f-0ebc613d7b15
2c8866c2-dc17-4b3e-8f71-e73da9b7dd4e	e7fe8671-d16d-47db-aa5a-d15490dcfcaa
2c8866c2-dc17-4b3e-8f71-e73da9b7dd4e	c36fb424-2a43-41be-b817-4e0fc37f48fb
2c8866c2-dc17-4b3e-8f71-e73da9b7dd4e	9fbd2182-7094-4f6e-84ab-d86a581a2107
2c8866c2-dc17-4b3e-8f71-e73da9b7dd4e	e513e41c-1d30-4c56-8c4b-88debc0ca14b
2c8866c2-dc17-4b3e-8f71-e73da9b7dd4e	7e45110c-8951-4e50-a843-d8251358af6b
2c8866c2-dc17-4b3e-8f71-e73da9b7dd4e	09367a58-c69e-4bf8-b0ae-6f3cf06f9d0d
2c8866c2-dc17-4b3e-8f71-e73da9b7dd4e	035fc9a7-9653-4575-96f6-80d3a48cada8
2c8866c2-dc17-4b3e-8f71-e73da9b7dd4e	81920680-564b-4d2d-b7dc-1ae668660e86
2c8866c2-dc17-4b3e-8f71-e73da9b7dd4e	fd404a5a-9a64-4eab-9e97-c29b53ff23dd
2c8866c2-dc17-4b3e-8f71-e73da9b7dd4e	58bc8f42-5b90-4b74-a75d-07c1d438b550
2c8866c2-dc17-4b3e-8f71-e73da9b7dd4e	b8f04bf9-9717-4ac5-8231-dfa5b45b90b3
2c8866c2-dc17-4b3e-8f71-e73da9b7dd4e	9888682c-42bb-4e14-ae7b-671a09ab8503
2c8866c2-dc17-4b3e-8f71-e73da9b7dd4e	1be6791f-fff1-4ff5-bf81-c4b0103205e1
2c8866c2-dc17-4b3e-8f71-e73da9b7dd4e	dd485959-82e6-4d13-abc3-e5b8af469757
2c8866c2-dc17-4b3e-8f71-e73da9b7dd4e	ab62cbe2-580c-4fc2-83ec-d7e91509222a
2c8866c2-dc17-4b3e-8f71-e73da9b7dd4e	6dcbf057-624a-49d4-a839-d47298835b7a
2c8866c2-dc17-4b3e-8f71-e73da9b7dd4e	3fd922fb-1b6d-4d6c-ad24-e828024b4178
34492721-3f11-40ca-86e8-2b48b6c7c7e0	f747f6bc-a5ab-422e-bd45-eaf0934344a0
9fbd2182-7094-4f6e-84ab-d86a581a2107	dd485959-82e6-4d13-abc3-e5b8af469757
9fbd2182-7094-4f6e-84ab-d86a581a2107	3fd922fb-1b6d-4d6c-ad24-e828024b4178
e513e41c-1d30-4c56-8c4b-88debc0ca14b	ab62cbe2-580c-4fc2-83ec-d7e91509222a
34492721-3f11-40ca-86e8-2b48b6c7c7e0	1067c0ba-f341-4ef7-b6f1-0f684ae54341
1067c0ba-f341-4ef7-b6f1-0f684ae54341	958c4f4a-d33c-4013-a0f7-29de108f4c3b
df9c6a74-d057-4bd2-acca-d0b150224939	ad20eb54-88ed-4771-bb9a-bf86d3edc045
2c8866c2-dc17-4b3e-8f71-e73da9b7dd4e	06fd2128-277d-40da-a127-56513996273f
34492721-3f11-40ca-86e8-2b48b6c7c7e0	c6fbf5e4-ff9f-4f5c-bb7f-9f8bb5a087a0
34492721-3f11-40ca-86e8-2b48b6c7c7e0	b0bfb301-dc6a-4574-a8fa-f749f6e35739
2c8866c2-dc17-4b3e-8f71-e73da9b7dd4e	237eaf24-3a4f-453c-9db7-97efd9dadce4
2c8866c2-dc17-4b3e-8f71-e73da9b7dd4e	78f4d451-3207-4d1c-b22e-e72c4c4935bf
2c8866c2-dc17-4b3e-8f71-e73da9b7dd4e	277e2a8e-700c-4e9d-abb8-ad00dd53754b
2c8866c2-dc17-4b3e-8f71-e73da9b7dd4e	a54d786c-e015-4cbd-b347-56d668decfd6
2c8866c2-dc17-4b3e-8f71-e73da9b7dd4e	28eb405b-76be-4bfc-b4bf-684fa8f486ae
2c8866c2-dc17-4b3e-8f71-e73da9b7dd4e	de8903de-017c-433a-92af-f4fac7c23df7
2c8866c2-dc17-4b3e-8f71-e73da9b7dd4e	ebd811a3-0a2c-4094-919d-40b104150611
2c8866c2-dc17-4b3e-8f71-e73da9b7dd4e	a9f3adcf-9339-44d1-8d8c-9209e8d6ad2c
2c8866c2-dc17-4b3e-8f71-e73da9b7dd4e	b44b4059-6d9a-450e-baf4-2a840dc1ebab
2c8866c2-dc17-4b3e-8f71-e73da9b7dd4e	97c51908-5745-4afd-aa2f-72894b4d7b65
2c8866c2-dc17-4b3e-8f71-e73da9b7dd4e	59ab6ba3-910f-4a92-88e6-cc088e40f074
2c8866c2-dc17-4b3e-8f71-e73da9b7dd4e	4de3a0db-ef40-4704-a81f-66ad0031d68c
2c8866c2-dc17-4b3e-8f71-e73da9b7dd4e	db51d919-16ea-4de9-aa77-e0a4689c4dad
2c8866c2-dc17-4b3e-8f71-e73da9b7dd4e	32a84c9f-3130-4fe0-bbdf-c9d3f4560648
2c8866c2-dc17-4b3e-8f71-e73da9b7dd4e	16cb6247-f06b-472f-a851-5bc25bbc792c
2c8866c2-dc17-4b3e-8f71-e73da9b7dd4e	d82e4d47-b6da-440d-9d6f-67d0d61bc8c3
2c8866c2-dc17-4b3e-8f71-e73da9b7dd4e	566dec0f-a5cb-4b15-8a64-34b446d3dfc6
277e2a8e-700c-4e9d-abb8-ad00dd53754b	32a84c9f-3130-4fe0-bbdf-c9d3f4560648
277e2a8e-700c-4e9d-abb8-ad00dd53754b	566dec0f-a5cb-4b15-8a64-34b446d3dfc6
a54d786c-e015-4cbd-b347-56d668decfd6	16cb6247-f06b-472f-a851-5bc25bbc792c
4d4edf02-eac6-4b62-995b-eba7c5e43838	d92960de-acbd-4ffc-9e97-b7c9cd64571d
4d4edf02-eac6-4b62-995b-eba7c5e43838	8aa5354a-ec06-411b-b85c-dc74fa1aa086
4d4edf02-eac6-4b62-995b-eba7c5e43838	e20c378a-3e97-41ac-8850-e8848245ae59
4d4edf02-eac6-4b62-995b-eba7c5e43838	aeaf646b-b9e8-4d60-9f3c-74cf1025b1d6
4d4edf02-eac6-4b62-995b-eba7c5e43838	de51d214-623d-467f-a7be-3b6b4eb2ef02
4d4edf02-eac6-4b62-995b-eba7c5e43838	588df1b6-5c8b-4192-aa5e-1d3cd936a91b
4d4edf02-eac6-4b62-995b-eba7c5e43838	b4a48979-0cea-4d47-b4cc-73f849c5521a
4d4edf02-eac6-4b62-995b-eba7c5e43838	bf97d717-fc22-4700-8e9d-01803cd5466d
4d4edf02-eac6-4b62-995b-eba7c5e43838	abf40e7d-e1ab-40be-9a83-a39295035ab3
4d4edf02-eac6-4b62-995b-eba7c5e43838	5d41ab30-f4e2-4c6a-beba-33c5ebb32ae6
4d4edf02-eac6-4b62-995b-eba7c5e43838	904fa713-1c63-42a9-9c8f-8f543ad9e108
4d4edf02-eac6-4b62-995b-eba7c5e43838	0f5871d8-f50a-45d4-b8e7-f76c97cd8b16
4d4edf02-eac6-4b62-995b-eba7c5e43838	d68d5df5-8124-490d-a020-c4c4e79cdcf5
4d4edf02-eac6-4b62-995b-eba7c5e43838	07d2e97e-7e6c-481b-bcb4-0e95075be1be
4d4edf02-eac6-4b62-995b-eba7c5e43838	ac00d5b3-9f1e-463a-b985-f8f7d584244a
4d4edf02-eac6-4b62-995b-eba7c5e43838	a5fb5837-6f0e-4426-831f-48a4e5b3ee15
4d4edf02-eac6-4b62-995b-eba7c5e43838	ab94c578-c0fe-4fd9-98bd-b6b4d9d84e11
0d4fb0db-d34f-428f-b286-be511c0d6395	cbcacbad-ff2b-4c1e-bb34-ec3a82b68bf5
aeaf646b-b9e8-4d60-9f3c-74cf1025b1d6	ac00d5b3-9f1e-463a-b985-f8f7d584244a
e20c378a-3e97-41ac-8850-e8848245ae59	07d2e97e-7e6c-481b-bcb4-0e95075be1be
e20c378a-3e97-41ac-8850-e8848245ae59	ab94c578-c0fe-4fd9-98bd-b6b4d9d84e11
0d4fb0db-d34f-428f-b286-be511c0d6395	ed04fe23-7f4c-4e30-87d3-efe7f50edf06
ed04fe23-7f4c-4e30-87d3-efe7f50edf06	efea978b-bd4b-46c1-95bd-6e33c956f97f
94df2060-f26b-4345-99c1-839650634073	bdd9ef43-0ede-4f04-81c1-e95582f5ca3b
2c8866c2-dc17-4b3e-8f71-e73da9b7dd4e	de8ddea2-7093-4692-b8be-96774cb881fb
4d4edf02-eac6-4b62-995b-eba7c5e43838	d647306e-23a8-4b91-9e0b-1c4637d73476
0d4fb0db-d34f-428f-b286-be511c0d6395	dfd13434-2081-49e8-a774-c5ee71b96ec5
0d4fb0db-d34f-428f-b286-be511c0d6395	884fa389-0f3d-469b-8283-dc7597a06577
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
0680ec7a-58b3-4139-b06f-11744de841e0	\N	password	2e99540b-145d-4f92-9ef4-fbe2a3a9e28c	1755016460065	\N	{"value":"7BYcjH/mxSsm5dZs+BIy4QBn02rQv/hzRegA0PhZ9u0=","salt":"lPuAFhZwCSDrtZqyZTeIRg==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
22276000-3225-434c-85c7-b766154d25e9	\N	password	d77c8420-723d-4785-bc2a-e8aca8a4a741	1755016647514	My password	{"value":"NKL50Fi+zkhApbrKcMhzafeopkDGsymzPYxJNFdQUNM=","salt":"8uueZ+p/1IyWVMDBBcbWag==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2025-08-12 16:34:14.572664	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.29.1	\N	\N	5016454302
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2025-08-12 16:34:14.582468	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.29.1	\N	\N	5016454302
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2025-08-12 16:34:14.619082	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.29.1	\N	\N	5016454302
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2025-08-12 16:34:14.622121	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	5016454302
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2025-08-12 16:34:14.690396	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.29.1	\N	\N	5016454302
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2025-08-12 16:34:14.693877	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.29.1	\N	\N	5016454302
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2025-08-12 16:34:14.751587	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.29.1	\N	\N	5016454302
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2025-08-12 16:34:14.75467	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.29.1	\N	\N	5016454302
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2025-08-12 16:34:14.75991	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.29.1	\N	\N	5016454302
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2025-08-12 16:34:14.82797	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.29.1	\N	\N	5016454302
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2025-08-12 16:34:14.857956	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	5016454302
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2025-08-12 16:34:14.860232	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	5016454302
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2025-08-12 16:34:14.875926	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	5016454302
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-08-12 16:34:14.886927	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.29.1	\N	\N	5016454302
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-08-12 16:34:14.887793	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	5016454302
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-08-12 16:34:14.889272	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.29.1	\N	\N	5016454302
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-08-12 16:34:14.891034	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.29.1	\N	\N	5016454302
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2025-08-12 16:34:14.915094	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.29.1	\N	\N	5016454302
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2025-08-12 16:34:14.939302	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.29.1	\N	\N	5016454302
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2025-08-12 16:34:14.943568	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.29.1	\N	\N	5016454302
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2025-08-12 16:34:14.944928	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.29.1	\N	\N	5016454302
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2025-08-12 16:34:14.94665	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.29.1	\N	\N	5016454302
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2025-08-12 16:34:14.999269	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.29.1	\N	\N	5016454302
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2025-08-12 16:34:15.003426	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.29.1	\N	\N	5016454302
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2025-08-12 16:34:15.004191	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.29.1	\N	\N	5016454302
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2025-08-12 16:34:15.263374	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.29.1	\N	\N	5016454302
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2025-08-12 16:34:15.299802	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.29.1	\N	\N	5016454302
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2025-08-12 16:34:15.302463	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.29.1	\N	\N	5016454302
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2025-08-12 16:34:15.333958	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.29.1	\N	\N	5016454302
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2025-08-12 16:34:15.342823	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.29.1	\N	\N	5016454302
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2025-08-12 16:34:15.354857	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.29.1	\N	\N	5016454302
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2025-08-12 16:34:15.359042	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.29.1	\N	\N	5016454302
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-08-12 16:34:15.363482	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	5016454302
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-08-12 16:34:15.365094	34	MARK_RAN	9:3a32bace77c84d7678d035a7f5a8084e	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.29.1	\N	\N	5016454302
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-08-12 16:34:15.38314	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.29.1	\N	\N	5016454302
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2025-08-12 16:34:15.387702	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.29.1	\N	\N	5016454302
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-08-12 16:34:15.391215	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	5016454302
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2025-08-12 16:34:15.393492	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.29.1	\N	\N	5016454302
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2025-08-12 16:34:15.395686	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.29.1	\N	\N	5016454302
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-08-12 16:34:15.396493	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.29.1	\N	\N	5016454302
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-08-12 16:34:15.397763	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.29.1	\N	\N	5016454302
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2025-08-12 16:34:15.401464	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.29.1	\N	\N	5016454302
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-08-12 16:34:16.438414	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.29.1	\N	\N	5016454302
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2025-08-12 16:34:16.442167	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.29.1	\N	\N	5016454302
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-08-12 16:34:16.444837	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.29.1	\N	\N	5016454302
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-08-12 16:34:16.450782	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.29.1	\N	\N	5016454302
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-08-12 16:34:16.451775	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.29.1	\N	\N	5016454302
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-08-12 16:34:16.536503	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.29.1	\N	\N	5016454302
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-08-12 16:34:16.539518	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.29.1	\N	\N	5016454302
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2025-08-12 16:34:16.559442	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.29.1	\N	\N	5016454302
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2025-08-12 16:34:16.799349	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.29.1	\N	\N	5016454302
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2025-08-12 16:34:16.802129	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	5016454302
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2025-08-12 16:34:16.804617	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.29.1	\N	\N	5016454302
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2025-08-12 16:34:16.806672	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.29.1	\N	\N	5016454302
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-08-12 16:34:16.810308	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.29.1	\N	\N	5016454302
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-08-12 16:34:16.813539	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.29.1	\N	\N	5016454302
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-08-12 16:34:16.844905	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.29.1	\N	\N	5016454302
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-08-12 16:34:17.133646	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.29.1	\N	\N	5016454302
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2025-08-12 16:34:17.152314	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.29.1	\N	\N	5016454302
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2025-08-12 16:34:17.156764	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.29.1	\N	\N	5016454302
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-08-12 16:34:17.16248	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.29.1	\N	\N	5016454302
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-08-12 16:34:17.164998	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.29.1	\N	\N	5016454302
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2025-08-12 16:34:17.166885	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.29.1	\N	\N	5016454302
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2025-08-12 16:34:17.168942	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.29.1	\N	\N	5016454302
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2025-08-12 16:34:17.171818	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.29.1	\N	\N	5016454302
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2025-08-12 16:34:17.200145	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.29.1	\N	\N	5016454302
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2025-08-12 16:34:17.222971	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.29.1	\N	\N	5016454302
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2025-08-12 16:34:17.226304	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.29.1	\N	\N	5016454302
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2025-08-12 16:34:17.258692	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.29.1	\N	\N	5016454302
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2025-08-12 16:34:17.262525	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.29.1	\N	\N	5016454302
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2025-08-12 16:34:17.265167	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.29.1	\N	\N	5016454302
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-08-12 16:34:17.270029	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	5016454302
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-08-12 16:34:17.275419	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	5016454302
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-08-12 16:34:17.276604	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	5016454302
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-08-12 16:34:17.291057	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.29.1	\N	\N	5016454302
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-08-12 16:34:17.324923	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.29.1	\N	\N	5016454302
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-08-12 16:34:17.327938	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.29.1	\N	\N	5016454302
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-08-12 16:34:17.328903	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.29.1	\N	\N	5016454302
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-08-12 16:34:17.33918	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.29.1	\N	\N	5016454302
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-08-12 16:34:17.340302	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.29.1	\N	\N	5016454302
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-08-12 16:34:17.37019	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.29.1	\N	\N	5016454302
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-08-12 16:34:17.371536	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	5016454302
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-08-12 16:34:17.374827	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	5016454302
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-08-12 16:34:17.375658	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	5016454302
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-08-12 16:34:17.398467	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	5016454302
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2025-08-12 16:34:17.401056	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.29.1	\N	\N	5016454302
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-08-12 16:34:17.40507	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.29.1	\N	\N	5016454302
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-08-12 16:34:17.409646	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.29.1	\N	\N	5016454302
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-08-12 16:34:17.413501	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.29.1	\N	\N	5016454302
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-08-12 16:34:17.417725	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.29.1	\N	\N	5016454302
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-08-12 16:34:17.450107	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	5016454302
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-08-12 16:34:17.454425	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.29.1	\N	\N	5016454302
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-08-12 16:34:17.455337	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.29.1	\N	\N	5016454302
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-08-12 16:34:17.459539	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.29.1	\N	\N	5016454302
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-08-12 16:34:17.460784	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.29.1	\N	\N	5016454302
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-08-12 16:34:17.464995	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.29.1	\N	\N	5016454302
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-08-12 16:34:17.536358	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	5016454302
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-08-12 16:34:17.537394	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	5016454302
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-08-12 16:34:17.554863	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	5016454302
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-08-12 16:34:17.587737	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	5016454302
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-08-12 16:34:17.589472	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	5016454302
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-08-12 16:34:17.617036	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.29.1	\N	\N	5016454302
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-08-12 16:34:17.621434	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.29.1	\N	\N	5016454302
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2025-08-12 16:34:17.631286	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.29.1	\N	\N	5016454302
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2025-08-12 16:34:17.663504	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.29.1	\N	\N	5016454302
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2025-08-12 16:34:17.694572	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.29.1	\N	\N	5016454302
18.0.15-30992-index-consent	keycloak	META-INF/jpa-changelog-18.0.15.xml	2025-08-12 16:34:17.744113	107	EXECUTED	9:80071ede7a05604b1f4906f3bf3b00f0	createIndex indexName=IDX_USCONSENT_SCOPE_ID, tableName=USER_CONSENT_CLIENT_SCOPE		\N	4.29.1	\N	\N	5016454302
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2025-08-12 16:34:17.747459	108	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.29.1	\N	\N	5016454302
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-08-12 16:34:17.773115	109	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.29.1	\N	\N	5016454302
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-08-12 16:34:17.774345	110	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.29.1	\N	\N	5016454302
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-08-12 16:34:17.778752	111	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	5016454302
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2025-08-12 16:34:17.781484	112	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.29.1	\N	\N	5016454302
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2025-08-12 16:34:17.793889	113	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.29.1	\N	\N	5016454302
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2025-08-12 16:34:17.79589	114	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.29.1	\N	\N	5016454302
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2025-08-12 16:34:17.799406	115	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.29.1	\N	\N	5016454302
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2025-08-12 16:34:17.80026	116	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.29.1	\N	\N	5016454302
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2025-08-12 16:34:17.804121	117	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.29.1	\N	\N	5016454302
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2025-08-12 16:34:17.806003	118	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	5016454302
24.0.0-9758	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-08-12 16:34:17.918944	119	EXECUTED	9:502c557a5189f600f0f445a9b49ebbce	addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...		\N	4.29.1	\N	\N	5016454302
24.0.0-9758-2	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-08-12 16:34:17.922702	120	EXECUTED	9:bf0fdee10afdf597a987adbf291db7b2	customChange		\N	4.29.1	\N	\N	5016454302
24.0.0-26618-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-08-12 16:34:17.925784	121	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	5016454302
24.0.0-26618-reindex	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-08-12 16:34:17.95707	122	EXECUTED	9:08707c0f0db1cef6b352db03a60edc7f	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	5016454302
24.0.2-27228	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-08-12 16:34:17.963077	123	EXECUTED	9:eaee11f6b8aa25d2cc6a84fb86fc6238	customChange		\N	4.29.1	\N	\N	5016454302
24.0.2-27967-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-08-12 16:34:17.964077	124	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	5016454302
24.0.2-27967-reindex	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-08-12 16:34:17.965482	125	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	5016454302
25.0.0-28265-tables	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-12 16:34:17.969778	126	EXECUTED	9:deda2df035df23388af95bbd36c17cef	addColumn tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	5016454302
25.0.0-28265-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-12 16:34:17.997253	127	EXECUTED	9:3e96709818458ae49f3c679ae58d263a	createIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	5016454302
25.0.0-28265-index-cleanup-uss-createdon	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-12 16:34:18.044279	128	EXECUTED	9:78ab4fc129ed5e8265dbcc3485fba92f	dropIndex indexName=IDX_OFFLINE_USS_CREATEDON, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	5016454302
25.0.0-28265-index-cleanup-uss-preload	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-12 16:34:18.071672	129	EXECUTED	9:de5f7c1f7e10994ed8b62e621d20eaab	dropIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	5016454302
25.0.0-28265-index-cleanup-uss-by-usersess	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-12 16:34:18.101668	130	EXECUTED	9:6eee220d024e38e89c799417ec33667f	dropIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	5016454302
25.0.0-28265-index-cleanup-css-preload	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-12 16:34:18.129691	131	EXECUTED	9:5411d2fb2891d3e8d63ddb55dfa3c0c9	dropIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	5016454302
25.0.0-28265-index-2-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-12 16:34:18.131029	132	MARK_RAN	9:b7ef76036d3126bb83c2423bf4d449d6	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	5016454302
25.0.0-28265-index-2-not-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-12 16:34:18.16154	133	EXECUTED	9:23396cf51ab8bc1ae6f0cac7f9f6fcf7	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	5016454302
25.0.0-org	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-12 16:34:18.172027	134	EXECUTED	9:5c859965c2c9b9c72136c360649af157	createTable tableName=ORG; addUniqueConstraint constraintName=UK_ORG_NAME, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_GROUP, tableName=ORG; createTable tableName=ORG_DOMAIN		\N	4.29.1	\N	\N	5016454302
unique-consentuser	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-12 16:34:18.179957	135	EXECUTED	9:5857626a2ea8767e9a6c66bf3a2cb32f	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.29.1	\N	\N	5016454302
unique-consentuser-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-12 16:34:18.181094	136	MARK_RAN	9:b79478aad5adaa1bc428e31563f55e8e	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.29.1	\N	\N	5016454302
25.0.0-28861-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-12 16:34:18.234495	137	EXECUTED	9:b9acb58ac958d9ada0fe12a5d4794ab1	createIndex indexName=IDX_PERM_TICKET_REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; createIndex indexName=IDX_PERM_TICKET_OWNER, tableName=RESOURCE_SERVER_PERM_TICKET		\N	4.29.1	\N	\N	5016454302
26.0.0-org-alias	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-08-12 16:34:18.239149	138	EXECUTED	9:6ef7d63e4412b3c2d66ed179159886a4	addColumn tableName=ORG; update tableName=ORG; addNotNullConstraint columnName=ALIAS, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_ALIAS, tableName=ORG		\N	4.29.1	\N	\N	5016454302
26.0.0-org-group	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-08-12 16:34:18.24372	139	EXECUTED	9:da8e8087d80ef2ace4f89d8c5b9ca223	addColumn tableName=KEYCLOAK_GROUP; update tableName=KEYCLOAK_GROUP; addNotNullConstraint columnName=TYPE, tableName=KEYCLOAK_GROUP; customChange		\N	4.29.1	\N	\N	5016454302
26.0.0-org-indexes	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-08-12 16:34:18.273629	140	EXECUTED	9:79b05dcd610a8c7f25ec05135eec0857	createIndex indexName=IDX_ORG_DOMAIN_ORG_ID, tableName=ORG_DOMAIN		\N	4.29.1	\N	\N	5016454302
26.0.0-org-group-membership	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-08-12 16:34:18.277064	141	EXECUTED	9:a6ace2ce583a421d89b01ba2a28dc2d4	addColumn tableName=USER_GROUP_MEMBERSHIP; update tableName=USER_GROUP_MEMBERSHIP; addNotNullConstraint columnName=MEMBERSHIP_TYPE, tableName=USER_GROUP_MEMBERSHIP		\N	4.29.1	\N	\N	5016454302
31296-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-08-12 16:34:18.280348	142	EXECUTED	9:64ef94489d42a358e8304b0e245f0ed4	createTable tableName=REVOKED_TOKEN; addPrimaryKey constraintName=CONSTRAINT_RT, tableName=REVOKED_TOKEN		\N	4.29.1	\N	\N	5016454302
31725-index-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-08-12 16:34:18.310178	143	EXECUTED	9:b994246ec2bf7c94da881e1d28782c7b	createIndex indexName=IDX_REV_TOKEN_ON_EXPIRE, tableName=REVOKED_TOKEN		\N	4.29.1	\N	\N	5016454302
26.0.0-idps-for-login	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-08-12 16:34:18.36144	144	EXECUTED	9:51f5fffadf986983d4bd59582c6c1604	addColumn tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_REALM_ORG, tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_FOR_LOGIN, tableName=IDENTITY_PROVIDER; customChange		\N	4.29.1	\N	\N	5016454302
26.0.0-32583-drop-redundant-index-on-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-08-12 16:34:18.385865	145	EXECUTED	9:24972d83bf27317a055d234187bb4af9	dropIndex indexName=IDX_US_SESS_ID_ON_CL_SESS, tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	5016454302
26.0.0.32582-remove-tables-user-session-user-session-note-and-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-08-12 16:34:18.399398	146	EXECUTED	9:febdc0f47f2ed241c59e60f58c3ceea5	dropTable tableName=CLIENT_SESSION_ROLE; dropTable tableName=CLIENT_SESSION_NOTE; dropTable tableName=CLIENT_SESSION_PROT_MAPPER; dropTable tableName=CLIENT_SESSION_AUTH_STATUS; dropTable tableName=CLIENT_USER_SESSION_NOTE; dropTable tableName=CLI...		\N	4.29.1	\N	\N	5016454302
26.0.0-33201-org-redirect-url	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-08-12 16:34:18.401364	147	EXECUTED	9:4d0e22b0ac68ebe9794fa9cb752ea660	addColumn tableName=ORG		\N	4.29.1	\N	\N	5016454302
29399-jdbc-ping-default	keycloak	META-INF/jpa-changelog-26.1.0.xml	2025-08-12 16:34:18.406386	148	EXECUTED	9:007dbe99d7203fca403b89d4edfdf21e	createTable tableName=JGROUPS_PING; addPrimaryKey constraintName=CONSTRAINT_JGROUPS_PING, tableName=JGROUPS_PING		\N	4.29.1	\N	\N	5016454302
26.1.0-34013	keycloak	META-INF/jpa-changelog-26.1.0.xml	2025-08-12 16:34:18.413745	149	EXECUTED	9:e6b686a15759aef99a6d758a5c4c6a26	addColumn tableName=ADMIN_EVENT_ENTITY		\N	4.29.1	\N	\N	5016454302
26.1.0-34380	keycloak	META-INF/jpa-changelog-26.1.0.xml	2025-08-12 16:34:18.416888	150	EXECUTED	9:ac8b9edb7c2b6c17a1c7a11fcf5ccf01	dropTable tableName=USERNAME_LOGIN_FAILURE		\N	4.29.1	\N	\N	5016454302
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
d173fb4f-af6c-4c50-bd78-301237d5f821	d1f2fa14-2f81-4487-946e-076068441946	f
d173fb4f-af6c-4c50-bd78-301237d5f821	3c2a4942-8476-4044-9eb4-d0f62f515aab	t
d173fb4f-af6c-4c50-bd78-301237d5f821	95b2d39b-5aa5-4ace-9418-cc7af550a3c6	t
d173fb4f-af6c-4c50-bd78-301237d5f821	d899830f-5e51-48b2-ba3d-ad58e4f8c69d	t
d173fb4f-af6c-4c50-bd78-301237d5f821	7547d42e-d172-4463-bae8-71b882e3b1ca	t
d173fb4f-af6c-4c50-bd78-301237d5f821	ad1b25c8-bff8-41fe-aba4-286af672c64f	f
d173fb4f-af6c-4c50-bd78-301237d5f821	e1423732-12cd-4b83-b339-f1e38f03df5d	f
d173fb4f-af6c-4c50-bd78-301237d5f821	2a638ed3-b5bb-409c-a112-e13bff69c33f	t
d173fb4f-af6c-4c50-bd78-301237d5f821	08cc2e81-7d54-45e8-be80-ed80013fb686	t
d173fb4f-af6c-4c50-bd78-301237d5f821	cf78551b-6051-4128-a3da-940eccbe08c6	f
d173fb4f-af6c-4c50-bd78-301237d5f821	08c0e400-285f-495b-9895-b8dcc97aa7c8	t
d173fb4f-af6c-4c50-bd78-301237d5f821	faf64e1f-0738-4686-ab97-1be9898c177b	t
d173fb4f-af6c-4c50-bd78-301237d5f821	fd4cee54-2846-4e8f-9607-0abb410d4cb8	f
59e3dfd1-7985-4568-9573-4084337fc1d1	3f9f4854-6bb1-43f3-aac6-9c0685ff042c	f
59e3dfd1-7985-4568-9573-4084337fc1d1	274fbafb-7e29-4834-a9b5-3469cfde7ad5	t
59e3dfd1-7985-4568-9573-4084337fc1d1	b793744b-f5ff-477d-976f-61d8ba2ebb5d	t
59e3dfd1-7985-4568-9573-4084337fc1d1	5e2b6eda-8009-4a08-9e99-92bf4cf5980c	t
59e3dfd1-7985-4568-9573-4084337fc1d1	3f13e525-d348-4787-80af-9256386f4670	t
59e3dfd1-7985-4568-9573-4084337fc1d1	d2ee2a14-7e55-4c28-9dad-21065c9d27be	f
59e3dfd1-7985-4568-9573-4084337fc1d1	02c90be0-1dd3-42b7-8c14-24d8b196bd9e	f
59e3dfd1-7985-4568-9573-4084337fc1d1	7cb3f141-f297-4261-b891-68c93b24a563	t
59e3dfd1-7985-4568-9573-4084337fc1d1	2dba8ad0-29cb-4e27-ae6b-e67854ac19c6	t
59e3dfd1-7985-4568-9573-4084337fc1d1	0689b937-49e7-460f-b544-0be503611a49	f
59e3dfd1-7985-4568-9573-4084337fc1d1	cc7d193a-1e69-4ca2-9266-79ab8a8b2124	t
59e3dfd1-7985-4568-9573-4084337fc1d1	13f07e3d-3bab-4476-96ec-b4333ded9400	t
59e3dfd1-7985-4568-9573-4084337fc1d1	914ed35b-5b06-45c0-a147-5b1421d67457	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id, details_json_long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only, organization_id, hide_on_login) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: ingredient; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.ingredient (id, created_at, created_by, last_modified_at, last_modified_by, ingredient_order, text, recipe_id) FROM stdin;
\.


--
-- Data for Name: jgroups_ping; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.jgroups_ping (address, name, cluster_name, ip, coord) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.keycloak_group (id, name, parent_group, realm_id, type) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
34492721-3f11-40ca-86e8-2b48b6c7c7e0	d173fb4f-af6c-4c50-bd78-301237d5f821	f	${role_default-roles}	default-roles-master	d173fb4f-af6c-4c50-bd78-301237d5f821	\N	\N
2c8866c2-dc17-4b3e-8f71-e73da9b7dd4e	d173fb4f-af6c-4c50-bd78-301237d5f821	f	${role_admin}	admin	d173fb4f-af6c-4c50-bd78-301237d5f821	\N	\N
5b8b4356-668e-4b7e-970f-0ebc613d7b15	d173fb4f-af6c-4c50-bd78-301237d5f821	f	${role_create-realm}	create-realm	d173fb4f-af6c-4c50-bd78-301237d5f821	\N	\N
e7fe8671-d16d-47db-aa5a-d15490dcfcaa	2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	t	${role_create-client}	create-client	d173fb4f-af6c-4c50-bd78-301237d5f821	2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	\N
c36fb424-2a43-41be-b817-4e0fc37f48fb	2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	t	${role_view-realm}	view-realm	d173fb4f-af6c-4c50-bd78-301237d5f821	2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	\N
9fbd2182-7094-4f6e-84ab-d86a581a2107	2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	t	${role_view-users}	view-users	d173fb4f-af6c-4c50-bd78-301237d5f821	2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	\N
e513e41c-1d30-4c56-8c4b-88debc0ca14b	2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	t	${role_view-clients}	view-clients	d173fb4f-af6c-4c50-bd78-301237d5f821	2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	\N
7e45110c-8951-4e50-a843-d8251358af6b	2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	t	${role_view-events}	view-events	d173fb4f-af6c-4c50-bd78-301237d5f821	2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	\N
09367a58-c69e-4bf8-b0ae-6f3cf06f9d0d	2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	t	${role_view-identity-providers}	view-identity-providers	d173fb4f-af6c-4c50-bd78-301237d5f821	2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	\N
035fc9a7-9653-4575-96f6-80d3a48cada8	2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	t	${role_view-authorization}	view-authorization	d173fb4f-af6c-4c50-bd78-301237d5f821	2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	\N
81920680-564b-4d2d-b7dc-1ae668660e86	2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	t	${role_manage-realm}	manage-realm	d173fb4f-af6c-4c50-bd78-301237d5f821	2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	\N
fd404a5a-9a64-4eab-9e97-c29b53ff23dd	2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	t	${role_manage-users}	manage-users	d173fb4f-af6c-4c50-bd78-301237d5f821	2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	\N
58bc8f42-5b90-4b74-a75d-07c1d438b550	2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	t	${role_manage-clients}	manage-clients	d173fb4f-af6c-4c50-bd78-301237d5f821	2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	\N
b8f04bf9-9717-4ac5-8231-dfa5b45b90b3	2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	t	${role_manage-events}	manage-events	d173fb4f-af6c-4c50-bd78-301237d5f821	2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	\N
9888682c-42bb-4e14-ae7b-671a09ab8503	2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	t	${role_manage-identity-providers}	manage-identity-providers	d173fb4f-af6c-4c50-bd78-301237d5f821	2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	\N
1be6791f-fff1-4ff5-bf81-c4b0103205e1	2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	t	${role_manage-authorization}	manage-authorization	d173fb4f-af6c-4c50-bd78-301237d5f821	2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	\N
dd485959-82e6-4d13-abc3-e5b8af469757	2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	t	${role_query-users}	query-users	d173fb4f-af6c-4c50-bd78-301237d5f821	2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	\N
ab62cbe2-580c-4fc2-83ec-d7e91509222a	2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	t	${role_query-clients}	query-clients	d173fb4f-af6c-4c50-bd78-301237d5f821	2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	\N
6dcbf057-624a-49d4-a839-d47298835b7a	2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	t	${role_query-realms}	query-realms	d173fb4f-af6c-4c50-bd78-301237d5f821	2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	\N
3fd922fb-1b6d-4d6c-ad24-e828024b4178	2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	t	${role_query-groups}	query-groups	d173fb4f-af6c-4c50-bd78-301237d5f821	2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	\N
f747f6bc-a5ab-422e-bd45-eaf0934344a0	592457f4-a68f-45f3-afaf-0654dbe57d2e	t	${role_view-profile}	view-profile	d173fb4f-af6c-4c50-bd78-301237d5f821	592457f4-a68f-45f3-afaf-0654dbe57d2e	\N
1067c0ba-f341-4ef7-b6f1-0f684ae54341	592457f4-a68f-45f3-afaf-0654dbe57d2e	t	${role_manage-account}	manage-account	d173fb4f-af6c-4c50-bd78-301237d5f821	592457f4-a68f-45f3-afaf-0654dbe57d2e	\N
958c4f4a-d33c-4013-a0f7-29de108f4c3b	592457f4-a68f-45f3-afaf-0654dbe57d2e	t	${role_manage-account-links}	manage-account-links	d173fb4f-af6c-4c50-bd78-301237d5f821	592457f4-a68f-45f3-afaf-0654dbe57d2e	\N
ebd0ebe3-19d1-475e-a563-64fb4bc90eae	592457f4-a68f-45f3-afaf-0654dbe57d2e	t	${role_view-applications}	view-applications	d173fb4f-af6c-4c50-bd78-301237d5f821	592457f4-a68f-45f3-afaf-0654dbe57d2e	\N
ad20eb54-88ed-4771-bb9a-bf86d3edc045	592457f4-a68f-45f3-afaf-0654dbe57d2e	t	${role_view-consent}	view-consent	d173fb4f-af6c-4c50-bd78-301237d5f821	592457f4-a68f-45f3-afaf-0654dbe57d2e	\N
df9c6a74-d057-4bd2-acca-d0b150224939	592457f4-a68f-45f3-afaf-0654dbe57d2e	t	${role_manage-consent}	manage-consent	d173fb4f-af6c-4c50-bd78-301237d5f821	592457f4-a68f-45f3-afaf-0654dbe57d2e	\N
33d02ac0-7eb7-482f-8eb1-c8f366bb051e	592457f4-a68f-45f3-afaf-0654dbe57d2e	t	${role_view-groups}	view-groups	d173fb4f-af6c-4c50-bd78-301237d5f821	592457f4-a68f-45f3-afaf-0654dbe57d2e	\N
f09e1c67-c695-41d5-bc9b-04b04cdd7800	592457f4-a68f-45f3-afaf-0654dbe57d2e	t	${role_delete-account}	delete-account	d173fb4f-af6c-4c50-bd78-301237d5f821	592457f4-a68f-45f3-afaf-0654dbe57d2e	\N
f5d6b08b-b395-4029-b8ee-a4f019b63c76	21a46612-c085-41c9-88ef-b65b41523fed	t	${role_read-token}	read-token	d173fb4f-af6c-4c50-bd78-301237d5f821	21a46612-c085-41c9-88ef-b65b41523fed	\N
06fd2128-277d-40da-a127-56513996273f	2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	t	${role_impersonation}	impersonation	d173fb4f-af6c-4c50-bd78-301237d5f821	2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	\N
c6fbf5e4-ff9f-4f5c-bb7f-9f8bb5a087a0	d173fb4f-af6c-4c50-bd78-301237d5f821	f	${role_offline-access}	offline_access	d173fb4f-af6c-4c50-bd78-301237d5f821	\N	\N
b0bfb301-dc6a-4574-a8fa-f749f6e35739	d173fb4f-af6c-4c50-bd78-301237d5f821	f	${role_uma_authorization}	uma_authorization	d173fb4f-af6c-4c50-bd78-301237d5f821	\N	\N
0d4fb0db-d34f-428f-b286-be511c0d6395	59e3dfd1-7985-4568-9573-4084337fc1d1	f	${role_default-roles}	default-roles-mealwurm	59e3dfd1-7985-4568-9573-4084337fc1d1	\N	\N
237eaf24-3a4f-453c-9db7-97efd9dadce4	91186b3f-f806-4cb0-a766-a2d142007df0	t	${role_create-client}	create-client	d173fb4f-af6c-4c50-bd78-301237d5f821	91186b3f-f806-4cb0-a766-a2d142007df0	\N
78f4d451-3207-4d1c-b22e-e72c4c4935bf	91186b3f-f806-4cb0-a766-a2d142007df0	t	${role_view-realm}	view-realm	d173fb4f-af6c-4c50-bd78-301237d5f821	91186b3f-f806-4cb0-a766-a2d142007df0	\N
277e2a8e-700c-4e9d-abb8-ad00dd53754b	91186b3f-f806-4cb0-a766-a2d142007df0	t	${role_view-users}	view-users	d173fb4f-af6c-4c50-bd78-301237d5f821	91186b3f-f806-4cb0-a766-a2d142007df0	\N
a54d786c-e015-4cbd-b347-56d668decfd6	91186b3f-f806-4cb0-a766-a2d142007df0	t	${role_view-clients}	view-clients	d173fb4f-af6c-4c50-bd78-301237d5f821	91186b3f-f806-4cb0-a766-a2d142007df0	\N
28eb405b-76be-4bfc-b4bf-684fa8f486ae	91186b3f-f806-4cb0-a766-a2d142007df0	t	${role_view-events}	view-events	d173fb4f-af6c-4c50-bd78-301237d5f821	91186b3f-f806-4cb0-a766-a2d142007df0	\N
de8903de-017c-433a-92af-f4fac7c23df7	91186b3f-f806-4cb0-a766-a2d142007df0	t	${role_view-identity-providers}	view-identity-providers	d173fb4f-af6c-4c50-bd78-301237d5f821	91186b3f-f806-4cb0-a766-a2d142007df0	\N
ebd811a3-0a2c-4094-919d-40b104150611	91186b3f-f806-4cb0-a766-a2d142007df0	t	${role_view-authorization}	view-authorization	d173fb4f-af6c-4c50-bd78-301237d5f821	91186b3f-f806-4cb0-a766-a2d142007df0	\N
a9f3adcf-9339-44d1-8d8c-9209e8d6ad2c	91186b3f-f806-4cb0-a766-a2d142007df0	t	${role_manage-realm}	manage-realm	d173fb4f-af6c-4c50-bd78-301237d5f821	91186b3f-f806-4cb0-a766-a2d142007df0	\N
b44b4059-6d9a-450e-baf4-2a840dc1ebab	91186b3f-f806-4cb0-a766-a2d142007df0	t	${role_manage-users}	manage-users	d173fb4f-af6c-4c50-bd78-301237d5f821	91186b3f-f806-4cb0-a766-a2d142007df0	\N
97c51908-5745-4afd-aa2f-72894b4d7b65	91186b3f-f806-4cb0-a766-a2d142007df0	t	${role_manage-clients}	manage-clients	d173fb4f-af6c-4c50-bd78-301237d5f821	91186b3f-f806-4cb0-a766-a2d142007df0	\N
59ab6ba3-910f-4a92-88e6-cc088e40f074	91186b3f-f806-4cb0-a766-a2d142007df0	t	${role_manage-events}	manage-events	d173fb4f-af6c-4c50-bd78-301237d5f821	91186b3f-f806-4cb0-a766-a2d142007df0	\N
4de3a0db-ef40-4704-a81f-66ad0031d68c	91186b3f-f806-4cb0-a766-a2d142007df0	t	${role_manage-identity-providers}	manage-identity-providers	d173fb4f-af6c-4c50-bd78-301237d5f821	91186b3f-f806-4cb0-a766-a2d142007df0	\N
db51d919-16ea-4de9-aa77-e0a4689c4dad	91186b3f-f806-4cb0-a766-a2d142007df0	t	${role_manage-authorization}	manage-authorization	d173fb4f-af6c-4c50-bd78-301237d5f821	91186b3f-f806-4cb0-a766-a2d142007df0	\N
32a84c9f-3130-4fe0-bbdf-c9d3f4560648	91186b3f-f806-4cb0-a766-a2d142007df0	t	${role_query-users}	query-users	d173fb4f-af6c-4c50-bd78-301237d5f821	91186b3f-f806-4cb0-a766-a2d142007df0	\N
16cb6247-f06b-472f-a851-5bc25bbc792c	91186b3f-f806-4cb0-a766-a2d142007df0	t	${role_query-clients}	query-clients	d173fb4f-af6c-4c50-bd78-301237d5f821	91186b3f-f806-4cb0-a766-a2d142007df0	\N
d82e4d47-b6da-440d-9d6f-67d0d61bc8c3	91186b3f-f806-4cb0-a766-a2d142007df0	t	${role_query-realms}	query-realms	d173fb4f-af6c-4c50-bd78-301237d5f821	91186b3f-f806-4cb0-a766-a2d142007df0	\N
566dec0f-a5cb-4b15-8a64-34b446d3dfc6	91186b3f-f806-4cb0-a766-a2d142007df0	t	${role_query-groups}	query-groups	d173fb4f-af6c-4c50-bd78-301237d5f821	91186b3f-f806-4cb0-a766-a2d142007df0	\N
4d4edf02-eac6-4b62-995b-eba7c5e43838	73709d32-73c9-48b5-bdcd-c1838f679a64	t	${role_realm-admin}	realm-admin	59e3dfd1-7985-4568-9573-4084337fc1d1	73709d32-73c9-48b5-bdcd-c1838f679a64	\N
d92960de-acbd-4ffc-9e97-b7c9cd64571d	73709d32-73c9-48b5-bdcd-c1838f679a64	t	${role_create-client}	create-client	59e3dfd1-7985-4568-9573-4084337fc1d1	73709d32-73c9-48b5-bdcd-c1838f679a64	\N
8aa5354a-ec06-411b-b85c-dc74fa1aa086	73709d32-73c9-48b5-bdcd-c1838f679a64	t	${role_view-realm}	view-realm	59e3dfd1-7985-4568-9573-4084337fc1d1	73709d32-73c9-48b5-bdcd-c1838f679a64	\N
e20c378a-3e97-41ac-8850-e8848245ae59	73709d32-73c9-48b5-bdcd-c1838f679a64	t	${role_view-users}	view-users	59e3dfd1-7985-4568-9573-4084337fc1d1	73709d32-73c9-48b5-bdcd-c1838f679a64	\N
aeaf646b-b9e8-4d60-9f3c-74cf1025b1d6	73709d32-73c9-48b5-bdcd-c1838f679a64	t	${role_view-clients}	view-clients	59e3dfd1-7985-4568-9573-4084337fc1d1	73709d32-73c9-48b5-bdcd-c1838f679a64	\N
de51d214-623d-467f-a7be-3b6b4eb2ef02	73709d32-73c9-48b5-bdcd-c1838f679a64	t	${role_view-events}	view-events	59e3dfd1-7985-4568-9573-4084337fc1d1	73709d32-73c9-48b5-bdcd-c1838f679a64	\N
588df1b6-5c8b-4192-aa5e-1d3cd936a91b	73709d32-73c9-48b5-bdcd-c1838f679a64	t	${role_view-identity-providers}	view-identity-providers	59e3dfd1-7985-4568-9573-4084337fc1d1	73709d32-73c9-48b5-bdcd-c1838f679a64	\N
b4a48979-0cea-4d47-b4cc-73f849c5521a	73709d32-73c9-48b5-bdcd-c1838f679a64	t	${role_view-authorization}	view-authorization	59e3dfd1-7985-4568-9573-4084337fc1d1	73709d32-73c9-48b5-bdcd-c1838f679a64	\N
bf97d717-fc22-4700-8e9d-01803cd5466d	73709d32-73c9-48b5-bdcd-c1838f679a64	t	${role_manage-realm}	manage-realm	59e3dfd1-7985-4568-9573-4084337fc1d1	73709d32-73c9-48b5-bdcd-c1838f679a64	\N
abf40e7d-e1ab-40be-9a83-a39295035ab3	73709d32-73c9-48b5-bdcd-c1838f679a64	t	${role_manage-users}	manage-users	59e3dfd1-7985-4568-9573-4084337fc1d1	73709d32-73c9-48b5-bdcd-c1838f679a64	\N
5d41ab30-f4e2-4c6a-beba-33c5ebb32ae6	73709d32-73c9-48b5-bdcd-c1838f679a64	t	${role_manage-clients}	manage-clients	59e3dfd1-7985-4568-9573-4084337fc1d1	73709d32-73c9-48b5-bdcd-c1838f679a64	\N
904fa713-1c63-42a9-9c8f-8f543ad9e108	73709d32-73c9-48b5-bdcd-c1838f679a64	t	${role_manage-events}	manage-events	59e3dfd1-7985-4568-9573-4084337fc1d1	73709d32-73c9-48b5-bdcd-c1838f679a64	\N
0f5871d8-f50a-45d4-b8e7-f76c97cd8b16	73709d32-73c9-48b5-bdcd-c1838f679a64	t	${role_manage-identity-providers}	manage-identity-providers	59e3dfd1-7985-4568-9573-4084337fc1d1	73709d32-73c9-48b5-bdcd-c1838f679a64	\N
d68d5df5-8124-490d-a020-c4c4e79cdcf5	73709d32-73c9-48b5-bdcd-c1838f679a64	t	${role_manage-authorization}	manage-authorization	59e3dfd1-7985-4568-9573-4084337fc1d1	73709d32-73c9-48b5-bdcd-c1838f679a64	\N
07d2e97e-7e6c-481b-bcb4-0e95075be1be	73709d32-73c9-48b5-bdcd-c1838f679a64	t	${role_query-users}	query-users	59e3dfd1-7985-4568-9573-4084337fc1d1	73709d32-73c9-48b5-bdcd-c1838f679a64	\N
ac00d5b3-9f1e-463a-b985-f8f7d584244a	73709d32-73c9-48b5-bdcd-c1838f679a64	t	${role_query-clients}	query-clients	59e3dfd1-7985-4568-9573-4084337fc1d1	73709d32-73c9-48b5-bdcd-c1838f679a64	\N
a5fb5837-6f0e-4426-831f-48a4e5b3ee15	73709d32-73c9-48b5-bdcd-c1838f679a64	t	${role_query-realms}	query-realms	59e3dfd1-7985-4568-9573-4084337fc1d1	73709d32-73c9-48b5-bdcd-c1838f679a64	\N
ab94c578-c0fe-4fd9-98bd-b6b4d9d84e11	73709d32-73c9-48b5-bdcd-c1838f679a64	t	${role_query-groups}	query-groups	59e3dfd1-7985-4568-9573-4084337fc1d1	73709d32-73c9-48b5-bdcd-c1838f679a64	\N
cbcacbad-ff2b-4c1e-bb34-ec3a82b68bf5	f1cf0338-5613-46d5-ae30-182027f6c52a	t	${role_view-profile}	view-profile	59e3dfd1-7985-4568-9573-4084337fc1d1	f1cf0338-5613-46d5-ae30-182027f6c52a	\N
ed04fe23-7f4c-4e30-87d3-efe7f50edf06	f1cf0338-5613-46d5-ae30-182027f6c52a	t	${role_manage-account}	manage-account	59e3dfd1-7985-4568-9573-4084337fc1d1	f1cf0338-5613-46d5-ae30-182027f6c52a	\N
efea978b-bd4b-46c1-95bd-6e33c956f97f	f1cf0338-5613-46d5-ae30-182027f6c52a	t	${role_manage-account-links}	manage-account-links	59e3dfd1-7985-4568-9573-4084337fc1d1	f1cf0338-5613-46d5-ae30-182027f6c52a	\N
addcdb4b-b5c8-45ff-8938-8048723ea9d7	f1cf0338-5613-46d5-ae30-182027f6c52a	t	${role_view-applications}	view-applications	59e3dfd1-7985-4568-9573-4084337fc1d1	f1cf0338-5613-46d5-ae30-182027f6c52a	\N
bdd9ef43-0ede-4f04-81c1-e95582f5ca3b	f1cf0338-5613-46d5-ae30-182027f6c52a	t	${role_view-consent}	view-consent	59e3dfd1-7985-4568-9573-4084337fc1d1	f1cf0338-5613-46d5-ae30-182027f6c52a	\N
94df2060-f26b-4345-99c1-839650634073	f1cf0338-5613-46d5-ae30-182027f6c52a	t	${role_manage-consent}	manage-consent	59e3dfd1-7985-4568-9573-4084337fc1d1	f1cf0338-5613-46d5-ae30-182027f6c52a	\N
9ba4b112-8e0b-420a-8b80-3ce4fc33439c	f1cf0338-5613-46d5-ae30-182027f6c52a	t	${role_view-groups}	view-groups	59e3dfd1-7985-4568-9573-4084337fc1d1	f1cf0338-5613-46d5-ae30-182027f6c52a	\N
ae5f5ee8-fda9-462f-b0c2-3df441a875ab	f1cf0338-5613-46d5-ae30-182027f6c52a	t	${role_delete-account}	delete-account	59e3dfd1-7985-4568-9573-4084337fc1d1	f1cf0338-5613-46d5-ae30-182027f6c52a	\N
de8ddea2-7093-4692-b8be-96774cb881fb	91186b3f-f806-4cb0-a766-a2d142007df0	t	${role_impersonation}	impersonation	d173fb4f-af6c-4c50-bd78-301237d5f821	91186b3f-f806-4cb0-a766-a2d142007df0	\N
d647306e-23a8-4b91-9e0b-1c4637d73476	73709d32-73c9-48b5-bdcd-c1838f679a64	t	${role_impersonation}	impersonation	59e3dfd1-7985-4568-9573-4084337fc1d1	73709d32-73c9-48b5-bdcd-c1838f679a64	\N
4c26bd66-88d7-4ca7-a6ff-9470b7455893	de2c6113-b63a-442c-9f13-065c02d7f77c	t	${role_read-token}	read-token	59e3dfd1-7985-4568-9573-4084337fc1d1	de2c6113-b63a-442c-9f13-065c02d7f77c	\N
dfd13434-2081-49e8-a774-c5ee71b96ec5	59e3dfd1-7985-4568-9573-4084337fc1d1	f	${role_offline-access}	offline_access	59e3dfd1-7985-4568-9573-4084337fc1d1	\N	\N
884fa389-0f3d-469b-8283-dc7597a06577	59e3dfd1-7985-4568-9573-4084337fc1d1	f	${role_uma_authorization}	uma_authorization	59e3dfd1-7985-4568-9573-4084337fc1d1	\N	\N
41e054a5-5c38-4b61-95a2-78b6fc0794f2	e45acc0e-3df5-4b55-83ec-9beeaef25c04	t		user	59e3dfd1-7985-4568-9573-4084337fc1d1	e45acc0e-3df5-4b55-83ec-9beeaef25c04	\N
d49202d1-354d-424b-9e6d-829ebb2f0385	e45acc0e-3df5-4b55-83ec-9beeaef25c04	t		admin	59e3dfd1-7985-4568-9573-4084337fc1d1	e45acc0e-3df5-4b55-83ec-9beeaef25c04	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.migration_model (id, version, update_time) FROM stdin;
7uucb	26.1.2	1755016458
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id, version) FROM stdin;
fa81f769-9c78-4488-9048-dbe78144eec0	ad57c361-819a-46bd-8c9e-d7d6b90482bc	0	1755016739	{"authMethod":"openid-connect","redirectUri":"http://localhost:9000/admin/master/console/","notes":{"clientId":"ad57c361-819a-46bd-8c9e-d7d6b90482bc","iss":"http://localhost:9000/realms/master","startedAt":"1755016536","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"3f41925d-1f9e-4e69-b121-1f27f52b7ec3","response_mode":"query","scope":"openid","userSessionStartedAt":"1755016536","redirect_uri":"http://localhost:9000/admin/master/console/","state":"0033f8d9-b10d-4a21-9eea-74db28b0bad7","code_challenge":"BwXCjuDkrKxDTkqgZhad1XCAB0K9wdpYG3vYAYSlfCM"}}	local	local	4
3bed1359-3c77-4729-9744-64bada96a09c	e45acc0e-3df5-4b55-83ec-9beeaef25c04	0	1755016988	{"authMethod":"openid-connect","notes":{"clientId":"e45acc0e-3df5-4b55-83ec-9beeaef25c04","userSessionStartedAt":"1755016988","iss":"http://localhost:9000/realms/mealwurm","startedAt":"1755016988","level-of-authentication":"-1"}}	local	local	0
81c39d60-73af-448f-b2d2-7a318cb05c16	e45acc0e-3df5-4b55-83ec-9beeaef25c04	0	1755016996	{"authMethod":"openid-connect","redirectUri":"http://localhost:3000","notes":{"clientId":"e45acc0e-3df5-4b55-83ec-9beeaef25c04","scope":"openid","userSessionStartedAt":"1755016729","iss":"http://localhost:9000/realms/mealwurm","startedAt":"1755016729","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","redirect_uri":"http://localhost:3000","state":"007b9b9dcd05431b9b724a04687c20a6","code_challenge":"UlcnBE2T1HHiLuK4JKz1BD4CV1IzJwzDXmVoEBIteKs","SSO_AUTH":"true"}}	local	local	5
04760a40-3ffb-468b-bafb-7183c201f9fa	ad57c361-819a-46bd-8c9e-d7d6b90482bc	0	1755017132	{"authMethod":"openid-connect","redirectUri":"http://localhost:9000/admin/master/console/","notes":{"clientId":"ad57c361-819a-46bd-8c9e-d7d6b90482bc","iss":"http://localhost:9000/realms/master","startedAt":"1755017074","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"c15d221a-c9e1-4767-a3b1-fd9051d4e039","response_mode":"query","scope":"openid","userSessionStartedAt":"1755017074","redirect_uri":"http://localhost:9000/admin/master/console/","state":"b8591780-4c5c-454e-8730-983bb388af9e","code_challenge":"Mjs3DzCoFdm7y0lzOlsBvBOw5jUiyBiVkggetLyGxXA"}}	local	local	1
224c2457-9772-4377-93d8-f9a2215619d6	e45acc0e-3df5-4b55-83ec-9beeaef25c04	0	1755018253	{"authMethod":"openid-connect","redirectUri":"http://localhost:3000","notes":{"clientId":"e45acc0e-3df5-4b55-83ec-9beeaef25c04","scope":"openid","userSessionStartedAt":"1755018219","iss":"http://localhost:9000/realms/mealwurm","startedAt":"1755018219","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","redirect_uri":"http://localhost:3000","state":"c9296300e53a4285a5aa950fe21fcd1a","code_challenge":"uoFaNZ8W-0liwe7uU5nrPA0gK2BU0nyP07yiomQpZBU"}}	local	local	3
d1470d26-0246-4d32-9e4b-8854138bb1ae	e45acc0e-3df5-4b55-83ec-9beeaef25c04	0	1755020515	{"authMethod":"openid-connect","redirectUri":"http://localhost:3000","notes":{"clientId":"e45acc0e-3df5-4b55-83ec-9beeaef25c04","scope":"openid","userSessionStartedAt":"1755020514","iss":"http://localhost:9000/realms/mealwurm","startedAt":"1755020514","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","redirect_uri":"http://localhost:3000","state":"b1dca02495074cc0b3591888e17d7dfa","code_challenge":"hRQ_fga1WjK4CK_AkJoXMTCOclyfWf_NMP8dBoGuTqM"}}	local	local	1
bf5c3c97-9765-42f4-9ec3-8dc55bb22c84	ad57c361-819a-46bd-8c9e-d7d6b90482bc	0	1755020532	{"authMethod":"openid-connect","redirectUri":"http://localhost:9000/admin/master/console/","notes":{"clientId":"ad57c361-819a-46bd-8c9e-d7d6b90482bc","iss":"http://localhost:9000/realms/master","startedAt":"1755020531","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"efb3a3d6-87ba-4ea6-995c-734e1b5858af","response_mode":"query","scope":"openid","userSessionStartedAt":"1755020531","redirect_uri":"http://localhost:9000/admin/master/console/","state":"bfc5a59a-0f7b-494e-9b94-971dcec1b487","code_challenge":"UPfZbM7IUV9bZQZ_4n8wTkRcWQjRaKVvKIIR9iRZ2u4"}}	local	local	1
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh, broker_session_id, version) FROM stdin;
fa81f769-9c78-4488-9048-dbe78144eec0	2e99540b-145d-4f92-9ef4-fbe2a3a9e28c	d173fb4f-af6c-4c50-bd78-301237d5f821	1755016536	0	{"ipAddress":"192.168.65.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjY1LjEiLCJvcyI6Ik1hYyBPUyBYIiwib3NWZXJzaW9uIjoiMTAuMTUuNyIsImJyb3dzZXIiOiJDaHJvbWUvMTM5LjAuMCIsImRldmljZSI6Ik1hYyIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1755016536","authenticators-completed":"{\\"da24060e-231d-48e9-8769-2f43b7781c87\\":1755016536}"},"state":"LOGGED_IN"}	1755016739	\N	4
3bed1359-3c77-4729-9744-64bada96a09c	d77c8420-723d-4785-bc2a-e8aca8a4a741	59e3dfd1-7985-4568-9573-4084337fc1d1	1755016988	0	{"ipAddress":"192.168.65.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjY1LjEiLCJvcyI6Ik90aGVyIiwib3NWZXJzaW9uIjoiVW5rbm93biIsImJyb3dzZXIiOiJQb3N0bWFuUnVudGltZS83LjQ1LjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","authenticators-completed":"{\\"3e1eeb5c-a8fa-4ec9-b9e4-f1b8225601ce\\":1755016988,\\"59e120c5-5885-44a8-899c-744edcfe461e\\":1755016988}"},"state":"LOGGED_IN"}	1755016988	\N	0
81c39d60-73af-448f-b2d2-7a318cb05c16	d77c8420-723d-4785-bc2a-e8aca8a4a741	59e3dfd1-7985-4568-9573-4084337fc1d1	1755016729	0	{"ipAddress":"192.168.65.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjY1LjEiLCJvcyI6Ik1hYyBPUyBYIiwib3NWZXJzaW9uIjoiMTAuMTUuNyIsImJyb3dzZXIiOiJDaHJvbWUvMTM5LjAuMCIsImRldmljZSI6Ik1hYyIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1755016729","authenticators-completed":"{\\"9bab23b8-a15c-46d2-b2a4-98285b21b85c\\":1755016729,\\"4fe26365-440f-4466-8da5-ec89c2da60f4\\":1755016996}"},"state":"LOGGED_IN"}	1755016996	\N	5
04760a40-3ffb-468b-bafb-7183c201f9fa	2e99540b-145d-4f92-9ef4-fbe2a3a9e28c	d173fb4f-af6c-4c50-bd78-301237d5f821	1755017074	0	{"ipAddress":"192.168.65.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjY1LjEiLCJvcyI6Ik1hYyBPUyBYIiwib3NWZXJzaW9uIjoiMTAuMTUuNyIsImJyb3dzZXIiOiJDaHJvbWUvMTM5LjAuMCIsImRldmljZSI6Ik1hYyIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1755017074","authenticators-completed":"{\\"da24060e-231d-48e9-8769-2f43b7781c87\\":1755017074}"},"state":"LOGGED_IN"}	1755017132	\N	1
224c2457-9772-4377-93d8-f9a2215619d6	d77c8420-723d-4785-bc2a-e8aca8a4a741	59e3dfd1-7985-4568-9573-4084337fc1d1	1755018219	0	{"ipAddress":"192.168.65.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjY1LjEiLCJvcyI6Ik1hYyBPUyBYIiwib3NWZXJzaW9uIjoiMTAuMTUuNyIsImJyb3dzZXIiOiJDaHJvbWUvMTM5LjAuMCIsImRldmljZSI6Ik1hYyIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1755018219","authenticators-completed":"{\\"9bab23b8-a15c-46d2-b2a4-98285b21b85c\\":1755018219}"},"state":"LOGGED_IN"}	1755018253	\N	3
d1470d26-0246-4d32-9e4b-8854138bb1ae	d77c8420-723d-4785-bc2a-e8aca8a4a741	59e3dfd1-7985-4568-9573-4084337fc1d1	1755020514	0	{"ipAddress":"192.168.65.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjY1LjEiLCJvcyI6Ik1hYyBPUyBYIiwib3NWZXJzaW9uIjoiMTAuMTUuNyIsImJyb3dzZXIiOiJDaHJvbWUvMTM5LjAuMCIsImRldmljZSI6Ik1hYyIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1755020514","authenticators-completed":"{\\"9bab23b8-a15c-46d2-b2a4-98285b21b85c\\":1755020514}"},"state":"LOGGED_IN"}	1755020515	\N	1
bf5c3c97-9765-42f4-9ec3-8dc55bb22c84	2e99540b-145d-4f92-9ef4-fbe2a3a9e28c	d173fb4f-af6c-4c50-bd78-301237d5f821	1755020531	0	{"ipAddress":"192.168.65.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjY1LjEiLCJvcyI6Ik1hYyBPUyBYIiwib3NWZXJzaW9uIjoiMTAuMTUuNyIsImJyb3dzZXIiOiJDaHJvbWUvMTM5LjAuMCIsImRldmljZSI6Ik1hYyIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1755020531","authenticators-completed":"{\\"da24060e-231d-48e9-8769-2f43b7781c87\\":1755020531}"},"state":"LOGGED_IN"}	1755020532	\N	1
\.


--
-- Data for Name: org; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.org (id, enabled, realm_id, group_id, name, description, alias, redirect_url) FROM stdin;
\.


--
-- Data for Name: org_domain; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.org_domain (id, name, verified, org_id) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
aab6085e-4d06-447a-92ec-2555844c4695	audience resolve	openid-connect	oidc-audience-resolve-mapper	01d6fa70-0341-4466-a5b9-3307c640576d	\N
895ede58-5826-4932-be42-165bd1da936b	locale	openid-connect	oidc-usermodel-attribute-mapper	ad57c361-819a-46bd-8c9e-d7d6b90482bc	\N
b6c589a7-d637-4a63-8cd9-52cfa80410a4	role list	saml	saml-role-list-mapper	\N	3c2a4942-8476-4044-9eb4-d0f62f515aab
174c2fc9-75a2-45f0-a965-3257a197ec27	organization	saml	saml-organization-membership-mapper	\N	95b2d39b-5aa5-4ace-9418-cc7af550a3c6
54f8f38d-95c5-454c-887e-d2d7fc542ad6	full name	openid-connect	oidc-full-name-mapper	\N	d899830f-5e51-48b2-ba3d-ad58e4f8c69d
7dc7730e-495d-49fb-8e08-eae2b8723839	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	d899830f-5e51-48b2-ba3d-ad58e4f8c69d
1b08ec14-b69f-44f4-b230-352841b41cda	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	d899830f-5e51-48b2-ba3d-ad58e4f8c69d
24cf98e9-670a-4a1e-ba5a-be63ef2b78e7	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	d899830f-5e51-48b2-ba3d-ad58e4f8c69d
50cbb8b4-0e70-4421-bd6d-f9ed77253a7f	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	d899830f-5e51-48b2-ba3d-ad58e4f8c69d
da4232dc-cfd3-4693-822c-03bcccf25f22	username	openid-connect	oidc-usermodel-attribute-mapper	\N	d899830f-5e51-48b2-ba3d-ad58e4f8c69d
b4ebce73-bfdd-4313-a08e-11fc8d211d98	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	d899830f-5e51-48b2-ba3d-ad58e4f8c69d
5fec7a43-01c1-4c95-92d5-6456a3cdc1f2	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	d899830f-5e51-48b2-ba3d-ad58e4f8c69d
b7dc0388-9b74-4c2e-b0d9-19659035e3ec	website	openid-connect	oidc-usermodel-attribute-mapper	\N	d899830f-5e51-48b2-ba3d-ad58e4f8c69d
6a919015-e95e-4abe-b22a-5293ba7cb42b	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	d899830f-5e51-48b2-ba3d-ad58e4f8c69d
0efb9028-c844-4141-87f9-868566681750	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	d899830f-5e51-48b2-ba3d-ad58e4f8c69d
221b060f-9766-43ec-a683-ec065ec62a2b	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	d899830f-5e51-48b2-ba3d-ad58e4f8c69d
6ba1872b-e51b-4af3-adb2-c305d4dd9fa7	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	d899830f-5e51-48b2-ba3d-ad58e4f8c69d
09e3d689-5dcd-4cc4-91c8-a21e7373c097	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	d899830f-5e51-48b2-ba3d-ad58e4f8c69d
ae491155-8de2-4895-969c-93c0eff04fd9	email	openid-connect	oidc-usermodel-attribute-mapper	\N	7547d42e-d172-4463-bae8-71b882e3b1ca
f7ba7209-b052-466a-a395-e47448ca490d	email verified	openid-connect	oidc-usermodel-property-mapper	\N	7547d42e-d172-4463-bae8-71b882e3b1ca
f03e0d66-d3fb-437d-b640-1ed193565ca4	address	openid-connect	oidc-address-mapper	\N	ad1b25c8-bff8-41fe-aba4-286af672c64f
8bf0a480-2388-4ef7-bf90-7a0a4db491f6	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	e1423732-12cd-4b83-b339-f1e38f03df5d
add08158-e078-435b-b361-47f7b0fd4659	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	e1423732-12cd-4b83-b339-f1e38f03df5d
bb2945f6-0269-40ce-9ee2-c276b71cd006	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	2a638ed3-b5bb-409c-a112-e13bff69c33f
0ac8fa58-b1fe-4233-8616-26ec412936a0	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	2a638ed3-b5bb-409c-a112-e13bff69c33f
ae943e6a-a87c-4624-94e3-470219c65dc7	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	2a638ed3-b5bb-409c-a112-e13bff69c33f
9dbee509-55cc-495b-a574-ca70e7601607	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	08cc2e81-7d54-45e8-be80-ed80013fb686
1ec3c441-ffed-48eb-961c-c90b5a1d8385	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	cf78551b-6051-4128-a3da-940eccbe08c6
6af5d86b-9379-4ed5-b8e7-f6ccf0e384be	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	cf78551b-6051-4128-a3da-940eccbe08c6
0f1cb55a-3154-4dc4-b20a-2c5c11a7c452	acr loa level	openid-connect	oidc-acr-mapper	\N	08c0e400-285f-495b-9895-b8dcc97aa7c8
fe1af370-eb4c-4ded-aafb-b3625ed0a30f	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	faf64e1f-0738-4686-ab97-1be9898c177b
8c78d849-9655-40a1-a039-1783e4ed49be	sub	openid-connect	oidc-sub-mapper	\N	faf64e1f-0738-4686-ab97-1be9898c177b
fb36df60-6c3a-4972-a546-336448aeb377	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	\N	02a4c2b3-9e2c-4c29-bf25-c84ed7ed3175
5215baf7-fdcc-4e7d-b587-c045b0e725ad	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	\N	02a4c2b3-9e2c-4c29-bf25-c84ed7ed3175
3a3594b0-8a64-493b-b8c5-121fe84d418b	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	\N	02a4c2b3-9e2c-4c29-bf25-c84ed7ed3175
e9404641-f2db-499e-a51f-7dcbe508a4fa	organization	openid-connect	oidc-organization-membership-mapper	\N	fd4cee54-2846-4e8f-9607-0abb410d4cb8
62286cfa-5bbd-4d3e-a8b3-f4c8ac0c3f3d	audience resolve	openid-connect	oidc-audience-resolve-mapper	516bb66b-5bd7-4c4b-9d12-b8a88c7f010c	\N
51eb27f9-8d04-4999-a9b4-4aa8c01d7dbd	role list	saml	saml-role-list-mapper	\N	274fbafb-7e29-4834-a9b5-3469cfde7ad5
71f786d0-c716-4399-bf3b-e7232518e468	organization	saml	saml-organization-membership-mapper	\N	b793744b-f5ff-477d-976f-61d8ba2ebb5d
b1baca6d-bc6d-454d-9f6c-551ae589234b	full name	openid-connect	oidc-full-name-mapper	\N	5e2b6eda-8009-4a08-9e99-92bf4cf5980c
87abe2b5-822a-4103-8906-84ed4c55fa9f	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	5e2b6eda-8009-4a08-9e99-92bf4cf5980c
91d340c5-8a79-43e1-b893-ba9021d72726	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	5e2b6eda-8009-4a08-9e99-92bf4cf5980c
da1966de-7ab3-4a08-8dcf-06e7a98ec11b	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	5e2b6eda-8009-4a08-9e99-92bf4cf5980c
a0376563-86b9-4d35-a729-59aa35b1476d	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	5e2b6eda-8009-4a08-9e99-92bf4cf5980c
35ad5d0f-8ef9-485f-8009-87a9da7ffa1f	username	openid-connect	oidc-usermodel-attribute-mapper	\N	5e2b6eda-8009-4a08-9e99-92bf4cf5980c
ecf150c7-cb5a-4450-966b-6b863d8b9e2b	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	5e2b6eda-8009-4a08-9e99-92bf4cf5980c
c890b76b-7337-4a54-8153-6f1c4c42b339	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	5e2b6eda-8009-4a08-9e99-92bf4cf5980c
bb69774e-8121-407b-96a1-a1842bb3c222	website	openid-connect	oidc-usermodel-attribute-mapper	\N	5e2b6eda-8009-4a08-9e99-92bf4cf5980c
beccb6e5-87db-43f7-b97a-afb75ae92c85	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	5e2b6eda-8009-4a08-9e99-92bf4cf5980c
dde4b95b-79b2-4543-a187-f874a474b648	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	5e2b6eda-8009-4a08-9e99-92bf4cf5980c
018ac6a5-b9cc-42e3-891f-2e2d742a2655	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	5e2b6eda-8009-4a08-9e99-92bf4cf5980c
69dc6334-1de7-4237-8435-849293efaf7a	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	5e2b6eda-8009-4a08-9e99-92bf4cf5980c
b2903eb3-9c41-4c89-bef2-bf288273eab1	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	5e2b6eda-8009-4a08-9e99-92bf4cf5980c
fff54719-5d3c-41e2-a59e-44d83002d286	email	openid-connect	oidc-usermodel-attribute-mapper	\N	3f13e525-d348-4787-80af-9256386f4670
01476256-5768-4fec-b944-5edf77eb2abc	email verified	openid-connect	oidc-usermodel-property-mapper	\N	3f13e525-d348-4787-80af-9256386f4670
04c408e6-2d96-4aa4-9774-80598351d982	address	openid-connect	oidc-address-mapper	\N	d2ee2a14-7e55-4c28-9dad-21065c9d27be
b0c680de-d932-49af-a24c-2a65e777c67f	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	02c90be0-1dd3-42b7-8c14-24d8b196bd9e
14849fde-1eb1-4984-a4e0-17ce5e2f2a74	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	02c90be0-1dd3-42b7-8c14-24d8b196bd9e
214ac591-ce7a-47dc-a070-3ef58628be63	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	7cb3f141-f297-4261-b891-68c93b24a563
55843100-3261-4c3d-9738-bf7cc47f0464	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	7cb3f141-f297-4261-b891-68c93b24a563
a403dd42-a51a-4352-91de-41ecc4688bb7	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	7cb3f141-f297-4261-b891-68c93b24a563
102d8010-6b19-4f46-8076-ae574775ae04	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	2dba8ad0-29cb-4e27-ae6b-e67854ac19c6
753d7d0e-b774-40e5-bbfe-84fc55febac6	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	0689b937-49e7-460f-b544-0be503611a49
81fc75ae-0efa-41ee-a756-f904bead94ef	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	0689b937-49e7-460f-b544-0be503611a49
50da95d6-ec5a-49f2-9587-724addcca420	acr loa level	openid-connect	oidc-acr-mapper	\N	cc7d193a-1e69-4ca2-9266-79ab8a8b2124
cf523dc3-98d7-4514-ac04-9b42ce49d353	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	13f07e3d-3bab-4476-96ec-b4333ded9400
dd428cc6-8ba8-496b-b67f-c1b1549aa2c9	sub	openid-connect	oidc-sub-mapper	\N	13f07e3d-3bab-4476-96ec-b4333ded9400
b105174e-e5df-47d9-b85e-bf8cf717c76c	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	\N	7697941d-d55a-4449-a14f-927e18a96712
d0fde499-56d5-410b-8011-1ca5f0c226d8	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	\N	7697941d-d55a-4449-a14f-927e18a96712
bed6b9d4-61b2-47eb-8803-e64d00ab069f	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	\N	7697941d-d55a-4449-a14f-927e18a96712
beb6f8cd-03c4-4dc6-9c09-6e0065e56b4a	organization	openid-connect	oidc-organization-membership-mapper	\N	914ed35b-5b06-45c0-a147-5b1421d67457
57465d1b-9a1a-4281-9b1c-ab0ff6199f37	locale	openid-connect	oidc-usermodel-attribute-mapper	33071a57-6cad-4a45-a1e9-17a7df75f18e	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
895ede58-5826-4932-be42-165bd1da936b	true	introspection.token.claim
895ede58-5826-4932-be42-165bd1da936b	true	userinfo.token.claim
895ede58-5826-4932-be42-165bd1da936b	locale	user.attribute
895ede58-5826-4932-be42-165bd1da936b	true	id.token.claim
895ede58-5826-4932-be42-165bd1da936b	true	access.token.claim
895ede58-5826-4932-be42-165bd1da936b	locale	claim.name
895ede58-5826-4932-be42-165bd1da936b	String	jsonType.label
b6c589a7-d637-4a63-8cd9-52cfa80410a4	false	single
b6c589a7-d637-4a63-8cd9-52cfa80410a4	Basic	attribute.nameformat
b6c589a7-d637-4a63-8cd9-52cfa80410a4	Role	attribute.name
09e3d689-5dcd-4cc4-91c8-a21e7373c097	true	introspection.token.claim
09e3d689-5dcd-4cc4-91c8-a21e7373c097	true	userinfo.token.claim
09e3d689-5dcd-4cc4-91c8-a21e7373c097	updatedAt	user.attribute
09e3d689-5dcd-4cc4-91c8-a21e7373c097	true	id.token.claim
09e3d689-5dcd-4cc4-91c8-a21e7373c097	true	access.token.claim
09e3d689-5dcd-4cc4-91c8-a21e7373c097	updated_at	claim.name
09e3d689-5dcd-4cc4-91c8-a21e7373c097	long	jsonType.label
0efb9028-c844-4141-87f9-868566681750	true	introspection.token.claim
0efb9028-c844-4141-87f9-868566681750	true	userinfo.token.claim
0efb9028-c844-4141-87f9-868566681750	birthdate	user.attribute
0efb9028-c844-4141-87f9-868566681750	true	id.token.claim
0efb9028-c844-4141-87f9-868566681750	true	access.token.claim
0efb9028-c844-4141-87f9-868566681750	birthdate	claim.name
0efb9028-c844-4141-87f9-868566681750	String	jsonType.label
1b08ec14-b69f-44f4-b230-352841b41cda	true	introspection.token.claim
1b08ec14-b69f-44f4-b230-352841b41cda	true	userinfo.token.claim
1b08ec14-b69f-44f4-b230-352841b41cda	firstName	user.attribute
1b08ec14-b69f-44f4-b230-352841b41cda	true	id.token.claim
1b08ec14-b69f-44f4-b230-352841b41cda	true	access.token.claim
1b08ec14-b69f-44f4-b230-352841b41cda	given_name	claim.name
1b08ec14-b69f-44f4-b230-352841b41cda	String	jsonType.label
221b060f-9766-43ec-a683-ec065ec62a2b	true	introspection.token.claim
221b060f-9766-43ec-a683-ec065ec62a2b	true	userinfo.token.claim
221b060f-9766-43ec-a683-ec065ec62a2b	zoneinfo	user.attribute
221b060f-9766-43ec-a683-ec065ec62a2b	true	id.token.claim
221b060f-9766-43ec-a683-ec065ec62a2b	true	access.token.claim
221b060f-9766-43ec-a683-ec065ec62a2b	zoneinfo	claim.name
221b060f-9766-43ec-a683-ec065ec62a2b	String	jsonType.label
24cf98e9-670a-4a1e-ba5a-be63ef2b78e7	true	introspection.token.claim
24cf98e9-670a-4a1e-ba5a-be63ef2b78e7	true	userinfo.token.claim
24cf98e9-670a-4a1e-ba5a-be63ef2b78e7	middleName	user.attribute
24cf98e9-670a-4a1e-ba5a-be63ef2b78e7	true	id.token.claim
24cf98e9-670a-4a1e-ba5a-be63ef2b78e7	true	access.token.claim
24cf98e9-670a-4a1e-ba5a-be63ef2b78e7	middle_name	claim.name
24cf98e9-670a-4a1e-ba5a-be63ef2b78e7	String	jsonType.label
50cbb8b4-0e70-4421-bd6d-f9ed77253a7f	true	introspection.token.claim
50cbb8b4-0e70-4421-bd6d-f9ed77253a7f	true	userinfo.token.claim
50cbb8b4-0e70-4421-bd6d-f9ed77253a7f	nickname	user.attribute
50cbb8b4-0e70-4421-bd6d-f9ed77253a7f	true	id.token.claim
50cbb8b4-0e70-4421-bd6d-f9ed77253a7f	true	access.token.claim
50cbb8b4-0e70-4421-bd6d-f9ed77253a7f	nickname	claim.name
50cbb8b4-0e70-4421-bd6d-f9ed77253a7f	String	jsonType.label
54f8f38d-95c5-454c-887e-d2d7fc542ad6	true	introspection.token.claim
54f8f38d-95c5-454c-887e-d2d7fc542ad6	true	userinfo.token.claim
54f8f38d-95c5-454c-887e-d2d7fc542ad6	true	id.token.claim
54f8f38d-95c5-454c-887e-d2d7fc542ad6	true	access.token.claim
5fec7a43-01c1-4c95-92d5-6456a3cdc1f2	true	introspection.token.claim
5fec7a43-01c1-4c95-92d5-6456a3cdc1f2	true	userinfo.token.claim
5fec7a43-01c1-4c95-92d5-6456a3cdc1f2	picture	user.attribute
5fec7a43-01c1-4c95-92d5-6456a3cdc1f2	true	id.token.claim
5fec7a43-01c1-4c95-92d5-6456a3cdc1f2	true	access.token.claim
5fec7a43-01c1-4c95-92d5-6456a3cdc1f2	picture	claim.name
5fec7a43-01c1-4c95-92d5-6456a3cdc1f2	String	jsonType.label
6a919015-e95e-4abe-b22a-5293ba7cb42b	true	introspection.token.claim
6a919015-e95e-4abe-b22a-5293ba7cb42b	true	userinfo.token.claim
6a919015-e95e-4abe-b22a-5293ba7cb42b	gender	user.attribute
6a919015-e95e-4abe-b22a-5293ba7cb42b	true	id.token.claim
6a919015-e95e-4abe-b22a-5293ba7cb42b	true	access.token.claim
6a919015-e95e-4abe-b22a-5293ba7cb42b	gender	claim.name
6a919015-e95e-4abe-b22a-5293ba7cb42b	String	jsonType.label
6ba1872b-e51b-4af3-adb2-c305d4dd9fa7	true	introspection.token.claim
6ba1872b-e51b-4af3-adb2-c305d4dd9fa7	true	userinfo.token.claim
6ba1872b-e51b-4af3-adb2-c305d4dd9fa7	locale	user.attribute
6ba1872b-e51b-4af3-adb2-c305d4dd9fa7	true	id.token.claim
6ba1872b-e51b-4af3-adb2-c305d4dd9fa7	true	access.token.claim
6ba1872b-e51b-4af3-adb2-c305d4dd9fa7	locale	claim.name
6ba1872b-e51b-4af3-adb2-c305d4dd9fa7	String	jsonType.label
7dc7730e-495d-49fb-8e08-eae2b8723839	true	introspection.token.claim
7dc7730e-495d-49fb-8e08-eae2b8723839	true	userinfo.token.claim
7dc7730e-495d-49fb-8e08-eae2b8723839	lastName	user.attribute
7dc7730e-495d-49fb-8e08-eae2b8723839	true	id.token.claim
7dc7730e-495d-49fb-8e08-eae2b8723839	true	access.token.claim
7dc7730e-495d-49fb-8e08-eae2b8723839	family_name	claim.name
7dc7730e-495d-49fb-8e08-eae2b8723839	String	jsonType.label
b4ebce73-bfdd-4313-a08e-11fc8d211d98	true	introspection.token.claim
b4ebce73-bfdd-4313-a08e-11fc8d211d98	true	userinfo.token.claim
b4ebce73-bfdd-4313-a08e-11fc8d211d98	profile	user.attribute
b4ebce73-bfdd-4313-a08e-11fc8d211d98	true	id.token.claim
b4ebce73-bfdd-4313-a08e-11fc8d211d98	true	access.token.claim
b4ebce73-bfdd-4313-a08e-11fc8d211d98	profile	claim.name
b4ebce73-bfdd-4313-a08e-11fc8d211d98	String	jsonType.label
b7dc0388-9b74-4c2e-b0d9-19659035e3ec	true	introspection.token.claim
b7dc0388-9b74-4c2e-b0d9-19659035e3ec	true	userinfo.token.claim
b7dc0388-9b74-4c2e-b0d9-19659035e3ec	website	user.attribute
b7dc0388-9b74-4c2e-b0d9-19659035e3ec	true	id.token.claim
b7dc0388-9b74-4c2e-b0d9-19659035e3ec	true	access.token.claim
b7dc0388-9b74-4c2e-b0d9-19659035e3ec	website	claim.name
b7dc0388-9b74-4c2e-b0d9-19659035e3ec	String	jsonType.label
da4232dc-cfd3-4693-822c-03bcccf25f22	true	introspection.token.claim
da4232dc-cfd3-4693-822c-03bcccf25f22	true	userinfo.token.claim
da4232dc-cfd3-4693-822c-03bcccf25f22	username	user.attribute
da4232dc-cfd3-4693-822c-03bcccf25f22	true	id.token.claim
da4232dc-cfd3-4693-822c-03bcccf25f22	true	access.token.claim
da4232dc-cfd3-4693-822c-03bcccf25f22	preferred_username	claim.name
da4232dc-cfd3-4693-822c-03bcccf25f22	String	jsonType.label
ae491155-8de2-4895-969c-93c0eff04fd9	true	introspection.token.claim
ae491155-8de2-4895-969c-93c0eff04fd9	true	userinfo.token.claim
ae491155-8de2-4895-969c-93c0eff04fd9	email	user.attribute
ae491155-8de2-4895-969c-93c0eff04fd9	true	id.token.claim
ae491155-8de2-4895-969c-93c0eff04fd9	true	access.token.claim
ae491155-8de2-4895-969c-93c0eff04fd9	email	claim.name
ae491155-8de2-4895-969c-93c0eff04fd9	String	jsonType.label
f7ba7209-b052-466a-a395-e47448ca490d	true	introspection.token.claim
f7ba7209-b052-466a-a395-e47448ca490d	true	userinfo.token.claim
f7ba7209-b052-466a-a395-e47448ca490d	emailVerified	user.attribute
f7ba7209-b052-466a-a395-e47448ca490d	true	id.token.claim
f7ba7209-b052-466a-a395-e47448ca490d	true	access.token.claim
f7ba7209-b052-466a-a395-e47448ca490d	email_verified	claim.name
f7ba7209-b052-466a-a395-e47448ca490d	boolean	jsonType.label
f03e0d66-d3fb-437d-b640-1ed193565ca4	formatted	user.attribute.formatted
f03e0d66-d3fb-437d-b640-1ed193565ca4	country	user.attribute.country
f03e0d66-d3fb-437d-b640-1ed193565ca4	true	introspection.token.claim
f03e0d66-d3fb-437d-b640-1ed193565ca4	postal_code	user.attribute.postal_code
f03e0d66-d3fb-437d-b640-1ed193565ca4	true	userinfo.token.claim
f03e0d66-d3fb-437d-b640-1ed193565ca4	street	user.attribute.street
f03e0d66-d3fb-437d-b640-1ed193565ca4	true	id.token.claim
f03e0d66-d3fb-437d-b640-1ed193565ca4	region	user.attribute.region
f03e0d66-d3fb-437d-b640-1ed193565ca4	true	access.token.claim
f03e0d66-d3fb-437d-b640-1ed193565ca4	locality	user.attribute.locality
8bf0a480-2388-4ef7-bf90-7a0a4db491f6	true	introspection.token.claim
8bf0a480-2388-4ef7-bf90-7a0a4db491f6	true	userinfo.token.claim
8bf0a480-2388-4ef7-bf90-7a0a4db491f6	phoneNumber	user.attribute
8bf0a480-2388-4ef7-bf90-7a0a4db491f6	true	id.token.claim
8bf0a480-2388-4ef7-bf90-7a0a4db491f6	true	access.token.claim
8bf0a480-2388-4ef7-bf90-7a0a4db491f6	phone_number	claim.name
8bf0a480-2388-4ef7-bf90-7a0a4db491f6	String	jsonType.label
add08158-e078-435b-b361-47f7b0fd4659	true	introspection.token.claim
add08158-e078-435b-b361-47f7b0fd4659	true	userinfo.token.claim
add08158-e078-435b-b361-47f7b0fd4659	phoneNumberVerified	user.attribute
add08158-e078-435b-b361-47f7b0fd4659	true	id.token.claim
add08158-e078-435b-b361-47f7b0fd4659	true	access.token.claim
add08158-e078-435b-b361-47f7b0fd4659	phone_number_verified	claim.name
add08158-e078-435b-b361-47f7b0fd4659	boolean	jsonType.label
0ac8fa58-b1fe-4233-8616-26ec412936a0	true	introspection.token.claim
0ac8fa58-b1fe-4233-8616-26ec412936a0	true	multivalued
0ac8fa58-b1fe-4233-8616-26ec412936a0	foo	user.attribute
0ac8fa58-b1fe-4233-8616-26ec412936a0	true	access.token.claim
0ac8fa58-b1fe-4233-8616-26ec412936a0	resource_access.${client_id}.roles	claim.name
0ac8fa58-b1fe-4233-8616-26ec412936a0	String	jsonType.label
ae943e6a-a87c-4624-94e3-470219c65dc7	true	introspection.token.claim
ae943e6a-a87c-4624-94e3-470219c65dc7	true	access.token.claim
bb2945f6-0269-40ce-9ee2-c276b71cd006	true	introspection.token.claim
bb2945f6-0269-40ce-9ee2-c276b71cd006	true	multivalued
bb2945f6-0269-40ce-9ee2-c276b71cd006	foo	user.attribute
bb2945f6-0269-40ce-9ee2-c276b71cd006	true	access.token.claim
bb2945f6-0269-40ce-9ee2-c276b71cd006	realm_access.roles	claim.name
bb2945f6-0269-40ce-9ee2-c276b71cd006	String	jsonType.label
9dbee509-55cc-495b-a574-ca70e7601607	true	introspection.token.claim
9dbee509-55cc-495b-a574-ca70e7601607	true	access.token.claim
1ec3c441-ffed-48eb-961c-c90b5a1d8385	true	introspection.token.claim
1ec3c441-ffed-48eb-961c-c90b5a1d8385	true	userinfo.token.claim
1ec3c441-ffed-48eb-961c-c90b5a1d8385	username	user.attribute
1ec3c441-ffed-48eb-961c-c90b5a1d8385	true	id.token.claim
1ec3c441-ffed-48eb-961c-c90b5a1d8385	true	access.token.claim
1ec3c441-ffed-48eb-961c-c90b5a1d8385	upn	claim.name
1ec3c441-ffed-48eb-961c-c90b5a1d8385	String	jsonType.label
6af5d86b-9379-4ed5-b8e7-f6ccf0e384be	true	introspection.token.claim
6af5d86b-9379-4ed5-b8e7-f6ccf0e384be	true	multivalued
6af5d86b-9379-4ed5-b8e7-f6ccf0e384be	foo	user.attribute
6af5d86b-9379-4ed5-b8e7-f6ccf0e384be	true	id.token.claim
6af5d86b-9379-4ed5-b8e7-f6ccf0e384be	true	access.token.claim
6af5d86b-9379-4ed5-b8e7-f6ccf0e384be	groups	claim.name
6af5d86b-9379-4ed5-b8e7-f6ccf0e384be	String	jsonType.label
0f1cb55a-3154-4dc4-b20a-2c5c11a7c452	true	introspection.token.claim
0f1cb55a-3154-4dc4-b20a-2c5c11a7c452	true	id.token.claim
0f1cb55a-3154-4dc4-b20a-2c5c11a7c452	true	access.token.claim
8c78d849-9655-40a1-a039-1783e4ed49be	true	introspection.token.claim
8c78d849-9655-40a1-a039-1783e4ed49be	true	access.token.claim
fe1af370-eb4c-4ded-aafb-b3625ed0a30f	AUTH_TIME	user.session.note
fe1af370-eb4c-4ded-aafb-b3625ed0a30f	true	introspection.token.claim
fe1af370-eb4c-4ded-aafb-b3625ed0a30f	true	id.token.claim
fe1af370-eb4c-4ded-aafb-b3625ed0a30f	true	access.token.claim
fe1af370-eb4c-4ded-aafb-b3625ed0a30f	auth_time	claim.name
fe1af370-eb4c-4ded-aafb-b3625ed0a30f	long	jsonType.label
3a3594b0-8a64-493b-b8c5-121fe84d418b	clientAddress	user.session.note
3a3594b0-8a64-493b-b8c5-121fe84d418b	true	introspection.token.claim
3a3594b0-8a64-493b-b8c5-121fe84d418b	true	id.token.claim
3a3594b0-8a64-493b-b8c5-121fe84d418b	true	access.token.claim
3a3594b0-8a64-493b-b8c5-121fe84d418b	clientAddress	claim.name
3a3594b0-8a64-493b-b8c5-121fe84d418b	String	jsonType.label
5215baf7-fdcc-4e7d-b587-c045b0e725ad	clientHost	user.session.note
5215baf7-fdcc-4e7d-b587-c045b0e725ad	true	introspection.token.claim
5215baf7-fdcc-4e7d-b587-c045b0e725ad	true	id.token.claim
5215baf7-fdcc-4e7d-b587-c045b0e725ad	true	access.token.claim
5215baf7-fdcc-4e7d-b587-c045b0e725ad	clientHost	claim.name
5215baf7-fdcc-4e7d-b587-c045b0e725ad	String	jsonType.label
fb36df60-6c3a-4972-a546-336448aeb377	client_id	user.session.note
fb36df60-6c3a-4972-a546-336448aeb377	true	introspection.token.claim
fb36df60-6c3a-4972-a546-336448aeb377	true	id.token.claim
fb36df60-6c3a-4972-a546-336448aeb377	true	access.token.claim
fb36df60-6c3a-4972-a546-336448aeb377	client_id	claim.name
fb36df60-6c3a-4972-a546-336448aeb377	String	jsonType.label
e9404641-f2db-499e-a51f-7dcbe508a4fa	true	introspection.token.claim
e9404641-f2db-499e-a51f-7dcbe508a4fa	true	multivalued
e9404641-f2db-499e-a51f-7dcbe508a4fa	true	id.token.claim
e9404641-f2db-499e-a51f-7dcbe508a4fa	true	access.token.claim
e9404641-f2db-499e-a51f-7dcbe508a4fa	organization	claim.name
e9404641-f2db-499e-a51f-7dcbe508a4fa	String	jsonType.label
51eb27f9-8d04-4999-a9b4-4aa8c01d7dbd	false	single
51eb27f9-8d04-4999-a9b4-4aa8c01d7dbd	Basic	attribute.nameformat
51eb27f9-8d04-4999-a9b4-4aa8c01d7dbd	Role	attribute.name
018ac6a5-b9cc-42e3-891f-2e2d742a2655	true	introspection.token.claim
018ac6a5-b9cc-42e3-891f-2e2d742a2655	true	userinfo.token.claim
018ac6a5-b9cc-42e3-891f-2e2d742a2655	zoneinfo	user.attribute
018ac6a5-b9cc-42e3-891f-2e2d742a2655	true	id.token.claim
018ac6a5-b9cc-42e3-891f-2e2d742a2655	true	access.token.claim
018ac6a5-b9cc-42e3-891f-2e2d742a2655	zoneinfo	claim.name
018ac6a5-b9cc-42e3-891f-2e2d742a2655	String	jsonType.label
35ad5d0f-8ef9-485f-8009-87a9da7ffa1f	true	introspection.token.claim
35ad5d0f-8ef9-485f-8009-87a9da7ffa1f	true	userinfo.token.claim
35ad5d0f-8ef9-485f-8009-87a9da7ffa1f	username	user.attribute
35ad5d0f-8ef9-485f-8009-87a9da7ffa1f	true	id.token.claim
35ad5d0f-8ef9-485f-8009-87a9da7ffa1f	true	access.token.claim
35ad5d0f-8ef9-485f-8009-87a9da7ffa1f	preferred_username	claim.name
35ad5d0f-8ef9-485f-8009-87a9da7ffa1f	String	jsonType.label
69dc6334-1de7-4237-8435-849293efaf7a	true	introspection.token.claim
69dc6334-1de7-4237-8435-849293efaf7a	true	userinfo.token.claim
69dc6334-1de7-4237-8435-849293efaf7a	locale	user.attribute
69dc6334-1de7-4237-8435-849293efaf7a	true	id.token.claim
69dc6334-1de7-4237-8435-849293efaf7a	true	access.token.claim
69dc6334-1de7-4237-8435-849293efaf7a	locale	claim.name
69dc6334-1de7-4237-8435-849293efaf7a	String	jsonType.label
87abe2b5-822a-4103-8906-84ed4c55fa9f	true	introspection.token.claim
87abe2b5-822a-4103-8906-84ed4c55fa9f	true	userinfo.token.claim
87abe2b5-822a-4103-8906-84ed4c55fa9f	lastName	user.attribute
87abe2b5-822a-4103-8906-84ed4c55fa9f	true	id.token.claim
87abe2b5-822a-4103-8906-84ed4c55fa9f	true	access.token.claim
87abe2b5-822a-4103-8906-84ed4c55fa9f	family_name	claim.name
87abe2b5-822a-4103-8906-84ed4c55fa9f	String	jsonType.label
91d340c5-8a79-43e1-b893-ba9021d72726	true	introspection.token.claim
91d340c5-8a79-43e1-b893-ba9021d72726	true	userinfo.token.claim
91d340c5-8a79-43e1-b893-ba9021d72726	firstName	user.attribute
91d340c5-8a79-43e1-b893-ba9021d72726	true	id.token.claim
91d340c5-8a79-43e1-b893-ba9021d72726	true	access.token.claim
91d340c5-8a79-43e1-b893-ba9021d72726	given_name	claim.name
91d340c5-8a79-43e1-b893-ba9021d72726	String	jsonType.label
a0376563-86b9-4d35-a729-59aa35b1476d	true	introspection.token.claim
a0376563-86b9-4d35-a729-59aa35b1476d	true	userinfo.token.claim
a0376563-86b9-4d35-a729-59aa35b1476d	nickname	user.attribute
a0376563-86b9-4d35-a729-59aa35b1476d	true	id.token.claim
a0376563-86b9-4d35-a729-59aa35b1476d	true	access.token.claim
a0376563-86b9-4d35-a729-59aa35b1476d	nickname	claim.name
a0376563-86b9-4d35-a729-59aa35b1476d	String	jsonType.label
b1baca6d-bc6d-454d-9f6c-551ae589234b	true	introspection.token.claim
b1baca6d-bc6d-454d-9f6c-551ae589234b	true	userinfo.token.claim
b1baca6d-bc6d-454d-9f6c-551ae589234b	true	id.token.claim
b1baca6d-bc6d-454d-9f6c-551ae589234b	true	access.token.claim
b2903eb3-9c41-4c89-bef2-bf288273eab1	true	introspection.token.claim
b2903eb3-9c41-4c89-bef2-bf288273eab1	true	userinfo.token.claim
b2903eb3-9c41-4c89-bef2-bf288273eab1	updatedAt	user.attribute
b2903eb3-9c41-4c89-bef2-bf288273eab1	true	id.token.claim
b2903eb3-9c41-4c89-bef2-bf288273eab1	true	access.token.claim
b2903eb3-9c41-4c89-bef2-bf288273eab1	updated_at	claim.name
b2903eb3-9c41-4c89-bef2-bf288273eab1	long	jsonType.label
bb69774e-8121-407b-96a1-a1842bb3c222	true	introspection.token.claim
bb69774e-8121-407b-96a1-a1842bb3c222	true	userinfo.token.claim
bb69774e-8121-407b-96a1-a1842bb3c222	website	user.attribute
bb69774e-8121-407b-96a1-a1842bb3c222	true	id.token.claim
bb69774e-8121-407b-96a1-a1842bb3c222	true	access.token.claim
bb69774e-8121-407b-96a1-a1842bb3c222	website	claim.name
bb69774e-8121-407b-96a1-a1842bb3c222	String	jsonType.label
beccb6e5-87db-43f7-b97a-afb75ae92c85	true	introspection.token.claim
beccb6e5-87db-43f7-b97a-afb75ae92c85	true	userinfo.token.claim
beccb6e5-87db-43f7-b97a-afb75ae92c85	gender	user.attribute
beccb6e5-87db-43f7-b97a-afb75ae92c85	true	id.token.claim
beccb6e5-87db-43f7-b97a-afb75ae92c85	true	access.token.claim
beccb6e5-87db-43f7-b97a-afb75ae92c85	gender	claim.name
beccb6e5-87db-43f7-b97a-afb75ae92c85	String	jsonType.label
c890b76b-7337-4a54-8153-6f1c4c42b339	true	introspection.token.claim
c890b76b-7337-4a54-8153-6f1c4c42b339	true	userinfo.token.claim
c890b76b-7337-4a54-8153-6f1c4c42b339	picture	user.attribute
c890b76b-7337-4a54-8153-6f1c4c42b339	true	id.token.claim
c890b76b-7337-4a54-8153-6f1c4c42b339	true	access.token.claim
c890b76b-7337-4a54-8153-6f1c4c42b339	picture	claim.name
c890b76b-7337-4a54-8153-6f1c4c42b339	String	jsonType.label
da1966de-7ab3-4a08-8dcf-06e7a98ec11b	true	introspection.token.claim
da1966de-7ab3-4a08-8dcf-06e7a98ec11b	true	userinfo.token.claim
da1966de-7ab3-4a08-8dcf-06e7a98ec11b	middleName	user.attribute
da1966de-7ab3-4a08-8dcf-06e7a98ec11b	true	id.token.claim
da1966de-7ab3-4a08-8dcf-06e7a98ec11b	true	access.token.claim
da1966de-7ab3-4a08-8dcf-06e7a98ec11b	middle_name	claim.name
da1966de-7ab3-4a08-8dcf-06e7a98ec11b	String	jsonType.label
dde4b95b-79b2-4543-a187-f874a474b648	true	introspection.token.claim
dde4b95b-79b2-4543-a187-f874a474b648	true	userinfo.token.claim
dde4b95b-79b2-4543-a187-f874a474b648	birthdate	user.attribute
dde4b95b-79b2-4543-a187-f874a474b648	true	id.token.claim
dde4b95b-79b2-4543-a187-f874a474b648	true	access.token.claim
dde4b95b-79b2-4543-a187-f874a474b648	birthdate	claim.name
dde4b95b-79b2-4543-a187-f874a474b648	String	jsonType.label
ecf150c7-cb5a-4450-966b-6b863d8b9e2b	true	introspection.token.claim
ecf150c7-cb5a-4450-966b-6b863d8b9e2b	true	userinfo.token.claim
ecf150c7-cb5a-4450-966b-6b863d8b9e2b	profile	user.attribute
ecf150c7-cb5a-4450-966b-6b863d8b9e2b	true	id.token.claim
ecf150c7-cb5a-4450-966b-6b863d8b9e2b	true	access.token.claim
ecf150c7-cb5a-4450-966b-6b863d8b9e2b	profile	claim.name
ecf150c7-cb5a-4450-966b-6b863d8b9e2b	String	jsonType.label
01476256-5768-4fec-b944-5edf77eb2abc	true	introspection.token.claim
01476256-5768-4fec-b944-5edf77eb2abc	true	userinfo.token.claim
01476256-5768-4fec-b944-5edf77eb2abc	emailVerified	user.attribute
01476256-5768-4fec-b944-5edf77eb2abc	true	id.token.claim
01476256-5768-4fec-b944-5edf77eb2abc	true	access.token.claim
01476256-5768-4fec-b944-5edf77eb2abc	email_verified	claim.name
01476256-5768-4fec-b944-5edf77eb2abc	boolean	jsonType.label
fff54719-5d3c-41e2-a59e-44d83002d286	true	introspection.token.claim
fff54719-5d3c-41e2-a59e-44d83002d286	true	userinfo.token.claim
fff54719-5d3c-41e2-a59e-44d83002d286	email	user.attribute
fff54719-5d3c-41e2-a59e-44d83002d286	true	id.token.claim
fff54719-5d3c-41e2-a59e-44d83002d286	true	access.token.claim
fff54719-5d3c-41e2-a59e-44d83002d286	email	claim.name
fff54719-5d3c-41e2-a59e-44d83002d286	String	jsonType.label
04c408e6-2d96-4aa4-9774-80598351d982	formatted	user.attribute.formatted
04c408e6-2d96-4aa4-9774-80598351d982	country	user.attribute.country
04c408e6-2d96-4aa4-9774-80598351d982	true	introspection.token.claim
04c408e6-2d96-4aa4-9774-80598351d982	postal_code	user.attribute.postal_code
04c408e6-2d96-4aa4-9774-80598351d982	true	userinfo.token.claim
04c408e6-2d96-4aa4-9774-80598351d982	street	user.attribute.street
04c408e6-2d96-4aa4-9774-80598351d982	true	id.token.claim
04c408e6-2d96-4aa4-9774-80598351d982	region	user.attribute.region
04c408e6-2d96-4aa4-9774-80598351d982	true	access.token.claim
04c408e6-2d96-4aa4-9774-80598351d982	locality	user.attribute.locality
14849fde-1eb1-4984-a4e0-17ce5e2f2a74	true	introspection.token.claim
14849fde-1eb1-4984-a4e0-17ce5e2f2a74	true	userinfo.token.claim
14849fde-1eb1-4984-a4e0-17ce5e2f2a74	phoneNumberVerified	user.attribute
14849fde-1eb1-4984-a4e0-17ce5e2f2a74	true	id.token.claim
14849fde-1eb1-4984-a4e0-17ce5e2f2a74	true	access.token.claim
14849fde-1eb1-4984-a4e0-17ce5e2f2a74	phone_number_verified	claim.name
14849fde-1eb1-4984-a4e0-17ce5e2f2a74	boolean	jsonType.label
b0c680de-d932-49af-a24c-2a65e777c67f	true	introspection.token.claim
b0c680de-d932-49af-a24c-2a65e777c67f	true	userinfo.token.claim
b0c680de-d932-49af-a24c-2a65e777c67f	phoneNumber	user.attribute
b0c680de-d932-49af-a24c-2a65e777c67f	true	id.token.claim
b0c680de-d932-49af-a24c-2a65e777c67f	true	access.token.claim
b0c680de-d932-49af-a24c-2a65e777c67f	phone_number	claim.name
b0c680de-d932-49af-a24c-2a65e777c67f	String	jsonType.label
214ac591-ce7a-47dc-a070-3ef58628be63	true	introspection.token.claim
214ac591-ce7a-47dc-a070-3ef58628be63	true	multivalued
214ac591-ce7a-47dc-a070-3ef58628be63	foo	user.attribute
214ac591-ce7a-47dc-a070-3ef58628be63	true	access.token.claim
214ac591-ce7a-47dc-a070-3ef58628be63	realm_access.roles	claim.name
214ac591-ce7a-47dc-a070-3ef58628be63	String	jsonType.label
55843100-3261-4c3d-9738-bf7cc47f0464	true	introspection.token.claim
55843100-3261-4c3d-9738-bf7cc47f0464	true	multivalued
55843100-3261-4c3d-9738-bf7cc47f0464	foo	user.attribute
55843100-3261-4c3d-9738-bf7cc47f0464	true	access.token.claim
55843100-3261-4c3d-9738-bf7cc47f0464	resource_access.${client_id}.roles	claim.name
55843100-3261-4c3d-9738-bf7cc47f0464	String	jsonType.label
a403dd42-a51a-4352-91de-41ecc4688bb7	true	introspection.token.claim
a403dd42-a51a-4352-91de-41ecc4688bb7	true	access.token.claim
102d8010-6b19-4f46-8076-ae574775ae04	true	introspection.token.claim
102d8010-6b19-4f46-8076-ae574775ae04	true	access.token.claim
753d7d0e-b774-40e5-bbfe-84fc55febac6	true	introspection.token.claim
753d7d0e-b774-40e5-bbfe-84fc55febac6	true	userinfo.token.claim
753d7d0e-b774-40e5-bbfe-84fc55febac6	username	user.attribute
753d7d0e-b774-40e5-bbfe-84fc55febac6	true	id.token.claim
753d7d0e-b774-40e5-bbfe-84fc55febac6	true	access.token.claim
753d7d0e-b774-40e5-bbfe-84fc55febac6	upn	claim.name
753d7d0e-b774-40e5-bbfe-84fc55febac6	String	jsonType.label
81fc75ae-0efa-41ee-a756-f904bead94ef	true	introspection.token.claim
81fc75ae-0efa-41ee-a756-f904bead94ef	true	multivalued
81fc75ae-0efa-41ee-a756-f904bead94ef	foo	user.attribute
81fc75ae-0efa-41ee-a756-f904bead94ef	true	id.token.claim
81fc75ae-0efa-41ee-a756-f904bead94ef	true	access.token.claim
81fc75ae-0efa-41ee-a756-f904bead94ef	groups	claim.name
81fc75ae-0efa-41ee-a756-f904bead94ef	String	jsonType.label
50da95d6-ec5a-49f2-9587-724addcca420	true	introspection.token.claim
50da95d6-ec5a-49f2-9587-724addcca420	true	id.token.claim
50da95d6-ec5a-49f2-9587-724addcca420	true	access.token.claim
cf523dc3-98d7-4514-ac04-9b42ce49d353	AUTH_TIME	user.session.note
cf523dc3-98d7-4514-ac04-9b42ce49d353	true	introspection.token.claim
cf523dc3-98d7-4514-ac04-9b42ce49d353	true	id.token.claim
cf523dc3-98d7-4514-ac04-9b42ce49d353	true	access.token.claim
cf523dc3-98d7-4514-ac04-9b42ce49d353	auth_time	claim.name
cf523dc3-98d7-4514-ac04-9b42ce49d353	long	jsonType.label
dd428cc6-8ba8-496b-b67f-c1b1549aa2c9	true	introspection.token.claim
dd428cc6-8ba8-496b-b67f-c1b1549aa2c9	true	access.token.claim
b105174e-e5df-47d9-b85e-bf8cf717c76c	client_id	user.session.note
b105174e-e5df-47d9-b85e-bf8cf717c76c	true	introspection.token.claim
b105174e-e5df-47d9-b85e-bf8cf717c76c	true	id.token.claim
b105174e-e5df-47d9-b85e-bf8cf717c76c	true	access.token.claim
b105174e-e5df-47d9-b85e-bf8cf717c76c	client_id	claim.name
b105174e-e5df-47d9-b85e-bf8cf717c76c	String	jsonType.label
bed6b9d4-61b2-47eb-8803-e64d00ab069f	clientAddress	user.session.note
bed6b9d4-61b2-47eb-8803-e64d00ab069f	true	introspection.token.claim
bed6b9d4-61b2-47eb-8803-e64d00ab069f	true	id.token.claim
bed6b9d4-61b2-47eb-8803-e64d00ab069f	true	access.token.claim
bed6b9d4-61b2-47eb-8803-e64d00ab069f	clientAddress	claim.name
bed6b9d4-61b2-47eb-8803-e64d00ab069f	String	jsonType.label
d0fde499-56d5-410b-8011-1ca5f0c226d8	clientHost	user.session.note
d0fde499-56d5-410b-8011-1ca5f0c226d8	true	introspection.token.claim
d0fde499-56d5-410b-8011-1ca5f0c226d8	true	id.token.claim
d0fde499-56d5-410b-8011-1ca5f0c226d8	true	access.token.claim
d0fde499-56d5-410b-8011-1ca5f0c226d8	clientHost	claim.name
d0fde499-56d5-410b-8011-1ca5f0c226d8	String	jsonType.label
beb6f8cd-03c4-4dc6-9c09-6e0065e56b4a	true	introspection.token.claim
beb6f8cd-03c4-4dc6-9c09-6e0065e56b4a	true	multivalued
beb6f8cd-03c4-4dc6-9c09-6e0065e56b4a	true	id.token.claim
beb6f8cd-03c4-4dc6-9c09-6e0065e56b4a	true	access.token.claim
beb6f8cd-03c4-4dc6-9c09-6e0065e56b4a	organization	claim.name
beb6f8cd-03c4-4dc6-9c09-6e0065e56b4a	String	jsonType.label
57465d1b-9a1a-4281-9b1c-ab0ff6199f37	true	introspection.token.claim
57465d1b-9a1a-4281-9b1c-ab0ff6199f37	true	userinfo.token.claim
57465d1b-9a1a-4281-9b1c-ab0ff6199f37	locale	user.attribute
57465d1b-9a1a-4281-9b1c-ab0ff6199f37	true	id.token.claim
57465d1b-9a1a-4281-9b1c-ab0ff6199f37	true	access.token.claim
57465d1b-9a1a-4281-9b1c-ab0ff6199f37	locale	claim.name
57465d1b-9a1a-4281-9b1c-ab0ff6199f37	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
59e3dfd1-7985-4568-9573-4084337fc1d1	60	300	300	\N	\N	\N	t	f	0	\N	mealwurm	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	91186b3f-f806-4cb0-a766-a2d142007df0	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	dc169c3a-9ce8-493b-832e-7d4af992b664	5afd3e03-4fe6-4338-8a59-edce2c74e3f2	a5e0b5ef-a769-4a6f-a19d-8a0d6506d2a6	4ca48059-e7ba-40ee-9ee3-40afe67a8c71	18a96f4d-26ef-4776-86fd-00ab7628713a	2592000	f	900	t	f	a52a0a93-cbc9-4bc7-bff0-e80ba2ac25d6	0	f	0	0	0d4fb0db-d34f-428f-b286-be511c0d6395
d173fb4f-af6c-4c50-bd78-301237d5f821	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	t	f	f	f	EXTERNAL	1800	36000	f	f	2d4a0989-d85d-4a89-b797-3cfd0c0aceb5	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	a986bd6f-0d25-47b9-93bc-2f535c61c98e	5dbfddb3-35f7-467d-99a5-f0853034d0e2	3d45feb7-fbb0-415e-879b-95eb6ade8d37	522e3d5d-7819-40c3-a56f-0f9ad25f5c34	810465db-f104-4ce9-bbd1-a34860ff98ab	2592000	f	900	t	f	32480b84-20de-484f-9eaf-f6f0caebcb27	0	f	0	0	34492721-3f11-40ca-86e8-2b48b6c7c7e0
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
bruteForceProtected	d173fb4f-af6c-4c50-bd78-301237d5f821	false
permanentLockout	d173fb4f-af6c-4c50-bd78-301237d5f821	false
maxTemporaryLockouts	d173fb4f-af6c-4c50-bd78-301237d5f821	0
bruteForceStrategy	d173fb4f-af6c-4c50-bd78-301237d5f821	MULTIPLE
maxFailureWaitSeconds	d173fb4f-af6c-4c50-bd78-301237d5f821	900
minimumQuickLoginWaitSeconds	d173fb4f-af6c-4c50-bd78-301237d5f821	60
waitIncrementSeconds	d173fb4f-af6c-4c50-bd78-301237d5f821	60
quickLoginCheckMilliSeconds	d173fb4f-af6c-4c50-bd78-301237d5f821	1000
maxDeltaTimeSeconds	d173fb4f-af6c-4c50-bd78-301237d5f821	43200
failureFactor	d173fb4f-af6c-4c50-bd78-301237d5f821	30
realmReusableOtpCode	d173fb4f-af6c-4c50-bd78-301237d5f821	false
firstBrokerLoginFlowId	d173fb4f-af6c-4c50-bd78-301237d5f821	261831b1-f7ea-43c1-8b3e-2e6b9140c82a
displayName	d173fb4f-af6c-4c50-bd78-301237d5f821	Keycloak
displayNameHtml	d173fb4f-af6c-4c50-bd78-301237d5f821	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	d173fb4f-af6c-4c50-bd78-301237d5f821	RS256
offlineSessionMaxLifespanEnabled	d173fb4f-af6c-4c50-bd78-301237d5f821	false
offlineSessionMaxLifespan	d173fb4f-af6c-4c50-bd78-301237d5f821	5184000
_browser_header.contentSecurityPolicyReportOnly	59e3dfd1-7985-4568-9573-4084337fc1d1	
_browser_header.xContentTypeOptions	59e3dfd1-7985-4568-9573-4084337fc1d1	nosniff
_browser_header.referrerPolicy	59e3dfd1-7985-4568-9573-4084337fc1d1	no-referrer
_browser_header.xRobotsTag	59e3dfd1-7985-4568-9573-4084337fc1d1	none
_browser_header.xFrameOptions	59e3dfd1-7985-4568-9573-4084337fc1d1	SAMEORIGIN
_browser_header.contentSecurityPolicy	59e3dfd1-7985-4568-9573-4084337fc1d1	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	59e3dfd1-7985-4568-9573-4084337fc1d1	1; mode=block
_browser_header.strictTransportSecurity	59e3dfd1-7985-4568-9573-4084337fc1d1	max-age=31536000; includeSubDomains
bruteForceProtected	59e3dfd1-7985-4568-9573-4084337fc1d1	false
permanentLockout	59e3dfd1-7985-4568-9573-4084337fc1d1	false
maxTemporaryLockouts	59e3dfd1-7985-4568-9573-4084337fc1d1	0
bruteForceStrategy	59e3dfd1-7985-4568-9573-4084337fc1d1	MULTIPLE
maxFailureWaitSeconds	59e3dfd1-7985-4568-9573-4084337fc1d1	900
minimumQuickLoginWaitSeconds	59e3dfd1-7985-4568-9573-4084337fc1d1	60
waitIncrementSeconds	59e3dfd1-7985-4568-9573-4084337fc1d1	60
quickLoginCheckMilliSeconds	59e3dfd1-7985-4568-9573-4084337fc1d1	1000
maxDeltaTimeSeconds	59e3dfd1-7985-4568-9573-4084337fc1d1	43200
failureFactor	59e3dfd1-7985-4568-9573-4084337fc1d1	30
realmReusableOtpCode	59e3dfd1-7985-4568-9573-4084337fc1d1	false
defaultSignatureAlgorithm	59e3dfd1-7985-4568-9573-4084337fc1d1	RS256
offlineSessionMaxLifespanEnabled	59e3dfd1-7985-4568-9573-4084337fc1d1	false
offlineSessionMaxLifespan	59e3dfd1-7985-4568-9573-4084337fc1d1	5184000
actionTokenGeneratedByAdminLifespan	59e3dfd1-7985-4568-9573-4084337fc1d1	43200
actionTokenGeneratedByUserLifespan	59e3dfd1-7985-4568-9573-4084337fc1d1	300
oauth2DeviceCodeLifespan	59e3dfd1-7985-4568-9573-4084337fc1d1	600
oauth2DevicePollingInterval	59e3dfd1-7985-4568-9573-4084337fc1d1	5
webAuthnPolicyRpEntityName	59e3dfd1-7985-4568-9573-4084337fc1d1	keycloak
webAuthnPolicySignatureAlgorithms	59e3dfd1-7985-4568-9573-4084337fc1d1	ES256,RS256
webAuthnPolicyRpId	59e3dfd1-7985-4568-9573-4084337fc1d1	
webAuthnPolicyAttestationConveyancePreference	59e3dfd1-7985-4568-9573-4084337fc1d1	not specified
webAuthnPolicyAuthenticatorAttachment	59e3dfd1-7985-4568-9573-4084337fc1d1	not specified
webAuthnPolicyRequireResidentKey	59e3dfd1-7985-4568-9573-4084337fc1d1	not specified
webAuthnPolicyUserVerificationRequirement	59e3dfd1-7985-4568-9573-4084337fc1d1	not specified
webAuthnPolicyCreateTimeout	59e3dfd1-7985-4568-9573-4084337fc1d1	0
webAuthnPolicyAvoidSameAuthenticatorRegister	59e3dfd1-7985-4568-9573-4084337fc1d1	false
webAuthnPolicyRpEntityNamePasswordless	59e3dfd1-7985-4568-9573-4084337fc1d1	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	59e3dfd1-7985-4568-9573-4084337fc1d1	ES256,RS256
webAuthnPolicyRpIdPasswordless	59e3dfd1-7985-4568-9573-4084337fc1d1	
webAuthnPolicyAttestationConveyancePreferencePasswordless	59e3dfd1-7985-4568-9573-4084337fc1d1	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	59e3dfd1-7985-4568-9573-4084337fc1d1	not specified
webAuthnPolicyRequireResidentKeyPasswordless	59e3dfd1-7985-4568-9573-4084337fc1d1	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	59e3dfd1-7985-4568-9573-4084337fc1d1	not specified
webAuthnPolicyCreateTimeoutPasswordless	59e3dfd1-7985-4568-9573-4084337fc1d1	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	59e3dfd1-7985-4568-9573-4084337fc1d1	false
cibaBackchannelTokenDeliveryMode	59e3dfd1-7985-4568-9573-4084337fc1d1	poll
cibaExpiresIn	59e3dfd1-7985-4568-9573-4084337fc1d1	120
cibaInterval	59e3dfd1-7985-4568-9573-4084337fc1d1	5
cibaAuthRequestedUserHint	59e3dfd1-7985-4568-9573-4084337fc1d1	login_hint
parRequestUriLifespan	59e3dfd1-7985-4568-9573-4084337fc1d1	60
firstBrokerLoginFlowId	59e3dfd1-7985-4568-9573-4084337fc1d1	3125af29-b88e-43dc-8cde-33f0249fa274
cibaBackchannelTokenDeliveryMode	d173fb4f-af6c-4c50-bd78-301237d5f821	poll
cibaExpiresIn	d173fb4f-af6c-4c50-bd78-301237d5f821	120
cibaAuthRequestedUserHint	d173fb4f-af6c-4c50-bd78-301237d5f821	login_hint
parRequestUriLifespan	d173fb4f-af6c-4c50-bd78-301237d5f821	60
cibaInterval	d173fb4f-af6c-4c50-bd78-301237d5f821	5
organizationsEnabled	d173fb4f-af6c-4c50-bd78-301237d5f821	false
adminPermissionsEnabled	d173fb4f-af6c-4c50-bd78-301237d5f821	false
verifiableCredentialsEnabled	d173fb4f-af6c-4c50-bd78-301237d5f821	false
actionTokenGeneratedByAdminLifespan	d173fb4f-af6c-4c50-bd78-301237d5f821	43200
actionTokenGeneratedByUserLifespan	d173fb4f-af6c-4c50-bd78-301237d5f821	300
oauth2DeviceCodeLifespan	d173fb4f-af6c-4c50-bd78-301237d5f821	600
oauth2DevicePollingInterval	d173fb4f-af6c-4c50-bd78-301237d5f821	5
clientSessionIdleTimeout	d173fb4f-af6c-4c50-bd78-301237d5f821	0
clientSessionMaxLifespan	d173fb4f-af6c-4c50-bd78-301237d5f821	0
clientOfflineSessionIdleTimeout	d173fb4f-af6c-4c50-bd78-301237d5f821	0
clientOfflineSessionMaxLifespan	d173fb4f-af6c-4c50-bd78-301237d5f821	0
webAuthnPolicyRpEntityName	d173fb4f-af6c-4c50-bd78-301237d5f821	keycloak
webAuthnPolicySignatureAlgorithms	d173fb4f-af6c-4c50-bd78-301237d5f821	ES256,RS256
webAuthnPolicyRpId	d173fb4f-af6c-4c50-bd78-301237d5f821	
webAuthnPolicyAttestationConveyancePreference	d173fb4f-af6c-4c50-bd78-301237d5f821	not specified
webAuthnPolicyAuthenticatorAttachment	d173fb4f-af6c-4c50-bd78-301237d5f821	not specified
webAuthnPolicyRequireResidentKey	d173fb4f-af6c-4c50-bd78-301237d5f821	not specified
webAuthnPolicyUserVerificationRequirement	d173fb4f-af6c-4c50-bd78-301237d5f821	not specified
webAuthnPolicyCreateTimeout	d173fb4f-af6c-4c50-bd78-301237d5f821	0
webAuthnPolicyAvoidSameAuthenticatorRegister	d173fb4f-af6c-4c50-bd78-301237d5f821	false
webAuthnPolicyRpEntityNamePasswordless	d173fb4f-af6c-4c50-bd78-301237d5f821	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	d173fb4f-af6c-4c50-bd78-301237d5f821	ES256,RS256
webAuthnPolicyRpIdPasswordless	d173fb4f-af6c-4c50-bd78-301237d5f821	
webAuthnPolicyAttestationConveyancePreferencePasswordless	d173fb4f-af6c-4c50-bd78-301237d5f821	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	d173fb4f-af6c-4c50-bd78-301237d5f821	not specified
webAuthnPolicyRequireResidentKeyPasswordless	d173fb4f-af6c-4c50-bd78-301237d5f821	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	d173fb4f-af6c-4c50-bd78-301237d5f821	not specified
webAuthnPolicyCreateTimeoutPasswordless	d173fb4f-af6c-4c50-bd78-301237d5f821	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	d173fb4f-af6c-4c50-bd78-301237d5f821	false
client-policies.profiles	d173fb4f-af6c-4c50-bd78-301237d5f821	{"profiles":[]}
client-policies.policies	d173fb4f-af6c-4c50-bd78-301237d5f821	{"policies":[]}
_browser_header.contentSecurityPolicyReportOnly	d173fb4f-af6c-4c50-bd78-301237d5f821	
_browser_header.xContentTypeOptions	d173fb4f-af6c-4c50-bd78-301237d5f821	nosniff
_browser_header.referrerPolicy	d173fb4f-af6c-4c50-bd78-301237d5f821	no-referrer
_browser_header.xRobotsTag	d173fb4f-af6c-4c50-bd78-301237d5f821	none
_browser_header.xFrameOptions	d173fb4f-af6c-4c50-bd78-301237d5f821	SAMEORIGIN
_browser_header.contentSecurityPolicy	d173fb4f-af6c-4c50-bd78-301237d5f821	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	d173fb4f-af6c-4c50-bd78-301237d5f821	1; mode=block
_browser_header.strictTransportSecurity	d173fb4f-af6c-4c50-bd78-301237d5f821	max-age=31536000; includeSubDomains
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
59e3dfd1-7985-4568-9573-4084337fc1d1	jboss-logging
d173fb4f-af6c-4c50-bd78-301237d5f821	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	d173fb4f-af6c-4c50-bd78-301237d5f821
password	password	t	t	59e3dfd1-7985-4568-9573-4084337fc1d1
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: recipe; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.recipe (id, created_at, created_by, last_modified_at, last_modified_by, cook_time, instructions, prep_time, title, user_id) FROM stdin;
\.


--
-- Data for Name: recipes_tags; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.recipes_tags (tag_id, recipe_id) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.redirect_uris (client_id, value) FROM stdin;
592457f4-a68f-45f3-afaf-0654dbe57d2e	/realms/master/account/*
01d6fa70-0341-4466-a5b9-3307c640576d	/realms/master/account/*
ad57c361-819a-46bd-8c9e-d7d6b90482bc	/admin/master/console/*
f1cf0338-5613-46d5-ae30-182027f6c52a	/realms/mealwurm/account/*
516bb66b-5bd7-4c4b-9d12-b8a88c7f010c	/realms/mealwurm/account/*
33071a57-6cad-4a45-a1e9-17a7df75f18e	/admin/mealwurm/console/*
e45acc0e-3df5-4b55-83ec-9beeaef25c04	http://localhost:3000/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
100ac909-783e-4978-9aff-23d9c5cdd437	VERIFY_EMAIL	Verify Email	d173fb4f-af6c-4c50-bd78-301237d5f821	t	f	VERIFY_EMAIL	50
96b3a962-fd33-4c8a-9ffe-3d3ddadb681c	UPDATE_PROFILE	Update Profile	d173fb4f-af6c-4c50-bd78-301237d5f821	t	f	UPDATE_PROFILE	40
e007487a-ec55-40da-abb9-042eb83a2b32	CONFIGURE_TOTP	Configure OTP	d173fb4f-af6c-4c50-bd78-301237d5f821	t	f	CONFIGURE_TOTP	10
533bf5a0-063c-4af1-86e4-a4200b4fdde2	UPDATE_PASSWORD	Update Password	d173fb4f-af6c-4c50-bd78-301237d5f821	t	f	UPDATE_PASSWORD	30
1f9da0fc-00df-4308-8cb0-c9860889f739	TERMS_AND_CONDITIONS	Terms and Conditions	d173fb4f-af6c-4c50-bd78-301237d5f821	f	f	TERMS_AND_CONDITIONS	20
879d7f50-8c9d-4246-82d1-32876ae3ce3f	delete_account	Delete Account	d173fb4f-af6c-4c50-bd78-301237d5f821	f	f	delete_account	60
f30c6e7f-5e25-4abc-87e7-d882ce148920	delete_credential	Delete Credential	d173fb4f-af6c-4c50-bd78-301237d5f821	t	f	delete_credential	100
7895e125-dc6c-440b-a1ae-30b2fc64ba6c	update_user_locale	Update User Locale	d173fb4f-af6c-4c50-bd78-301237d5f821	t	f	update_user_locale	1000
261c74a5-ccdf-44b5-8dc3-259c84169602	webauthn-register	Webauthn Register	d173fb4f-af6c-4c50-bd78-301237d5f821	t	f	webauthn-register	70
5fe07559-3064-4415-86ba-1fa2af9d7841	webauthn-register-passwordless	Webauthn Register Passwordless	d173fb4f-af6c-4c50-bd78-301237d5f821	t	f	webauthn-register-passwordless	80
75800680-2a48-4782-8655-c8c7e0c58bf3	VERIFY_PROFILE	Verify Profile	d173fb4f-af6c-4c50-bd78-301237d5f821	t	f	VERIFY_PROFILE	90
ff1c652e-2f4f-490f-8540-8807bf3657c4	VERIFY_EMAIL	Verify Email	59e3dfd1-7985-4568-9573-4084337fc1d1	t	f	VERIFY_EMAIL	50
f1fc6c0e-60ec-4117-9368-a053eeb3ba43	UPDATE_PROFILE	Update Profile	59e3dfd1-7985-4568-9573-4084337fc1d1	t	f	UPDATE_PROFILE	40
afaa2d08-46eb-4cf2-af6c-ba95af9e3ff8	CONFIGURE_TOTP	Configure OTP	59e3dfd1-7985-4568-9573-4084337fc1d1	t	f	CONFIGURE_TOTP	10
10464423-38ab-481b-acec-303451c0f10c	UPDATE_PASSWORD	Update Password	59e3dfd1-7985-4568-9573-4084337fc1d1	t	f	UPDATE_PASSWORD	30
c561daea-3b29-414c-8ce9-230357977fd1	TERMS_AND_CONDITIONS	Terms and Conditions	59e3dfd1-7985-4568-9573-4084337fc1d1	f	f	TERMS_AND_CONDITIONS	20
8564fe13-acc2-4745-8168-690e304c8c00	delete_account	Delete Account	59e3dfd1-7985-4568-9573-4084337fc1d1	f	f	delete_account	60
c62d5dfa-43e5-4837-94b4-6dac78ef3100	delete_credential	Delete Credential	59e3dfd1-7985-4568-9573-4084337fc1d1	t	f	delete_credential	100
cbc34913-ab3f-4c2b-90e9-2f72a3005ada	update_user_locale	Update User Locale	59e3dfd1-7985-4568-9573-4084337fc1d1	t	f	update_user_locale	1000
fa2cfdd5-8ade-4444-9c91-5d43b0381f5d	webauthn-register	Webauthn Register	59e3dfd1-7985-4568-9573-4084337fc1d1	t	f	webauthn-register	70
374def9a-54c3-4905-a6cc-28066b517105	webauthn-register-passwordless	Webauthn Register Passwordless	59e3dfd1-7985-4568-9573-4084337fc1d1	t	f	webauthn-register-passwordless	80
1bd94e06-1253-44d5-8637-deba9c1f3898	VERIFY_PROFILE	Verify Profile	59e3dfd1-7985-4568-9573-4084337fc1d1	t	f	VERIFY_PROFILE	90
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: revoked_token; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.revoked_token (id, expire) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
01d6fa70-0341-4466-a5b9-3307c640576d	33d02ac0-7eb7-482f-8eb1-c8f366bb051e
01d6fa70-0341-4466-a5b9-3307c640576d	1067c0ba-f341-4ef7-b6f1-0f684ae54341
516bb66b-5bd7-4c4b-9d12-b8a88c7f010c	9ba4b112-8e0b-420a-8b80-3ce4fc33439c
516bb66b-5bd7-4c4b-9d12-b8a88c7f010c	ed04fe23-7f4c-4e30-87d3-efe7f50edf06
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.tag (id, created_at, created_by, last_modified_at, last_modified_by, name, user_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.user_attribute (name, value, user_id, id, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
is_temporary_admin	true	2e99540b-145d-4f92-9ef4-fbe2a3a9e28c	dc4c3bfd-244f-4699-a14c-f5b52137c98b	\N	\N	\N
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
2e99540b-145d-4f92-9ef4-fbe2a3a9e28c	\N	8cc4fb02-bb3c-48fc-86ac-298ea347ec3a	f	t	\N	\N	\N	d173fb4f-af6c-4c50-bd78-301237d5f821	admin	1755016459973	\N	0
d77c8420-723d-4785-bc2a-e8aca8a4a741	test@test.com	test@test.com	t	t	\N	Jane	Doe	59e3dfd1-7985-4568-9573-4084337fc1d1	user	1755016636567	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.user_group_membership (group_id, user_id, membership_type) FROM stdin;
\.


--
-- Data for Name: user_mealwyrm; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.user_mealwyrm (id, created_at, email, last_modified_at, username) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
34492721-3f11-40ca-86e8-2b48b6c7c7e0	2e99540b-145d-4f92-9ef4-fbe2a3a9e28c
2c8866c2-dc17-4b3e-8f71-e73da9b7dd4e	2e99540b-145d-4f92-9ef4-fbe2a3a9e28c
0d4fb0db-d34f-428f-b286-be511c0d6395	d77c8420-723d-4785-bc2a-e8aca8a4a741
41e054a5-5c38-4b61-95a2-78b6fc0794f2	d77c8420-723d-4785-bc2a-e8aca8a4a741
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.web_origins (client_id, value) FROM stdin;
ad57c361-819a-46bd-8c9e-d7d6b90482bc	+
33071a57-6cad-4a45-a1e9-17a7df75f18e	+
e45acc0e-3df5-4b55-83ec-9beeaef25c04	http://localhost:3000
\.


--
-- Name: org_domain ORG_DOMAIN_pkey; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.org_domain
    ADD CONSTRAINT "ORG_DOMAIN_pkey" PRIMARY KEY (id, name);


--
-- Name: org ORG_pkey; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT "ORG_pkey" PRIMARY KEY (id);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: jgroups_ping constraint_jgroups_ping; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.jgroups_ping
    ADD CONSTRAINT constraint_jgroups_ping PRIMARY KEY (address);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: revoked_token constraint_rt; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.revoked_token
    ADD CONSTRAINT constraint_rt PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: ingredient ingredient_pkey; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.ingredient
    ADD CONSTRAINT ingredient_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: recipe recipe_pkey; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.recipe
    ADD CONSTRAINT recipe_pkey PRIMARY KEY (id);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: tag tag_pkey; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY (id);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: user_consent uk_external_consent; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_external_consent UNIQUE (client_storage_provider, external_client_id, user_id);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_local_consent; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_local_consent UNIQUE (client_id, user_id);


--
-- Name: org uk_org_alias; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_alias UNIQUE (realm_id, alias);


--
-- Name: org uk_org_group; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_group UNIQUE (group_id);


--
-- Name: org uk_org_name; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_name UNIQUE (realm_id, name);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: user_mealwyrm user_mealwyrm_pkey; Type: CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.user_mealwyrm
    ADD CONSTRAINT user_mealwyrm_pkey PRIMARY KEY (id);


--
-- Name: fed_user_attr_long_values; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX fed_user_attr_long_values ON public.fed_user_attribute USING btree (long_value_hash, name);


--
-- Name: fed_user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX fed_user_attr_long_values_lower_case ON public.fed_user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, substr(value, 1, 255));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_idp_for_login; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_idp_for_login ON public.identity_provider USING btree (realm_id, enabled, link_only, hide_on_login, organization_id);


--
-- Name: idx_idp_realm_org; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_idp_realm_org ON public.identity_provider USING btree (realm_id, organization_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_uss_by_broker_session_id; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_offline_uss_by_broker_session_id ON public.offline_user_session USING btree (broker_session_id, realm_id);


--
-- Name: idx_offline_uss_by_last_session_refresh; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_offline_uss_by_last_session_refresh ON public.offline_user_session USING btree (realm_id, offline_flag, last_session_refresh);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_org_domain_org_id; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_org_domain_org_id ON public.org_domain USING btree (org_id);


--
-- Name: idx_perm_ticket_owner; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_perm_ticket_owner ON public.resource_server_perm_ticket USING btree (owner);


--
-- Name: idx_perm_ticket_requester; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_perm_ticket_requester ON public.resource_server_perm_ticket USING btree (requester);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_rev_token_on_expire; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_rev_token_on_expire ON public.revoked_token USING btree (expire);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_usconsent_scope_id; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_usconsent_scope_id ON public.user_consent_client_scope USING btree (scope_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: user_attr_long_values; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX user_attr_long_values ON public.user_attribute USING btree (long_value_hash, name);


--
-- Name: user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: mealwurm
--

CREATE INDEX user_attr_long_values_lower_case ON public.user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: recipes_tags fk1aclg8mjue39rqjtkhb6a3gyo; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.recipes_tags
    ADD CONSTRAINT fk1aclg8mjue39rqjtkhb6a3gyo FOREIGN KEY (tag_id) REFERENCES public.tag(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- Name: tag fkeqvssx8uvrygt2yvfos0lpi0m; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT fkeqvssx8uvrygt2yvfos0lpi0m FOREIGN KEY (user_id) REFERENCES public.user_mealwyrm(id);


--
-- Name: recipe fkf3w7919cuxwp375i5qggrotc1; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.recipe
    ADD CONSTRAINT fkf3w7919cuxwp375i5qggrotc1 FOREIGN KEY (user_id) REFERENCES public.user_mealwyrm(id);


--
-- Name: ingredient fkj0s4ywmqqqw4h5iommigh5yja; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.ingredient
    ADD CONSTRAINT fkj0s4ywmqqqw4h5iommigh5yja FOREIGN KEY (recipe_id) REFERENCES public.recipe(id);


--
-- Name: recipes_tags fktiqr6955gihe06pulh6o28rrg; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.recipes_tags
    ADD CONSTRAINT fktiqr6955gihe06pulh6o28rrg FOREIGN KEY (recipe_id) REFERENCES public.recipe(id);


--
-- PostgreSQL database dump complete
--

