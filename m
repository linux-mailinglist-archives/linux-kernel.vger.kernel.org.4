Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44B573A7AD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 19:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjFVRu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 13:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjFVRuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 13:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3785A1BE3;
        Thu, 22 Jun 2023 10:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76969618D3;
        Thu, 22 Jun 2023 17:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF8DAC433C9;
        Thu, 22 Jun 2023 17:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687456220;
        bh=mecX4VsAue/U5mGaZYaeZjDfxNsXiRLEKNUKCBGBf9w=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UVQwAGwL9AJBkCoCU77NSU5DqR2nJ9N2id/uHHygN85XkOFAchKj7ShUlbuboUCy3
         k77NRcil3kvmmYSZLyIxng7heNokI39It2xXZrqMNuardOxFVKntmg//xpVdBamASA
         lGyUkDp8eA540/CzXeL+VydggQ697XaqENuCOcvqW9OHjm9LiILCX53dYGSRVgWtkq
         uW9NBt27hsrvMq732fWxpukk/vWR0lbzM6xObuJ625PnZEM0ybDTAdn5uyl+rRpEg7
         p72TRqIqDlkVnOpuo3YltXLvD2BJN/Z1f5U3Tg31nnkrqBNNdniImlf3M/2l2syI4u
         cnXGhmzy7teFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9ABEEC691EF;
        Thu, 22 Jun 2023 17:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf, docs: BPF Iterator Document
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168745622062.7216.11212431697621652773.git-patchwork-notify@kernel.org>
Date:   Thu, 22 Jun 2023 17:50:20 +0000
References: <20230622095407.1024053-1-aspsk@isovalent.com>
In-Reply-To: <20230622095407.1024053-1-aspsk@isovalent.com>
To:     Anton Protopopov <aspsk@isovalent.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, void@manifault.com, psreep@gmail.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, corbet@lwn.net
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

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 22 Jun 2023 09:54:07 +0000 you wrote:
> Fix the description of the seq_info field of the bpf_iter_reg structure which
> was wrong due to an accidental copy/paste of the previous field's description.
> 
> Fixes: 8972e18a439d ("bpf, docs: BPF Iterator Document")
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> ---
>  Documentation/bpf/bpf_iterators.rst | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [bpf-next] bpf, docs: BPF Iterator Document
    https://git.kernel.org/bpf/bpf-next/c/2404dd01b534

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


