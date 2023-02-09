Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222BD6914C8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 00:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjBIXlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 18:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjBIXk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 18:40:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C366D8D5
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 15:40:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC107B8237F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 23:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 76D32C433D2;
        Thu,  9 Feb 2023 23:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675986017;
        bh=tBO9rl6wLLIEb6LYMFEVhbFpu0eTRNNEGdf0K5Z2O1w=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=N8xZmUCq0S4MI9tSIskysBA4ShHOBs77JhI9BsQ/ta6qOney2e/BGxLCFLrMaQ+Kn
         knDAy/x0+s3LCCiU1aHSgHTl5MsftQbXF05Siw/YBGIOqCd1p6nua2VeVdeJ5QL22D
         TB6QtsXiwm38zWSFPxYRJqHFekLg6dFMDPRecQjCRWvqGhcJ88ucfF18NjQGxx/13S
         PiZnHSF9kaH9KvjkO+VImg3Mccy26HJdG0FMvE6GFgBHnSOJqQA69OJf3UITgVAjJf
         IFCYpm++u6r4IGktV3AErgXE6YYpLmOFPH7mQUxalwx32ri0JL8l879l2fgeHKqAld
         ICJIV+cJt+YeA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5A603E49FB0;
        Thu,  9 Feb 2023 23:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2] riscv: Fixup race condition on PG_dcache_clean in
 flush_icache_pte
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167598601736.16272.8641782921035193984.git-patchwork-notify@kernel.org>
Date:   Thu, 09 Feb 2023 23:40:17 +0000
References: <20230127035306.1819561-1-guoren@kernel.org>
In-Reply-To: <20230127035306.1819561-1-guoren@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, arnd@arndb.de,
        palmer@rivosinc.com, conor.dooley@microchip.com,
        apatel@ventanamicro.com, atishp@atishpatra.org,
        mark.rutland@arm.com, bjorn@kernel.org, tongtiangen@huawei.com,
        ajones@ventanamicro.com, andrew@sifive.com,
        linux-kernel@vger.kernel.org, guoren@linux.alibaba.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 26 Jan 2023 22:53:06 -0500 you wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> In commit 588a513d3425 ("arm64: Fix race condition on PG_dcache_clean
> in __sync_icache_dcache()"), we found RISC-V has the same issue as the
> previous arm64. The previous implementation didn't guarantee the correct
> sequence of operations, which means flush_icache_all() hasn't been
> called when the PG_dcache_clean was set. That would cause a risk of page
> synchronization.
> 
> [...]

Here is the summary with links:
  - [V2] riscv: Fixup race condition on PG_dcache_clean in flush_icache_pte
    https://git.kernel.org/riscv/c/950b879b7f02

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


