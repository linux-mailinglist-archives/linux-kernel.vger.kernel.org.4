Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A594A691177
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 20:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjBITkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 14:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBITkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 14:40:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68ED0457E6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 11:40:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E696B816DD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 19:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9FCA6C4339B;
        Thu,  9 Feb 2023 19:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675971618;
        bh=TgmrnC/M5HXZGBRzFdINy6NLvEYYMbHiA4VgIM1fb3k=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Zobd8bf4shU+7TgwlyO/tvuH9iFjLJUi8MXNllc+GXQL3pHFMBS8w+XB8dDIMXSHj
         6a01mwz6I4dcdvxwqVj2pcnnTUXHS6I+VkeEs3kvxjCN8j1myMfdNbUFSnPNqZPsrx
         FZQul7aKl+oqUwID1hnxPbiSe5UNLcRQ4YBh57CcsRxO1BfdLtHB5kzi+jwq5W4hfo
         hOTDQIv/FE2T7a8lOdKWziWHjbiZC4UBoeYxnW49WDwOyGZ4eipd/9DKxKxENgD4Cj
         LKQgYzSUveyTxGL2vkz2efzE5oWlJQvgJ5zWED160MZrMpfR+gi15zHcdqL3bNMkCd
         HRHV7e61LyL1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8750EE21EC9;
        Thu,  9 Feb 2023 19:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] riscv: stacktrace: Fix missing the first frame
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167597161855.28032.12085099343569341369.git-patchwork-notify@kernel.org>
Date:   Thu, 09 Feb 2023 19:40:18 +0000
References: <20221207025038.1022045-1-liushixin2@huawei.com>
In-Reply-To: <20221207025038.1022045-1-liushixin2@huawei.com>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     linux-riscv@lists.infradead.org, conor@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, changbin.du@intel.com,
        linux-kernel@vger.kernel.org
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

On Wed, 7 Dec 2022 10:50:38 +0800 you wrote:
> When running kfence_test, I found some testcases failed like this:
> 
>  # test_out_of_bounds_read: EXPECTATION FAILED at mm/kfence/kfence_test.c:346
>  Expected report_matches(&expect) to be true, but is false
>  not ok 1 - test_out_of_bounds_read
> 
> The corresponding call-trace is:
> 
> [...]

Here is the summary with links:
  - [v2] riscv: stacktrace: Fix missing the first frame
    https://git.kernel.org/riscv/c/cb80242cc679

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


