Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A52613E92
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 20:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJaTzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 15:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJaTzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:55:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3AC13F46;
        Mon, 31 Oct 2022 12:55:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CF0F60BDE;
        Mon, 31 Oct 2022 19:55:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE0FC433D6;
        Mon, 31 Oct 2022 19:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667246105;
        bh=pyVKDV9QrizM1GaBQq4r6UkfjgqRTyFKgmg+DUJEeQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mW9DeEtixxOapdRHvxfLlxaq8LROL7F1QXfcV+G5uXeMnzoTrGmytiX0uHZI+YNzw
         xvT0Sw8CjZRBFt/Q7mkklElI9RtFeYIEPTiAMnIxkpwCGXbZLE05jGHBpXzYNj+uAH
         Jyk6ToZz7whWr+9xodG6dpq4kUxomyK4YvgRy99M8Uq6T94ievbr9ZoMBOO8H+/msf
         n58dXAT+2VGsnqLz8EcAWGDiagcAPLiiEpt5LzZnQYH36hbj/vTbd04IiA/QiKL4xX
         FiwIRacDl3ssyae3g6+FA7eNJ+BYnTRY+9ngedNVDycdGhQZpHiiMeYcVLm2+z2po8
         vSWtzrDwF4nsQ==
Date:   Mon, 31 Oct 2022 19:55:00 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: microchip: fix memory node unit address for
 icicle
Message-ID: <Y2AoFCbQFGnWT48Y@spud>
References: <20221025195643.1215890-1-conor@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025195643.1215890-1-conor@kernel.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 08:56:44PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Evidently I forgot to update the unit address for the 38-bit cached
> memory node when I changed the address in the reg property..
> Update it to match.
> 
> Fixes: 6c1193301791 ("riscv: dts: microchip: update memory configuration for v2022.10")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Applied:
https://git.kernel.org/conor/c/d6105a8b7c160a73ae04054c8921eba80a294146

> ---
>  arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
> index ec7b7c2a3ce2..8ced67c3b00b 100644
> --- a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
> +++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
> @@ -37,7 +37,7 @@ ddrc_cache_lo: memory@80000000 {
>  		status = "okay";
>  	};
>  
> -	ddrc_cache_hi: memory@1000000000 {
> +	ddrc_cache_hi: memory@1040000000 {
>  		device_type = "memory";
>  		reg = <0x10 0x40000000 0x0 0x40000000>;
>  		status = "okay";
> -- 
> 2.38.0
> 
