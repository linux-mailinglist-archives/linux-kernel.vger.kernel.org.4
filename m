Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89596BA36C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 00:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjCNXKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 19:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjCNXKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 19:10:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD39A2A6C2;
        Tue, 14 Mar 2023 16:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70514B81C1E;
        Tue, 14 Mar 2023 23:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 154D7C433A1;
        Tue, 14 Mar 2023 23:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678835421;
        bh=Y1jhSl5t1yRVm3V2cFgzlR2isIydaRbBCbb6BWOJaAo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=iOM6W9t6T47DsH4QzF3dwMVb8wxdToWbGDk+1cIhSwCHTUZFut+TnglodwUcg4Aaj
         y+28DddIDd0YQpFTfo9GlfNHkVmlp33gyQrS4pev5V+7n2ZQxjhtXRLEfwqU8G8Hz/
         0HSDERZNBUvLRWhblWEGH8Xqr3QNW0OQigd2BhnoEfNQjBaBHStxhz9OtAaYZmHnbp
         +BoNIQNmp0zfls7xjfnzGUHIyEr3DNno2fCOJ5tss6CXUECG6+CpgLTnwCDQy9tEBX
         9Ivx1txiDyzmcrjZvjzm5nqEa9PKAhgw8at5uACM3Eg48R2HQlJ/Bepj0OYuWJulwb
         rvQrUB42CXZaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F36B8E524FE;
        Tue, 14 Mar 2023 23:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 3/8] Bluetooth: hci_ldisc: Fix tty_set_termios() return value
 assumptions
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167883542099.4543.9923542324087254222.git-patchwork-notify@kernel.org>
Date:   Tue, 14 Mar 2023 23:10:20 +0000
References: <20230309082035.14880-4-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20230309082035.14880-4-ilpo.jarvinen@linux.intel.com>
To:     =?utf-8?q?Ilpo_J=C3=A4rvinen_=3Cilpo=2Ejarvinen=40linux=2Eintel=2Ecom=3E?=@ci.codeaurora.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, marcel@holtmann.org, johan.hedberg@gmail.com,
        luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  9 Mar 2023 10:20:30 +0200 you wrote:
> tty_set_termios() never returns anything else than 0. Make the debug
> prints to look directly into the new termios instead to check CRTSCTS
> state.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/bluetooth/hci_ldisc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [3/8] Bluetooth: hci_ldisc: Fix tty_set_termios() return value assumptions
    https://git.kernel.org/bluetooth/bluetooth-next/c/dd41882582a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


