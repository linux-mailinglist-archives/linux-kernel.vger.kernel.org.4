Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B1473924B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 00:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjFUWK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 18:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjFUWKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 18:10:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE32B1992;
        Wed, 21 Jun 2023 15:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43340616DB;
        Wed, 21 Jun 2023 22:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A637C433C9;
        Wed, 21 Jun 2023 22:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687385423;
        bh=jVgDhBoRTvZ6I5+cfLGcpChhJvWte8ZlsYgmvJp1jF8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=F1g6k8Xi0GYBBkBpJsvcB56/hPvq/w/WGd3ow/Hbfg9fdIW4ocKC7/FHvIGjz0m9b
         PMVtapXNxNsyjHONZ8kPKPqNuYhJf70J4iFS4aUm4191/PtCptY59UVIf97TmT2MhG
         2RwQe5Do398TcqFS/iiI7dRNHc6kRsJ4DBy62TjL9dI7x7alEf0IH0UVOVrl4IOVzu
         GpXREwleGVmeGPz2nTKQdc6MpblUJqHDbSbhfMJtKidUVQAqjhAVDZG+8F2iqXIomA
         hTUsIy0ECnJu00tWYzQCIJw9GJ+IZe9LpXHPRsz27PaipgINTqeIJZ30QVgETX6OAv
         T7S6+t4Zs4RLQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75DFAE2A034;
        Wed, 21 Jun 2023 22:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v5 0/3] leds: trigger: netdev: add additional modes
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168738542347.32529.17106611701898066780.git-patchwork-notify@kernel.org>
Date:   Wed, 21 Jun 2023 22:10:23 +0000
References: <20230619204700.6665-1-ansuelsmth@gmail.com>
In-Reply-To: <20230619204700.6665-1-ansuelsmth@gmail.com>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     pavel@ucw.cz, lee@kernel.org, andrew@lunn.ch, davem@davemloft.net,
        dan.carpenter@linaro.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
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
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Jun 2023 22:46:57 +0200 you wrote:
> This is a continue of [1]. It was decided to take a more gradual
> approach to implement LEDs support for switch and phy starting with
> basic support and then implementing the hw control part when we have all
> the prereq done.
> 
> This should be the final part for the netdev trigger.
> I added net-next tag and added netdev mailing list since I was informed
> that this should be merged with netdev branch.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/3] leds: trigger: netdev: add additional specific link speed mode
    https://git.kernel.org/netdev/net-next/c/d5e01266e7f5
  - [net-next,v5,2/3] leds: trigger: netdev: add additional specific link duplex mode
    https://git.kernel.org/netdev/net-next/c/f22f95b9ff15
  - [net-next,v5,3/3] leds: trigger: netdev: expose hw_control status via sysfs
    https://git.kernel.org/netdev/net-next/c/b655892ffd6d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


