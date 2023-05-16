Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700E670501A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 16:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbjEPOAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 10:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbjEPOAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 10:00:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524F54693
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 07:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E116263A5F
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 14:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46C2EC433EF;
        Tue, 16 May 2023 14:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684245621;
        bh=CycJxwzgp6NdmMm5PSA0/XzQXHs+2X2MUpAmyyID13k=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=q4B4fo0H9Smg68Mor77RXLThjn0vgF0H71IqBgNFW2LrpkLBcbKlPoJJX4tRFVDoM
         2ubtyypoHsJzSPD7uuPmqKusxoBxed4soktkS56h3AVcjV7lOCjfOeMK2+hfHA89YB
         vBj+TqcMBSthoVSJcyD9tNqKOveZi9x/YhSR//nb4DkMm7N1UyNXMQ1xZb3gln9ubb
         j2jln7A53WHDLhHuxjXAmlwdwEFUc0620COJKwwDlE1JFbZgKRXc86Ec/NulTM3zXy
         fR6pStfyI/yzgEdFKVeBh6q1oyASSG2ym4sj3LPKP3SLjG9DSMNHGr2+9mG3UegPvq
         nLVI9CmoxNHNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2998CE45237;
        Tue, 16 May 2023 14:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] SPDX conversion for bonding, 8390, and i825xx drivers
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168424562116.31205.13617747575033389868.git-patchwork-notify@kernel.org>
Date:   Tue, 16 May 2023 14:00:21 +0000
References: <20230515060714.621952-1-bagasdotme@gmail.com>
In-Reply-To: <20230515060714.621952-1-bagasdotme@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        j.vosburgh@gmail.com, andy@greyhouse.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        sammy@sammy.net, gerg@linux-m68k.org, simon.horman@corigine.com,
        trix@redhat.com, yangyingliang@huawei.com
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
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 15 May 2023 13:07:10 +0700 you wrote:
> This series is SPDX conversion for bonding, 8390, and i825xx driver
> subsystems. It is splitted from v2 of my SPDX conversion series in
> response to Didi's GPL full name fixes [1] to make it easily
> digestible.
> 
> The conversion in this series is divided by each subsystem and by
> license type.
> 
> [...]

Here is the summary with links:
  - [net,1/5] net: bonding: Add SPDX identifier to remaining files
    https://git.kernel.org/netdev/net-next/c/613a014191f5
  - [net,2/5] net: ethernet: 8390: Convert unversioned GPL notice to SPDX license identifier
    https://git.kernel.org/netdev/net-next/c/dc3eb2f4ec09
  - [net,3/5] net: ethernet: 8390: Replace GPL 2.0 boilerplate with SPDX identifier
    https://git.kernel.org/netdev/net-next/c/9f07af05d0e4
  - [net,4/5] net: ethernet: i825xx: Replace unversioned GPL (GPL 1.0) notice with SPDX identifier
    https://git.kernel.org/netdev/net-next/c/9ac40d080bef
  - [net,5/5] net: ethernet: i825xx: sun3_8256: Add SPDX license identifier
    https://git.kernel.org/netdev/net-next/c/4f693a8f5617

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


