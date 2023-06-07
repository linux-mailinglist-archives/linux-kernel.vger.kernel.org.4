Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888577250FD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 02:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239855AbjFGAAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 20:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbjFGAAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 20:00:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6945E1707
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 17:00:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0766A633D2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 00:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6149DC4339C;
        Wed,  7 Jun 2023 00:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686096020;
        bh=gvvjUKQi4wiUt55k1lOIB90d9t2HHIpkJYXB1NoPZMg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BOTENdVUIQ/9A3Q3sAtj7l0NnIJZ5pXpfsTF3xMIz2IgbL8Xhao8FxsfjKOl/HZZr
         G7ng77QseyQTklBhD4T4ZUmPG5nDyHrYrotzilEOmkMOLyNDuDMbX3L9WMn2+UWUoh
         aOSTMW8aLsfEk+lyK5Pjc1v23MxFme2Wxdf2Zax289USGB7c7BqkZGewbuhEV8jU0w
         frC5GMovgFQt7B1GGFxlxGjOwgm6HCYVUp6rRkM1osP5OzhrZ6i1/9mnnKF+ebGgMp
         TqlJmP4i+ptSUgEZYJ1BEMsuTJE2xe97tTyqMSq9ZbhMn1OVAuRhddBMd5mYrTac2A
         IgHotCqjyAOVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 44DA4E8722F;
        Wed,  7 Jun 2023 00:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/2] riscv: allow case-insensitive ISA string parsing
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168609602027.16436.14732118380879424687.git-patchwork-notify@kernel.org>
Date:   Wed, 07 Jun 2023 00:00:20 +0000
References: <tencent_E6911C8D71F5624E432A1AFDF86804C3B509@qq.com>
In-Reply-To: <tencent_E6911C8D71F5624E432A1AFDF86804C3B509@qq.com>
To:     Yangyu Chen <cyy@cyyself.name>
Cc:     linux-riscv@lists.infradead.org, conor@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        ajones@ventanamicro.com, twd2.me@gmail.com, soha@lohu.info,
        i@zenithal.me
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

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue,  2 May 2023 00:10:19 +0800 you wrote:
> This patchset allows case-insensitive ISA string parsing, which is
> needed in the ACPI environment. As the RISC-V Hart Capabilities Table
> (RHCT) description in UEFI Forum ECR[1] shows the format of the ISA
> string is defined in the RISC-V unprivileged specification[2]. However,
> the RISC-V unprivileged specification defines the ISA naming strings are
> case-insensitive while the current ISA string parser in the kernel only
> accepts lowercase letters. In this case, the kernel should allow
> case-insensitive ISA string parsing. Moreover, this reason has been
> discussed in Conor's patch[3]. And I have also checked the current ISA
> string parsing in the recent ACPI support patch[4] will also call
> `riscv_fill_hwcap` function as DT we use now.
> 
> [...]

Here is the summary with links:
  - [v3,1/2] riscv: allow case-insensitive ISA string parsing
    https://git.kernel.org/riscv/c/255b34d799dd
  - [v3,2/2] dt-bindings: riscv: drop invalid comment about riscv,isa lower-case reasoning
    https://git.kernel.org/riscv/c/9e320d7ca46a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


