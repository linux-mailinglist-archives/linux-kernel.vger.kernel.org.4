Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3025BB139
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 18:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiIPQqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 12:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIPQqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 12:46:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84D11A6ADD;
        Fri, 16 Sep 2022 09:46:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA86E1595;
        Fri, 16 Sep 2022 09:46:13 -0700 (PDT)
Received: from [10.57.18.118] (unknown [10.57.18.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E876F3F73D;
        Fri, 16 Sep 2022 09:46:05 -0700 (PDT)
Message-ID: <6a64bfed-2939-299f-5807-607406eaa89b@arm.com>
Date:   Fri, 16 Sep 2022 17:46:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/2] dt-bindings: rockchip: k3566-quartz64-a: fix names
 entries, refactor
Content-Language: en-GB
To:     Alessandro Carminati <alessandro.carminati@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <YyRxp7pDCyikNLGc@lab.hqhome163.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YyRxp7pDCyikNLGc@lab.hqhome163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-16 13:52, Alessandro Carminati wrote:
> Fix esisting "No underscores in node names" general rule, and prepare for
> new board versions.
> 
> Signed-off-by: Alessandro Carminati <alessandro.carminati@gmail.com>
> ---
>   arch/arm64/boot/dts/rockchip/Makefile         |  2 +-
>   ...-quartz64-a.dts => rk3566-quartz64-a.dtsi} | 27 ++++++++-----------
>   .../dts/rockchip/rk3566-quartz64-a.usb3.dts   |  9 +++++++
>   3 files changed, 21 insertions(+), 17 deletions(-)
>   rename arch/arm64/boot/dts/rockchip/{rk3566-quartz64-a.dts => rk3566-quartz64-a.dtsi} (97%)
>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.usb3.dts
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index ef79a672804a..97ec6c156346 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -59,7 +59,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire-excavator.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399pro-rock-pi-n10.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.1.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.2.dtb
> -dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-a.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-a.usb3.dtb

Beware that changing the name of an existing DTB is going to break some 
people's boot scripts. Since this one was merged several releases ago, 
it's a probably bit too late to change now.

Thanks,
Robin.
