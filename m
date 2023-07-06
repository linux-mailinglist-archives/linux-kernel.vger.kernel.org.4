Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D077496FE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 10:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbjGFICa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 04:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjGFIC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 04:02:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA12121
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 01:02:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12AFB618B8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 08:02:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94CCC433C7;
        Thu,  6 Jul 2023 08:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688630547;
        bh=6QpwKPmnJCc+Qn4RbnyQAK3huFIb15xha54+tnXJrdU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rz98atuOb83fjJuTXqpzUca5rAo9TjySUdzPYu4ldVibHR1zHrCBKMxehu9WUQmEY
         9PTiM1ChwrCXD+ODKt4LQuPltdSxW3td1faHTEsdgfNhBMehBdq5mEkPRW1RlM5xkc
         qqbFXtKKHt+SL6NNNk6mic/imQLwP0SrTu4tX2Nvhh9duqinFrC/UwWV3vbX3SCVh3
         5c+i750b6JtQy3ktRSpDjKF28/wQ969rAnqdmxFA7UlJZUfv3X6B/iDYL9n1E0uuQ5
         QRvYlcp96LWibhMzAIwHDvgvghV5/zNbhT1J8k6tuLEIS/WMfLl8rOHPfTu3BfXYST
         xWVZLBXBXc6/w==
Date:   Thu, 6 Jul 2023 11:02:22 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Ratheesh Kannoth <rkannoth@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.kubiak@intel.com, sgoutham@marvell.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        sbhatta@marvell.com, gakula@marvell.com, schalla@marvell.com,
        hkelam@marvell.com
Subject: Re: [PATCH net v1] octeontx2-af: Promisc enable/disable through mbox
Message-ID: <20230706080222.GT6455@unreal>
References: <20230706042705.3235990-1-rkannoth@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706042705.3235990-1-rkannoth@marvell.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 09:57:05AM +0530, Ratheesh Kannoth wrote:
> In legacy silicon, promiscuous mode is only modified
> through CGX mbox messages. In CN10KB silicon, it is modified
> from CGX mbox and NIX. This breaks legacy application
> behaviour. Fix this by removing call from NIX.
> 
> Fixes: d6c9784baf59 ("octeontx2-af: Invoke exact match functions if supported")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> 
> ---
> ChangeLog
> 
> v0 -> v1: Fix 80 lines checkpatch warnings
> ---
>  .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 11 ++-------
>  .../marvell/octeontx2/af/rvu_npc_hash.c       | 23 +++++++++++++++++--
>  2 files changed, 23 insertions(+), 11 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
