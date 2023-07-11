Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA3074F69D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 19:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjGKRKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 13:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjGKRK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:10:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5448410C0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 10:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E231061587
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 17:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36AD4C433C9;
        Tue, 11 Jul 2023 17:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689095421;
        bh=KuzTMEs7J5RjDnJEbEDpEyUV5/7ysZRwvN6afL+U5LE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PdQqXKZnuWXKDD3Fe1sfJ9v66Kri9C2SwsolQ7rwWYc7M4TE02pWeVr2cIqqqrXyn
         J0uOkzpb6nw6X0pbGp4A1ejtIwa8uJ4w6I5IrswPjPxWb+NGus274rBb6n4XK5Dj4h
         tAHFp/wReRruVOcJgsLnlbxSb/Ge6Dcn8HegE1ESWZQDgddvngdTDELODdgmPWQomj
         S/5JxCjTTheLwq6xTuHaiIqv+4exsPV1vZSqekhaMEiIXSVG2AFe5tZzR2QQzYlTbP
         F7smMHBF910quRsYb0lIibpeWceMjAnsPcto6eafUwXmxc3aN1CxKeyUOnvkbSfXqU
         zYRfOmXlAMGOw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1187CE5381F;
        Tue, 11 Jul 2023 17:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] samples/bpf: syscall_tp: aarch64 no open syscall
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168909542106.17152.8261497932587649159.git-patchwork-notify@kernel.org>
Date:   Tue, 11 Jul 2023 17:10:21 +0000
References: <tencent_C6AD4AD72BEFE813228FC188905F96C6A506@qq.com>
In-Reply-To: <tencent_C6AD4AD72BEFE813228FC188905F96C6A506@qq.com>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     ast@kernel.org, rongtao@cestc.cn, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 11 Jul 2023 19:14:59 +0800 you wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> __NR_open never exist on AArch64.
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  samples/bpf/syscall_tp_kern.c | 4 ++++
>  1 file changed, 4 insertions(+)

Here is the summary with links:
  - [bpf-next] samples/bpf: syscall_tp: aarch64 no open syscall
    https://git.kernel.org/bpf/bpf-next/c/07018b57066e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


