Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AF474C9D9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 04:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjGJCVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 22:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGJCVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 22:21:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8006F123
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 19:21:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78FB560D58
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:21:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481B6C433C8;
        Mon, 10 Jul 2023 02:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688955670;
        bh=+UoAnr+iPAaMdQiGQ0NGnvy5Fo2RLf00VEydjrqUO0M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=X65ssAjyCwOd3t0RdhIxM1IEuHvRNvZsdkstW+WPgCM3qxJb0F7pdZxUof8twWm6l
         EceTAe1yBJQTsAf/wunNvegpHsMg7FKhGDeIsBUpo0Y+US6H8fpSmQ80wkbsYzyxs4
         pwLH8IabCbCRJU7054QXYBAKxRA584mRy1sFaSdKKZN2yJD9N7B+nAavJWxPYlIUHK
         g0L9KwTtEsmYZBubKX6h2X/05TyJvE7iRE14egajbG4+TYxGmpPPwhdVWy0qYrZC8j
         fn+xckeSlivMqS+xJCS1rAV7QdbhAp/Yi7A516thKl5ywzgROkNieJyRmizWd5xsN4
         yxq6Y08xK8sJQ==
Message-ID: <fae4705f-587b-9899-ea0e-21f2e6ea7387@kernel.org>
Date:   Sun, 9 Jul 2023 21:21:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4] arm64: dts: agilex/stratix10: Updated QSPI Flash
 layout for UBIFS
Content-Language: en-US
To:     kah.jing.lee@intel.com, catalin.marinas@arm.com,
        conor+dt@kernel.org, krzysztof.kozlowski@linaro.org,
        Markus.Elfring@web.de, robh+dt@kernel.org, will@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
References: <20230703083626.1347969-1-kah.jing.lee@intel.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20230703083626.1347969-1-kah.jing.lee@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/3/23 03:36, kah.jing.lee@intel.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
> 
> Non-UBIFS related boot and fpga data should be stored in qspi_boot (mtd0)
> while keeping the rootfs with UBIFS in the root partition "mtd1".
> Thus, update the QSPI flash layout to support UBIFS in the mtd root
> partition.
> 
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
> Signed-off-by: Kah Jing Lee <kah.jing.lee@intel.com>
> ---
> V4->V3: Drop cover letter & remove unnecessary marker line
> V3->V2: Update commit messages
> V2->V1: Update subject prefix
> 
>   arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 8 ++++----
>   arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts     | 8 ++++----
>   2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> index 38ae674f2f02..12b960b9183c 100644
> --- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> @@ -202,12 +202,12 @@ partitions {
>   
>   			qspi_boot: partition@0 {
>   				label = "Boot and fpga data";
> -				reg = <0x0 0x03FE0000>;
> +				reg = <0x0 0x04200000>;
>   			};
>   
> -			qspi_rootfs: partition@3FE0000 {
> -				label = "Root Filesystem - JFFS2";
> -				reg = <0x03FE0000 0x0C020000>;
> +			root: partition@4200000 {
> +				label = "Root Filesystem - UBIFS";
> +				reg = <0x04200000 0x0BE00000>;
>   			};
>   		};
>   	};
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
> index 07c3f8876613..608017e6e36a 100644
> --- a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
> @@ -128,12 +128,12 @@ partitions {
>   
>   			qspi_boot: partition@0 {
>   				label = "Boot and fpga data";
> -				reg = <0x0 0x03FE0000>;
> +				reg = <0x0 0x04200000>;
>   			};
>   
> -			qspi_rootfs: partition@3FE0000 {
> -				label = "Root Filesystem - JFFS2";
> -				reg = <0x03FE0000 0x0C020000>;
> +			root: partition@4200000 {
> +				label = "Root Filesystem - UBIFS";
> +				reg = <0x04200000 0x0BE00000>;
>   			};
>   		};
>   	};
> 
> base-commit: dad9774deaf1cf8e8f7483310dfb2690310193d2

Applied!

Thanks,
Dinh
