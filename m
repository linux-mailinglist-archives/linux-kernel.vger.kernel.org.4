Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D248651000
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 17:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiLSQMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 11:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiLSQMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 11:12:07 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9952A195
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 08:12:03 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1447c7aa004so12037865fac.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 08:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=opNyEy4Hga2S+HSZGwYoo4n70oAUrhY/I95QJwBLXGw=;
        b=GLXF0a9hN4NDrxSiyquzet3CYHgBek4M8xB9NgCoRur+3SiWUQ7U0TpQ80vS2Ey3yF
         7Z9I/KAw6ATX613YDJ3PomP8p4XMs41nnalAMwU6+QkQFUhMm8vvsM/K4MpnHj4V1b0x
         +YaWd5cjgjBFDIyenlffSYdjzvSma6xkeJIJvjxWrd9sI8mBIlSsddTfnkbhYVUCIDzB
         Lw7vc0hRHHp2zRSkxqQG/nmlTh1KEbHJdzruUiUK2ggEdHmzJdhNBQQ55yhkimSIbzcJ
         ORq78PFUdH2Oq9tfhYAjIghbEMkSxUcC+jVPPGxbu/HWGDnWbImG5UrI6v8+r37GhsdB
         tXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=opNyEy4Hga2S+HSZGwYoo4n70oAUrhY/I95QJwBLXGw=;
        b=NMUoX65mDS+Yl2I9jNTjirOsnm2XEh1ro7Z73nDjqOPi9foCSt9lQbNyAUzHvJj9ap
         +nRNfg9ac2jVK6wAr4pZxn9f5M+nIhEidEbM4di5hRgyUIx/2PH1ECZrj+bdInminzaR
         mSZCliyp4bFVN5PcxAdx6y3rI80JfvsrriNOj7Y7y4IQGn1oMCAr8/BMin+ORKv3e5pK
         a2GMVDWwusZ/vJTMmPytPZU9+RiG1eQ1iZj+jNZ3lZqnRjRJyG2f2vSgXq34BdIQrxjj
         0T6Lqkda/Rz353lLPLo9WYs82Ev6i0PiAZ87ZX3A0GVs5gi3pD4Y8ekR5bZjVfsWBVvj
         9s6A==
X-Gm-Message-State: AFqh2kqeibctlIzCYg6LYugs5+7ZtyZjWkFOjWiX6WMU9ObGPc3CWmJ4
        2GPFJfFD9g8vq163dtc3lkBrywzvRlquMTzbnWxxQg==
X-Google-Smtp-Source: AA0mqf55kS80V69FV3FbQLl+xTi2OHqecJQT7VNkb/GHotEghsH04avx+8ln6J+VXS2w3SXe+3JAgEmw1jbdGZgvIyg=
X-Received: by 2002:a05:6870:9e4c:b0:13c:33d0:22e2 with SMTP id
 pt12-20020a0568709e4c00b0013c33d022e2mr1717322oab.14.1671466323100; Mon, 19
 Dec 2022 08:12:03 -0800 (PST)
MIME-Version: 1.0
References: <20221205163754.221139-1-robert.foss@linaro.org>
 <20221205163754.221139-11-robert.foss@linaro.org> <853d49f9-cd97-e8a0-53fd-9f673c2720a1@linaro.org>
In-Reply-To: <853d49f9-cd97-e8a0-53fd-9f673c2720a1@linaro.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 19 Dec 2022 17:11:52 +0100
Message-ID: <CAG3jFysRXykUgOqRiPVYSRtjQ5Rfj+DQQqPzhzA8j9B9LToj5g@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] arm64: dts: qcom: sm8350-hdk: Enable display &
 dsi nodes
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run,
        airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        quic_kalyant@quicinc.com, angelogioacchino.delregno@somainline.org,
        loic.poulain@linaro.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, vkoul@kernel.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>,
        vinod.koul@linaro.org, quic_jesszhan@quicinc.com,
        andersson@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Dec 2022 at 17:44, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 05/12/2022 18:37, Robert Foss wrote:
> > Enable the display subsystem and the dsi0 output for
> > the sm8350-hdk board.
> >
> > Signed-off-by: Robert Foss <robert.foss@linaro.org>
> > ---
> >   arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 22 ++++++++++++++++++++++
> >   1 file changed, 22 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> > index e6deb08c6da0..39462c659c58 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> > +++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> > @@ -213,10 +213,32 @@ &cdsp {
> >       firmware-name = "qcom/sm8350/cdsp.mbn";
> >   };
> >
> > +&dispcc {
> > +     status = "okay";
> > +};
> > +
> > +&dsi0 {
>
> Bjorn suggested using mdss_dsi0 / mdss_dsi0_phy labels for DSI host and
> PHY, as it allows us to group them nicely. WDYT?

Sounds quite reasonable, fixing it in dts/dtsi/binding.

>
> > +     vdda-supply = <&vreg_l6b_1p2>;
> > +     status = "okay";
> > +};
> > +
> > +&dsi0_phy  {
> > +     vdds-supply = <&vreg_l5b_0p88>;
> > +     status = "okay";
> > +};
> > +
> >   &gpi_dma1 {
> >       status = "okay";
> >   };
> >
> > +&mdss {
> > +     status = "okay";
> > +};
> > +
> > +&mdss_mdp {
> > +     status = "okay";
> > +};
> > +
> >   &mpss {
> >       status = "okay";
> >       firmware-name = "qcom/sm8350/modem.mbn";
>
> --
> With best wishes
> Dmitry
>
