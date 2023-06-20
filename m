Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98DC573667D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 10:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjFTIkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 04:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbjFTIkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 04:40:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFBEDB
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 01:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4457E6109A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 08:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E070C433C8;
        Tue, 20 Jun 2023 08:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687250421;
        bh=kErwKwo+EYHKvcMbPgNsAvybz33Jox8dGvAzlDYX0WE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TE9W033wJe1vrj2BD1Fq4qgDk/ooJrhb+2sELLFNU9vk1Q4wDd6ZnnggUIi6KKh1o
         05zlC4xtLjureKdpJpdzEXnMn1qay8Epr/Ht2Fx+MXTd4ZlpxEKDKaqqt+vXsia0IZ
         k7SZg1FF/9/kJPUOVQseKp4rZk6owNMqAeD0hcJUoC/6JsekBGQStkU430lZI2yS+L
         e25pDl6YaxQ5dUhJ/QgE99HsuT00TN1zgOfHzxWFz4ul2sxjuJRRk/ljkXKfAtc3Zb
         InVRXXWV0goyPl9TmgQvcwqXqTRdSrhxlIB9eu2JtPeD0iECnC+2Kh1KfOL3SnT9Lf
         EKwZ7Chnrdo1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7E73EE21EDF;
        Tue, 20 Jun 2023 08:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dpaa2-mac: add 25gbase-r support
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168725042151.7255.16176413891658881208.git-patchwork-notify@kernel.org>
Date:   Tue, 20 Jun 2023 08:40:21 +0000
References: <20230616111414.1578-1-josua@solid-run.com>
In-Reply-To: <20230616111414.1578-1-josua@solid-run.com>
To:     Josua Mayer <josua@solid-run.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ioana.ciornei@nxp.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk
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

On Fri, 16 Jun 2023 14:14:14 +0300 you wrote:
> Layerscape MACs support 25Gbps network speed with dpmac "CAUI" mode.
> Add the mappings between DPMAC_ETH_IF_* and HY_INTERFACE_MODE_*, as well
> as the 25000 mac capability.
> 
> Tested on SolidRun LX2162a Clearfog, serdes 1 protocol 18.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> 
> [...]

Here is the summary with links:
  - net: dpaa2-mac: add 25gbase-r support
    https://git.kernel.org/netdev/net/c/9a43827e876c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


