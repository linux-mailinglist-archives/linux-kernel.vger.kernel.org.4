Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D9C6C720D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 22:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjCWVAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 17:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjCWVA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 17:00:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082EC6192
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 14:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 971E1626ED
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 21:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E70DDC433D2;
        Thu, 23 Mar 2023 21:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679605221;
        bh=s9bXoRFsk51mtRO5vA9hAmomeuYjmlnifQIlKFwqLRA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hEnHnpJu/YjO8wo/zmmNAKzwCotV3HbLsjEPtJR/hrPYzD7HNBCmLBQiEEjKkCJ5N
         eo+HEN12pWFCTu7e/dq1LoiVRq5d/qGnDgZ3AmajDl4otmFh+m/WPePz+9EQJEu7IL
         bM3Tp/ls5/0+i3WRy7fhqnMuqyx0+jSAbebi1/0ctJOPVbeYbq2AMH4cHW8mXT33VW
         NHFs6C0osOz8zNRC+B9s4i7W0WjZkWjxfAf5wQkb8vJ7VY1mIa8ALY9VJGZN6HcPHX
         NYQkV8YNpbVUuuACHIn4+z/tnO3TDqWyImzUZJ9tJEx6WAR2D3wtsj0i78xU+6A1i8
         XclvRqGIHux3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D3605E4F0D7;
        Thu, 23 Mar 2023 21:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] riscv: mm: Fix incorrect ASID argument when flushing TLB
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167960522086.10481.6194294455098619740.git-patchwork-notify@kernel.org>
Date:   Thu, 23 Mar 2023 21:00:20 +0000
References: <20230313034906.2401730-1-dylan@andestech.com>
In-Reply-To: <20230313034906.2401730-1-dylan@andestech.com>
To:     Dylan Jhong <dylan@andestech.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        guoren@kernel.org, sergey.matyukevich@syntacore.com,
        aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, x5710999x@gmail.com,
        tim609@andestech.com, peterlin@andestech.com, ycliang@andestech.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 13 Mar 2023 11:49:06 +0800 you wrote:
> Currently, we pass the CONTEXTID instead of the ASID to the TLB flush
> function. We should only take the ASID field to prevent from touching
> the reserved bit field.
> 
> Fixes: 3f1e782998cd ("riscv: add ASID-based tlbflushing methods")
> Signed-off-by: Dylan Jhong <dylan@andestech.com>
> 
> [...]

Here is the summary with links:
  - [v2] riscv: mm: Fix incorrect ASID argument when flushing TLB
    https://git.kernel.org/riscv/c/9a801afd3eb9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


