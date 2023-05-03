Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32F06F52CD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjECIK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjECIKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:10:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A545599
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 01:10:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CDBE627B0
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 08:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B4D4C433D2;
        Wed,  3 May 2023 08:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683101424;
        bh=3CHjCfDp7Pv1imQOgY8v/8hC+1fjQAX3ePTWSqAm0Ic=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PXVetXbzlgbgqSTBlWdksSXEucudPVn0TnQkAGHcNCeNIIPdu7v6GwkonOnMLxV5s
         +mpH4+WUduwKk3llXkd83O4Tb3hTU/tUBv+9G7mo3iUe0pUyABaWuCyX1g18Fv3U3q
         7Woz1mh/ePQpFs4lrRJmOWTkvue6uT7gsExl5KWFUtED0EabYyZluDUUprOFMIcwJ+
         u1Kh6fH4r1aSmI3Q1rro9bsnmnh1UC7opDvTg5ngDT3aWwUFyVhKgub+WLGK9KTvys
         6X202vUf7a+RZfS8s1heuciqcIemNSOacQDH56mFFEb9pr9dErJsTdaVbGQc0Vi5qQ
         EiRq13Xzn0m6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3BB92C395FD;
        Wed,  3 May 2023 08:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH v5 00/11] octeontx2: Miscellaneous fixes
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168310142423.16336.14588338859037879117.git-patchwork-notify@kernel.org>
Date:   Wed, 03 May 2023 08:10:24 +0000
References: <20230503070944.960190-1-saikrishnag@marvell.com>
In-Reply-To: <20230503070944.960190-1-saikrishnag@marvell.com>
To:     Sai Krishna <saikrishnag@marvell.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, simon.horman@corigine.com,
        leon@kernel.org, sgoutham@marvell.com, gakula@marvell.com,
        lcherian@marvell.com, jerinj@marvell.com, hkelam@marvell.com,
        sbhatta@marvell.com
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
by David S. Miller <davem@davemloft.net>:

On Wed, 3 May 2023 12:39:33 +0530 you wrote:
> This patchset includes following fixes.
> 
> Patch #1 Fix for the race condition while updating APR table
> 
> Patch #2 Fix end bit position in NPC scan config
> 
> Patch #3 Fix depth of CAM, MEM table entries
> 
> [...]

Here is the summary with links:
  - [net,v5,01/11] octeontx2-af: Secure APR table update with the lock
    https://git.kernel.org/netdev/net/c/048486f81d01
  - [net,v5,02/11] octeontx2-af: Fix start and end bit for scan config
    https://git.kernel.org/netdev/net/c/c60a6b90e789
  - [net,v5,03/11] octeontx2-af: Fix depth of cam and mem table.
    https://git.kernel.org/netdev/net/c/60999cb83554
  - [net,v5,04/11] octeontx2-pf: Increase the size of dmac filter flows
    https://git.kernel.org/netdev/net/c/2a6eecc592b4
  - [net,v5,05/11] octeontx2-af: Add validation for lmac type
    https://git.kernel.org/netdev/net/c/cb5edce27176
  - [net,v5,06/11] octeontx2-af: Update correct mask to filter IPv4 fragments
    https://git.kernel.org/netdev/net/c/2075bf150ddf
  - [net,v5,07/11] octeontx2-af: Update/Fix NPC field hash extract feature
    https://git.kernel.org/netdev/net/c/406bed11fb91
  - [net,v5,08/11] octeontx2-af: Fix issues with NPC field hash extract
    https://git.kernel.org/netdev/net/c/f66155905959
  - [net,v5,09/11] octeontx2-af: Skip PFs if not enabled
    https://git.kernel.org/netdev/net/c/5eb1b7220948
  - [net,v5,10/11] octeontx2-pf: Disable packet I/O for graceful exit
    https://git.kernel.org/netdev/net/c/c926252205c4
  - [net,v5,11/11] octeontx2-vf: Detach LF resources on probe cleanup
    https://git.kernel.org/netdev/net/c/99ae1260fdb5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


