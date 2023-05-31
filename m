Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19967189BF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 21:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjEaTAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 15:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjEaTAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 15:00:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B537412F;
        Wed, 31 May 2023 12:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34BE963D58;
        Wed, 31 May 2023 19:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F3B7C4339C;
        Wed, 31 May 2023 19:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685559621;
        bh=pvfnVzlP4+u/+g0/7F5jYWinAYAQmKCG1U/Qcyrb6I8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MbuekiCr0/I+Wu4Rw004qmMDI/nXZKcghUPjGkMaqQy1sitoHHNGxTX0Bdx5LljgS
         Kv7mlXEED1nhV3c47cXomU43v/FtmjQO43mAczq7S43IKc9imSFcXUw+oXy3Qr4HhW
         8fWEXg808Sm4Kh9aZ0k1hELpEXfG+iKkj0+vyQLuSj9go9yeUvlctKR8nfFFUQq/rv
         cd96eeMwXhMWtvcMWoFh9kV7Xl4c4LC8qcPIRn79LnzjlPgiz1GI1y9h38djT3I2Wh
         wbWlyC/MKJVFHxgo8nqoVd4pCZjdgq4VZ6QooyurH1YHC1FRpZb46wdiT5NUGx0kxH
         fuC1d9JJPyzQQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 548F5E4F0A6;
        Wed, 31 May 2023 19:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND 0/2] Bluetooth: fix bdaddr quirks
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168555962133.19706.9121953193856938504.git-patchwork-notify@kernel.org>
Date:   Wed, 31 May 2023 19:00:21 +0000
References: <20230531090424.3187-1-johan+linaro@kernel.org>
In-Reply-To: <20230531090424.3187-1-johan+linaro@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        mka@chromium.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 31 May 2023 11:04:22 +0200 you wrote:
> These patches fix a couple of issues with the two bdaddr quirks:
> 
> The first one allows HCI_QUIRK_INVALID_BDADDR to be used with
> HCI_QUIRK_NON_PERSISTENT_SETUP.
> 
> The second patch restores the original semantics of the
> HCI_QUIRK_USE_BDADDR_PROPERTY so that the controller is marked as
> unconfigured when no device address is specified in the devicetree (as
> the quirk is documented to work).
> 
> [...]

Here is the summary with links:
  - [RESEND,1/2] Bluetooth: fix invalid-bdaddr quirk for non-persistent setup
    https://git.kernel.org/bluetooth/bluetooth-next/c/92776a7e761e
  - [RESEND,2/2] Bluetooth: fix use-bdaddr-property quirk
    https://git.kernel.org/bluetooth/bluetooth-next/c/6ac517d8cf8b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


