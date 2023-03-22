Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F856C47D8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 11:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjCVKlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 06:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjCVKlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 06:41:46 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5E961304
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 03:41:45 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id l27so8178637wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 03:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679481704;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=skDnyQLe1JXdCg1sNQHqpeJHAlfAsnOpU7qQyP4hHOg=;
        b=GSamitR5gd+/UzbyXSgYPJV7PmQ5ceiqB2gRsLSYfgDBbvjxo2QYvkSXKnM5bEzeSD
         B7qXr4fCsv+cghc+QYyE/3ZBGrikeib607wQYkwUA47N5hn21hj8KNbODFSyOaowLCmt
         HPHZBYlYCXTcUyVZ51+0NsjdpDgw7A/Tw/Y8OL9NlKo6n2sc0ETcGhA3FBmN7xAfKzNU
         KUllCOt9xplQPWUCSboOZAIt8Hya1qLXR85iWUcCUu5sBpXnug3XV3C3hAgfzRUbLSQj
         KJlYcQsLqyxICGLivSBKQIgkLAnul/X98QbqzEz7QGxQnLBuY/Vieh5YC+LIVRXfF01E
         THBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679481704;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=skDnyQLe1JXdCg1sNQHqpeJHAlfAsnOpU7qQyP4hHOg=;
        b=RLIrozHVidSqrwZouwsHF2EqE9p/M/MjEvQj3khr4FvkS7X3RBEXxMhRTMXKKM3ce0
         to2tZmEhQna4+9IwORIVNAvYuKU7/aK2Mn5mDwltuHms0+UDHXzJvHP7T/dgsMtirYZ4
         q5oKN62Wp3hD00sI9C+8NLlq3VMum+8yZbIRmoKVkTdY7rvlToX5QlWrgoCvWv9wpUOH
         2j5elhOtoqJCapTRwY3ZCCuq8aLF17YtdJBwoNnPXls5B+QuqmXIKuPcPx6yGDsSSBX4
         /+1uyufTqQOs7HDaG1JpLusSxCpi0HlO3MYzWstYNWTWy0dvF/wB9AtAhfYXE0QF+XJQ
         jv9Q==
X-Gm-Message-State: AO0yUKWe1XVA+v8DjGtFZ6H/66b/BDJsgmeqLAcAbD+gKzf7TbNP8Lko
        H3jozWUifKY4azquGRISfzM/qkKIu+UgiO7JNcaOnVf4JU8sSr+2
X-Google-Smtp-Source: AK7set8wAPw5tK+KOLu3l95YMhBqfO34Pi6ONEtsWZgiwe84T8NwsFpmq2fBkotWjwqz/Ud4m6hn17Aj50DyVc2GhAM=
X-Received: by 2002:a5d:6641:0:b0:2d0:58f9:a69 with SMTP id
 f1-20020a5d6641000000b002d058f90a69mr1153282wrw.4.1679481704118; Wed, 22 Mar
 2023 03:41:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230321190118.3327360-1-bhupesh.sharma@linaro.org>
 <20230321190118.3327360-3-bhupesh.sharma@linaro.org> <ZBoVzFTr8LBWsmrX@gerhold.net>
In-Reply-To: <ZBoVzFTr8LBWsmrX@gerhold.net>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Wed, 22 Mar 2023 16:11:32 +0530
Message-ID: <CAH=2NtyJHGcfhWMdUmJ=38kC-CjP7jznQEU7jX+983hdEJs4-A@mail.gmail.com>
Subject: Re: [PATCH 2/5] arm64: dts: qcom: sm6115: Add Crypto Engine support
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andersson@kernel.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2023 at 02:09, Stephan Gerhold <stephan@gerhold.net> wrote:
>
> On Wed, Mar 22, 2023 at 12:31:15AM +0530, Bhupesh Sharma wrote:
> > Add crypto engine (CE) and CE BAM related nodes and definitions to
> > 'sm6115.dtsi'.
> >
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sm6115.dtsi | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > index c56738633431..b2d2cdde41fa 100644
> > --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > @@ -664,6 +664,32 @@ usb_1_hsphy: phy@1613000 {
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
> > +                     iommus = <&apps_smmu 0x84 0x11>,
> > +                              <&apps_smmu 0x86 0x11>,
> > +                              <&apps_smmu 0x94 0x11>,
> > +                              <&apps_smmu 0x96 0x11>;
> > +             };
> > +
> > +             crypto: crypto@1b3a000 {
> > +                     compatible = "qcom,sm6115-qce", "qcom,sm8150-qce", "qcom,qce";
> > +                     reg = <0x0 0x01b3a000 0x0 0x6000>;
> > +                     dmas = <&cryptobam 6>, <&cryptobam 7>;
> > +                     dma-names = "rx", "tx";
> > +                     iommus = <&apps_smmu 0x84 0x11>,
> > +                              <&apps_smmu 0x86 0x11>,
> > +                              <&apps_smmu 0x94 0x11>,
> > +                              <&apps_smmu 0x96 0x11>;
>
> If you apply the 0x11 mask to the stream ID then the last two items here
> are identical to the first two (0x94 & ~0x11 = 0x84). Why are they
> needed? They look redundant to me.

Thanks, I will check them out and fix them in v2.

Regards.
