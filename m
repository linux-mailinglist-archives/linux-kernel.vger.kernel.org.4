Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51BB666C81
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239586AbjALIgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235142AbjALIfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:35:07 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96F5C50054;
        Thu, 12 Jan 2023 00:34:27 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79974FEC;
        Thu, 12 Jan 2023 00:35:09 -0800 (PST)
Received: from [192.168.1.12] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 236043F71A;
        Thu, 12 Jan 2023 00:34:25 -0800 (PST)
Message-ID: <74fe4cb1-9306-75a6-8adc-f7bb9191feb4@arm.com>
Date:   Thu, 12 Jan 2023 09:33:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v2 04/23] arm64: dts: Update cache properties for apm
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Khuong Dinh <khuong@os.amperecomputing.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
References: <20221107155825.1644604-1-pierre.gondois@arm.com>
 <20221107155825.1644604-5-pierre.gondois@arm.com>
Content-Language: en-US
In-Reply-To: <20221107155825.1644604-5-pierre.gondois@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(subset for cc list)
Hello,
Just a reminder in case the patch was forgotten,
Regards,
Pierre

On 11/7/22 16:56, Pierre Gondois wrote:
> The DeviceTree Specification v0.3 specifies that the cache node
> 'compatible' and 'cache-level' properties are 'required'. Cf.
> s3.8 Multi-level and Shared Cache Nodes
> The 'cache-unified' property should be present if one of the
> properties for unified cache is present ('cache-size', ...).
> 
> Update the Device Trees accordingly.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>   arch/arm64/boot/dts/apm/apm-shadowcat.dtsi | 4 ++++
>   arch/arm64/boot/dts/apm/apm-storm.dtsi     | 4 ++++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
> index a8526f8157ec..68ba865fcd58 100644
> --- a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
> +++ b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
> @@ -97,15 +97,19 @@ cpu@301 {
>   		};
>   		xgene_L2_0: l2-cache-0 {
>   			compatible = "cache";
> +			cache-level = <2>;
>   		};
>   		xgene_L2_1: l2-cache-1 {
>   			compatible = "cache";
> +			cache-level = <2>;
>   		};
>   		xgene_L2_2: l2-cache-2 {
>   			compatible = "cache";
> +			cache-level = <2>;
>   		};
>   		xgene_L2_3: l2-cache-3 {
>   			compatible = "cache";
> +			cache-level = <2>;
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
> index f56d687f772d..9ac7417f65eb 100644
> --- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
> +++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
> @@ -81,15 +81,19 @@ cpu@301 {
>   		};
>   		xgene_L2_0: l2-cache-0 {
>   			compatible = "cache";
> +			cache-level = <2>;
>   		};
>   		xgene_L2_1: l2-cache-1 {
>   			compatible = "cache";
> +			cache-level = <2>;
>   		};
>   		xgene_L2_2: l2-cache-2 {
>   			compatible = "cache";
> +			cache-level = <2>;
>   		};
>   		xgene_L2_3: l2-cache-3 {
>   			compatible = "cache";
> +			cache-level = <2>;
>   		};
>   	};
>   
