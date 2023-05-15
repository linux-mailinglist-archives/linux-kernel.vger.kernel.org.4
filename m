Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08E2703D98
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 21:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243447AbjEOTUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 15:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236004AbjEOTUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 15:20:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5000EB8
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 12:20:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8DDF62324
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 19:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14312C4339B;
        Mon, 15 May 2023 19:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684178420;
        bh=LyOJi/qVgBu0+z0V1xOl962sFcB/Su9DjQmlE4QBRNE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=AyyEcuF/IS+wc6DeMZRZrgihgsbzGj6FAxQ2m2WEgXt2VeG83lsZG1YocmTtX30lm
         I9j78XBptRV9G7xoU8ymS5lery2toYEYr1bgpyNgbkGhlYYz8527EhfpFmKQ8Ic6jK
         LBQgwzePQy/MBX3RmSGidkXf1fCnC2h2svUJ3kfOAyAkI5slraeIlJHVNrw1659cwU
         BwA1N9fQtLRvCdgRIXrPKlL8jKPXLw1uKR7oXagNlvwGzx6wRNhOl20EFNGBKypCCT
         BTw1DtjIr+cp4x50kEecpmJn2uccWIRInciojeeSf3K3xk7H4A9qz7nbndP/Y7owjJ
         rKdm4V6+RdW/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DCF01E49FAB;
        Mon, 15 May 2023 19:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] arm64,bpf: Support struct arguments in the BPF
 trampoline
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168417841990.1340.9887886289072485201.git-patchwork-notify@kernel.org>
Date:   Mon, 15 May 2023 19:20:19 +0000
References: <20230511140507.514888-1-revest@chromium.org>
In-Reply-To: <20230511140507.514888-1-revest@chromium.org>
To:     Florent Revest <revest@chromium.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
        mark.rutland@arm.com, xukuohai@huaweicloud.com, zlim.lnx@gmail.com,
        yhs@meta.com, yhs@fb.com
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

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 11 May 2023 16:05:07 +0200 you wrote:
> This extends the BPF trampoline JIT to support attachment to functions
> that take small structures (up to 128bit) as argument. This is trivially
> achieved by saving/restoring a number of "argument registers" rather
> than a number of arguments.
> 
> The AAPCS64 section 6.8.2 describes the parameter passing ABI.
> "Composite types" (like C structs) below 16 bytes (as enforced by the
> BPF verifier) are provided as part of the 8 argument registers as
> explained in the section C.12.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] arm64,bpf: Support struct arguments in the BPF trampoline
    https://git.kernel.org/bpf/bpf-next/c/90564f1e3dd6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


