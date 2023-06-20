Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D937360F3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 03:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjFTBAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 21:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjFTBA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 21:00:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409AA10C2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 18:00:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 270DB60F77
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 01:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24D5FC433CB;
        Tue, 20 Jun 2023 01:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687222824;
        bh=i+bkBGyvWdYTzpAuClogxpBwgpL1xJGlOgV4zpfwFvk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=i5TrPzeDUtdGThVJUdeeuXnGMhhXwNhK/o2qo6Y/66rnbiQYM0elJY5AAPIptSjWW
         fW9xRDTR8TMh2QxLP3nk79+Ms81jithGN2MljY7/J+itMQe17PdJxCcr9ByBcnV4B9
         /m0bAqZEbt03RxTht4uehz6x5R3ElON8qmiHD3xb5Gz4vHabq0htYhiKYJNgqrV4uk
         25gDhHX1K6y1+c4f2MW/AVDuqZ285pXphFYyyh2gA+g+7E/JlDlOTerDfV+t0VrLyH
         nX80a+FvzSI8LqllpkqORmxNbDmC7cA/MVfxmZm05qsJ7t9rG8V82OwO+B8m/x6RuZ
         Qbbg2tZR/fvVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0DAC7E301F8;
        Tue, 20 Jun 2023 01:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] riscv: mm: stub extable related functions/macros for !MMU
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168722282405.22807.12021813710687983255.git-patchwork-notify@kernel.org>
Date:   Tue, 20 Jun 2023 01:00:24 +0000
References: <20230509152641.805-1-jszhang@kernel.org>
In-Reply-To: <20230509152641.805-1-jszhang@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org
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

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue,  9 May 2023 23:26:41 +0800 you wrote:
> extable relies on the MMU to work properly, so it's useless to
> include __ex_table sections and build extable related functions for
> !MMU case.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
> 
> [...]

Here is the summary with links:
  - [v2] riscv: mm: stub extable related functions/macros for !MMU
    https://git.kernel.org/riscv/c/de658bcf0333

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


