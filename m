Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47177377FC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 01:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjFTXkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 19:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjFTXki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 19:40:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7896D1712
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 16:40:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE1F161326
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E8A2C433C0;
        Tue, 20 Jun 2023 23:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687304432;
        bh=MzePdahtLZw6+jL8v2zldGkseoJjdfgMR1ZbnZIcMew=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UVDlDRZgv9sXJbrpBdjjsfOwRl9EHMmr2QlzkgQ1EwEMc9xE2g/tLx1PxvcoLQkEG
         P5lYo26BBy7MOElPW+yibJpNYyTLCYFf1HCaHdzB3tskU3JfWD/WIVbuWo56LugKpk
         28wxxPQNRm2lDQgl2fYIUkUqPTd14rG/FrdZDGcKl0b0vhFK4nS6PPZQOgTGECnMJ0
         6TuXbGG+HaIZXpL2uCgsPxfdRZViB8z/VVc/adtN9D52kvTr/ct6L14F3Dxd/gBgjN
         cqU2c5e5fG6PCsUEVauXwPnchX2QRcTGVecI5rACO3EZwJaUb9d0PyqaE/nB4APJ94
         uqsGsya/7doYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 116EBE21EDB;
        Tue, 20 Jun 2023 23:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/3] bpf,
 arm64: use BPF prog pack allocator in BPF JIT
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168730443206.21092.6381881646118757164.git-patchwork-notify@kernel.org>
Date:   Tue, 20 Jun 2023 23:40:32 +0000
References: <20230619100121.27534-1-puranjay12@gmail.com>
In-Reply-To: <20230619100121.27534-1-puranjay12@gmail.com>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, catalin.marinas@arm.com,
        mark.rutland@arm.com, bpf@vger.kernel.org, kpsingh@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 19 Jun 2023 10:01:18 +0000 you wrote:
> BPF programs currently consume a page each on ARM64. For systems with many BPF
> programs, this adds significant pressure to instruction TLB. High iTLB pressure
> usually causes slow down for the whole system.
> 
> Song Liu introduced the BPF prog pack allocator[1] to mitigate the above issue.
> It packs multiple BPF programs into a single huge page. It is currently only
> enabled for the x86_64 BPF JIT.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/3] bpf: make bpf_prog_pack allocator portable
    https://git.kernel.org/bpf/bpf-next/c/9a44df2a4f2a
  - [bpf-next,v3,2/3] arm64: patching: Add aarch64_insn_copy()
    https://git.kernel.org/bpf/bpf-next/c/a7ed8ed92482
  - [bpf-next,v3,3/3] bpf, arm64: use bpf_jit_binary_pack_alloc
    https://git.kernel.org/bpf/bpf-next/c/49703aa2adfa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


