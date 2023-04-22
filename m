Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7D46EB64C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 02:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbjDVAN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 20:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbjDVANx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 20:13:53 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C422696
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 17:13:51 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54fe25c2765so33406437b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 17:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682122430; x=1684714430;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GzjW1lq0MJ52FFDUmy1RMun3dw9kCODZzOkNuQoKVFQ=;
        b=J8zz0xzVEVTmuO+QCchnyLOACpU2OxMwN76VmUoQNxeJD7lSyHM4h0YEOymgGKgAsY
         5x97hyE/nqCLpE6W9A6gTiqMRgVb/ZKus6pzuNQu9QEvkESDmRTL1HNYKD9T8IqGfdfY
         I5WeVtMLpijK+KscUwWaVcwhYvndgz1r6HhkopfxHiRZNYwfVad9c+OV5I1Jh9fSlRep
         U8qXNVrEXbFla9nl8q/sFG+xaCiVnOmEokum3DXsBPteVMaqmHWBPmx1Yw7kUoRHPnZL
         dw4QD4IIYU8g42uQ68aklxRgIM4dFOmcBOPMNy/vsMGfaTepKxctuVTV123jbhPFDY90
         Q+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682122430; x=1684714430;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GzjW1lq0MJ52FFDUmy1RMun3dw9kCODZzOkNuQoKVFQ=;
        b=joXDcCG5ZuKgJMfxZbQjTL1yvPefdVbldRxQSohfpOfVR7iGaNgOYo+JpzMRLQEkpY
         zvW4stXKUAGR6MNfDfTcFoGLhLQT7l9s5ATlcSmD8d4v8JyVWmBLNgoOL/gF2B4VETzU
         /LscVXQTCDFwurrHhE6SJrcErdMpi14U27V7EC5pwsLhxkL2bgtzcHIVr8ifsSeY7GAr
         Z/Z3tr8u7Cs49TECZRupPy1ivIgA3/YbKBJAy1l4xma7NzoSDtchoWBQH0LrgvcG5GU+
         ZzT0ae0JdRtSjOjWMuShQUwh81TOAS5OgCiWdqA7y7qHBO7e3+Ng5Af7z/yQGJHNYajG
         4Hgg==
X-Gm-Message-State: AAQBX9fswsWJfCFLf4UbrCmnZOi87d0GxU8w8P72BZCtwRW/zKKK0FDf
        UOosmAdrQ9m1KZeYVkLkzwo/Jeq240BdgjAAltnWag==
X-Google-Smtp-Source: AKy350YD/7d1h1phzQfoDhjdI8jO1aJLgkfA7UGVDvuyuI4QrGdpzww8tQUWXQoC+TO38zUmAMs0m9bqWMHMnsrhCow=
X-Received: by 2002:a81:4fd7:0:b0:54b:fcc4:b3f4 with SMTP id
 d206-20020a814fd7000000b0054bfcc4b3f4mr3162136ywb.19.1682122430289; Fri, 21
 Apr 2023 17:13:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230421124938.21974-1-quic_devipriy@quicinc.com> <20230421124938.21974-6-quic_devipriy@quicinc.com>
In-Reply-To: <20230421124938.21974-6-quic_devipriy@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 22 Apr 2023 03:13:39 +0300
Message-ID: <CAA8EJpqx1jv_xEnS-2rOOGCtEB=1vo477H7XLGGvH=o7NHJD7w@mail.gmail.com>
Subject: Re: [PATCH V3 5/6] arm64: dts: qcom: ipq9574: Enable PCIe PHYs and controllers
To:     Devi Priya <quic_devipriy@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, mani@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-clk@vger.kernel.org, quic_srichara@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_ipkumar@quicinc.com
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

On Fri, 21 Apr 2023 at 15:51, Devi Priya <quic_devipriy@quicinc.com> wrote:
>
> Enable the PCIe controller and PHY nodes corresponding to
> RDP 433.
>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>  Changes in V3:
>         - No change
>
>  arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 62 +++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> index 7be578017bf7..3ae38cf327ea 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> @@ -8,6 +8,7 @@
>
>  /dts-v1/;
>
> +#include <dt-bindings/gpio/gpio.h>
>  #include "ipq9574.dtsi"
>
>  / {
> @@ -43,6 +44,42 @@
>         };
>  };
>
> +&pcie1_phy {
> +       status = "okay";
> +};
> +
> +&pcie1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pcie_1_pin>;
> +
> +       perst-gpios = <&tlmm 26 GPIO_ACTIVE_LOW>;

Usually qcom PCIe hosts also define wake-gpios.

> +       status = "okay";
> +};
> +
> +&pcie2_phy {
> +       status = "okay";
> +};
> +
> +&pcie2 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pcie_2_pin>;
> +
> +       perst-gpios = <&tlmm 29 GPIO_ACTIVE_LOW>;
> +       status = "okay";
> +};
> +
> +&pcie3_phy {
> +       status = "okay";
> +};
> +
> +&pcie3 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pcie_3_pin>;
> +
> +       perst-gpios = <&tlmm 32 GPIO_ACTIVE_LOW>;
> +       status = "okay";
> +};
> +
>  &sdhc_1 {
>         pinctrl-0 = <&sdc_default_state>;
>         pinctrl-names = "default";
> @@ -60,6 +97,31 @@
>  };
>
>  &tlmm {
> +
> +       pcie_1_pin: pcie-1-state {
> +               pins = "gpio26";
> +               function = "gpio";
> +               drive-strength = <8>;
> +               bias-pull-down;
> +               output-low;

No clkreq and no wake gpios?

> +       };
> +
> +       pcie_2_pin: pcie-2-state {
> +               pins = "gpio29";
> +               function = "gpio";
> +               drive-strength = <8>;
> +               bias-pull-down;
> +               output-low;
> +       };
> +
> +       pcie_3_pin: pcie-3-state {
> +               pins = "gpio32";
> +               function = "gpio";
> +               drive-strength = <8>;
> +               bias-pull-up;
> +               output-low;
> +       };
> +
>         sdc_default_state: sdc-default-state {
>                 clk-pins {
>                         pins = "gpio5";
> --
> 2.17.1
>


-- 
With best wishes
Dmitry
