Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091A871FCEA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbjFBJAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbjFBJAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:00:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254471A7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 02:00:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF56F64DA3
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 09:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E30BC433D2;
        Fri,  2 Jun 2023 09:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685696419;
        bh=uOErDDWPpio4SFtiIgvWQbN5603ru0tviyKBLEbh4bI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=I1W3BB8jE3g9JzxzApKrTtUrf0IA42fYwsVNO6dZhMmIBmimm6bSgdFld9t/Q29M/
         S8NW6B5mcvRGR7w7rqp14C9g112VLzSnssnHQDbfkcQFS0U46RWK2YKKqmdrZ9KXDh
         rQRCqbDsmPWLrk8B8BaCgXEHBqZVCGhq/rTdS3RUbM5nHFC7Zjnr2FD/DNmTOML3oC
         IYbqwKr6HHFntXTlCGRtYUh26dReFPibSPpPUNQJOKOlqjC4sR9uYhOE+7Lf9yXk6y
         X7Iio2xrnYrvQHIa0OZVwinGBkw6rOYaUAUuppIRymO4Q/imO40rN6u0i48CAd6+0i
         aSl7p2Gd9LcMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DD9F4E49FA9;
        Fri,  2 Jun 2023 09:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: systemport: Replace platform_get_irq with
 platform_get_irq_optional
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168569641890.3424.4096762437597839432.git-patchwork-notify@kernel.org>
Date:   Fri, 02 Jun 2023 09:00:18 +0000
References: <20230601033002.869-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20230601033002.869-1-jiasheng@iscas.ac.cn>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     justin.chen@broadcom.com, f.fainelli@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, bcm-kernel-feedback-list@broadcom.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu,  1 Jun 2023 11:30:02 +0800 you wrote:
> Replace platform_get_irq with platform_get_irq_optional because wol_irq
> is optional.
> 
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/net/ethernet/broadcom/bcmsysport.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - net: systemport: Replace platform_get_irq with platform_get_irq_optional
    https://git.kernel.org/netdev/net/c/f93b30e50a81

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


