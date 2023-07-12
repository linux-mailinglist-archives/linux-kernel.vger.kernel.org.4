Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF9175087E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbjGLMjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbjGLMjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:39:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D405C1981
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:39:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71FF06177D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 12:39:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE1BC433C8;
        Wed, 12 Jul 2023 12:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689165557;
        bh=V30cr/gIRf6hxwNzJhqq8lbR26epNHKX64BaObglznY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mROMGWvAOwvuk+ntgC9S66YVGhyyXWYKjFYvw3h66wtIyDYpPLpPiCQRRGSEi1zCt
         SORGcejBdCx/dFrTORlu0rXiww4RXLeR/O0p1w39FNA3tVwLqO6AbLX8czY9aldPy1
         JzTpZDUQLdZDlbSKzWy/+OVukhd5qpz5AOL8J0WtJMeYQ0eZEaXlfTmXxGuOodjSgF
         /BFuJIPqEiX98ORwCh2h2RJ0SB2HTrLicfddol2Jvw7mJMxLNAZLMtE/+eShyEldS5
         9p0KBlgcgJZypSoPF7sZ1HasO6ngnOXfQF7T9xV/jlieikXRdPLzpv2bs9fiNQHx/U
         lsvae1yDsFWHA==
Date:   Wed, 12 Jul 2023 15:39:14 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net PATCH 2/3] octeontx2-af: Fix hash extraction enable
 configuration
Message-ID: <20230712123914.GC41919@unreal>
References: <20230712111604.2290974-1-sumang@marvell.com>
 <20230712111604.2290974-3-sumang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712111604.2290974-3-sumang@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 04:46:03PM +0530, Suman Ghosh wrote:
> As of today, hash extraction was enabled by default for the default
> MKEX profile. This patch fixes that and enable the support based on
> customer specific MKEX profile.
> 
> Fixes: a95ab93550d3 ("octeontx2-af: Use hashed field in MCAM key")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> ---
>  .../marvell/octeontx2/af/rvu_npc_fs.c         | 22 +++++++---
>  .../marvell/octeontx2/af/rvu_npc_fs.h         |  4 ++
>  .../marvell/octeontx2/af/rvu_npc_hash.c       | 43 ++++++++++++++++++-
>  .../marvell/octeontx2/af/rvu_npc_hash.h       |  8 ++--
>  4 files changed, 65 insertions(+), 12 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
