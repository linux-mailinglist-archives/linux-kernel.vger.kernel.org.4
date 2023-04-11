Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7FD6DDE48
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjDKOmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjDKOmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:42:04 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732F230D0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:42:02 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id dg15so33954460vsb.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1681224121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0IsUqzAOOGwTdW6oKTQYTYQ5rspex3tOJ/uzBmQs6E4=;
        b=m67XMiBjyE3LGndoYzB34x0EN0by382QLFad3fSrEBAfHC1Y1WMZ6keTHWmp9WJgXr
         JKscIfMjwcVQhjeq3BE359R9ISZ+NRUl8RoVQSYQL7GJ3AlYEsS1Nrqz9vNQvyRFMQ7d
         R2kAd04SmmVwd2yCelv7dr9h5y/MWOuA/OqYkr7nX0CTYo50QHcDmxuzNpQBE8nSv6xK
         5fV5HCu9aLJLa8iWTNfegA4tAIawXp2LFCBwAK4ZnyszQ7gYkywcoH302ircJq1aqUjP
         F5L3FjuFkOSrdpTkkhS1r3UhVTmIekMMQEsT4goBX8K3AQ87VtvGrkZooWkwaS33VEJ7
         bwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681224121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0IsUqzAOOGwTdW6oKTQYTYQ5rspex3tOJ/uzBmQs6E4=;
        b=yOUWGDhtRPoEDePZjb5OktE9Pzz7+b8QskUarSFcFYNVlWdS8Q18F1fdGDMa1CswrO
         LH5jh0JXUbYZPvH2UEWufMvBxt47LViaHlxwy7Lydd1qXHdwHaYa4375rEuQBuSkYQLv
         zEv+tQ4lTKwR26vqCFFQ48BvE9c/1WBrUqdUyOdxzFRuDuhZCrN0yXbOrOVoF2wWEFCK
         NQTvkX6BALeFMMDlMO2/k4HRFfMrVMoRcEC9A++xa+lyoEfZmi9NbiK/ayOWYxbrknXD
         iynZ7ccn8tmQjtUOyiDaciGMPFtXDoxdhbCqeda3HosMCI9YWbY5JqUD7I4DGdc0jPyx
         6L8g==
X-Gm-Message-State: AAQBX9fP2FLNXpEDjDqROhFKuZrsnqQhqeN0Y8yYQWZ6gbSgktljyhoy
        NbTZLgWbNhPcHX7NORHde0y8t9HtqVLAXV6RVXZfbpso9u0ny+J77iE=
X-Google-Smtp-Source: AKy350a1MTHqScxDS1gDZ+TEOp6sZEA+LrjI4KfWxPLlXutjQPKll5t0VC5GNPpg/ojsniiIfjxnn+OWFZwBml1l9PA=
X-Received: by 2002:a67:e0c4:0:b0:42c:515f:4a48 with SMTP id
 m4-20020a67e0c4000000b0042c515f4a48mr5688372vsl.0.1681224121594; Tue, 11 Apr
 2023 07:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230411125910.401075-1-brgl@bgdev.pl> <20230411125910.401075-8-brgl@bgdev.pl>
 <6c75d434-bb5d-278f-a125-d096fd6b387d@linaro.org>
In-Reply-To: <6c75d434-bb5d-278f-a125-d096fd6b387d@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 11 Apr 2023 16:41:50 +0200
Message-ID: <CAMRc=MdLckYzUjDQzbNUaaviuABEDXcs0ctW6+-3fZiCbvfYQA@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] arm64: dts: qcom: sa8775p: add the GPU IOMMU node
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 3:16=E2=80=AFPM Konrad Dybcio <konrad.dybcio@linaro=
.org> wrote:
>
>
>
> On 11.04.2023 14:59, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Add the Adreno GPU IOMMU for sa8775p-based platforms.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 37 +++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dt=
s/qcom/sa8775p.dtsi
> > index 191b510b5a1a..11f3d80dd869 100644
> > --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> > @@ -7,6 +7,7 @@
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >  #include <dt-bindings/clock/qcom,rpmh.h>
> >  #include <dt-bindings/clock/qcom,sa8775p-gcc.h>
> > +#include <dt-bindings/clock/qcom,sa8775p-gpucc.h>
> >  #include <dt-bindings/interconnect/qcom,sa8775p-rpmh.h>
> >  #include <dt-bindings/power/qcom-rpmpd.h>
> >  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> > @@ -605,6 +606,42 @@ gpucc: clock-controller@3d90000 {
> >                       #power-domain-cells =3D <1>;
> >               };
> >
> > +             adreno_smmu: iommu@3da0000 {
> > +                     compatible =3D "qcom,sa8775p-smmu-500", "qcom,adr=
eno-smmu",
> > +                                  "arm,mmu-500";
> Err.. does it even boot like this? You dropped the qcom,smmu-500 compatib=
le
> which means it's getting bound to the generic SMMU driver (without
> QC quirks). If that was a mistake, you should have had all 4
>
> "qcom,sa8775p-smmu-500", qcom,adreno-smmu, "qcom,smmu-500", "arm,mmu-500"
>
> Without falling into the qc-specific codepaths, the Adreno compat does
> nothing.
>

I did that initially, then noticed dtbs_check fails because the
existing adreno GPUs implementing "arm,smmu-500" expect three
compatibles like in this commit. I did that and the driver still
probed the same so I assumed all's good. You're right of course, the
adreno impl is not being assigned without "qcom,smmu-500". Are the
bindings wrong in this case and should it be something like the
following?

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index d966dc65ce10..cd1b052a7242 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -84,6 +84,7 @@ properties:
               - qcom,sm8150-smmu-500
               - qcom,sm8250-smmu-500
           - const: qcom,adreno-smmu
+          - const: qcom,smmu-500
           - const: arm,mmu-500
       - description: Qcom Adreno GPUs implementing "arm,smmu-v2"
         items:

Bartosz

> Konrad
> > +                     reg =3D <0x0 0x03da0000 0x0 0x20000>;
> > +                     #iommu-cells =3D <2>;
> > +                     #global-interrupts =3D <2>;
> > +                     dma-coherent;
> > +                     power-domains =3D <&gpucc GPU_CC_CX_GDSC>;
> > +                     clocks =3D <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
> > +                              <&gcc GCC_GPU_SNOC_DVM_GFX_CLK>,
> > +                              <&gpucc GPU_CC_AHB_CLK>,
> > +                              <&gpucc GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK>,
> > +                              <&gpucc GPU_CC_CX_GMU_CLK>,
> > +                              <&gpucc GPU_CC_HUB_CX_INT_CLK>,
> > +                              <&gpucc GPU_CC_HUB_AON_CLK>;
> > +                     clock-names =3D "gcc_gpu_memnoc_gfx_clk",
> > +                                   "gcc_gpu_snoc_dvm_gfx_clk",
> > +                                   "gpu_cc_ahb_clk",
> > +                                   "gpu_cc_hlos1_vote_gpu_smmu_clk",
> > +                                   "gpu_cc_cx_gmu_clk",
> > +                                   "gpu_cc_hub_cx_int_clk",
> > +                                   "gpu_cc_hub_aon_clk";
> > +                     interrupts =3D <GIC_SPI 673 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 674 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 678 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 679 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 680 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 681 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 682 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 683 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 684 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 685 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 686 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 687 IRQ_TYPE_LEVEL_HIGH>;
> > +             };
> > +
> >               pdc: interrupt-controller@b220000 {
> >                       compatible =3D "qcom,sa8775p-pdc", "qcom,pdc";
> >                       reg =3D <0x0 0x0b220000 0x0 0x30000>,
