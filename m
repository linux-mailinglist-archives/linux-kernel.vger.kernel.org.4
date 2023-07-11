Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A387674EC82
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 13:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjGKLUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 07:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjGKLUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:20:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3823F11D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4EFD6142E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 11:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1EF46C433C7;
        Tue, 11 Jul 2023 11:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689074421;
        bh=GYFBjWURXVpCTSxNPurIgg5XIkV1t3+Z846c7cc+7dg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GvP1nq3nt96eYGdYsMnKfwrNmRQ53h1lvnr32J4EvcwJI+IxmIpEkXnA1fVjzIpx3
         cDSyw5eQXHJG4PNpEsRRnPM9YyCz8ecMGlSmuQqVKv+YKEZi3r85DmFW1eNNiLq3W5
         a8X73GVt1K6/zqTgAIa3He5bPxU+AiTFX+o/ER6xAxygXBO9UQNCBYZmf92Gh56TpW
         hAjjiOYhG8u2GDJYhQ0ATPbqPx8ljhfxnim/qi61CqP/LkbtWnQXhxC0CurQDG9HrM
         rZYR3b0qdLSuLAYZhCvNvMkuAAbEyba8KiHLkELGlxMKKNRjMqzC4rlJDfzMPm3f9z
         /0hKTmTIuNumg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 043EBE4D010;
        Tue, 11 Jul 2023 11:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH V5] octeontx2-pf: Add additional check for MCAM rules
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168907442101.23063.4848906391252600918.git-patchwork-notify@kernel.org>
Date:   Tue, 11 Jul 2023 11:20:21 +0000
References: <20230710103027.2244139-1-sumang@marvell.com>
In-Reply-To: <20230710103027.2244139-1-sumang@marvell.com>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 10 Jul 2023 16:00:27 +0530 you wrote:
> Due to hardware limitation, MCAM drop rule with
> ether_type == 802.1Q and vlan_id == 0 is not supported. Hence rejecting
> such rules.
> 
> Fixes: dce677da57c0 ("octeontx2-pf: Add vlan-etype to ntuple filters")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net,V5] octeontx2-pf: Add additional check for MCAM rules
    https://git.kernel.org/netdev/net/c/8278ee2a2646

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


