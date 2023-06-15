Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA66731F96
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 20:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjFOSAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 14:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjFOSAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 14:00:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41054273D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 11:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF9E962243
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 18:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2758AC433C9;
        Thu, 15 Jun 2023 18:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686852023;
        bh=zTjNcEllzl3aLrGkjNfY3daqXIXZvvpMNXCwS2+qpDU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GKnv4zWtK5XKi9hCU3J3r4hYo24rHwy7vALUfpfIV231fVvnATfVQruVA7YGYZzE/
         8/U/YYOOCVyy7NjdP1QVHR58sLvoGMA8CUoLwK4pJj5VtrzQA9FYz2Bioa86VYLbP+
         E0gotbRFiEx6iw5Xz0cQhQaJtxN9J5NPCIXJ6CD/VRaSanTLZSfqDWvyFOWbEQS/0P
         8iNvMSrP+vvNkosTx0lHRKTjaup61Ejz9uA4Cc9hcWTKQSMGvnemyVh3Q3PHVp6seQ
         EHjjCSLDv42Q5rFZMhwIz5p2jahdOs8TSTzEGdjb5ih9qbS1lzTk39ZlyLbhwVyU2A
         BMuO6HBFvKO5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0E835E29F32;
        Thu, 15 Jun 2023 18:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: check zone write pointer points to the end
 of zone
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168685202305.7502.13424680817113801085.git-patchwork-notify@kernel.org>
Date:   Thu, 15 Jun 2023 18:00:23 +0000
References: <20230612233203.1571983-1-daeho43@gmail.com>
In-Reply-To: <20230612233203.1571983-1-daeho43@gmail.com>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        daehojeong@google.com
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

On Mon, 12 Jun 2023 16:32:03 -0700 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> We don't need to report an issue, when the zone write pointer already
> points to the end of the zone, since the zone mismatch is already taken
> care.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: check zone write pointer points to the end of zone
    https://git.kernel.org/jaegeuk/f2fs/c/7faa5e31fcc1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


