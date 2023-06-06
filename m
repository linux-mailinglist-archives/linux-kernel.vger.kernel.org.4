Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE530724748
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 17:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbjFFPK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 11:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234842AbjFFPKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:10:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B98E40
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 08:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3378D62D50
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 15:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78AC0C4339B;
        Tue,  6 Jun 2023 15:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686064220;
        bh=bQr/eFi4VULMVyUdMjxoiN5haOdXvfPwHaB7Lt8UCr4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=h5IqtCCtOytUdbR9JJjXMWJz2mlIJwkzyrNE0HTSTYpjQ9z/VEch8Qm2FK4D1aj7A
         gyPHXzrj70U209T6jg0mpUMybxtkQvQLhNW6BR7MZscz6RPkMdRWFv2Ra9Lb+KrZKv
         Ph8p3GzKqgtQwcdJKXmVqDjCY6halmlRMXOnlhi2shOns8JHou24griY9gZHXwLs5Y
         Gbc1OeqArF9E+L8Adfx8WxxmOyXSBZcGoWfyACGd1CDoArbLI3NecS4Whei8SQSEhK
         4+/BsHD9dvdfDX4ILfu+QUwoyoxT9Kl/JtD6hYFciAwGlt2w7fabuvhv9NqS145kOi
         yFGEQgJGgNFZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 59F4CC4166F;
        Tue,  6 Jun 2023 15:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND] bpf: cleanup unused function declaration
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168606422036.10567.7750110941195035658.git-patchwork-notify@kernel.org>
Date:   Tue, 06 Jun 2023 15:10:20 +0000
References: <20230606021047.170667-1-gongruiqi@huaweicloud.com>
In-Reply-To: <20230606021047.170667-1-gongruiqi@huaweicloud.com>
To:     Ruiqi Gong <gongruiqi@huaweicloud.com>
Cc:     andrii.nakryiko@gmail.com, sdf@google.com, ast@kernel.org,
        daniel@iogearbox.net, john.fastabend@gmail.com,
        martin.lau@linux.dev, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangweiyang2@huawei.com,
        xiujianfeng@huawei.com, gongruiqi1@huawei.com
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

On Tue,  6 Jun 2023 10:10:47 +0800 you wrote:
> All usage and the definition of `bpf_prog_free_linfo()` has been removed
> in commit e16301fbe183 ("bpf: Simplify freeing logic in linfo and
> jited_linfo"). Clean up its declaration in the header file.
> 
> Signed-off-by: Ruiqi Gong <gongruiqi@huaweicloud.com>
> Acked-by: Stanislav Fomichev <sdf@google.com>
> Link: https://lore.kernel.org/all/20230602030842.279262-1-gongruiqi@huaweicloud.com/
> 
> [...]

Here is the summary with links:
  - [RESEND] bpf: cleanup unused function declaration
    https://git.kernel.org/bpf/bpf-next/c/aa6182707a53

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


