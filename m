Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBB765C789
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 20:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238720AbjACT3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 14:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjACT3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:29:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F5A13EA4;
        Tue,  3 Jan 2023 11:29:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4056E614FE;
        Tue,  3 Jan 2023 19:29:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E50CC433D2;
        Tue,  3 Jan 2023 19:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672774160;
        bh=kS1/OyPfwcshfjZ/3SRHvug8fTiy5Wp9PW3ZNN6JzkY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pVFMp+O7STYIzNC26PdnlOB+c8TEatF6kKtV74xmbxzfcUAgnz3l52ERbwcVEEQVR
         iPX8VOIHAJfP67k3yMDCVkLMU9UNjOgHHj7PC1MU+n6bRjOpuQhFXrf79U7Qp8gelK
         +fqGyFRzXPNx2V2R9+pswBxersPoCp4IgsbYCoRbMe6BfQABV/13+ccEJe0Na4cUiB
         ZfCWj3fii45asfmzvj3hIK8Gs3nyJ2brfsLIpw3b/NzziiAtVm4kRzDAyx16/F4irb
         SFf8Rcz+8RHR+vb2JEQq+CTjeLWBXg4a6aWIq6ufp9F3TsEFT4N1jNOmJ7tJ6KVG3y
         j897npKffKRaQ==
Received: by mail-vs1-f54.google.com with SMTP id x65so19280454vsb.13;
        Tue, 03 Jan 2023 11:29:20 -0800 (PST)
X-Gm-Message-State: AFqh2koi+O/gtHaRIRSPHgPVoZ2wmmA7vR0EZt0AiI3hgcakfFPgE5V7
        BU3csidkBPtWYlvb9rjx/xxw+ONPuDPmCUX6kQ==
X-Google-Smtp-Source: AMrXdXsQ2RTXm/Q35pqeUXeb1yWkLtg8oApHK2GmDp4d+XS1Y9R+sLOqoroDn7dwWaNBSf2fnc/56BSdJ4WHQRyGYuk=
X-Received: by 2002:a67:edd4:0:b0:3b5:1fe4:f1c2 with SMTP id
 e20-20020a67edd4000000b003b51fe4f1c2mr5170483vsp.0.1672774159592; Tue, 03 Jan
 2023 11:29:19 -0800 (PST)
MIME-Version: 1.0
References: <20221207211327.2848665-1-robh@kernel.org>
In-Reply-To: <20221207211327.2848665-1-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 3 Jan 2023 13:29:08 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKmULjtP7UCMZDxJTL3p7C_WS9qMaL5tMg5Jv74Sb0QQw@mail.gmail.com>
Message-ID: <CAL_JsqKmULjtP7UCMZDxJTL3p7C_WS9qMaL5tMg5Jv74Sb0QQw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Fix CPU nodes compatible string
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 7, 2022 at 3:13 PM Rob Herring <robh@kernel.org> wrote:
>
> 'arm,kryo' is not documented and is not an Arm Ltd thing either as that
> is Qualcomm branding. The correct compatible is 'qcom,kryo'.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Ping!

>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 212580316d3e..f06cc7588acc 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -166,7 +166,7 @@ cpus {
>
>                 CPU0: cpu@0 {
>                         device_type = "cpu";
> -                       compatible = "arm,kryo";
> +                       compatible = "qcom,kryo";
>                         reg = <0x0 0x0>;
>                         enable-method = "psci";
>                         cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> @@ -189,7 +189,7 @@ L3_0: l3-cache {
>
>                 CPU1: cpu@100 {
>                         device_type = "cpu";
> -                       compatible = "arm,kryo";
> +                       compatible = "qcom,kryo";
>                         reg = <0x0 0x100>;
>                         enable-method = "psci";
>                         cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> @@ -209,7 +209,7 @@ L2_100: l2-cache {
>
>                 CPU2: cpu@200 {
>                         device_type = "cpu";
> -                       compatible = "arm,kryo";
> +                       compatible = "qcom,kryo";
>                         reg = <0x0 0x200>;
>                         enable-method = "psci";
>                         cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> @@ -229,7 +229,7 @@ L2_200: l2-cache {
>
>                 CPU3: cpu@300 {
>                         device_type = "cpu";
> -                       compatible = "arm,kryo";
> +                       compatible = "qcom,kryo";
>                         reg = <0x0 0x300>;
>                         enable-method = "psci";
>                         cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> @@ -249,7 +249,7 @@ L2_300: l2-cache {
>
>                 CPU4: cpu@400 {
>                         device_type = "cpu";
> -                       compatible = "arm,kryo";
> +                       compatible = "qcom,kryo";
>                         reg = <0x0 0x400>;
>                         enable-method = "psci";
>                         cpu-idle-states = <&BIG_CPU_SLEEP_0
> @@ -269,7 +269,7 @@ L2_400: l2-cache {
>
>                 CPU5: cpu@500 {
>                         device_type = "cpu";
> -                       compatible = "arm,kryo";
> +                       compatible = "qcom,kryo";
>                         reg = <0x0 0x500>;
>                         enable-method = "psci";
>                         cpu-idle-states = <&BIG_CPU_SLEEP_0
> @@ -289,7 +289,7 @@ L2_500: l2-cache {
>
>                 CPU6: cpu@600 {
>                         device_type = "cpu";
> -                       compatible = "arm,kryo";
> +                       compatible = "qcom,kryo";
>                         reg = <0x0 0x600>;
>                         enable-method = "psci";
>                         cpu-idle-states = <&BIG_CPU_SLEEP_0
> @@ -309,7 +309,7 @@ L2_600: l2-cache {
>
>                 CPU7: cpu@700 {
>                         device_type = "cpu";
> -                       compatible = "arm,kryo";
> +                       compatible = "qcom,kryo";
>                         reg = <0x0 0x700>;
>                         enable-method = "psci";
>                         cpu-idle-states = <&BIG_CPU_SLEEP_0
> --
> 2.35.1
>
