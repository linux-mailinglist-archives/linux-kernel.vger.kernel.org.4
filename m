Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBF06F3CC7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 06:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbjEBEnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 00:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjEBEnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 00:43:18 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5283F30CF
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 21:43:16 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-2fddb442d47so2998180f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 21:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683002595; x=1685594595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tA1FfDhaYIxyn0VxdWW674rRwqunc0w4xTIHodrHzwY=;
        b=dvJMlvH0bFWESLjAbcfx4zNKXrf57LuLGi61CzMOE2B60X4jn+bcILY/MVjJ0DlDos
         ItGCbtyYtAZCp//bwwBDivKjkH3AI3k/78g82f2b6srg8pDRf+c1R5vd1Otm/iiGs3EL
         7C7Dh1fIiBE/QI/OU2//ANNGcf1TLx446pY+eMMZoWkbMOGJRtCZpIfk2uQQ8qvb0CM7
         ctxYb0AWA4bOtiw8e6euiqxy0M7ymkdoefi5GijJGrheAl0IyRdJCGcYN8X5cDdSygch
         vKSbpafFDdX6XaoaA1mvb3Whc4KVmKgA7sQ4eBmMmyFVdjuJhQS6uwX2jDOeZosz3Pwr
         ejmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683002595; x=1685594595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tA1FfDhaYIxyn0VxdWW674rRwqunc0w4xTIHodrHzwY=;
        b=C7ZlXAgPw5V7QmmcLTjnXc0qbC5bLR6WpQNBmXzPTdFLH+RsSMh349dwh5EeaEuHrT
         n9s5+IijQK6OCpb+MEYqtp6qDtiJA11SuNc755yYGBiezekcVxO7Xr7l5LBf3+E/vEcE
         V9ax6Z4oAEQXQYZvEbrRlshxLkKPOdg9Zgr+8ISZGyxcAzaxYlbPqQm9YUkoejOh0kTw
         gfpL2PQWXpanprnhwgtv1ivRYHdj2KZBQt8rw5Zxjmw8Ip74CSvkf7nWkNBF6ac0LLFH
         VOs0RHgg7lIJ/v0XyXcQwfXqKUDncxYM0O2v5zXnZgA9Oo/ihFvj/0MlH/M/W8z2KE2s
         6kmw==
X-Gm-Message-State: AC+VfDw+KYhPXsDPKntgJP9yT/+7lJUiufDz20MGNpBgsfTWCwwQ9wkk
        LgVptr6CXk+AyJUXN4glyp1kE87yJG7KBxOtlIa+LA==
X-Google-Smtp-Source: ACHHUZ7S82hfGUV9NeXNSbEN4gy+ZPnKp7H1xFs9706sWyoci8/jfrvdCz4olCPDuCiPEnKktFLWwFqWMqYBk5OBqGo=
X-Received: by 2002:adf:df8c:0:b0:306:3489:2615 with SMTP id
 z12-20020adfdf8c000000b0030634892615mr1121956wrl.40.1683002594725; Mon, 01
 May 2023 21:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230501192432.1220727-1-bhupesh.sharma@linaro.org>
 <20230501192432.1220727-4-bhupesh.sharma@linaro.org> <82e61752-dc76-9714-d2e1-13962c4217ee@linaro.org>
In-Reply-To: <82e61752-dc76-9714-d2e1-13962c4217ee@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Tue, 2 May 2023 10:13:03 +0530
Message-ID: <CAH=2Ntx4tpJPdh-UHH6urZi4X67sNW8=OYprxi2hi-KX+2w91A@mail.gmail.com>
Subject: Re: [PATCH v9 3/4] arm64: dts: qcom: sm6115: Add USB SS qmp phy node
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, konrad.dybcio@linaro.org, kishon@kernel.org,
        vkoul@kernel.org, krzysztof.kozlowski+dt@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 May 2023 at 05:48, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 01/05/2023 22:24, Bhupesh Sharma wrote:
> > Add USB superspeed qmp phy node to dtsi.
> >
> > Make sure that the various board dts files (which include sm4250.dtsi file)
> > continue to work as intended.
> >
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >   .../boot/dts/qcom/sm4250-oneplus-billie2.dts  |  3 ++
> >   arch/arm64/boot/dts/qcom/sm6115.dtsi          | 29 +++++++++++++++++--
> >   .../boot/dts/qcom/sm6115p-lenovo-j606f.dts    |  3 ++
> >   3 files changed, 33 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> > index a1f0622db5a0..75951fd439df 100644
> > --- a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> > +++ b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> > @@ -242,6 +242,9 @@ &usb {
> >   &usb_dwc3 {
> >       maximum-speed = "high-speed";
> >       dr_mode = "peripheral";
> > +
> > +     phys = <&usb_hsphy>;
> > +     phy-names = "usb2-phy";
> >   };
> >
> >   &usb_hsphy {
> > diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > index 631ca327e064..21d00b0295a1 100644
> > --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > @@ -661,6 +661,31 @@ usb_hsphy: phy@1613000 {
> >                       status = "disabled";
> >               };
> >
> > +             usb_qmpphy: phy@1615000 {
> > +                     compatible = "qcom,sm6115-qmp-usb3-phy";
> > +                     reg = <0x0 0x01615000 0x0 0x200>;
>
> I replied with R-B, but then I noticed that the length of the region is
> bad. What is the maximum offset that is used by the driver? I know that
> it is bigger than 0x200.

Sure, let me recheck and fix this in the next version.

Thanks,
Bhupesh
