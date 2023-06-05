Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFE0723267
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 23:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbjFEVk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 17:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjFEVkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 17:40:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDBCF2
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 14:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8919E62B19
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 21:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2A0EC433EF;
        Mon,  5 Jun 2023 21:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686001220;
        bh=A9OcsADokwb+SeoE0+3x1nsXSxcqDXKTkvN54zzAlEM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VGFW9zFEs6Sq7BJre6omPTGFVbWfCJN0gVaAl95xNwdmFNsXUxbUMrYoCfJSQjQhx
         gbc8yixtGFgCmGa6vVcqy6rPk7k/oicqSORZrcvBDJ62+SXIM4OPuEOUBgXpQnFNTD
         4vwgteK9bGq/3tolAswvNdEXqzGOm1IU0/aiFPYiHGh0xDwOcpRAQSV4TyRUhXRws2
         kLt7pTniVLpS/MUMgP55lkouxiXyNXiV65j1XmpX/AlKtTxcOmy5Ub2WrqbaK8Vcf3
         Bb3cjh0Ys/g41RQOmrS74eaCvyDe00Dkukce4j78pT7y/MzqlMR3CXuB2dYLDyCiYZ
         LnHzpqRNKLJxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B5205E4F0A8;
        Mon,  5 Jun 2023 21:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] bpf: Teach verifier that trusted PTR_TO_BTF_ID
 pointers are non-NULL
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168600122073.24826.11603138027046134322.git-patchwork-notify@kernel.org>
Date:   Mon, 05 Jun 2023 21:40:20 +0000
References: <20230602150112.1494194-1-void@manifault.com>
In-Reply-To: <20230602150112.1494194-1-void@manifault.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
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

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  2 Jun 2023 10:01:11 -0500 you wrote:
> In reg_type_not_null(), we currently assume that a pointer may be NULL
> if it has the PTR_MAYBE_NULL modifier, or if it doesn't belong to one of
> several base type of pointers that are never NULL-able. For example,
> PTR_TO_CTX, PTR_TO_MAP_VALUE, etc.
> 
> It turns out that in some cases, PTR_TO_BTF_ID can never be NULL as
> well, though we currently don't specify it. For example, if you had the
> following program:
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Teach verifier that trusted PTR_TO_BTF_ID pointers are non-NULL
    https://git.kernel.org/bpf/bpf-next/c/51302c951c8f
  - [bpf-next,2/2] selftests/bpf: Add test for non-NULLable PTR_TO_BTF_IDs
    https://git.kernel.org/bpf/bpf-next/c/f904c67876c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


