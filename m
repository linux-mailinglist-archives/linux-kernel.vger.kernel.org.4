Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AAE6AA6A7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 01:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjCDAu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 19:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCDAuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 19:50:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC1B5FE95;
        Fri,  3 Mar 2023 16:50:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB905B81A1C;
        Sat,  4 Mar 2023 00:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63138C4339E;
        Sat,  4 Mar 2023 00:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677891020;
        bh=4FbmRPeFiBlY8SC4Ui2iNIvrNbes1G5D8qC4NFkg3bQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ar2x9XQEzoIZS/PDptbUpeD0MQx0vQ+1kZIvtlPz7BIYnMGIsvvZPnNLTji+H2pJ3
         zY3vUUuMt5Dt2SAD2rHAIBY+mN6c1+WYA3biqbV7D1O1L2LJBIdig/uIkKxu6TsoGU
         LXPER8gXryb9hlkb9x6Z4qi02IeckOoNgZx2ZePAwMbguvA2lWZ9VlFzYW7G+/PcVj
         dkWI9rcTrvny49Uy+zpHmjUlNC7GTgAmZwH5Ld8yEDslS9Pu58oee9UvDfKWRW+1vm
         NroiqprM8g6VAwSIGjoeK0tZ8S1QDjoAzVqo4DVlaYzW7UvrmXmT40YgZ4nUtqCxL1
         cAQpZ8SlWX6Bw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 452FDC04E35;
        Sat,  4 Mar 2023 00:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btusb: Add new PID/VID 04ca:3801 for MT7663
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167789102028.19976.10449875720237508514.git-patchwork-notify@kernel.org>
Date:   Sat, 04 Mar 2023 00:50:20 +0000
References: <20230228055517.17348-1-tangmeng@uniontech.com>
In-Reply-To: <20230228055517.17348-1-tangmeng@uniontech.com>
To:     Meng Tang <tangmeng@uniontech.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhuweijun@uniontech.com
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

On Tue, 28 Feb 2023 13:55:17 +0800 you wrote:
> This bluetooth device is found in a combo WLAN/BT card
> for a MediaTek 7663.
> 
> Tested on Acer Aspire A315-24P Notebook
> 
> The device information:
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btusb: Add new PID/VID 04ca:3801 for MT7663
    https://git.kernel.org/bluetooth/bluetooth-next/c/5e9b50ee3995

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


