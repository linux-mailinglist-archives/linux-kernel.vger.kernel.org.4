Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A867094B4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 12:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbjESKW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 06:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbjESKWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 06:22:49 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D060010C3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:22:45 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f450815d0bso29739495e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684491764; x=1687083764;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vos6vt5BS4/XYeWH6r4wBT3sD7a/Mu3b1rL5AWSUIyc=;
        b=zvzQZJFrb6oSGwy04xhouMY/dwjvf6Ni+outoTs3WPM/su4qbg5jfqZ9Ud5HrEwUGU
         0md11nEmqTgE66PCfjcTR9y4zmAKk5h/wahbydQvJArnA2QsFFQMlDQSUtBhIvDxgnCy
         OT64vCwMkDCFhdleOHfOnoFOX+XQr6hgH6Elkc0yxNHb5m9zuVYCaDxsTghqs6UV3s7/
         e0SCp0WmtrGL2TBxjT2OUy6r6resja0f3Z9wT6gCbNubcJnDfwBFj1F1tll939WFp7gV
         Ph2mpCwwfpCevEhnQxszUmkazo3ccpwXhnLSH4RjBfCEvey8eQDLa1V5iE7QqNbX35tG
         FEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684491764; x=1687083764;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vos6vt5BS4/XYeWH6r4wBT3sD7a/Mu3b1rL5AWSUIyc=;
        b=VyzF5YoHABMDHllZnX5unzmhbPSZLmoJeE6VtiAVSlmBsZGu99nJj8hJF8sDbe2bFU
         O5x3I1JUjGEa5rkpxi/nhL4JGHeg7852aUelPjn+S64dQnY4YY1QKUxevJqocpxD4B4d
         n38ym/Dr6meju5iBonugAJjKiN6tDvvXxNfPiFF79gkXp7+2pbrSIooeVTIUpEwwMJXE
         nN38ZPO7Jkw7dbSgeQdquu8cdGNlvGrZzZYvYl6MYPErrNGuPonFNfikiLyET87vkaYY
         E+VS6K8eUsFB/p/m16Xk8xljCeP6xPcbj6sNEYMTaGiFQC+wG/SvrbN2rThR8jBV9GYv
         +UEA==
X-Gm-Message-State: AC+VfDzk0vnUNTJoiOfdQNuqONSH5f/ZGFAkGDzHDzlu9MK1UjPNBCkY
        7eaJrSDBsk3diirAzlf6Al9zK0NlZnUpgsINb5nw3XAgOOpZTp0N
X-Google-Smtp-Source: ACHHUZ6vRDGZhwrqmLqjDvWeD6HWjxwxm0aXo54EkY10Lk264m027KeqfdyrszY2jPj4S1mOezbHoAT4r5KzdaduUKI=
X-Received: by 2002:a1c:f402:0:b0:3f4:23a4:7a93 with SMTP id
 z2-20020a1cf402000000b003f423a47a93mr1017546wma.25.1684491764154; Fri, 19 May
 2023 03:22:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230405072836.1690248-1-bhupesh.sharma@linaro.org>
 <20230405072836.1690248-8-bhupesh.sharma@linaro.org> <ZGdLCdSof027mk5u@gerhold.net>
In-Reply-To: <ZGdLCdSof027mk5u@gerhold.net>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Fri, 19 May 2023 15:52:32 +0530
Message-ID: <CAH=2Ntx4H+hOzYLWqiogdBGE+rQ2XayrweE_P8T8gVE0zbwzeg@mail.gmail.com>
Subject: Re: [PATCH v6 07/11] arm64: dts: qcom: sm6115: Add Crypto Engine support
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, konrad.dybcio@linaro.org,
        vladimir.zapolskiy@linaro.org, rfoss@kernel.org,
        neil.armstrong@linaro.org, djakov@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephan,

On Fri, 19 May 2023 at 15:40, Stephan Gerhold <stephan@gerhold.net> wrote:
>
> Hi Bhupesh,
>
> Not sure if this is the latest version of this series since it's pretty
> old but I didn't find a new one. Just came here because you mentioned
> RB1/RB2 [1] in my bam_dma patch and they don't have any BAM defined
> upstream yet.
>
> [1]: https://lore.kernel.org/linux-arm-msm/CAH=2Ntw0BZH=RGp14mYLhX7D6jV5O5eDKRQbby=uCy85xMDU_g@mail.gmail.com/
>
> On Wed, Apr 05, 2023 at 12:58:32PM +0530, Bhupesh Sharma wrote:
> > Add crypto engine (CE) and CE BAM related nodes and definitions to
> > 'sm6115.dtsi'.
> >
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sm6115.dtsi | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > index 2a51c938bbcb..ebac026b4cc7 100644
> > --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > @@ -650,6 +650,28 @@ usb_hsphy: phy@1613000 {
> >                       status = "disabled";
> >               };
> >
> > +             cryptobam: dma-controller@1b04000 {
> > +                     compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
> > +                     reg = <0x0 0x01b04000 0x0 0x24000>;
> > +                     interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
> > +                     #dma-cells = <1>;
> > +                     qcom,ee = <0>;
> > +                     qcom,controlled-remotely;
> > +                     num-channels = <8>;
> > +                     qcom,num-ees = <2>;
> > +                     iommus = <&apps_smmu 0x94 0x11>,
> > +                              <&apps_smmu 0x96 0x11>;
> > +             };
> > +
> > +             crypto: crypto@1b3a000 {
> > +                     compatible = "qcom,sm6115-qce", "qcom,sm8150-qce", "qcom,qce";
> > +                     reg = <0x0 0x01b3a000 0x0 0x6000>;
> > +                     dmas = <&cryptobam 6>, <&cryptobam 7>;
> > +                     dma-names = "rx", "tx";
> > +                     iommus = <&apps_smmu 0x94 0x11>,
> > +                              <&apps_smmu 0x96 0x11>;
>
> Shouldn't you have clocks = <&rpmcc RPM_SMD_CE1_CLK> here to make sure
> the clock for the crypto engine is on? Your binding patch (PATCH 06/11)
> says "Crypto Engine block on Qualcomm SoCs SM6115 and QCM2290 do not
> require clocks strictly" but doesn't say why.
>
> Make sure you don't rely on having rpmcc keep unused clocks on
> permanently. This is the case at the moment, but we would like to change
> this [2]. Adding new users that rely on this broken behavior would just
> make this effort even more complicated.
>
> If you also add the clock to the cryptobam then you should be able to
> see the advantage of my bam_dma patch [3]. It allows you to drop
> "num-channels" and "qcom,num-ees" from the cryptobam in your changes
> above because it can then be read directly from the BAM registers.

Thanks for pointing this out. Actually that's why I was using your
patch while testing with RB1/RB2 :)

Yes, so the background is that I am preparing a new version of this
crypto enablement patchset.
Also your assumption about the clocks being turned on by the firmware
is true for RB1/RB2 devices, so enabling them via Linux is optional as
per Qualcomm enggs.

So, I am testing the new patchset right now with 'clock' entries
provided in the .dtsi and see if that causes any issue / improvement
(etc.)

Will come back with updates (and a new version of this patchset) soon.

Regards,
Bhupesh

> Thanks,
> Stephan
>
> [2]: https://lore.kernel.org/linux-arm-msm/20230303-topic-rpmcc_sleep-v2-0-ae80a325fe94@linaro.org/
> [3]: https://lore.kernel.org/linux-arm-msm/20230518-bamclk-dt-v1-1-82f738c897d9@gerhold.net/
