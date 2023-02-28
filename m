Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31376A60F9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 22:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjB1VLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 16:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjB1VLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 16:11:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B316D2B62C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 13:11:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39FFF611DD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 21:11:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CEB4C433A0;
        Tue, 28 Feb 2023 21:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677618677;
        bh=8lV+IaCiKMm2e7+A28kFpfKbQczqgP/e64KBjOHSYjQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ujOHjxx3JB60IDiRNO3KQ0O4ioZlytnREsKI3fPcEuCBOW2o4alANzWwdrvWO31DO
         JsRiHfa8YaMUBfKYPfGDcdPjKObo2KJrhn/URQwcrjug2r/3L3cxDV57TokO2Jzj5X
         OLPLZ+tYM81OeyiiUgvlKcthor6OX7nP8u3Xkd16L4Z5XE4gqkrybqb5NOZuur7e1p
         ThsY8mNehUONpCuw1Q0x6Akc6QEMvmDMXuK/AQMa0b9Zb8jnZYkQN0HyRGtzxjcqhP
         PwD9a9bAJy95r67E3js0iLSkdiqqcaMpFYVdb6ngn72Sjm/23RaD+PM2bIXEBnYiRc
         VPA32UcR8AiJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 58C96C73FF5;
        Tue, 28 Feb 2023 21:11:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] Small fixups for the Zbb string functions
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167761867735.10135.12344795154961095592.git-patchwork-notify@kernel.org>
Date:   Tue, 28 Feb 2023 21:11:17 +0000
References: <20230208225328.1636017-1-heiko@sntech.de>
In-Reply-To: <20230208225328.1636017-1-heiko@sntech.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-riscv@lists.infradead.org, palmer@rivosinc.com,
        conor@kernel.org, linux-kernel@vger.kernel.org,
        christoph.muellner@vrull.eu, ajones@ventanamicro.com,
        heiko.stuebner@vrull.eu
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed,  8 Feb 2023 23:53:26 +0100 you wrote:
> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> 
> I didn't manage to address Andrews comments on v5 [0] in time
> before the series got applied, so here are two addon comments
> that hopefully do his comments justice now.
> 
> 
> [...]

Here is the summary with links:
  - [1/2] RISC-V: fix ordering of Zbb extension
    (no matching commit)
  - [2/2] RISC-V: improve string-function assembly
    https://git.kernel.org/riscv/c/6934cf8a3e0b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


