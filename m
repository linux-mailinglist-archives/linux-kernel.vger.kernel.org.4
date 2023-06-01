Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A7B71F3BF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 22:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbjFAUVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 16:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjFAUVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 16:21:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED5A10EB;
        Thu,  1 Jun 2023 13:20:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F5F56495F;
        Thu,  1 Jun 2023 20:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E419FC4339B;
        Thu,  1 Jun 2023 20:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685650819;
        bh=tZKKg0LORH8+7Jf9bqksdik1OnIaetPXfVTt/qqjvyk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rIkomw20u6mEVDMn/IOEschDnoMpN2fPCMMXA8EoUDTpSMD91rxyy4KITCCT/5Twq
         H/H6pjARN6F0tDaeAeV4qqRHTItgCy0RlCGe8UQfWCBAr9wyCH1xeiMcwXITkkmYBi
         YaEs+RCqjaEAY/xPTDQIaWqICXicsvHA47LjbfEO+lhTdicr5TW3/dIVoi9sDXBS8q
         wZ6yZE5JJOMpjdjbibUuwjsec2ihWAcFq5tppCHuduoshy3uk8mq8Mk2ZIpdWHUHD/
         mCpCz0CXq708hpaP3/LKqqGTA9hqOdAUe//xp0Qf07/hBTlgD2M7FBIqJmvagj3LhU
         N5FlL/a0EUOpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C58B0C43162;
        Thu,  1 Jun 2023 20:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: perf: Fix callchain parse error with kernel tracepoint
 events
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168565081980.8603.14671777947375742178.git-patchwork-notify@kernel.org>
Date:   Thu, 01 Jun 2023 20:20:19 +0000
References: <20230601095355.1168910-1-ism.hong@gmail.com>
In-Reply-To: <20230601095355.1168910-1-ism.hong@gmail.com>
To:     Ism Hong <ism.hong@gmail.com>
Cc:     linux-riscv@lists.infradead.org, ism.hong@realtek.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu,  1 Jun 2023 17:53:55 +0800 you wrote:
> For RISC-V, when tracing with tracepoint events, the IP and status are
> set to 0, preventing the perf code parsing the callchain and resolving
> the symbols correctly.
> 
>  ./ply 'tracepoint:kmem/kmem_cache_alloc { @[stack]=count(); }'
>  @:
>  { <STACKID4294967282> }: 1
> 
> [...]

Here is the summary with links:
  - riscv: perf: Fix callchain parse error with kernel tracepoint events
    https://git.kernel.org/riscv/c/9a7e8ec0d4cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


