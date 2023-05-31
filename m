Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A78D717DBA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 13:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235339AbjEaLK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 07:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjEaLKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 07:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50609E8;
        Wed, 31 May 2023 04:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC31C63538;
        Wed, 31 May 2023 11:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C4EDC4339B;
        Wed, 31 May 2023 11:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685531421;
        bh=HPyxuv+32mzuFbyIZZQ67hhRqs4/0tjF0wvqYmuefj0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kKhfu7Kmopcc58c7cdqLZA/bGu0gprPRt+0DkCKWv0KSnyX9DAU3og8QflYksObev
         PiEAUreCCuLbyKlrE4K2PUx/p/DfAwfqhjDKgCJKV04VkUvm9UJMQRAFPMt2Zf8+87
         s7dHrVcLzf4D1YmRB93lxtFpDnBLZ/AbvjvZmojyOs1uFzgDtSBd/ldFakMV73LRlV
         ruIFkwUxfw5YmiCONF0eBdRs364pPwo5LQiE0hXGIpPDnlyiltEQTBPxygfBidGHjY
         P+7RSNchvGVfAIrjFjnPrPU9TtRS2YRRILcordrk376P3fXUVVZ8e2XI5ZCB5Aw986
         VWW4rh1isQ7Dw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 23011E52C03;
        Wed, 31 May 2023 11:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf/tests: Use struct_size()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168553142113.8778.17191708621111165063.git-patchwork-notify@kernel.org>
Date:   Wed, 31 May 2023 11:10:21 +0000
References: <20230531043251.989312-1-suhui@nfschina.com>
In-Reply-To: <20230531043251.989312-1-suhui@nfschina.com>
To:     Su Hui <suhui@nfschina.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Wed, 31 May 2023 12:32:51 +0800 you wrote:
> Use struct_size() instead of hand writing it.
> This is less verbose and more informative.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  lib/test_bpf.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Here is the summary with links:
  - bpf/tests: Use struct_size()
    https://git.kernel.org/bpf/bpf-next/c/0d2da4b595d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


