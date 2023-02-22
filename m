Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F4269F743
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 16:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjBVPAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 10:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbjBVPAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 10:00:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A8B38E8D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 07:00:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D0A4B815D8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 15:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B28E7C4332E;
        Wed, 22 Feb 2023 15:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677078022;
        bh=7r+PiGpQC/jPWvSvPp3U+a5U5bek3m6CH3EArNTd7Z0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Hmj46h5FqsKYjWT0c+fkGLcvTAufr4S8vpNK/deuvZNA9+jLLfGAAofUmMDEAjDuH
         v46t9i8z8Wb9tpwyMjB55ctt/t/8/aptG2rwtrkv9K76Sg2YsgXBiKmML3bcAwOVI6
         P1LyhxpObORmoN/MaQ2+bpDmYCRtV+CfIoLD9Pkea7hWEYb77A+ROqAarvAhUCpL+I
         lcX4fPDGaU1kh/w85WcXX5UOYwG4e+D+0/KFyVNKRKoRpThsf+zgYlyrImLE1ogxx8
         KE6YYfdOm5BfpYRQBZrGjy9YX3l0MmULKSfXyTvrwWNbUUv0hA0t55/fScm5s9Oo06
         kwB6hf1bTeOkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 93B33C73FE7;
        Wed, 22 Feb 2023 15:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] Small fixups for the Zbb string functions
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167707802259.24438.1077934966472416097.git-patchwork-notify@kernel.org>
Date:   Wed, 22 Feb 2023 15:00:22 +0000
References: <20230208225328.1636017-1-heiko@sntech.de>
In-Reply-To: <20230208225328.1636017-1-heiko@sntech.de>
To:     =?utf-8?q?Heiko_St=C3=BCbner_=3Cheiko=40sntech=2Ede=3E?=@ci.codeaurora.org
Cc:     linux-riscv@lists.infradead.org, palmer@rivosinc.com,
        conor@kernel.org, linux-kernel@vger.kernel.org,
        christoph.muellner@vrull.eu, ajones@ventanamicro.com,
        heiko.stuebner@vrull.eu
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
    https://git.kernel.org/riscv/c/1eac28201ac0
  - [2/2] RISC-V: improve string-function assembly
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


