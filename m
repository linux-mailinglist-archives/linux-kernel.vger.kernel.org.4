Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5C475087D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjGLMjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGLMjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:39:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C09B10F2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:39:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36DA3617A4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 12:39:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23119C433C7;
        Wed, 12 Jul 2023 12:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689165546;
        bh=2G6y5g6BO5AA9+KodQorTlrJ1hYxvQ5qjHQHxScxn/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XvSoyALBT91Fzs4+F58gLJK3K1FzI/Rqc9tttvQBNKq99Tvrj2tIbxMdRvLCj8Z5v
         v5IFyndc2xRXZxzuc70J3eVgtjewhUDkCuwDWdDdz6RqLcXVvzF6/QP3ptUtePZX08
         lom9aU/h2qraVdztS7vwiWtKaleVFv3TB6gNVw6hm745xcz3w1wfeH48oXujXNPmft
         +HdoTHR1AqAOtPY574zMhhc3sx+6zyzJsNOeLiEbky/3IY3qq/Q3HjARg4F2cxx5N/
         fKpg/Rix4fR6MrIBMZLhVTDVehbbn0LMWArHxhbi99LAGGLFUeBhwqEWueTLYEJSkk
         vCH07tgLm/u7w==
Date:   Wed, 12 Jul 2023 15:39:02 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net PATCH 1/3] octeontx2-af: Fix hash extraction mbox message
Message-ID: <20230712123902.GB41919@unreal>
References: <20230712111604.2290974-1-sumang@marvell.com>
 <20230712111604.2290974-2-sumang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712111604.2290974-2-sumang@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 04:46:02PM +0530, Suman Ghosh wrote:
> As of today, hash extraction mbox message response supports only the
> secret key. This patch adds support to extract both hash mask and hash
> control along with the secret key. These are needed to use hash
> reduction of 128 bit IPv6 address to 32 bit.
> 
> Fixes: a95ab93550d3 ("octeontx2-af: Use hashed field in MCAM key")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> ---
>  .../net/ethernet/marvell/octeontx2/af/mbox.h  | 16 ++--
>  .../marvell/octeontx2/af/rvu_npc_hash.c       | 80 +++++++++++--------
>  .../marvell/octeontx2/af/rvu_npc_hash.h       | 13 +--
>  3 files changed, 67 insertions(+), 42 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
