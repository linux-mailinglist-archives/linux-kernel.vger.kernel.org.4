Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36437747876
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 20:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjGDSu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 14:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGDSuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 14:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4F4E64
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 11:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 976B76135F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 18:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9D12C433C9;
        Tue,  4 Jul 2023 18:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688496622;
        bh=OHzmN/s5aiR09LX7MGMptKODSg0gdacao0bKTiZ24rU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WzOZYkLPdXDGx8Wkypyk2goP0IsdoIYQOseWT8KrWonDcyYhpy2YfrpwCAZcaxSFX
         2Yr8NYVAdY4l5lv1VFSaV4Qq+J0sZIHwI15zfKGMqGbtcwIpFd+hCOtj0AJRklAZ2J
         /rUFOlV+hwrGOm2746o5I45lZ4AUTsCkBnUwJAGcs3R5QHIkPdpgDBviJraYZ7+dJ7
         zYwLnwJV07ofXbiRQXeuGLdDIkQEfRPfzO6iHVwWQoTCy/fOx15xV4UdNxXiTnotnC
         nP1ZTpnrY72VYw2UBGvuqlNKnH2+SRRQ7za5X7sIY78m5g2UjtEfE+8y/8foqv2u11
         xvLQaKjZqCD6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CB2D4C6445A;
        Tue,  4 Jul 2023 18:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/2] Fix mangled link-local MAC DAs with SJA1105 DSA
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168849662182.30545.11329680467658735166.git-patchwork-notify@kernel.org>
Date:   Tue, 04 Jul 2023 18:50:21 +0000
References: <20230703220545.3172891-1-vladimir.oltean@nxp.com>
In-Reply-To: <20230703220545.3172891-1-vladimir.oltean@nxp.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-kernel@vger.kernel.org
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

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  4 Jul 2023 01:05:43 +0300 you wrote:
> The SJA1105 hardware tagging protocol is weird and will put DSA
> information (source port, switch ID) in the MAC DA of the packets sent
> to the CPU, and then send some additional (meta) packets which contain
> the original bytes from the previous packet's MAC DA.
> 
> The tagging protocol driver contains logic to handle this, but the meta
> frames are optional functionality, and there are configurations when
> they aren't received (no PTP RX timestamping). Thus, the MAC DA from
> packets sent to the stack is not correct in all cases.
> 
> [...]

Here is the summary with links:
  - [v2,net,1/2] net: dsa: tag_sja1105: fix MAC DA patching from meta frames
    https://git.kernel.org/netdev/net/c/1dcf6efd5f0c
  - [v2,net,2/2] net: dsa: sja1105: always enable the send_meta options
    https://git.kernel.org/netdev/net/c/a372d66af485

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


