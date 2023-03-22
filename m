Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72106C59F9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 00:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjCVXAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 19:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjCVXAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 19:00:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D7F6588;
        Wed, 22 Mar 2023 16:00:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3EA11B81E5C;
        Wed, 22 Mar 2023 23:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7C09C433EF;
        Wed, 22 Mar 2023 23:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679526018;
        bh=TpKhjMd2ykbPDRW06PIinu5mXASt2hjOMVkMCU/PbpA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kxXdx/Rg59rPqHK2E/BrlAZhjUUsdzMVy5/2mcV1tV3Hqtc1HpjFfiUHaKCviMJ4o
         ycQ350c5wElPKauyBFWUuQeABTpLK9MRI1TNNyI3rrcd9k1bUSLb2YevGcwRA6ELvq
         m1FIpqB7eVvxq7ENy5Kwdd+kYzYNJlrNfSIvW+kEutkbTFT0b2j08yG+1DKZUeEt+i
         Xt+rIQu0Jd4Pr1iIEolkNiYVZU8JNtZpshQ9gjVWQ3N/VaSVAFxTOkFutMVw94PfLy
         9jYr2E40aTatCvlfwLP3bYYv14qc3O7PdeDIOsJRxV2lyJfJG0LTw05vOO9LibVq6l
         QWEIDgf4Pr1Gw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89984E66C8D;
        Wed, 22 Mar 2023 23:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: NXP: select CONFIG_CRC8
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167952601855.12488.5721473276968423229.git-patchwork-notify@kernel.org>
Date:   Wed, 22 Mar 2023 23:00:18 +0000
References: <20230322111636.1028838-1-arnd@kernel.org>
In-Reply-To: <20230322111636.1028838-1-arnd@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        neeraj.sanjaykale@nxp.com, ilpo.jarvinen@linux.intel.com,
        arnd@arndb.de, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 22 Mar 2023 12:16:27 +0100 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The driver needs both CRC32 and CRC8 to link correctly:
> 
> ld.lld: error: undefined symbol: crc8_populate_msb
> >>> referenced by btnxpuart.c
> >>>               drivers/bluetooth/btnxpuart.o:(nxp_serdev_probe) in archive vmlinux.a
> ld.lld: error: undefined symbol: crc8
> >>> referenced by btnxpuart.c
> >>>               drivers/bluetooth/btnxpuart.o:(nxp_send_ack) in archive vmlinux.a
> 
> [...]

Here is the summary with links:
  - Bluetooth: NXP: select CONFIG_CRC8
    https://git.kernel.org/bluetooth/bluetooth-next/c/335aed70654a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


