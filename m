Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4013171FCE6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbjFBJA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234099AbjFBJAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:00:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD6D1A6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 02:00:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6FF464DA2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 09:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F09D8C4339B;
        Fri,  2 Jun 2023 09:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685696419;
        bh=Fk+l9DZKdsNSTjZvKyeObVaDm8wwUDqpLO+9WsZPdEw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=IIKmcfkUUlA2fe5Xfh142xIFb6lo27nYLbTfDQTN5/g1FatT1Dqh9Ww6yw8WvDvAd
         cPkoI5qQlgD+OfAa2EjMjHZim2Hplz31cRwJ8FF09LCAbA48PR6efgsoYqatv5d4ar
         m9JA8wFlafeZkBhGTYHPQb2jxo45eJjtXgUP3bLnk3niElDBGoldabjmsRF8M9mQHD
         ZnKGjBaFMCr6wD0a8kCWJz+GyeHjW661/M2xS8HXEeh9ZCS46YF2WxLQ/Fscci5nIj
         mpXWtPy2rnMLRy90ROg3qUPmz0KxtyCG1dJufficp1tUj04d5UEFCukWPT3IXDUhXF
         vkuH8JmDeH2ng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D30AFC395E0;
        Fri,  2 Jun 2023 09:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net/ipv4: ping_group_range: allow GID from 2147483648
 to 4294967294
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168569641886.3424.10702306383468804424.git-patchwork-notify@kernel.org>
Date:   Fri, 02 Jun 2023 09:00:18 +0000
References: <20230601031305.55901-1-akihiro.suda.cz@hco.ntt.co.jp>
In-Reply-To: <20230601031305.55901-1-akihiro.suda.cz@hco.ntt.co.jp>
To:     Akihiro Suda <suda.gitsendemail@gmail.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, segoon@openwall.com, kuniyu@amazon.com,
        akihiro.suda.cz@hco.ntt.co.jp, suda.kyoto@gmail.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  1 Jun 2023 12:13:05 +0900 you wrote:
> With this commit, all the GIDs ("0 4294967294") can be written to the
> "net.ipv4.ping_group_range" sysctl.
> 
> Note that 4294967295 (0xffffffff) is an invalid GID (see gid_valid() in
> include/linux/uidgid.h), and an attempt to register this number will cause
> -EINVAL.
> 
> [...]

Here is the summary with links:
  - [net,v3] net/ipv4: ping_group_range: allow GID from 2147483648 to 4294967294
    https://git.kernel.org/netdev/net/c/e209fee4118f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


