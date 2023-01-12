Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE23666C88
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239781AbjALIgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236639AbjALIfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:35:52 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 628694C714;
        Thu, 12 Jan 2023 00:35:01 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43CD812FC;
        Thu, 12 Jan 2023 00:35:43 -0800 (PST)
Received: from [192.168.1.12] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 772373F71A;
        Thu, 12 Jan 2023 00:34:59 -0800 (PST)
Message-ID: <99644abd-337e-e4a8-4c29-a1c55be489b1@arm.com>
Date:   Thu, 12 Jan 2023 09:34:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v2 01/23] arm64: dts: Update cache properties for amazon
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Antoine Tenart <atenart@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20221107155825.1644604-1-pierre.gondois@arm.com>
 <20221107155825.1644604-2-pierre.gondois@arm.com>
Content-Language: en-US
In-Reply-To: <20221107155825.1644604-2-pierre.gondois@arm.com>
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
>   arch/arm64/boot/dts/amazon/alpine-v3.dtsi | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amazon/alpine-v3.dtsi b/arch/arm64/boot/dts/amazon/alpine-v3.dtsi
> index 73a352ea8fd5..ba7e56dc85db 100644
> --- a/arch/arm64/boot/dts/amazon/alpine-v3.dtsi
> +++ b/arch/arm64/boot/dts/amazon/alpine-v3.dtsi
> @@ -246,6 +246,7 @@ cpu@303 {
>   
>   		cluster0_l2: cache@0 {
>   			compatible = "cache";
> +			cache-unified;
>   			cache-size = <0x200000>;
>   			cache-line-size = <64>;
>   			cache-sets = <2048>;
> @@ -254,6 +255,7 @@ cluster0_l2: cache@0 {
>   
>   		cluster1_l2: cache@100 {
>   			compatible = "cache";
> +			cache-unified;
>   			cache-size = <0x200000>;
>   			cache-line-size = <64>;
>   			cache-sets = <2048>;
> @@ -262,6 +264,7 @@ cluster1_l2: cache@100 {
>   
>   		cluster2_l2: cache@200 {
>   			compatible = "cache";
> +			cache-unified;
>   			cache-size = <0x200000>;
>   			cache-line-size = <64>;
>   			cache-sets = <2048>;
> @@ -270,6 +273,7 @@ cluster2_l2: cache@200 {
>   
>   		cluster3_l2: cache@300 {
>   			compatible = "cache";
> +			cache-unified;
>   			cache-size = <0x200000>;
>   			cache-line-size = <64>;
>   			cache-sets = <2048>;
