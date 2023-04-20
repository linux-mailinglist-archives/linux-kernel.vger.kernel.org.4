Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FBA6E9D98
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 23:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbjDTVAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 17:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjDTVAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 17:00:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BE05FC7;
        Thu, 20 Apr 2023 14:00:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5958D64159;
        Thu, 20 Apr 2023 21:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B71D2C4339C;
        Thu, 20 Apr 2023 21:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682024420;
        bh=HKRlgOYGrv+EnF39NqlKWcxXWTd3ozXhjEOa8Hc4gGY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cgrq2lyiF6n0xZqD0l7U/q2FLFX6sPa4tDh27wSPncy9fivwihVHP55jGA42Qtmyc
         OOqO+abzIEs/AS/9Q9ncxo5xm8ba6PB0RzUxAUPbiSSaDNt7YMco2IdIrkl2flxm6V
         wS8+N//LKvMwFTAmY7zQbZMTz6pbV93XoWEGCiGUrxTqNFj6MV0B5GpG0/Z+4f1K4v
         E5WATwZZgcgAwPlorY0Xrw7FydETNIB8gkegoNG/9WVi/MZpXj8nWvZZb730F5LJw4
         ZEv1GRwuNj1b7DwIEglS7fmB0tPiyVMHoDDVx9D2Zme65sDDVtPd0WyQ0zHj1syowe
         M5Mx2fOvXNdxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 98B72C395C8;
        Thu, 20 Apr 2023 21:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btnxpuart: Enable flow control before checking
 boot signature
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168202442062.11865.1139590238714814236.git-patchwork-notify@kernel.org>
Date:   Thu, 20 Apr 2023 21:00:20 +0000
References: <20230419152413.1688840-1-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20230419152413.1688840-1-neeraj.sanjaykale@nxp.com>
To:     Neeraj sanjay kale <neeraj.sanjaykale@nxp.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        pmenzel@molgen.mpg.de, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, amitkumar.karwar@nxp.com,
        rohit.fule@nxp.com, sherry.sun@nxp.com
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

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 19 Apr 2023 20:54:13 +0530 you wrote:
> This enables flow control before checking for bootloader signature and
> deciding whether FW download is needed or not. In case of V1 bootloader
> chips w8987 and w8997, it is observed that if WLAN FW is downloaded first
> and power save is enabled in wlan core, bootloader signatures are not
> emitted by the BT core when the chip is put to sleep. As a result, the
> driver skips FW download and subsequent HCI commands get timeout errors
> in dmesg as shown below:
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btnxpuart: Enable flow control before checking boot signature
    https://git.kernel.org/bluetooth/bluetooth-next/c/4b1f1ab59be1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


