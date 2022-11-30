Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D188363CED8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 06:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbiK3FuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 00:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbiK3FuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 00:50:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352EB53EF5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 21:50:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD17C61A25
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 05:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14FE0C433C1;
        Wed, 30 Nov 2022 05:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669787416;
        bh=mWapkiqeTyhlxtRKV32R7knpZ7vDUmMOPyBjveYsR+U=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Av78yeFmfoNfcMdGgqwR32cOMPacIyY0KesjwoFf/ydY6U13ddUEDf2bwaLb94WOV
         kO+bbyWiJ4tfLwP08lIt5TjX3qCMvMAOaipihb59G0p9jg0T7oYFPBdJd+L3WD+8S7
         s/oOMpFD2Jb7hgEDM+Vi6QwtZdLmFNhPn/DuDqUwa0tB4QvGKaCwl9qLQRkGglzpY+
         YTiRBpwouNVLRuOJv+AKNhHAQ6zagIQfma3orWDLEiwwwlANZKLf6oZ6XPIr13zjDk
         5k97t/Htyhx+EEs65WlkM1NJajxP5GFqEsZiNSfv0ERmLVHFvcwYZ7QZWxxg7PA9R1
         SGCjgUhK1ipQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE4EFE21EF2;
        Wed, 30 Nov 2022 05:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] riscv: mm: Proper page permissions after initmem free
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <166978741597.2406.14892412978128239301.git-patchwork-notify@kernel.org>
Date:   Wed, 30 Nov 2022 05:50:15 +0000
References: <20221115090641.258476-1-bjorn@kernel.org>
In-Reply-To: <20221115090641.258476-1-bjorn@kernel.org>
To:     =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm5Aa2VybmVsLm9yZz4=?=@ci.codeaurora.org
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
        samuel@sholland.org, bjorn@rivosinc.com,
        linux-kernel@vger.kernel.org
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

On Tue, 15 Nov 2022 10:06:40 +0100 you wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> 64-bit RISC-V kernels have the kernel image mapped separately to alias
> the linear map. The linear map and the kernel image map are documented
> as "direct mapping" and "kernel" respectively in [1].
> 
> At image load time, the linear map corresponding to the kernel image
> is set to PAGE_READ permission, and the kernel image map is set to
> PAGE_READ|PAGE_EXEC.
> 
> [...]

Here is the summary with links:
  - [v2] riscv: mm: Proper page permissions after initmem free
    https://git.kernel.org/riscv/c/6fdd5d2f8c2f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


