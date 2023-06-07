Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057E2726760
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjFGRat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjFGRab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:30:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604E4210C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 10:30:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFCE8641FD
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 17:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F66FC433EF;
        Wed,  7 Jun 2023 17:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686159025;
        bh=rMJ3ZHFNgdmlUuFM0xas0L1YWaRZl3xS0/0vxWWbySo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=a2SiPzTR8J6pyrOsbeOb69AYtOBZmdC0ghJT8cV6J2ILLBxbTxW/qb7N5euoDTGQm
         Z9b6877HcuZCQBmtOwc5JSlt+iznnLD8XhQVTgXDgZrDQlDSkXOHQBX0fyqcuH8Gdl
         hnPonUmxhxXtTcRQ7lp0ev0lAW/+0/9HrijJnWU4BTmGMNzamvvr3Q0nfcWOW9wbqb
         fLkjJpYtveFZjYRlmfPCoUwZWaxccxkBU2FALAVNP+VurWZcv1TKButLIOdNwpUgSK
         C5fyYBEMMmtP/PtPSWSWg7NC55FqxyCSKREQC+jwMgnoQh+dGfH5Fty5a2IzUPCnLB
         ok7KLYWvaL3Qg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 24B87E4D016;
        Wed,  7 Jun 2023 17:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: do more sanity check on inode
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168615902514.7521.467509343163618820.git-patchwork-notify@kernel.org>
Date:   Wed, 07 Jun 2023 17:30:25 +0000
References: <20230531014055.3904072-1-chao@kernel.org>
In-Reply-To: <20230531014055.3904072-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

On Wed, 31 May 2023 09:40:55 +0800 you wrote:
> There are several issues in sanity_check_inode():
> - The code looks not clean, it checks extra_attr related condition
> dispersively.
> - It missed to check i_extra_isize w/ lower boundary
> - It missed to check feature dependency: prjquota, inode_chksum,
> inode_crtime, compression features rely on extra_attr feature.
> - It's not necessary to check i_extra_isize due to it will only
> be assigned to non-zero value if f2fs_has_extra_attr() is true
> in do_read_inode().
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: do more sanity check on inode
    https://git.kernel.org/jaegeuk/f2fs/c/3ef38938753c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


