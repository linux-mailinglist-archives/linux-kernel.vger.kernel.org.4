Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3033C5B8F88
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 22:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiINUK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 16:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiINUKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 16:10:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E531151;
        Wed, 14 Sep 2022 13:10:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8083261EDC;
        Wed, 14 Sep 2022 20:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D684CC43470;
        Wed, 14 Sep 2022 20:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663186215;
        bh=9OZMr1n0GHCTt6IZXGKGKdtXKIOUSGIvPn8gy1kQ/4g=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VyXdUxzSiZcu1aDdrbdILLiW+n0b09Ni8LMynwA1wpv0ONBrsA4s9mM+S57Q2IdbF
         ggADrY0MriiV2lHFHy3uZUdT8w22t6XPEi8B7ryGAVFXIZTM8l9uvNAUVU0mcXQNMn
         wzBMKc6AoKxTP2LWWhRnt30hB2ZXK01s0pRAD5OIdWGMiftX+gpHscsQRnuMkfA8BB
         DdP9/pO1OZ0jgIm5hvO66XTA5DWQYNNnY4K1JJEyS17D3pEMkzHOhJH5mwnlFdhyuy
         BcPXwP/++I63LIIgDn1h0ZwVAiHgFnBxxkb8M0cZwvm84awznJVRyIEmKXYB4amZ7q
         X/MJ/FWvB2lbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BB342C73FF2;
        Wed, 14 Sep 2022 20:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add a new PID/VID 13d3/3583 for MT7921
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166318621576.18930.954047185528748078.git-patchwork-notify@kernel.org>
Date:   Wed, 14 Sep 2022 20:10:15 +0000
References: <cec2ae0d86aa633f3a6666e3812c1c05ab9a0d03.1661921257.git.objelf@gmail.com>
In-Reply-To: <cec2ae0d86aa633f3a6666e3812c1c05ab9a0d03.1661921257.git.objelf@gmail.com>
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com,
        Stella.Chang@mediatek.com, Tom.Chou@mediatek.com,
        steve.lee@mediatek.com, jsiuda@google.com, frankgor@google.com,
        abhishekpandit@google.com, michaelfsun@google.com,
        mcchou@chromium.org, shawnku@google.com,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Wed, 31 Aug 2022 12:53:28 +0800 you wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Add VID 13D3 & PID 3583 for MediaTek MT7921 USB Bluetooth chip.
> 
> The information in /sys/kernel/debug/usb/devices about the Bluetooth
> device is listed as the below.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: Add a new PID/VID 13d3/3583 for MT7921
    https://git.kernel.org/bluetooth/bluetooth-next/c/f0ad26ee822b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


