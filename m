Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4CB6C7D26
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 12:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjCXLWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 07:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjCXLWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 07:22:21 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F2722DC4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 04:22:19 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id h8so6546543ede.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 04:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1679656938;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRr72t+4UZ9OP3mnlpRJ8YUSEtD1+XLxKD3GEqqnIeE=;
        b=rByZavltipXd6PeR2v95ebI03dIGh+3m2D/LZWooOg5lz5WRzXzg/D3YV9l6c0uKxL
         jmZHyS9y3jTCVpIFONpkVGKNXMgqnEoCtaALhrvBxRcbhy7HZAO65bc/g/LbBuXCXQQq
         I0GAjGQd/+iNmUagoaSY16uUt3vBsSa/WZr3QMIH9KM3NswBASm4ZC0Y4Mn2CONJZed9
         gY6oxtGvKUnV7EMSeoXWDnT23dCbFjxq4MKzORJ1TDHUbU2+aP0X8kol/QZ89GQ3s0Ec
         bcIzag9bxLfvF2eRS7XN3NkjTpxb97uICwhyXyalcsyXQH5rGpou8OAfP+VUeZHyMHz4
         6Feg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679656938;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HRr72t+4UZ9OP3mnlpRJ8YUSEtD1+XLxKD3GEqqnIeE=;
        b=NWkkXUPOG1V06seUKON6mawIlEtYzwh2PPAXLSEoKB/MbTCvK6orvqTjRp7HVFgoUX
         W9f6rrpG3yXYlV8hB3ldIx607KTzGYieW0VNcPZzT13WFuV1T2Qgg3rpffCgC5ayCqQR
         qUt0iUnAvaLqpynKUqxhAppC/sEbnUc0FGc9F63Z8kaCIL88n3sND332/LAnwxeZfmPD
         czERHFZhcj2+68dlJF/JorYnzIFqRHChMPtzboky44d+ncEMNUq1IQsKlRi6R1tQa1+V
         r+s2ick+V9JqdFkA9V74fLEeE33pRJOl7w8XIalQMz1V9nOpLG5um5Lviz3QlEVuidH8
         O8VQ==
X-Gm-Message-State: AAQBX9fSB6ZizFEA2RRuAHTfKPpzz6mTY663dQOkbD9QlmQ/0UkkjKd0
        ATMY6U6MPRHrqGaKUteFwhOKmA==
X-Google-Smtp-Source: AKy350bjEB9tApb06Tb8yG8b1P3/ZPV+Lg4I1D0D6bOj4xxx8mW783dZePdsRRnmgNADtBJDf0pU8g==
X-Received: by 2002:a17:906:5288:b0:932:3d1b:b67a with SMTP id c8-20020a170906528800b009323d1bb67amr2333180ejm.41.1679656938274;
        Fri, 24 Mar 2023 04:22:18 -0700 (PDT)
Received: from localhost (84-115-214-73.cable.dynamic.surfer.at. [84.115.214.73])
        by smtp.gmail.com with ESMTPSA id g9-20020a056402320900b004fd219242a5sm10458496eda.7.2023.03.24.04.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 04:22:18 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 24 Mar 2023 12:22:17 +0100
Message-Id: <CREKOWOABXLP.28VKF824CFB3O@otso>
To:     "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
        <broonie@kernel.org>
Cc:     <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <steev@kali.org>, <johan+linaro@kernel.org>,
        <quic_bjorande@quicinc.com>
Subject: Re: [PATCH 5/8] ASoC: codecs: lpass: register mclk after runtime pm
From:   "Luca Weiss" <luca.weiss@fairphone.com>
X-Mailer: aerc 0.14.0
References: <20230209122806.18923-1-srinivas.kandagatla@linaro.org>
 <20230209122806.18923-6-srinivas.kandagatla@linaro.org>
In-Reply-To: <20230209122806.18923-6-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

On Thu Feb 9, 2023 at 1:28 PM CET, Srinivas Kandagatla wrote:
> move mclk out registration after runtime pm is enabled so that the
> clk framework can resume the codec if it requires to enable the mclk out.
>
> Fixes: c96baa2949b2 ("ASoC: codecs: wsa-macro: add runtime pm support")
> Fixes: 72ad25eabda0 ("ASoC: codecs: va-macro: add runtime pm support")
> Fixes: 366ff79ed539 ("ASoC: codecs: rx-macro: add runtime pm support")
> Fixes: 1fb83bc5cf64 ("ASoC: codecs: tx-macro: add runtime pm support")
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

I see the following remoteproc crash with this patch in on
sm6350/sm7225-fairphone-fp4.

To be clear, all the audio parts for that SoC are not upstream (yet) and
there's still many issues to solve so not sure if it's actually my fault.

Anyways, getting this crash after starting adsp.

[   97.212943] qcom_q6v5_pas 3000000.remoteproc: fatal error received: ABT_=
dal.c:287:ABTimeout: AHB Bus hang is detected, Number of bus hang detected =
:=3D 1 , addr0 =3D 0x3370000 , addr1 =3D 0x0!!!
[   97.212995] remoteproc remoteproc0: crash detected in 3000000.remoteproc=
: type fatal error
[   97.213015] remoteproc remoteproc0: handling crash #1 in 3000000.remotep=
roc
[   97.213022] remoteproc remoteproc0: recovering 3000000.remoteproc

This happens just after some clocks on the adsp get disabled, this is
from my own debug prints:
[   97.189097] q6afe_set_lpass_clock: clk_id=3D780, attri=3D1, clk_root=3D0=
, freq=3D0
[   97.189426] q6afe_set_lpass_clock: clk_id=3D781, attri=3D1, clk_root=3D0=
, freq=3D0

And then a couple of seconds later the whole phone just crashes into the
900e mode.

Regards
Luca


> ---
>  sound/soc/codecs/lpass-rx-macro.c  |  8 ++++----
>  sound/soc/codecs/lpass-tx-macro.c  |  8 ++++----
>  sound/soc/codecs/lpass-va-macro.c  | 20 ++++++++++----------
>  sound/soc/codecs/lpass-wsa-macro.c |  9 ++++-----
>  4 files changed, 22 insertions(+), 23 deletions(-)
>
> diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-r=
x-macro.c
> index a9ef9d5ffcc5..dd6970d5eb8d 100644
> --- a/sound/soc/codecs/lpass-rx-macro.c
> +++ b/sound/soc/codecs/lpass-rx-macro.c
> @@ -3601,10 +3601,6 @@ static int rx_macro_probe(struct platform_device *=
pdev)
>  	if (ret)
>  		goto err_fsgen;
> =20
> -	ret =3D rx_macro_register_mclk_output(rx);
> -	if (ret)
> -		goto err_clkout;
> -
>  	ret =3D devm_snd_soc_register_component(dev, &rx_macro_component_drv,
>  					      rx_macro_dai,
>  					      ARRAY_SIZE(rx_macro_dai));
> @@ -3618,6 +3614,10 @@ static int rx_macro_probe(struct platform_device *=
pdev)
>  	pm_runtime_set_active(dev);
>  	pm_runtime_enable(dev);
> =20
> +	ret =3D rx_macro_register_mclk_output(rx);
> +	if (ret)
> +		goto err_clkout;
> +
>  	return 0;
> =20
>  err_clkout:
> diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-t=
x-macro.c
> index 2ef62d6edc30..b9475ba55e20 100644
> --- a/sound/soc/codecs/lpass-tx-macro.c
> +++ b/sound/soc/codecs/lpass-tx-macro.c
> @@ -2036,10 +2036,6 @@ static int tx_macro_probe(struct platform_device *=
pdev)
>  	if (ret)
>  		goto err_fsgen;
> =20
> -	ret =3D tx_macro_register_mclk_output(tx);
> -	if (ret)
> -		goto err_clkout;
> -
>  	ret =3D devm_snd_soc_register_component(dev, &tx_macro_component_drv,
>  					      tx_macro_dai,
>  					      ARRAY_SIZE(tx_macro_dai));
> @@ -2052,6 +2048,10 @@ static int tx_macro_probe(struct platform_device *=
pdev)
>  	pm_runtime_set_active(dev);
>  	pm_runtime_enable(dev);
> =20
> +	ret =3D tx_macro_register_mclk_output(tx);
> +	if (ret)
> +		goto err_clkout;
> +
>  	return 0;
> =20
>  err_clkout:
> diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-v=
a-macro.c
> index b0b6cf29cba3..1623ba78ddb3 100644
> --- a/sound/soc/codecs/lpass-va-macro.c
> +++ b/sound/soc/codecs/lpass-va-macro.c
> @@ -1524,16 +1524,6 @@ static int va_macro_probe(struct platform_device *=
pdev)
>  	if (ret)
>  		goto err_mclk;
> =20
> -	ret =3D va_macro_register_fsgen_output(va);
> -	if (ret)
> -		goto err_clkout;
> -
> -	va->fsgen =3D clk_hw_get_clk(&va->hw, "fsgen");
> -	if (IS_ERR(va->fsgen)) {
> -		ret =3D PTR_ERR(va->fsgen);
> -		goto err_clkout;
> -	}
> -
>  	if (va->has_swr_master) {
>  		/* Set default CLK div to 1 */
>  		regmap_update_bits(va->regmap, CDC_VA_TOP_CSR_SWR_MIC_CTL0,
> @@ -1560,6 +1550,16 @@ static int va_macro_probe(struct platform_device *=
pdev)
>  	pm_runtime_set_active(dev);
>  	pm_runtime_enable(dev);
> =20
> +	ret =3D va_macro_register_fsgen_output(va);
> +	if (ret)
> +		goto err_clkout;
> +
> +	va->fsgen =3D clk_hw_get_clk(&va->hw, "fsgen");
> +	if (IS_ERR(va->fsgen)) {
> +		ret =3D PTR_ERR(va->fsgen);
> +		goto err_clkout;
> +	}
> +
>  	return 0;
> =20
>  err_clkout:
> diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-=
wsa-macro.c
> index 5cfe96f6e430..c0b86d69c72e 100644
> --- a/sound/soc/codecs/lpass-wsa-macro.c
> +++ b/sound/soc/codecs/lpass-wsa-macro.c
> @@ -2451,11 +2451,6 @@ static int wsa_macro_probe(struct platform_device =
*pdev)
>  	if (ret)
>  		goto err_fsgen;
> =20
> -	ret =3D wsa_macro_register_mclk_output(wsa);
> -	if (ret)
> -		goto err_clkout;
> -
> -
>  	ret =3D devm_snd_soc_register_component(dev, &wsa_macro_component_drv,
>  					      wsa_macro_dai,
>  					      ARRAY_SIZE(wsa_macro_dai));
> @@ -2468,6 +2463,10 @@ static int wsa_macro_probe(struct platform_device =
*pdev)
>  	pm_runtime_set_active(dev);
>  	pm_runtime_enable(dev);
> =20
> +	ret =3D wsa_macro_register_mclk_output(wsa);
> +	if (ret)
> +		goto err_clkout;
> +
>  	return 0;
> =20
>  err_clkout:
> --=20
> 2.21.0

