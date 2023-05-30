Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCE77171E2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbjE3Xkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbjE3Xkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:40:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79826191
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:40:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC42D63545
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 23:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54A58C433A8;
        Tue, 30 May 2023 23:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685490024;
        bh=H9VqBAbZl2Fz3jcWASfHBQXr+VWaknCHrI+JGkA2M7I=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=JEd3jMOSxkRA25cxJZQj+PH7QXy2mHT5dhF1np91C5mvtwruhLNQjF05SpS9MX+xV
         xXHGiCRdtPMUskZmY3GoYdPH7DSUCzELY702nliohHfJbfmuXMmrOrTL58GcMkiXGS
         5hhyRziWIrfJTn+uPE/3cgI24DdW/BTXRDNBvsT3KAlakPVvW5PF3kE2XSYoTD5LrQ
         4xIST7nT8C+efwbd4haMOP8zLRYNvlAzt3Woe2J7l/m3AgIiHTiftCg1jKXHJ0AES+
         P3rXnXLNYBkTISxN52Engk4u5tt9UMIFXbZ1ixyTIBIuE1g2b6SLfxJ42rsKmpBxqb
         db/rKKoBaOExA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35AC6E21ED8;
        Tue, 30 May 2023 23:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: flush error flags in workqueue
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168549002421.8773.313920209333136970.git-patchwork-notify@kernel.org>
Date:   Tue, 30 May 2023 23:40:24 +0000
References: <20230518021412.2037728-1-chao@kernel.org>
In-Reply-To: <20230518021412.2037728-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Thu, 18 May 2023 10:14:12 +0800 you wrote:
> In IRQ context, it wakes up workqueue to record errors into on-disk
> superblock fields rather than in-memory fields.
> 
> Fixes: 1aa161e43106 ("f2fs: fix scheduling while atomic in decompression path")
> Fixes: 95fa90c9e5a7 ("f2fs: support recording errors into superblock")
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3] f2fs: flush error flags in workqueue
    https://git.kernel.org/jaegeuk/f2fs/c/36e63b159dd6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


