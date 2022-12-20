Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD4B6527B1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 21:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbiLTUP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 15:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234269AbiLTUPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 15:15:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5CF1EC7C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 12:15:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3957CB8122F
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 20:15:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BFAC433EF;
        Tue, 20 Dec 2022 20:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671567311;
        bh=ipegR7OSSzbYG38ubO9ej+f9FSMXHFS82T2UsjxnDTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VnKVkdREKqO0LeOi5L4aB5nfeZ+o6FKV8d3PRnb/YP/8NWsf+SwVOiGKOG6ICeIXd
         gvBtJpth3KJI5umL0phNQMtoduk+doj8TtJD/LLYL5BtUqqjXp+ipvOaISv8tH18ky
         NEA2LGpGmGN2JYSr0PDsNV3+8NEVCPNhVicwMeCMPe6lX9i9fKEL84uWdWBAZDffRm
         Sg5idBWVGVwPxSxMmNluR0CaqZEGA1OqtHQyFGmaxx6frsyo+TJMEoiGsNtLuW0MTo
         4xIwLARZNQE9iVxaXqnwF7iLPpSP2Khig8Ob/W9o+hhtqxS8GWAcYl4Jtk8VTQBICM
         5wkWgikENnjpg==
Received: by pali.im (Postfix)
        id 8002D963; Tue, 20 Dec 2022 21:15:08 +0100 (CET)
Date:   Tue, 20 Dec 2022 21:15:08 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, jbglaw@lug-owl.de,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/5] powerpc/64: Replace -mcpu=e500mc64 by -mcpu=e5500
Message-ID: <20221220201508.b47rg5ii2p6wkrkq@pali>
References: <38a8d765ed9149bc6b5484a7142e3bc59ffa3b1a.1671475543.git.christophe.leroy@csgroup.eu>
 <fa71ed20d22c156225436374f0ab847daac893bc.1671475543.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa71ed20d22c156225436374f0ab847daac893bc.1671475543.git.christophe.leroy@csgroup.eu>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 December 2022 19:45:58 Christophe Leroy wrote:
> E500MC64 is a processor pre-dating E5500 that has never been
> commercialised. Use -mcpu=e5500 for E5500 core.
> 
> More details at https://gcc.gnu.org/PR108149
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Acked-by: Pali Rohár <pali@kernel.org>

> ---
>  arch/powerpc/platforms/Kconfig.cputype | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> index 31cea2eeb59e..29d6be033576 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -249,7 +249,7 @@ config TARGET_CPU
>  	default "power8" if POWER8_CPU
>  	default "power9" if POWER9_CPU
>  	default "power10" if POWER10_CPU
> -	default "e500mc64" if E5500_CPU
> +	default "e5500" if E5500_CPU
>  	default "e6500" if E6500_CPU
>  	default "power4" if POWERPC64_CPU && !CPU_LITTLE_ENDIAN
>  	default "power8" if POWERPC64_CPU && CPU_LITTLE_ENDIAN
> -- 
> 2.38.1
> 
