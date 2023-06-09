Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749D07295C6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241876AbjFIJqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241841AbjFIJpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:45:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D5E46BB
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 02:40:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E61FD61470
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 09:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54157C4339C;
        Fri,  9 Jun 2023 09:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686303622;
        bh=QsjPUpkRO5qwm0xSfCepOjD6AFakWYdIF5Oxfmz3lLo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=AvozqRxhS8wdOWpuR2IwxLOVmHpV8OMtKTIHCUC7neJhPIcj0U3WCnCaV1SPs3fUx
         ZtZZnEaSHZi9HFWOYU/soFQ6G4oIdQNGLu/G+elYUGPsNLyOzdbuJ77t4V8jdZHXlG
         gw7fDR3K43wWua4e2M+DdiN5hiUnMse7FAMyAWthEcJcXVrFx2nzQ/tFDxk4y4BC0j
         bw56vf5WHzup4oz75gN08d2YGHA4uthN6HDJnBVrVATIgLjNu31yd45rSLh5zweRwD
         7yXv3q6PoIZUI846QY1ZA5zbTcw+9h5aTaUM6Db2LTl9qevFxUkmHKZqcaGPOvzIiy
         ayHvQP5+3FhJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3B998C43157;
        Fri,  9 Jun 2023 09:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/2] net/ncsi: refactoring for GMA command
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168630362223.15762.16643998871572719262.git-patchwork-notify@kernel.org>
Date:   Fri, 09 Jun 2023 09:40:22 +0000
References: <20230607151742.6699-1-fr0st61te@gmail.com>
In-Reply-To: <20230607151742.6699-1-fr0st61te@gmail.com>
To:     Ivan Mikhaylov <fr0st61te@gmail.com>
Cc:     sam@mendozajonas.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, vijaykhemka@fb.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
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

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  7 Jun 2023 18:17:40 +0300 you wrote:
> Make one GMA function for all manufacturers, change ndo_set_mac_address
> to dev_set_mac_address for notifiying net layer about MAC change which
> ndo_set_mac_address doesn't do.
> 
> Changes from v1:
> 	1. delete ftgmac100.txt changes about mac-address-increment
> 	2. add convert to yaml from ftgmac100.txt
> 	3. add mac-address-increment option for ethernet-controller.yaml
> 
> [...]

Here is the summary with links:
  - [v3,1/2] net/ncsi: make one oem_gma function for all mfr id
    https://git.kernel.org/netdev/net-next/c/74b449b98dcc
  - [v3,2/2] net/ncsi: change from ndo_set_mac_address to dev_set_mac_address
    https://git.kernel.org/netdev/net-next/c/790071347a0a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


