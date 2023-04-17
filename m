Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7F36E541D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 23:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjDQVuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 17:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjDQVuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 17:50:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945391BD7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 14:50:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BF24623E9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 21:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97104C4339B;
        Mon, 17 Apr 2023 21:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681768218;
        bh=k/iLWe5JIRygwm7y4JmXtyf4IstYXvnRZ1SRfnjZKp4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=pZtQa/qQeVA6f4wkVvGLuHQe5KfTq2WmCtnVGqo2Ypmx0HvSm6xkYIe7y36Kno5/w
         V8zAyalWKI2igzwUnDpvaxrI20AMFY1tWhVcOmV5LgACFfewFbgJwBnuC8Bbyf6oUl
         U807MmZUak4x8TZ9FmL9CbVgOkqOHBYittUvGXfDDD4PdfS32e50/++V5e2JnVj9Ai
         sfZgqFYqOEXtx/fqJfh5L85pU+Su4kxF7K93fAn1meDA54NEtj1PSPxnFTTvq7QK8l
         SgXNLDYc8qfzXoROBDOiTyxu3ijBGeDvUk+QZ4+Z5UIHp7Z9I6Nk24EvUD1oKAgXWI
         ZAL0c476T/naQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 69D1FE3309F;
        Mon, 17 Apr 2023 21:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove bulk remove_proc_entry() and
 unnecessary kobject_del()
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168176821843.10429.17764121899305487542.git-patchwork-notify@kernel.org>
Date:   Mon, 17 Apr 2023 21:50:18 +0000
References: <20230406191629.63024-1-frank.li@vivo.com>
In-Reply-To: <20230406191629.63024-1-frank.li@vivo.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri,  7 Apr 2023 03:16:29 +0800 you wrote:
> Convert to use remove_proc_subtree() and kill kobject_del() directly.
> kobject_put() actually covers kobject removal automatically, which is
> single stage removal.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/f2fs/sysfs.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: remove bulk remove_proc_entry() and unnecessary kobject_del()
    https://git.kernel.org/jaegeuk/f2fs/c/33560f8020c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


