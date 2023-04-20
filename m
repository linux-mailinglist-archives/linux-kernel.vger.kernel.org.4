Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC226E9AF6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 19:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjDTRk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 13:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjDTRkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 13:40:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2826E114;
        Thu, 20 Apr 2023 10:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A34D964B07;
        Thu, 20 Apr 2023 17:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0229BC4339C;
        Thu, 20 Apr 2023 17:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682012422;
        bh=g0ksG6nfP361Le8p/mc0obDjhA3uxSOnBqsqKl8TFic=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=H+O4QULsjgMwJYS6AYt1YJg55l10HlZgTvndw5KVKTuHyJgzu/k33R4yXrFpPO5B9
         GxOXfy/0sGByAnoopEwTaHdyugG7tdLJMiI64YuL7/C/AcStOmZOLGEBwcwQbgC9BV
         WY9lGxTse50ZgmDnlyef44MrIqjCSNmDbbdusf88T5rRUGATui1MKMc4xgYOIxFTP3
         g57+yZiDB6UNrjaNfMs9PR9RpM66Fl6Ijx0pOKQQNFkM5HrCn7xqDZ3i1GspQUkMhz
         qpYUrNgVFdbMyKUWVpQjfBYys27G1Y0KPgww9V6AaUOueLFmgChE7RYkqF8nwYECZd
         I6BH3IxR3oTSw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DD154C395C8;
        Thu, 20 Apr 2023 17:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v9 0/1] riscv: Allow to downgrade paging mode from the command
 line
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168201242189.9373.3633169603042394509.git-patchwork-notify@kernel.org>
Date:   Thu, 20 Apr 2023 17:40:21 +0000
References: <20230329050951.66085-1-alexghiti@rivosinc.com>
In-Reply-To: <20230329050951.66085-1-alexghiti@rivosinc.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, corbet@lwn.net,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, conor@kernel.org, ardb@kernel.org,
        bjorn@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 29 Mar 2023 07:09:50 +0200 you wrote:
> This new version gets rid of the limitation that prevented KASAN kernels
> to use the newly introduced parameters.
> 
> While looking into KASLR, I fell onto commit aacd149b6238 ("arm64: head:
> avoid relocating the kernel twice for KASLR"): it allows to use the fdt
> functions very early in the boot process with KASAN enabled by simply
> compiling a new version of those functions without instrumentation.
> 
> [...]

Here is the summary with links:
  - [v9,1/1] riscv: Allow to downgrade paging mode from the command line
    https://git.kernel.org/riscv/c/c070bcfdb2fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


