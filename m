Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A5B731F9D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 20:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237138AbjFOSAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 14:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjFOSAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 14:00:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637D7294C;
        Thu, 15 Jun 2023 11:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D43AD6226B;
        Thu, 15 Jun 2023 18:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29C06C433CB;
        Thu, 15 Jun 2023 18:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686852023;
        bh=Imb3WG7QI8cil1kPmzmNUNmJVrOdNvIhZQQyApYC8nw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XJPmGYRrUIzmrBfArHQF8Ry4unq7pMbbzC03vCvsSD/ZQSoFQTv7rme0Fj8eNEvo0
         yoj8Vrm1GHG0cdlnVnahueux46kBFlj+gBZUL9mTGeCHywFbnsSfsCcayOhb6MjZgX
         czLOu7hxuOgZQATOMUH7s7c1PfAFXf+vfXlXM/ycDjLS+YQH3IpgVPr3Ku/Lzg7Gwr
         0K349CUhNh9ApEE+yieYrsytVck60j4Tyhp6rzQu/MpmTDqkOI76qS0H94eHalbFDj
         Pz9zYYKZNYqLnGT4iVRxdY8xp+9qL7n/oFOdd4U2uCIolzKMHs2NOJCbU+kmXHjYly
         PHWRawnPYcj5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03F78C395E0;
        Thu, 15 Jun 2023 18:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove i_xattr_sem to avoid deadlock and
 fix the original issue
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168685202301.7502.14081948087591121398.git-patchwork-notify@kernel.org>
Date:   Thu, 15 Jun 2023 18:00:23 +0000
References: <20230613233940.3643362-1-jaegeuk@kernel.org>
In-Reply-To: <20230613233940.3643362-1-jaegeuk@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, stable@vger.kernel.org
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

On Tue, 13 Jun 2023 16:39:40 -0700 you wrote:
> This reverts commit 27161f13e3c3 "f2fs: avoid race in between read xattr & write xattr".
> 
> That introduced a deadlock case:
> 
> Thread #1:
> 
> [122554.641906][   T92]  f2fs_getxattr+0xd4/0x5fc
>     -> waiting for f2fs_down_read(&F2FS_I(inode)->i_xattr_sem);
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: remove i_xattr_sem to avoid deadlock and fix the original issue
    https://git.kernel.org/jaegeuk/f2fs/c/c1ac6e02b5fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


