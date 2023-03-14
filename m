Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54F26B8D0E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjCNIVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjCNIUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:20:53 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4B5903A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:20:03 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id n17so3086603uaj.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678782002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bF78zWHqqUKIbB+xlRsQAspCq+3mase5H2df6Yb8uE=;
        b=uO/M/lBFzN1NhnakSxMnQma72lpAmMuuAKbc8WB8FwmzTOwnC15y+R2JfuPRVdj5lW
         r0w3HLjzR1vGn3hMmiutkqxU+jSim+s7vFF0HHFiIWjdFWYjpKnvEw2yGAaanstNyam1
         6ahdLW6dDps/loVFTDENGciMnrd306PI7gLVaX8PqXwfVTIA+Uz8cK2LuD5AUUbVGGGJ
         VfIk99CslB97vA/iAdK1p47QGLK4jP+p1ijwMeaA4+1kiHB3z2ca5EDfD0vgpbHem0e+
         cpwG6k6kNnfPrPCbM7R2pBvnBtAXo4/tFiNuCc50B2LV5ZpEid5s7QNEF4e/4NRyjVLr
         r2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678782002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bF78zWHqqUKIbB+xlRsQAspCq+3mase5H2df6Yb8uE=;
        b=r1tibcwFSHqzS+WUoobUIxeZAG3vP2Oyg4z82hcKEP1fz/kf5cenWwKiilKkzjIyv5
         a6loLW/2zOb65FkS5z/+oHyAIvLjQFkkP0y6HXR/tEJznTfVt7uJY7J95d1HVRJs4EnB
         jsuJlSD/A0C7Hwe4vdsUlmjZBg/zFx3R71Ld/6ITKkUVUtvDB18yRpXomKB6ClrZkp8M
         oQO/GCNxubo9Rr2NBIc4ZIDw9I0Su5fb5y6V3Gfo1zfKcbVJjq7xWMMt7Z98zS1aFECs
         wmVSyWOde97JkPWQBVSyiYZ96LdjXrfi4Y5dBDWT3BG2w29yY1x0fUEZMFGLwN5cmO/L
         32dg==
X-Gm-Message-State: AO0yUKV0dm4CX7B+veD/CtCPDOl/hzKRjSEUc1DU3Cg2WAOjAvCIaOKQ
        4yUNeWGI1Xe56qDp4Pd8YPDw/Ww16I1+dqc/PFPltw==
X-Google-Smtp-Source: AK7set88xziaapI3MIwlyigAiRg99oEfYMDSpfr79hKFVygFT4iuLDdkEALMtXXIR3k9yA5C5Nzwe8mAVzlvww6R6yw=
X-Received: by 2002:ab0:14c5:0:b0:67a:2833:5ceb with SMTP id
 f5-20020ab014c5000000b0067a28335cebmr8399660uae.0.1678782002582; Tue, 14 Mar
 2023 01:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230214092713.211054-1-brgl@bgdev.pl> <20230214092713.211054-3-brgl@bgdev.pl>
 <a2cad9e8-53a7-3a1e-1c40-b360ed1c1b08@quicinc.com>
In-Reply-To: <a2cad9e8-53a7-3a1e-1c40-b360ed1c1b08@quicinc.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 14 Mar 2023 09:19:51 +0100
Message-ID: <CAMRc=Mf=3wuCL4rWYoeWyL8eHe8nuWEB__jTeEPmdO56oVQ46w@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: add initial support for qcom sa8775p-ride
To:     Shazad Hussain <quic_shazhuss@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 7:26=E2=80=AFAM Shazad Hussain
<quic_shazhuss@quicinc.com> wrote:
>
>
>
> On 2/14/2023 2:57 PM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > This adds basic support for the Qualcomm sa8775p platform and the
> > reference board: sa8775p-ride. The dt files describe the basics of the
> > SoC and enable booting to shell.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > ---
> >   arch/arm64/boot/dts/qcom/Makefile         |   1 +
> >   arch/arm64/boot/dts/qcom/sa8775p-ride.dts |  47 ++
> >   arch/arm64/boot/dts/qcom/sa8775p.dtsi     | 805 +++++++++++++++++++++=
+
> >   3 files changed, 853 insertions(+)
> >   create mode 100644 arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> >   create mode 100644 arch/arm64/boot/dts/qcom/sa8775p.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qc=
om/Makefile
> > index 31aa54f0428c..b63cd1861e68 100644
> > --- a/arch/arm64/boot/dts/qcom/Makefile
> > +++ b/arch/arm64/boot/dts/qcom/Makefile
> > @@ -75,6 +75,7 @@ dtb-$(CONFIG_ARCH_QCOM)     +=3D qru1000-idp.dtb
> >   dtb-$(CONFIG_ARCH_QCOM)     +=3D sa8155p-adp.dtb
> >   dtb-$(CONFIG_ARCH_QCOM)     +=3D sa8295p-adp.dtb
> >   dtb-$(CONFIG_ARCH_QCOM)     +=3D sa8540p-ride.dtb
> > +dtb-$(CONFIG_ARCH_QCOM)      +=3D sa8775p-ride.dtb
> >   dtb-$(CONFIG_ARCH_QCOM)     +=3D sc7180-idp.dtb
> >   dtb-$(CONFIG_ARCH_QCOM)     +=3D sc7180-trogdor-coachz-r1.dtb
> >   dtb-$(CONFIG_ARCH_QCOM)     +=3D sc7180-trogdor-coachz-r1-lte.dtb
> > diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boo=
t/dts/qcom/sa8775p-ride.dts
> > new file mode 100644
> > index 000000000000..3adf7349f4e5
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> > @@ -0,0 +1,47 @@
> > +// SPDX-License-Identifier: BSD-3-Clause
> > +/*
> > + * Copyright (c) 2023, Linaro Limited
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "sa8775p.dtsi"
> > +
> > +/ {
> > +     model =3D "Qualcomm SA8775P Ride";
> > +     compatible =3D "qcom,sa8775p-ride", "qcom,sa8775p";
> > +
> > +     aliases {
> > +             serial0 =3D &uart10;
> > +     };
> > +
> > +     chosen {
> > +             stdout-path =3D "serial0:115200n8";
> > +     };
> > +};
> > +
> > +&qupv3_id_1 {
> > +     status =3D "okay";
> > +};
> > +
> > +&sleep_clk {
> > +     clock-frequency =3D <32764>;
> > +};
> > +
> > +&tlmm {
> > +     qup_uart10_default: qup-uart10-state {
> > +             pins =3D "gpio46", "gpio47";
> > +             function =3D "qup1_se3";
> > +     };
> > +};
>
> Can we keep &tlmm at the end ? As this would be expanding.
>

The overridden nodes are ordered alphabetically. Why would expanding
them be a reason to put it at the end?

Bart

[...]
