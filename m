Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0428F644AA0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 18:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiLFRuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 12:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiLFRuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 12:50:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BFC2228D;
        Tue,  6 Dec 2022 09:50:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA715B81B00;
        Tue,  6 Dec 2022 17:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56067C433B5;
        Tue,  6 Dec 2022 17:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670349017;
        bh=vnrsEcjZq5+7qt/t33vzTsH4giZIyJwRDMHO+qQlWgI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nL/uGD9fqjH7/Lu+/zTKv5k9RoepNYWFXbT84eke+koxQADZz/6lS2eic7fUDSZJL
         sjtvqsNT/PEduUvdZYdhpsXuTw+G57B/Pb7FttXhv+h8yXcb2J5TaFkkgp0eVk9Vqj
         I9+bjrTzxXo/Vljxz3Qz744pv+zqtB+WFExX3RQwANRh/0vPOUoKvyZdeyizMToc7E
         5eztA9eNbu5e6tzfTNFiVwPcqwUEJ2DXmg/gMZsqLQTsUhFaSbY/7mkbBvjbkiQdcS
         Y0lIf7M07uVf4kWAt4BTaX5vYpFYej62PgZJijsu1Bgrqcuqvzp14oEjp8qEbnwbjQ
         UlQfevhmW7SHA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3CCC0E56AA2;
        Tue,  6 Dec 2022 17:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btintel: Fix missing free skb in
 btintel_setup_combined()
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167034901724.25798.17751229965672179058.git-patchwork-notify@kernel.org>
Date:   Tue, 06 Dec 2022 17:50:17 +0000
References: <20221205135357.3961836-1-bobo.shaobowang@huawei.com>
In-Reply-To: <20221205135357.3961836-1-bobo.shaobowang@huawei.com>
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     liwei391@huawei.com, marcel@holtmann.org, luiz.dentz@gmail.com,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 5 Dec 2022 21:53:57 +0800 you wrote:
> skb allocated by __hci_cmd_sync would not be used whether in checking
> for supported iBT hardware variants or after, we should free it in all
> error branches, this patch makes the case read version failed or default
> error case free skb before return.
> 
> Fixes: c86c7285bb08 ("Bluetooth: btintel: Fix the legacy bootloader returns tlv based version")
> Fixes: 019a1caa7fd2 ("Bluetooth: btintel: Refactoring setup routine for bootloader devices")
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: btintel: Fix missing free skb in btintel_setup_combined()
    https://git.kernel.org/bluetooth/bluetooth-next/c/6ae5399836fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


