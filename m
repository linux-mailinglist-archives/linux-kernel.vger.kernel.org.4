Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731B863C789
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 19:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235529AbiK2S4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 13:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236335AbiK2Szh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 13:55:37 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFEE68C6D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 10:55:11 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id u27so12461572lfc.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 10:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7i7xLaLGc79LQhOkqoCltEFokPDR1NnWcxiPD8dqrqM=;
        b=h6l+C6EGLfXNPNWLozZz3Kb1ThB5ZSqO8B7mBTY8eLoI+Tiq6wYTuBnkSPhLx5b1FI
         NmVs1HcsE4wF/yIfs7uyZCvSJebD7nO/A/QPO2Lvn3nXu+Na+laCJ+AiYdBI4k0sFrxz
         YJccbNprMQumAJvEjANCgCHmM1+MVHu5XSyoAJw32gA0Kcf2+xntjWsztj283SBfnEXD
         6EOk4chqm57FoFvIOLKhFYwzHqvPk2woXiKU9y1vrGb2DtrFqqccEjVWiBNiAMEHPgBb
         V5gYGwqupiSSh/PAOAi9tYVDWKU/EhvExUs5mRUDypUhCk4BLQkYDiaxe+eYUV+gCfVf
         11WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7i7xLaLGc79LQhOkqoCltEFokPDR1NnWcxiPD8dqrqM=;
        b=a54SwWCM/aAhcnZRxS9FyXh9j7Wcfn9nKY1xGozqWRG/YLMhZJd1wmp9D3m5KmcHLN
         58cwvSvalHF/v/Vloyn3bsdY3S8XnltEua3K0m1tLeyblFmAIzY+OSqtJN/h+9kGEcms
         Zo5gOkpIiDxj7aOnf2ZWFUkPJAYpclW9OYwNv3KiqPphrc/z+dzgDmRQKyzZc0M91KdS
         ljw/84s4Ao2UueSvfJSwnz9zjWOuuSNEBG1eu6SMRO1siHhY8KU7jo98DEAWeIXXbeEm
         ZdlmPOgCHMLaI6vkQ+CELOocmPxG1oNJizIBh0ZHT2Gkz3JYieE4d/5P5KlIImFRQv3q
         r+iQ==
X-Gm-Message-State: ANoB5pnMG62Fl36gbnwXFMLfhsCOsNCLyPDq4u+KvCG3rX4ofvX0PFeO
        Qk4ryRPVJW6JCcS8h3OAaF8TrJl1jnc4TkeDxKTlvQ==
X-Google-Smtp-Source: AA0mqf6Z/JK+9KigSFUS+aXUfMML/RKLi5QOLEzN/JEaOZjKN1mlBo67pp6CkV44w09gsepzyp2L+Dmmc8ew5dWreos=
X-Received: by 2002:a05:6512:34d0:b0:4a8:ebec:7140 with SMTP id
 w16-20020a05651234d000b004a8ebec7140mr19548194lfr.150.1669748109731; Tue, 29
 Nov 2022 10:55:09 -0800 (PST)
MIME-Version: 1.0
References: <20221128171215.1768745-1-bhupesh.sharma@linaro.org> <65c9cd0a-ef4e-5d38-3b15-0126b1eb7a7f@linaro.org>
In-Reply-To: <65c9cd0a-ef4e-5d38-3b15-0126b1eb7a7f@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Wed, 30 Nov 2022 00:24:58 +0530
Message-ID: <CAH=2Ntw-U1sLgbVxab7zAkFRHCnew6kYzLqqrqeUMtJJR8TmrQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sm6115: Add geni debug uart node for qup0
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, me@iskren.info,
        Bjorn Andersson <andersson@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Nov 2022 at 19:00, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 28.11.2022 18:12, Bhupesh Sharma wrote:
> > qup0 on sm6115 / sm4250 has 6 SEs, with SE4 as debug uart.
> > Add the debug uart node in sm6115 dtsi file.
> >
> > Cc: Bjorn Andersson <andersson@kernel.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> > - Based on linux-next.
> >
> >  arch/arm64/boot/dts/qcom/sm6115.dtsi | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > index 0340ed21be05..e4a2440ce544 100644
> > --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > @@ -649,6 +649,26 @@ ufs_mem_phy_lanes: phy@4807400 {
> >                       };
> >               };
> >
> > +             qupv3_id_0: geniqup@4ac0000 {
> > +                     compatible = "qcom,geni-se-qup";
> > +                     reg = <0x4ac0000 0x2000>;
> Please pad address to 8 hex digits, same below.

Sure, I will fix it in v2.

Thanks,
Bhupesh

> > +                     clock-names = "m-ahb", "s-ahb";
> > +                     clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
> > +                              <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
> > +                     #address-cells = <1>;
> > +                     #size-cells = <1>;
> > +                     ranges;
> > +
> > +                     uart4: serial@4a90000 {
> > +                             compatible = "qcom,geni-debug-uart";
> > +                             reg = <0x4a90000 0x4000>;
> > +                             clock-names = "se";
> > +                             clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
> > +                             interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>;
> > +                             status = "disabled";
> > +                     };
> > +             };
> > +
> >               usb_1: usb@4ef8800 {
> >                       compatible = "qcom,sm6115-dwc3", "qcom,dwc3";
> >                       reg = <0x04ef8800 0x400>;
