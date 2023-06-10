Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408CD72A9BE
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 09:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbjFJHMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 03:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbjFJHMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 03:12:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F81B3A9B
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 00:12:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E97563382
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 07:12:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A355C433D2;
        Sat, 10 Jun 2023 07:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686381136;
        bh=SV22PWx/vlOiTdejfpDBVO98csXRJ2C6VPjBezAOWzI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kalzse/ySprpbv1069UkP+IVM8InxjJz5Q9SNCg8ITC9GqCb1rRaodzS1STjeVT56
         JnPRckLNRA2b6zKl2eQCgS84tD5db+Aldx7PUtYoiJf+w+EvVWb+yNmrQPrFWhuVdT
         iiIDrLd2HfeqeNMsMppyNh8RKaIcWNBzcuIP0I5jInIlWbEJ+rafZL3kfED2f2JIqQ
         +cD6mtH4nHbyzNkKpx8n+HCj53cSv/4RFrKrtSIeDl4OuM/qgyU4h3RAja+b4ktrio
         lV0qQ3F3NqM9pWATzncYPlZa7sbq0hGzpmDzUbZzd2qmx/M6ONX9RUA5BLIP0ldURd
         58H/vuQDRG9qg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA7DDE1CF31;
        Sat, 10 Jun 2023 07:12:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] mptcp: unify PM interfaces
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168638113595.4960.8012275935135904829.git-patchwork-notify@kernel.org>
Date:   Sat, 10 Jun 2023 07:12:15 +0000
References: <20230608-upstream-net-next-20230608-mptcp-unify-pm-interfaces-v1-0-b301717c9ff5@tessares.net>
In-Reply-To: <20230608-upstream-net-next-20230608-mptcp-unify-pm-interfaces-v1-0-b301717c9ff5@tessares.net>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     mptcp@lists.linux.dev, martineau@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        geliang.tang@suse.com
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

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 08 Jun 2023 15:20:48 +0200 you wrote:
> These patches from Geliang better isolate the two MPTCP path-managers by
> avoiding calling userspace PM functions from the in-kernel PM. Instead,
> new functions declared in pm.c directly dispatch to the right PM.
> 
> In addition to have a clearer code, this also avoids a bit of duplicated
> checks.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] mptcp: export local_address
    https://git.kernel.org/netdev/net-next/c/dc886bce753c
  - [net-next,2/4] mptcp: unify pm get_local_id interfaces
    https://git.kernel.org/netdev/net-next/c/9bbec87ecfe8
  - [net-next,3/4] mptcp: unify pm get_flags_and_ifindex_by_id
    https://git.kernel.org/netdev/net-next/c/f40be0db0b76
  - [net-next,4/4] mptcp: unify pm set_flags interfaces
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


