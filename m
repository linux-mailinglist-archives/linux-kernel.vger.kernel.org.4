Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADF76E7CB0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbjDSOat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbjDSOah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:30:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD04B464
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:30:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2023363771
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C657C433A4;
        Wed, 19 Apr 2023 14:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681914622;
        bh=CLPBCvnLBPNDhkb3p5LS+h+PE2cDwvg/S4UXs4J1CbE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=i11vCd7wd6FsvgKK3GuPKKQHxXINchgPooH7ZUEOJyIkihbGVuiAL0bMUJRnRTHAV
         1/nLznGDAGFzPg4E5I/YHcUL4+2QO6/3Mp4DFRwlIxyi5ZvnFAZ+EMgfKp1jXNLXCm
         xH4YiIFpUkvL8JzyfhA60sFX0GG0yAC/iwFLKV8zd1c3XrykMfGkp39YSXLFDg8HVW
         QKLqyFf5a2YmmQQcaB8EnBSKcra9Gr8WA/6LWlXbGVO1PchDf4O6z5zE0/T4cpBpN3
         yaIBB+JU0YN5nUsmVtQZpg3J2qPpXRIVURkqjvTFU29HGHVwZoi6JFIb98b86hlrHz
         f9oaGrWupUA+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 667E2E330AB;
        Wed, 19 Apr 2023 14:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Revert "riscv: Set more data to cacheinfo"
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168191462241.22791.9394039484769649395.git-patchwork-notify@kernel.org>
Date:   Wed, 19 Apr 2023 14:30:22 +0000
References: <20230308064734.512457-1-suagrfillet@gmail.com>
In-Reply-To: <20230308064734.512457-1-suagrfillet@gmail.com>
To:     Song Shuai <suagrfillet@gmail.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        pierre.gondois@arm.com, conor.dooley@microchip.com,
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

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed,  8 Mar 2023 14:47:34 +0800 you wrote:
> This reverts commit baf7cbd94b5688f167443a2cc3dcea3300132099.
> 
> There are some duplicate cache attributes populations executed
> in both ci_leaf_init() and later cache_setup_properties().
> 
> Revert the commit baf7cbd94b56 ("riscv: Set more data to cacheinfo")
> to setup only the level and type attributes at this early place.
> 
> [...]

Here is the summary with links:
  - Revert "riscv: Set more data to cacheinfo"
    https://git.kernel.org/riscv/c/6a24915145c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


