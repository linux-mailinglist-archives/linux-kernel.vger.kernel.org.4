Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8446D1F58
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 13:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjCaLmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 07:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjCaLml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 07:42:41 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB3C191FB
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 04:42:39 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id ew6so88380480edb.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 04:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1680262958; x=1682854958;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4UMt/uQavZvUD9jlmkMLKcZa3Scbrdah2/KVZEgnww=;
        b=VN+f7qPZVike+udaEK6uUPh17uXFK9dM3elIMx+dnL3YEpuM28Xt0JtM3X4BjiE40p
         lc1WL9u/UkcBusz289hoiNNHESo2f0DlAf/YjTCxO5f37mm13xtKrUmCstczo2uu5Fkh
         jokVwQV2Gdtx28sdsHsEivCG6Ekgii/hhDE9Y2Pjqof0LunmbmQdh1VPJZs5UtMJMke4
         MH0YnhQGKsBa35bv/1gnqeAkvu5f52ujLY5EACddKeWY6qHMAnaK6Xs74/f/vIggeFIX
         Nwwm/qOu/3NFlzmdC+uqYF4r7TdkQoc4bd5RMG+9PKjhATumppOys8TDOd3qNcPvf+ab
         5dmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680262958; x=1682854958;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K4UMt/uQavZvUD9jlmkMLKcZa3Scbrdah2/KVZEgnww=;
        b=j1+qRXn7ErJbTdvSVsSN1VSYgsl5OXIq4ua7M/J7xfqbBLBU4Vg/2aceEuELDFafp6
         sQ4ROzY2cfNmaNHt8/h88jtEyLVk2+dq99PnonhIFcR8PLE/fn8Z7B9jp9079ZsKhXjX
         lkBjwHCvbDDg8ISUPkOpqG/E7ojsyH6B7ThQYqW1Sp7aBFXT/Lxz4MCg5UBHnqUS+obb
         zzHiwKgFE9D3eN0zDLR/HG8K4kz5zyF+au53OFYiJPgQfps1/f3wCFSy2XgkBQDPibI6
         0padtrWxxW2gCCsu9SLQMxOQXmTgo1f7EjayQPlqDTn0zYjWWDsRVjqkTEy0k0lpRo2D
         0pKA==
X-Gm-Message-State: AAQBX9dyj84zdDIflxo/ouLd21kTdF73NmFyGW6/NdynePiKSI6oGowT
        qDDbyn07368rRp4AKQzc7rvIDQ==
X-Google-Smtp-Source: AKy350bU6YNYtfDrZJb4mmhrOkc2Dbh79ZNF3PcRCc5KbPdRkJ5TYvPvhlSpYorjEEX8ZCut+dDJnA==
X-Received: by 2002:a17:906:9f04:b0:944:8c30:830d with SMTP id fy4-20020a1709069f0400b009448c30830dmr19555868ejc.42.1680262957896;
        Fri, 31 Mar 2023 04:42:37 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906058100b00946c5da4d32sm890571ejn.40.2023.03.31.04.42.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 04:42:37 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 31 Mar 2023 13:42:37 +0200
Message-Id: <CRKJIAFM4FQS.CLF4S9AUEBBX@otso>
Cc:     <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <steev@kali.org>, <johan+linaro@kernel.org>,
        <quic_bjorande@quicinc.com>
Subject: Re: [PATCH 5/8] ASoC: codecs: lpass: register mclk after runtime pm
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
        <broonie@kernel.org>
X-Mailer: aerc 0.14.0
References: <20230209122806.18923-1-srinivas.kandagatla@linaro.org>
 <20230209122806.18923-6-srinivas.kandagatla@linaro.org>
 <CREKOWOABXLP.28VKF824CFB3O@otso>
 <e782e78c-422f-fbf9-94a3-3557c9f7fc7e@linaro.org>
In-Reply-To: <e782e78c-422f-fbf9-94a3-3557c9f7fc7e@linaro.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Mar 24, 2023 at 2:40 PM CET, Srinivas Kandagatla wrote:
> Hi Luca,
>
> On 24/03/2023 11:22, Luca Weiss wrote:
> > Hi Srinivas,
> >=20
> > On Thu Feb 9, 2023 at 1:28 PM CET, Srinivas Kandagatla wrote:
> >> move mclk out registration after runtime pm is enabled so that the
> >> clk framework can resume the codec if it requires to enable the mclk o=
ut.
> >>
> >> Fixes: c96baa2949b2 ("ASoC: codecs: wsa-macro: add runtime pm support"=
)
> >> Fixes: 72ad25eabda0 ("ASoC: codecs: va-macro: add runtime pm support")
> >> Fixes: 366ff79ed539 ("ASoC: codecs: rx-macro: add runtime pm support")
> >> Fixes: 1fb83bc5cf64 ("ASoC: codecs: tx-macro: add runtime pm support")
> >> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> >=20
> > I see the following remoteproc crash with this patch in on
> > sm6350/sm7225-fairphone-fp4.
> >=20
> > To be clear, all the audio parts for that SoC are not upstream (yet) an=
d
> > there's still many issues to solve so not sure if it's actually my faul=
t.
> >=20
>
> please try this patch Amit did report this issue before
>
> https://lore.kernel.org/lkml/20230323110125.23790-1-srinivas.kandagatla@l=
inaro.org/

Right, that fixes it on sm6350/sm7225 also. Thanks!

Regards
Luca

>
>
> thanks,
> srini
> > Anyways, getting this crash after starting adsp.
> >=20
> > [   97.212943] qcom_q6v5_pas 3000000.remoteproc: fatal error received: =
ABT_dal.c:287:ABTimeout: AHB Bus hang is detected, Number of bus hang detec=
ted :=3D 1 , addr0 =3D 0x3370000 , addr1 =3D 0x0!!!
> > [   97.212995] remoteproc remoteproc0: crash detected in 3000000.remote=
proc: type fatal error
> > [   97.213015] remoteproc remoteproc0: handling crash #1 in 3000000.rem=
oteproc
> > [   97.213022] remoteproc remoteproc0: recovering 3000000.remoteproc
> >=20
> > This happens just after some clocks on the adsp get disabled, this is
> > from my own debug prints:
> > [   97.189097] q6afe_set_lpass_clock: clk_id=3D780, attri=3D1, clk_root=
=3D0, freq=3D0
> > [   97.189426] q6afe_set_lpass_clock: clk_id=3D781, attri=3D1, clk_root=
=3D0, freq=3D0
> >=20
> > And then a couple of seconds later the whole phone just crashes into th=
e
> > 900e mode.
> >=20
> > Regards
> > Luca
> >=20
> >=20
> >> ---
> >>   sound/soc/codecs/lpass-rx-macro.c  |  8 ++++----
> >>   sound/soc/codecs/lpass-tx-macro.c  |  8 ++++----
> >>   sound/soc/codecs/lpass-va-macro.c  | 20 ++++++++++----------
> >>   sound/soc/codecs/lpass-wsa-macro.c |  9 ++++-----
> >>   4 files changed, 22 insertions(+), 23 deletions(-)
> >>
> >> diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpas=
s-rx-macro.c
> >> index a9ef9d5ffcc5..dd6970d5eb8d 100644
> >> --- a/sound/soc/codecs/lpass-rx-macro.c
> >> +++ b/sound/soc/codecs/lpass-rx-macro.c
> >> @@ -3601,10 +3601,6 @@ static int rx_macro_probe(struct platform_devic=
e *pdev)
> >>   	if (ret)
> >>   		goto err_fsgen;
> >>  =20
> >> -	ret =3D rx_macro_register_mclk_output(rx);
> >> -	if (ret)
> >> -		goto err_clkout;
> >> -
> >>   	ret =3D devm_snd_soc_register_component(dev, &rx_macro_component_dr=
v,
> >>   					      rx_macro_dai,
> >>   					      ARRAY_SIZE(rx_macro_dai));
> >> @@ -3618,6 +3614,10 @@ static int rx_macro_probe(struct platform_devic=
e *pdev)
> >>   	pm_runtime_set_active(dev);
> >>   	pm_runtime_enable(dev);
> >>  =20
> >> +	ret =3D rx_macro_register_mclk_output(rx);
> >> +	if (ret)
> >> +		goto err_clkout;
> >> +
> >>   	return 0;
> >>  =20
> >>   err_clkout:
> >> diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpas=
s-tx-macro.c
> >> index 2ef62d6edc30..b9475ba55e20 100644
> >> --- a/sound/soc/codecs/lpass-tx-macro.c
> >> +++ b/sound/soc/codecs/lpass-tx-macro.c
> >> @@ -2036,10 +2036,6 @@ static int tx_macro_probe(struct platform_devic=
e *pdev)
> >>   	if (ret)
> >>   		goto err_fsgen;
> >>  =20
> >> -	ret =3D tx_macro_register_mclk_output(tx);
> >> -	if (ret)
> >> -		goto err_clkout;
> >> -
> >>   	ret =3D devm_snd_soc_register_component(dev, &tx_macro_component_dr=
v,
> >>   					      tx_macro_dai,
> >>   					      ARRAY_SIZE(tx_macro_dai));
> >> @@ -2052,6 +2048,10 @@ static int tx_macro_probe(struct platform_devic=
e *pdev)
> >>   	pm_runtime_set_active(dev);
> >>   	pm_runtime_enable(dev);
> >>  =20
> >> +	ret =3D tx_macro_register_mclk_output(tx);
> >> +	if (ret)
> >> +		goto err_clkout;
> >> +
> >>   	return 0;
> >>  =20
> >>   err_clkout:
> >> diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpas=
s-va-macro.c
> >> index b0b6cf29cba3..1623ba78ddb3 100644
> >> --- a/sound/soc/codecs/lpass-va-macro.c
> >> +++ b/sound/soc/codecs/lpass-va-macro.c
> >> @@ -1524,16 +1524,6 @@ static int va_macro_probe(struct platform_devic=
e *pdev)
> >>   	if (ret)
> >>   		goto err_mclk;
> >>  =20
> >> -	ret =3D va_macro_register_fsgen_output(va);
> >> -	if (ret)
> >> -		goto err_clkout;
> >> -
> >> -	va->fsgen =3D clk_hw_get_clk(&va->hw, "fsgen");
> >> -	if (IS_ERR(va->fsgen)) {
> >> -		ret =3D PTR_ERR(va->fsgen);
> >> -		goto err_clkout;
> >> -	}
> >> -
> >>   	if (va->has_swr_master) {
> >>   		/* Set default CLK div to 1 */
> >>   		regmap_update_bits(va->regmap, CDC_VA_TOP_CSR_SWR_MIC_CTL0,
> >> @@ -1560,6 +1550,16 @@ static int va_macro_probe(struct platform_devic=
e *pdev)
> >>   	pm_runtime_set_active(dev);
> >>   	pm_runtime_enable(dev);
> >>  =20
> >> +	ret =3D va_macro_register_fsgen_output(va);
> >> +	if (ret)
> >> +		goto err_clkout;
> >> +
> >> +	va->fsgen =3D clk_hw_get_clk(&va->hw, "fsgen");
> >> +	if (IS_ERR(va->fsgen)) {
> >> +		ret =3D PTR_ERR(va->fsgen);
> >> +		goto err_clkout;
> >> +	}
> >> +
> >>   	return 0;
> >>  =20
> >>   err_clkout:
> >> diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpa=
ss-wsa-macro.c
> >> index 5cfe96f6e430..c0b86d69c72e 100644
> >> --- a/sound/soc/codecs/lpass-wsa-macro.c
> >> +++ b/sound/soc/codecs/lpass-wsa-macro.c
> >> @@ -2451,11 +2451,6 @@ static int wsa_macro_probe(struct platform_devi=
ce *pdev)
> >>   	if (ret)
> >>   		goto err_fsgen;
> >>  =20
> >> -	ret =3D wsa_macro_register_mclk_output(wsa);
> >> -	if (ret)
> >> -		goto err_clkout;
> >> -
> >> -
> >>   	ret =3D devm_snd_soc_register_component(dev, &wsa_macro_component_d=
rv,
> >>   					      wsa_macro_dai,
> >>   					      ARRAY_SIZE(wsa_macro_dai));
> >> @@ -2468,6 +2463,10 @@ static int wsa_macro_probe(struct platform_devi=
ce *pdev)
> >>   	pm_runtime_set_active(dev);
> >>   	pm_runtime_enable(dev);
> >>  =20
> >> +	ret =3D wsa_macro_register_mclk_output(wsa);
> >> +	if (ret)
> >> +		goto err_clkout;
> >> +
> >>   	return 0;
> >>  =20
> >>   err_clkout:
> >> --=20
> >> 2.21.0
> >=20

