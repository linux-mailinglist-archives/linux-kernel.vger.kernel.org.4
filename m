Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62FC60543B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 01:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJSXxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 19:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiJSXxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 19:53:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FF017534F;
        Wed, 19 Oct 2022 16:53:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FE4061342;
        Wed, 19 Oct 2022 23:53:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69912C433C1;
        Wed, 19 Oct 2022 23:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666223579;
        bh=6kyUB5tKFDB5XUjFi6QCd6MkTS2oO8t5uING/AE0Fjw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qBPIclqEN6ga3sptd0OAkLER6swsxHPJec6x1ajyDUojN8Haz1Rs8MFew5rbT+TbE
         ltLtcAX3exTMIe6KMxj88RYDRQxNEsIom2ddEXEDrkMvGfYVJCgkZX1vovlYfjk1XW
         oV9cUMpG7TlfoXkZ3c9JxpZ9Y17cWj3utqWNtWBPRI2ZSN+oF+JhDHSjWO9T00KJgi
         Jhk/WgOEnpqEGBAMDGWCcHzz1RhSCK5c1uz8WvyeBPuudQa+cJIO9tSpuCGvAWefNd
         /hXaiwj+PspiN+PGUVbe1pCODmjhL1veuwgeqOUOe/RXab4vpP5n0eAbCo8xkkMkYo
         p7YRLTpM5O3CA==
Date:   Wed, 19 Oct 2022 16:52:58 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Wireless <linux-wireless@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Ilan Peer <ilan.peer@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the wireless-next tree with Linus'
 tree
Message-ID: <20221019165258.1ea6daa6@kernel.org>
In-Reply-To: <20221020041440.3f6c1e46@canb.auug.org.au>
References: <20221020032340.5cf101c0@canb.auug.org.au>
        <20221019162324.2baaa7e8@kernel.org>
        <20221020041440.3f6c1e46@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Oct 2022 04:14:40 +1100 Stephen Rothwell wrote:
> > Dunno if this is a glitch or real problem. But it reminds me - I see
> > there is direct wireless -> wireless-next merge without going via
> > Linus's tree. I think you may have mentioned it to us, but not sure
> > if I said this clearly - let's try to avoid such merges. Linus certainly
> > doesn't like when we do net -> net-next merges without sending net to
> > him first and forwarding. I'm not 100% sure why (maybe Steven knows)
> > - whether it's an aesthetic thing or avoiding real issues thing, but
> > either way it's _a_ thing :S  
> 
> Has Linus really complained about you merging the net tree into the
> net-next tree?

I can't find that exchange right now. Maybe it was about merging
back his tree into ours without submitting a PR. Hm.
