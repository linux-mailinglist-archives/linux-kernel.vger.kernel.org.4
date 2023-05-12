Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B223700FD6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 22:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239502AbjELUkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 16:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238968AbjELUkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 16:40:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C0126AE;
        Fri, 12 May 2023 13:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCDCA6549E;
        Fri, 12 May 2023 20:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 022B8C4339C;
        Fri, 12 May 2023 20:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683924022;
        bh=RFMTTezwvJog/G6Yvn9MW4jnBNeAZIpG9k836AsxN2Q=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Pqfe+Gf2h0Dy29ygWpr/DAtTm/r4tfZZKXK2gCCaQ9iyNX6wz6p8eIoTTJoZFbF5N
         +PvwRxcHKCtY0aSioOubGzalKoltkYB/tR6io7NpDhAzTRHSBol3Mys5QIQQ2SHuHf
         4p360d0N4Ih7o49DHAwglWfQIiVPMVVfD/YazHxHVUlem7maUw7i6iHO2HfA6FPmTw
         hu+GQ2NZge43eDWlz2pqy/y0ryREY4DhcEOAwKDf0nt+kQMarWUuQ9twoZMnnXIwy1
         vgNc7bQZgMU72N5/P6ziA07W1oGZGQgrZX1/BTe3sYVZ/NifKIvK03NxYS+xtrTlrm
         vc/H2D5X4PPPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1B93E26D20;
        Fri, 12 May 2023 20:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/1] Bluetooth: btrtl: Add missing MODULE_FIRMWARE
 declarations
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168392402185.13139.13016199728773610543.git-patchwork-notify@kernel.org>
Date:   Fri, 12 May 2023 20:40:21 +0000
References: <20230509195119.9655-1-dan.gora@gmail.com>
In-Reply-To: <20230509195119.9655-1-dan.gora@gmail.com>
To:     Dan Gora <dan.gora@gmail.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
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

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  9 May 2023 12:51:19 -0700 you wrote:
> Add missing MODULE_FIRMWARE declarations for firmware referenced in
> btrtl.c.
> 
> Signed-off-by: Dan Gora <dan.gora@gmail.com>
> ---
>  drivers/bluetooth/btrtl.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [v2,1/1] Bluetooth: btrtl: Add missing MODULE_FIRMWARE declarations
    https://git.kernel.org/bluetooth/bluetooth-next/c/5a0830d69a77

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


