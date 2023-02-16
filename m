Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF55869904A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjBPJnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjBPJnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:43:14 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CD57D9A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:43:12 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id az27so299678uab.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k+IcP9JZ9x1kcivgUFdu74is1jTxITNl/hwmvZ5y5f8=;
        b=m7QKamtB4nlsz/kEd9OvsoPEHumtXSdhtUbRm4tQ0On6c+9PjP2yH0/5/9K2zfxYZ4
         WpWELkjr+vDA/keD2bO/gcC1hvebLE5sG+WBfdZX/b++2xFRtUbCZ4niFU32eqoaVeko
         CXy/jsYQtF9+NNrkbUn3Bl1jIA4gpjJWLCbaDW305DS8+ii4Mz7BkcFZ1a35T6jfOzDI
         Thelr5sBigU6ftwkb9DbJN+hYZbYfpfGqKFhpdkNe7LhtMhgdsApygg9Qj5lsjSxPL0q
         cZBPMc+ghaAFCJcB5Z8NbwglLP2RXcAPoKPSZXL3gn1ABvc0Jq3X+YXFmIQoAgqOoGPu
         1bhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k+IcP9JZ9x1kcivgUFdu74is1jTxITNl/hwmvZ5y5f8=;
        b=wj2mSjG9G/zi+D60MM4ErZMg63d7WC7AYu0FuxzV8eQ6J/0yp3+T+mfJQCF4pRddoN
         0LL5JWmpvQdsCzsK+8idqV2P6JjLkUWckdtvYIAXV5A6WA27KImSdV12urIID7xpDAjf
         iar9EgGGvPA4rmYF0kfeyq3JecZdkjDG9H5PjxMpH2g+2axBuEa+PEX4Fb5msb7gvQzd
         Ad+/rr779w1Zm+fy1El344UUKJuPL28zTLMLSllq3H4AGRyT1cK4Jus3rs90kdp8v605
         JMT4gmy6WnReZQmoWycaZTCFCKdi39KWw62NznKUfByL8Y34BscVO3ezvqsuyIxosjyl
         B1tQ==
X-Gm-Message-State: AO0yUKXYfm7Od4WwfPhmu0uQzDaRjsHgI4Fa6ZbMEzdUUXaLgu2G5wMH
        S6a+FCHfuc/SY7I4emgdR8yHLKeK9ezjFjoXBolGRA==
X-Google-Smtp-Source: AK7set/HBL5bYW7gxs8bV8MFxYe2tMQUs1boWXh8ugz4WqDDq0aDUuMmiKXQPGsPd1LWO/To14TY6DEuDhNA5e1Rcdo=
X-Received: by 2002:ab0:549e:0:b0:68a:8f33:9567 with SMTP id
 p30-20020ab0549e000000b0068a8f339567mr817107uaa.2.1676540592009; Thu, 16 Feb
 2023 01:43:12 -0800 (PST)
MIME-Version: 1.0
References: <20230215154002.446808-1-brgl@bgdev.pl> <20230215154002.446808-4-brgl@bgdev.pl>
In-Reply-To: <20230215154002.446808-4-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 16 Feb 2023 10:43:01 +0100
Message-ID: <CAMRc=MdH7yxof63V2icesypGTFSssziaA5sCOZP_Gby-3ciLKA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] arm64: dts: qcom: sa8775p: add the GNSS high-speed
 UART for sa8775p-ride
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 4:40 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Add the serial port connected to the GNSS on sa8775p-ride.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 34 +++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi     | 15 ++++++++++
>  2 files changed, 49 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> index d01ca3a9ee37..47cf26ea49e8 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> @@ -13,6 +13,7 @@ / {
>
>         aliases {
>                 serial0 = &uart10;
> +               serial1 = &uart12;
>                 i2c18 = &i2c18;
>                 spi16 = &spi16;
>         };
> @@ -66,6 +67,30 @@ qup_i2c18_default: qup-i2c18-state {
>                 drive-strength = <2>;
>                 bias-pull-up;
>         };
> +
> +       qup_uart12_cts: qup-uart12-cts-state {
> +               pins = "gpio52";
> +               function = "qup1_se5";
> +               bias-disable;
> +       };
> +
> +       qup_uart12_rts: qup_uart12_rts-state {
> +               pins = "gpio53";
> +               function = "qup1_se5";
> +               bias-pull-down;
> +       };
> +
> +       qup_uart12_tx: qup_uart12_tx-state {
> +               pins = "gpio54";
> +               function = "qup1_se5";
> +               bias-pull-up;
> +       };
> +
> +       qup_uart12_rx: qup_uart12_rx-state {
> +               pins = "gpio55";
> +               function = "qup1_se5";
> +               bias-pull-down;
> +       };
>  };
>
>  &uart10 {
> @@ -75,6 +100,15 @@ &uart10 {
>         status = "okay";
>  };
>
> +&uart12 {
> +       pinctrl-0 = <&qup_uart12_cts>,
> +                   <&qup_uart12_rts>,
> +                   <&qup_uart12_tx>,
> +                   <&qup_uart12_rx>;
> +       pinctrl-names = "default";
> +       status = "okay";
> +};
> +
>  &xo_board_clk {
>         clock-frequency = <38400000>;
>  };
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index 1abb545ff4f4..8b8931ea739d 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -489,6 +489,21 @@ &clk_virt SLAVE_QUP_CORE_1 0>,
>                                 operating-points-v2 = <&qup_opp_table_100mhz>;
>                                 status = "disabled";
>                         };
> +
> +                       uart12: serial@a94000 {
> +                               compatible = "qcom,geni-uart";
> +                               reg = <0x0 0xa94000 0x0 0x4000>;
> +                               interrupts = <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>;

Please disregard this series, I've just noticed I didn't stage the
change to the interrupt number here which is wrong. And I need to fix
the underscores in node names too.

Bart

> +                               clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
> +                               clock-names = "se";
> +                               interconnects = <&clk_virt MASTER_QUP_CORE_1 0
> +                                                &clk_virt SLAVE_QUP_CORE_1 0>,
> +                                               <&gem_noc MASTER_APPSS_PROC 0
> +                                                &config_noc SLAVE_QUP_1 0>;
> +                               interconnect-names = "qup-core", "qup-config";
> +                               power-domains = <&rpmhpd SA8775P_CX>;
> +                               status = "disabled";
> +                       };
>                 };
>
>                 qupv3_id_2: geniqup@8c0000 {
> --
> 2.37.2
>
