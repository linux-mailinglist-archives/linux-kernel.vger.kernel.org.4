Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73D47218B7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 18:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbjFDQ6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 12:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjFDQ6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 12:58:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C696E98
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 09:58:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62D9561692
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 16:58:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B26FBC4339B;
        Sun,  4 Jun 2023 16:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685897926;
        bh=cl8Z4lNxakzndB+ZO48d0dZ+UKVDOh+bjBhY3pf35Tk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LVkkRqNB4HqSao6f3z1gUXlAjJr8al6K52SRG94vhKMK1bIOuPAQwdV5j/h2067bS
         SvWr8+mCPQD3buYioWMS71Xb/lDW4SVjRCo8Nw1rS73waKCv0s9oTCZu2nCLLTSreA
         ZM1TVClyvg/j3liaYrZAxnxLxOGW3HU3E+lyFRTFwQGjGlFebuX3emErdVKdi7Sd1G
         aW+vWfYEhmqhNRw5DVtDgN/lKqQ4IYQnzUkzvWycv6v5RvCnKBQG1QvBkNp/7gfCHX
         E6eMIEgZ0pzVQrEhGe9KQMayKpsVmRzyZW10szep9pBIclQe3imw/gDgRogJTVq49y
         4iBLm8wxp+iYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 85A98C395E0;
        Sun,  4 Jun 2023 16:58:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] net: enetc: correct the statistics of rx bytes
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168589792654.18651.16742899391823119808.git-patchwork-notify@kernel.org>
Date:   Sun, 04 Jun 2023 16:58:46 +0000
References: <20230602094659.965523-1-wei.fang@nxp.com>
In-Reply-To: <20230602094659.965523-1-wei.fang@nxp.com>
To:     Wei Fang <wei.fang@nxp.com>
Cc:     claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.or,
        pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        hawk@kernel.org, john.fastabend@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  2 Jun 2023 17:46:57 +0800 you wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> The purpose of this patch set is to fix the issue of rx bytes
> statistics. The first patch corrects the rx bytes statistics
> of normal kernel protocol stack path, and the second patch is
> used to correct the rx bytes statistics of XDP.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: enetc: correct the statistics of rx bytes
    https://git.kernel.org/netdev/net/c/7190d0ff0e17
  - [net,2/2] net: enetc: correct rx_bytes statistics of XDP
    https://git.kernel.org/netdev/net/c/fdebd850cc06

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


