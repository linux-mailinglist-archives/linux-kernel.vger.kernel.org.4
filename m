Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362ED61939A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 10:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbiKDJdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 05:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiKDJdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 05:33:10 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E4C2A704
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 02:33:08 -0700 (PDT)
Received: from [192.168.31.208] (unknown [194.29.137.22])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 8587A3F096;
        Fri,  4 Nov 2022 10:33:05 +0100 (CET)
Message-ID: <a170aaa0-966d-8ddd-76ae-ff832ee5e214@somainline.org>
Date:   Fri, 4 Nov 2022 10:33:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v10 2/4] arm64: dts: qcom: sc7280: Add LTE SKU for
 sc7280-evoker family
To:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20221104061941.2739938-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20221104141515.v10.2.If03e9e85e63ece4b1599db841c90ed785c47a4be@changeid>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221104141515.v10.2.If03e9e85e63ece4b1599db841c90ed785c47a4be@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/11/2022 07:19, Sheng-Liang Pan wrote:
> evoker have wifi/lte sku, add different dts for each sku.
>
> Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad

>
> Changes in v8:
> - updated patch subjects
>
> Changes in v5:
> - recover whitespace change
>
> Changes in v4:
> - recover change for trackpad and touchscreen
>
>   arch/arm64/boot/dts/qcom/Makefile                 |  3 ++-
>   .../boot/dts/qcom/sc7280-herobrine-evoker-lte.dts | 14 ++++++++++++++
>   .../boot/dts/qcom/sc7280-herobrine-evoker.dts     | 15 +++++++++++++++
>   ...evoker-r0.dts => sc7280-herobrine-evoker.dtsi} |  7 -------
>   4 files changed, 31 insertions(+), 8 deletions(-)
>   create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-lte.dts
>   create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts
>   rename arch/arm64/boot/dts/qcom/{sc7280-herobrine-evoker-r0.dts => sc7280-herobrine-evoker.dtsi} (98%)
>
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index b0558d3389e5a..6f234995284b2 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -106,7 +106,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1-lte.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-crd.dtb
> -dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-evoker-r0.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-evoker.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-evoker-lte.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-herobrine-r1.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r0.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r1.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-lte.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-lte.dts
> new file mode 100644
> index 0000000000000..3af9224a7492e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-lte.dts
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Evoker board device tree source
> + *
> + * Copyright 2022 Google LLC.
> + */
> +
> +#include "sc7280-herobrine-evoker.dts"
> +#include "sc7280-herobrine-lte-sku.dtsi"
> +
> +/ {
> +	model = "Google Evoker with LTE";
> +	compatible = "google,evoker-sku512", "qcom,sc7280";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts
> new file mode 100644
> index 0000000000000..dcdd4eecfe670
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Evoker board device tree source
> + *
> + * Copyright 2022 Google LLC.
> + */
> +
> +/dts-v1/;
> +
> +#include "sc7280-herobrine-evoker.dtsi"
> +
> +/ {
> +	model = "Google Evoker";
> +	compatible = "google,evoker", "qcom,sc7280";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtsi
> similarity index 98%
> rename from arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts
> rename to arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtsi
> index 739e81bd6d689..a6015491c6082 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtsi
> @@ -5,15 +5,8 @@
>    * Copyright 2022 Google LLC.
>    */
>   
> -/dts-v1/;
> -
>   #include "sc7280-herobrine.dtsi"
>   
> -/ {
> -	model = "Google Evoker";
> -	compatible = "google,evoker", "qcom,sc7280";
> -};
> -
>   /*
>    * ADDITIONS TO FIXED REGULATORS DEFINED IN PARENT DEVICE TREE FILES
>    *
