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
    id character varying(36) NOT NULL,
    created_at timestamp(6) without time zone,
    created_by character varying(255),
    last_modified_at timestamp(6) without time zone,
    last_modified_by character varying(255),
    ingredient_order integer NOT NULL,
    text character varying(255),
    recipe_id character varying(36)
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
    id character varying(36) NOT NULL,
    created_at timestamp(6) without time zone,
    created_by character varying(255),
    last_modified_at timestamp(6) without time zone,
    last_modified_by character varying(255),
    cook_time integer NOT NULL,
    instructions text,
    prep_time integer NOT NULL,
    title character varying(255),
    user_id character varying(36)
);


ALTER TABLE public.recipe OWNER TO mealwurm;

--
-- Name: recipes_tags; Type: TABLE; Schema: public; Owner: mealwurm
--

CREATE TABLE public.recipes_tags (
    tag_id character varying(36) NOT NULL,
    recipe_id character varying(36) NOT NULL
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
    id character varying(36) NOT NULL,
    created_at timestamp(6) without time zone,
    created_by character varying(255),
    last_modified_at timestamp(6) without time zone,
    last_modified_by character varying(255),
    name character varying(255),
    user_id character varying(36)
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
a9a035ad-114b-41bf-ad48-2d719e23c275	\N	auth-cookie	cce4122f-9b89-420a-bd97-dc991169c190	69a25179-b194-402a-b7d0-ffd52f3f6a03	2	10	f	\N	\N
9e4d6c24-8361-44fa-b08e-dbc7d27f3f2e	\N	auth-spnego	cce4122f-9b89-420a-bd97-dc991169c190	69a25179-b194-402a-b7d0-ffd52f3f6a03	3	20	f	\N	\N
24dcaf65-2505-4aed-9bee-cca071a8a354	\N	identity-provider-redirector	cce4122f-9b89-420a-bd97-dc991169c190	69a25179-b194-402a-b7d0-ffd52f3f6a03	2	25	f	\N	\N
1df7175e-b18f-4835-9dcc-bff78dc11e55	\N	\N	cce4122f-9b89-420a-bd97-dc991169c190	69a25179-b194-402a-b7d0-ffd52f3f6a03	2	30	t	6feb14c4-7746-44d8-88f7-6383faf5ce0a	\N
ae5920a8-f43c-4752-ada5-5cd539fb5b8d	\N	auth-username-password-form	cce4122f-9b89-420a-bd97-dc991169c190	6feb14c4-7746-44d8-88f7-6383faf5ce0a	0	10	f	\N	\N
ceea3b99-cdc3-4631-b255-0bf756cc53b4	\N	\N	cce4122f-9b89-420a-bd97-dc991169c190	6feb14c4-7746-44d8-88f7-6383faf5ce0a	1	20	t	cb084dd4-1d75-429b-b5a7-6740672b6412	\N
938a26c8-02a6-4517-a6a0-c386999065b6	\N	conditional-user-configured	cce4122f-9b89-420a-bd97-dc991169c190	cb084dd4-1d75-429b-b5a7-6740672b6412	0	10	f	\N	\N
c77362f9-6422-4fcd-9235-0033a0957433	\N	auth-otp-form	cce4122f-9b89-420a-bd97-dc991169c190	cb084dd4-1d75-429b-b5a7-6740672b6412	0	20	f	\N	\N
4f1edbe5-1a4c-45d3-a6d4-44bce3de2b51	\N	direct-grant-validate-username	cce4122f-9b89-420a-bd97-dc991169c190	ed2d371c-ead3-450b-a637-182ffa8469be	0	10	f	\N	\N
3f95a5a7-7b28-4d02-9c90-c4c5b2621268	\N	direct-grant-validate-password	cce4122f-9b89-420a-bd97-dc991169c190	ed2d371c-ead3-450b-a637-182ffa8469be	0	20	f	\N	\N
5ab3e883-5465-4799-9da5-9d9f0f413ff9	\N	\N	cce4122f-9b89-420a-bd97-dc991169c190	ed2d371c-ead3-450b-a637-182ffa8469be	1	30	t	37f8e773-c8ff-4dbb-9dc9-773f69e9796d	\N
8e04d3c8-2e0d-4a2d-8318-3188f35da3a4	\N	conditional-user-configured	cce4122f-9b89-420a-bd97-dc991169c190	37f8e773-c8ff-4dbb-9dc9-773f69e9796d	0	10	f	\N	\N
93133c61-de01-4dc4-87f7-6aed38760fb6	\N	direct-grant-validate-otp	cce4122f-9b89-420a-bd97-dc991169c190	37f8e773-c8ff-4dbb-9dc9-773f69e9796d	0	20	f	\N	\N
6e194c0b-075f-44bd-841d-8c14b9188dd6	\N	registration-page-form	cce4122f-9b89-420a-bd97-dc991169c190	35ebe2df-2086-4536-8953-103a9c4477c4	0	10	t	620211bb-1c6e-45f9-9a64-e4f970ab8231	\N
40f2c72e-92e0-45ec-8e49-0e083d1b63b7	\N	registration-user-creation	cce4122f-9b89-420a-bd97-dc991169c190	620211bb-1c6e-45f9-9a64-e4f970ab8231	0	20	f	\N	\N
4e988908-3ab6-4413-b67e-88b31186b31c	\N	registration-password-action	cce4122f-9b89-420a-bd97-dc991169c190	620211bb-1c6e-45f9-9a64-e4f970ab8231	0	50	f	\N	\N
819953ea-b7c1-42ef-919f-a1a9d30b892f	\N	registration-recaptcha-action	cce4122f-9b89-420a-bd97-dc991169c190	620211bb-1c6e-45f9-9a64-e4f970ab8231	3	60	f	\N	\N
7c63effb-e8f1-46a4-a4ee-c5fa4bb3e491	\N	registration-terms-and-conditions	cce4122f-9b89-420a-bd97-dc991169c190	620211bb-1c6e-45f9-9a64-e4f970ab8231	3	70	f	\N	\N
a8b63479-98b6-4487-a417-ca05f3fd15bf	\N	reset-credentials-choose-user	cce4122f-9b89-420a-bd97-dc991169c190	e732dcf6-d163-4076-b37c-1f6067fd9e0e	0	10	f	\N	\N
c5b34921-ffe0-4b0c-8ea8-c30b096be731	\N	reset-credential-email	cce4122f-9b89-420a-bd97-dc991169c190	e732dcf6-d163-4076-b37c-1f6067fd9e0e	0	20	f	\N	\N
2eba7021-4978-47fe-8eb6-f0008ff680f3	\N	reset-password	cce4122f-9b89-420a-bd97-dc991169c190	e732dcf6-d163-4076-b37c-1f6067fd9e0e	0	30	f	\N	\N
428b3019-1c03-42cb-bc16-dded9fa271c1	\N	\N	cce4122f-9b89-420a-bd97-dc991169c190	e732dcf6-d163-4076-b37c-1f6067fd9e0e	1	40	t	8ab1dcc4-3f1f-428d-949a-ad1dadaed598	\N
df5bd495-75c2-4ebb-bc9e-0a26fceeebcf	\N	conditional-user-configured	cce4122f-9b89-420a-bd97-dc991169c190	8ab1dcc4-3f1f-428d-949a-ad1dadaed598	0	10	f	\N	\N
03485a81-b767-4f5d-a263-03dd72540544	\N	reset-otp	cce4122f-9b89-420a-bd97-dc991169c190	8ab1dcc4-3f1f-428d-949a-ad1dadaed598	0	20	f	\N	\N
f7d76ec8-4b22-497d-8154-1e43377d935b	\N	client-secret	cce4122f-9b89-420a-bd97-dc991169c190	ebb0eb59-e3b7-4c6a-a5c4-7f72f0b54c2e	2	10	f	\N	\N
c33c41a2-e6db-4bf3-9f89-7bb76eb30237	\N	client-jwt	cce4122f-9b89-420a-bd97-dc991169c190	ebb0eb59-e3b7-4c6a-a5c4-7f72f0b54c2e	2	20	f	\N	\N
6dfea95e-01c3-4863-b325-557ca971d510	\N	client-secret-jwt	cce4122f-9b89-420a-bd97-dc991169c190	ebb0eb59-e3b7-4c6a-a5c4-7f72f0b54c2e	2	30	f	\N	\N
feb45725-1341-47f6-9b67-7c2c7c71837a	\N	client-x509	cce4122f-9b89-420a-bd97-dc991169c190	ebb0eb59-e3b7-4c6a-a5c4-7f72f0b54c2e	2	40	f	\N	\N
0a0e768c-acd1-4e97-a5ec-b4fb28620aa2	\N	idp-review-profile	cce4122f-9b89-420a-bd97-dc991169c190	a199ef20-4e50-4d45-a722-f11ea38c5eb2	0	10	f	\N	4c7e85e8-4b6a-4aef-8656-5dd6333a71a5
637757c3-28eb-472e-9a1f-15d5a2773192	\N	\N	cce4122f-9b89-420a-bd97-dc991169c190	a199ef20-4e50-4d45-a722-f11ea38c5eb2	0	20	t	2ce325fc-f377-4bed-a01e-344c399568ec	\N
f693ecc1-2e1c-42bf-9fa3-936ab42da67d	\N	idp-create-user-if-unique	cce4122f-9b89-420a-bd97-dc991169c190	2ce325fc-f377-4bed-a01e-344c399568ec	2	10	f	\N	b2d29620-20cd-421f-a4c4-2cc0dd2d5a09
1381a070-baa4-44aa-8446-b9edf7610892	\N	\N	cce4122f-9b89-420a-bd97-dc991169c190	2ce325fc-f377-4bed-a01e-344c399568ec	2	20	t	47639264-cae3-4fc1-ab5e-fb068b0a1eb5	\N
595caba9-3346-4096-a59d-2a7d2470cc9f	\N	idp-confirm-link	cce4122f-9b89-420a-bd97-dc991169c190	47639264-cae3-4fc1-ab5e-fb068b0a1eb5	0	10	f	\N	\N
ae13145f-3e5e-4b59-9c0e-d13ac93e9fd8	\N	\N	cce4122f-9b89-420a-bd97-dc991169c190	47639264-cae3-4fc1-ab5e-fb068b0a1eb5	0	20	t	aaf2a050-1619-4fff-b973-e7ca59e24889	\N
e8a1f646-8235-4487-9a9b-235aff6dc181	\N	idp-email-verification	cce4122f-9b89-420a-bd97-dc991169c190	aaf2a050-1619-4fff-b973-e7ca59e24889	2	10	f	\N	\N
38468692-30c9-494a-a120-3cb8cdc248bb	\N	\N	cce4122f-9b89-420a-bd97-dc991169c190	aaf2a050-1619-4fff-b973-e7ca59e24889	2	20	t	3e055004-ee12-433c-a323-b156904ffe12	\N
45b4a9a0-5083-4be8-92a6-3f7769888476	\N	idp-username-password-form	cce4122f-9b89-420a-bd97-dc991169c190	3e055004-ee12-433c-a323-b156904ffe12	0	10	f	\N	\N
65e3a64e-5db9-439f-bc5e-b9aaddff2fc4	\N	\N	cce4122f-9b89-420a-bd97-dc991169c190	3e055004-ee12-433c-a323-b156904ffe12	1	20	t	3da8c1d0-3764-47ff-ae1c-e37e05bcf5a1	\N
4dd1bb40-46f8-481f-8301-ecd37d7472cd	\N	conditional-user-configured	cce4122f-9b89-420a-bd97-dc991169c190	3da8c1d0-3764-47ff-ae1c-e37e05bcf5a1	0	10	f	\N	\N
7b32fd61-4fd1-49c9-8fe9-f1f88a8e823d	\N	auth-otp-form	cce4122f-9b89-420a-bd97-dc991169c190	3da8c1d0-3764-47ff-ae1c-e37e05bcf5a1	0	20	f	\N	\N
bcfeda00-b44e-47d6-aab5-d666b1a3b9e1	\N	http-basic-authenticator	cce4122f-9b89-420a-bd97-dc991169c190	7c2d8e43-1d57-4554-b8ac-8984d35bcb2a	0	10	f	\N	\N
bc58ee92-0fb6-407b-9b2b-1e530efc143a	\N	docker-http-basic-authenticator	cce4122f-9b89-420a-bd97-dc991169c190	c3249293-ec9c-4fb9-a051-91e6a878ec12	0	10	f	\N	\N
719dfae1-c693-4a43-95be-73f7744c8f54	\N	auth-cookie	38d94c69-6603-4341-a226-f65366146032	d44239b3-06eb-4ec1-9f94-a09d967fcbf4	2	10	f	\N	\N
3799e82c-630b-4f53-986d-273b0cf8dc6b	\N	auth-spnego	38d94c69-6603-4341-a226-f65366146032	d44239b3-06eb-4ec1-9f94-a09d967fcbf4	3	20	f	\N	\N
a1d46391-8a41-4048-b373-2a96a81e36dc	\N	identity-provider-redirector	38d94c69-6603-4341-a226-f65366146032	d44239b3-06eb-4ec1-9f94-a09d967fcbf4	2	25	f	\N	\N
d3024203-112d-4fdb-83c7-60d350c3053d	\N	\N	38d94c69-6603-4341-a226-f65366146032	d44239b3-06eb-4ec1-9f94-a09d967fcbf4	2	30	t	34cc3064-fc21-4558-bd7c-0eb6716d13c4	\N
38c835c9-8323-4bb4-b38b-42fa42029de7	\N	auth-username-password-form	38d94c69-6603-4341-a226-f65366146032	34cc3064-fc21-4558-bd7c-0eb6716d13c4	0	10	f	\N	\N
ee4142cc-1e2e-4184-822f-2889a3734c29	\N	\N	38d94c69-6603-4341-a226-f65366146032	34cc3064-fc21-4558-bd7c-0eb6716d13c4	1	20	t	64b99d2b-d366-42b7-86d7-13aa1bd8c46b	\N
5c1300c1-3dd6-4a32-a0db-04a11f9b7f62	\N	conditional-user-configured	38d94c69-6603-4341-a226-f65366146032	64b99d2b-d366-42b7-86d7-13aa1bd8c46b	0	10	f	\N	\N
932c390a-9cd5-4e6a-ae8c-2ea743f5d07f	\N	auth-otp-form	38d94c69-6603-4341-a226-f65366146032	64b99d2b-d366-42b7-86d7-13aa1bd8c46b	0	20	f	\N	\N
a9e4fcce-040c-4004-adbd-e79ef1b207cb	\N	\N	38d94c69-6603-4341-a226-f65366146032	d44239b3-06eb-4ec1-9f94-a09d967fcbf4	2	26	t	bf682728-1aca-4bc3-846c-1bb815606c2a	\N
5b3c4b89-27ff-4a43-9b5b-0b4f8bb05d22	\N	\N	38d94c69-6603-4341-a226-f65366146032	bf682728-1aca-4bc3-846c-1bb815606c2a	1	10	t	58fee30b-4659-4896-9a18-eeb00c34cde5	\N
2ca728a2-9634-4319-bf23-537c74784bf5	\N	conditional-user-configured	38d94c69-6603-4341-a226-f65366146032	58fee30b-4659-4896-9a18-eeb00c34cde5	0	10	f	\N	\N
f5867a22-197e-4e35-b871-696a129ff20c	\N	organization	38d94c69-6603-4341-a226-f65366146032	58fee30b-4659-4896-9a18-eeb00c34cde5	2	20	f	\N	\N
2195c4ef-3e2b-4f14-b42c-039e4db8e5a6	\N	direct-grant-validate-username	38d94c69-6603-4341-a226-f65366146032	400c7467-cda2-49a2-bcf8-5960c5bb1694	0	10	f	\N	\N
cdeb1f8a-0884-493b-b0dc-356e4684a81b	\N	direct-grant-validate-password	38d94c69-6603-4341-a226-f65366146032	400c7467-cda2-49a2-bcf8-5960c5bb1694	0	20	f	\N	\N
8ce51351-cd52-48f9-ad2e-1e6effdb15f0	\N	\N	38d94c69-6603-4341-a226-f65366146032	400c7467-cda2-49a2-bcf8-5960c5bb1694	1	30	t	e88dd8b9-2225-49df-a4b9-d9e1a11a842d	\N
57652972-5c76-4aa1-9de3-a8c56fc39819	\N	conditional-user-configured	38d94c69-6603-4341-a226-f65366146032	e88dd8b9-2225-49df-a4b9-d9e1a11a842d	0	10	f	\N	\N
ac761cbd-7ac4-4e17-94c2-6f9d95f37998	\N	direct-grant-validate-otp	38d94c69-6603-4341-a226-f65366146032	e88dd8b9-2225-49df-a4b9-d9e1a11a842d	0	20	f	\N	\N
c5ff93b3-1129-45e2-af8d-004969253d3e	\N	registration-page-form	38d94c69-6603-4341-a226-f65366146032	da777280-03fd-4447-b2d2-5970166e6ab5	0	10	t	0b4bbb6b-d9da-4180-9e8a-4ca2617e82ba	\N
5411c3a9-01a1-40f0-b6a3-8aa5cf78a68e	\N	registration-user-creation	38d94c69-6603-4341-a226-f65366146032	0b4bbb6b-d9da-4180-9e8a-4ca2617e82ba	0	20	f	\N	\N
3964b1ba-609e-4390-92ee-cea38d4b63f0	\N	registration-password-action	38d94c69-6603-4341-a226-f65366146032	0b4bbb6b-d9da-4180-9e8a-4ca2617e82ba	0	50	f	\N	\N
b8ef9ca6-d503-4381-8a19-40182d904a74	\N	registration-recaptcha-action	38d94c69-6603-4341-a226-f65366146032	0b4bbb6b-d9da-4180-9e8a-4ca2617e82ba	3	60	f	\N	\N
3988002a-7007-45ab-8c1f-ffb0e4a394a3	\N	registration-terms-and-conditions	38d94c69-6603-4341-a226-f65366146032	0b4bbb6b-d9da-4180-9e8a-4ca2617e82ba	3	70	f	\N	\N
b15ce211-1ca6-47ac-b5c6-035413a1aecc	\N	reset-credentials-choose-user	38d94c69-6603-4341-a226-f65366146032	36f4fca7-4154-4eda-898c-83d622d24cf0	0	10	f	\N	\N
be5d7af7-604a-4a43-87cd-0bdf0d158b7c	\N	reset-credential-email	38d94c69-6603-4341-a226-f65366146032	36f4fca7-4154-4eda-898c-83d622d24cf0	0	20	f	\N	\N
82574ec5-409d-4c92-a33e-32db89dcb74f	\N	reset-password	38d94c69-6603-4341-a226-f65366146032	36f4fca7-4154-4eda-898c-83d622d24cf0	0	30	f	\N	\N
bbcfbac9-71b1-469c-a778-7aeadf5486fa	\N	\N	38d94c69-6603-4341-a226-f65366146032	36f4fca7-4154-4eda-898c-83d622d24cf0	1	40	t	3c94d05e-a44f-459c-b179-55e8ec097a08	\N
df6786df-335e-40d0-9f89-570ddce34332	\N	conditional-user-configured	38d94c69-6603-4341-a226-f65366146032	3c94d05e-a44f-459c-b179-55e8ec097a08	0	10	f	\N	\N
01627d42-7ef7-4a47-b89a-25b5bf05c194	\N	reset-otp	38d94c69-6603-4341-a226-f65366146032	3c94d05e-a44f-459c-b179-55e8ec097a08	0	20	f	\N	\N
c2b9bab7-634e-404b-bf05-12d7f311f5f9	\N	client-secret	38d94c69-6603-4341-a226-f65366146032	23e7836d-ed1c-4d5c-94b4-1807077c0c26	2	10	f	\N	\N
73b0d59b-14b1-46c1-829a-e03b55450ea0	\N	client-jwt	38d94c69-6603-4341-a226-f65366146032	23e7836d-ed1c-4d5c-94b4-1807077c0c26	2	20	f	\N	\N
1693e5c4-494f-4291-9de6-b549d8532d21	\N	client-secret-jwt	38d94c69-6603-4341-a226-f65366146032	23e7836d-ed1c-4d5c-94b4-1807077c0c26	2	30	f	\N	\N
9a147101-c591-4b11-b29f-4b8e984238dc	\N	client-x509	38d94c69-6603-4341-a226-f65366146032	23e7836d-ed1c-4d5c-94b4-1807077c0c26	2	40	f	\N	\N
3e73116f-77af-43c3-8d86-0a5f055b4d40	\N	idp-review-profile	38d94c69-6603-4341-a226-f65366146032	eaa8a50d-cb90-43d8-8cc5-aec3eaf24f56	0	10	f	\N	2e73e467-7370-46dc-bf2a-f1f3a533b9d0
fb3db92d-d8e3-45bb-bf81-bb8c7ad009f7	\N	\N	38d94c69-6603-4341-a226-f65366146032	eaa8a50d-cb90-43d8-8cc5-aec3eaf24f56	0	20	t	799be8b0-18a4-48a8-ab6e-d3d6d038e266	\N
0326f863-a7f5-40a0-941a-a62746bfa81c	\N	idp-create-user-if-unique	38d94c69-6603-4341-a226-f65366146032	799be8b0-18a4-48a8-ab6e-d3d6d038e266	2	10	f	\N	6a19d1f5-7023-444a-9b67-dce012c76de2
1ff293c9-07ea-426e-892d-7750965b99da	\N	\N	38d94c69-6603-4341-a226-f65366146032	799be8b0-18a4-48a8-ab6e-d3d6d038e266	2	20	t	df015a57-b828-457c-8a82-05ea343603bc	\N
48ff8228-8fdf-4c60-b3cc-ee23f69935b1	\N	idp-confirm-link	38d94c69-6603-4341-a226-f65366146032	df015a57-b828-457c-8a82-05ea343603bc	0	10	f	\N	\N
1749da8c-8734-431b-bb4a-c8d0f62fba04	\N	\N	38d94c69-6603-4341-a226-f65366146032	df015a57-b828-457c-8a82-05ea343603bc	0	20	t	fb3f60ac-87f6-4c25-ab65-89992a10dfa4	\N
6314298c-674f-49c9-978b-cccacf82ad3e	\N	idp-email-verification	38d94c69-6603-4341-a226-f65366146032	fb3f60ac-87f6-4c25-ab65-89992a10dfa4	2	10	f	\N	\N
d58a660a-c337-4e5b-895e-31381e89dc2a	\N	\N	38d94c69-6603-4341-a226-f65366146032	fb3f60ac-87f6-4c25-ab65-89992a10dfa4	2	20	t	ad64d4a9-4a77-4810-9132-e472a90366d7	\N
f9970fcd-e89d-42d1-8cb8-2cb46c0bedf0	\N	idp-username-password-form	38d94c69-6603-4341-a226-f65366146032	ad64d4a9-4a77-4810-9132-e472a90366d7	0	10	f	\N	\N
e8b67706-c6a2-4a82-bd9e-91abadb30268	\N	\N	38d94c69-6603-4341-a226-f65366146032	ad64d4a9-4a77-4810-9132-e472a90366d7	1	20	t	80c24de3-c9ee-4830-b186-d2ee57c9d5af	\N
02155fd6-24a5-4b57-8ed6-09b316e0db8a	\N	conditional-user-configured	38d94c69-6603-4341-a226-f65366146032	80c24de3-c9ee-4830-b186-d2ee57c9d5af	0	10	f	\N	\N
c56956df-7ea4-48e5-988e-f03d45c30f22	\N	auth-otp-form	38d94c69-6603-4341-a226-f65366146032	80c24de3-c9ee-4830-b186-d2ee57c9d5af	0	20	f	\N	\N
18fc618b-a7c9-428e-8ce2-357e62bab730	\N	\N	38d94c69-6603-4341-a226-f65366146032	eaa8a50d-cb90-43d8-8cc5-aec3eaf24f56	1	50	t	f115a809-6f15-4458-ac6f-a070e9f80bda	\N
169898c7-1f64-4760-9775-8cee283f8e5a	\N	conditional-user-configured	38d94c69-6603-4341-a226-f65366146032	f115a809-6f15-4458-ac6f-a070e9f80bda	0	10	f	\N	\N
036f5d46-5e02-4dfc-b431-6aea789010c1	\N	idp-add-organization-member	38d94c69-6603-4341-a226-f65366146032	f115a809-6f15-4458-ac6f-a070e9f80bda	0	20	f	\N	\N
51a1e90e-d3e5-41c5-81c0-aee0bc21d885	\N	http-basic-authenticator	38d94c69-6603-4341-a226-f65366146032	5cba329b-4e2a-4c01-b630-72dd0fceffe1	0	10	f	\N	\N
181e93de-3b70-4a6a-981f-6421579c7a99	\N	docker-http-basic-authenticator	38d94c69-6603-4341-a226-f65366146032	48f4bacb-626d-4c97-bf01-d606ff9e904a	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
69a25179-b194-402a-b7d0-ffd52f3f6a03	browser	Browser based authentication	cce4122f-9b89-420a-bd97-dc991169c190	basic-flow	t	t
6feb14c4-7746-44d8-88f7-6383faf5ce0a	forms	Username, password, otp and other auth forms.	cce4122f-9b89-420a-bd97-dc991169c190	basic-flow	f	t
cb084dd4-1d75-429b-b5a7-6740672b6412	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	cce4122f-9b89-420a-bd97-dc991169c190	basic-flow	f	t
ed2d371c-ead3-450b-a637-182ffa8469be	direct grant	OpenID Connect Resource Owner Grant	cce4122f-9b89-420a-bd97-dc991169c190	basic-flow	t	t
37f8e773-c8ff-4dbb-9dc9-773f69e9796d	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	cce4122f-9b89-420a-bd97-dc991169c190	basic-flow	f	t
35ebe2df-2086-4536-8953-103a9c4477c4	registration	Registration flow	cce4122f-9b89-420a-bd97-dc991169c190	basic-flow	t	t
620211bb-1c6e-45f9-9a64-e4f970ab8231	registration form	Registration form	cce4122f-9b89-420a-bd97-dc991169c190	form-flow	f	t
e732dcf6-d163-4076-b37c-1f6067fd9e0e	reset credentials	Reset credentials for a user if they forgot their password or something	cce4122f-9b89-420a-bd97-dc991169c190	basic-flow	t	t
8ab1dcc4-3f1f-428d-949a-ad1dadaed598	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	cce4122f-9b89-420a-bd97-dc991169c190	basic-flow	f	t
ebb0eb59-e3b7-4c6a-a5c4-7f72f0b54c2e	clients	Base authentication for clients	cce4122f-9b89-420a-bd97-dc991169c190	client-flow	t	t
a199ef20-4e50-4d45-a722-f11ea38c5eb2	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	cce4122f-9b89-420a-bd97-dc991169c190	basic-flow	t	t
2ce325fc-f377-4bed-a01e-344c399568ec	User creation or linking	Flow for the existing/non-existing user alternatives	cce4122f-9b89-420a-bd97-dc991169c190	basic-flow	f	t
47639264-cae3-4fc1-ab5e-fb068b0a1eb5	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	cce4122f-9b89-420a-bd97-dc991169c190	basic-flow	f	t
aaf2a050-1619-4fff-b973-e7ca59e24889	Account verification options	Method with which to verity the existing account	cce4122f-9b89-420a-bd97-dc991169c190	basic-flow	f	t
3e055004-ee12-433c-a323-b156904ffe12	Verify Existing Account by Re-authentication	Reauthentication of existing account	cce4122f-9b89-420a-bd97-dc991169c190	basic-flow	f	t
3da8c1d0-3764-47ff-ae1c-e37e05bcf5a1	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	cce4122f-9b89-420a-bd97-dc991169c190	basic-flow	f	t
7c2d8e43-1d57-4554-b8ac-8984d35bcb2a	saml ecp	SAML ECP Profile Authentication Flow	cce4122f-9b89-420a-bd97-dc991169c190	basic-flow	t	t
c3249293-ec9c-4fb9-a051-91e6a878ec12	docker auth	Used by Docker clients to authenticate against the IDP	cce4122f-9b89-420a-bd97-dc991169c190	basic-flow	t	t
d44239b3-06eb-4ec1-9f94-a09d967fcbf4	browser	Browser based authentication	38d94c69-6603-4341-a226-f65366146032	basic-flow	t	t
34cc3064-fc21-4558-bd7c-0eb6716d13c4	forms	Username, password, otp and other auth forms.	38d94c69-6603-4341-a226-f65366146032	basic-flow	f	t
64b99d2b-d366-42b7-86d7-13aa1bd8c46b	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	38d94c69-6603-4341-a226-f65366146032	basic-flow	f	t
bf682728-1aca-4bc3-846c-1bb815606c2a	Organization	\N	38d94c69-6603-4341-a226-f65366146032	basic-flow	f	t
58fee30b-4659-4896-9a18-eeb00c34cde5	Browser - Conditional Organization	Flow to determine if the organization identity-first login is to be used	38d94c69-6603-4341-a226-f65366146032	basic-flow	f	t
400c7467-cda2-49a2-bcf8-5960c5bb1694	direct grant	OpenID Connect Resource Owner Grant	38d94c69-6603-4341-a226-f65366146032	basic-flow	t	t
e88dd8b9-2225-49df-a4b9-d9e1a11a842d	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	38d94c69-6603-4341-a226-f65366146032	basic-flow	f	t
da777280-03fd-4447-b2d2-5970166e6ab5	registration	Registration flow	38d94c69-6603-4341-a226-f65366146032	basic-flow	t	t
0b4bbb6b-d9da-4180-9e8a-4ca2617e82ba	registration form	Registration form	38d94c69-6603-4341-a226-f65366146032	form-flow	f	t
36f4fca7-4154-4eda-898c-83d622d24cf0	reset credentials	Reset credentials for a user if they forgot their password or something	38d94c69-6603-4341-a226-f65366146032	basic-flow	t	t
3c94d05e-a44f-459c-b179-55e8ec097a08	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	38d94c69-6603-4341-a226-f65366146032	basic-flow	f	t
23e7836d-ed1c-4d5c-94b4-1807077c0c26	clients	Base authentication for clients	38d94c69-6603-4341-a226-f65366146032	client-flow	t	t
eaa8a50d-cb90-43d8-8cc5-aec3eaf24f56	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	38d94c69-6603-4341-a226-f65366146032	basic-flow	t	t
799be8b0-18a4-48a8-ab6e-d3d6d038e266	User creation or linking	Flow for the existing/non-existing user alternatives	38d94c69-6603-4341-a226-f65366146032	basic-flow	f	t
df015a57-b828-457c-8a82-05ea343603bc	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	38d94c69-6603-4341-a226-f65366146032	basic-flow	f	t
fb3f60ac-87f6-4c25-ab65-89992a10dfa4	Account verification options	Method with which to verity the existing account	38d94c69-6603-4341-a226-f65366146032	basic-flow	f	t
ad64d4a9-4a77-4810-9132-e472a90366d7	Verify Existing Account by Re-authentication	Reauthentication of existing account	38d94c69-6603-4341-a226-f65366146032	basic-flow	f	t
80c24de3-c9ee-4830-b186-d2ee57c9d5af	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	38d94c69-6603-4341-a226-f65366146032	basic-flow	f	t
f115a809-6f15-4458-ac6f-a070e9f80bda	First Broker Login - Conditional Organization	Flow to determine if the authenticator that adds organization members is to be used	38d94c69-6603-4341-a226-f65366146032	basic-flow	f	t
5cba329b-4e2a-4c01-b630-72dd0fceffe1	saml ecp	SAML ECP Profile Authentication Flow	38d94c69-6603-4341-a226-f65366146032	basic-flow	t	t
48f4bacb-626d-4c97-bf01-d606ff9e904a	docker auth	Used by Docker clients to authenticate against the IDP	38d94c69-6603-4341-a226-f65366146032	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
4c7e85e8-4b6a-4aef-8656-5dd6333a71a5	review profile config	cce4122f-9b89-420a-bd97-dc991169c190
b2d29620-20cd-421f-a4c4-2cc0dd2d5a09	create unique user config	cce4122f-9b89-420a-bd97-dc991169c190
2e73e467-7370-46dc-bf2a-f1f3a533b9d0	review profile config	38d94c69-6603-4341-a226-f65366146032
6a19d1f5-7023-444a-9b67-dce012c76de2	create unique user config	38d94c69-6603-4341-a226-f65366146032
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
4c7e85e8-4b6a-4aef-8656-5dd6333a71a5	missing	update.profile.on.first.login
b2d29620-20cd-421f-a4c4-2cc0dd2d5a09	false	require.password.update.after.registration
2e73e467-7370-46dc-bf2a-f1f3a533b9d0	missing	update.profile.on.first.login
6a19d1f5-7023-444a-9b67-dce012c76de2	false	require.password.update.after.registration
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
efd4d5ad-dc20-455a-af96-473ecb04282d	t	f	master-realm	0	f	\N	\N	t	\N	f	cce4122f-9b89-420a-bd97-dc991169c190	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
9ee22a07-854e-4b97-a636-a8a17d2cc1a4	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	cce4122f-9b89-420a-bd97-dc991169c190	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
76faf3ac-102c-40bf-970f-eb1f78aa06ad	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	cce4122f-9b89-420a-bd97-dc991169c190	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
c0b99c11-10d3-430d-962f-94e1b57a6013	t	f	broker	0	f	\N	\N	t	\N	f	cce4122f-9b89-420a-bd97-dc991169c190	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
245c8a5c-3bf4-4ff8-a90d-da60f1b7ef1c	t	t	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	cce4122f-9b89-420a-bd97-dc991169c190	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
ce67e6d2-2979-4222-884f-d16c97fc96ba	t	t	admin-cli	0	t	\N	\N	f	\N	f	cce4122f-9b89-420a-bd97-dc991169c190	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
7d116705-0e72-4b1a-ad08-e8aeaaab5fbe	t	f	mealwurm-realm	0	f	\N	\N	t	\N	f	cce4122f-9b89-420a-bd97-dc991169c190	\N	0	f	f	mealwurm Realm	f	client-secret	\N	\N	\N	t	f	f	f
719d2e4a-9b0e-489a-9c43-830f5859b0e8	t	f	realm-management	0	f	\N	\N	t	\N	f	38d94c69-6603-4341-a226-f65366146032	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
43911470-b287-4ab5-b065-3f02b4e850f6	t	f	account	0	t	\N	/realms/mealwurm/account/	f	\N	f	38d94c69-6603-4341-a226-f65366146032	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
329515af-4e73-4143-8938-3567714ec63b	t	f	account-console	0	t	\N	/realms/mealwurm/account/	f	\N	f	38d94c69-6603-4341-a226-f65366146032	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
a14ba3ad-455e-42ea-87d1-38ef5c3de155	t	f	broker	0	f	\N	\N	t	\N	f	38d94c69-6603-4341-a226-f65366146032	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
1e407bad-abc2-4602-b914-06c58e9fcacc	t	t	security-admin-console	0	t	\N	/admin/mealwurm/console/	f	\N	f	38d94c69-6603-4341-a226-f65366146032	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
cf737a80-f102-4180-bbf5-198f610756c9	t	t	admin-cli	0	t	\N	\N	f	\N	f	38d94c69-6603-4341-a226-f65366146032	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
8f8c0971-90fd-48b1-9b94-73a7deedf5d6	t	t	mealwurm	0	t	\N	http://localhost:3000	f		f	38d94c69-6603-4341-a226-f65366146032	openid-connect	-1	t	f	mealwurm	f	client-secret	http://localhost:3000		\N	t	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
9ee22a07-854e-4b97-a636-a8a17d2cc1a4	post.logout.redirect.uris	+
76faf3ac-102c-40bf-970f-eb1f78aa06ad	post.logout.redirect.uris	+
76faf3ac-102c-40bf-970f-eb1f78aa06ad	pkce.code.challenge.method	S256
245c8a5c-3bf4-4ff8-a90d-da60f1b7ef1c	post.logout.redirect.uris	+
245c8a5c-3bf4-4ff8-a90d-da60f1b7ef1c	pkce.code.challenge.method	S256
245c8a5c-3bf4-4ff8-a90d-da60f1b7ef1c	client.use.lightweight.access.token.enabled	true
ce67e6d2-2979-4222-884f-d16c97fc96ba	client.use.lightweight.access.token.enabled	true
43911470-b287-4ab5-b065-3f02b4e850f6	post.logout.redirect.uris	+
329515af-4e73-4143-8938-3567714ec63b	post.logout.redirect.uris	+
329515af-4e73-4143-8938-3567714ec63b	pkce.code.challenge.method	S256
1e407bad-abc2-4602-b914-06c58e9fcacc	post.logout.redirect.uris	+
1e407bad-abc2-4602-b914-06c58e9fcacc	pkce.code.challenge.method	S256
1e407bad-abc2-4602-b914-06c58e9fcacc	client.use.lightweight.access.token.enabled	true
cf737a80-f102-4180-bbf5-198f610756c9	client.use.lightweight.access.token.enabled	true
8f8c0971-90fd-48b1-9b94-73a7deedf5d6	oauth2.device.authorization.grant.enabled	false
8f8c0971-90fd-48b1-9b94-73a7deedf5d6	oidc.ciba.grant.enabled	false
8f8c0971-90fd-48b1-9b94-73a7deedf5d6	post.logout.redirect.uris	http://localhost:3000/*
8f8c0971-90fd-48b1-9b94-73a7deedf5d6	backchannel.logout.session.required	true
8f8c0971-90fd-48b1-9b94-73a7deedf5d6	backchannel.logout.revoke.offline.tokens	false
8f8c0971-90fd-48b1-9b94-73a7deedf5d6	realm_client	false
8f8c0971-90fd-48b1-9b94-73a7deedf5d6	display.on.consent.screen	false
8f8c0971-90fd-48b1-9b94-73a7deedf5d6	frontchannel.logout.session.required	true
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
2ecd7335-158f-42ca-a11f-40b3e3977158	offline_access	cce4122f-9b89-420a-bd97-dc991169c190	OpenID Connect built-in scope: offline_access	openid-connect
4f20806e-7577-4b53-ad34-754a77ebfa5d	role_list	cce4122f-9b89-420a-bd97-dc991169c190	SAML role list	saml
527a0e4f-4ab4-42ed-be81-c3166f4cbf1e	saml_organization	cce4122f-9b89-420a-bd97-dc991169c190	Organization Membership	saml
c5e68625-65ff-4723-8b83-dbc965ced676	profile	cce4122f-9b89-420a-bd97-dc991169c190	OpenID Connect built-in scope: profile	openid-connect
9eccf774-4cd5-4f2a-829b-14adbff99cea	email	cce4122f-9b89-420a-bd97-dc991169c190	OpenID Connect built-in scope: email	openid-connect
0273bfe9-94bf-4789-9d32-6d496057f2ef	address	cce4122f-9b89-420a-bd97-dc991169c190	OpenID Connect built-in scope: address	openid-connect
585a4801-6e6d-4417-98b8-2d3984080635	phone	cce4122f-9b89-420a-bd97-dc991169c190	OpenID Connect built-in scope: phone	openid-connect
4e85f1fa-ac35-4a19-8500-f211780b130d	roles	cce4122f-9b89-420a-bd97-dc991169c190	OpenID Connect scope for add user roles to the access token	openid-connect
e395ccda-2bf8-4a1a-a79f-14e62a00e954	web-origins	cce4122f-9b89-420a-bd97-dc991169c190	OpenID Connect scope for add allowed web origins to the access token	openid-connect
7ee2413b-851b-4155-9e9a-7a30f4c6d406	microprofile-jwt	cce4122f-9b89-420a-bd97-dc991169c190	Microprofile - JWT built-in scope	openid-connect
f7fd1bf7-d593-4e9e-b459-332b8318415d	acr	cce4122f-9b89-420a-bd97-dc991169c190	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
240f22bf-89e6-4ee2-ae61-1a7c25dd3434	basic	cce4122f-9b89-420a-bd97-dc991169c190	OpenID Connect scope for add all basic claims to the token	openid-connect
148b6457-6267-452a-a530-6963fbd6539e	service_account	cce4122f-9b89-420a-bd97-dc991169c190	Specific scope for a client enabled for service accounts	openid-connect
0666a187-c81e-4513-a921-8615212ad07d	organization	cce4122f-9b89-420a-bd97-dc991169c190	Additional claims about the organization a subject belongs to	openid-connect
7d703584-37c2-4c25-a46a-30bf9e37f62d	offline_access	38d94c69-6603-4341-a226-f65366146032	OpenID Connect built-in scope: offline_access	openid-connect
108c6856-ea9c-46b4-9d2c-20533ecf376c	role_list	38d94c69-6603-4341-a226-f65366146032	SAML role list	saml
dd8875a0-d565-4487-9eca-718f74785bd6	saml_organization	38d94c69-6603-4341-a226-f65366146032	Organization Membership	saml
a33162e5-f6df-4608-9796-b95e156a1d8f	profile	38d94c69-6603-4341-a226-f65366146032	OpenID Connect built-in scope: profile	openid-connect
9fae9540-7efc-42f9-962f-01723becf220	email	38d94c69-6603-4341-a226-f65366146032	OpenID Connect built-in scope: email	openid-connect
22163393-0526-4ebd-baea-94515880fdf4	address	38d94c69-6603-4341-a226-f65366146032	OpenID Connect built-in scope: address	openid-connect
3f33c4cf-c478-4e24-9955-744f16b3370a	phone	38d94c69-6603-4341-a226-f65366146032	OpenID Connect built-in scope: phone	openid-connect
d5f0eb87-574a-4a35-81b7-91c278c476a2	roles	38d94c69-6603-4341-a226-f65366146032	OpenID Connect scope for add user roles to the access token	openid-connect
4345e7ac-1678-4eb2-909d-4e0cf6858ce9	web-origins	38d94c69-6603-4341-a226-f65366146032	OpenID Connect scope for add allowed web origins to the access token	openid-connect
44c04c4d-ddf3-4729-a5ab-f96f551f55d8	microprofile-jwt	38d94c69-6603-4341-a226-f65366146032	Microprofile - JWT built-in scope	openid-connect
b55b05c7-ecef-4449-b947-e0f4c1592755	acr	38d94c69-6603-4341-a226-f65366146032	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
1208d451-edf5-46a3-b16f-afa1d0061a44	basic	38d94c69-6603-4341-a226-f65366146032	OpenID Connect scope for add all basic claims to the token	openid-connect
213dd6bd-9da3-4233-9c71-2631e8fde48b	service_account	38d94c69-6603-4341-a226-f65366146032	Specific scope for a client enabled for service accounts	openid-connect
27bb686a-c1a9-43dd-bc00-118bf917b1e3	organization	38d94c69-6603-4341-a226-f65366146032	Additional claims about the organization a subject belongs to	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
2ecd7335-158f-42ca-a11f-40b3e3977158	true	display.on.consent.screen
2ecd7335-158f-42ca-a11f-40b3e3977158	${offlineAccessScopeConsentText}	consent.screen.text
4f20806e-7577-4b53-ad34-754a77ebfa5d	true	display.on.consent.screen
4f20806e-7577-4b53-ad34-754a77ebfa5d	${samlRoleListScopeConsentText}	consent.screen.text
527a0e4f-4ab4-42ed-be81-c3166f4cbf1e	false	display.on.consent.screen
c5e68625-65ff-4723-8b83-dbc965ced676	true	display.on.consent.screen
c5e68625-65ff-4723-8b83-dbc965ced676	${profileScopeConsentText}	consent.screen.text
c5e68625-65ff-4723-8b83-dbc965ced676	true	include.in.token.scope
9eccf774-4cd5-4f2a-829b-14adbff99cea	true	display.on.consent.screen
9eccf774-4cd5-4f2a-829b-14adbff99cea	${emailScopeConsentText}	consent.screen.text
9eccf774-4cd5-4f2a-829b-14adbff99cea	true	include.in.token.scope
0273bfe9-94bf-4789-9d32-6d496057f2ef	true	display.on.consent.screen
0273bfe9-94bf-4789-9d32-6d496057f2ef	${addressScopeConsentText}	consent.screen.text
0273bfe9-94bf-4789-9d32-6d496057f2ef	true	include.in.token.scope
585a4801-6e6d-4417-98b8-2d3984080635	true	display.on.consent.screen
585a4801-6e6d-4417-98b8-2d3984080635	${phoneScopeConsentText}	consent.screen.text
585a4801-6e6d-4417-98b8-2d3984080635	true	include.in.token.scope
4e85f1fa-ac35-4a19-8500-f211780b130d	true	display.on.consent.screen
4e85f1fa-ac35-4a19-8500-f211780b130d	${rolesScopeConsentText}	consent.screen.text
4e85f1fa-ac35-4a19-8500-f211780b130d	false	include.in.token.scope
e395ccda-2bf8-4a1a-a79f-14e62a00e954	false	display.on.consent.screen
e395ccda-2bf8-4a1a-a79f-14e62a00e954		consent.screen.text
e395ccda-2bf8-4a1a-a79f-14e62a00e954	false	include.in.token.scope
7ee2413b-851b-4155-9e9a-7a30f4c6d406	false	display.on.consent.screen
7ee2413b-851b-4155-9e9a-7a30f4c6d406	true	include.in.token.scope
f7fd1bf7-d593-4e9e-b459-332b8318415d	false	display.on.consent.screen
f7fd1bf7-d593-4e9e-b459-332b8318415d	false	include.in.token.scope
240f22bf-89e6-4ee2-ae61-1a7c25dd3434	false	display.on.consent.screen
240f22bf-89e6-4ee2-ae61-1a7c25dd3434	false	include.in.token.scope
148b6457-6267-452a-a530-6963fbd6539e	false	display.on.consent.screen
148b6457-6267-452a-a530-6963fbd6539e	false	include.in.token.scope
0666a187-c81e-4513-a921-8615212ad07d	true	display.on.consent.screen
0666a187-c81e-4513-a921-8615212ad07d	${organizationScopeConsentText}	consent.screen.text
0666a187-c81e-4513-a921-8615212ad07d	true	include.in.token.scope
7d703584-37c2-4c25-a46a-30bf9e37f62d	true	display.on.consent.screen
7d703584-37c2-4c25-a46a-30bf9e37f62d	${offlineAccessScopeConsentText}	consent.screen.text
108c6856-ea9c-46b4-9d2c-20533ecf376c	true	display.on.consent.screen
108c6856-ea9c-46b4-9d2c-20533ecf376c	${samlRoleListScopeConsentText}	consent.screen.text
dd8875a0-d565-4487-9eca-718f74785bd6	false	display.on.consent.screen
a33162e5-f6df-4608-9796-b95e156a1d8f	true	display.on.consent.screen
a33162e5-f6df-4608-9796-b95e156a1d8f	${profileScopeConsentText}	consent.screen.text
a33162e5-f6df-4608-9796-b95e156a1d8f	true	include.in.token.scope
9fae9540-7efc-42f9-962f-01723becf220	true	display.on.consent.screen
9fae9540-7efc-42f9-962f-01723becf220	${emailScopeConsentText}	consent.screen.text
9fae9540-7efc-42f9-962f-01723becf220	true	include.in.token.scope
22163393-0526-4ebd-baea-94515880fdf4	true	display.on.consent.screen
22163393-0526-4ebd-baea-94515880fdf4	${addressScopeConsentText}	consent.screen.text
22163393-0526-4ebd-baea-94515880fdf4	true	include.in.token.scope
3f33c4cf-c478-4e24-9955-744f16b3370a	true	display.on.consent.screen
3f33c4cf-c478-4e24-9955-744f16b3370a	${phoneScopeConsentText}	consent.screen.text
3f33c4cf-c478-4e24-9955-744f16b3370a	true	include.in.token.scope
d5f0eb87-574a-4a35-81b7-91c278c476a2	true	display.on.consent.screen
d5f0eb87-574a-4a35-81b7-91c278c476a2	${rolesScopeConsentText}	consent.screen.text
d5f0eb87-574a-4a35-81b7-91c278c476a2	false	include.in.token.scope
4345e7ac-1678-4eb2-909d-4e0cf6858ce9	false	display.on.consent.screen
4345e7ac-1678-4eb2-909d-4e0cf6858ce9		consent.screen.text
4345e7ac-1678-4eb2-909d-4e0cf6858ce9	false	include.in.token.scope
44c04c4d-ddf3-4729-a5ab-f96f551f55d8	false	display.on.consent.screen
44c04c4d-ddf3-4729-a5ab-f96f551f55d8	true	include.in.token.scope
b55b05c7-ecef-4449-b947-e0f4c1592755	false	display.on.consent.screen
b55b05c7-ecef-4449-b947-e0f4c1592755	false	include.in.token.scope
1208d451-edf5-46a3-b16f-afa1d0061a44	false	display.on.consent.screen
1208d451-edf5-46a3-b16f-afa1d0061a44	false	include.in.token.scope
213dd6bd-9da3-4233-9c71-2631e8fde48b	false	display.on.consent.screen
213dd6bd-9da3-4233-9c71-2631e8fde48b	false	include.in.token.scope
27bb686a-c1a9-43dd-bc00-118bf917b1e3	true	display.on.consent.screen
27bb686a-c1a9-43dd-bc00-118bf917b1e3	${organizationScopeConsentText}	consent.screen.text
27bb686a-c1a9-43dd-bc00-118bf917b1e3	true	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
9ee22a07-854e-4b97-a636-a8a17d2cc1a4	c5e68625-65ff-4723-8b83-dbc965ced676	t
9ee22a07-854e-4b97-a636-a8a17d2cc1a4	f7fd1bf7-d593-4e9e-b459-332b8318415d	t
9ee22a07-854e-4b97-a636-a8a17d2cc1a4	9eccf774-4cd5-4f2a-829b-14adbff99cea	t
9ee22a07-854e-4b97-a636-a8a17d2cc1a4	4e85f1fa-ac35-4a19-8500-f211780b130d	t
9ee22a07-854e-4b97-a636-a8a17d2cc1a4	240f22bf-89e6-4ee2-ae61-1a7c25dd3434	t
9ee22a07-854e-4b97-a636-a8a17d2cc1a4	e395ccda-2bf8-4a1a-a79f-14e62a00e954	t
9ee22a07-854e-4b97-a636-a8a17d2cc1a4	7ee2413b-851b-4155-9e9a-7a30f4c6d406	f
9ee22a07-854e-4b97-a636-a8a17d2cc1a4	0273bfe9-94bf-4789-9d32-6d496057f2ef	f
9ee22a07-854e-4b97-a636-a8a17d2cc1a4	585a4801-6e6d-4417-98b8-2d3984080635	f
9ee22a07-854e-4b97-a636-a8a17d2cc1a4	2ecd7335-158f-42ca-a11f-40b3e3977158	f
9ee22a07-854e-4b97-a636-a8a17d2cc1a4	0666a187-c81e-4513-a921-8615212ad07d	f
76faf3ac-102c-40bf-970f-eb1f78aa06ad	c5e68625-65ff-4723-8b83-dbc965ced676	t
76faf3ac-102c-40bf-970f-eb1f78aa06ad	f7fd1bf7-d593-4e9e-b459-332b8318415d	t
76faf3ac-102c-40bf-970f-eb1f78aa06ad	9eccf774-4cd5-4f2a-829b-14adbff99cea	t
76faf3ac-102c-40bf-970f-eb1f78aa06ad	4e85f1fa-ac35-4a19-8500-f211780b130d	t
76faf3ac-102c-40bf-970f-eb1f78aa06ad	240f22bf-89e6-4ee2-ae61-1a7c25dd3434	t
76faf3ac-102c-40bf-970f-eb1f78aa06ad	e395ccda-2bf8-4a1a-a79f-14e62a00e954	t
76faf3ac-102c-40bf-970f-eb1f78aa06ad	7ee2413b-851b-4155-9e9a-7a30f4c6d406	f
76faf3ac-102c-40bf-970f-eb1f78aa06ad	0273bfe9-94bf-4789-9d32-6d496057f2ef	f
76faf3ac-102c-40bf-970f-eb1f78aa06ad	585a4801-6e6d-4417-98b8-2d3984080635	f
76faf3ac-102c-40bf-970f-eb1f78aa06ad	2ecd7335-158f-42ca-a11f-40b3e3977158	f
76faf3ac-102c-40bf-970f-eb1f78aa06ad	0666a187-c81e-4513-a921-8615212ad07d	f
ce67e6d2-2979-4222-884f-d16c97fc96ba	c5e68625-65ff-4723-8b83-dbc965ced676	t
ce67e6d2-2979-4222-884f-d16c97fc96ba	f7fd1bf7-d593-4e9e-b459-332b8318415d	t
ce67e6d2-2979-4222-884f-d16c97fc96ba	9eccf774-4cd5-4f2a-829b-14adbff99cea	t
ce67e6d2-2979-4222-884f-d16c97fc96ba	4e85f1fa-ac35-4a19-8500-f211780b130d	t
ce67e6d2-2979-4222-884f-d16c97fc96ba	240f22bf-89e6-4ee2-ae61-1a7c25dd3434	t
ce67e6d2-2979-4222-884f-d16c97fc96ba	e395ccda-2bf8-4a1a-a79f-14e62a00e954	t
ce67e6d2-2979-4222-884f-d16c97fc96ba	7ee2413b-851b-4155-9e9a-7a30f4c6d406	f
ce67e6d2-2979-4222-884f-d16c97fc96ba	0273bfe9-94bf-4789-9d32-6d496057f2ef	f
ce67e6d2-2979-4222-884f-d16c97fc96ba	585a4801-6e6d-4417-98b8-2d3984080635	f
ce67e6d2-2979-4222-884f-d16c97fc96ba	2ecd7335-158f-42ca-a11f-40b3e3977158	f
ce67e6d2-2979-4222-884f-d16c97fc96ba	0666a187-c81e-4513-a921-8615212ad07d	f
c0b99c11-10d3-430d-962f-94e1b57a6013	c5e68625-65ff-4723-8b83-dbc965ced676	t
c0b99c11-10d3-430d-962f-94e1b57a6013	f7fd1bf7-d593-4e9e-b459-332b8318415d	t
c0b99c11-10d3-430d-962f-94e1b57a6013	9eccf774-4cd5-4f2a-829b-14adbff99cea	t
c0b99c11-10d3-430d-962f-94e1b57a6013	4e85f1fa-ac35-4a19-8500-f211780b130d	t
c0b99c11-10d3-430d-962f-94e1b57a6013	240f22bf-89e6-4ee2-ae61-1a7c25dd3434	t
c0b99c11-10d3-430d-962f-94e1b57a6013	e395ccda-2bf8-4a1a-a79f-14e62a00e954	t
c0b99c11-10d3-430d-962f-94e1b57a6013	7ee2413b-851b-4155-9e9a-7a30f4c6d406	f
c0b99c11-10d3-430d-962f-94e1b57a6013	0273bfe9-94bf-4789-9d32-6d496057f2ef	f
c0b99c11-10d3-430d-962f-94e1b57a6013	585a4801-6e6d-4417-98b8-2d3984080635	f
c0b99c11-10d3-430d-962f-94e1b57a6013	2ecd7335-158f-42ca-a11f-40b3e3977158	f
c0b99c11-10d3-430d-962f-94e1b57a6013	0666a187-c81e-4513-a921-8615212ad07d	f
efd4d5ad-dc20-455a-af96-473ecb04282d	c5e68625-65ff-4723-8b83-dbc965ced676	t
efd4d5ad-dc20-455a-af96-473ecb04282d	f7fd1bf7-d593-4e9e-b459-332b8318415d	t
efd4d5ad-dc20-455a-af96-473ecb04282d	9eccf774-4cd5-4f2a-829b-14adbff99cea	t
efd4d5ad-dc20-455a-af96-473ecb04282d	4e85f1fa-ac35-4a19-8500-f211780b130d	t
efd4d5ad-dc20-455a-af96-473ecb04282d	240f22bf-89e6-4ee2-ae61-1a7c25dd3434	t
efd4d5ad-dc20-455a-af96-473ecb04282d	e395ccda-2bf8-4a1a-a79f-14e62a00e954	t
efd4d5ad-dc20-455a-af96-473ecb04282d	7ee2413b-851b-4155-9e9a-7a30f4c6d406	f
efd4d5ad-dc20-455a-af96-473ecb04282d	0273bfe9-94bf-4789-9d32-6d496057f2ef	f
efd4d5ad-dc20-455a-af96-473ecb04282d	585a4801-6e6d-4417-98b8-2d3984080635	f
efd4d5ad-dc20-455a-af96-473ecb04282d	2ecd7335-158f-42ca-a11f-40b3e3977158	f
efd4d5ad-dc20-455a-af96-473ecb04282d	0666a187-c81e-4513-a921-8615212ad07d	f
245c8a5c-3bf4-4ff8-a90d-da60f1b7ef1c	c5e68625-65ff-4723-8b83-dbc965ced676	t
245c8a5c-3bf4-4ff8-a90d-da60f1b7ef1c	f7fd1bf7-d593-4e9e-b459-332b8318415d	t
245c8a5c-3bf4-4ff8-a90d-da60f1b7ef1c	9eccf774-4cd5-4f2a-829b-14adbff99cea	t
245c8a5c-3bf4-4ff8-a90d-da60f1b7ef1c	4e85f1fa-ac35-4a19-8500-f211780b130d	t
245c8a5c-3bf4-4ff8-a90d-da60f1b7ef1c	240f22bf-89e6-4ee2-ae61-1a7c25dd3434	t
245c8a5c-3bf4-4ff8-a90d-da60f1b7ef1c	e395ccda-2bf8-4a1a-a79f-14e62a00e954	t
245c8a5c-3bf4-4ff8-a90d-da60f1b7ef1c	7ee2413b-851b-4155-9e9a-7a30f4c6d406	f
245c8a5c-3bf4-4ff8-a90d-da60f1b7ef1c	0273bfe9-94bf-4789-9d32-6d496057f2ef	f
245c8a5c-3bf4-4ff8-a90d-da60f1b7ef1c	585a4801-6e6d-4417-98b8-2d3984080635	f
245c8a5c-3bf4-4ff8-a90d-da60f1b7ef1c	2ecd7335-158f-42ca-a11f-40b3e3977158	f
245c8a5c-3bf4-4ff8-a90d-da60f1b7ef1c	0666a187-c81e-4513-a921-8615212ad07d	f
43911470-b287-4ab5-b065-3f02b4e850f6	9fae9540-7efc-42f9-962f-01723becf220	t
43911470-b287-4ab5-b065-3f02b4e850f6	4345e7ac-1678-4eb2-909d-4e0cf6858ce9	t
43911470-b287-4ab5-b065-3f02b4e850f6	a33162e5-f6df-4608-9796-b95e156a1d8f	t
43911470-b287-4ab5-b065-3f02b4e850f6	1208d451-edf5-46a3-b16f-afa1d0061a44	t
43911470-b287-4ab5-b065-3f02b4e850f6	d5f0eb87-574a-4a35-81b7-91c278c476a2	t
43911470-b287-4ab5-b065-3f02b4e850f6	b55b05c7-ecef-4449-b947-e0f4c1592755	t
43911470-b287-4ab5-b065-3f02b4e850f6	3f33c4cf-c478-4e24-9955-744f16b3370a	f
43911470-b287-4ab5-b065-3f02b4e850f6	7d703584-37c2-4c25-a46a-30bf9e37f62d	f
43911470-b287-4ab5-b065-3f02b4e850f6	22163393-0526-4ebd-baea-94515880fdf4	f
43911470-b287-4ab5-b065-3f02b4e850f6	27bb686a-c1a9-43dd-bc00-118bf917b1e3	f
43911470-b287-4ab5-b065-3f02b4e850f6	44c04c4d-ddf3-4729-a5ab-f96f551f55d8	f
329515af-4e73-4143-8938-3567714ec63b	9fae9540-7efc-42f9-962f-01723becf220	t
329515af-4e73-4143-8938-3567714ec63b	4345e7ac-1678-4eb2-909d-4e0cf6858ce9	t
329515af-4e73-4143-8938-3567714ec63b	a33162e5-f6df-4608-9796-b95e156a1d8f	t
329515af-4e73-4143-8938-3567714ec63b	1208d451-edf5-46a3-b16f-afa1d0061a44	t
329515af-4e73-4143-8938-3567714ec63b	d5f0eb87-574a-4a35-81b7-91c278c476a2	t
329515af-4e73-4143-8938-3567714ec63b	b55b05c7-ecef-4449-b947-e0f4c1592755	t
329515af-4e73-4143-8938-3567714ec63b	3f33c4cf-c478-4e24-9955-744f16b3370a	f
329515af-4e73-4143-8938-3567714ec63b	7d703584-37c2-4c25-a46a-30bf9e37f62d	f
329515af-4e73-4143-8938-3567714ec63b	22163393-0526-4ebd-baea-94515880fdf4	f
329515af-4e73-4143-8938-3567714ec63b	27bb686a-c1a9-43dd-bc00-118bf917b1e3	f
329515af-4e73-4143-8938-3567714ec63b	44c04c4d-ddf3-4729-a5ab-f96f551f55d8	f
cf737a80-f102-4180-bbf5-198f610756c9	9fae9540-7efc-42f9-962f-01723becf220	t
cf737a80-f102-4180-bbf5-198f610756c9	4345e7ac-1678-4eb2-909d-4e0cf6858ce9	t
cf737a80-f102-4180-bbf5-198f610756c9	a33162e5-f6df-4608-9796-b95e156a1d8f	t
cf737a80-f102-4180-bbf5-198f610756c9	1208d451-edf5-46a3-b16f-afa1d0061a44	t
cf737a80-f102-4180-bbf5-198f610756c9	d5f0eb87-574a-4a35-81b7-91c278c476a2	t
cf737a80-f102-4180-bbf5-198f610756c9	b55b05c7-ecef-4449-b947-e0f4c1592755	t
cf737a80-f102-4180-bbf5-198f610756c9	3f33c4cf-c478-4e24-9955-744f16b3370a	f
cf737a80-f102-4180-bbf5-198f610756c9	7d703584-37c2-4c25-a46a-30bf9e37f62d	f
cf737a80-f102-4180-bbf5-198f610756c9	22163393-0526-4ebd-baea-94515880fdf4	f
cf737a80-f102-4180-bbf5-198f610756c9	27bb686a-c1a9-43dd-bc00-118bf917b1e3	f
cf737a80-f102-4180-bbf5-198f610756c9	44c04c4d-ddf3-4729-a5ab-f96f551f55d8	f
a14ba3ad-455e-42ea-87d1-38ef5c3de155	9fae9540-7efc-42f9-962f-01723becf220	t
a14ba3ad-455e-42ea-87d1-38ef5c3de155	4345e7ac-1678-4eb2-909d-4e0cf6858ce9	t
a14ba3ad-455e-42ea-87d1-38ef5c3de155	a33162e5-f6df-4608-9796-b95e156a1d8f	t
a14ba3ad-455e-42ea-87d1-38ef5c3de155	1208d451-edf5-46a3-b16f-afa1d0061a44	t
a14ba3ad-455e-42ea-87d1-38ef5c3de155	d5f0eb87-574a-4a35-81b7-91c278c476a2	t
a14ba3ad-455e-42ea-87d1-38ef5c3de155	b55b05c7-ecef-4449-b947-e0f4c1592755	t
a14ba3ad-455e-42ea-87d1-38ef5c3de155	3f33c4cf-c478-4e24-9955-744f16b3370a	f
a14ba3ad-455e-42ea-87d1-38ef5c3de155	7d703584-37c2-4c25-a46a-30bf9e37f62d	f
a14ba3ad-455e-42ea-87d1-38ef5c3de155	22163393-0526-4ebd-baea-94515880fdf4	f
a14ba3ad-455e-42ea-87d1-38ef5c3de155	27bb686a-c1a9-43dd-bc00-118bf917b1e3	f
a14ba3ad-455e-42ea-87d1-38ef5c3de155	44c04c4d-ddf3-4729-a5ab-f96f551f55d8	f
719d2e4a-9b0e-489a-9c43-830f5859b0e8	9fae9540-7efc-42f9-962f-01723becf220	t
719d2e4a-9b0e-489a-9c43-830f5859b0e8	4345e7ac-1678-4eb2-909d-4e0cf6858ce9	t
719d2e4a-9b0e-489a-9c43-830f5859b0e8	a33162e5-f6df-4608-9796-b95e156a1d8f	t
719d2e4a-9b0e-489a-9c43-830f5859b0e8	1208d451-edf5-46a3-b16f-afa1d0061a44	t
719d2e4a-9b0e-489a-9c43-830f5859b0e8	d5f0eb87-574a-4a35-81b7-91c278c476a2	t
719d2e4a-9b0e-489a-9c43-830f5859b0e8	b55b05c7-ecef-4449-b947-e0f4c1592755	t
719d2e4a-9b0e-489a-9c43-830f5859b0e8	3f33c4cf-c478-4e24-9955-744f16b3370a	f
719d2e4a-9b0e-489a-9c43-830f5859b0e8	7d703584-37c2-4c25-a46a-30bf9e37f62d	f
719d2e4a-9b0e-489a-9c43-830f5859b0e8	22163393-0526-4ebd-baea-94515880fdf4	f
719d2e4a-9b0e-489a-9c43-830f5859b0e8	27bb686a-c1a9-43dd-bc00-118bf917b1e3	f
719d2e4a-9b0e-489a-9c43-830f5859b0e8	44c04c4d-ddf3-4729-a5ab-f96f551f55d8	f
1e407bad-abc2-4602-b914-06c58e9fcacc	9fae9540-7efc-42f9-962f-01723becf220	t
1e407bad-abc2-4602-b914-06c58e9fcacc	4345e7ac-1678-4eb2-909d-4e0cf6858ce9	t
1e407bad-abc2-4602-b914-06c58e9fcacc	a33162e5-f6df-4608-9796-b95e156a1d8f	t
1e407bad-abc2-4602-b914-06c58e9fcacc	1208d451-edf5-46a3-b16f-afa1d0061a44	t
1e407bad-abc2-4602-b914-06c58e9fcacc	d5f0eb87-574a-4a35-81b7-91c278c476a2	t
1e407bad-abc2-4602-b914-06c58e9fcacc	b55b05c7-ecef-4449-b947-e0f4c1592755	t
1e407bad-abc2-4602-b914-06c58e9fcacc	3f33c4cf-c478-4e24-9955-744f16b3370a	f
1e407bad-abc2-4602-b914-06c58e9fcacc	7d703584-37c2-4c25-a46a-30bf9e37f62d	f
1e407bad-abc2-4602-b914-06c58e9fcacc	22163393-0526-4ebd-baea-94515880fdf4	f
1e407bad-abc2-4602-b914-06c58e9fcacc	27bb686a-c1a9-43dd-bc00-118bf917b1e3	f
1e407bad-abc2-4602-b914-06c58e9fcacc	44c04c4d-ddf3-4729-a5ab-f96f551f55d8	f
8f8c0971-90fd-48b1-9b94-73a7deedf5d6	9fae9540-7efc-42f9-962f-01723becf220	t
8f8c0971-90fd-48b1-9b94-73a7deedf5d6	4345e7ac-1678-4eb2-909d-4e0cf6858ce9	t
8f8c0971-90fd-48b1-9b94-73a7deedf5d6	a33162e5-f6df-4608-9796-b95e156a1d8f	t
8f8c0971-90fd-48b1-9b94-73a7deedf5d6	1208d451-edf5-46a3-b16f-afa1d0061a44	t
8f8c0971-90fd-48b1-9b94-73a7deedf5d6	d5f0eb87-574a-4a35-81b7-91c278c476a2	t
8f8c0971-90fd-48b1-9b94-73a7deedf5d6	b55b05c7-ecef-4449-b947-e0f4c1592755	t
8f8c0971-90fd-48b1-9b94-73a7deedf5d6	3f33c4cf-c478-4e24-9955-744f16b3370a	f
8f8c0971-90fd-48b1-9b94-73a7deedf5d6	7d703584-37c2-4c25-a46a-30bf9e37f62d	f
8f8c0971-90fd-48b1-9b94-73a7deedf5d6	22163393-0526-4ebd-baea-94515880fdf4	f
8f8c0971-90fd-48b1-9b94-73a7deedf5d6	27bb686a-c1a9-43dd-bc00-118bf917b1e3	f
8f8c0971-90fd-48b1-9b94-73a7deedf5d6	44c04c4d-ddf3-4729-a5ab-f96f551f55d8	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
2ecd7335-158f-42ca-a11f-40b3e3977158	532db205-37f1-4d76-89f2-92f7daf40762
7d703584-37c2-4c25-a46a-30bf9e37f62d	3d3cc335-d0f1-42e4-8887-4bfce55be516
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
127ec5d8-7860-4c71-bab7-264797265d27	Trusted Hosts	cce4122f-9b89-420a-bd97-dc991169c190	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	cce4122f-9b89-420a-bd97-dc991169c190	anonymous
d9eeb4cc-315a-4259-9b70-7f5fcb5030b6	Consent Required	cce4122f-9b89-420a-bd97-dc991169c190	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	cce4122f-9b89-420a-bd97-dc991169c190	anonymous
a4ef916a-4a11-4181-927c-dff4ab657d39	Full Scope Disabled	cce4122f-9b89-420a-bd97-dc991169c190	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	cce4122f-9b89-420a-bd97-dc991169c190	anonymous
35d93f24-67a9-4209-af81-c88b093d42c8	Max Clients Limit	cce4122f-9b89-420a-bd97-dc991169c190	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	cce4122f-9b89-420a-bd97-dc991169c190	anonymous
4899933b-9e17-48f4-ad52-49535b993c9d	Allowed Protocol Mapper Types	cce4122f-9b89-420a-bd97-dc991169c190	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	cce4122f-9b89-420a-bd97-dc991169c190	anonymous
3f393a12-3a3b-4deb-9930-6ae978f33260	Allowed Client Scopes	cce4122f-9b89-420a-bd97-dc991169c190	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	cce4122f-9b89-420a-bd97-dc991169c190	anonymous
7d7ce550-1d30-40c4-a772-66abdcc4b136	Allowed Protocol Mapper Types	cce4122f-9b89-420a-bd97-dc991169c190	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	cce4122f-9b89-420a-bd97-dc991169c190	authenticated
bd8e7e3b-1f0f-49c7-96a2-5f95af3146d3	Allowed Client Scopes	cce4122f-9b89-420a-bd97-dc991169c190	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	cce4122f-9b89-420a-bd97-dc991169c190	authenticated
b3e64afe-4a2b-4c5d-9f34-ebffb10a480e	rsa-generated	cce4122f-9b89-420a-bd97-dc991169c190	rsa-generated	org.keycloak.keys.KeyProvider	cce4122f-9b89-420a-bd97-dc991169c190	\N
ee269cf3-acf7-45d8-8abb-bb6e12731231	rsa-enc-generated	cce4122f-9b89-420a-bd97-dc991169c190	rsa-enc-generated	org.keycloak.keys.KeyProvider	cce4122f-9b89-420a-bd97-dc991169c190	\N
bc170a29-c247-4f80-8a91-941455c18f3b	hmac-generated-hs512	cce4122f-9b89-420a-bd97-dc991169c190	hmac-generated	org.keycloak.keys.KeyProvider	cce4122f-9b89-420a-bd97-dc991169c190	\N
59bc265c-c932-4fee-8ae4-55b7d64cc1fb	aes-generated	cce4122f-9b89-420a-bd97-dc991169c190	aes-generated	org.keycloak.keys.KeyProvider	cce4122f-9b89-420a-bd97-dc991169c190	\N
6944baff-c6c7-45e7-8c42-7275f43016f9	\N	cce4122f-9b89-420a-bd97-dc991169c190	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	cce4122f-9b89-420a-bd97-dc991169c190	\N
b5478687-2761-4af6-b2f1-6a3f4f817b98	rsa-generated	38d94c69-6603-4341-a226-f65366146032	rsa-generated	org.keycloak.keys.KeyProvider	38d94c69-6603-4341-a226-f65366146032	\N
6c13c9e2-aef8-4ade-aad1-03a918b38b59	rsa-enc-generated	38d94c69-6603-4341-a226-f65366146032	rsa-enc-generated	org.keycloak.keys.KeyProvider	38d94c69-6603-4341-a226-f65366146032	\N
ccd0584c-3628-49c2-9649-90cfaba75ed5	hmac-generated-hs512	38d94c69-6603-4341-a226-f65366146032	hmac-generated	org.keycloak.keys.KeyProvider	38d94c69-6603-4341-a226-f65366146032	\N
e5e03d06-5e83-4b84-8dd3-55624a3e273f	aes-generated	38d94c69-6603-4341-a226-f65366146032	aes-generated	org.keycloak.keys.KeyProvider	38d94c69-6603-4341-a226-f65366146032	\N
df7d71c0-5fac-406d-8b83-30c73daef3b2	Trusted Hosts	38d94c69-6603-4341-a226-f65366146032	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	38d94c69-6603-4341-a226-f65366146032	anonymous
4393c19f-8695-4b3f-bd51-94b98a9910ce	Consent Required	38d94c69-6603-4341-a226-f65366146032	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	38d94c69-6603-4341-a226-f65366146032	anonymous
4f2e7e39-9e3a-4489-9b5b-3cc83613d5f4	Full Scope Disabled	38d94c69-6603-4341-a226-f65366146032	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	38d94c69-6603-4341-a226-f65366146032	anonymous
77d0c0ce-7cad-4224-b695-397e114fe3c3	Max Clients Limit	38d94c69-6603-4341-a226-f65366146032	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	38d94c69-6603-4341-a226-f65366146032	anonymous
e4a4939c-f932-43b7-abec-a82cf311657d	Allowed Protocol Mapper Types	38d94c69-6603-4341-a226-f65366146032	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	38d94c69-6603-4341-a226-f65366146032	anonymous
58fb9097-178b-4276-8d67-53c2a088ca0a	Allowed Client Scopes	38d94c69-6603-4341-a226-f65366146032	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	38d94c69-6603-4341-a226-f65366146032	anonymous
bb7e3b2f-2756-43fd-ba24-95f190849ce2	Allowed Protocol Mapper Types	38d94c69-6603-4341-a226-f65366146032	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	38d94c69-6603-4341-a226-f65366146032	authenticated
6530eb4a-b8a3-4904-873b-c6cbcf09eb22	Allowed Client Scopes	38d94c69-6603-4341-a226-f65366146032	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	38d94c69-6603-4341-a226-f65366146032	authenticated
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
ac99c683-0907-46e8-aca6-cf37c23a59d8	7d7ce550-1d30-40c4-a772-66abdcc4b136	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
34426a79-25a4-4be2-ae25-3f642a75b7ad	7d7ce550-1d30-40c4-a772-66abdcc4b136	allowed-protocol-mapper-types	saml-user-attribute-mapper
9be4ea56-fd45-40c2-b902-5949ddb60569	7d7ce550-1d30-40c4-a772-66abdcc4b136	allowed-protocol-mapper-types	oidc-full-name-mapper
ba7ba740-61a0-4b71-91fa-7458fb4c124e	7d7ce550-1d30-40c4-a772-66abdcc4b136	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
e88dc372-faac-410d-a72e-34b9f3d5176c	7d7ce550-1d30-40c4-a772-66abdcc4b136	allowed-protocol-mapper-types	saml-user-property-mapper
ac0ee8f3-4fcc-422e-aa91-09f9110443eb	7d7ce550-1d30-40c4-a772-66abdcc4b136	allowed-protocol-mapper-types	oidc-address-mapper
dc2f3e87-3939-472b-8ea9-8af94e87833e	7d7ce550-1d30-40c4-a772-66abdcc4b136	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
90ddc45f-8500-4d65-aedf-7dd0d1650790	7d7ce550-1d30-40c4-a772-66abdcc4b136	allowed-protocol-mapper-types	saml-role-list-mapper
00a98b03-b86b-46d8-b870-e0561123b58c	3f393a12-3a3b-4deb-9930-6ae978f33260	allow-default-scopes	true
27a8237a-0f9b-4868-87af-494d51fe8453	127ec5d8-7860-4c71-bab7-264797265d27	host-sending-registration-request-must-match	true
39a9e879-28a7-46ed-852f-e34d6a090406	127ec5d8-7860-4c71-bab7-264797265d27	client-uris-must-match	true
24b73e6c-4c34-4cd2-bddf-646c5e283671	4899933b-9e17-48f4-ad52-49535b993c9d	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
55599cee-e6e2-46fb-8ddf-4f6a381f8188	4899933b-9e17-48f4-ad52-49535b993c9d	allowed-protocol-mapper-types	oidc-address-mapper
3e84ed17-aa9e-47aa-ba4f-8c6c8c0a5f0e	4899933b-9e17-48f4-ad52-49535b993c9d	allowed-protocol-mapper-types	saml-role-list-mapper
da6f737e-d25c-49d7-80b7-1b4a53420dfe	4899933b-9e17-48f4-ad52-49535b993c9d	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
f6fd1748-13d5-48d2-bb87-1af0584236eb	4899933b-9e17-48f4-ad52-49535b993c9d	allowed-protocol-mapper-types	saml-user-attribute-mapper
899d7ac4-5fc3-4e69-9c9d-a450ff762ca5	4899933b-9e17-48f4-ad52-49535b993c9d	allowed-protocol-mapper-types	saml-user-property-mapper
ed3b169f-8544-403d-8211-3fa482ead648	4899933b-9e17-48f4-ad52-49535b993c9d	allowed-protocol-mapper-types	oidc-full-name-mapper
b095f02f-b4cb-4efc-a9c5-fde3d52374ec	4899933b-9e17-48f4-ad52-49535b993c9d	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
f63e35c6-2827-48f0-9dc9-3ae6300edfe6	bd8e7e3b-1f0f-49c7-96a2-5f95af3146d3	allow-default-scopes	true
00e51bc3-36f7-4496-b499-d10ac5fbc367	35d93f24-67a9-4209-af81-c88b093d42c8	max-clients	200
805093e3-4e40-473a-9236-3a2c12e557f6	b3e64afe-4a2b-4c5d-9f34-ebffb10a480e	certificate	MIICmzCCAYMCBgGYybM2ODANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwODIwMjI1NTIyWhcNMzUwODIwMjI1NzAyWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC2CJjs1Hdt7ozLKXIcb0utu5Xrr12lotmMEN+yFAqcAc0evXbQjBIsTnbT5Ysjfo1I8I7JMnkuraJH7EOFaXG89mO98HvaUdhlDb9RRgR1Ks6mDNuGJlhjxeW5QDUEPBz0mAagiCieViW4dOeVJNXlCP5SYb9hvF+Vo3KX8MxY+ggBuoTdeELp9PFh8sclNZDwAZ5ysPonZ7kh0+OFY3NJqBcPtgjheGPooJH6vZz9NT0o9Gaw8hqRWD0dVZ3ICTmREOZE+dVANlXQvwfDMC5j7YD/SviOTRzjlJ9/h3nG5Wp8Z6GHLquRTA+wEHYFsG1CsQAhlOAPTdHbpY77Rhg9AgMBAAEwDQYJKoZIhvcNAQELBQADggEBAJYR2NIMRZ7y0m88haXWaeRsJLDDEf+mmOuy0qOsOongJhQCC6Jq6mNUUNoAWtz83pryxTWMUVJ+h8ZeJ3njL9HIM9ZPLa6R+E6C0i41ErnfZr1ClHofJtPRMvT8kvyCwwvi2Q8bmS8x4zUYsLXbobxiHM/lfMASdFgjrLQxHfKCHC3hXDgfDdMQO5Uso+4EYfW1arR/ZeVqvHb9eOaO/VBECvjXsGtIouP5iWAMAB08jC9pIeXhdNU4q97lhhLGlwlbS7CDzkbAdNkVdq5b3MOFBhie2twIvBbpCLvMEX8wddXS/QA4+7F0VtCCD3YJ9IV5iM0ckNTC30H/X1eumew=
a75ebce1-aaec-42e7-b94b-73d719b8a2bb	b3e64afe-4a2b-4c5d-9f34-ebffb10a480e	privateKey	MIIEowIBAAKCAQEAtgiY7NR3be6MyylyHG9LrbuV669dpaLZjBDfshQKnAHNHr120IwSLE520+WLI36NSPCOyTJ5Lq2iR+xDhWlxvPZjvfB72lHYZQ2/UUYEdSrOpgzbhiZYY8XluUA1BDwc9JgGoIgonlYluHTnlSTV5Qj+UmG/YbxflaNyl/DMWPoIAbqE3XhC6fTxYfLHJTWQ8AGecrD6J2e5IdPjhWNzSagXD7YI4Xhj6KCR+r2c/TU9KPRmsPIakVg9HVWdyAk5kRDmRPnVQDZV0L8HwzAuY+2A/0r4jk0c45Sff4d5xuVqfGehhy6rkUwPsBB2BbBtQrEAIZTgD03R26WO+0YYPQIDAQABAoIBAAVxrGEo2YmIIN3Sl38SNQk1Gv65d+uEO01dE9OXldmklCXfNLZ3+fMpRZSAwPCG0GLmDt8li0pCFyBfiIVs6eHk3IbJsmqNGBOtnZMorOl0JkoBCG+ypeIWARDRQsSlp5gJE+mpKM3Tdb1WgbaMK3l2E2UTV03s/E7VXI/+u53Nj3LGnOxq3HaL2VzD62jJnrD682FB7uHUoV260rcepFQrAVMWMMHHjRF4januxkW3L7pIleUEVNN4OBolw/Lc2ImIHovjulG4n1j7VCda+oxt3vhC7ZaQwiWaubqk8pfTnkflSQS97ztPdexNZ8wZe5nZOurseO9hPvWOtxMLzGECgYEA+eBfdSUT5KB1jV6ZHB/fs6752+NykTSdYFOjlYJS0OFSLptgK03z66BJxYbZdjYCEQbiJB5BLixNTOX/UK4QJbY00156g8bwOwGE8ZFOAimrkqiHIaOmX9hck2yZw3F+4SFgQiFd8R7FUTsbi+I4QXEfjo11+cPYGE1Z8i17+fcCgYEAun6a1uZlTFcKX8DU8XWHCuPR5pTRuOn48yReONw5+ttcgUI+YDFBvzPAckRKhlKA1CtvO5JmfrTXRZazi7aal7lWURIWBHwGOfJnZDYtKCAUjnPGNc6nsLgJHSLGXfBHb9Gub9nvjmYoisPvJ5dJMJuluBbQBzp05ZkMUEvY0msCgYBO39th7+1Cmr/gev7bmNgVMONf3IDagwA2WtBlLjkUBDvbyGHn6XhYZUVEG5fjL5MhasnRWtd6SrOv1V3tSrSAIu6z1bvYguBrz8P2OMal+h9VcOsO3Eh1MqeuRXaX8eh6Cf4Hgd7UcMEaLg0475SQW7P5XH/j8kTxDuGYh3D96wKBgDfNjlNjWUhAezAvqQgfHKtbhAE04pQsHnvSlAb7jrXLUaCzy6pI0t19hMYsPQh4Q2g5Hu16XwTm48tEzrCtkRB5OqTDfqcU3WAVcm5/738kKkJ9zf9nuLGeP8viDe0p6pZA7as2UQIQ+2yaOENmd1X+HNY6rUCcc0IIS7DzIQvFAoGBAN2yHQC6MdQdGuDsEtYVtW8NfBd39TrgjUi1z17jJpFSbtVNsZAp+mHMtIKLz6kK11ss1y4g4cvOwd+ifl0T2BMdgP2A1u5P1O1YNL0oZtFWvl7bB2VE20K6qwtBr6JNlltqKFkjQYQybaqANOENUiuPWePibPf7UjNoT3Gs3WrD
c7ecb17e-4cd7-438b-ac15-72a57970b189	b3e64afe-4a2b-4c5d-9f34-ebffb10a480e	keyUse	SIG
beb6ed7c-aaf5-4e2c-883f-c093a756a4d4	b3e64afe-4a2b-4c5d-9f34-ebffb10a480e	priority	100
ef5077b9-11c0-4bb8-8e8f-85a8cb936e5d	bc170a29-c247-4f80-8a91-941455c18f3b	priority	100
1748e071-a1ec-4948-8dc7-191b58a2e724	bc170a29-c247-4f80-8a91-941455c18f3b	secret	SLkEQgwnCHYccQYgAH4yqc8LoDYYbAqCwiDjnpeQUaPJvC9jrLTlOXjsS41_wvrKwV9Q_qilxwJ7tzRtOSUV5ehnMWjTE7aM4GG4fWuuyAKM9lqIc-LpCzYKTevQV7DFZb5tpbb9TDG1l-O7CyaIB1jSw9_u-VCDb0MX8cWokmE
605355ea-e31f-4b69-9355-466e9eebc027	bc170a29-c247-4f80-8a91-941455c18f3b	algorithm	HS512
aeb22ae0-7a17-49ff-a71a-5aecee65ea12	bc170a29-c247-4f80-8a91-941455c18f3b	kid	77fe5826-9e23-484f-abd2-24ea89668281
0dcd8c65-fd88-45bb-b876-453432e403db	6944baff-c6c7-45e7-8c42-7275f43016f9	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
e6090999-929f-4dfc-9dbf-75ba36468529	59bc265c-c932-4fee-8ae4-55b7d64cc1fb	kid	4cd00910-83cf-4f60-a92c-601b9198e419
ee178a43-2f3c-4d0e-93f7-de4dc27f9883	59bc265c-c932-4fee-8ae4-55b7d64cc1fb	priority	100
26a2b35f-7147-4e81-a4fc-59d764d36387	59bc265c-c932-4fee-8ae4-55b7d64cc1fb	secret	KurdwvuiKcsSsAUQO_5Apw
a8f75e9d-abc6-4373-a229-4d9a0d737698	ee269cf3-acf7-45d8-8abb-bb6e12731231	priority	100
353f985e-d6fc-498a-ac25-469032dd5710	ee269cf3-acf7-45d8-8abb-bb6e12731231	privateKey	MIIEowIBAAKCAQEAxOFV7duqN2dUvhYG1hB0r8KhwHzR+n0/QGz5n+QpZphVeNNjYXy8W4wluQuJ3vA3wENFL347MMkQrtOluiPbvPaHrTq3qbiqhGFoGMXZB3zuAOhc06B3uGYopizqEXqkdlUgJVd9BR6Bz8iUyTEhcCecmdfuih1tFcNLZ2tnSFlw0DgvsRn6yisaS7qzb0/zeCTrancks0WHM8varBaYf2/tuziumcJEEfX7ZHmsfIOaEPsC0B7U9qAmycldhRem4mJxsYS45lnfbjtmXlIffP3ipHvBF6ebTV9TFUpuxlpoHSS6OIIZ4b5eqv8RmV+aow1JIoW7nOXjvdX0u/F0VQIDAQABAoIBAAuLNYFKLU4s/jMHEkTgQiHsGj/cZxN2NIyP1zMg1aybp1H7qGAW8um160r7pOHa2T9Usmx5Ik9XUBBwKHokOsYho7hB28hVI5UPgQ2yzBQ8Ua2L8lAWS0QXTrAvrKnJtHWbwtQYWnmVCFd+k1AYqV/sx/8yl1ynImDxn9eN3J3JRmLEt6mM4Lq2FZr7MypNo4GNcbmPMUYVh4CUmyV1WlTPP/3G0BkRmKD5aFt0iQLf3xRatXcdHsaSgPKoKS16QpNmIwPZ5MQlIRKsyyP/0xjMWo7kQw8ULB0wY75aihpa0FEkvnpSUmEaSWwDdVwCYUn/Di+e55PSaLNXKj6pHQECgYEA7aYI9UbHcCFA8bUcaZd/4j5Cpt67MgpjKF4d1nc6QhVl4Q3DxsvorFSJfhKILO4RTK0agPr3Kdz7HIQzMN2fYukdFTsyDeMdrOzK3XcUBztLWB3/VPhui7zgQpjaEdBHPykQIy0mliVG1/RseGBMWcw/yOMSh8Chl2QMaDPy9I0CgYEA1BVerXke3re9MN37Uz9U68t/RgiQaVYtUuFPFA7PNIQMknjF4T0gXR7SBObY3K/JZoNhXO/O+1TlYgtrdaZaPQYDvBXihubcoHybfrljSOR3KJllX/8eYKlsWTr/sycinZYekFsSL3o/CqVez0Pt8rwhsm9BVcnWB2SiF8eMYOkCgYEAr/xInfpwLqUxhszr4XYDifM5QIGodoIis/4ecneQeOeHroWW+Vx/TT69ItNubHdP8EwwWFuBNUsj2hY8Im+8XG7szpArnQUXMLuZ7y8DceeDABoWv0HJ+0k/eZHfy1lFqYwrGyGQdZfdQocK3InTgJw0j/s3+be48ndwiKoPvPECgYBElERxQ+E/k5qR2rYSTUBgnwUg2FQaO8ucKU8w5TkLeke2dWdHVkTI19aBz0QA2Lb/dyxcqQ79Jo6mDZtKB+jWIsPCZjFB/hUJsEF30OrR/06oyjGFwTFJgH+QuwtEGzuOSaTIeSqAP79y6damnwiqnTsoP+GYpBOZgGkJ13UFQQKBgHzE7udlRFVuAvwtkO+/l9z2wr9euEUvU4m2GXJ59vcqJIe2L+Y3GfsencBkoRzy7c3jyEQLUOzSapyyJ6/jrGuyXcZhsihAmH7HF4XkFgPSKrghchipFIOfVWZRjXbISnKteaYLxPyao41zYjPQQxMOaB7H5heWwH43Up7aaR6L
dac0d226-43f1-4e62-a151-4e4a731e7023	ee269cf3-acf7-45d8-8abb-bb6e12731231	keyUse	ENC
69ee0cbf-0be0-4cd4-8340-151109bed699	ee269cf3-acf7-45d8-8abb-bb6e12731231	certificate	MIICmzCCAYMCBgGYybM3SzANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwODIwMjI1NTIyWhcNMzUwODIwMjI1NzAyWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDE4VXt26o3Z1S+FgbWEHSvwqHAfNH6fT9AbPmf5ClmmFV402NhfLxbjCW5C4ne8DfAQ0UvfjswyRCu06W6I9u89oetOrepuKqEYWgYxdkHfO4A6FzToHe4ZiimLOoReqR2VSAlV30FHoHPyJTJMSFwJ5yZ1+6KHW0Vw0tna2dIWXDQOC+xGfrKKxpLurNvT/N4JOtqdySzRYczy9qsFph/b+27OK6ZwkQR9ftkeax8g5oQ+wLQHtT2oCbJyV2FF6biYnGxhLjmWd9uO2ZeUh98/eKke8EXp5tNX1MVSm7GWmgdJLo4ghnhvl6q/xGZX5qjDUkihbuc5eO91fS78XRVAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAJ1brRIqzLg8u9+yjWLH8G5D/gvE6bPGgkWBuykUcZzKAI7o6r8p6YziJnyp+MRnH/+ZlCpsYctF+YX4R5o/eO03uYlvDqovoi+zR1D5OAqGFMCABKXmV6HPGPgN/G0gBe0X0kH0Y6/hTevjyFhzzKat0Mzr3+BmBArBIpIDvZgxr98dxYOpWWoGtmaYLsyNiMtPJ25TtpSoRGk2Hs15FM2p15lJAVPRegxYjA2oh9IYbUpERnSi3Y/qkTq8iupgkoDvKOd1UdO2CqTUNLs1bnuLHKga9UmvI9aqrJSdNQ3DMyAasIP8ekrqG/QiNKChV7KGo7asCqMuwDom5t45pG8=
a5091be2-d9db-4921-8415-bed61eb24482	ee269cf3-acf7-45d8-8abb-bb6e12731231	algorithm	RSA-OAEP
b3e1bd6d-8880-488f-9490-c2eb4a91a88b	b5478687-2761-4af6-b2f1-6a3f4f817b98	privateKey	MIIEpAIBAAKCAQEA8iU+HN8eWD+DlEjjn2AoYyzUn7BYN5Nb4TxaDbpMKLC3qfIMs8b0DpQRDH4nRNto0hESMzGeAKcoycSrhYbUsuqWo4/sUEHJJ6py3ALmEw70HqZM2i2Yp3ehdUrv38+m7wQaXSVgEViy7Z7I6l4lY3wErMmcdXHIwAZbYfuxydPHO1Y010t7fYd8kURf/ewWsqZ+qED8o/rwPIBB7P4WxtB/jIyENUnbyVXz5B230KsWQNkvTyJ2aooozRJEiHQ1GXf3n5ufv15P/hETT/SRlUzdBECBmCZY9ZPMra11UNcMEdRyPfQFXty5UC/ur9JJFecucyZvm6bI61eXUj6jbwIDAQABAoIBAHYU8Ug1CeAxAOJT9SRoSOmsF/fTkAFyC9E3lBazraX+H2Jxlf4pXCSr0fCMqGusr14ZUw3B+XIKEhrqnFYeHSUuvsz+R1gP7J86QI7HnxjWJve3UyzmJVYtQYAoTfePlLFkB9M6gbGT1pWH5CReSs9L0B/OpUykcygpMXEDw3xOpjlyJM1XlXSwlOiH6ovWSLphxxbc9AlHNwIrRhx82KvEqTmkvLse3m7vK+px+BzCAQP4ZsUKcZdKukoh6ZxJNB2oklI4HaRQL9ZMci/NyEGGDfDEY0R2j2Cb+Qs92dV/YP2IVjLKqmqVuGWFRLUQFMxzaqy22smJ/2O7EBEyl0kCgYEA+hfSe7zmVECS5udxwC9b6pJRdK+P9E0vk61ZD5FX0tWhoVNVHn50htPcBDLDFYkSEG/Q0/wWtIe35/4kw5cTf6nfxvt4987jFqiWByRBYSdXlGAFrHXjgvKZCLvFzrG/9VGbDv4oIuOmz1GC/sOj4LGeow3WyOQ42ODKPiLjmesCgYEA991dn8+Rc58tTO3lNyefZTXJoe/hQVJ7m+zhAi+qW3zEa3Mz90cgGm3yIan0Fw40CgWqLJS6dtLvNKJCyn/hwDgFlAzZnI2o/EKAh9rsufaaTKoCtl4bbUCHEWT7LeVe218a6Snr5mmODRX65jYkSK7PI9R7ORnWVgOYeeu8V40CgYEAwMiSSS4hQvsQAoyQo/wd16F4xwD6b/D75tOunpCEaZKiaHCLYdlKzBAOPvI+baBe22rGSFK/0eP4wQ2om1ke/78cMA/zfNrvNK06EUFCYLjqCwdF+F5bxbpqe0/7uExO07VXWORUXiisko2b8/Uto2xoA/sMAYnjxFLrs6BDYIcCgYEAqpUHbQeeE5OVyp7ipB25vh7RYIhFXv5UIZBZnnaNaJ8qUsSbG/AwMOA/xlk/qmpU+BzD7CCDX2l1xKRzEQgHppEnjad2UB7SEKH38QeC6czEjkRmz3leqMbC7f6wOvrjWFhQne0C87TrVSguXycdu4PK/N6r2zVj5BhfZHEPUrUCgYBz17tE7YjR/YH9XrDNy/Mi3Ym9gLu8t0o2IKdFFHp3qetAQcqztIXp83ZsuJ/v0VzOf8CfLqz5X1VTHUWNYixr510qZ3kWEHBSyaBMEx1T2Anxh3v+WBOu9ughORvExlHjH8edKgRyOHjRlCoM/wConXiGJdQgugLNeQnuWq9beQ==
92351a72-db6a-42e0-8595-123cdf11dec0	b5478687-2761-4af6-b2f1-6a3f4f817b98	certificate	MIICnzCCAYcCBgGYybfhzjANBgkqhkiG9w0BAQsFADATMREwDwYDVQQDDAhtZWFsd3VybTAeFw0yNTA4MjAyMzAwMjhaFw0zNTA4MjAyMzAyMDhaMBMxETAPBgNVBAMMCG1lYWx3dXJtMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA8iU+HN8eWD+DlEjjn2AoYyzUn7BYN5Nb4TxaDbpMKLC3qfIMs8b0DpQRDH4nRNto0hESMzGeAKcoycSrhYbUsuqWo4/sUEHJJ6py3ALmEw70HqZM2i2Yp3ehdUrv38+m7wQaXSVgEViy7Z7I6l4lY3wErMmcdXHIwAZbYfuxydPHO1Y010t7fYd8kURf/ewWsqZ+qED8o/rwPIBB7P4WxtB/jIyENUnbyVXz5B230KsWQNkvTyJ2aooozRJEiHQ1GXf3n5ufv15P/hETT/SRlUzdBECBmCZY9ZPMra11UNcMEdRyPfQFXty5UC/ur9JJFecucyZvm6bI61eXUj6jbwIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQCUbbnuP6wTfaPWZiWBE6XLdfWCAniLacHbI84ps/wFrJyo7OFY7yTZnToha4S1pBTrpgvWudlAJ1VfzEGiaPrdvEMQ0Uui48SqhpmigKksBly7PaIRx+J9JrLBeY7HZgc4DbE6VR0LdDjfki9mBkrxT5rzVOGkp9NvYixcVOMHg84OGhO233Cv/HfLftRbKSHoJgRtmc40rm5j3eTbZ4/9J5LCbUCRvQCHLRnA3cayhhL79QlUy7ZV8vXQEpdaWkwHjzHQBRxXf9EzbNJG8ejtKlqG4PBErRu1GGq6LQaoact79s7EGrT/7xStQNHA1WiCWODL+WqmvZAHm98G8EBm
510c1c16-369a-4341-ac85-2af2d44ce88d	b5478687-2761-4af6-b2f1-6a3f4f817b98	priority	100
89fd099b-5d44-44ca-ac8a-0232c82434ae	b5478687-2761-4af6-b2f1-6a3f4f817b98	keyUse	SIG
529af4ca-6f18-49a5-8470-87f19d973539	ccd0584c-3628-49c2-9649-90cfaba75ed5	kid	33f52979-97d5-4105-aa1c-61c845e69ff9
d2f8731d-3ab5-4882-bb91-242542e438de	ccd0584c-3628-49c2-9649-90cfaba75ed5	priority	100
6635768e-1aa2-402e-8205-df32bcd2c924	ccd0584c-3628-49c2-9649-90cfaba75ed5	algorithm	HS512
28886261-c80f-492e-b36d-a19c217af73e	ccd0584c-3628-49c2-9649-90cfaba75ed5	secret	hmD79mcQxzGipOLFLQHm52wCq55h8Z1PHZ0RnDSpNhK0K4klh1rKfEtx5TdHk3wrs-VyhmQ1J7hd336aR1_qYfxQZDPBsdW4600N31gAlnbyoCQJBY4Plb-75oYEHLFbH2Me3jLTjZr1ste_v3Y9n2QQMSs1J_0N3zm0eETJVus
e56f9bb6-e08e-401a-af4c-ad69d58293fa	e5e03d06-5e83-4b84-8dd3-55624a3e273f	kid	a9e28c92-5e14-48a4-85ef-082aabe15718
f415c2b9-41b8-490c-9c4b-960ae7457e1b	e5e03d06-5e83-4b84-8dd3-55624a3e273f	secret	ajahdoOv4JIREZsb5bCtnQ
d6f09f26-ad79-4015-a638-efecd3a97781	e5e03d06-5e83-4b84-8dd3-55624a3e273f	priority	100
e58a2f24-e401-44b8-8042-1607871c728f	6c13c9e2-aef8-4ade-aad1-03a918b38b59	keyUse	ENC
4a793b5e-3233-4303-97b4-3018aa402d3b	6c13c9e2-aef8-4ade-aad1-03a918b38b59	certificate	MIICnzCCAYcCBgGYybfikjANBgkqhkiG9w0BAQsFADATMREwDwYDVQQDDAhtZWFsd3VybTAeFw0yNTA4MjAyMzAwMjhaFw0zNTA4MjAyMzAyMDhaMBMxETAPBgNVBAMMCG1lYWx3dXJtMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA2QK7InyTBu+BRqyAXg7JD8VlgcvLQkJAXnm5sH69Hjd406M8DJclRT5/IZCqbviRgoH/97k4VEmGRejoWN9qQcWnJPEBPA/YZ9yahyTeUAk7x4lfyPBjLLd3bK2gwIHtVOwcTm/2KXYvcUCdwbyXN0G1Yzk0jaqSeX3Y1Zc7WEddXx0wYKEm59/QsBu20XZz28YEQ/twAJvaB/hrPnYNWvCcrdGPHxQSRW9wtps9hWGOz9dp1Y08PtgOOxRivCgMKrCi+t/Dzm7Hgl/PQIEo6Uppo/m9/2w5Iu5Lw0+DxfUiG7RF6C6lf2hVuSv1u0nhIkoG6WzZNP2RjsGoaObJ3QIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQDQearonhazRmeVDMk/muJRICx+PByZZ0/FureT4iZUkL8JbHxvrtgcYtCAmyas+cYz9y1gYl9jXIUATbz5RUr2JQN6mGm/uxK7Zt2NbVCz0tqGuSKePuxkcgxFj5QKcOFuwwhRIvtvBrqu2xWoFKq3hUpwhSG58mQTcw26x0nPiFzu1/ROefecyLsQ3v8niNM8qrhlzVoavRLV/0kfd/drGnLQKoes25jUOf9o9+VfxpV9CvD4mUdspbshLMy4SPEQjhNZIMC+xy2uiCHn9f2/RfBBA29BpUjcWuKzzzyx2oyLkHRYbKWrHmv0wKAN4Jn7X2I04BQrTcLZ3mvX9yh0
03c5fda3-bbad-4f39-9053-4e5019639883	6c13c9e2-aef8-4ade-aad1-03a918b38b59	privateKey	MIIEogIBAAKCAQEA2QK7InyTBu+BRqyAXg7JD8VlgcvLQkJAXnm5sH69Hjd406M8DJclRT5/IZCqbviRgoH/97k4VEmGRejoWN9qQcWnJPEBPA/YZ9yahyTeUAk7x4lfyPBjLLd3bK2gwIHtVOwcTm/2KXYvcUCdwbyXN0G1Yzk0jaqSeX3Y1Zc7WEddXx0wYKEm59/QsBu20XZz28YEQ/twAJvaB/hrPnYNWvCcrdGPHxQSRW9wtps9hWGOz9dp1Y08PtgOOxRivCgMKrCi+t/Dzm7Hgl/PQIEo6Uppo/m9/2w5Iu5Lw0+DxfUiG7RF6C6lf2hVuSv1u0nhIkoG6WzZNP2RjsGoaObJ3QIDAQABAoIBAA3KZWOD6KECc+Punuq7RE43BGQa9BQGG0qVsDX12+VRb6F9aFnBeiocFl6m75nFPJP/WGmg8OI0WO7U5f0N15YN7jkEAsjTFfTFuWE4t9L8vzqHMZnWourKzvFOWF6bcx5YMdVPOqS4YLvw+AWBi1eE2rbPQhZ1nkDPvUmXhnst0dL+LHnlFfcSKRRt6FoLrXeGUzVU8z3ZulkGwOiXOgFlh/0tNg3vFCYIrL+14Ax2jjThf7limm04mushEgFT86rnQl0rvzAU2aNT16gW3BiJDO+bUHoXPyJUe75rHgBYz7CX+YluEdyVdRctfJEQOA1M5IK3cN897vmxc1hWtjkCgYEA+FOm9mWQEgMmMYKl2TY7G12/zt3u+O7CQQHiALujyncEmqcaZ1pDzEqmmDiFO6AvCdd25APEJgQn+fxFokKeJK7oGiKIY27uBLTU+OZbHjxdx3e/cRvu5XlWyKE1zrqKcVoMTDPJyo6hb1bWuxEbe1YLZVK0k0x8G7W2Lsb8MokCgYEA37dbpLNoAaD+pDJ0mogwsg3zG73I8A0yFaKUXlmRXDkZbLT/Fvqi37xQGscaR2UnC48Vqc0IRb1aH1tQcRBibS+ZEIpkihMQmT1K+QZCPofJ3A0EZyQzsHmQAjG035kktOF0s+28wJeJQH0BYwP/48qOxEfntK2dnWUW5+d217UCgYB0TYl3AR42sW7j5VKTpsiMCp5Y3qybvgcQtzcILNmLa66mV/kPysDSH2xjAqWzxVQCgf1W0US+oVevxy09z4GNoLVn+CB0oXGslpzgbdLjGFa7oyPwb6q1oty4Xnh69/b7G7eCwQaTbbXCFaPAPUTnwObZb6DPFBVUTQikY+GeMQKBgFx0Hj92lSj3K8UXxPCID/fFpA525C+whF5EjiRfx57hSgyO0Eziz6S+4ivu1IFk4Dn6q+08eoq3siL7TccsCkEtRoh7aQlWz6lEl1NKrt3AqD90cbleUK5Bzq3ZdPJjC7Rk6CHjwfmlpmcsQgJ1iK7O6ylavfsBNP3y5QB5u7dxAoGAXqMWL5GkSX9VcKzmkJws0hPYDZhy76DaOKKqWcZXd68I3r+YG2OKV1Fln3Sw7O3tjqGZ3rOKpy8kjtjWMxYy+OHqjJdshPCN4BMBmh/HVTPUylgFOcksE3H9sbQFTSBQgd3PPQIQJVNZ+2hbbFYKoAt4m/y8hwbn7SS7Lksk4MU=
d2f22dcf-6935-4d2e-8a73-4bec01e6a9eb	6c13c9e2-aef8-4ade-aad1-03a918b38b59	priority	100
521bca52-fb67-4583-961d-14ed80ae59bf	6c13c9e2-aef8-4ade-aad1-03a918b38b59	algorithm	RSA-OAEP
dda749e2-6da6-4de9-9651-a96d706891f7	e4a4939c-f932-43b7-abec-a82cf311657d	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
fdf56925-6d9a-4e67-8cc8-6a81a4f00d42	e4a4939c-f932-43b7-abec-a82cf311657d	allowed-protocol-mapper-types	oidc-full-name-mapper
15213913-10e0-4549-85f7-95273d5b2a66	e4a4939c-f932-43b7-abec-a82cf311657d	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
bf319b04-9254-4bcd-8eaf-83b52075aaef	e4a4939c-f932-43b7-abec-a82cf311657d	allowed-protocol-mapper-types	saml-user-property-mapper
8eccbdca-0d75-4214-8164-1f73b32fed78	e4a4939c-f932-43b7-abec-a82cf311657d	allowed-protocol-mapper-types	oidc-address-mapper
1d2736cc-74fa-4c91-8750-a5f859d055ab	e4a4939c-f932-43b7-abec-a82cf311657d	allowed-protocol-mapper-types	saml-role-list-mapper
40dd62ef-775f-449f-8e79-17e9334fe24f	e4a4939c-f932-43b7-abec-a82cf311657d	allowed-protocol-mapper-types	saml-user-attribute-mapper
2e71e1e9-272a-4a90-b2c0-737e78abbd4b	e4a4939c-f932-43b7-abec-a82cf311657d	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
501d90dd-f554-43b6-b656-b76e4afa0813	58fb9097-178b-4276-8d67-53c2a088ca0a	allow-default-scopes	true
245396fd-7e37-4375-a4e7-e177c0d8ea23	bb7e3b2f-2756-43fd-ba24-95f190849ce2	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
a4c137ae-b758-4341-877c-d80e4a005a88	bb7e3b2f-2756-43fd-ba24-95f190849ce2	allowed-protocol-mapper-types	saml-user-property-mapper
c5e719da-ba14-441b-90a1-751dd19ba38e	bb7e3b2f-2756-43fd-ba24-95f190849ce2	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
2891e1c4-bfab-4f98-b900-2c0c1e595bf6	bb7e3b2f-2756-43fd-ba24-95f190849ce2	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
49186755-c589-4217-bb5d-1856379c4bd3	bb7e3b2f-2756-43fd-ba24-95f190849ce2	allowed-protocol-mapper-types	saml-role-list-mapper
23530174-d47f-4e73-8010-1b854ff16774	bb7e3b2f-2756-43fd-ba24-95f190849ce2	allowed-protocol-mapper-types	saml-user-attribute-mapper
f39d6c5f-5cf1-4330-ab0a-d781d7f8fc39	bb7e3b2f-2756-43fd-ba24-95f190849ce2	allowed-protocol-mapper-types	oidc-full-name-mapper
512a7401-983e-484d-a544-8cefcc5e1a3d	bb7e3b2f-2756-43fd-ba24-95f190849ce2	allowed-protocol-mapper-types	oidc-address-mapper
849d14df-e9e2-4574-96cc-06416fd89b0c	77d0c0ce-7cad-4224-b695-397e114fe3c3	max-clients	200
bb1ea7eb-8566-492a-a78d-65f4408d9255	df7d71c0-5fac-406d-8b83-30c73daef3b2	client-uris-must-match	true
2c7fc3af-db0e-4587-8529-db4d427035d3	df7d71c0-5fac-406d-8b83-30c73daef3b2	host-sending-registration-request-must-match	true
087e1887-597f-4a1a-954a-54a9dcb98972	6530eb4a-b8a3-4904-873b-c6cbcf09eb22	allow-default-scopes	true
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.composite_role (composite, child_role) FROM stdin;
c8f9f357-481c-4493-b79f-af9cc4c19b54	34065eca-0f61-4572-b7ed-a7d833f7327b
c8f9f357-481c-4493-b79f-af9cc4c19b54	cb6328b8-cd1d-46b1-b198-5f128c55ac9e
c8f9f357-481c-4493-b79f-af9cc4c19b54	50c89b45-d6b0-4047-afe3-6c91c7068699
c8f9f357-481c-4493-b79f-af9cc4c19b54	18ea92a8-35eb-4d4e-a717-5119da0991c7
c8f9f357-481c-4493-b79f-af9cc4c19b54	05cc487b-e394-42a1-93e4-94fddcaf9dd4
c8f9f357-481c-4493-b79f-af9cc4c19b54	fab82415-c32c-4a78-8cba-74cf2d24dc36
c8f9f357-481c-4493-b79f-af9cc4c19b54	0ddafd6d-73ed-440c-a324-6badc83b02dc
c8f9f357-481c-4493-b79f-af9cc4c19b54	25c27ea0-7dcd-461d-880f-8a6ca914193c
c8f9f357-481c-4493-b79f-af9cc4c19b54	cc96f1e1-73b0-4bfd-b296-a393b499b2d8
c8f9f357-481c-4493-b79f-af9cc4c19b54	e1ecf6e7-c857-448d-b620-b140c8505909
c8f9f357-481c-4493-b79f-af9cc4c19b54	630fab6a-657a-4473-bf72-b11551838b57
c8f9f357-481c-4493-b79f-af9cc4c19b54	9bfc3bc3-cb30-48a1-8f9e-2e0dcf1d53d8
c8f9f357-481c-4493-b79f-af9cc4c19b54	b6f39ef2-127b-4382-8f4f-228fd2aaeefc
c8f9f357-481c-4493-b79f-af9cc4c19b54	51eb8dce-99a8-4286-a755-e87d84c49bc8
c8f9f357-481c-4493-b79f-af9cc4c19b54	45fa2f67-1cef-4421-8843-fae24d19f505
c8f9f357-481c-4493-b79f-af9cc4c19b54	0c10bf66-cdaa-49c4-aee5-67a758afc93d
c8f9f357-481c-4493-b79f-af9cc4c19b54	52386e51-867a-498f-9cb6-e399105d89a6
c8f9f357-481c-4493-b79f-af9cc4c19b54	8d1341f5-5c1e-450f-a071-f73bf7802f5f
05cc487b-e394-42a1-93e4-94fddcaf9dd4	0c10bf66-cdaa-49c4-aee5-67a758afc93d
18ea92a8-35eb-4d4e-a717-5119da0991c7	45fa2f67-1cef-4421-8843-fae24d19f505
18ea92a8-35eb-4d4e-a717-5119da0991c7	8d1341f5-5c1e-450f-a071-f73bf7802f5f
570a17f9-be4e-4bb0-93ba-1396fda1eb4b	01ac2597-5249-410a-81ed-97a9425286ed
570a17f9-be4e-4bb0-93ba-1396fda1eb4b	2a99939f-e2f5-4831-9d79-6146281fac01
2a99939f-e2f5-4831-9d79-6146281fac01	7fbe82a2-f987-43f5-aa39-1f5918dab314
ba68025b-7977-4b5d-be21-9cb423509391	60ad9c4f-14ac-4a3c-b615-3ef94daa3bd3
c8f9f357-481c-4493-b79f-af9cc4c19b54	5ba8ccfb-724c-42df-8dc1-858563dcefc5
570a17f9-be4e-4bb0-93ba-1396fda1eb4b	532db205-37f1-4d76-89f2-92f7daf40762
570a17f9-be4e-4bb0-93ba-1396fda1eb4b	d879b246-44bc-49a7-8827-27c2390cf39d
c8f9f357-481c-4493-b79f-af9cc4c19b54	3baed6dc-ec83-4081-993c-4a5c8b1cdb49
c8f9f357-481c-4493-b79f-af9cc4c19b54	6a2adb2b-ed59-4da6-b6d2-78650abe938a
c8f9f357-481c-4493-b79f-af9cc4c19b54	9b237490-233d-4cc9-80bb-55ff211efb72
c8f9f357-481c-4493-b79f-af9cc4c19b54	525ce390-966c-4dfc-be10-fb27c773cdfc
c8f9f357-481c-4493-b79f-af9cc4c19b54	9fe837d2-83a6-4023-9438-5516da9703cb
c8f9f357-481c-4493-b79f-af9cc4c19b54	f26f8884-1a54-4025-aad7-cd0981123320
c8f9f357-481c-4493-b79f-af9cc4c19b54	17590634-91d7-4bcb-9204-89de5503551a
c8f9f357-481c-4493-b79f-af9cc4c19b54	f0164c37-d1b7-4cae-95f6-8ff841a59e5d
c8f9f357-481c-4493-b79f-af9cc4c19b54	d2608ad3-ca5c-4391-9a6c-c8098c1d22b1
c8f9f357-481c-4493-b79f-af9cc4c19b54	b3e6d9ef-af09-47d7-89b9-0c4e405cdca0
c8f9f357-481c-4493-b79f-af9cc4c19b54	27b19c96-477b-49cb-8cad-50350d596021
c8f9f357-481c-4493-b79f-af9cc4c19b54	db4e4460-982e-41a3-83b9-aae578e74f63
c8f9f357-481c-4493-b79f-af9cc4c19b54	e602b813-5ee9-4fa6-8135-e8ebccd523d6
c8f9f357-481c-4493-b79f-af9cc4c19b54	a36fcb85-95ba-4a25-91dc-622bc4168cf5
c8f9f357-481c-4493-b79f-af9cc4c19b54	88534c3f-198f-4ffd-ba8e-4af06bf1b4a0
c8f9f357-481c-4493-b79f-af9cc4c19b54	05be0021-bb54-488c-8425-3be0be52cbd7
c8f9f357-481c-4493-b79f-af9cc4c19b54	d3d12f12-4d5e-4176-b1d3-910a437c3eff
525ce390-966c-4dfc-be10-fb27c773cdfc	88534c3f-198f-4ffd-ba8e-4af06bf1b4a0
9b237490-233d-4cc9-80bb-55ff211efb72	a36fcb85-95ba-4a25-91dc-622bc4168cf5
9b237490-233d-4cc9-80bb-55ff211efb72	d3d12f12-4d5e-4176-b1d3-910a437c3eff
96c5b0b5-0860-4da2-95a0-352684caee45	4a724813-0d4d-42e5-84fe-56b082a40f8c
96c5b0b5-0860-4da2-95a0-352684caee45	8a5de00c-33b5-4e1b-a217-bb9d9f04b58b
96c5b0b5-0860-4da2-95a0-352684caee45	a3f03e07-a791-46ec-bd5a-92a5b98bcc50
96c5b0b5-0860-4da2-95a0-352684caee45	8cf81b82-571b-4d7e-9411-9bc67b7e0785
96c5b0b5-0860-4da2-95a0-352684caee45	b3e60e5a-2159-4832-b0ed-c9d18b38d13c
96c5b0b5-0860-4da2-95a0-352684caee45	29ee398f-971f-453f-b575-420dcbe84ab0
96c5b0b5-0860-4da2-95a0-352684caee45	6806382a-5c2d-452c-b595-2ce7c6cde23a
96c5b0b5-0860-4da2-95a0-352684caee45	287c1f87-b774-4f43-9658-24102adface3
96c5b0b5-0860-4da2-95a0-352684caee45	e72937eb-1987-42bc-bc98-3b64077f937b
96c5b0b5-0860-4da2-95a0-352684caee45	fd26f8d7-f291-4b3f-88c0-cf5617622e45
96c5b0b5-0860-4da2-95a0-352684caee45	9cba42c4-ffab-483f-ac87-8aa49d1979a7
96c5b0b5-0860-4da2-95a0-352684caee45	08182a30-7a0b-4208-ae7e-4bb3aa0d7bb2
96c5b0b5-0860-4da2-95a0-352684caee45	13822a2d-ab1c-4aa7-9b2b-5a07fb5868b0
96c5b0b5-0860-4da2-95a0-352684caee45	a560950e-30f8-4902-b681-f2e35a7095e4
96c5b0b5-0860-4da2-95a0-352684caee45	d0189878-29a4-4b5e-a14a-ed4b2eae926e
96c5b0b5-0860-4da2-95a0-352684caee45	ad00b656-ae5f-45df-ad4c-7453068f29d1
96c5b0b5-0860-4da2-95a0-352684caee45	284e74c1-d013-4508-add4-2413f047205d
203ccff1-a8dd-48b0-8e84-419e0293d5b8	0c65922d-aee2-4356-98fe-7dc68a471356
8cf81b82-571b-4d7e-9411-9bc67b7e0785	d0189878-29a4-4b5e-a14a-ed4b2eae926e
a3f03e07-a791-46ec-bd5a-92a5b98bcc50	284e74c1-d013-4508-add4-2413f047205d
a3f03e07-a791-46ec-bd5a-92a5b98bcc50	a560950e-30f8-4902-b681-f2e35a7095e4
203ccff1-a8dd-48b0-8e84-419e0293d5b8	df95cde9-97ca-4121-b0be-6e2db4961e8c
df95cde9-97ca-4121-b0be-6e2db4961e8c	61f2a14e-5309-46c0-8dde-531a5c54accb
d81a8b2e-2173-4eec-be40-eeeea19483d8	3ccce739-85e6-4266-9c8f-3a57e590e85a
c8f9f357-481c-4493-b79f-af9cc4c19b54	57b7f4b3-6a3e-4bf5-b530-673aa50a2357
96c5b0b5-0860-4da2-95a0-352684caee45	edd15cfe-da78-48df-bd9b-4e2edcd5d05d
203ccff1-a8dd-48b0-8e84-419e0293d5b8	3d3cc335-d0f1-42e4-8887-4bfce55be516
203ccff1-a8dd-48b0-8e84-419e0293d5b8	c68e95ac-e31a-4b5c-9eda-6991d6a354fd
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
2077c455-97aa-4223-ac0f-9ab2062f1e16	\N	password	7157f634-21c5-4eb4-93af-c05171c60ce2	1755730622502	\N	{"value":"XBmWbTWowKsLEhaZxpCkkaHqlWBKX6yTnloySYFY498=","salt":"uBo6owKwuZODGxBN2YR5ZA==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
8f58d877-994e-4d49-86f3-6c3c631457e4	\N	password	1a5073e0-ec8d-4c6c-a747-a118c3417368	1755731918444	My password	{"value":"C0d+MPcIuzWyQ/o11bgMYfzHlYQ6WOm3j7ezqZ7TG6Y=","salt":"I2yT7treelcnl3aO3O8+5Q==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
74b25715-eca8-40e9-ba82-2166a16d3cc2	\N	password	a5928e7e-07bd-4d1f-a5f0-04d4db576c46	1755731946567	My password	{"value":"In2P+8WZK2Cda2FL3E4tOVhyyTwwrEnO2zHMu9owJBs=","salt":"bqwCp5KUQi5LZi1gZcCVzA==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
261ed0cf-7d9e-4d5e-ba6c-731279b25bc8	\N	password	26949c13-c089-4da7-8be0-229e3bd68cd4	1755791711204	\N	{"value":"59FOq9EtWfhA7ITWxjTQAHe/cS2PK8DFXS3fM5Blsts=","salt":"UjrWPtfSMoqle8Bfh2sGtg==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2025-08-20 22:56:54.603869	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.29.1	\N	\N	5730614303
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2025-08-20 22:56:54.615001	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.29.1	\N	\N	5730614303
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2025-08-20 22:56:54.650567	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.29.1	\N	\N	5730614303
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2025-08-20 22:56:54.653567	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	5730614303
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2025-08-20 22:56:54.733588	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.29.1	\N	\N	5730614303
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2025-08-20 22:56:54.739001	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.29.1	\N	\N	5730614303
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2025-08-20 22:56:54.809478	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.29.1	\N	\N	5730614303
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2025-08-20 22:56:54.814073	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.29.1	\N	\N	5730614303
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2025-08-20 22:56:54.821121	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.29.1	\N	\N	5730614303
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2025-08-20 22:56:54.903611	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.29.1	\N	\N	5730614303
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2025-08-20 22:56:54.935021	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	5730614303
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2025-08-20 22:56:54.937544	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	5730614303
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2025-08-20 22:56:54.95664	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	5730614303
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-08-20 22:56:54.969327	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.29.1	\N	\N	5730614303
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-08-20 22:56:54.970182	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	5730614303
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-08-20 22:56:54.971707	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.29.1	\N	\N	5730614303
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-08-20 22:56:54.97368	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.29.1	\N	\N	5730614303
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2025-08-20 22:56:55.004543	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.29.1	\N	\N	5730614303
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2025-08-20 22:56:55.031302	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.29.1	\N	\N	5730614303
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2025-08-20 22:56:55.034878	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.29.1	\N	\N	5730614303
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2025-08-20 22:56:55.036981	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.29.1	\N	\N	5730614303
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2025-08-20 22:56:55.039162	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.29.1	\N	\N	5730614303
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2025-08-20 22:56:55.082994	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.29.1	\N	\N	5730614303
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2025-08-20 22:56:55.086504	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.29.1	\N	\N	5730614303
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2025-08-20 22:56:55.087294	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.29.1	\N	\N	5730614303
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2025-08-20 22:56:55.34348	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.29.1	\N	\N	5730614303
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2025-08-20 22:56:55.3887	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.29.1	\N	\N	5730614303
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2025-08-20 22:56:55.395723	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.29.1	\N	\N	5730614303
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2025-08-20 22:56:55.427024	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.29.1	\N	\N	5730614303
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2025-08-20 22:56:55.436037	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.29.1	\N	\N	5730614303
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2025-08-20 22:56:55.457057	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.29.1	\N	\N	5730614303
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2025-08-20 22:56:55.460653	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.29.1	\N	\N	5730614303
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-08-20 22:56:55.465817	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	5730614303
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-08-20 22:56:55.467042	34	MARK_RAN	9:3a32bace77c84d7678d035a7f5a8084e	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.29.1	\N	\N	5730614303
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-08-20 22:56:55.498016	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.29.1	\N	\N	5730614303
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2025-08-20 22:56:55.501694	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.29.1	\N	\N	5730614303
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-08-20 22:56:55.505119	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	5730614303
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2025-08-20 22:56:55.507269	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.29.1	\N	\N	5730614303
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2025-08-20 22:56:55.509434	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.29.1	\N	\N	5730614303
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-08-20 22:56:55.510239	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.29.1	\N	\N	5730614303
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-08-20 22:56:55.511438	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.29.1	\N	\N	5730614303
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2025-08-20 22:56:55.51502	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.29.1	\N	\N	5730614303
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-08-20 22:56:57.402133	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.29.1	\N	\N	5730614303
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2025-08-20 22:56:57.406828	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.29.1	\N	\N	5730614303
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-08-20 22:56:57.409757	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.29.1	\N	\N	5730614303
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-08-20 22:56:57.413581	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.29.1	\N	\N	5730614303
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-08-20 22:56:57.414387	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.29.1	\N	\N	5730614303
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-08-20 22:56:57.530744	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.29.1	\N	\N	5730614303
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-08-20 22:56:57.535999	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.29.1	\N	\N	5730614303
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2025-08-20 22:56:57.561295	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.29.1	\N	\N	5730614303
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2025-08-20 22:56:57.860273	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.29.1	\N	\N	5730614303
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2025-08-20 22:56:57.863015	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	5730614303
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2025-08-20 22:56:57.865217	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.29.1	\N	\N	5730614303
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2025-08-20 22:56:57.867631	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.29.1	\N	\N	5730614303
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-08-20 22:56:57.871334	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.29.1	\N	\N	5730614303
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-08-20 22:56:57.875054	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.29.1	\N	\N	5730614303
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-08-20 22:56:57.918718	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.29.1	\N	\N	5730614303
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-08-20 22:56:58.235854	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.29.1	\N	\N	5730614303
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2025-08-20 22:56:58.253155	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.29.1	\N	\N	5730614303
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2025-08-20 22:56:58.257855	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.29.1	\N	\N	5730614303
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-08-20 22:56:58.263605	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.29.1	\N	\N	5730614303
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-08-20 22:56:58.265929	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.29.1	\N	\N	5730614303
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2025-08-20 22:56:58.267722	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.29.1	\N	\N	5730614303
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2025-08-20 22:56:58.269622	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.29.1	\N	\N	5730614303
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2025-08-20 22:56:58.271512	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.29.1	\N	\N	5730614303
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2025-08-20 22:56:58.295791	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.29.1	\N	\N	5730614303
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2025-08-20 22:56:58.319266	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.29.1	\N	\N	5730614303
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2025-08-20 22:56:58.322648	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.29.1	\N	\N	5730614303
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2025-08-20 22:56:58.349084	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.29.1	\N	\N	5730614303
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2025-08-20 22:56:58.352494	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.29.1	\N	\N	5730614303
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2025-08-20 22:56:58.355583	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.29.1	\N	\N	5730614303
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-08-20 22:56:58.360361	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	5730614303
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-08-20 22:56:58.365416	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	5730614303
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-08-20 22:56:58.366582	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	5730614303
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-08-20 22:56:58.380669	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.29.1	\N	\N	5730614303
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-08-20 22:56:58.409255	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.29.1	\N	\N	5730614303
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-08-20 22:56:58.411915	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.29.1	\N	\N	5730614303
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-08-20 22:56:58.412855	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.29.1	\N	\N	5730614303
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-08-20 22:56:58.425478	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.29.1	\N	\N	5730614303
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-08-20 22:56:58.429273	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.29.1	\N	\N	5730614303
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-08-20 22:56:58.458575	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.29.1	\N	\N	5730614303
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-08-20 22:56:58.459857	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	5730614303
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-08-20 22:56:58.462929	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	5730614303
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-08-20 22:56:58.463864	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	5730614303
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-08-20 22:56:58.491823	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	5730614303
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2025-08-20 22:56:58.494572	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.29.1	\N	\N	5730614303
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-08-20 22:56:58.505219	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.29.1	\N	\N	5730614303
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-08-20 22:56:58.512323	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.29.1	\N	\N	5730614303
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-08-20 22:56:58.517426	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.29.1	\N	\N	5730614303
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-08-20 22:56:58.521731	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.29.1	\N	\N	5730614303
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-08-20 22:56:58.542864	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	5730614303
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-08-20 22:56:58.547039	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.29.1	\N	\N	5730614303
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-08-20 22:56:58.547889	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.29.1	\N	\N	5730614303
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-08-20 22:56:58.551911	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.29.1	\N	\N	5730614303
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-08-20 22:56:58.553078	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.29.1	\N	\N	5730614303
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-08-20 22:56:58.558301	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.29.1	\N	\N	5730614303
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-08-20 22:56:58.630357	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	5730614303
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-08-20 22:56:58.631413	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	5730614303
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-08-20 22:56:58.650171	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	5730614303
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-08-20 22:56:58.679489	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	5730614303
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-08-20 22:56:58.680601	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	5730614303
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-08-20 22:56:58.715609	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.29.1	\N	\N	5730614303
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-08-20 22:56:58.724778	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.29.1	\N	\N	5730614303
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2025-08-20 22:56:58.73318	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.29.1	\N	\N	5730614303
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2025-08-20 22:56:58.769434	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.29.1	\N	\N	5730614303
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2025-08-20 22:56:58.811248	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.29.1	\N	\N	5730614303
18.0.15-30992-index-consent	keycloak	META-INF/jpa-changelog-18.0.15.xml	2025-08-20 22:56:58.846421	107	EXECUTED	9:80071ede7a05604b1f4906f3bf3b00f0	createIndex indexName=IDX_USCONSENT_SCOPE_ID, tableName=USER_CONSENT_CLIENT_SCOPE		\N	4.29.1	\N	\N	5730614303
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2025-08-20 22:56:58.849836	108	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.29.1	\N	\N	5730614303
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-08-20 22:56:58.874899	109	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.29.1	\N	\N	5730614303
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-08-20 22:56:58.87596	110	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.29.1	\N	\N	5730614303
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-08-20 22:56:58.883191	111	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	5730614303
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2025-08-20 22:56:58.888041	112	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.29.1	\N	\N	5730614303
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2025-08-20 22:56:58.919627	113	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.29.1	\N	\N	5730614303
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2025-08-20 22:56:58.922853	114	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.29.1	\N	\N	5730614303
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2025-08-20 22:56:58.926877	115	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.29.1	\N	\N	5730614303
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2025-08-20 22:56:58.927838	116	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.29.1	\N	\N	5730614303
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2025-08-20 22:56:58.93285	117	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.29.1	\N	\N	5730614303
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2025-08-20 22:56:58.935712	118	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	5730614303
24.0.0-9758	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-08-20 22:56:59.098651	119	EXECUTED	9:502c557a5189f600f0f445a9b49ebbce	addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...		\N	4.29.1	\N	\N	5730614303
24.0.0-9758-2	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-08-20 22:56:59.106596	120	EXECUTED	9:bf0fdee10afdf597a987adbf291db7b2	customChange		\N	4.29.1	\N	\N	5730614303
24.0.0-26618-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-08-20 22:56:59.109967	121	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	5730614303
24.0.0-26618-reindex	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-08-20 22:56:59.137988	122	EXECUTED	9:08707c0f0db1cef6b352db03a60edc7f	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	5730614303
24.0.2-27228	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-08-20 22:56:59.141014	123	EXECUTED	9:eaee11f6b8aa25d2cc6a84fb86fc6238	customChange		\N	4.29.1	\N	\N	5730614303
24.0.2-27967-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-08-20 22:56:59.141898	124	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	5730614303
24.0.2-27967-reindex	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-08-20 22:56:59.14312	125	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	5730614303
25.0.0-28265-tables	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-20 22:56:59.1468	126	EXECUTED	9:deda2df035df23388af95bbd36c17cef	addColumn tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	5730614303
25.0.0-28265-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-20 22:56:59.170036	127	EXECUTED	9:3e96709818458ae49f3c679ae58d263a	createIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	5730614303
25.0.0-28265-index-cleanup-uss-createdon	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-20 22:56:59.218785	128	EXECUTED	9:78ab4fc129ed5e8265dbcc3485fba92f	dropIndex indexName=IDX_OFFLINE_USS_CREATEDON, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	5730614303
25.0.0-28265-index-cleanup-uss-preload	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-20 22:56:59.251605	129	EXECUTED	9:de5f7c1f7e10994ed8b62e621d20eaab	dropIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	5730614303
25.0.0-28265-index-cleanup-uss-by-usersess	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-20 22:56:59.288773	130	EXECUTED	9:6eee220d024e38e89c799417ec33667f	dropIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	5730614303
25.0.0-28265-index-cleanup-css-preload	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-20 22:56:59.327153	131	EXECUTED	9:5411d2fb2891d3e8d63ddb55dfa3c0c9	dropIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	5730614303
25.0.0-28265-index-2-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-20 22:56:59.330885	132	MARK_RAN	9:b7ef76036d3126bb83c2423bf4d449d6	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	5730614303
25.0.0-28265-index-2-not-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-20 22:56:59.387002	133	EXECUTED	9:23396cf51ab8bc1ae6f0cac7f9f6fcf7	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	5730614303
25.0.0-org	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-20 22:56:59.398638	134	EXECUTED	9:5c859965c2c9b9c72136c360649af157	createTable tableName=ORG; addUniqueConstraint constraintName=UK_ORG_NAME, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_GROUP, tableName=ORG; createTable tableName=ORG_DOMAIN		\N	4.29.1	\N	\N	5730614303
unique-consentuser	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-20 22:56:59.409667	135	EXECUTED	9:5857626a2ea8767e9a6c66bf3a2cb32f	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.29.1	\N	\N	5730614303
unique-consentuser-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-20 22:56:59.413625	136	MARK_RAN	9:b79478aad5adaa1bc428e31563f55e8e	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.29.1	\N	\N	5730614303
25.0.0-28861-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-08-20 22:56:59.485255	137	EXECUTED	9:b9acb58ac958d9ada0fe12a5d4794ab1	createIndex indexName=IDX_PERM_TICKET_REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; createIndex indexName=IDX_PERM_TICKET_OWNER, tableName=RESOURCE_SERVER_PERM_TICKET		\N	4.29.1	\N	\N	5730614303
26.0.0-org-alias	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-08-20 22:56:59.49123	138	EXECUTED	9:6ef7d63e4412b3c2d66ed179159886a4	addColumn tableName=ORG; update tableName=ORG; addNotNullConstraint columnName=ALIAS, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_ALIAS, tableName=ORG		\N	4.29.1	\N	\N	5730614303
26.0.0-org-group	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-08-20 22:56:59.50463	139	EXECUTED	9:da8e8087d80ef2ace4f89d8c5b9ca223	addColumn tableName=KEYCLOAK_GROUP; update tableName=KEYCLOAK_GROUP; addNotNullConstraint columnName=TYPE, tableName=KEYCLOAK_GROUP; customChange		\N	4.29.1	\N	\N	5730614303
26.0.0-org-indexes	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-08-20 22:56:59.537587	140	EXECUTED	9:79b05dcd610a8c7f25ec05135eec0857	createIndex indexName=IDX_ORG_DOMAIN_ORG_ID, tableName=ORG_DOMAIN		\N	4.29.1	\N	\N	5730614303
26.0.0-org-group-membership	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-08-20 22:56:59.541379	141	EXECUTED	9:a6ace2ce583a421d89b01ba2a28dc2d4	addColumn tableName=USER_GROUP_MEMBERSHIP; update tableName=USER_GROUP_MEMBERSHIP; addNotNullConstraint columnName=MEMBERSHIP_TYPE, tableName=USER_GROUP_MEMBERSHIP		\N	4.29.1	\N	\N	5730614303
31296-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-08-20 22:56:59.545645	142	EXECUTED	9:64ef94489d42a358e8304b0e245f0ed4	createTable tableName=REVOKED_TOKEN; addPrimaryKey constraintName=CONSTRAINT_RT, tableName=REVOKED_TOKEN		\N	4.29.1	\N	\N	5730614303
31725-index-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-08-20 22:56:59.582227	143	EXECUTED	9:b994246ec2bf7c94da881e1d28782c7b	createIndex indexName=IDX_REV_TOKEN_ON_EXPIRE, tableName=REVOKED_TOKEN		\N	4.29.1	\N	\N	5730614303
26.0.0-idps-for-login	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-08-20 22:56:59.651601	144	EXECUTED	9:51f5fffadf986983d4bd59582c6c1604	addColumn tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_REALM_ORG, tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_FOR_LOGIN, tableName=IDENTITY_PROVIDER; customChange		\N	4.29.1	\N	\N	5730614303
26.0.0-32583-drop-redundant-index-on-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-08-20 22:56:59.677788	145	EXECUTED	9:24972d83bf27317a055d234187bb4af9	dropIndex indexName=IDX_US_SESS_ID_ON_CL_SESS, tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	5730614303
26.0.0.32582-remove-tables-user-session-user-session-note-and-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-08-20 22:56:59.697855	146	EXECUTED	9:febdc0f47f2ed241c59e60f58c3ceea5	dropTable tableName=CLIENT_SESSION_ROLE; dropTable tableName=CLIENT_SESSION_NOTE; dropTable tableName=CLIENT_SESSION_PROT_MAPPER; dropTable tableName=CLIENT_SESSION_AUTH_STATUS; dropTable tableName=CLIENT_USER_SESSION_NOTE; dropTable tableName=CLI...		\N	4.29.1	\N	\N	5730614303
26.0.0-33201-org-redirect-url	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-08-20 22:56:59.70212	147	EXECUTED	9:4d0e22b0ac68ebe9794fa9cb752ea660	addColumn tableName=ORG		\N	4.29.1	\N	\N	5730614303
29399-jdbc-ping-default	keycloak	META-INF/jpa-changelog-26.1.0.xml	2025-08-20 22:56:59.712726	148	EXECUTED	9:007dbe99d7203fca403b89d4edfdf21e	createTable tableName=JGROUPS_PING; addPrimaryKey constraintName=CONSTRAINT_JGROUPS_PING, tableName=JGROUPS_PING		\N	4.29.1	\N	\N	5730614303
26.1.0-34013	keycloak	META-INF/jpa-changelog-26.1.0.xml	2025-08-20 22:56:59.730694	149	EXECUTED	9:e6b686a15759aef99a6d758a5c4c6a26	addColumn tableName=ADMIN_EVENT_ENTITY		\N	4.29.1	\N	\N	5730614303
26.1.0-34380	keycloak	META-INF/jpa-changelog-26.1.0.xml	2025-08-20 22:56:59.736823	150	EXECUTED	9:ac8b9edb7c2b6c17a1c7a11fcf5ccf01	dropTable tableName=USERNAME_LOGIN_FAILURE		\N	4.29.1	\N	\N	5730614303
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
cce4122f-9b89-420a-bd97-dc991169c190	2ecd7335-158f-42ca-a11f-40b3e3977158	f
cce4122f-9b89-420a-bd97-dc991169c190	4f20806e-7577-4b53-ad34-754a77ebfa5d	t
cce4122f-9b89-420a-bd97-dc991169c190	527a0e4f-4ab4-42ed-be81-c3166f4cbf1e	t
cce4122f-9b89-420a-bd97-dc991169c190	c5e68625-65ff-4723-8b83-dbc965ced676	t
cce4122f-9b89-420a-bd97-dc991169c190	9eccf774-4cd5-4f2a-829b-14adbff99cea	t
cce4122f-9b89-420a-bd97-dc991169c190	0273bfe9-94bf-4789-9d32-6d496057f2ef	f
cce4122f-9b89-420a-bd97-dc991169c190	585a4801-6e6d-4417-98b8-2d3984080635	f
cce4122f-9b89-420a-bd97-dc991169c190	4e85f1fa-ac35-4a19-8500-f211780b130d	t
cce4122f-9b89-420a-bd97-dc991169c190	e395ccda-2bf8-4a1a-a79f-14e62a00e954	t
cce4122f-9b89-420a-bd97-dc991169c190	7ee2413b-851b-4155-9e9a-7a30f4c6d406	f
cce4122f-9b89-420a-bd97-dc991169c190	f7fd1bf7-d593-4e9e-b459-332b8318415d	t
cce4122f-9b89-420a-bd97-dc991169c190	240f22bf-89e6-4ee2-ae61-1a7c25dd3434	t
cce4122f-9b89-420a-bd97-dc991169c190	0666a187-c81e-4513-a921-8615212ad07d	f
38d94c69-6603-4341-a226-f65366146032	7d703584-37c2-4c25-a46a-30bf9e37f62d	f
38d94c69-6603-4341-a226-f65366146032	108c6856-ea9c-46b4-9d2c-20533ecf376c	t
38d94c69-6603-4341-a226-f65366146032	dd8875a0-d565-4487-9eca-718f74785bd6	t
38d94c69-6603-4341-a226-f65366146032	a33162e5-f6df-4608-9796-b95e156a1d8f	t
38d94c69-6603-4341-a226-f65366146032	9fae9540-7efc-42f9-962f-01723becf220	t
38d94c69-6603-4341-a226-f65366146032	22163393-0526-4ebd-baea-94515880fdf4	f
38d94c69-6603-4341-a226-f65366146032	3f33c4cf-c478-4e24-9955-744f16b3370a	f
38d94c69-6603-4341-a226-f65366146032	d5f0eb87-574a-4a35-81b7-91c278c476a2	t
38d94c69-6603-4341-a226-f65366146032	4345e7ac-1678-4eb2-909d-4e0cf6858ce9	t
38d94c69-6603-4341-a226-f65366146032	44c04c4d-ddf3-4729-a5ab-f96f551f55d8	f
38d94c69-6603-4341-a226-f65366146032	b55b05c7-ecef-4449-b947-e0f4c1592755	t
38d94c69-6603-4341-a226-f65366146032	1208d451-edf5-46a3-b16f-afa1d0061a44	t
38d94c69-6603-4341-a226-f65366146032	27bb686a-c1a9-43dd-bc00-118bf917b1e3	f
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
54bff689-6216-4f4d-ab85-03d0503fefd5	\N	\N	\N	\N	0	2 pieces of bread	096a2232-f038-4047-a55c-dc34661a03a9
0fc05b69-697a-486a-b5d2-408506e3727b	\N	\N	\N	\N	1	1T peanut butter	096a2232-f038-4047-a55c-dc34661a03a9
85e1ea52-fbcf-44f3-b166-78ad2df85d4a	\N	\N	\N	\N	2	1T jam or jelly	096a2232-f038-4047-a55c-dc34661a03a9
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
570a17f9-be4e-4bb0-93ba-1396fda1eb4b	cce4122f-9b89-420a-bd97-dc991169c190	f	${role_default-roles}	default-roles-master	cce4122f-9b89-420a-bd97-dc991169c190	\N	\N
34065eca-0f61-4572-b7ed-a7d833f7327b	cce4122f-9b89-420a-bd97-dc991169c190	f	${role_create-realm}	create-realm	cce4122f-9b89-420a-bd97-dc991169c190	\N	\N
c8f9f357-481c-4493-b79f-af9cc4c19b54	cce4122f-9b89-420a-bd97-dc991169c190	f	${role_admin}	admin	cce4122f-9b89-420a-bd97-dc991169c190	\N	\N
cb6328b8-cd1d-46b1-b198-5f128c55ac9e	efd4d5ad-dc20-455a-af96-473ecb04282d	t	${role_create-client}	create-client	cce4122f-9b89-420a-bd97-dc991169c190	efd4d5ad-dc20-455a-af96-473ecb04282d	\N
50c89b45-d6b0-4047-afe3-6c91c7068699	efd4d5ad-dc20-455a-af96-473ecb04282d	t	${role_view-realm}	view-realm	cce4122f-9b89-420a-bd97-dc991169c190	efd4d5ad-dc20-455a-af96-473ecb04282d	\N
18ea92a8-35eb-4d4e-a717-5119da0991c7	efd4d5ad-dc20-455a-af96-473ecb04282d	t	${role_view-users}	view-users	cce4122f-9b89-420a-bd97-dc991169c190	efd4d5ad-dc20-455a-af96-473ecb04282d	\N
05cc487b-e394-42a1-93e4-94fddcaf9dd4	efd4d5ad-dc20-455a-af96-473ecb04282d	t	${role_view-clients}	view-clients	cce4122f-9b89-420a-bd97-dc991169c190	efd4d5ad-dc20-455a-af96-473ecb04282d	\N
fab82415-c32c-4a78-8cba-74cf2d24dc36	efd4d5ad-dc20-455a-af96-473ecb04282d	t	${role_view-events}	view-events	cce4122f-9b89-420a-bd97-dc991169c190	efd4d5ad-dc20-455a-af96-473ecb04282d	\N
0ddafd6d-73ed-440c-a324-6badc83b02dc	efd4d5ad-dc20-455a-af96-473ecb04282d	t	${role_view-identity-providers}	view-identity-providers	cce4122f-9b89-420a-bd97-dc991169c190	efd4d5ad-dc20-455a-af96-473ecb04282d	\N
25c27ea0-7dcd-461d-880f-8a6ca914193c	efd4d5ad-dc20-455a-af96-473ecb04282d	t	${role_view-authorization}	view-authorization	cce4122f-9b89-420a-bd97-dc991169c190	efd4d5ad-dc20-455a-af96-473ecb04282d	\N
cc96f1e1-73b0-4bfd-b296-a393b499b2d8	efd4d5ad-dc20-455a-af96-473ecb04282d	t	${role_manage-realm}	manage-realm	cce4122f-9b89-420a-bd97-dc991169c190	efd4d5ad-dc20-455a-af96-473ecb04282d	\N
e1ecf6e7-c857-448d-b620-b140c8505909	efd4d5ad-dc20-455a-af96-473ecb04282d	t	${role_manage-users}	manage-users	cce4122f-9b89-420a-bd97-dc991169c190	efd4d5ad-dc20-455a-af96-473ecb04282d	\N
630fab6a-657a-4473-bf72-b11551838b57	efd4d5ad-dc20-455a-af96-473ecb04282d	t	${role_manage-clients}	manage-clients	cce4122f-9b89-420a-bd97-dc991169c190	efd4d5ad-dc20-455a-af96-473ecb04282d	\N
9bfc3bc3-cb30-48a1-8f9e-2e0dcf1d53d8	efd4d5ad-dc20-455a-af96-473ecb04282d	t	${role_manage-events}	manage-events	cce4122f-9b89-420a-bd97-dc991169c190	efd4d5ad-dc20-455a-af96-473ecb04282d	\N
b6f39ef2-127b-4382-8f4f-228fd2aaeefc	efd4d5ad-dc20-455a-af96-473ecb04282d	t	${role_manage-identity-providers}	manage-identity-providers	cce4122f-9b89-420a-bd97-dc991169c190	efd4d5ad-dc20-455a-af96-473ecb04282d	\N
51eb8dce-99a8-4286-a755-e87d84c49bc8	efd4d5ad-dc20-455a-af96-473ecb04282d	t	${role_manage-authorization}	manage-authorization	cce4122f-9b89-420a-bd97-dc991169c190	efd4d5ad-dc20-455a-af96-473ecb04282d	\N
45fa2f67-1cef-4421-8843-fae24d19f505	efd4d5ad-dc20-455a-af96-473ecb04282d	t	${role_query-users}	query-users	cce4122f-9b89-420a-bd97-dc991169c190	efd4d5ad-dc20-455a-af96-473ecb04282d	\N
0c10bf66-cdaa-49c4-aee5-67a758afc93d	efd4d5ad-dc20-455a-af96-473ecb04282d	t	${role_query-clients}	query-clients	cce4122f-9b89-420a-bd97-dc991169c190	efd4d5ad-dc20-455a-af96-473ecb04282d	\N
52386e51-867a-498f-9cb6-e399105d89a6	efd4d5ad-dc20-455a-af96-473ecb04282d	t	${role_query-realms}	query-realms	cce4122f-9b89-420a-bd97-dc991169c190	efd4d5ad-dc20-455a-af96-473ecb04282d	\N
8d1341f5-5c1e-450f-a071-f73bf7802f5f	efd4d5ad-dc20-455a-af96-473ecb04282d	t	${role_query-groups}	query-groups	cce4122f-9b89-420a-bd97-dc991169c190	efd4d5ad-dc20-455a-af96-473ecb04282d	\N
01ac2597-5249-410a-81ed-97a9425286ed	9ee22a07-854e-4b97-a636-a8a17d2cc1a4	t	${role_view-profile}	view-profile	cce4122f-9b89-420a-bd97-dc991169c190	9ee22a07-854e-4b97-a636-a8a17d2cc1a4	\N
2a99939f-e2f5-4831-9d79-6146281fac01	9ee22a07-854e-4b97-a636-a8a17d2cc1a4	t	${role_manage-account}	manage-account	cce4122f-9b89-420a-bd97-dc991169c190	9ee22a07-854e-4b97-a636-a8a17d2cc1a4	\N
7fbe82a2-f987-43f5-aa39-1f5918dab314	9ee22a07-854e-4b97-a636-a8a17d2cc1a4	t	${role_manage-account-links}	manage-account-links	cce4122f-9b89-420a-bd97-dc991169c190	9ee22a07-854e-4b97-a636-a8a17d2cc1a4	\N
5b3289af-e458-4666-9689-7b7e512194aa	9ee22a07-854e-4b97-a636-a8a17d2cc1a4	t	${role_view-applications}	view-applications	cce4122f-9b89-420a-bd97-dc991169c190	9ee22a07-854e-4b97-a636-a8a17d2cc1a4	\N
60ad9c4f-14ac-4a3c-b615-3ef94daa3bd3	9ee22a07-854e-4b97-a636-a8a17d2cc1a4	t	${role_view-consent}	view-consent	cce4122f-9b89-420a-bd97-dc991169c190	9ee22a07-854e-4b97-a636-a8a17d2cc1a4	\N
ba68025b-7977-4b5d-be21-9cb423509391	9ee22a07-854e-4b97-a636-a8a17d2cc1a4	t	${role_manage-consent}	manage-consent	cce4122f-9b89-420a-bd97-dc991169c190	9ee22a07-854e-4b97-a636-a8a17d2cc1a4	\N
0b0f3db9-e0cc-4a9d-b64c-22942e0c340d	9ee22a07-854e-4b97-a636-a8a17d2cc1a4	t	${role_view-groups}	view-groups	cce4122f-9b89-420a-bd97-dc991169c190	9ee22a07-854e-4b97-a636-a8a17d2cc1a4	\N
c06dc361-e1f4-40bc-b937-d80c87338b76	9ee22a07-854e-4b97-a636-a8a17d2cc1a4	t	${role_delete-account}	delete-account	cce4122f-9b89-420a-bd97-dc991169c190	9ee22a07-854e-4b97-a636-a8a17d2cc1a4	\N
e0fe3318-a30c-4ed9-9d50-7f6d5e758a7b	c0b99c11-10d3-430d-962f-94e1b57a6013	t	${role_read-token}	read-token	cce4122f-9b89-420a-bd97-dc991169c190	c0b99c11-10d3-430d-962f-94e1b57a6013	\N
5ba8ccfb-724c-42df-8dc1-858563dcefc5	efd4d5ad-dc20-455a-af96-473ecb04282d	t	${role_impersonation}	impersonation	cce4122f-9b89-420a-bd97-dc991169c190	efd4d5ad-dc20-455a-af96-473ecb04282d	\N
532db205-37f1-4d76-89f2-92f7daf40762	cce4122f-9b89-420a-bd97-dc991169c190	f	${role_offline-access}	offline_access	cce4122f-9b89-420a-bd97-dc991169c190	\N	\N
d879b246-44bc-49a7-8827-27c2390cf39d	cce4122f-9b89-420a-bd97-dc991169c190	f	${role_uma_authorization}	uma_authorization	cce4122f-9b89-420a-bd97-dc991169c190	\N	\N
203ccff1-a8dd-48b0-8e84-419e0293d5b8	38d94c69-6603-4341-a226-f65366146032	f	${role_default-roles}	default-roles-mealwurm	38d94c69-6603-4341-a226-f65366146032	\N	\N
3baed6dc-ec83-4081-993c-4a5c8b1cdb49	7d116705-0e72-4b1a-ad08-e8aeaaab5fbe	t	${role_create-client}	create-client	cce4122f-9b89-420a-bd97-dc991169c190	7d116705-0e72-4b1a-ad08-e8aeaaab5fbe	\N
6a2adb2b-ed59-4da6-b6d2-78650abe938a	7d116705-0e72-4b1a-ad08-e8aeaaab5fbe	t	${role_view-realm}	view-realm	cce4122f-9b89-420a-bd97-dc991169c190	7d116705-0e72-4b1a-ad08-e8aeaaab5fbe	\N
9b237490-233d-4cc9-80bb-55ff211efb72	7d116705-0e72-4b1a-ad08-e8aeaaab5fbe	t	${role_view-users}	view-users	cce4122f-9b89-420a-bd97-dc991169c190	7d116705-0e72-4b1a-ad08-e8aeaaab5fbe	\N
525ce390-966c-4dfc-be10-fb27c773cdfc	7d116705-0e72-4b1a-ad08-e8aeaaab5fbe	t	${role_view-clients}	view-clients	cce4122f-9b89-420a-bd97-dc991169c190	7d116705-0e72-4b1a-ad08-e8aeaaab5fbe	\N
9fe837d2-83a6-4023-9438-5516da9703cb	7d116705-0e72-4b1a-ad08-e8aeaaab5fbe	t	${role_view-events}	view-events	cce4122f-9b89-420a-bd97-dc991169c190	7d116705-0e72-4b1a-ad08-e8aeaaab5fbe	\N
f26f8884-1a54-4025-aad7-cd0981123320	7d116705-0e72-4b1a-ad08-e8aeaaab5fbe	t	${role_view-identity-providers}	view-identity-providers	cce4122f-9b89-420a-bd97-dc991169c190	7d116705-0e72-4b1a-ad08-e8aeaaab5fbe	\N
17590634-91d7-4bcb-9204-89de5503551a	7d116705-0e72-4b1a-ad08-e8aeaaab5fbe	t	${role_view-authorization}	view-authorization	cce4122f-9b89-420a-bd97-dc991169c190	7d116705-0e72-4b1a-ad08-e8aeaaab5fbe	\N
f0164c37-d1b7-4cae-95f6-8ff841a59e5d	7d116705-0e72-4b1a-ad08-e8aeaaab5fbe	t	${role_manage-realm}	manage-realm	cce4122f-9b89-420a-bd97-dc991169c190	7d116705-0e72-4b1a-ad08-e8aeaaab5fbe	\N
d2608ad3-ca5c-4391-9a6c-c8098c1d22b1	7d116705-0e72-4b1a-ad08-e8aeaaab5fbe	t	${role_manage-users}	manage-users	cce4122f-9b89-420a-bd97-dc991169c190	7d116705-0e72-4b1a-ad08-e8aeaaab5fbe	\N
b3e6d9ef-af09-47d7-89b9-0c4e405cdca0	7d116705-0e72-4b1a-ad08-e8aeaaab5fbe	t	${role_manage-clients}	manage-clients	cce4122f-9b89-420a-bd97-dc991169c190	7d116705-0e72-4b1a-ad08-e8aeaaab5fbe	\N
27b19c96-477b-49cb-8cad-50350d596021	7d116705-0e72-4b1a-ad08-e8aeaaab5fbe	t	${role_manage-events}	manage-events	cce4122f-9b89-420a-bd97-dc991169c190	7d116705-0e72-4b1a-ad08-e8aeaaab5fbe	\N
db4e4460-982e-41a3-83b9-aae578e74f63	7d116705-0e72-4b1a-ad08-e8aeaaab5fbe	t	${role_manage-identity-providers}	manage-identity-providers	cce4122f-9b89-420a-bd97-dc991169c190	7d116705-0e72-4b1a-ad08-e8aeaaab5fbe	\N
e602b813-5ee9-4fa6-8135-e8ebccd523d6	7d116705-0e72-4b1a-ad08-e8aeaaab5fbe	t	${role_manage-authorization}	manage-authorization	cce4122f-9b89-420a-bd97-dc991169c190	7d116705-0e72-4b1a-ad08-e8aeaaab5fbe	\N
a36fcb85-95ba-4a25-91dc-622bc4168cf5	7d116705-0e72-4b1a-ad08-e8aeaaab5fbe	t	${role_query-users}	query-users	cce4122f-9b89-420a-bd97-dc991169c190	7d116705-0e72-4b1a-ad08-e8aeaaab5fbe	\N
88534c3f-198f-4ffd-ba8e-4af06bf1b4a0	7d116705-0e72-4b1a-ad08-e8aeaaab5fbe	t	${role_query-clients}	query-clients	cce4122f-9b89-420a-bd97-dc991169c190	7d116705-0e72-4b1a-ad08-e8aeaaab5fbe	\N
05be0021-bb54-488c-8425-3be0be52cbd7	7d116705-0e72-4b1a-ad08-e8aeaaab5fbe	t	${role_query-realms}	query-realms	cce4122f-9b89-420a-bd97-dc991169c190	7d116705-0e72-4b1a-ad08-e8aeaaab5fbe	\N
d3d12f12-4d5e-4176-b1d3-910a437c3eff	7d116705-0e72-4b1a-ad08-e8aeaaab5fbe	t	${role_query-groups}	query-groups	cce4122f-9b89-420a-bd97-dc991169c190	7d116705-0e72-4b1a-ad08-e8aeaaab5fbe	\N
96c5b0b5-0860-4da2-95a0-352684caee45	719d2e4a-9b0e-489a-9c43-830f5859b0e8	t	${role_realm-admin}	realm-admin	38d94c69-6603-4341-a226-f65366146032	719d2e4a-9b0e-489a-9c43-830f5859b0e8	\N
4a724813-0d4d-42e5-84fe-56b082a40f8c	719d2e4a-9b0e-489a-9c43-830f5859b0e8	t	${role_create-client}	create-client	38d94c69-6603-4341-a226-f65366146032	719d2e4a-9b0e-489a-9c43-830f5859b0e8	\N
8a5de00c-33b5-4e1b-a217-bb9d9f04b58b	719d2e4a-9b0e-489a-9c43-830f5859b0e8	t	${role_view-realm}	view-realm	38d94c69-6603-4341-a226-f65366146032	719d2e4a-9b0e-489a-9c43-830f5859b0e8	\N
a3f03e07-a791-46ec-bd5a-92a5b98bcc50	719d2e4a-9b0e-489a-9c43-830f5859b0e8	t	${role_view-users}	view-users	38d94c69-6603-4341-a226-f65366146032	719d2e4a-9b0e-489a-9c43-830f5859b0e8	\N
8cf81b82-571b-4d7e-9411-9bc67b7e0785	719d2e4a-9b0e-489a-9c43-830f5859b0e8	t	${role_view-clients}	view-clients	38d94c69-6603-4341-a226-f65366146032	719d2e4a-9b0e-489a-9c43-830f5859b0e8	\N
b3e60e5a-2159-4832-b0ed-c9d18b38d13c	719d2e4a-9b0e-489a-9c43-830f5859b0e8	t	${role_view-events}	view-events	38d94c69-6603-4341-a226-f65366146032	719d2e4a-9b0e-489a-9c43-830f5859b0e8	\N
29ee398f-971f-453f-b575-420dcbe84ab0	719d2e4a-9b0e-489a-9c43-830f5859b0e8	t	${role_view-identity-providers}	view-identity-providers	38d94c69-6603-4341-a226-f65366146032	719d2e4a-9b0e-489a-9c43-830f5859b0e8	\N
6806382a-5c2d-452c-b595-2ce7c6cde23a	719d2e4a-9b0e-489a-9c43-830f5859b0e8	t	${role_view-authorization}	view-authorization	38d94c69-6603-4341-a226-f65366146032	719d2e4a-9b0e-489a-9c43-830f5859b0e8	\N
287c1f87-b774-4f43-9658-24102adface3	719d2e4a-9b0e-489a-9c43-830f5859b0e8	t	${role_manage-realm}	manage-realm	38d94c69-6603-4341-a226-f65366146032	719d2e4a-9b0e-489a-9c43-830f5859b0e8	\N
e72937eb-1987-42bc-bc98-3b64077f937b	719d2e4a-9b0e-489a-9c43-830f5859b0e8	t	${role_manage-users}	manage-users	38d94c69-6603-4341-a226-f65366146032	719d2e4a-9b0e-489a-9c43-830f5859b0e8	\N
fd26f8d7-f291-4b3f-88c0-cf5617622e45	719d2e4a-9b0e-489a-9c43-830f5859b0e8	t	${role_manage-clients}	manage-clients	38d94c69-6603-4341-a226-f65366146032	719d2e4a-9b0e-489a-9c43-830f5859b0e8	\N
9cba42c4-ffab-483f-ac87-8aa49d1979a7	719d2e4a-9b0e-489a-9c43-830f5859b0e8	t	${role_manage-events}	manage-events	38d94c69-6603-4341-a226-f65366146032	719d2e4a-9b0e-489a-9c43-830f5859b0e8	\N
08182a30-7a0b-4208-ae7e-4bb3aa0d7bb2	719d2e4a-9b0e-489a-9c43-830f5859b0e8	t	${role_manage-identity-providers}	manage-identity-providers	38d94c69-6603-4341-a226-f65366146032	719d2e4a-9b0e-489a-9c43-830f5859b0e8	\N
13822a2d-ab1c-4aa7-9b2b-5a07fb5868b0	719d2e4a-9b0e-489a-9c43-830f5859b0e8	t	${role_manage-authorization}	manage-authorization	38d94c69-6603-4341-a226-f65366146032	719d2e4a-9b0e-489a-9c43-830f5859b0e8	\N
a560950e-30f8-4902-b681-f2e35a7095e4	719d2e4a-9b0e-489a-9c43-830f5859b0e8	t	${role_query-users}	query-users	38d94c69-6603-4341-a226-f65366146032	719d2e4a-9b0e-489a-9c43-830f5859b0e8	\N
d0189878-29a4-4b5e-a14a-ed4b2eae926e	719d2e4a-9b0e-489a-9c43-830f5859b0e8	t	${role_query-clients}	query-clients	38d94c69-6603-4341-a226-f65366146032	719d2e4a-9b0e-489a-9c43-830f5859b0e8	\N
ad00b656-ae5f-45df-ad4c-7453068f29d1	719d2e4a-9b0e-489a-9c43-830f5859b0e8	t	${role_query-realms}	query-realms	38d94c69-6603-4341-a226-f65366146032	719d2e4a-9b0e-489a-9c43-830f5859b0e8	\N
284e74c1-d013-4508-add4-2413f047205d	719d2e4a-9b0e-489a-9c43-830f5859b0e8	t	${role_query-groups}	query-groups	38d94c69-6603-4341-a226-f65366146032	719d2e4a-9b0e-489a-9c43-830f5859b0e8	\N
0c65922d-aee2-4356-98fe-7dc68a471356	43911470-b287-4ab5-b065-3f02b4e850f6	t	${role_view-profile}	view-profile	38d94c69-6603-4341-a226-f65366146032	43911470-b287-4ab5-b065-3f02b4e850f6	\N
df95cde9-97ca-4121-b0be-6e2db4961e8c	43911470-b287-4ab5-b065-3f02b4e850f6	t	${role_manage-account}	manage-account	38d94c69-6603-4341-a226-f65366146032	43911470-b287-4ab5-b065-3f02b4e850f6	\N
61f2a14e-5309-46c0-8dde-531a5c54accb	43911470-b287-4ab5-b065-3f02b4e850f6	t	${role_manage-account-links}	manage-account-links	38d94c69-6603-4341-a226-f65366146032	43911470-b287-4ab5-b065-3f02b4e850f6	\N
a1d107ab-3236-421f-a769-41838661415d	43911470-b287-4ab5-b065-3f02b4e850f6	t	${role_view-applications}	view-applications	38d94c69-6603-4341-a226-f65366146032	43911470-b287-4ab5-b065-3f02b4e850f6	\N
3ccce739-85e6-4266-9c8f-3a57e590e85a	43911470-b287-4ab5-b065-3f02b4e850f6	t	${role_view-consent}	view-consent	38d94c69-6603-4341-a226-f65366146032	43911470-b287-4ab5-b065-3f02b4e850f6	\N
d81a8b2e-2173-4eec-be40-eeeea19483d8	43911470-b287-4ab5-b065-3f02b4e850f6	t	${role_manage-consent}	manage-consent	38d94c69-6603-4341-a226-f65366146032	43911470-b287-4ab5-b065-3f02b4e850f6	\N
ed8e34e0-550c-490e-947e-8dd58f57179e	43911470-b287-4ab5-b065-3f02b4e850f6	t	${role_view-groups}	view-groups	38d94c69-6603-4341-a226-f65366146032	43911470-b287-4ab5-b065-3f02b4e850f6	\N
3a90b4f2-2f32-40be-b2a1-cfbb33a12507	43911470-b287-4ab5-b065-3f02b4e850f6	t	${role_delete-account}	delete-account	38d94c69-6603-4341-a226-f65366146032	43911470-b287-4ab5-b065-3f02b4e850f6	\N
57b7f4b3-6a3e-4bf5-b530-673aa50a2357	7d116705-0e72-4b1a-ad08-e8aeaaab5fbe	t	${role_impersonation}	impersonation	cce4122f-9b89-420a-bd97-dc991169c190	7d116705-0e72-4b1a-ad08-e8aeaaab5fbe	\N
edd15cfe-da78-48df-bd9b-4e2edcd5d05d	719d2e4a-9b0e-489a-9c43-830f5859b0e8	t	${role_impersonation}	impersonation	38d94c69-6603-4341-a226-f65366146032	719d2e4a-9b0e-489a-9c43-830f5859b0e8	\N
c70f99c7-6a06-4b02-8900-52ede73cdfe5	a14ba3ad-455e-42ea-87d1-38ef5c3de155	t	${role_read-token}	read-token	38d94c69-6603-4341-a226-f65366146032	a14ba3ad-455e-42ea-87d1-38ef5c3de155	\N
3d3cc335-d0f1-42e4-8887-4bfce55be516	38d94c69-6603-4341-a226-f65366146032	f	${role_offline-access}	offline_access	38d94c69-6603-4341-a226-f65366146032	\N	\N
c68e95ac-e31a-4b5c-9eda-6991d6a354fd	38d94c69-6603-4341-a226-f65366146032	f	${role_uma_authorization}	uma_authorization	38d94c69-6603-4341-a226-f65366146032	\N	\N
b6fc0cef-f532-4500-b1c6-53d6324b78d8	8f8c0971-90fd-48b1-9b94-73a7deedf5d6	t		user	38d94c69-6603-4341-a226-f65366146032	8f8c0971-90fd-48b1-9b94-73a7deedf5d6	\N
0da09e77-86a7-4390-8323-b001d6bfe73d	8f8c0971-90fd-48b1-9b94-73a7deedf5d6	t		admin	38d94c69-6603-4341-a226-f65366146032	8f8c0971-90fd-48b1-9b94-73a7deedf5d6	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.migration_model (id, version, update_time) FROM stdin;
8ap2p	26.1.2	1755730620
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id, version) FROM stdin;
6dcb044e-eee6-47f3-af0b-f0ce4cde1d97	8f8c0971-90fd-48b1-9b94-73a7deedf5d6	0	1755794969	{"authMethod":"openid-connect","redirectUri":"http://localhost:3000","notes":{"clientId":"8f8c0971-90fd-48b1-9b94-73a7deedf5d6","scope":"openid","userSessionStartedAt":"1755792486","iss":"http://localhost:9000/realms/mealwurm","startedAt":"1755792486","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","redirect_uri":"http://localhost:3000","state":"4e529e8fdc6c4c54bbba253346247e62","code_challenge":"GWqRRp8XB489Jih_uzGsdxMuC0-WAfRdRhuWKE0wLx8"}}	local	local	11
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh, broker_session_id, version) FROM stdin;
6dcb044e-eee6-47f3-af0b-f0ce4cde1d97	1a5073e0-ec8d-4c6c-a747-a118c3417368	38d94c69-6603-4341-a226-f65366146032	1755792486	0	{"ipAddress":"192.168.65.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjY1LjEiLCJvcyI6Ik1hYyBPUyBYIiwib3NWZXJzaW9uIjoiMTAuMTUuNyIsImJyb3dzZXIiOiJDaHJvbWUvMTM5LjAuMCIsImRldmljZSI6Ik1hYyIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1755792486","authenticators-completed":"{\\"38c835c9-8323-4bb4-b38b-42fa42029de7\\":1755792486}"},"state":"LOGGED_IN"}	1755794969	\N	11
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
770c832c-39fe-42a4-89df-c5c5c32a6f9f	audience resolve	openid-connect	oidc-audience-resolve-mapper	76faf3ac-102c-40bf-970f-eb1f78aa06ad	\N
01c68d61-3705-4213-8790-99d95a541115	locale	openid-connect	oidc-usermodel-attribute-mapper	245c8a5c-3bf4-4ff8-a90d-da60f1b7ef1c	\N
55a50b98-a36e-4f18-a039-765c9987bd58	role list	saml	saml-role-list-mapper	\N	4f20806e-7577-4b53-ad34-754a77ebfa5d
62629080-4de6-4a77-96c1-4a5a0f08972f	organization	saml	saml-organization-membership-mapper	\N	527a0e4f-4ab4-42ed-be81-c3166f4cbf1e
5ae912e9-9735-4fff-ae08-0278b5628e54	full name	openid-connect	oidc-full-name-mapper	\N	c5e68625-65ff-4723-8b83-dbc965ced676
5887e371-334f-48ab-a860-4ed0f7fee1e9	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	c5e68625-65ff-4723-8b83-dbc965ced676
0b3c28c9-50d6-4b6a-8056-e88fd3ae6e5c	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	c5e68625-65ff-4723-8b83-dbc965ced676
b6fedb45-ab29-41fd-863a-69241aa0f771	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	c5e68625-65ff-4723-8b83-dbc965ced676
c683dc16-9f32-4afe-b488-f3c1bcef57c4	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	c5e68625-65ff-4723-8b83-dbc965ced676
6fc01282-c0ff-4095-8e3a-9a22dab566c8	username	openid-connect	oidc-usermodel-attribute-mapper	\N	c5e68625-65ff-4723-8b83-dbc965ced676
01df49ef-287b-4f6e-b2d0-e4bcfe9eb6dc	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	c5e68625-65ff-4723-8b83-dbc965ced676
75cec992-38f8-40d3-818e-b50a906e4d91	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	c5e68625-65ff-4723-8b83-dbc965ced676
7a741d92-8c01-4db5-9864-7da1fee9d138	website	openid-connect	oidc-usermodel-attribute-mapper	\N	c5e68625-65ff-4723-8b83-dbc965ced676
dc461814-625c-4345-aaa9-7a2d36bf5e5c	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	c5e68625-65ff-4723-8b83-dbc965ced676
41e0532f-d045-4c47-90af-da146c200573	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	c5e68625-65ff-4723-8b83-dbc965ced676
f2262013-7623-4aa2-848c-e6cfb374d94d	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	c5e68625-65ff-4723-8b83-dbc965ced676
0237fc25-86c1-46fb-9ace-771ca80aab38	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	c5e68625-65ff-4723-8b83-dbc965ced676
ddd080e8-9470-47f8-83ed-c5bb36161e7c	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	c5e68625-65ff-4723-8b83-dbc965ced676
ae773188-8b2d-4a1a-b372-0d8b4875f9ec	email	openid-connect	oidc-usermodel-attribute-mapper	\N	9eccf774-4cd5-4f2a-829b-14adbff99cea
7289d033-04d9-45a6-a9ef-629e1805c946	email verified	openid-connect	oidc-usermodel-property-mapper	\N	9eccf774-4cd5-4f2a-829b-14adbff99cea
4fb2ae65-88eb-4984-adad-874da0b405c2	address	openid-connect	oidc-address-mapper	\N	0273bfe9-94bf-4789-9d32-6d496057f2ef
52bd2238-809b-4eaa-a0d4-09718e394cac	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	585a4801-6e6d-4417-98b8-2d3984080635
54704c8a-0aaf-47ab-873c-69755de6c3b9	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	585a4801-6e6d-4417-98b8-2d3984080635
9b8d41f5-778a-4033-9b33-a027e159afe9	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	4e85f1fa-ac35-4a19-8500-f211780b130d
eb3df39f-75e8-49fd-add6-f8a144fe6f90	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	4e85f1fa-ac35-4a19-8500-f211780b130d
adeb0613-3775-4e99-9305-648d3850ea0f	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	4e85f1fa-ac35-4a19-8500-f211780b130d
5b55b390-cd87-40b6-9c12-7674ac2dd333	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	e395ccda-2bf8-4a1a-a79f-14e62a00e954
e9c6730d-ee63-44af-b2f0-40c38a785041	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	7ee2413b-851b-4155-9e9a-7a30f4c6d406
c74fca0e-d9ac-461d-b9b4-f3d3ccfde58e	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	7ee2413b-851b-4155-9e9a-7a30f4c6d406
be55b758-dff5-46b7-8863-5f0b47745cac	acr loa level	openid-connect	oidc-acr-mapper	\N	f7fd1bf7-d593-4e9e-b459-332b8318415d
68613301-c2fa-4d0c-be3d-8952f9499034	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	240f22bf-89e6-4ee2-ae61-1a7c25dd3434
ab86d51e-2713-4c4a-81d8-5f5dcf2466df	sub	openid-connect	oidc-sub-mapper	\N	240f22bf-89e6-4ee2-ae61-1a7c25dd3434
4d959ab8-2335-4779-8312-34472493c342	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	\N	148b6457-6267-452a-a530-6963fbd6539e
2c17b6a3-a293-454d-a9b2-7667b7657d1a	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	\N	148b6457-6267-452a-a530-6963fbd6539e
5f87fa0e-4bc4-474e-9a66-d7f9f01d288a	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	\N	148b6457-6267-452a-a530-6963fbd6539e
2bcab627-28e7-425c-b473-248056f8adf7	organization	openid-connect	oidc-organization-membership-mapper	\N	0666a187-c81e-4513-a921-8615212ad07d
a620b8bb-702e-41f3-bf73-444238d8f8e8	audience resolve	openid-connect	oidc-audience-resolve-mapper	329515af-4e73-4143-8938-3567714ec63b	\N
8984061b-e387-472c-8c8f-2993c7bd614f	role list	saml	saml-role-list-mapper	\N	108c6856-ea9c-46b4-9d2c-20533ecf376c
6da8bd8e-602e-4d3f-a447-822fed5ac3af	organization	saml	saml-organization-membership-mapper	\N	dd8875a0-d565-4487-9eca-718f74785bd6
01e33086-2db8-4b39-8cfc-4182543a9593	full name	openid-connect	oidc-full-name-mapper	\N	a33162e5-f6df-4608-9796-b95e156a1d8f
56bdc1eb-666d-47b5-9f08-febff2c05001	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	a33162e5-f6df-4608-9796-b95e156a1d8f
62144f27-b35a-43d8-a14c-0146a1ec83ab	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	a33162e5-f6df-4608-9796-b95e156a1d8f
014b2b4a-95d2-48d7-948b-74f58823dcde	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	a33162e5-f6df-4608-9796-b95e156a1d8f
094b3754-cb92-4a05-b0e6-77139a7d0bed	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	a33162e5-f6df-4608-9796-b95e156a1d8f
b8b5fdef-15ff-417c-a907-401a0421c0e5	username	openid-connect	oidc-usermodel-attribute-mapper	\N	a33162e5-f6df-4608-9796-b95e156a1d8f
3f0b1f8d-81ca-4602-8daf-d2d9ab820067	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	a33162e5-f6df-4608-9796-b95e156a1d8f
b8fb26a3-1af8-42b0-916d-1fa6fe2acfb2	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	a33162e5-f6df-4608-9796-b95e156a1d8f
d3d0a300-4f33-4f88-b4cd-3d56514aea4f	website	openid-connect	oidc-usermodel-attribute-mapper	\N	a33162e5-f6df-4608-9796-b95e156a1d8f
b027200e-4801-4866-b156-127b64e831df	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	a33162e5-f6df-4608-9796-b95e156a1d8f
0110c6a6-450d-4325-82e7-bce18efae32c	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	a33162e5-f6df-4608-9796-b95e156a1d8f
ea5d071c-b9f8-4511-96a7-3ada03beab60	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	a33162e5-f6df-4608-9796-b95e156a1d8f
3a70ae55-0b20-4746-880e-4a643f840263	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	a33162e5-f6df-4608-9796-b95e156a1d8f
bd0c98d2-cbdf-4b57-9f7e-b1039c5464ff	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	a33162e5-f6df-4608-9796-b95e156a1d8f
62866d27-9818-4b3d-b28c-1275d5f8be4f	email	openid-connect	oidc-usermodel-attribute-mapper	\N	9fae9540-7efc-42f9-962f-01723becf220
2d55bf29-e186-4b6a-b882-b077319d6ae8	email verified	openid-connect	oidc-usermodel-property-mapper	\N	9fae9540-7efc-42f9-962f-01723becf220
13302c92-8233-4df5-807a-1b7ec0e8b91e	address	openid-connect	oidc-address-mapper	\N	22163393-0526-4ebd-baea-94515880fdf4
1d21ab56-33c4-4f48-81ff-316dae88ea30	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	3f33c4cf-c478-4e24-9955-744f16b3370a
a6dc1d31-7d84-4f1b-973b-ef32b39f5e26	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	3f33c4cf-c478-4e24-9955-744f16b3370a
3dafea38-735d-42c4-96c7-493182d03949	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	d5f0eb87-574a-4a35-81b7-91c278c476a2
9ec1b1f9-a4c2-48d8-9eb4-42be5865418a	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	d5f0eb87-574a-4a35-81b7-91c278c476a2
0a4979a1-e8e5-4cb2-b0a5-5235a781493f	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	d5f0eb87-574a-4a35-81b7-91c278c476a2
a18e92f9-1c8d-4b17-87d4-f12e59675ad8	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	4345e7ac-1678-4eb2-909d-4e0cf6858ce9
f33ee5e3-0269-4944-a7da-00329041ddce	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	44c04c4d-ddf3-4729-a5ab-f96f551f55d8
ca8e7056-0b3e-4c3e-89f8-aecc341929c9	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	44c04c4d-ddf3-4729-a5ab-f96f551f55d8
0b74a2f5-867f-422d-864b-ba054259038f	acr loa level	openid-connect	oidc-acr-mapper	\N	b55b05c7-ecef-4449-b947-e0f4c1592755
eaec8666-148b-4c78-8eb8-d7e7d046ddf7	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	1208d451-edf5-46a3-b16f-afa1d0061a44
c701f0e7-ae71-4361-83e9-c176385104d2	sub	openid-connect	oidc-sub-mapper	\N	1208d451-edf5-46a3-b16f-afa1d0061a44
2dfd1ac6-290a-44cf-af63-efa527875d96	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	\N	213dd6bd-9da3-4233-9c71-2631e8fde48b
db557651-f184-460f-a56b-f9540b9adab3	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	\N	213dd6bd-9da3-4233-9c71-2631e8fde48b
0ce2c4a0-07ac-4f84-9097-c40295260c88	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	\N	213dd6bd-9da3-4233-9c71-2631e8fde48b
88480917-579d-4a3f-9671-aa1afa7a77c1	organization	openid-connect	oidc-organization-membership-mapper	\N	27bb686a-c1a9-43dd-bc00-118bf917b1e3
aae703eb-e82a-4bb1-9966-111fca67ced3	locale	openid-connect	oidc-usermodel-attribute-mapper	1e407bad-abc2-4602-b914-06c58e9fcacc	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
01c68d61-3705-4213-8790-99d95a541115	true	introspection.token.claim
01c68d61-3705-4213-8790-99d95a541115	true	userinfo.token.claim
01c68d61-3705-4213-8790-99d95a541115	locale	user.attribute
01c68d61-3705-4213-8790-99d95a541115	true	id.token.claim
01c68d61-3705-4213-8790-99d95a541115	true	access.token.claim
01c68d61-3705-4213-8790-99d95a541115	locale	claim.name
01c68d61-3705-4213-8790-99d95a541115	String	jsonType.label
55a50b98-a36e-4f18-a039-765c9987bd58	false	single
55a50b98-a36e-4f18-a039-765c9987bd58	Basic	attribute.nameformat
55a50b98-a36e-4f18-a039-765c9987bd58	Role	attribute.name
01df49ef-287b-4f6e-b2d0-e4bcfe9eb6dc	true	introspection.token.claim
01df49ef-287b-4f6e-b2d0-e4bcfe9eb6dc	true	userinfo.token.claim
01df49ef-287b-4f6e-b2d0-e4bcfe9eb6dc	profile	user.attribute
01df49ef-287b-4f6e-b2d0-e4bcfe9eb6dc	true	id.token.claim
01df49ef-287b-4f6e-b2d0-e4bcfe9eb6dc	true	access.token.claim
01df49ef-287b-4f6e-b2d0-e4bcfe9eb6dc	profile	claim.name
01df49ef-287b-4f6e-b2d0-e4bcfe9eb6dc	String	jsonType.label
0237fc25-86c1-46fb-9ace-771ca80aab38	true	introspection.token.claim
0237fc25-86c1-46fb-9ace-771ca80aab38	true	userinfo.token.claim
0237fc25-86c1-46fb-9ace-771ca80aab38	locale	user.attribute
0237fc25-86c1-46fb-9ace-771ca80aab38	true	id.token.claim
0237fc25-86c1-46fb-9ace-771ca80aab38	true	access.token.claim
0237fc25-86c1-46fb-9ace-771ca80aab38	locale	claim.name
0237fc25-86c1-46fb-9ace-771ca80aab38	String	jsonType.label
0b3c28c9-50d6-4b6a-8056-e88fd3ae6e5c	true	introspection.token.claim
0b3c28c9-50d6-4b6a-8056-e88fd3ae6e5c	true	userinfo.token.claim
0b3c28c9-50d6-4b6a-8056-e88fd3ae6e5c	firstName	user.attribute
0b3c28c9-50d6-4b6a-8056-e88fd3ae6e5c	true	id.token.claim
0b3c28c9-50d6-4b6a-8056-e88fd3ae6e5c	true	access.token.claim
0b3c28c9-50d6-4b6a-8056-e88fd3ae6e5c	given_name	claim.name
0b3c28c9-50d6-4b6a-8056-e88fd3ae6e5c	String	jsonType.label
41e0532f-d045-4c47-90af-da146c200573	true	introspection.token.claim
41e0532f-d045-4c47-90af-da146c200573	true	userinfo.token.claim
41e0532f-d045-4c47-90af-da146c200573	birthdate	user.attribute
41e0532f-d045-4c47-90af-da146c200573	true	id.token.claim
41e0532f-d045-4c47-90af-da146c200573	true	access.token.claim
41e0532f-d045-4c47-90af-da146c200573	birthdate	claim.name
41e0532f-d045-4c47-90af-da146c200573	String	jsonType.label
5887e371-334f-48ab-a860-4ed0f7fee1e9	true	introspection.token.claim
5887e371-334f-48ab-a860-4ed0f7fee1e9	true	userinfo.token.claim
5887e371-334f-48ab-a860-4ed0f7fee1e9	lastName	user.attribute
5887e371-334f-48ab-a860-4ed0f7fee1e9	true	id.token.claim
5887e371-334f-48ab-a860-4ed0f7fee1e9	true	access.token.claim
5887e371-334f-48ab-a860-4ed0f7fee1e9	family_name	claim.name
5887e371-334f-48ab-a860-4ed0f7fee1e9	String	jsonType.label
5ae912e9-9735-4fff-ae08-0278b5628e54	true	introspection.token.claim
5ae912e9-9735-4fff-ae08-0278b5628e54	true	userinfo.token.claim
5ae912e9-9735-4fff-ae08-0278b5628e54	true	id.token.claim
5ae912e9-9735-4fff-ae08-0278b5628e54	true	access.token.claim
6fc01282-c0ff-4095-8e3a-9a22dab566c8	true	introspection.token.claim
6fc01282-c0ff-4095-8e3a-9a22dab566c8	true	userinfo.token.claim
6fc01282-c0ff-4095-8e3a-9a22dab566c8	username	user.attribute
6fc01282-c0ff-4095-8e3a-9a22dab566c8	true	id.token.claim
6fc01282-c0ff-4095-8e3a-9a22dab566c8	true	access.token.claim
6fc01282-c0ff-4095-8e3a-9a22dab566c8	preferred_username	claim.name
6fc01282-c0ff-4095-8e3a-9a22dab566c8	String	jsonType.label
75cec992-38f8-40d3-818e-b50a906e4d91	true	introspection.token.claim
75cec992-38f8-40d3-818e-b50a906e4d91	true	userinfo.token.claim
75cec992-38f8-40d3-818e-b50a906e4d91	picture	user.attribute
75cec992-38f8-40d3-818e-b50a906e4d91	true	id.token.claim
75cec992-38f8-40d3-818e-b50a906e4d91	true	access.token.claim
75cec992-38f8-40d3-818e-b50a906e4d91	picture	claim.name
75cec992-38f8-40d3-818e-b50a906e4d91	String	jsonType.label
7a741d92-8c01-4db5-9864-7da1fee9d138	true	introspection.token.claim
7a741d92-8c01-4db5-9864-7da1fee9d138	true	userinfo.token.claim
7a741d92-8c01-4db5-9864-7da1fee9d138	website	user.attribute
7a741d92-8c01-4db5-9864-7da1fee9d138	true	id.token.claim
7a741d92-8c01-4db5-9864-7da1fee9d138	true	access.token.claim
7a741d92-8c01-4db5-9864-7da1fee9d138	website	claim.name
7a741d92-8c01-4db5-9864-7da1fee9d138	String	jsonType.label
b6fedb45-ab29-41fd-863a-69241aa0f771	true	introspection.token.claim
b6fedb45-ab29-41fd-863a-69241aa0f771	true	userinfo.token.claim
b6fedb45-ab29-41fd-863a-69241aa0f771	middleName	user.attribute
b6fedb45-ab29-41fd-863a-69241aa0f771	true	id.token.claim
b6fedb45-ab29-41fd-863a-69241aa0f771	true	access.token.claim
b6fedb45-ab29-41fd-863a-69241aa0f771	middle_name	claim.name
b6fedb45-ab29-41fd-863a-69241aa0f771	String	jsonType.label
c683dc16-9f32-4afe-b488-f3c1bcef57c4	true	introspection.token.claim
c683dc16-9f32-4afe-b488-f3c1bcef57c4	true	userinfo.token.claim
c683dc16-9f32-4afe-b488-f3c1bcef57c4	nickname	user.attribute
c683dc16-9f32-4afe-b488-f3c1bcef57c4	true	id.token.claim
c683dc16-9f32-4afe-b488-f3c1bcef57c4	true	access.token.claim
c683dc16-9f32-4afe-b488-f3c1bcef57c4	nickname	claim.name
c683dc16-9f32-4afe-b488-f3c1bcef57c4	String	jsonType.label
dc461814-625c-4345-aaa9-7a2d36bf5e5c	true	introspection.token.claim
dc461814-625c-4345-aaa9-7a2d36bf5e5c	true	userinfo.token.claim
dc461814-625c-4345-aaa9-7a2d36bf5e5c	gender	user.attribute
dc461814-625c-4345-aaa9-7a2d36bf5e5c	true	id.token.claim
dc461814-625c-4345-aaa9-7a2d36bf5e5c	true	access.token.claim
dc461814-625c-4345-aaa9-7a2d36bf5e5c	gender	claim.name
dc461814-625c-4345-aaa9-7a2d36bf5e5c	String	jsonType.label
ddd080e8-9470-47f8-83ed-c5bb36161e7c	true	introspection.token.claim
ddd080e8-9470-47f8-83ed-c5bb36161e7c	true	userinfo.token.claim
ddd080e8-9470-47f8-83ed-c5bb36161e7c	updatedAt	user.attribute
ddd080e8-9470-47f8-83ed-c5bb36161e7c	true	id.token.claim
ddd080e8-9470-47f8-83ed-c5bb36161e7c	true	access.token.claim
ddd080e8-9470-47f8-83ed-c5bb36161e7c	updated_at	claim.name
ddd080e8-9470-47f8-83ed-c5bb36161e7c	long	jsonType.label
f2262013-7623-4aa2-848c-e6cfb374d94d	true	introspection.token.claim
f2262013-7623-4aa2-848c-e6cfb374d94d	true	userinfo.token.claim
f2262013-7623-4aa2-848c-e6cfb374d94d	zoneinfo	user.attribute
f2262013-7623-4aa2-848c-e6cfb374d94d	true	id.token.claim
f2262013-7623-4aa2-848c-e6cfb374d94d	true	access.token.claim
f2262013-7623-4aa2-848c-e6cfb374d94d	zoneinfo	claim.name
f2262013-7623-4aa2-848c-e6cfb374d94d	String	jsonType.label
7289d033-04d9-45a6-a9ef-629e1805c946	true	introspection.token.claim
7289d033-04d9-45a6-a9ef-629e1805c946	true	userinfo.token.claim
7289d033-04d9-45a6-a9ef-629e1805c946	emailVerified	user.attribute
7289d033-04d9-45a6-a9ef-629e1805c946	true	id.token.claim
7289d033-04d9-45a6-a9ef-629e1805c946	true	access.token.claim
7289d033-04d9-45a6-a9ef-629e1805c946	email_verified	claim.name
7289d033-04d9-45a6-a9ef-629e1805c946	boolean	jsonType.label
ae773188-8b2d-4a1a-b372-0d8b4875f9ec	true	introspection.token.claim
ae773188-8b2d-4a1a-b372-0d8b4875f9ec	true	userinfo.token.claim
ae773188-8b2d-4a1a-b372-0d8b4875f9ec	email	user.attribute
ae773188-8b2d-4a1a-b372-0d8b4875f9ec	true	id.token.claim
ae773188-8b2d-4a1a-b372-0d8b4875f9ec	true	access.token.claim
ae773188-8b2d-4a1a-b372-0d8b4875f9ec	email	claim.name
ae773188-8b2d-4a1a-b372-0d8b4875f9ec	String	jsonType.label
4fb2ae65-88eb-4984-adad-874da0b405c2	formatted	user.attribute.formatted
4fb2ae65-88eb-4984-adad-874da0b405c2	country	user.attribute.country
4fb2ae65-88eb-4984-adad-874da0b405c2	true	introspection.token.claim
4fb2ae65-88eb-4984-adad-874da0b405c2	postal_code	user.attribute.postal_code
4fb2ae65-88eb-4984-adad-874da0b405c2	true	userinfo.token.claim
4fb2ae65-88eb-4984-adad-874da0b405c2	street	user.attribute.street
4fb2ae65-88eb-4984-adad-874da0b405c2	true	id.token.claim
4fb2ae65-88eb-4984-adad-874da0b405c2	region	user.attribute.region
4fb2ae65-88eb-4984-adad-874da0b405c2	true	access.token.claim
4fb2ae65-88eb-4984-adad-874da0b405c2	locality	user.attribute.locality
52bd2238-809b-4eaa-a0d4-09718e394cac	true	introspection.token.claim
52bd2238-809b-4eaa-a0d4-09718e394cac	true	userinfo.token.claim
52bd2238-809b-4eaa-a0d4-09718e394cac	phoneNumber	user.attribute
52bd2238-809b-4eaa-a0d4-09718e394cac	true	id.token.claim
52bd2238-809b-4eaa-a0d4-09718e394cac	true	access.token.claim
52bd2238-809b-4eaa-a0d4-09718e394cac	phone_number	claim.name
52bd2238-809b-4eaa-a0d4-09718e394cac	String	jsonType.label
54704c8a-0aaf-47ab-873c-69755de6c3b9	true	introspection.token.claim
54704c8a-0aaf-47ab-873c-69755de6c3b9	true	userinfo.token.claim
54704c8a-0aaf-47ab-873c-69755de6c3b9	phoneNumberVerified	user.attribute
54704c8a-0aaf-47ab-873c-69755de6c3b9	true	id.token.claim
54704c8a-0aaf-47ab-873c-69755de6c3b9	true	access.token.claim
54704c8a-0aaf-47ab-873c-69755de6c3b9	phone_number_verified	claim.name
54704c8a-0aaf-47ab-873c-69755de6c3b9	boolean	jsonType.label
9b8d41f5-778a-4033-9b33-a027e159afe9	true	introspection.token.claim
9b8d41f5-778a-4033-9b33-a027e159afe9	true	multivalued
9b8d41f5-778a-4033-9b33-a027e159afe9	foo	user.attribute
9b8d41f5-778a-4033-9b33-a027e159afe9	true	access.token.claim
9b8d41f5-778a-4033-9b33-a027e159afe9	realm_access.roles	claim.name
9b8d41f5-778a-4033-9b33-a027e159afe9	String	jsonType.label
adeb0613-3775-4e99-9305-648d3850ea0f	true	introspection.token.claim
adeb0613-3775-4e99-9305-648d3850ea0f	true	access.token.claim
eb3df39f-75e8-49fd-add6-f8a144fe6f90	true	introspection.token.claim
eb3df39f-75e8-49fd-add6-f8a144fe6f90	true	multivalued
eb3df39f-75e8-49fd-add6-f8a144fe6f90	foo	user.attribute
eb3df39f-75e8-49fd-add6-f8a144fe6f90	true	access.token.claim
eb3df39f-75e8-49fd-add6-f8a144fe6f90	resource_access.${client_id}.roles	claim.name
eb3df39f-75e8-49fd-add6-f8a144fe6f90	String	jsonType.label
5b55b390-cd87-40b6-9c12-7674ac2dd333	true	introspection.token.claim
5b55b390-cd87-40b6-9c12-7674ac2dd333	true	access.token.claim
c74fca0e-d9ac-461d-b9b4-f3d3ccfde58e	true	introspection.token.claim
c74fca0e-d9ac-461d-b9b4-f3d3ccfde58e	true	multivalued
c74fca0e-d9ac-461d-b9b4-f3d3ccfde58e	foo	user.attribute
c74fca0e-d9ac-461d-b9b4-f3d3ccfde58e	true	id.token.claim
c74fca0e-d9ac-461d-b9b4-f3d3ccfde58e	true	access.token.claim
c74fca0e-d9ac-461d-b9b4-f3d3ccfde58e	groups	claim.name
c74fca0e-d9ac-461d-b9b4-f3d3ccfde58e	String	jsonType.label
e9c6730d-ee63-44af-b2f0-40c38a785041	true	introspection.token.claim
e9c6730d-ee63-44af-b2f0-40c38a785041	true	userinfo.token.claim
e9c6730d-ee63-44af-b2f0-40c38a785041	username	user.attribute
e9c6730d-ee63-44af-b2f0-40c38a785041	true	id.token.claim
e9c6730d-ee63-44af-b2f0-40c38a785041	true	access.token.claim
e9c6730d-ee63-44af-b2f0-40c38a785041	upn	claim.name
e9c6730d-ee63-44af-b2f0-40c38a785041	String	jsonType.label
be55b758-dff5-46b7-8863-5f0b47745cac	true	introspection.token.claim
be55b758-dff5-46b7-8863-5f0b47745cac	true	id.token.claim
be55b758-dff5-46b7-8863-5f0b47745cac	true	access.token.claim
68613301-c2fa-4d0c-be3d-8952f9499034	AUTH_TIME	user.session.note
68613301-c2fa-4d0c-be3d-8952f9499034	true	introspection.token.claim
68613301-c2fa-4d0c-be3d-8952f9499034	true	id.token.claim
68613301-c2fa-4d0c-be3d-8952f9499034	true	access.token.claim
68613301-c2fa-4d0c-be3d-8952f9499034	auth_time	claim.name
68613301-c2fa-4d0c-be3d-8952f9499034	long	jsonType.label
ab86d51e-2713-4c4a-81d8-5f5dcf2466df	true	introspection.token.claim
ab86d51e-2713-4c4a-81d8-5f5dcf2466df	true	access.token.claim
2c17b6a3-a293-454d-a9b2-7667b7657d1a	clientHost	user.session.note
2c17b6a3-a293-454d-a9b2-7667b7657d1a	true	introspection.token.claim
2c17b6a3-a293-454d-a9b2-7667b7657d1a	true	id.token.claim
2c17b6a3-a293-454d-a9b2-7667b7657d1a	true	access.token.claim
2c17b6a3-a293-454d-a9b2-7667b7657d1a	clientHost	claim.name
2c17b6a3-a293-454d-a9b2-7667b7657d1a	String	jsonType.label
4d959ab8-2335-4779-8312-34472493c342	client_id	user.session.note
4d959ab8-2335-4779-8312-34472493c342	true	introspection.token.claim
4d959ab8-2335-4779-8312-34472493c342	true	id.token.claim
4d959ab8-2335-4779-8312-34472493c342	true	access.token.claim
4d959ab8-2335-4779-8312-34472493c342	client_id	claim.name
4d959ab8-2335-4779-8312-34472493c342	String	jsonType.label
5f87fa0e-4bc4-474e-9a66-d7f9f01d288a	clientAddress	user.session.note
5f87fa0e-4bc4-474e-9a66-d7f9f01d288a	true	introspection.token.claim
5f87fa0e-4bc4-474e-9a66-d7f9f01d288a	true	id.token.claim
5f87fa0e-4bc4-474e-9a66-d7f9f01d288a	true	access.token.claim
5f87fa0e-4bc4-474e-9a66-d7f9f01d288a	clientAddress	claim.name
5f87fa0e-4bc4-474e-9a66-d7f9f01d288a	String	jsonType.label
2bcab627-28e7-425c-b473-248056f8adf7	true	introspection.token.claim
2bcab627-28e7-425c-b473-248056f8adf7	true	multivalued
2bcab627-28e7-425c-b473-248056f8adf7	true	id.token.claim
2bcab627-28e7-425c-b473-248056f8adf7	true	access.token.claim
2bcab627-28e7-425c-b473-248056f8adf7	organization	claim.name
2bcab627-28e7-425c-b473-248056f8adf7	String	jsonType.label
8984061b-e387-472c-8c8f-2993c7bd614f	false	single
8984061b-e387-472c-8c8f-2993c7bd614f	Basic	attribute.nameformat
8984061b-e387-472c-8c8f-2993c7bd614f	Role	attribute.name
0110c6a6-450d-4325-82e7-bce18efae32c	true	introspection.token.claim
0110c6a6-450d-4325-82e7-bce18efae32c	true	userinfo.token.claim
0110c6a6-450d-4325-82e7-bce18efae32c	birthdate	user.attribute
0110c6a6-450d-4325-82e7-bce18efae32c	true	id.token.claim
0110c6a6-450d-4325-82e7-bce18efae32c	true	access.token.claim
0110c6a6-450d-4325-82e7-bce18efae32c	birthdate	claim.name
0110c6a6-450d-4325-82e7-bce18efae32c	String	jsonType.label
014b2b4a-95d2-48d7-948b-74f58823dcde	true	introspection.token.claim
014b2b4a-95d2-48d7-948b-74f58823dcde	true	userinfo.token.claim
014b2b4a-95d2-48d7-948b-74f58823dcde	middleName	user.attribute
014b2b4a-95d2-48d7-948b-74f58823dcde	true	id.token.claim
014b2b4a-95d2-48d7-948b-74f58823dcde	true	access.token.claim
014b2b4a-95d2-48d7-948b-74f58823dcde	middle_name	claim.name
014b2b4a-95d2-48d7-948b-74f58823dcde	String	jsonType.label
01e33086-2db8-4b39-8cfc-4182543a9593	true	introspection.token.claim
01e33086-2db8-4b39-8cfc-4182543a9593	true	userinfo.token.claim
01e33086-2db8-4b39-8cfc-4182543a9593	true	id.token.claim
01e33086-2db8-4b39-8cfc-4182543a9593	true	access.token.claim
094b3754-cb92-4a05-b0e6-77139a7d0bed	true	introspection.token.claim
094b3754-cb92-4a05-b0e6-77139a7d0bed	true	userinfo.token.claim
094b3754-cb92-4a05-b0e6-77139a7d0bed	nickname	user.attribute
094b3754-cb92-4a05-b0e6-77139a7d0bed	true	id.token.claim
094b3754-cb92-4a05-b0e6-77139a7d0bed	true	access.token.claim
094b3754-cb92-4a05-b0e6-77139a7d0bed	nickname	claim.name
094b3754-cb92-4a05-b0e6-77139a7d0bed	String	jsonType.label
3a70ae55-0b20-4746-880e-4a643f840263	true	introspection.token.claim
3a70ae55-0b20-4746-880e-4a643f840263	true	userinfo.token.claim
3a70ae55-0b20-4746-880e-4a643f840263	locale	user.attribute
3a70ae55-0b20-4746-880e-4a643f840263	true	id.token.claim
3a70ae55-0b20-4746-880e-4a643f840263	true	access.token.claim
3a70ae55-0b20-4746-880e-4a643f840263	locale	claim.name
3a70ae55-0b20-4746-880e-4a643f840263	String	jsonType.label
3f0b1f8d-81ca-4602-8daf-d2d9ab820067	true	introspection.token.claim
3f0b1f8d-81ca-4602-8daf-d2d9ab820067	true	userinfo.token.claim
3f0b1f8d-81ca-4602-8daf-d2d9ab820067	profile	user.attribute
3f0b1f8d-81ca-4602-8daf-d2d9ab820067	true	id.token.claim
3f0b1f8d-81ca-4602-8daf-d2d9ab820067	true	access.token.claim
3f0b1f8d-81ca-4602-8daf-d2d9ab820067	profile	claim.name
3f0b1f8d-81ca-4602-8daf-d2d9ab820067	String	jsonType.label
56bdc1eb-666d-47b5-9f08-febff2c05001	true	introspection.token.claim
56bdc1eb-666d-47b5-9f08-febff2c05001	true	userinfo.token.claim
56bdc1eb-666d-47b5-9f08-febff2c05001	lastName	user.attribute
56bdc1eb-666d-47b5-9f08-febff2c05001	true	id.token.claim
56bdc1eb-666d-47b5-9f08-febff2c05001	true	access.token.claim
56bdc1eb-666d-47b5-9f08-febff2c05001	family_name	claim.name
56bdc1eb-666d-47b5-9f08-febff2c05001	String	jsonType.label
62144f27-b35a-43d8-a14c-0146a1ec83ab	true	introspection.token.claim
62144f27-b35a-43d8-a14c-0146a1ec83ab	true	userinfo.token.claim
62144f27-b35a-43d8-a14c-0146a1ec83ab	firstName	user.attribute
62144f27-b35a-43d8-a14c-0146a1ec83ab	true	id.token.claim
62144f27-b35a-43d8-a14c-0146a1ec83ab	true	access.token.claim
62144f27-b35a-43d8-a14c-0146a1ec83ab	given_name	claim.name
62144f27-b35a-43d8-a14c-0146a1ec83ab	String	jsonType.label
b027200e-4801-4866-b156-127b64e831df	true	introspection.token.claim
b027200e-4801-4866-b156-127b64e831df	true	userinfo.token.claim
b027200e-4801-4866-b156-127b64e831df	gender	user.attribute
b027200e-4801-4866-b156-127b64e831df	true	id.token.claim
b027200e-4801-4866-b156-127b64e831df	true	access.token.claim
b027200e-4801-4866-b156-127b64e831df	gender	claim.name
b027200e-4801-4866-b156-127b64e831df	String	jsonType.label
b8b5fdef-15ff-417c-a907-401a0421c0e5	true	introspection.token.claim
b8b5fdef-15ff-417c-a907-401a0421c0e5	true	userinfo.token.claim
b8b5fdef-15ff-417c-a907-401a0421c0e5	username	user.attribute
b8b5fdef-15ff-417c-a907-401a0421c0e5	true	id.token.claim
b8b5fdef-15ff-417c-a907-401a0421c0e5	true	access.token.claim
b8b5fdef-15ff-417c-a907-401a0421c0e5	preferred_username	claim.name
b8b5fdef-15ff-417c-a907-401a0421c0e5	String	jsonType.label
b8fb26a3-1af8-42b0-916d-1fa6fe2acfb2	true	introspection.token.claim
b8fb26a3-1af8-42b0-916d-1fa6fe2acfb2	true	userinfo.token.claim
b8fb26a3-1af8-42b0-916d-1fa6fe2acfb2	picture	user.attribute
b8fb26a3-1af8-42b0-916d-1fa6fe2acfb2	true	id.token.claim
b8fb26a3-1af8-42b0-916d-1fa6fe2acfb2	true	access.token.claim
b8fb26a3-1af8-42b0-916d-1fa6fe2acfb2	picture	claim.name
b8fb26a3-1af8-42b0-916d-1fa6fe2acfb2	String	jsonType.label
bd0c98d2-cbdf-4b57-9f7e-b1039c5464ff	true	introspection.token.claim
bd0c98d2-cbdf-4b57-9f7e-b1039c5464ff	true	userinfo.token.claim
bd0c98d2-cbdf-4b57-9f7e-b1039c5464ff	updatedAt	user.attribute
bd0c98d2-cbdf-4b57-9f7e-b1039c5464ff	true	id.token.claim
bd0c98d2-cbdf-4b57-9f7e-b1039c5464ff	true	access.token.claim
bd0c98d2-cbdf-4b57-9f7e-b1039c5464ff	updated_at	claim.name
bd0c98d2-cbdf-4b57-9f7e-b1039c5464ff	long	jsonType.label
d3d0a300-4f33-4f88-b4cd-3d56514aea4f	true	introspection.token.claim
d3d0a300-4f33-4f88-b4cd-3d56514aea4f	true	userinfo.token.claim
d3d0a300-4f33-4f88-b4cd-3d56514aea4f	website	user.attribute
d3d0a300-4f33-4f88-b4cd-3d56514aea4f	true	id.token.claim
d3d0a300-4f33-4f88-b4cd-3d56514aea4f	true	access.token.claim
d3d0a300-4f33-4f88-b4cd-3d56514aea4f	website	claim.name
d3d0a300-4f33-4f88-b4cd-3d56514aea4f	String	jsonType.label
ea5d071c-b9f8-4511-96a7-3ada03beab60	true	introspection.token.claim
ea5d071c-b9f8-4511-96a7-3ada03beab60	true	userinfo.token.claim
ea5d071c-b9f8-4511-96a7-3ada03beab60	zoneinfo	user.attribute
ea5d071c-b9f8-4511-96a7-3ada03beab60	true	id.token.claim
ea5d071c-b9f8-4511-96a7-3ada03beab60	true	access.token.claim
ea5d071c-b9f8-4511-96a7-3ada03beab60	zoneinfo	claim.name
ea5d071c-b9f8-4511-96a7-3ada03beab60	String	jsonType.label
2d55bf29-e186-4b6a-b882-b077319d6ae8	true	introspection.token.claim
2d55bf29-e186-4b6a-b882-b077319d6ae8	true	userinfo.token.claim
2d55bf29-e186-4b6a-b882-b077319d6ae8	emailVerified	user.attribute
2d55bf29-e186-4b6a-b882-b077319d6ae8	true	id.token.claim
2d55bf29-e186-4b6a-b882-b077319d6ae8	true	access.token.claim
2d55bf29-e186-4b6a-b882-b077319d6ae8	email_verified	claim.name
2d55bf29-e186-4b6a-b882-b077319d6ae8	boolean	jsonType.label
62866d27-9818-4b3d-b28c-1275d5f8be4f	true	introspection.token.claim
62866d27-9818-4b3d-b28c-1275d5f8be4f	true	userinfo.token.claim
62866d27-9818-4b3d-b28c-1275d5f8be4f	email	user.attribute
62866d27-9818-4b3d-b28c-1275d5f8be4f	true	id.token.claim
62866d27-9818-4b3d-b28c-1275d5f8be4f	true	access.token.claim
62866d27-9818-4b3d-b28c-1275d5f8be4f	email	claim.name
62866d27-9818-4b3d-b28c-1275d5f8be4f	String	jsonType.label
13302c92-8233-4df5-807a-1b7ec0e8b91e	formatted	user.attribute.formatted
13302c92-8233-4df5-807a-1b7ec0e8b91e	country	user.attribute.country
13302c92-8233-4df5-807a-1b7ec0e8b91e	true	introspection.token.claim
13302c92-8233-4df5-807a-1b7ec0e8b91e	postal_code	user.attribute.postal_code
13302c92-8233-4df5-807a-1b7ec0e8b91e	true	userinfo.token.claim
13302c92-8233-4df5-807a-1b7ec0e8b91e	street	user.attribute.street
13302c92-8233-4df5-807a-1b7ec0e8b91e	true	id.token.claim
13302c92-8233-4df5-807a-1b7ec0e8b91e	region	user.attribute.region
13302c92-8233-4df5-807a-1b7ec0e8b91e	true	access.token.claim
13302c92-8233-4df5-807a-1b7ec0e8b91e	locality	user.attribute.locality
1d21ab56-33c4-4f48-81ff-316dae88ea30	true	introspection.token.claim
1d21ab56-33c4-4f48-81ff-316dae88ea30	true	userinfo.token.claim
1d21ab56-33c4-4f48-81ff-316dae88ea30	phoneNumber	user.attribute
1d21ab56-33c4-4f48-81ff-316dae88ea30	true	id.token.claim
1d21ab56-33c4-4f48-81ff-316dae88ea30	true	access.token.claim
1d21ab56-33c4-4f48-81ff-316dae88ea30	phone_number	claim.name
1d21ab56-33c4-4f48-81ff-316dae88ea30	String	jsonType.label
a6dc1d31-7d84-4f1b-973b-ef32b39f5e26	true	introspection.token.claim
a6dc1d31-7d84-4f1b-973b-ef32b39f5e26	true	userinfo.token.claim
a6dc1d31-7d84-4f1b-973b-ef32b39f5e26	phoneNumberVerified	user.attribute
a6dc1d31-7d84-4f1b-973b-ef32b39f5e26	true	id.token.claim
a6dc1d31-7d84-4f1b-973b-ef32b39f5e26	true	access.token.claim
a6dc1d31-7d84-4f1b-973b-ef32b39f5e26	phone_number_verified	claim.name
a6dc1d31-7d84-4f1b-973b-ef32b39f5e26	boolean	jsonType.label
0a4979a1-e8e5-4cb2-b0a5-5235a781493f	true	introspection.token.claim
0a4979a1-e8e5-4cb2-b0a5-5235a781493f	true	access.token.claim
3dafea38-735d-42c4-96c7-493182d03949	true	introspection.token.claim
3dafea38-735d-42c4-96c7-493182d03949	true	multivalued
3dafea38-735d-42c4-96c7-493182d03949	foo	user.attribute
3dafea38-735d-42c4-96c7-493182d03949	true	access.token.claim
3dafea38-735d-42c4-96c7-493182d03949	realm_access.roles	claim.name
3dafea38-735d-42c4-96c7-493182d03949	String	jsonType.label
9ec1b1f9-a4c2-48d8-9eb4-42be5865418a	true	introspection.token.claim
9ec1b1f9-a4c2-48d8-9eb4-42be5865418a	true	multivalued
9ec1b1f9-a4c2-48d8-9eb4-42be5865418a	foo	user.attribute
9ec1b1f9-a4c2-48d8-9eb4-42be5865418a	true	access.token.claim
9ec1b1f9-a4c2-48d8-9eb4-42be5865418a	resource_access.${client_id}.roles	claim.name
9ec1b1f9-a4c2-48d8-9eb4-42be5865418a	String	jsonType.label
a18e92f9-1c8d-4b17-87d4-f12e59675ad8	true	introspection.token.claim
a18e92f9-1c8d-4b17-87d4-f12e59675ad8	true	access.token.claim
ca8e7056-0b3e-4c3e-89f8-aecc341929c9	true	introspection.token.claim
ca8e7056-0b3e-4c3e-89f8-aecc341929c9	true	multivalued
ca8e7056-0b3e-4c3e-89f8-aecc341929c9	foo	user.attribute
ca8e7056-0b3e-4c3e-89f8-aecc341929c9	true	id.token.claim
ca8e7056-0b3e-4c3e-89f8-aecc341929c9	true	access.token.claim
ca8e7056-0b3e-4c3e-89f8-aecc341929c9	groups	claim.name
ca8e7056-0b3e-4c3e-89f8-aecc341929c9	String	jsonType.label
f33ee5e3-0269-4944-a7da-00329041ddce	true	introspection.token.claim
f33ee5e3-0269-4944-a7da-00329041ddce	true	userinfo.token.claim
f33ee5e3-0269-4944-a7da-00329041ddce	username	user.attribute
f33ee5e3-0269-4944-a7da-00329041ddce	true	id.token.claim
f33ee5e3-0269-4944-a7da-00329041ddce	true	access.token.claim
f33ee5e3-0269-4944-a7da-00329041ddce	upn	claim.name
f33ee5e3-0269-4944-a7da-00329041ddce	String	jsonType.label
0b74a2f5-867f-422d-864b-ba054259038f	true	introspection.token.claim
0b74a2f5-867f-422d-864b-ba054259038f	true	id.token.claim
0b74a2f5-867f-422d-864b-ba054259038f	true	access.token.claim
c701f0e7-ae71-4361-83e9-c176385104d2	true	introspection.token.claim
c701f0e7-ae71-4361-83e9-c176385104d2	true	access.token.claim
eaec8666-148b-4c78-8eb8-d7e7d046ddf7	AUTH_TIME	user.session.note
eaec8666-148b-4c78-8eb8-d7e7d046ddf7	true	introspection.token.claim
eaec8666-148b-4c78-8eb8-d7e7d046ddf7	true	id.token.claim
eaec8666-148b-4c78-8eb8-d7e7d046ddf7	true	access.token.claim
eaec8666-148b-4c78-8eb8-d7e7d046ddf7	auth_time	claim.name
eaec8666-148b-4c78-8eb8-d7e7d046ddf7	long	jsonType.label
0ce2c4a0-07ac-4f84-9097-c40295260c88	clientAddress	user.session.note
0ce2c4a0-07ac-4f84-9097-c40295260c88	true	introspection.token.claim
0ce2c4a0-07ac-4f84-9097-c40295260c88	true	id.token.claim
0ce2c4a0-07ac-4f84-9097-c40295260c88	true	access.token.claim
0ce2c4a0-07ac-4f84-9097-c40295260c88	clientAddress	claim.name
0ce2c4a0-07ac-4f84-9097-c40295260c88	String	jsonType.label
2dfd1ac6-290a-44cf-af63-efa527875d96	client_id	user.session.note
2dfd1ac6-290a-44cf-af63-efa527875d96	true	introspection.token.claim
2dfd1ac6-290a-44cf-af63-efa527875d96	true	id.token.claim
2dfd1ac6-290a-44cf-af63-efa527875d96	true	access.token.claim
2dfd1ac6-290a-44cf-af63-efa527875d96	client_id	claim.name
2dfd1ac6-290a-44cf-af63-efa527875d96	String	jsonType.label
db557651-f184-460f-a56b-f9540b9adab3	clientHost	user.session.note
db557651-f184-460f-a56b-f9540b9adab3	true	introspection.token.claim
db557651-f184-460f-a56b-f9540b9adab3	true	id.token.claim
db557651-f184-460f-a56b-f9540b9adab3	true	access.token.claim
db557651-f184-460f-a56b-f9540b9adab3	clientHost	claim.name
db557651-f184-460f-a56b-f9540b9adab3	String	jsonType.label
88480917-579d-4a3f-9671-aa1afa7a77c1	true	introspection.token.claim
88480917-579d-4a3f-9671-aa1afa7a77c1	true	multivalued
88480917-579d-4a3f-9671-aa1afa7a77c1	true	id.token.claim
88480917-579d-4a3f-9671-aa1afa7a77c1	true	access.token.claim
88480917-579d-4a3f-9671-aa1afa7a77c1	organization	claim.name
88480917-579d-4a3f-9671-aa1afa7a77c1	String	jsonType.label
aae703eb-e82a-4bb1-9966-111fca67ced3	true	introspection.token.claim
aae703eb-e82a-4bb1-9966-111fca67ced3	true	userinfo.token.claim
aae703eb-e82a-4bb1-9966-111fca67ced3	locale	user.attribute
aae703eb-e82a-4bb1-9966-111fca67ced3	true	id.token.claim
aae703eb-e82a-4bb1-9966-111fca67ced3	true	access.token.claim
aae703eb-e82a-4bb1-9966-111fca67ced3	locale	claim.name
aae703eb-e82a-4bb1-9966-111fca67ced3	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
38d94c69-6603-4341-a226-f65366146032	60	300	300				t	f	0	mealwurm	mealwurm	0	\N	t	f	f	f	EXTERNAL	1800	36000	f	f	7d116705-0e72-4b1a-ad08-e8aeaaab5fbe	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	d44239b3-06eb-4ec1-9f94-a09d967fcbf4	da777280-03fd-4447-b2d2-5970166e6ab5	400c7467-cda2-49a2-bcf8-5960c5bb1694	36f4fca7-4154-4eda-898c-83d622d24cf0	23e7836d-ed1c-4d5c-94b4-1807077c0c26	2592000	f	900	t	f	48f4bacb-626d-4c97-bf01-d606ff9e904a	0	f	0	0	203ccff1-a8dd-48b0-8e84-419e0293d5b8
cce4122f-9b89-420a-bd97-dc991169c190	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	efd4d5ad-dc20-455a-af96-473ecb04282d	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	69a25179-b194-402a-b7d0-ffd52f3f6a03	35ebe2df-2086-4536-8953-103a9c4477c4	ed2d371c-ead3-450b-a637-182ffa8469be	e732dcf6-d163-4076-b37c-1f6067fd9e0e	ebb0eb59-e3b7-4c6a-a5c4-7f72f0b54c2e	2592000	f	900	t	f	c3249293-ec9c-4fb9-a051-91e6a878ec12	0	f	0	0	570a17f9-be4e-4bb0-93ba-1396fda1eb4b
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	cce4122f-9b89-420a-bd97-dc991169c190	
_browser_header.xContentTypeOptions	cce4122f-9b89-420a-bd97-dc991169c190	nosniff
_browser_header.referrerPolicy	cce4122f-9b89-420a-bd97-dc991169c190	no-referrer
_browser_header.xRobotsTag	cce4122f-9b89-420a-bd97-dc991169c190	none
_browser_header.xFrameOptions	cce4122f-9b89-420a-bd97-dc991169c190	SAMEORIGIN
_browser_header.contentSecurityPolicy	cce4122f-9b89-420a-bd97-dc991169c190	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	cce4122f-9b89-420a-bd97-dc991169c190	1; mode=block
_browser_header.strictTransportSecurity	cce4122f-9b89-420a-bd97-dc991169c190	max-age=31536000; includeSubDomains
bruteForceProtected	cce4122f-9b89-420a-bd97-dc991169c190	false
permanentLockout	cce4122f-9b89-420a-bd97-dc991169c190	false
maxTemporaryLockouts	cce4122f-9b89-420a-bd97-dc991169c190	0
bruteForceStrategy	cce4122f-9b89-420a-bd97-dc991169c190	MULTIPLE
maxFailureWaitSeconds	cce4122f-9b89-420a-bd97-dc991169c190	900
minimumQuickLoginWaitSeconds	cce4122f-9b89-420a-bd97-dc991169c190	60
waitIncrementSeconds	cce4122f-9b89-420a-bd97-dc991169c190	60
quickLoginCheckMilliSeconds	cce4122f-9b89-420a-bd97-dc991169c190	1000
maxDeltaTimeSeconds	cce4122f-9b89-420a-bd97-dc991169c190	43200
failureFactor	cce4122f-9b89-420a-bd97-dc991169c190	30
realmReusableOtpCode	cce4122f-9b89-420a-bd97-dc991169c190	false
firstBrokerLoginFlowId	cce4122f-9b89-420a-bd97-dc991169c190	a199ef20-4e50-4d45-a722-f11ea38c5eb2
displayName	cce4122f-9b89-420a-bd97-dc991169c190	Keycloak
displayNameHtml	cce4122f-9b89-420a-bd97-dc991169c190	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	cce4122f-9b89-420a-bd97-dc991169c190	RS256
offlineSessionMaxLifespanEnabled	cce4122f-9b89-420a-bd97-dc991169c190	false
offlineSessionMaxLifespan	cce4122f-9b89-420a-bd97-dc991169c190	5184000
bruteForceProtected	38d94c69-6603-4341-a226-f65366146032	false
permanentLockout	38d94c69-6603-4341-a226-f65366146032	false
maxTemporaryLockouts	38d94c69-6603-4341-a226-f65366146032	0
bruteForceStrategy	38d94c69-6603-4341-a226-f65366146032	MULTIPLE
maxFailureWaitSeconds	38d94c69-6603-4341-a226-f65366146032	900
minimumQuickLoginWaitSeconds	38d94c69-6603-4341-a226-f65366146032	60
waitIncrementSeconds	38d94c69-6603-4341-a226-f65366146032	60
quickLoginCheckMilliSeconds	38d94c69-6603-4341-a226-f65366146032	1000
maxDeltaTimeSeconds	38d94c69-6603-4341-a226-f65366146032	43200
failureFactor	38d94c69-6603-4341-a226-f65366146032	30
realmReusableOtpCode	38d94c69-6603-4341-a226-f65366146032	false
defaultSignatureAlgorithm	38d94c69-6603-4341-a226-f65366146032	RS256
offlineSessionMaxLifespanEnabled	38d94c69-6603-4341-a226-f65366146032	false
offlineSessionMaxLifespan	38d94c69-6603-4341-a226-f65366146032	5184000
actionTokenGeneratedByAdminLifespan	38d94c69-6603-4341-a226-f65366146032	43200
actionTokenGeneratedByUserLifespan	38d94c69-6603-4341-a226-f65366146032	300
oauth2DeviceCodeLifespan	38d94c69-6603-4341-a226-f65366146032	600
oauth2DevicePollingInterval	38d94c69-6603-4341-a226-f65366146032	5
webAuthnPolicyRpEntityName	38d94c69-6603-4341-a226-f65366146032	keycloak
webAuthnPolicySignatureAlgorithms	38d94c69-6603-4341-a226-f65366146032	ES256,RS256
webAuthnPolicyRpId	38d94c69-6603-4341-a226-f65366146032	
webAuthnPolicyAttestationConveyancePreference	38d94c69-6603-4341-a226-f65366146032	not specified
webAuthnPolicyAuthenticatorAttachment	38d94c69-6603-4341-a226-f65366146032	not specified
webAuthnPolicyRequireResidentKey	38d94c69-6603-4341-a226-f65366146032	not specified
webAuthnPolicyUserVerificationRequirement	38d94c69-6603-4341-a226-f65366146032	not specified
webAuthnPolicyCreateTimeout	38d94c69-6603-4341-a226-f65366146032	0
webAuthnPolicyAvoidSameAuthenticatorRegister	38d94c69-6603-4341-a226-f65366146032	false
webAuthnPolicyRpEntityNamePasswordless	38d94c69-6603-4341-a226-f65366146032	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	38d94c69-6603-4341-a226-f65366146032	ES256,RS256
webAuthnPolicyRpIdPasswordless	38d94c69-6603-4341-a226-f65366146032	
webAuthnPolicyAttestationConveyancePreferencePasswordless	38d94c69-6603-4341-a226-f65366146032	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	38d94c69-6603-4341-a226-f65366146032	not specified
webAuthnPolicyRequireResidentKeyPasswordless	38d94c69-6603-4341-a226-f65366146032	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	38d94c69-6603-4341-a226-f65366146032	not specified
webAuthnPolicyCreateTimeoutPasswordless	38d94c69-6603-4341-a226-f65366146032	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	38d94c69-6603-4341-a226-f65366146032	false
cibaBackchannelTokenDeliveryMode	38d94c69-6603-4341-a226-f65366146032	poll
cibaExpiresIn	38d94c69-6603-4341-a226-f65366146032	120
cibaInterval	38d94c69-6603-4341-a226-f65366146032	5
cibaAuthRequestedUserHint	38d94c69-6603-4341-a226-f65366146032	login_hint
parRequestUriLifespan	38d94c69-6603-4341-a226-f65366146032	60
firstBrokerLoginFlowId	38d94c69-6603-4341-a226-f65366146032	eaa8a50d-cb90-43d8-8cc5-aec3eaf24f56
organizationsEnabled	38d94c69-6603-4341-a226-f65366146032	false
adminPermissionsEnabled	38d94c69-6603-4341-a226-f65366146032	false
verifiableCredentialsEnabled	38d94c69-6603-4341-a226-f65366146032	false
clientSessionIdleTimeout	38d94c69-6603-4341-a226-f65366146032	0
clientSessionMaxLifespan	38d94c69-6603-4341-a226-f65366146032	0
clientOfflineSessionIdleTimeout	38d94c69-6603-4341-a226-f65366146032	0
clientOfflineSessionMaxLifespan	38d94c69-6603-4341-a226-f65366146032	0
client-policies.profiles	38d94c69-6603-4341-a226-f65366146032	{"profiles":[]}
client-policies.policies	38d94c69-6603-4341-a226-f65366146032	{"policies":[]}
darkMode	38d94c69-6603-4341-a226-f65366146032	true
_browser_header.contentSecurityPolicyReportOnly	38d94c69-6603-4341-a226-f65366146032	
_browser_header.xContentTypeOptions	38d94c69-6603-4341-a226-f65366146032	nosniff
_browser_header.referrerPolicy	38d94c69-6603-4341-a226-f65366146032	no-referrer
_browser_header.xRobotsTag	38d94c69-6603-4341-a226-f65366146032	none
_browser_header.xFrameOptions	38d94c69-6603-4341-a226-f65366146032	SAMEORIGIN
_browser_header.contentSecurityPolicy	38d94c69-6603-4341-a226-f65366146032	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	38d94c69-6603-4341-a226-f65366146032	1; mode=block
_browser_header.strictTransportSecurity	38d94c69-6603-4341-a226-f65366146032	max-age=31536000; includeSubDomains
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
cce4122f-9b89-420a-bd97-dc991169c190	jboss-logging
38d94c69-6603-4341-a226-f65366146032	jboss-logging
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
password	password	t	t	cce4122f-9b89-420a-bd97-dc991169c190
password	password	t	t	38d94c69-6603-4341-a226-f65366146032
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
096a2232-f038-4047-a55c-dc34661a03a9	\N	\N	\N	\N	5	Combine ingredients in sandwich fashion. Enjoy.	5	Peanut Butter & Jelly Sandwich	1a5073e0-ec8d-4c6c-a747-a118c3417368
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
9ee22a07-854e-4b97-a636-a8a17d2cc1a4	/realms/master/account/*
76faf3ac-102c-40bf-970f-eb1f78aa06ad	/realms/master/account/*
245c8a5c-3bf4-4ff8-a90d-da60f1b7ef1c	/admin/master/console/*
43911470-b287-4ab5-b065-3f02b4e850f6	/realms/mealwurm/account/*
329515af-4e73-4143-8938-3567714ec63b	/realms/mealwurm/account/*
1e407bad-abc2-4602-b914-06c58e9fcacc	/admin/mealwurm/console/*
8f8c0971-90fd-48b1-9b94-73a7deedf5d6	http://localhost:3000/*
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
332bede8-4ea7-4c03-812f-eb18ba23c17e	VERIFY_EMAIL	Verify Email	cce4122f-9b89-420a-bd97-dc991169c190	t	f	VERIFY_EMAIL	50
9c1170c5-02f8-4d60-a876-a03884d6fd37	UPDATE_PROFILE	Update Profile	cce4122f-9b89-420a-bd97-dc991169c190	t	f	UPDATE_PROFILE	40
ee20917e-5ae5-407c-bae5-2ed496de7c00	CONFIGURE_TOTP	Configure OTP	cce4122f-9b89-420a-bd97-dc991169c190	t	f	CONFIGURE_TOTP	10
1b06c2a8-c92f-4548-b2ff-3d5be1f274e2	UPDATE_PASSWORD	Update Password	cce4122f-9b89-420a-bd97-dc991169c190	t	f	UPDATE_PASSWORD	30
7d43f701-860c-479e-b442-231bed0bd152	TERMS_AND_CONDITIONS	Terms and Conditions	cce4122f-9b89-420a-bd97-dc991169c190	f	f	TERMS_AND_CONDITIONS	20
addd84d8-c2ca-45c0-9c4e-1aa3f0c1e3ee	delete_account	Delete Account	cce4122f-9b89-420a-bd97-dc991169c190	f	f	delete_account	60
c539d8a3-cd0e-4841-87c9-4077404b3856	delete_credential	Delete Credential	cce4122f-9b89-420a-bd97-dc991169c190	t	f	delete_credential	100
1d75eb23-d87b-4f79-a377-5a7e93c875c2	update_user_locale	Update User Locale	cce4122f-9b89-420a-bd97-dc991169c190	t	f	update_user_locale	1000
05abae18-8046-4d42-ab42-d829aead467e	webauthn-register	Webauthn Register	cce4122f-9b89-420a-bd97-dc991169c190	t	f	webauthn-register	70
a1f2542b-6fc3-4080-8877-4f4f4683353b	webauthn-register-passwordless	Webauthn Register Passwordless	cce4122f-9b89-420a-bd97-dc991169c190	t	f	webauthn-register-passwordless	80
25592254-dbeb-482b-9432-adb53742326e	VERIFY_PROFILE	Verify Profile	cce4122f-9b89-420a-bd97-dc991169c190	t	f	VERIFY_PROFILE	90
8698876c-b32f-428b-85e1-ee6319e9ad4c	VERIFY_EMAIL	Verify Email	38d94c69-6603-4341-a226-f65366146032	t	f	VERIFY_EMAIL	50
ee1b5123-6d2c-4cc9-9d5c-072a6f12a5e7	UPDATE_PROFILE	Update Profile	38d94c69-6603-4341-a226-f65366146032	t	f	UPDATE_PROFILE	40
ee152f9b-aea5-49db-ab12-347aa96c9ae5	CONFIGURE_TOTP	Configure OTP	38d94c69-6603-4341-a226-f65366146032	t	f	CONFIGURE_TOTP	10
0715b477-0544-4226-817e-ffe77fd16bc0	UPDATE_PASSWORD	Update Password	38d94c69-6603-4341-a226-f65366146032	t	f	UPDATE_PASSWORD	30
91a374e4-eba2-4019-b93c-fee9d8baf730	TERMS_AND_CONDITIONS	Terms and Conditions	38d94c69-6603-4341-a226-f65366146032	f	f	TERMS_AND_CONDITIONS	20
170fcaa2-9a79-4fcc-9e68-d84ad490757b	delete_account	Delete Account	38d94c69-6603-4341-a226-f65366146032	f	f	delete_account	60
b00fda52-5e08-445f-a9a2-b64569e404d9	delete_credential	Delete Credential	38d94c69-6603-4341-a226-f65366146032	t	f	delete_credential	100
007aa51a-4236-476f-b4b5-36f0779293ab	update_user_locale	Update User Locale	38d94c69-6603-4341-a226-f65366146032	t	f	update_user_locale	1000
f2ebe741-d347-4c40-b604-55ab716be9ae	webauthn-register	Webauthn Register	38d94c69-6603-4341-a226-f65366146032	t	f	webauthn-register	70
174ce546-45c6-405d-b05e-7f131aff8803	webauthn-register-passwordless	Webauthn Register Passwordless	38d94c69-6603-4341-a226-f65366146032	t	f	webauthn-register-passwordless	80
44a021a5-ec6b-439c-b18c-7a46e410a560	VERIFY_PROFILE	Verify Profile	38d94c69-6603-4341-a226-f65366146032	t	f	VERIFY_PROFILE	90
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
76faf3ac-102c-40bf-970f-eb1f78aa06ad	2a99939f-e2f5-4831-9d79-6146281fac01
76faf3ac-102c-40bf-970f-eb1f78aa06ad	0b0f3db9-e0cc-4a9d-b64c-22942e0c340d
329515af-4e73-4143-8938-3567714ec63b	df95cde9-97ca-4121-b0be-6e2db4961e8c
329515af-4e73-4143-8938-3567714ec63b	ed8e34e0-550c-490e-947e-8dd58f57179e
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
is_temporary_admin	true	7157f634-21c5-4eb4-93af-c05171c60ce2	04a6fb36-35be-4352-af88-1b31f1d0991e	\N	\N	\N
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
7157f634-21c5-4eb4-93af-c05171c60ce2	\N	763b4e65-f430-449c-a64a-cd8c7fce0275	f	t	\N	\N	\N	cce4122f-9b89-420a-bd97-dc991169c190	admin	1755730622378	\N	0
1a5073e0-ec8d-4c6c-a747-a118c3417368	user@gmail.com	user@gmail.com	t	t	\N	Jane	Doe	38d94c69-6603-4341-a226-f65366146032	user	1755731904460	\N	0
a5928e7e-07bd-4d1f-a5f0-04d4db576c46	admin@gmail.com	admin@gmail.com	t	t	\N	John	Doe	38d94c69-6603-4341-a226-f65366146032	admin	1755731934919	\N	0
26949c13-c089-4da7-8be0-229e3bd68cd4	user2@gmail.com	user2@gmail.com	t	t	\N	Juan	Doe	38d94c69-6603-4341-a226-f65366146032	user2	1755791711147	\N	0
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
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
570a17f9-be4e-4bb0-93ba-1396fda1eb4b	7157f634-21c5-4eb4-93af-c05171c60ce2
c8f9f357-481c-4493-b79f-af9cc4c19b54	7157f634-21c5-4eb4-93af-c05171c60ce2
203ccff1-a8dd-48b0-8e84-419e0293d5b8	1a5073e0-ec8d-4c6c-a747-a118c3417368
203ccff1-a8dd-48b0-8e84-419e0293d5b8	a5928e7e-07bd-4d1f-a5f0-04d4db576c46
0da09e77-86a7-4390-8323-b001d6bfe73d	a5928e7e-07bd-4d1f-a5f0-04d4db576c46
b6fc0cef-f532-4500-b1c6-53d6324b78d8	1a5073e0-ec8d-4c6c-a747-a118c3417368
203ccff1-a8dd-48b0-8e84-419e0293d5b8	26949c13-c089-4da7-8be0-229e3bd68cd4
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: mealwurm
--

COPY public.web_origins (client_id, value) FROM stdin;
245c8a5c-3bf4-4ff8-a90d-da60f1b7ef1c	+
1e407bad-abc2-4602-b914-06c58e9fcacc	+
8f8c0971-90fd-48b1-9b94-73a7deedf5d6	http://localhost:3000
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
-- Name: recipe fk34blgcxj4lf4h51ihrv22u3aq; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.recipe
    ADD CONSTRAINT fk34blgcxj4lf4h51ihrv22u3aq FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


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
-- Name: tag fk8f1500b0xius78qlqavqv0wll; Type: FK CONSTRAINT; Schema: public; Owner: mealwurm
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT fk8f1500b0xius78qlqavqv0wll FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


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

