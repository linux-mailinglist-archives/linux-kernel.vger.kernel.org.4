Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C914717B63
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbjEaJLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235317AbjEaJKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:10:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935FC10C0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:10:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 237DC638A4
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 09:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7042DC433D2;
        Wed, 31 May 2023 09:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685524226;
        bh=7iyKw3AI+/PbLpT0npiMTd07y3q6m4qEfTjMG2C5ARI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=iE1bw8+GW9dTecVSBDFaNnMGAm4jRmSkWRgIN/2DiRzMrKzj//qAWjciwI74C4DLJ
         TI8I8drbyqBh49homjqctBzd3mi+jMHGm6j1tSrrnpxTQ2z9x9xZHNzH01pixUHhT3
         9sBKyxVAZTcPs6IXHkMZ324V4zxgvXOmG4CHwGNsR/kuNdk+f0i0Qs/BbfXK8oC0vp
         CgQj/SyHMuE20p0fXKnz6MhFZXukXGa6grfImVdZhTwD0+eedPCyUIbW2O8m9r8Puo
         4qCqLkuISz8g++tlHIqclJKXRny7juLK28R+Uc16uCOBcujbvt4iy0Odys0X3Fd56Q
         L7SOaekuXvHcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5162BE52C0F;
        Wed, 31 May 2023 09:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 0/3] dsa: marvell: Add support for mv88e6071 and 6020
  switches
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168552422632.12579.17095488160210315198.git-patchwork-notify@kernel.org>
Date:   Wed, 31 May 2023 09:10:26 +0000
References: <20230530083916.2139667-1-lukma@denx.de>
In-Reply-To: <20230530083916.2139667-1-lukma@denx.de>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     andrew@lunn.ch, olteanv@gmail.com, linux@armlinux.org.uk,
        edumazet@google.com, f.fainelli@gmail.com, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, alexander.duyck@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 30 May 2023 10:39:13 +0200 you wrote:
> After the commit (SHA1: 7e9517375a14f44ee830ca1c3278076dd65fcc8f);
> "net: dsa: mv88e6xxx: fix max_mtu of 1492 on 6165, 6191, 6220, 6250, 6290" the
> error when mv88e6020 or mv88e6071 is used is not present anymore.
> 
> As a result patches for adding max frame size are not required to provide
> working setup with aforementioned switches.
> 
> [...]

Here is the summary with links:
  - [v8,1/3] net: dsa: Define .set_max_frame_size() callback for mv88e6250 SoC family
    https://git.kernel.org/netdev/net-next/c/dd4144e54e81
  - [v8,2/3] net: dsa: mv88e6xxx: add support for MV88E6020 switch
    https://git.kernel.org/netdev/net-next/c/71d94a432a15
  - [v8,3/3] net: dsa: mv88e6xxx: add support for MV88E6071 switch
    https://git.kernel.org/netdev/net-next/c/372188c86e4b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


