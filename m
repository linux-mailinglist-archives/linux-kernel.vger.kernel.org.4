Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F228A5FBC66
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 22:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiJKUuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 16:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiJKUuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 16:50:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CFE2A739;
        Tue, 11 Oct 2022 13:50:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8724EB816AD;
        Tue, 11 Oct 2022 20:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23DE6C433D7;
        Tue, 11 Oct 2022 20:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665521417;
        bh=EkZDntzfhCC+LGw9OnjWM2/+O+hp2cF51ogIpBq6dPw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=i7x+i+wpodaUGUnxCSY5u9Af6yDJkAxqaMIyMsCfWqUpsVItaiuXruA4IlWKdCrEF
         obWFTzFRyqnnXHzuT2TAmGdV7YWIRekHsNpoO6nrWc41nm/CSQ0ekiQR6/EnnQk7J8
         Lu/Oc74UHvAd2dfShaLQ23ZjQXZ9syuLZ1kHWhHEksWgKZCl3A392tpLxat2Ps1Dfa
         bsVt7Q8U6ZyJw576+UKE7pe/p9bm6l8yW3v3X9wJmpg9V7nrnENy7+NLmpIwoFFFug
         CGjU0EqEOZi8bkmKt67aFmV4O9yT50JSPU1KTdCmgIHSftHtmvlwcVpO1P9Jm91utc
         FK4L4M50xG4yQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 07EE1E29F37;
        Tue, 11 Oct 2022 20:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/2] Bluetooth: Add btrealtek data struct and improve SCO
 sound quality of RTK chips
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166552141702.15349.18253290720492836485.git-patchwork-notify@kernel.org>
Date:   Tue, 11 Oct 2022 20:50:17 +0000
References: <20221005084331.1001-1-hildawu@realtek.com>
In-Reply-To: <20221005084331.1001-1-hildawu@realtek.com>
To:     Hilda Wu <hildawu@realtek.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        apusaka@chromium.org, yinghsu@chromium.org, max.chou@realtek.com,
        alex_lu@realsil.com.cn, kidman@realtek.com
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

On Wed, 5 Oct 2022 16:43:29 +0800 you wrote:
> From: Hilda Wu <hildawu@realtek.com>
> 
> Add btrealtek data struct and use definition of vendor flags to manage
> the specific chip.
> 
> The Bluetooth: btusb: Ignore zero length of USB packets on ALT 6 for
> specific chip need to transmit mSBC data continuously without the
> zero length of USB packets.
> 
> [...]

Here is the summary with links:
  - [v4,1/2] Bluetooth: btrtl: Add btrealtek data struct
    https://git.kernel.org/bluetooth/bluetooth-next/c/a0acc8e27228
  - [v4,2/2] Bluetooth: btusb: Ignore zero length of USB packets on ALT 6 for specific chip
    https://git.kernel.org/bluetooth/bluetooth-next/c/d6a615c8b539

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


