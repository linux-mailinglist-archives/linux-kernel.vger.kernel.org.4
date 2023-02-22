Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95AD769FB08
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjBVScP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjBVScN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:32:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A24D2F791;
        Wed, 22 Feb 2023 10:32:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B7D96141D;
        Wed, 22 Feb 2023 18:32:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A529C433EF;
        Wed, 22 Feb 2023 18:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677090732;
        bh=3ioskgJHOBrx7Bm8pWAJOjc9wrc/KSc87vCEEbwR5nk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IUlFqiQmUXh7ldvjahgfzvT0wkhtPRkXXJXr7Hc0hYSwvH3Nrw261qMjwwZnDG8cS
         Jg7LaK4BNLnZwjqt7NY6MCnEkLuccHodhVOnOVCvfnGMPH2100QdlhIvlBBDTcI/sP
         m3TvWHF9qqqs6c23fgocUaMfzP2762AURcw82oAes2WPFPRkBAD27bl4P9xh639S8b
         MLb6A64xx2JmojfC+oHtAQ8/EdrGIUcn0RbFkx0X+GA9fJZRTurFqCIN3A73Cz5K4q
         uGE6cmsRwYqJOpzTOpMGh2ZIjMin7BDs1dmLW05u4PyMScLACeBFFxfljkKMwX4g2R
         UPp3rrbggQI4Q==
Message-ID: <f153bb62-ec3c-c16d-5b43-f53b5319c2e6@kernel.org>
Date:   Wed, 22 Feb 2023 19:32:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] Mips: ls2k1000: dts: add the display controller
 device node
Content-Language: en-US
To:     suijingfeng <suijingfeng@loongson.cn>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20230222165514.684729-1-suijingfeng@loongson.cn>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230222165514.684729-1-suijingfeng@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2023 17:55, suijingfeng wrote:
> The display controller is a pci device, it's pci vendor id is
> 0x0014, it's pci device id is 0x7a06.
> 
> Signed-off-by: suijingfeng <suijingfeng@loongson.cn>
> ---
>  .../boot/dts/loongson/loongson64-2k1000.dtsi  | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi b/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
> index 8143a61111e3..a528af3977d9 100644
> --- a/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
> +++ b/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
> @@ -31,6 +31,18 @@ memory@200000 {
>  			<0x00000001 0x10000000 0x00000001 0xb0000000>; /* 6912 MB at 4352MB */
>  	};
>  
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		display_reserved: framebuffer@30000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x0 0x30000000 0x0 0x04000000>; /* 64M */
> +			linux,cma-default;
> +		};
> +	};
> +
>  	cpu_clk: cpu_clk {
>  		#clock-cells = <0>;
>  		compatible = "fixed-clock";
> @@ -198,6 +210,15 @@ sata@8,0 {
>  				interrupt-parent = <&liointc0>;
>  			};
>  
> +			display-controller@6,0 {
> +				compatible = "loongson,ls2k1000-dc";
> +
> +				reg = <0x3000 0x0 0x0 0x0 0x0>;
> +				interrupts = <28 IRQ_TYPE_LEVEL_LOW>;
> +				interrupt-parent = <&liointc0>;
> +				memory-region = <&display_reserved>;

NAK. Test your code against the bindings you send. It's the same
patchset. You basically send something which the same moment is incorrect.

Best regards,
Krzysztof

