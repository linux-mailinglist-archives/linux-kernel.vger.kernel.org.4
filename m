Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C301A6208A6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 06:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiKHFAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 00:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbiKHE7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 23:59:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81785186FF;
        Mon,  7 Nov 2022 20:58:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A78E61477;
        Tue,  8 Nov 2022 04:58:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD9CC433C1;
        Tue,  8 Nov 2022 04:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667883511;
        bh=T4tDRWuZasu03wuxxewbLmmVZ6MOIYipTxzVqzujbXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AmfeWUwRvFgJh5VXDeQMnFZRcTIXVV3ffxBkUKO4l/rq64c7rCSVYCDIvi0BFptlu
         vWhELfhba/fleaQ4YARNEEaCo+WiECp7a6TJMT6FreZgBNbbz/3ryMdZII+z7AcES4
         07rEHS3NjKNVkQeZ8h7Fqxt/KbhKX8U2psmZqB4MrKYwEvjdkrjikmQJfem2blKRJz
         ZATAAKo7UdVMfH1MHTrw+Et57rECE1wzrhk7fGQGGF2IMzEsai2jdX21N0mj1iiTqh
         qVzsm6GUJBqvA7NWtrRN4l5AIPeEzUmCp6Yk7FBQlsJbhOYb+vlU7drNgy0qJIS6YT
         8BbLArK7UZztg==
Date:   Mon, 7 Nov 2022 22:58:28 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     agross@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, jic23@kernel.org, lars@metafoo.de,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        bhupesh.sharma@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-hardening@vger.kernel.org, marijn.suijten@somainline.org,
        kernel@collabora.com, luca@z3ntu.xyz, a39.skl@gmail.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: Re: [PATCH 9/9] arm64: dts: qcom: Add support for SONY Xperia X/X
 Compact
Message-ID: <20221108045828.4cwq4lyskfxc5fdk@builder.lan>
References: <20221104172122.252761-1-angelogioacchino.delregno@collabora.com>
 <20221104172122.252761-10-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104172122.252761-10-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 06:21:22PM +0100, AngeloGioacchino Del Regno wrote:
[..]
> +&rpm_requests {
> +	pm8950_regulators: regulators {
[..]
> +		pm8950_l8: l8 {
> +			regulator-min-microvolt = <2900000>;
> +			regulator-max-microvolt = <2900000>;

Are you sure you don't need regulator-allow-set-load and a
regulator-system-load to force vmmc-supply of your sdhc up to HPM?

We've had this issue a few too many times...

> +		};
> +
> +		pm8950_l9: l9 {
> +			regulator-min-microvolt = <2000000>;
> +			regulator-max-microvolt = <2400000>;
> +		};
> +
> +		pm8950_l10: l10 {
> +			regulator-min-microvolt = <2500000>;
> +			regulator-max-microvolt = <2900000>;
> +		};
> +
> +		pm8950_l11: l11 {
> +			regulator-min-microvolt = <2950000>;
> +			regulator-max-microvolt = <2950000>;

As above.

> +		};
> +
> +		pm8950_l12: l12 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2950000>;
> +		};
> +

Regards,
Bjorn
