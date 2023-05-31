Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08B67176FD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 08:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbjEaGkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 02:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjEaGkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 02:40:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5073799
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 23:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE21462B2A
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 06:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3DE46C433D2;
        Wed, 31 May 2023 06:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685515220;
        bh=0F5CFyCNDWyVreznbLHgH1BLNQGO4dp1+YadEAadEiQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=iappkUMkqFEr+3R69Kuu+nLTMxh6Z5sBoPRKOxjqzcrPdo0GWMxEdNyVRBxeXqzIq
         0OXWmvNKn/luFWgV23+r1of0Mn5TDMB5nEI1SwVFbyIFCe7I/XMySKGAxx50sc4vSw
         OgeX1qSkLr+FgpMUL+YefS1R8Nqc7/uWuPIB1O1lUKKWE0iiIPoGrdnmwuWtzfQRlF
         j2ZFrFO0WAZFp0ykEGLznWUSVOXZllaqQWW+qo8CGtJ0OtzUlFvUfwCttR4eeT4eLi
         Y20J+0YwvYqNwQls+oVgOcpHBLL5jVi9UUS2L87txu4WvTHPHGAmm1Y7C6c6fN5P6Y
         q8u8YwcpZNnvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1EB22E52BF3;
        Wed, 31 May 2023 06:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 net 0/4] net/sched: Fixes for sch_ingress and sch_clsact
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168551522012.11093.1296970233634715565.git-patchwork-notify@kernel.org>
Date:   Wed, 31 May 2023 06:40:20 +0000
References: <cover.1685388545.git.peilin.ye@bytedance.com>
In-Reply-To: <cover.1685388545.git.peilin.ye@bytedance.com>
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, peilin.ye@bytedance.com,
        john.fastabend@gmail.com, daniel@iogearbox.net,
        vladbu@mellanox.com, pctammela@mojatatu.com, hdanton@sina.com,
        shaozhengchao@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, cong.wang@bytedance.com
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

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 May 2023 12:52:31 -0700 you wrote:
> Link to v5: https://lore.kernel.org/r/cover.1684887977.git.peilin.ye@bytedance.com/
> Link to v4: https://lore.kernel.org/r/cover.1684825171.git.peilin.ye@bytedance.com/
> Link to v3 (incomplete): https://lore.kernel.org/r/cover.1684821877.git.peilin.ye@bytedance.com/
> Link to v2: https://lore.kernel.org/r/cover.1684796705.git.peilin.ye@bytedance.com/
> Link to v1: https://lore.kernel.org/r/cover.1683326865.git.peilin.ye@bytedance.com/
> 
> Hi all,
> 
> [...]

Here is the summary with links:
  - [v6,net,1/4] net/sched: sch_ingress: Only create under TC_H_INGRESS
    https://git.kernel.org/netdev/net/c/c7cfbd115001
  - [v6,net,2/4] net/sched: sch_clsact: Only create under TC_H_CLSACT
    https://git.kernel.org/netdev/net/c/5eeebfe6c493
  - [v6,net,3/4] net/sched: Reserve TC_H_INGRESS (TC_H_CLSACT) for ingress (clsact) Qdiscs
    https://git.kernel.org/netdev/net/c/f85fa45d4a94
  - [v6,net,4/4] net/sched: Prohibit regrafting ingress or clsact Qdiscs
    https://git.kernel.org/netdev/net/c/9de95df5d15b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


