Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCBD74FD12
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 04:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjGLCaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 22:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGLCaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 22:30:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF991722;
        Tue, 11 Jul 2023 19:30:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33995616A4;
        Wed, 12 Jul 2023 02:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F878C433C9;
        Wed, 12 Jul 2023 02:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689129020;
        bh=P4blXZ/KNZGfsUitb08zZr/C5+eX2FocoJvgmALEdm0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=paBfqdkuq3Sx5xcQMiTl27OWk9cKsQWxs54wgcPB6qC+8OIWNGpyFlAoe5YD+ONTu
         QHd0ad4oX8CeSB/oFc+3IwKq3i0xyBrjSbHTLvYObTb2pKwYnN0sK2YK99T6/hBmKj
         l7FxUe/Bt4+7bXfDudtYvj5TzFSYTGw5u7QA8nDoQN2rrMe5hW//N4PAs9dldQ32TG
         xDUVfuoaHDXYSWNzWF7j88kFRfLe6MVJ/IYO+fTm6h5AXuTYvbKTkjT/s+hiMU9p3N
         wtbx/hKXswz+VFeRqUqIUdhEXZl00qhfDrPYylEsFBNbQsD2KRqjDNjU2vFLLz5WF9
         grmXb1oFGT0xQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7184AE29F44;
        Wed, 12 Jul 2023 02:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] wifi: airo: avoid uninitialized warning in
 airo_get_rate()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168912902045.27748.5229570051520953441.git-patchwork-notify@kernel.org>
Date:   Wed, 12 Jul 2023 02:30:20 +0000
References: <20230709133154.26206-1-rdunlap@infradead.org>
In-Reply-To: <20230709133154.26206-1-rdunlap@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, geert@linux-m68k.org,
        kvalo@kernel.org, linux-wireless@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org
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
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  9 Jul 2023 06:31:54 -0700 you wrote:
> Quieten a gcc (11.3.0) build error or warning by checking the function
> call status and returning -EBUSY if the function call failed.
> This is similar to what several other wireless drivers do for the
> SIOCGIWRATE ioctl call when there is a locking problem.
> 
> drivers/net/wireless/cisco/airo.c: error: 'status_rid.currentXmitRate' is used uninitialized [-Werror=uninitialized]
> 
> [...]

Here is the summary with links:
  - [net] wifi: airo: avoid uninitialized warning in airo_get_rate()
    https://git.kernel.org/netdev/net/c/9373771aaed1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


