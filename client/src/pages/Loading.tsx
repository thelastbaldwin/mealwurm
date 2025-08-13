import { Container } from "../components";
import { LoadingWaveIcon } from "../icons";

const Loading = () => {
  return (
    <Container>
      <section className="flex flex-1 justify-center items-center">
        <div className="flex flex-col items-center">
          <LoadingWaveIcon />
        </div>
      </section>
    </Container>
  );
};

export default Loading;
