Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E786AF250
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 19:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbjCGSwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 13:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbjCGSwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 13:52:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9C3ABB05;
        Tue,  7 Mar 2023 10:40:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CEEB6154D;
        Tue,  7 Mar 2023 18:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1B45C4339E;
        Tue,  7 Mar 2023 18:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678214422;
        bh=0Km3cU2M71bUNgN4deuOVVicUmYwuXX7+MzpAI8YyRA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=IxtG0Hc0Ma8jZduCGVu0ababp6DD824SeUrXR1fSW6AkjHfb2GgGlJkmzfEPXA1f3
         1zDVLFHzbLrzTras0bffQxg17G+WdHlio7vpV8AeICJUQn5kvf64QKi/oQjFoiS8VJ
         AxEps4KThLh9vXTjpWFtcf3ZN0BxTKhpFjRnZ1zKcmuREIQtzKihxjnFPMLK6ljvn5
         J9JqI4TWQlVXWkFprZ/jPr40HuS5XY+sa8OsEPj6zcmbkfSK2nC2vVO7b6oM7amORH
         CV5rc+JxQEHh1eIsjmtvzIQF67HGO+6eykMabYywL06NhOKHMtE80FnjVYyuAAEUxM
         /Jq6rKJ1DsWYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1AE3E61B66;
        Tue,  7 Mar 2023 18:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] Bluetooth: btusb: Add new PID/VID 04ca:3801 for MT7633
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167821442265.6197.1268673976982343328.git-patchwork-notify@kernel.org>
Date:   Tue, 07 Mar 2023 18:40:22 +0000
References: <20230228051554.13501-1-tangmeng@uniontech.com>
In-Reply-To: <20230228051554.13501-1-tangmeng@uniontech.com>
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
    (no matching commit)
  - [2/2] Bluetooth: Add VID/PID 0489/e0e4 for MediaTek MT7922
    https://git.kernel.org/bluetooth/bluetooth-next/c/46c62fe67690

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


