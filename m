Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFC76FB320
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 16:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbjEHOmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 10:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbjEHOl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 10:41:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823F9769E
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 07:41:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15B0F64065
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 14:41:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FFD1C433D2;
        Mon,  8 May 2023 14:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683556916;
        bh=eAOT+NHmXh2QJqEgJ9YZFhBuoVP6a8qQZVhJ1sJRZHA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=euf9Aa2Z7hjHuHjV/3m1HVsFRDsNxFrLu7KT6qMiHLyr98PAoyX1nvFb30R/QOEmj
         b9RaXV/0bKrysX+sh93F4T2fXyF5RIhqPjXG5NnYlfRzIJZHwGGySFcwPJl0YzNvUn
         O3QFAsCA+09RIb4Tdz8vEvDcJ9JLf3nDEFI4/hU5S6Pl6dgo5xtD5iR+lXlec+fsbx
         uS67bgj6VwtBu+mvlp3N0Vy9DkG7QBG54ch1Eq2xzgkuKDyHmu6chRo/Pa76MGqrJ6
         oniwt2lmozGIq2remUBpVL30EpyxUXZnJreIhCa3xbPyKcTh+IAt/HkNNOsxZcJYea
         QAlyBGMMybe+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4FE2BE4F0A2;
        Mon,  8 May 2023 14:41:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes] riscv: Move .rela.dyn to the init sections
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168355691632.25692.12423469985952426151.git-patchwork-notify@kernel.org>
Date:   Mon, 08 May 2023 14:41:56 +0000
References: <20230428120932.22735-1-alexghiti@rivosinc.com>
In-Reply-To: <20230428120932.22735-1-alexghiti@rivosinc.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
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

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri, 28 Apr 2023 14:09:32 +0200 you wrote:
> The recent introduction of relocatable kernels prepared the move of
> .rela.dyn to the init section, but actually forgot to do so, so do it
> here.
> 
> Before this patch: "Freeing unused kernel image (initmem) memory: 2592K"
> After this patch:  "Freeing unused kernel image (initmem) memory: 6288K"
> 
> [...]

Here is the summary with links:
  - [-fixes] riscv: Move .rela.dyn to the init sections
    https://git.kernel.org/riscv/c/4db9e253e701

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


