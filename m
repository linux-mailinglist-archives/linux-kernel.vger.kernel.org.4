Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABF35E6309
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbiIVNAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiIVM7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 08:59:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE4E25C59
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 05:59:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7DD36B83645
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 12:59:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B48C433D6;
        Thu, 22 Sep 2022 12:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663851583;
        bh=09koZeVSGebO2PnQHAwVgSzAwlSrsdXFkaq3SF5x/3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pgs1NMeZO7bc6MfzR7opEttjGCZsF0e15D7Z8mdkSBrUwO8a0ZXxdYUV0ykJ12x5l
         zRxMcWYJxgYkLUv4jXkVQ5qbDiZqZLI4oEI7Hnm8U7TvWweOz6dRy/XVP6O5LdPJSv
         JQW8k39CEbwy4J3DBYKdwHWgUM3X4oht58Iiwk0w7rMfhi+OtKNRnWoRCFF3eAparw
         8qKqnB4fwQZCVCJ/hgfonplKXjqQIUS5LCW3PCWAIZEsQI5txOkIuYvj0nd89ubBCU
         38K7ebJ9xj3rttNPCYZKRtgJcb6I+E7xLIVHLv0MG3pNoOO/vjIkD/uWi7JUFpuC9f
         vXMPgeBQF4D6A==
Received: by pali.im (Postfix)
        id A4315858; Thu, 22 Sep 2022 14:59:40 +0200 (CEST)
Date:   Thu, 22 Sep 2022 14:59:40 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: dts: turris1x.dts: Fix NOR partitions labels
Message-ID: <20220922125940.6bmrr7mnddz3ddgb@pali>
References: <20220830225500.8856-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220830225500.8856-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 August 2022 00:55:00 Pali Rohár wrote:
> Partition partition@20000 contains generic kernel image and it does not
> have to be used only for rescue purposes. Partition partition@1c0000
> contains bootable rescue system and partition partition@340000 contains
> factory image/data for restoring to NAND. So change partition labels to
> better fit their purpose by removing possible misleading substring "rootfs"
> from these labels.
> 
> Fixes: 54c15ec3b738 ("powerpc: dts: Add DTS file for CZ.NIC Turris 1.x routers")
> Signed-off-by: Pali Rohár <pali@kernel.org>

Ping?

> ---
>  arch/powerpc/boot/dts/turris1x.dts | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/turris1x.dts b/arch/powerpc/boot/dts/turris1x.dts
> index b7635f0b87a9..64c0dd733e40 100644
> --- a/arch/powerpc/boot/dts/turris1x.dts
> +++ b/arch/powerpc/boot/dts/turris1x.dts
> @@ -263,21 +263,21 @@
>  				};
>  
>  				partition@20000 {
> -					/* 1.7 MB for Rescue Linux Kernel Image */
> +					/* 1.7 MB for Linux Kernel Image */
>  					reg = <0x00020000 0x001a0000>;
> -					label = "rescue-kernel";
> +					label = "kernel";
>  				};
>  
>  				partition@1c0000 {
>  					/* 1.5 MB for Rescue JFFS2 Root File System */
>  					reg = <0x001c0000 0x00180000>;
> -					label = "rescue-rootfs";
> +					label = "rescue";
>  				};
>  
>  				partition@340000 {
> -					/* 11 MB for TAR.XZ Backup with content of NAND Root File System */
> +					/* 11 MB for TAR.XZ Archive with Factory content of NAND Root File System */
>  					reg = <0x00340000 0x00b00000>;
> -					label = "backup-rootfs";
> +					label = "factory";
>  				};
>  
>  				partition@e40000 {
> -- 
> 2.20.1
> 
