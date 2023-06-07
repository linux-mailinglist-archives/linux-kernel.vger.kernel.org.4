Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552CD725D1D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240072AbjFGLa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238532AbjFGLaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:30:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245541707;
        Wed,  7 Jun 2023 04:30:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B231163DE4;
        Wed,  7 Jun 2023 11:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEFD4C433A4;
        Wed,  7 Jun 2023 11:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686137422;
        bh=02ohk6uho+wdZeYJ3NbWDHfzlrRx7UjDJg/ozOIJ858=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=aJPzAKAWNoHnrRlCFfkwyFZkdKwr/8sC1yDwDvNni0dIaGnb9sZO1hMaTXWKP2/L6
         cK6GToNOnBKU0X6ZV+QCuoRM63kpYqVP0k3FxdpDt6BKo4C4qiH8qf28kdTiNhnYWn
         ZWvSYv3uIpRyPVBntWG6sgmS3+FgekjkNjHLeKWNFcKCn/hUrryq9uOk+7GxlhIqhK
         urtW2UTZPuJMEPN31EoS6YMqxE/uKJTY8W/doJxNhXaa4mzDGKJHGNMKLNKjArSNRk
         Gxcf+mCIb0PPeX2GmQkD2D0hO5FezHBxz6CP9kJz+Pis/HrsmA89wJigD4KVqEYjgs
         6braM724ICC0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6B06E4F13A;
        Wed,  7 Jun 2023 11:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: liquidio: fix mixed module-builtin object
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168613742187.29815.12409173950657122077.git-patchwork-notify@kernel.org>
Date:   Wed, 07 Jun 2023 11:30:21 +0000
References: <20230606171849.2025648-1-masahiroy@kernel.org>
In-Reply-To: <20230606171849.2025648-1-masahiroy@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-kernel@vger.kernel.org,
        dchickles@marvell.com, sburla@marvell.com, fmanlunas@marvell.com,
        simon.horman@corigine.com, terrelln@fb.com
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

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  7 Jun 2023 02:18:49 +0900 you wrote:
> With CONFIG_LIQUIDIO=m and CONFIG_LIQUIDIO_VF=y (or vice versa),
> $(common-objs) are linked to a module and also to vmlinux even though
> the expected CFLAGS are different between builtins and modules.
> 
> This is the same situation as fixed by commit 637a642f5ca5 ("zstd:
> Fixing mixed module-builtin objects").
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: liquidio: fix mixed module-builtin object
    https://git.kernel.org/netdev/net-next/c/f71be9d084c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


