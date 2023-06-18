Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155637345D5
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 12:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjFRKaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 06:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjFRKaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 06:30:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782A5E5E
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 03:30:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 159B360C6E
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 10:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 710AEC433C9;
        Sun, 18 Jun 2023 10:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687084219;
        bh=5fsuaDnwo2qvmwk8ou2lxLE0fvol54AynpeZPNcwaPM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lDsrpVBDDA6CnkU/0DJrMu+5EtLL74KbXD5m+eqaoLiLac4kIN1LOt7EM5BsrCn72
         g0B24gBDO8sZ6umP7D6UrFTJcQsxkuDb+xDtqyQ32eTYqRprTL9DqbcwcVd4y8Rcsp
         588Jw41xyTMboYzVQpI16bpXH/S9i98PoSkRe9VF86zFA93J2RYc4J6BmB0BB9DQ7t
         ymKtK9iWAgbnOXqunV+YhH7LDDASZ/Jtza5IwqoiURpxgf44Fb/CzzEontlOrKo3iJ
         WNKMyvZ5LXsZOPI2isB5OY3AwChO5IhJPLFHsdFMD34d6sB6l+oJHSR3/wIS4JDGUu
         Nh43sS4bQSu6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 56C08E21EE5;
        Sun, 18 Jun 2023 10:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] nfc: fdp: Add MODULE_FIRMWARE macros
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168708421935.2238.16204190681278158265.git-patchwork-notify@kernel.org>
Date:   Sun, 18 Jun 2023 10:30:19 +0000
References: <20230616122218.1036256-1-juerg.haefliger@canonical.com>
In-Reply-To: <20230616122218.1036256-1-juerg.haefliger@canonical.com>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     krzysztof.kozlowski@linaro.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        shangxiaojing@huawei.com
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

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 16 Jun 2023 14:22:18 +0200 you wrote:
> The module loads firmware so add MODULE_FIRMWARE macros to provide that
> information via modinfo.
> 
> Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> ---
>  drivers/nfc/fdp/fdp.c | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - nfc: fdp: Add MODULE_FIRMWARE macros
    https://git.kernel.org/netdev/net/c/eb09fc2d1416

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


