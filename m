Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37FA73E0A5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjFZNaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjFZNa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:30:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2BD1A2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 023C660EAB
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 13:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57512C433C9;
        Mon, 26 Jun 2023 13:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687786221;
        bh=uT9iYZr53tRCgJSEQLzD+bSX1zc/7rb1qVF4nDAIp8I=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gu/6k51t3gTRxSghh4OE/qwupRvCcxZrU4lqCTucfl+r9ksecSacAA4Lb5I8UhCo8
         0UN+qqyt8ysWEfES8UjAcSpfq+fMaSS9gjNmExOq59W7W/lY1M4bJDoKEoQsACmwS/
         44AN1HU96oxlDUP/HgkCwa7HhxHfy8YtYiG8Rptr4ZhpFV4n+WgJvKXd7fKRzP5yg6
         MXxuOgUtNfY1Fi1Rc3NBNsTvMZY72Kodc9+G+9a/d39q9sL6HW0YxsaV6xQ2Xs4Wx5
         yhWNf/Gg1BKrREIVwqVcaRWjs+Sxo+xExtWXTdOgr7ZrCX1qQKraanWg8xiCo+6p8E
         VFZpRdn9tHjvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 380FDC4167B;
        Mon, 26 Jun 2023 13:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: refactor struct f2fs_attr macro
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168778622122.24530.10217255719781321675.git-patchwork-notify@kernel.org>
Date:   Mon, 26 Jun 2023 13:30:21 +0000
References: <20230506151604.36890-1-frank.li@vivo.com>
In-Reply-To: <20230506151604.36890-1-frank.li@vivo.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, lkp@intel.com
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

On Sat,  6 May 2023 23:16:03 +0800 you wrote:
> This patch provides a large number of variants of F2FS_RW_ATTR
> and F2FS_RO_ATTR macros, reducing the number of parameters required
> to initialize the f2fs_attr structure.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202304152234.wjaY3IYm-lkp@intel.com/
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v4] f2fs: refactor struct f2fs_attr macro
    https://git.kernel.org/jaegeuk/f2fs/c/6201c478dedc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


