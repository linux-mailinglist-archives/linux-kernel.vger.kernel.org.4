Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EDF715A7A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjE3Jl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjE3Jlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:41:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1402FC
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 02:41:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E0C362CA1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:41:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9EFAC433D2;
        Tue, 30 May 2023 09:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685439692;
        bh=2tuj7AtKSDuy0EDA4m4ZyONmVZkVqpCP2lFX0A5XKYY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=AcZ938CiuTHDpzzboIF8RW0NlzBK/DEqSJnt6odILEKP+Z4Rp66pLfL4yOCw5Pp9A
         62leyJwIUQbjBYR9Wxu+ufrXPeIeE27UF4Pik28lnptV4QV/xpbybJwZvtWkle58Dw
         /HcOGbrJvVL/itTid++rROZCp3EG6HxyYEmBM0dmGcl7qmyPrzBnawJ7hFX5EzzzwL
         aweUIWgtJYMO256G4VwYch/M2d++r1Vt5Kq4Ijn0Hde/WLwrBTbY9cmHcOEQcEkxMp
         B/dejAY2JLj4FKzUCIV+FY6neWeZbxUXD60eY468TjlwpJsYwyoMh2lqFUu0DtAks3
         +dE7fZoDJ14ew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE635E52C02;
        Tue, 30 May 2023 09:41:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/5] Microchip DSA Driver Improvements
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168543969270.28717.11968516011003747192.git-patchwork-notify@kernel.org>
Date:   Tue, 30 May 2023 09:41:32 +0000
References: <20230526073445.668430-1-o.rempel@pengutronix.de>
In-Reply-To: <20230526073445.668430-1-o.rempel@pengutronix.de>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     davem@davemloft.net, andrew@lunn.ch, edumazet@google.com,
        f.fainelli@gmail.com, kuba@kernel.org, pabeni@redhat.com,
        olteanv@gmail.com, woojung.huh@microchip.com,
        arun.ramadoss@microchip.com, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        UNGLinuxDriver@microchip.com, linux@armlinux.org.uk
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
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 26 May 2023 09:34:40 +0200 you wrote:
> changes v2:
> - set .max_register = U8_MAX, it should be more readable
> - clarify in the RMW error handling patch, logging behavior
>   expectation.
> 
> I'd like to share a set of patches for the Microchip DSA driver. These
> patches were chosen from a bigger set because they are simpler and
> should be easier to review. The goal is to make the code easier to read,
> get rid of unused code, and handle errors better.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/5] net: dsa: microchip: improving error handling for 8-bit register RMW operations
    https://git.kernel.org/netdev/net-next/c/2f0d579956e8
  - [net-next,v2,2/5] net: dsa: microchip: add an enum for regmap widths
    https://git.kernel.org/netdev/net-next/c/b8311f46c6f5
  - [net-next,v2,3/5] net: dsa: microchip: remove ksz_port:on variable
    https://git.kernel.org/netdev/net-next/c/bb4609d27f89
  - [net-next,v2,4/5] net: dsa: microchip: ksz8: Prepare ksz8863_smi for regmap register access validation
    https://git.kernel.org/netdev/net-next/c/ae1ad12e9da4
  - [net-next,v2,5/5] net: dsa: microchip: Add register access control for KSZ8873 chip
    https://git.kernel.org/netdev/net-next/c/d0dec3333040

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


