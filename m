Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DACC601C98
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 00:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiJQWtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 18:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiJQWs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 18:48:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D027E82A;
        Mon, 17 Oct 2022 15:48:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA312B81B43;
        Mon, 17 Oct 2022 22:48:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F65C433D6;
        Mon, 17 Oct 2022 22:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666046935;
        bh=N81PdrM3b+XEPhHiIdHu9hpum+xGjOIDh8lLV2jhtXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b3QET5xD/VPEIbDlsCd+/EMNz37hKfy9qBmoCOS+C8SEOHmwHTG5MHQNK2zaVcBaF
         TuvHfvOdKyeQVqRoXGwbj/BUGdtm8/bEtMkI4qEmadPp03NdzUXGNHiCNLyuAe6ZX0
         OrksbPhmPMZO1qCT5bu5sB6vgGlWw2/6+1iwIUY2xzXBn8SIi6Lh4CiAx5tM6xcxHM
         TKHprvZADFcjYyyGn8oBRuJIX1UZQ659SYpNazbNbMg/FKcaohTaMg65y4nsNtdy6q
         KLfJEfKH5QDs8R9aMmCo2ena9wIDxccHHahAkXkxnxdmyj/seXRCO66XsDkCkv60uP
         sdWOwcUjpfheQ==
Date:   Mon, 17 Oct 2022 17:48:53 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, dianders@chromium.org,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v6 2/3] arm64: dts: qcom: Add LTE SKU for sc7280-evoker
 family
Message-ID: <20221017224853.stuy5qeqxjxntob4@builder.lan>
References: <20221003102735.39028-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20221003182637.v6.2.I1454364ac3d8ecc64677884d6b7d2f3e334e4b4a@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221003182637.v6.2.I1454364ac3d8ecc64677884d6b7d2f3e334e4b4a@changeid>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 06:27:35PM +0800, Sheng-Liang Pan wrote:

Please prefix your sc7280 changes with "arm64: dts: qcom: sc7280: "...

Regards,
Bjorn

> evoker have wifi/lte sku, add different dts for each sku.
> 
> Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> (no changes since v5)
> 
> Changes in v5:
> - remove unnecessary whitespace
> 
> Changes in v4:
> - remove change for trackpad and touchscreen
> 
>  arch/arm64/boot/dts/qcom/Makefile                 |  3 ++-
>  .../boot/dts/qcom/sc7280-herobrine-evoker-lte.dts | 14 ++++++++++++++
>  .../boot/dts/qcom/sc7280-herobrine-evoker.dts     | 15 +++++++++++++++
>  ...evoker-r0.dts => sc7280-herobrine-evoker.dtsi} |  7 -------
>  4 files changed, 31 insertions(+), 8 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-lte.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts
>  rename arch/arm64/boot/dts/qcom/{sc7280-herobrine-evoker-r0.dts => sc7280-herobrine-evoker.dtsi} (98%)
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 65cb0f714ed6b..91153baeeffae 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -95,7 +95,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1-lte.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-crd.dtb
> -dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-evoker-r0.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-evoker.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-evoker-lte.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-herobrine-r1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r0.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r1.dtb
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
> index ccbe50b6249ab..e78072159d54b 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtsi
> @@ -5,15 +5,8 @@
>   * Copyright 2022 Google LLC.
>   */
>  
> -/dts-v1/;
> -
>  #include "sc7280-herobrine.dtsi"
>  
> -/ {
> -	model = "Google Evoker";
> -	compatible = "google,evoker", "qcom,sc7280";
> -};
> -
>  /*
>   * ADDITIONS TO FIXED REGULATORS DEFINED IN PARENT DEVICE TREE FILES
>   *
> -- 
> 2.34.1
> 
