Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D4968855E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 18:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjBBRaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 12:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjBBRaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 12:30:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817896D072
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 09:30:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CFC561A73
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 17:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6BB70C4339C;
        Thu,  2 Feb 2023 17:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675359017;
        bh=LriLzzcrjvf2aq9MHuzmDWOO4COF/M+nniJBrNFPJiU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CnRcPgvyJWF1VvbsBLfnIFk6aay8Un57fO/Z+N/h2Se0ciBQbNcWtVMoZkRmbZGXT
         edYhJ4qszoAaJatmOU3Zl0NBJGgkQ71PIo7vH3JwJof/9m3ckasayATA9wOaB6ZvDY
         iPJByZ7fYw+D3pN6RNw4yxKoPAulNkEmIvdt8y56Dk/BkBAnWLsHDyNmaq1MoU+c2G
         MMYzQOr1rhkYOehZekSCmtF5osZ0BbVG4SM8TOYueywf2p5xPcHRxd2XCO8RhKuFNQ
         Di26NBNBitvR6REAIot0W1bte9XEcuEGgq1ewdCPWNvTeRKnnizTsSOZoswd6mKJFr
         4gQRKoxVNdwNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5473EC0C40E;
        Thu,  2 Feb 2023 17:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: disable generation of unwind tables
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167535901734.19827.9982979775688143971.git-patchwork-notify@kernel.org>
Date:   Thu, 02 Feb 2023 17:30:17 +0000
References: <mvmzg9xybqu.fsf@suse.de>
In-Reply-To: <mvmzg9xybqu.fsf@suse.de>
To:     Andreas Schwab <schwab@suse.de>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 01 Feb 2023 10:29:45 +0100 you wrote:
> GCC 13 will enable -fasynchronous-unwind-tables by default on riscv.  In
> the kernel, we don't have any use for unwind tables yet, so disable them.
> More importantly, the .eh_frame section brings relocations
> (R_RISC_32_PCREL, R_RISCV_SET{6,8,16}, R_RISCV_SUB{6,8,16}) into modules
> that we are not prepared to handle.
> 
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> 
> [...]

Here is the summary with links:
  - riscv: disable generation of unwind tables
    https://git.kernel.org/riscv/c/2f394c0e7d11

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


