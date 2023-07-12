Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A299F750D54
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 18:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbjGLQAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 12:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjGLQAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:00:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6182A2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 09:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 701876187E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C09E5C433C8;
        Wed, 12 Jul 2023 16:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689177621;
        bh=zNkYR0JyjRXUJ7vFyx0u819ePXXPtTPmLqFb58IyYgU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=u5pbmmRny/PgfzGaePeSfwG/Wkz1NNm0fuvAIPvRY54ujqc2YoYxFh69nika2ZSD0
         zo/mi7wOv7tN6YXq/s/DBm0k+gEOYRsptfSTe3JTW32cKZKdjLefA+3UE4JV3UJEdm
         kvNoyh/it49Jx5roU0VLRZxGnePIshWFYFtbWWoJMRV44pwD38vXMmHM/rr085XsK4
         FbrxPleSDBbEUyv9o1mC2mjMrc+YV1HWFEhLBEyuaaNaMryrKXEIKE7p9AR++HZQJp
         K/CkVAIwYnOtqsB8lYA0JGGuFu74ajRl0lkIjyGn6AC95KRkenlxDIKl4fHpIiWX++
         aktu/dNXgE1oA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9ADCFE4D006;
        Wed, 12 Jul 2023 16:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] perf: RISC-V: Remove PERF_HES_STOPPED flag checking in
 riscv_pmu_start()
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168917762163.26837.1392502139104305103.git-patchwork-notify@kernel.org>
Date:   Wed, 12 Jul 2023 16:00:21 +0000
References: <20230710154328.19574-1-eric.lin@sifive.com>
In-Reply-To: <20230710154328.19574-1-eric.lin@sifive.com>
To:     Eric Lin <eric.lin@sifive.com>
Cc:     linux-riscv@lists.infradead.org, atishp@atishpatra.org,
        anup@brainfault.org, will@kernel.org, mark.rutland@arm.com,
        palmer@dabbelt.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, greentime.hu@sifive.com,
        vincent.chen@sifive.com
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

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 10 Jul 2023 15:43:28 +0000 you wrote:
> Since commit 096b52fd2bb4 ("perf: RISC-V: throttle perf events") the
> perf_sample_event_took() function was added to report time spent in
> overflow interrupts. If the interrupt takes too long, the perf framework
> will lower the sysctl_perf_event_sample_rate and max_samples_per_tick.
> When hwc->interrupts is larger than max_samples_per_tick, the
> hwc->interrupts will be set to MAX_INTERRUPTS, and events will be
> throttled within the __perf_event_account_interrupt() function.
> 
> [...]

Here is the summary with links:
  - perf: RISC-V: Remove PERF_HES_STOPPED flag checking in riscv_pmu_start()
    https://git.kernel.org/riscv/c/66843b14fb71

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


