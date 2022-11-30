Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFAF363CED9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 06:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbiK3FuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 00:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiK3FuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 00:50:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB1C55CAD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 21:50:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50F2DB81A31
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 05:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08D53C43470;
        Wed, 30 Nov 2022 05:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669787416;
        bh=Zir1ps/2c2EwIni6tIKiHxWTktiNF48TCCnVqNEWPdw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jeyo07wxc6apZt9dJYmMQEWjnLgIu2l4VAidR70XYiUroF5v9Nphw5gGMZdrEez2l
         6Jm+jVSCsF5itw6QYCV0WVCRDYfYKjfzrR7eKdE+oN620B0UFLvtVmm++1L6aqn4IS
         p9tRiEsUqX5S0Wf5Kl3UHLi996Jxo+c3WN1W4JfTFieMEtPEsj8ssVaD/7wG1rF+o0
         svRbuz4ljcwKkUtF5jMu8Pjl950xYijUHiX7SQysO0bEjUAf+hoBXtXHmQX9CzFKTP
         teimL55Lb0WdaEnAQAWRkcGGgiuLLSkzKeMwqNlRJuxNPXybl5eMXkCNtVS0IQXQ6g
         mhxIMdaPE08Yw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E33E7E29F38;
        Wed, 30 Nov 2022 05:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] riscv: vdso: fix section overlapping under some conditions
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <166978741592.2406.17617743225163774809.git-patchwork-notify@kernel.org>
Date:   Wed, 30 Nov 2022 05:50:15 +0000
References: <20221102170254.1925-1-jszhang@kernel.org>
In-Reply-To: <20221102170254.1925-1-jszhang@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, lkp@intel.com
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

On Thu,  3 Nov 2022 01:02:54 +0800 you wrote:
> lkp reported a build error, I tried the config and can reproduce
> build error as below:
> 
>   VDSOLD  arch/riscv/kernel/vdso/vdso.so.dbg
> ld.lld: error: section .note file range overlaps with .text
> >>> .note range is [0x7C8, 0x803]
> >>> .text range is [0x800, 0x1993]
> 
> [...]

Here is the summary with links:
  - [v2] riscv: vdso: fix section overlapping under some conditions
    https://git.kernel.org/riscv/c/74f6bb55c834

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


