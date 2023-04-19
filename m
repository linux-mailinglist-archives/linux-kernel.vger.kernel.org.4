Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B396E7CAD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjDSOal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjDSOah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:30:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC818A50
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:30:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE55760C1B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48E30C433D2;
        Wed, 19 Apr 2023 14:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681914622;
        bh=M70RX4NCruISu4PxvB6EcGl+QW8E4STaGkaa4S6an8Y=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=aAWM7ZqJRuVsph/2fNLv2Zwednvp3qgyDgiKT1CBbAv3qcSoLjfkqejb+GX8d3hJa
         Vp32YeEApyxftA2PFG3bdjCzmLtsj1FLyT0j5Uy5YCRZunbBMdJY9quc1KI1B87FSn
         aKttwMZlbQ5yd4fjYHgMnO9QVGTSjwamvYxykvolEg0M39Y2GrKJkc/X8hXQdKXfRC
         ka4pdQOjG1NCx1qU2K1EUhBPrtPWuGv1eJu+APBgxa8+u7Jcqmh9Qsil18kaZ1lMFg
         poVC+fcatl3MPzuPXVJLY89AzC0U9rK1BlNpCNxmXsRtnK4VNC1WjaQ1QU/LwUtTAP
         /IBsLKFhufR1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 30BC3C395EA;
        Wed, 19 Apr 2023 14:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Kconfig: enable SCHED_MC kconfig
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168191462219.22791.16015879723160274958.git-patchwork-notify@kernel.org>
Date:   Wed, 19 Apr 2023 14:30:22 +0000
References: <20230310110336.970985-1-suagrfillet@gmail.com>
In-Reply-To: <20230310110336.970985-1-suagrfillet@gmail.com>
To:     Song Shuai <suagrfillet@gmail.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, conor@kernel.org,
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

On Fri, 10 Mar 2023 19:03:36 +0800 you wrote:
> RISC-V now builds the sched domain based on the simple possible map.
> 
> Enable SCHED_MC to make the building based on cpu_coregroup_mask()
> which also takes care of the NUMA and cores with LLC.
> 
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> 
> [...]

Here is the summary with links:
  - riscv: Kconfig: enable SCHED_MC kconfig
    https://git.kernel.org/riscv/c/8bf7b3b66762

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


