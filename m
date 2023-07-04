Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738EA747553
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjGDPaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjGDPa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:30:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C661B10EA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 08:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6521061259
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 15:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CBC24C433C7;
        Tue,  4 Jul 2023 15:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688484621;
        bh=mRq7xH15VXJDxmtW3iuqpiG4oT/4J+rHNWrZw1Vgtik=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=e1qvcozjIFtPVctgcHr+XcCgiqn4sGp4qer8gFrPN75V6NDv6MAEgFA3R5Z/LDFTh
         YctrodbviObiVmgGEy8sB2S6epS+lFo252d+UViHhywJY1s2WYsBfYZVl6F5U9uBUm
         oh0gdQK0DKylLyRIG0Lb+ybfEu+3B8KllJQlWAC47bc1Ynb5spXxfl3LBgTjEUzVdg
         s8iofwf1UDNwQQOQg5VYH61JJ69Ul6APkK+OZhAzSpO+VmLHCTBDvXsVua/zxWAI38
         r8Ty1zrnJOXug3psklpq6kFO7dCtkS7N/fPVEgHNriLE6xvE3h5maopNAFjFsmhkw7
         QOert9zw/S5uQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B6289C40C5E;
        Tue,  4 Jul 2023 15:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: vdso: include vdso/vsyscall.h for vdso_data
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168848462174.9093.2909110610886712536.git-patchwork-notify@kernel.org>
Date:   Tue, 04 Jul 2023 15:30:21 +0000
References: <20230616114357.159601-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20230616114357.159601-1-ben.dooks@codethink.co.uk>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Fri, 16 Jun 2023 12:43:57 +0100 you wrote:
> Add include of <vdso/vsyscall.h> to pull in the defition of vdso_data
> to remove the following sparse warning:
> 
> arch/riscv/kernel/vdso.c:39:18: warning: symbol 'vdso_data' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> 
> [...]

Here is the summary with links:
  - riscv: vdso: include vdso/vsyscall.h for vdso_data
    https://git.kernel.org/riscv/c/54cdede08f2f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


