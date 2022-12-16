Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDC664F1DC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 20:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbiLPTh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 14:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbiLPThx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 14:37:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC48D165A1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 11:37:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A6BC621E4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 19:37:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF7A5C433EF;
        Fri, 16 Dec 2022 19:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671219470;
        bh=M1ZYaPESBl8QhjN70S555yU5nbnIzMhYimAaNNoyDlo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jycl+yhJ0nPclDBKuttoXHtIJ/akO51DK2j+udBqmiqwvHYwevm1OHGslbiAcCSiq
         8tx3pnPyohxd/Z1CLI21rHtvQcP8jTQV9Sa6mT83cdoiNEdRDhJO9Zhsel12Xx9/jN
         n7sKm2gSSxZDr8gAJPqETQu10Cjo9JVebfu43/IQ1QLA4jkq/edLoi/woHTPSRbo17
         cCrDa4ZdcdxnnlS5GeXWPJNVHASodlcRmFpTOJ1qsUUBerRZH8AEhB+L0cHM9auac+
         UG9AYgT7aiY441t9HxCzpX4lRq6AbGzBROL87II7MjwxuiFlstdHYzKEVS1fKOdbPt
         zTDevQg7+36kg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ADAFBC00445;
        Fri, 16 Dec 2022 19:37:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next V6 0/2] riscv: kexec: Fxiup crash_save percpu and
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167121947070.14925.11249878728419640630.git-patchwork-notify@kernel.org>
Date:   Fri, 16 Dec 2022 19:37:50 +0000
References: <20221209075513.532249-1-guoren@kernel.org>
In-Reply-To: <20221209075513.532249-1-guoren@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, palmer@rivosinc.com,
        conor.Dooley@microchip.com, heiko@sntech.de,
        linux-kernel@vger.kernel.org, crash-utility@redhat.com,
        guoren@linux.alibaba.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri,  9 Dec 2022 02:55:11 -0500 you wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Current riscv kexec can't crash_save percpu states and disable
> interrupts properly. The series fix them, make crash correct.
> 
> v6:
>  - Fixup checkpatch.pl problems
>  - Remove Fixes tags and make the series as features
> 
> [...]

Here is the summary with links:
  - [-next,V6,1/2] riscv: kexec: EOI active and mask all interrupts in kexec crash path
    https://git.kernel.org/riscv/c/b17d19a5314a
  - [-next,V6,2/2] riscv: kexec: Make crash save multi harts' context
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


