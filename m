Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E1C70D141
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 04:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbjEWCa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 22:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbjEWCa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:30:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2CBE0;
        Mon, 22 May 2023 19:30:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A37FE62DF3;
        Tue, 23 May 2023 02:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03DD5C433D2;
        Tue, 23 May 2023 02:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684809019;
        bh=/gIqHoFjt8M64XKdDtFb6V1OoH2Wd0AkbZsnebu7fCA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=dFUXAc4CyQTWZ+4Prfnd2mjS8phO0hWvb33eu8rh276o43ALcaKvUTZFgaYJx16Jh
         4Ep+He9dHuXQnMZjfQgbBGskEq7MRX2OuonhGCwm1lo8JRp5kvzc8/GvJaJDnEicjO
         U3xZolAu/4E2ZNYLSY4dnv0UsqAFKf+M5luJKtLJgOquywmS+MrMXhICdiVw/YaSI+
         JO9M7Hyai9Pj6N2Y14AUS9D/Lue0p+nMSZfwOQ7FIGakPSwBsFDd1Bq7cpcFuhISPk
         h+3iKU1HD5GtKZiU5V2eXxv74AAjH889ZaBDhjBCZf/UY0g3moBYc0+aP6spHzNpor
         lgQVzT+KSX4NQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DC960E22B07;
        Tue, 23 May 2023 02:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] 3c589_cs: Fix an error handling path in tc589_probe()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168480901889.21333.9242102292843319105.git-patchwork-notify@kernel.org>
Date:   Tue, 23 May 2023 02:30:18 +0000
References: <d8593ae867b24c79063646e36f9b18b0790107cb.1684575975.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <d8593ae867b24c79063646e36f9b18b0790107cb.1684575975.git.christophe.jaillet@wanadoo.fr>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux@dominikbrodowski.net,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        netdev@vger.kernel.org
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

On Sat, 20 May 2023 11:48:55 +0200 you wrote:
> Should tc589_config() fail, some resources need to be released as already
> done in the remove function.
> 
> Fixes: 15b99ac17295 ("[PATCH] pcmcia: add return value to _config() functions")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/net/ethernet/3com/3c589_cs.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net] 3c589_cs: Fix an error handling path in tc589_probe()
    https://git.kernel.org/netdev/net/c/640bf95b2c7c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


