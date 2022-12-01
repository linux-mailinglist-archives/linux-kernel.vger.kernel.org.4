Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D7F63F8B6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 21:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiLAUAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 15:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiLAUAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 15:00:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BF522BF1;
        Thu,  1 Dec 2022 12:00:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5AEA6210A;
        Thu,  1 Dec 2022 20:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D45CC433B5;
        Thu,  1 Dec 2022 20:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669924818;
        bh=uGBsr/hstgwa729QsPkvdSJp6eIAUSt4S9XSEQd9+dI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UYXW+QlaEPfet5LGGba7bb5EyMZV2bUlI/RhlXXi/Jhze0mjdukPUWJqwEm75ktrI
         iy3yqtDjCnLolDALpxgpw0mdZgcv/G8mDfh7lYVlKydNhPdEfL9Lz5YORfTJCnq6C+
         03gYJyKEYYhpk1vawzS6ur6sJ6uXbBQqRHRhna2BRyavgR0RFl3OdPGnir7cbJ5pmp
         +iJTfEswu4yFXSJQXGS6zWDw0s64Um3xsg/pWZT/0poXO0z0zZKwvrkvbfLb+iI7Lt
         PiUsIIDQEPKMKO794s+CyJMZAVtIv8iWCHthFykjIAb2lDWyTZQJmqaDM62RjIhLlB
         pb70oA+A/9oqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 22708E52537;
        Thu,  1 Dec 2022 20:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] Bluetooth: btusb: Add a new PID/VID 13d3/3549 for
 RTL8822CU
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166992481813.20187.3684550416484948696.git-patchwork-notify@kernel.org>
Date:   Thu, 01 Dec 2022 20:00:18 +0000
References: <SI2PR02MB4603E18266419AF72EB5864BDD149@SI2PR02MB4603.apcprd02.prod.outlook.com>
In-Reply-To: <SI2PR02MB4603E18266419AF72EB5864BDD149@SI2PR02MB4603.apcprd02.prod.outlook.com>
To:     Gongwei Li <lifangpi@hotmail.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        pmenzel@molgen.mpg.de, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, 972624427@qq.com,
        ligongwei@kylinos.cn
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

On Thu,  1 Dec 2022 17:43:53 +0800 you wrote:
> From: Gongwei Li <ligongwei@kylinos.cn>
> 
> * /sys/kernel/debug/usb/devices
> T:  Bus=03 Lev=02 Prnt=02 Port=02 Cnt=03 Dev#=  5 Spd=12   MxCh= 0
> D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0bda ProdID=b85b Rev= 0.00
> S:  Manufacturer=Realtek
> S:  Product=Bluetooth Radio
> S:  SerialNumber=00e04c000001
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> 
> [...]

Here is the summary with links:
  - [v4] Bluetooth: btusb: Add a new PID/VID 13d3/3549 for RTL8822CU
    https://git.kernel.org/bluetooth/bluetooth-next/c/6fe6d1677693

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


