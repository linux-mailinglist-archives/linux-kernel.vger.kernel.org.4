Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44ACB6888E9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 22:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbjBBVUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 16:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBBVUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 16:20:21 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F186DB1B;
        Thu,  2 Feb 2023 13:20:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2D349CE2D3C;
        Thu,  2 Feb 2023 21:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72B38C433D2;
        Thu,  2 Feb 2023 21:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675372817;
        bh=3Jv2UMKJ0IzgcYUSbZattaaMhXW7euHwrpGmvpOiWAM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Tx6P/pQOiaACxwJi5oRuue5YSucfQn/xwlQrRcZscKVXRPjZloTR3ACQqUwXDYe9y
         SEqdT8nMM13EPKLefQPthTdnAxQY6pLPU/eAPuworl/2nZ62kqVNku9Auv2zoujAsh
         1S/SSmNs7CXHZ+tgGBM8mODcoKR39kkzIa/wbS7NgLx6omZ/E+zIvlzDKJGzwQgjvX
         xBEhW+CRxC62Q+7wekxwWbSlGixFELUMv33dTJGIVk9QH5DBxSotNAB2vSThDInebl
         MXcevwUhQkiFqBwWsUYk+k+Y+ZXxpNnn0W7h50qh83QvcsGfnSgSzri8uPJbpQbBQ0
         drZ2bVvry19Hg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 58606E5250B;
        Thu,  2 Feb 2023 21:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [kernel PATCH v1] Bluetooth: hci_qca: get wakeup status from serdev
 device handle
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167537281735.11585.12963558704988703806.git-patchwork-notify@kernel.org>
Date:   Thu, 02 Feb 2023 21:20:17 +0000
References: <20230202094659.kernel.v1.1.I7d79501f333609addbb0b39803a7bafb99e5b728@changeid>
In-Reply-To: <20230202094659.kernel.v1.1.I7d79501f333609addbb0b39803a7bafb99e5b728@changeid>
To:     Zhengping Jiang <jiangzp@google.com>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, chromeos-bluetooth-upstreaming@chromium.org,
        johan.hedberg@gmail.com, gubbaven@codeaurora.org,
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

On Thu,  2 Feb 2023 09:47:01 -0800 you wrote:
> Bluetooth controller attached via the UART is handled by the serdev driver.
> Get the wakeup status from the device handle through serdev, instead of the
> parent path.
> 
> Fixes: c1a74160eaf1 ("Bluetooth: hci_qca: Add device_may_wakeup support")
> Signed-off-by: Zhengping Jiang <jiangzp@google.com>
> 
> [...]

Here is the summary with links:
  - [kernel,v1] Bluetooth: hci_qca: get wakeup status from serdev device handle
    https://git.kernel.org/bluetooth/bluetooth-next/c/3d29daf4b155

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


