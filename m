Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A208172825F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236913AbjFHOKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236907AbjFHOKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:10:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A1B2D71
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 07:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38C7264E0B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 14:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 910F0C4339E;
        Thu,  8 Jun 2023 14:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686233421;
        bh=M2hdkj/aqger+2hxUCmWq7hrnZFgudHDHrlIG8mCorA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SHK5/HCPiCK7LLA9ghCjDWIWcqFKwE+hFRmZqnRFs7eSPR+j2fjG6N619VtOqonyz
         i2XOUZjlQ31LKy//mmJQEbmK9m2lgFam1mCxeep5bf450SHKizPYblnR4hcVp2fqRd
         Zz/y+o/5FmxlXKp+rwEqvNhOHEiSX1ilMBRDeziJTR0tTD+1pryHV4iFgNCELv0egl
         ZmyGGUIcNB28cVBoGDij2FThim8FBA38wrPOckAmgGN64PRyswO3DDnb27K9frdNPO
         ZGpL5n8HY4o91Ky9LP5BhvIkVaUmk6tHQ04YDO5T+pundJabJqMoNLJCb+5PgSdMry
         XF+weIEX8dyBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 739DFE4D031;
        Thu,  8 Jun 2023 14:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes] riscv: Check the virtual alignment before choosing a
 map size
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168623342146.30670.13170012353498536520.git-patchwork-notify@kernel.org>
Date:   Thu, 08 Jun 2023 14:10:21 +0000
References: <20230607125851.63370-1-alexghiti@rivosinc.com>
In-Reply-To: <20230607125851.63370-1-alexghiti@rivosinc.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, ajones@ventanamicro.com,
        robh@kernel.org, anup@brainfault.org, linux-kernel@vger.kernel.org,
        songshuaishuai@tinylab.org
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

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed,  7 Jun 2023 14:58:51 +0200 you wrote:
> We used to only check the alignment of the physical address to decide
> which mapping would fit for a certain region of the linear mapping, but
> it is not enough since the virtual address must also be aligned, so check
> that too.
> 
> Fixes: 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the linear mapping")
> Reported-by: Song Shuai <songshuaishuai@tinylab.org>
> Link: https://lore.kernel.org/linux-riscv/tencent_7C3B580B47C1B17C16488EC1@qq.com/
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> 
> [...]

Here is the summary with links:
  - [-fixes] riscv: Check the virtual alignment before choosing a map size
    https://git.kernel.org/riscv/c/49a0a3731596

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


