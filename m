Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F44374E369
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 03:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjGKBWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 21:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjGKBWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:22:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6A31701
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 18:21:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3318C612B3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 01:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 926F2C433C9;
        Tue, 11 Jul 2023 01:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689038421;
        bh=hn/g6yNfgEEXxR7VZVlWH5sSlNJkhabLWA9rOQ89w60=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=b32u56n1pDxs7P5+KTz1gErMYS8GsDdSj9Gjtkfmkr7qZTpzBFKk9MAxEBRtBBr35
         SMen9PV7yHfanGaA/VNZGxMUi0AHeBkA/zrpjN31fQ4nSZRh7jdGil/8shc2O5JTAz
         p7WHKJoqBjdSJWrdtF8MPv1wMH3kTga+5gvI+6BNgMbQt8wQYWdQgJyLwDpfxApXf0
         Ngk5yJ61Df5dH+MOZeOrZmOltd7/Tpu+yyLNwWT+cW7TzrUH2sj6+hGEtQfDosktNi
         ZlV8/qImboPZN37PosNni9D6Y+mvQx92U78+JSU8jSSORimdgerZzDWBnTwgpxrUEL
         5+APkfnaDRBFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78D06C395F8;
        Tue, 11 Jul 2023 01:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf,docs: Create new standardization subdirectory
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168903842148.8047.7806856535858862596.git-patchwork-notify@kernel.org>
Date:   Tue, 11 Jul 2023 01:20:21 +0000
References: <20230710183027.15132-1-void@manifault.com>
In-Reply-To: <20230710183027.15132-1-void@manifault.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com, bpf@ietf.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 10 Jul 2023 13:30:27 -0500 you wrote:
> The BPF standardization effort is actively underway with the IETF. As
> described in the BPF Working Group (WG) charter in [0], there are a
> number of proposed documents, some informational and some proposed
> standards, that will be drafted as part of the standardization effort.
> 
> [0]: https://datatracker.ietf.org/wg/bpf/about/
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf,docs: Create new standardization subdirectory
    https://git.kernel.org/bpf/bpf-next/c/4d496be9ca05

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


