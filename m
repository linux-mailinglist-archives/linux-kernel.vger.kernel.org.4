Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD0A6CA9D1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjC0QAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbjC0QAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:00:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453013A8F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:00:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED6CDB816D4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2FF38C433AE;
        Mon, 27 Mar 2023 16:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679932820;
        bh=UosN6WQmhU0gC9d+forj880ODhU3d/cXAP2nSX62Ok8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KrsvI2JR/EF6ofUmO0G+zXz6nAti6v81lp4d0Hm3kNYM32oxxUjdsBymVpUy5Smoa
         olnw4Pn360MKZlVQCW/JUGnxgfLA53hL5JzVS6G6OW7L/ysbtQgaTmor35a54Ig+oJ
         axT62tuk+Zy7/3ijnrnbx2jaAnjGcziZGOCMzdj0aPZvIt3v9SDLQsuOfbkXKyc/IB
         fLlFegXI473a9e9WVZVbcmWUr0giKFIASeGOkC1YE26HF/WzBsKZPRilOt9PvSpasF
         pcguNWlGVjrRc6Re6NYHH39Sy3JBH+lkxh2sTWlW5aFsOWSBtWuthIFQK2mQeDTtj7
         FCZ2noenDN9pA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0454AE52505;
        Mon, 27 Mar 2023 16:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: compress: fix to call
 f2fs_wait_on_page_writeback() in f2fs_write_raw_pages()
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167993282000.32120.2964162432731935413.git-patchwork-notify@kernel.org>
Date:   Mon, 27 Mar 2023 16:00:20 +0000
References: <20230320172218.59628-1-frank.li@vivo.com>
In-Reply-To: <20230320172218.59628-1-frank.li@vivo.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org, hch@lst.de, hanqi@vivo.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 21 Mar 2023 01:22:18 +0800 you wrote:
> BUG_ON() will be triggered when writing files concurrently,
> because the same page is writtenback multiple times.
> 
> 1597 void folio_end_writeback(struct folio *folio)
> 1598 {
> 		......
> 1618     if (!__folio_end_writeback(folio))
> 1619         BUG();
> 		......
> 1625 }
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: compress: fix to call f2fs_wait_on_page_writeback() in f2fs_write_raw_pages()
    https://git.kernel.org/jaegeuk/f2fs/c/08a8457cfd78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


