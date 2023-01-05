Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833F465F76E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 00:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbjAEXA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 18:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbjAEXAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 18:00:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45644882B
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 15:00:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9FF30B81BFA
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 23:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B40FC433F2;
        Thu,  5 Jan 2023 23:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672959616;
        bh=D5EHiJpROSuZ6P66ntkt9Xvxx1BijBthqB0kyLC3nmo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VEYHaVbdtW1o3ZVcYpOmTq9pILMnqMklO0d56bWmskp84HvyAxtrkVNSQXLi9w1q0
         zy3853jqxRn/e3f4rTiCmj4yAi+C7NbwlnPlgPltF93DF7D/i2dlVaNZifoBA5atrx
         f8drl/AnI3LWBvkYTpwBFmMOmh+YdiZD9BGqTDRKU8sdBV8qQ6An4dOk3S8BS5fXGv
         otqdlZLHikVXWyw78mro6MJf7ZlCQk4gUpfh+YtOJml8F4pU0vSH4j5KdlKb36ULB9
         pVBwNaY2k0bcpVAMujm4e/TLjUzbrVaW4qUBZ3gpkclhHBfOHXbs9BCKwzxNzwoA0K
         f75Cy+7cmBShA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B355E4D007;
        Thu,  5 Jan 2023 23:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: uaccess: fix type of 0 variable on error in get_user()
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167295961617.27641.4395161455545202996.git-patchwork-notify@kernel.org>
Date:   Thu, 05 Jan 2023 23:00:16 +0000
References: <20221229170545.718264-1-ben-linux@fluff.org>
In-Reply-To: <20221229170545.718264-1-ben-linux@fluff.org>
To:     Ben Dooks <ben-linux@fluff.org>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 29 Dec 2022 17:05:45 +0000 you wrote:
> If the get_user(x, ptr) has x as a pointer, then the setting
> of (x) = 0 is going to produce the following sparse warning,
> so fix this by forcing the type of 'x' when access_ok() fails.
> 
> fs/aio.c:2073:21: warning: Using plain integer as NULL pointer
> 
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> 
> [...]

Here is the summary with links:
  - riscv: uaccess: fix type of 0 variable on error in get_user()
    https://git.kernel.org/riscv/c/b9b916aee671

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


