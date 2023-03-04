Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A3A6AA6A4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 01:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjCDAu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 19:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjCDAuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 19:50:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0585F6FF;
        Fri,  3 Mar 2023 16:50:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 951B7B817BF;
        Sat,  4 Mar 2023 00:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57F57C4339B;
        Sat,  4 Mar 2023 00:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677891020;
        bh=JBqAuFyeYyOYu9wciIzcpaxMGdS4lok2GBq54XQ6U6I=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FXUmXtX5jqG1rL0IXSKW2hngqthdngkNxu5yp0/nKRl3jXg1gcqUti+VJ7GBV7pL9
         FMAPkjxHnsY8r77HKrMlmPSuG8v8bCKELouaV6A8+yF2NQqw5PUQ0rmCRUso7MsiIg
         K6p8yph6Grso6bopGRbIERJ9nAZlwllkzyQRdf2eTS890Q7V+7LHetlsFViPFwebrq
         FfKbkFuY/eZdpa3vkPB/T/8dOcRu6Ht8YBm4IXsHaSiWxwhDx76seqTeDbqo/rr+Er
         TY6v9FNVeShVapE0Y6ZHwRFJAQtpTsKR4YgkWn8AV/GnLWxqZ4wm6NGJD5N7CCgmgG
         kOw8y5ngJ/WSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C060C41679;
        Sat,  4 Mar 2023 00:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] Bluetooth: btusb: Add new PID/VID 04ca:3801 for MT7633
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167789102023.19976.11801319508370143784.git-patchwork-notify@kernel.org>
Date:   Sat, 04 Mar 2023 00:50:20 +0000
References: <20230228051554.13501-1-tangmeng@uniontech.com>
In-Reply-To: <20230228051554.13501-1-tangmeng@uniontech.com>
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

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 28 Feb 2023 13:15:53 +0800 you wrote:
> This bluetooth device is found in a combo WLAN/BT card
> for a MediaTek 7633.
> 
> Tested on Acer Aspire A315-24P Notebook
> 
> The device information:
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: btusb: Add new PID/VID 04ca:3801 for MT7633
    https://git.kernel.org/bluetooth/bluetooth-next/c/5e9b50ee3995
  - [2/2] Bluetooth: Add VID/PID 0489/e0e4 for MediaTek MT7922
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


