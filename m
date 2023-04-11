Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06EE6DE2C6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 19:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjDKRjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 13:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjDKRjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:39:19 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA43E65B9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 10:39:05 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id q5so5026389wmo.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 10:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681234744;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zYhbwOdBd3vMxKKBbYYrqI16ZcFTfZ8NDiAcQOEPvvg=;
        b=V5kjk/z8OjMoh8qlAAJbfNt/7r5VaoXEnhLYPoeAV7ijJHAcUNaA85q6iKLYfw7IHr
         u08GVN2wvrKwA9sy9iw+cb0HFnuAOTGp+qkHtfjkyXyfEKzUAMCBk7lPQ/x4633FK7P/
         xZCg4A+lWaNh2RZM0JlNUgS0Lr3tjCkZxKPNhdWLhGLh2DbOGDuqIoUIKr4y5w+jHBje
         LbmH5kgISlg1AGHC5UTsdLy+8fKEcPqiR7+p1TZQRKZxxyuwNeGkWwG64vVfTmdtE0V0
         eoDu0JS70rT5BbrPzIVxGF8sQzFhXHkd1Wgk+o0hUA/IPpenHiA50dK2wTon6bC9pjmp
         MiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681234744;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zYhbwOdBd3vMxKKBbYYrqI16ZcFTfZ8NDiAcQOEPvvg=;
        b=aH148eJn+Z6l/nKsyoN81TBVRprUwTr9w5mHYsPTId8bMUiiZObJ7So5k1YvJtOqww
         kD8tPbYP/AdLKoVdf99PMEf8UuTsVGve5KNtDB3UdKehISOlB9gkgsBHCmmFblgfuUhK
         S0wNxqRjq546TuMYye0fY8vvSFh0h30yw6bKxs87MLmNQ006faKi6GYDvjlEIJ7bI3fs
         bXIotoe0TPj2+JiedTs81aYhd0SYPZGlb1hmroldKSNJxqRmYs1MhIx53YK5NCTh/nXO
         p6ISN194LpLr/a905cxxNrqCMVktvLyBhCJQC12hOv++EO1CcYzEe/HWpm43D7FAlc99
         bZPQ==
X-Gm-Message-State: AAQBX9dly6YPa/3ET36gAG2jWH7r5XFsGJ6aJZY4UTwFcHmjswFWdK0t
        c1HGpRfCkgmYhTEdz5PqzLzFOgkVhDYILm5wX2Q8nA==
X-Google-Smtp-Source: AKy350Znyu1IvWROumlxai26nS+blIGNiWtQgPioqndo5D6ZQhJxK6Q/bngg+L8knrXBrCXblcPDGOtlhttj5QaVPv8=
X-Received: by 2002:a7b:c7d0:0:b0:3ed:7664:6d7b with SMTP id
 z16-20020a7bc7d0000000b003ed76646d7bmr889640wmk.8.1681234743849; Tue, 11 Apr
 2023 10:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230411072840.2751813-1-bhupesh.sharma@linaro.org>
 <20230411072840.2751813-3-bhupesh.sharma@linaro.org> <9130c1cb-4081-b21c-7c1b-2e0c9879e66a@linaro.org>
In-Reply-To: <9130c1cb-4081-b21c-7c1b-2e0c9879e66a@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Tue, 11 Apr 2023 23:08:52 +0530
Message-ID: <CAH=2NtzuN-0qgm7Hn6aJN+ZSRROFna09SHThVFbfKGVdsLzNWg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: Add base qrb4210-rb2 board dts
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, andersson@kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2023 at 18:26, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> On 11.04.2023 09:28, Bhupesh Sharma wrote:
> > Add DTS for Qualcomm qrb4210-rb2 board which uses SM4250 SoC.
> >
> > This adds debug uart, emmc, uSD and tlmm support along with
> > regulators found on this board.
> >
> > Also defines the 'xo_board' and 'sleep_clk' frequencies for
> > this board.
> >
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/Makefile        |   1 +
> >  arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 223 +++++++++++++++++++++++
> >  2 files changed, 224 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> >
> > diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> > index e0e2def48470..d42c59572ace 100644
> > --- a/arch/arm64/boot/dts/qcom/Makefile
> > +++ b/arch/arm64/boot/dts/qcom/Makefile
> > @@ -74,6 +74,7 @@ dtb-$(CONFIG_ARCH_QCOM)     += qcs404-evb-1000.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)      += qcs404-evb-4000.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)      += qdu1000-idp.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)      += qrb2210-rb1.dtb
> > +dtb-$(CONFIG_ARCH_QCOM)      += qrb4210-rb2.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)      += qrb5165-rb5.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)      += qrb5165-rb5-vision-mezzanine.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)      += qru1000-idp.dtb
> > diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> > new file mode 100644
> > index 000000000000..c9c6e3787462
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> > @@ -0,0 +1,223 @@
> > +// SPDX-License-Identifier: BSD-3-Clause
> > +/*
> > + * Copyright (c) 2023, Linaro Limited
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "sm4250.dtsi"
> > +
> > +/ {
> > +     model = "Qualcomm Technologies, Inc. QRB4210 RB2";
> > +     compatible = "qcom,qrb4210-rb2", "qcom,qrb4210", "qcom,sm4250";
> > +
> > +     aliases {
> > +             serial0 = &uart4;
> > +     };
> > +
> > +     chosen {
> > +             stdout-path = "serial0:115200n8";
> > +     };
> > +
> > +     vph_pwr: vph-pwr-regulator {
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "vph_pwr";
> > +             regulator-min-microvolt = <3700000>;
> > +             regulator-max-microvolt = <3700000>;
> > +
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +     };
> > +};
> > +
> > +&qupv3_id_0 {
> > +     status = "okay";
> > +};
> > +
> > +&rpm_requests {
> > +     regulators {
> > +             compatible = "qcom,rpm-pm6125-regulators";
> > +
> > +             vdd-s1-supply = <&vph_pwr>;
> > +             vdd-s2-supply = <&vph_pwr>;
> > +             vdd-s3-supply = <&vph_pwr>;
> > +             vdd-s4-supply = <&vph_pwr>;
> > +             vdd-s5-supply = <&vph_pwr>;
> > +             vdd-s6-supply = <&vph_pwr>;
> > +             vdd-s7-supply = <&vph_pwr>;
> > +             vdd-s8-supply = <&vph_pwr>;
> > +             vdd-s9-supply = <&vph_pwr>;
> > +             vdd-s10-supply = <&vph_pwr>;
> > +
> > +             vdd-l1-l7-l17-l18-supply = <&vreg_s6a_1p352>;
> > +             vdd-l2-l3-l4-supply = <&vreg_s6a_1p352>;
> > +             vdd-l5-l15-l19-l20-l21-l22-supply = <&vph_pwr>;
> > +             vdd-l6-l8-supply = <&vreg_s5a_0p848>;
> > +             vdd-l9-l11-supply = <&vreg_s7a_2p04>;
> > +             vdd-l10-l13-l14-supply = <&vreg_s7a_2p04>;
> > +             vdd-l12-l16-supply = <&vreg_s7a_2p04>;
> > +             vdd-l23-l24-supply = <&vph_pwr>;
> > +
> > +             vreg_s5a_0p848: s5 {
> I think going with pmicname_regulatorname (e.g. pm6125_s5) here
> and adding:
>
> regulator-name = "vreg_s5a_0p848"
>
> would make this more maintainable.

Ok.

> > +&sdhc_1 {
> > +     vmmc-supply = <&vreg_l24a_2p96>;
> > +     vqmmc-supply = <&vreg_l11a_1p8>;
> > +     no-sdio;
> > +     non-removable;
> > +
> > +     status = "okay";
> > +};
> > +
> > +&sdhc_2 {
> > +     cd-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>; /* card detect gpio */
> This comment is still pretty much spam.

Ok.

> > +     vmmc-supply = <&vreg_l22a_2p96>;
> > +     vqmmc-supply = <&vreg_l5a_2p96>;
> > +     no-sdio;
> > +
> > +     status = "okay";
> > +};
> > +
> > +&sleep_clk {
> > +     clock-frequency = <32000>;
> > +};
> > +
> > +&tlmm {
> > +     gpio-reserved-ranges = <37 5>, <43 2>, <47 1>,
> > +                            <49 1>, <52 1>, <54 1>,
> > +                            <56 3>, <61 2>, <64 1>,
> > +                            <68 1>, <72 8>, <96 1>;
> > +};
> > +
> > +&uart4 {
> > +     status = "okay";
> > +};
> This is not the correct SE for the production board. People
> booting this will get a tz bite.

Hmm.. I can swap it, but the problem is that it's as the SE for my RB2
board, so I would rather provide instructions in the cover letter as to how
to swap it (say for a production board) and recompile the dts.

Otherwise, it might break the debug uart console for even the test
folks @ Qualcomm.
I will send a v4 accordingly.

Thanks,
Bhupesh
