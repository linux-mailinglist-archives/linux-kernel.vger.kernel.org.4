Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9332874249C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 13:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjF2LBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 07:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjF2LAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 07:00:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D981719
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 04:00:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9063C6152E
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 11:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E95A4C433CA;
        Thu, 29 Jun 2023 11:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688036423;
        bh=e9jePG6UyxbYwxB7xMCdKQwO1kR2D8zWNv2+CMxFbYE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Q1QwvUN6mvDTIkJz220KZYRgC8ST3XF/abvxj+7NOW1AwOXPz334USfiMws8OYgnX
         +xSQcVzx8COPaWhcA2sIS+8EAIo2rigsJKMs4N0uHJxQd7VBNVgCPbcz+dB8G6L7n8
         GbaMzZvRNchmoYOunjYi+Iybx1wJnsw6fa1DzIpUuIIiCaeVCreBCDq2yfVi+K6xII
         WaBxGSAu63CjKOy/Qk4pSYY6t4v4SZzQYvjreuXk2v28Z23JMp1WBXpDuCM5eMlGWE
         HTGntm3B6YeFdnbQn3cBHkifpXslLMsIs3YiWb3nSKgBWoXn3jQ/4eKD6my5I/R5MO
         sqjnYukFKBd2g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C8CBEC41671;
        Thu, 29 Jun 2023 11:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/3] Fix PTP packet drops with ocelot-8021q DSA tag
 protocol
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168803642280.5822.10953805337271532475.git-patchwork-notify@kernel.org>
Date:   Thu, 29 Jun 2023 11:00:22 +0000
References: <20230627163114.3561597-1-vladimir.oltean@nxp.com>
In-Reply-To: <20230627163114.3561597-1-vladimir.oltean@nxp.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, claudiu.manoil@nxp.com,
        alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
        xiaoliang.yang_1@nxp.com, richardcochran@gmail.com,
        atenart@kernel.org, linux-kernel@vger.kernel.org
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
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 27 Jun 2023 19:31:11 +0300 you wrote:
> Changes in v2:
> - Distinguish between L2 and L4 PTP packets
> v1 at:
> https://lore.kernel.org/netdev/20230626154003.3153076-1-vladimir.oltean@nxp.com/
> 
> Patch 3/3 fixes an issue with the ocelot/felix driver, where it would
> drop PTP traffic on RX unless hardware timestamping for that packet type
> was enabled.
> 
> [...]

Here is the summary with links:
  - [v2,net,1/3] net: mscc: ocelot: don't report that RX timestamping is enabled by default
    https://git.kernel.org/netdev/net/c/4fd44b82b7ac
  - [v2,net,2/3] net: mscc: ocelot: don't keep PTP configuration of all ports in single structure
    https://git.kernel.org/netdev/net/c/45d0fcb5bc95
  - [v2,net,3/3] net: dsa: felix: don't drop PTP frames with tag_8021q when RX timestamping is disabled
    https://git.kernel.org/netdev/net/c/2edcfcbb3c59

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


