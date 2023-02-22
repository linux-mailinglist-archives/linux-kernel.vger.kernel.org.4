Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B2B69F73D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 16:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbjBVPAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 10:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjBVPA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 10:00:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C9138030
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 07:00:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C678B61496
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 15:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30970C433D2;
        Wed, 22 Feb 2023 15:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677078022;
        bh=Yi3u5Nak6osibQzcfwjNbC7RplCrm3Sc03yEPeaYTPY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=YHoxUi/oxGi3akT53+zNV7IFx8pNNqOa2WMcuRqjlMjxepTxHm8oYyfBFHIHpfkHN
         6ZDH/l6NLrG2nCkGtST9QJCGEs8gf8tjFTaO80KGYadLy0awP0V/tDbT6f0/czvMz8
         MMc5WLsQB6NcYB33Jj8oCXS9QAe/4gmyoIH+vym4Oq9N2osmBjZ1Drt656AT9jiwl0
         IYrCjT+7XZuxiPP08rqtFjRD5ffDVR99j3+w9HjOgnHIqtew09Wjqu0O2ZiAFPwDrK
         Z5M3La1yONKs8K/wBI4G0E3CAk/EZZh9GgK/k6s6VnO9V8vVNoiMQzF1hML/29YAbq
         QYRiDETqoxADg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C1E6C59A4C;
        Wed, 22 Feb 2023 15:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND] riscv: jump_label: Fixup unaligned arch_static_branch
 function
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167707802203.24438.3366600866397687013.git-patchwork-notify@kernel.org>
Date:   Wed, 22 Feb 2023 15:00:22 +0000
References: <20230206090440.1255001-1-guoren@kernel.org>
In-Reply-To: <20230206090440.1255001-1-guoren@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mhiramat@kernel.org,
        conor.dooley@microchip.com, penberg@kernel.org,
        mark.rutland@arm.com, jrtc27@jrtc27.com, andy.chiu@sifive.com,
        zong.li@sifive.com, greentime.hu@sifive.com, bjorn@kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon,  6 Feb 2023 04:04:40 -0500 you wrote:
> From: Andy Chiu <andy.chiu@sifive.com>
> 
> Runtime code patching must be done at a naturally aligned address, or we
> may execute on a partial instruction.
> 
> We have encountered problems traced back to static jump functions during
> the test. We switched the tracer randomly for every 1~5 seconds on a
> dual-core QEMU setup and found the kernel sucking at a static branch
> where it jumps to itself.
> 
> [...]

Here is the summary with links:
  - [RESEND] riscv: jump_label: Fixup unaligned arch_static_branch function
    https://git.kernel.org/riscv/c/9ddfc3cd8060

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


