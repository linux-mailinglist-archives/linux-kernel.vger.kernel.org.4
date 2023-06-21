Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B50C7379CC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 05:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjFUDke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 23:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjFUDkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 23:40:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D890419C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 20:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52D2161470
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 03:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F4F8C433A9;
        Wed, 21 Jun 2023 03:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687318822;
        bh=guk/06o7LZA+5U9RuKFJhdP5CGB0duQTyV9WuylmEWo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qr1TFLJbmpJJtWxnvuXruPzyCx4Ce2I5lKWWvNw7BG+wWuyb1aR3cXLtUc5WzfsPT
         cEP/PII02CvS1fpdWFLUxe40Bc1P31amWfxIrKC9DZQLB1kLHjsxQALtC45DDPn1GX
         9tApa+z0Hcz31v3RmjUC+tRTW4+boXZ1tNsUwqQ/xk6rupRFhcJb6OtBdnPXLstRi3
         gPYP5PxX5nLm3PcQ7VALm+Z+6vzvfL0wWvctfMvI4nmBEAuhyHY4uW0sHQP99biZS7
         JPooGZEiiAvtBy5w4J+bhgbByWp8SebuRWXO0NeQYi939ARNAXmlr/Nf7jXqvVBmKO
         A8Qq+zO4CpjjQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 27565C395D9;
        Wed, 21 Jun 2023 03:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] octeontx2-pf: TC flower offload support for rxqueue
 mapping
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168731882215.8371.13113440505535258115.git-patchwork-notify@kernel.org>
Date:   Wed, 21 Jun 2023 03:40:22 +0000
References: <20230619060638.1032304-1-rkannoth@marvell.com>
In-Reply-To: <20230619060638.1032304-1-rkannoth@marvell.com>
To:     Ratheesh Kannoth <rkannoth@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, sbhatta@marvell.com,
        gakula@marvell.com, schalla@marvell.com, hkelam@marvell.com
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

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Jun 2023 11:36:38 +0530 you wrote:
> TC rule support to offload rx queue mapping rules.
> 
> Eg:
>    tc filter add dev eth2 ingress protocol ip flower \
>       dst_ip 192.168.8.100  \
>       action skbedit queue_mapping 4 skip_sw
>       action mirred ingress redirect dev eth5
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-pf: TC flower offload support for rxqueue mapping
    https://git.kernel.org/netdev/net-next/c/365eb32e4b45

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


