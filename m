Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF5D62F945
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 16:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242088AbiKRP2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 10:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242178AbiKRP2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 10:28:41 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A7B64571
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 07:28:39 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id z9so2673816ilu.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 07:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V3r1rBEjB59P7Hp9rGdtjQJ0ITi8NZo801rMdyiF4HU=;
        b=G+PzEFfAhMqQSIaM94usPBm+ze8W/n7MqO76Y1A3SsmdmZNsRJR4K38aX8qjnGNxLe
         yaHwhUn3hbQVPmGCo96jqLkb3TamQXkTlCN8qtTYA79D8j14Kdlt9KEZE+UvSQrRQwZl
         XN3osX0KOX7aMFWMp/Hd0xyTG7q+NC2QRuMbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3r1rBEjB59P7Hp9rGdtjQJ0ITi8NZo801rMdyiF4HU=;
        b=5shyMrvopowyR4FrzDvvxyoNEmqd6ojjPTeClWlMKv4iyLu4uxL/BqgPPjvSXwaZvw
         z+RtBFx59WMTlpyZvZFS9pJVrWOSPZxqMzIe4xpXoSwWCf/1GWw88PwrS45lcUGwwBKQ
         M9cgY/Ba02AEsFGgPVtnEvIWQApOhbs3ImT8tA2N8IWL+rLvKcYJyqEEag6P55GBrneD
         S+BtxyHyvVrp1Fu14Clg1xGXkdTjPm0kVSsKgD4tN457Wa7p5KYc8Dkcwfy8PVQCUZ3d
         o1pHMFKt+ON/vemfNuE2tUV9swDVdK0Ohah7vlDQ8tq/JT4KTWP7BoQ25d8ObxgJQR8L
         RcQg==
X-Gm-Message-State: ANoB5pnOJJVs+mI7kLkUEy0yIquEEpWje7DpKXVfXVoD5fDgQwNhhh7Z
        /9YSX0upa1b/ksd7FnI2uYu/Pw==
X-Google-Smtp-Source: AA0mqf6C3biW+ByQBq4hcoGxLWTV//5gPtXVCzNfAg0J28ZfiqPApQ/2Us66xTCumk0l7fvllDWDPg==
X-Received: by 2002:a05:6e02:c0d:b0:300:b1ee:c196 with SMTP id d13-20020a056e020c0d00b00300b1eec196mr3614368ile.237.1668785319286;
        Fri, 18 Nov 2022 07:28:39 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id o7-20020a056e02092700b003027f923d29sm1351073ilt.39.2022.11.18.07.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 07:28:38 -0800 (PST)
Date:   Fri, 18 Nov 2022 15:28:38 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <quic_rjendra@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dianders@chromium.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc7280: Add a new herobrine Pro SKU
Message-ID: <Y3ekpgpRxgFwEeo0@google.com>
References: <20221118073017.26128-1-quic_rjendra@quicinc.com>
 <20221118073017.26128-2-quic_rjendra@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221118073017.26128-2-quic_rjendra@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rajendra,

On Fri, Nov 18, 2022 at 01:00:17PM +0530, Rajendra Nayak wrote:

> Subject: arm64: dts: qcom: sc7280: Add a new herobrine Pro SKU

nit: this adds the herobrine *CRD* Pro SKU (though other Pro SKUs
might follow), so 'CRD' should be part of the subject

uber-nit: 'new' is redundant in this context

> Some of the qualcomm qcard based herobrine devices can come with
> a Pro variant of the chipset with some qcard level changes like
> the smps9 from pm8350c which is ganged up with smps7 and smps8,
> so we just end up removing smps9 from the herobrine pro sku dtsi.

This is a very long sentence :)

> We then use it to create a new dts for the Pro variant of the
> herobrine CRD.

Using 'we' is a a bit colloquial for a commit message, how a about
something like this: 'Add a .dtsi for pro skus that deletes the
smps9 node and include it from the new dts for the CRD Pro'.

> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |  1 +
>  .../dts/qcom/sc7280-herobrine-crd-pro.dts     | 35 +++++++++++++++++++
>  .../dts/qcom/sc7280-herobrine-pro-sku.dtsi    |  8 +++++
>  3 files changed, 44 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-crd-pro.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-pro-sku.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index afe496a93f94..c5ac51c3a383 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -108,6 +108,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1-lte.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-crd.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-crd-pro.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-evoker.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-evoker-lte.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-herobrine-r1.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd-pro.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd-pro.dts
> new file mode 100644
> index 000000000000..fe6b228e9e4b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd-pro.dts
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * sc7280 CRD 3+ Pro board device tree source
> + *
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include "sc7280-herobrine-crd.dts"
> +#include "sc7280-herobrine-pro-sku.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. sc7280 CRD Pro platform (rev5+)";
> +	compatible = "google,hoglin-sku1536", "qcom,sc7280";
> +
> +	/* FIXED REGULATORS */
> +
> +	/*
> +	 * On most herobrine boards PPVAR_SYS directly provides VREG_EDP_BL.
> +	 * However, on CRD there's an extra regulator in the way. Since this
> +	 * is expected to be uncommon, we'll leave the "vreg_edp_bl" label
> +	 * in the baseboard herobrine.dtsi point at "ppvar_sys" and then
> +	 * make a "_crd" specific version here.
> +	 */
> +	vreg_edp_bl_crd: vreg-edp-bl-crd-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vreg_edp_bl_crd";
> +
> +		gpio = <&pm8350c_gpios 6 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&edp_bl_reg_en>;
> +
> +		vin-supply = <&ppvar_sys>;
> +	};
> +};

Why is this node needed here, doesn't it already exist by including
'sc7280-herobrine-crd.dts'?

> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-pro-sku.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-pro-sku.dtsi
> new file mode 100644
> index 000000000000..fb4bbe8aeda0
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-pro-sku.dtsi
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Google Herobrine dts fragment for PRO SKUs
> + *
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/delete-node/ &vreg_s9c_0p676;
> -- 
> 2.17.1
> 
