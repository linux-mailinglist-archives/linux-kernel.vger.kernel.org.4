Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5318165F76D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 00:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbjAEXAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 18:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbjAEXAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 18:00:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61734392C2;
        Thu,  5 Jan 2023 15:00:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBD3961C83;
        Thu,  5 Jan 2023 23:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B454C433EF;
        Thu,  5 Jan 2023 23:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672959616;
        bh=BGCX8lkKaNvfirMazSGGcGK0Qxa9sByloCjt7nCQRoU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UQ3+MksAZC20zTZVswmy3PregvLQZdaeYZs8A5z3DKvw6Ze/WJd6yhQkdL8UL5h17
         FDeL/IU59lLMN1VNZD/wZ5JsUzceszNW2zQnSMtyYQsTisxyP1rFwlS1p+R8k+lUfW
         lvuc/peDABG/kaNGeQ563UP7tGkYsRUcl16XFaUen5w5qUrLGGJzKMrOXs3otODo3Q
         SPw721PUS9Rx/EqmZzWKTzXtr2wyRL3+VWtQfnKhfNBGl0wd4Toss8GakYwBxd0xrp
         rJ3j4dEJ09WTRAzvmMyWAPuPEdCsIbDET27C2OW2SMdcOb60p8u0zegR9k9986ol4B
         SMMdTWvBOGYEg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 23419E5724A;
        Thu,  5 Jan 2023 23:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv, kprobes: Stricter c.jr/c.jalr decoding
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167295961613.27641.13795817742406776564.git-patchwork-notify@kernel.org>
Date:   Thu, 05 Jan 2023 23:00:16 +0000
References: <20230102160748.1307289-1-bjorn@kernel.org>
In-Reply-To: <20230102160748.1307289-1-bjorn@kernel.org>
To:     =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm5Aa2VybmVsLm9yZz4=?=@ci.codeaurora.org
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, guoren@kernel.org,
        bjorn@rivosinc.com, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
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

On Mon,  2 Jan 2023 17:07:48 +0100 you wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> In the compressed instruction extension, c.jr, c.jalr, c.mv, and c.add
> is encoded the following way (each instruction is 16b):
> 
> ---+-+-----------+-----------+--
> 100 0 rs1[4:0]!=0       00000 10 : c.jr
> 100 1 rs1[4:0]!=0       00000 10 : c.jalr
> 100 0  rd[4:0]!=0 rs2[4:0]!=0 10 : c.mv
> 100 1  rd[4:0]!=0 rs2[4:0]!=0 10 : c.add
> 
> [...]

Here is the summary with links:
  - riscv, kprobes: Stricter c.jr/c.jalr decoding
    https://git.kernel.org/riscv/c/b2d473a6019e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


