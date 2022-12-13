Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1784A64AFC0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 07:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbiLMGUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 01:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbiLMGUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 01:20:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED8D1CB34
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 22:20:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED2E561314
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 06:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31FA7C433F0;
        Tue, 13 Dec 2022 06:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670912418;
        bh=lXO8/1CnS/fPdHOgjcDQhLRQhUXmhy2+rqnlrKJDH8s=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DyqzVKfskC3sGktrinycjG3OGMb0LUcoGXB2/cNUCD4nUNO7G7Q9gcupYF4d23uGa
         QzMSUthLyQGnmvHQmpvbV8YJTiRT1CJiiTu1IWnpbGApejoL7jnAxrCzK5cvlQ7QkR
         mvN8bwitXb64Z8H+VZKnAhBsI/ul3W8+HfNvx6yu8tbRfJdX4S267+axJkR22qVD+s
         sxr7O7o3RVkVnlT+T2Dkcz1DSfI2tXE9jgVg8RdMiZMMXeKrMvCUBJHSR7d7Pfm/mE
         32C6/tV1kFdD9sLAuM0JahCo5mPrye+WPRxvYvV2sNBOjaA2c9H7BpO1afmZubmuyw
         pO6U3lTupfBqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 15B13C00445;
        Tue, 13 Dec 2022 06:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] RISC-V: Align the shadow stack
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167091241808.24276.8153329766826159166.git-patchwork-notify@kernel.org>
Date:   Tue, 13 Dec 2022 06:20:18 +0000
References: <20221130023515.20217-1-palmer@rivosinc.com>
In-Reply-To: <20221130023515.20217-1-palmer@rivosinc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, jszhang@kernel.org,
        guoren@kernel.org, linux-kernel@vger.kernel.org
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

On Tue, 29 Nov 2022 18:35:14 -0800 you wrote:
> The standard RISC-V ABIs all require 16-byte stack alignment.  We're
> only calling that one function on the shadow stack so I doubt it'd
> result in a real issue, but might as well keep this lined up.
> 
> Fixes: 31da94c25aea ("riscv: add VMAP_STACK overflow detection")
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> [...]

Here is the summary with links:
  - [1/2] RISC-V: Align the shadow stack
    https://git.kernel.org/riscv/c/b003b3b77d65
  - [2/2] RISC-V: Add some comments about the shadow and overflow stacks
    https://git.kernel.org/riscv/c/de57ecc47610

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


