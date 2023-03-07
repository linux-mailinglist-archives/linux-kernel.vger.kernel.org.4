Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68ABB6AF26D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 19:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbjCGSxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 13:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbjCGSw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 13:52:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F426C80A0;
        Tue,  7 Mar 2023 10:40:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6857D61549;
        Tue,  7 Mar 2023 18:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CAE1CC433A4;
        Tue,  7 Mar 2023 18:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678214422;
        bh=R2Lpba+MkRvsa6QrLYhDE6ruAc4fIRvAMahbLiqKjJo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jiPf8mJHipjZwGEDRzOGPSHnUFgl3X8r6ST9pYpl4qfdEzhpp1ajRU6aKjTgUGiLX
         XQjS/t5rbGRIZl7m2AJn0YFAy2Hl3lNEubcrWb8OdkSJOOk0+0J0I7SuOb4A96kxCY
         Evz6JQmBU1kpfs1QQHD+YQafAZVCjH8Yl5R0mE8YWCubz3Q53ZHbg6YvbMVBVEJGrc
         oeHnsyo9jHLM16NIlssc4nmGxvFef4u8nmj7fIRI0gTuhBhWpLHiFG3pCIPX4WGV4m
         dh276nNvvp0VOnxdCOBbnNfLqYBsfrKSLn2w5KrpECJR/1tF7XvGc7vQ/aLc3U5Tzl
         1VsUdXXvlmM+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ABCCBE61B69;
        Tue,  7 Mar 2023 18:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: Add VID/PID 0489/e0e4 for MediaTek MT7922
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167821442269.6197.5946656447305088602.git-patchwork-notify@kernel.org>
Date:   Tue, 07 Mar 2023 18:40:22 +0000
References: <20230306014459.25023-1-tangmeng@uniontech.com>
In-Reply-To: <20230306014459.25023-1-tangmeng@uniontech.com>
To:     Meng Tang <tangmeng@uniontech.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhuweijun@uniontech.com
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

On Mon,  6 Mar 2023 09:44:59 +0800 you wrote:
> Tested on Acer Nitro AN515-47 Notebook
> 
> output from /sys/kernel/debug/usb/devices:
> 
> T:  Bus=03 Lev=01 Prnt=01 Port=02 Cnt=02 Dev#=  2 Spd=480  MxCh= 0
> D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0489 ProdID=e0e4 Rev= 1.00
> S:  Manufacturer=MediaTek Inc.
> S:  Product=Wireless_Device
> S:  SerialNumber=000000000
> C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=100mA
> A:  FirstIf#= 0 IfCount= 3 Cls=e0(wlcon) Sub=01 Prot=01
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=125us
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
> I:* If#= 2 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
> E:  Ad=8a(I) Atr=03(Int.) MxPS=  64 Ivl=125us
> E:  Ad=0a(O) Atr=03(Int.) MxPS=  64 Ivl=125us
> I:  If#= 2 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
> E:  Ad=8a(I) Atr=03(Int.) MxPS= 512 Ivl=125us
> E:  Ad=0a(O) Atr=03(Int.) MxPS= 512 Ivl=125us
> 
> [...]

Here is the summary with links:
  - Bluetooth: Add VID/PID 0489/e0e4 for MediaTek MT7922
    https://git.kernel.org/bluetooth/bluetooth-next/c/46c62fe67690

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


