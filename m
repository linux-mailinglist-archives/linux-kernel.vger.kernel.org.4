Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F63749211
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 01:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjGEXuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 19:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbjGEXuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 19:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE8D172B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 16:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C619617F1
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 23:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A14C4C433CA;
        Wed,  5 Jul 2023 23:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688601022;
        bh=wF3zf8/MLATQ/c23tboRByapQW7HjjUk1ZCKWbYWn/Y=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=E/cxeRlcq3fuV4PqYFVqm21m6k06WPkO9pbgs39wagk89mo3QcEqiq/Pm/UnXCszy
         82mS5ixKGiKI25bcYY8j36ss7wqGDICATLLxUiPRQ3amqx8Qv8ffsAtzWQPKxFj7o5
         IfHwq/i7TILqtANFYoVKH2qhnGMlg2k21fmd2jX3RbbHak/jQRP1skIlLifGuH2JWr
         IZS8eM+SMLCIsLRU9iQdYbfCfMAHea7C5UxktYA9NUCFPmkal6PngNkkav4g1vjYSl
         NrvpF3dL92oX4GH9Hjacw2+DrMGlv6h1FvrRzEVHPSkdA06JWm/GUv47UHx280f+tT
         TTs/9R2murMDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7CEBBC0C40E;
        Wed,  5 Jul 2023 23:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] riscv: move memblock_allow_resize() after linear mapping
 is ready
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168860102250.23922.10880634323125131800.git-patchwork-notify@kernel.org>
Date:   Wed, 05 Jul 2023 23:50:22 +0000
References: <tencent_FBB94CE615C5CCE7701CD39C15CCE0EE9706@qq.com>
In-Reply-To: <tencent_FBB94CE615C5CCE7701CD39C15CCE0EE9706@qq.com>
To:     Woody Zhang <woodylab@foxmail.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, alexghiti@rivosinc.com,
        conor.dooley@microchip.com, linux-kernel@vger.kernel.org
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

On Wed, 14 Jun 2023 21:19:07 +0800 you wrote:
> The initial memblock metadata is accessed from kernel image mapping. The
> regions arrays need to "reallocated" from memblock and accessed through
> linear mapping to cover more memblock regions. So the resizing should
> not be allowed until linear mapping is ready. Note that there are
> memblock allocations when building linear mapping.
> 
> This patch is similar to 24cc61d8cb5a ("arm64: memblock: don't permit
> memblock resizing until linear mapping is up").
> 
> [...]

Here is the summary with links:
  - [v3] riscv: move memblock_allow_resize() after linear mapping is ready
    https://git.kernel.org/riscv/c/85fadc0d0411

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


