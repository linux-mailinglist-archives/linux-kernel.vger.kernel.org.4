Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57487171E4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbjE3Xku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbjE3Xkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:40:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7878C18D
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:40:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E418463546
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 23:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 429FAC433A0;
        Tue, 30 May 2023 23:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685490024;
        bh=X2D/1a1qdK0++0GVnVTUuU8tD+5QP3hQ8D+IOu9ggiI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kaHUTYTq6NQmZcM5+V5T+3gOXuTYdbf10V/3EBLA2qEbcu3te5I7w9OIr6xBtxALQ
         FWHU0msvz/mAh4O2EAffmxDSitq1G6xbt166qcVdQ4NwSupHO1Zyz+BWYzvNjmgPoe
         PYkNWnnjaElmGQ8k7kw+ltjvLWIl5cHMqvp588mVwCcOg0EwlU4KgZkGmMnNk5ajFv
         Jid6cfvOowEXsnhVtedK2hLSkOSV1+EgXWS+MYoHboBAmtDeniic41pw6SYVeu38H+
         5gP5ASTJhJo9nsprlT3V/O/aiJXlz5RWj7ORoVYzByUXSUvxbD+2BJ8W74jAhwkIu9
         v3DYWxWuWRzjw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A6DDE21EC5;
        Tue, 30 May 2023 23:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to avoid NULL pointer dereference
 f2fs_write_end_io()
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168549002416.8773.766514446956426834.git-patchwork-notify@kernel.org>
Date:   Tue, 30 May 2023 23:40:24 +0000
References: <20230523061725.650692-1-chao@kernel.org>
In-Reply-To: <20230523061725.650692-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, butterflyhuangxx@gmail.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Tue, 23 May 2023 14:17:25 +0800 you wrote:
> butt3rflyh4ck reports a bug as below:
> 
> When a thread always calls F2FS_IOC_RESIZE_FS to resize fs, if resize fs is
> failed, f2fs kernel thread would invoke callback function to update f2fs io
> info, it would call  f2fs_write_end_io and may trigger null-ptr-deref in
> NODE_MAPPING.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix to avoid NULL pointer dereference f2fs_write_end_io()
    https://git.kernel.org/jaegeuk/f2fs/c/9318465d0e82

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


