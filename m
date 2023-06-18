Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317677345CF
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 12:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjFRKUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 06:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjFRKUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 06:20:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685538F;
        Sun, 18 Jun 2023 03:20:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2E7C61148;
        Sun, 18 Jun 2023 10:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B60DC433C9;
        Sun, 18 Jun 2023 10:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687083619;
        bh=l6Xo8X/qXpyCuetv0nWpu2k2NybFKErZPdAP74m9f44=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DGaDPtwcMFP68PIH2clT8HBixCjnps/XnWPQbhY7vXLsbxuQDPtVkoqCm1wbAwOWm
         wYL72EGWm//l4dyxFErujSiinqDYHmLI62lA3W1jPBL3qstSayUkJAv4tBM9slcGah
         6lOQ3M0K/dIIGk465jAIZpxMA+3H16jJW6ySJ5dWBQMlQGhBukn/0BkmBK8qqELnF9
         qsTzdulUVM84BTvm6EvjliFGAAl961tWnkDs1MWEgjH8pkggq12aixNngAECOBsMFs
         B1RZo4Gh2X5GfGUwTlN9JKZB4aOCA6/mK0zbZ5MKQtIHw4zc4aziB8h5ASAUdugjdM
         0iCGlRuVVTFFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3037BC395C7;
        Sun, 18 Jun 2023 10:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ieee802154/adf7242: Add MODULE_FIRMWARE macro
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168708361919.30416.7304884252982729819.git-patchwork-notify@kernel.org>
Date:   Sun, 18 Jun 2023 10:20:19 +0000
References: <20230616121807.1034050-1-juerg.haefliger@canonical.com>
In-Reply-To: <20230616121807.1034050-1-juerg.haefliger@canonical.com>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     michael.hennerich@analog.com, alex.aring@gmail.com,
        stefan@datenfreihafen.org, miquel.raynal@bootlin.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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
by David S. Miller <davem@davemloft.net>:

On Fri, 16 Jun 2023 14:18:07 +0200 you wrote:
> The module loads firmware so add a MODULE_FIRMWARE macro to provide that
> information via modinfo.
> 
> Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> ---
>  drivers/net/ieee802154/adf7242.c | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - ieee802154/adf7242: Add MODULE_FIRMWARE macro
    https://git.kernel.org/netdev/net/c/f593a94b530a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


