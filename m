Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50070655F92
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 04:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbiLZDlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 22:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiLZDld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 22:41:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A009EDED;
        Sun, 25 Dec 2022 19:41:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 271BC60C63;
        Mon, 26 Dec 2022 03:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 877B9C43392;
        Mon, 26 Dec 2022 03:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672026091;
        bh=eEt0EmGRhDWnVkZQUlJF6mUiacUHBLfsxUqi7rzOu0U=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nsu/D+BMLaCwIog1O38CcS0qOZzS46gIcIrjp+6fueQjrGJ1wVmEUmHa8uvmmq/OR
         HA6zo/jnoibF2XWPt4xMwtTe1gH7Kq2/cN2n1NzfIGGeoK95B2hWaFEG26oqowUBkI
         R+N9YVtjt2oyyEq36avmeloch/uf0m1GINzW/0JWHv2hS1BLK1rwX/WPbq+VPWcqDZ
         KNghu6G7p+3iq2h/3TB8SXBSsTTAbz4zk3zsIOU6/zeTqO51sbg80DEZ2Cu9c1cOf5
         NuG1x7FfLAJEbCJe20C0ycXFM+Xhlh31/VhysT7dptBpn0QFGf4Td6Y8wpqo7tsM1g
         skLMBPx26GdKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6E3BEFE0855;
        Mon, 26 Dec 2022 03:41:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] platform/chrome: cros_ec_typec: Link PD object to
 partner
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <167202609144.9518.765740468177252042.git-patchwork-notify@kernel.org>
Date:   Mon, 26 Dec 2022 03:41:31 +0000
References: <20221122220538.2991775-1-pmalani@chromium.org>
In-Reply-To: <20221122220538.2991775-1-pmalani@chromium.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        chrome-platform@lists.linux.dev, bleung@chromium.org,
        gregkh@linuxfoundation.org, groeck@chromium.org,
        heikki.krogerus@linux.intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to chrome-platform/linux.git (for-next)
by Greg Kroah-Hartman <gregkh@linuxfoundation.org>:

On Tue, 22 Nov 2022 22:05:35 +0000 you wrote:
> This is a short series to link a registered USB PD object to its associated
> partner device. This is helpful for userspace services (the ChromeOS Type-C
> daemon, for example), to identify which Type-C peripheral a PD object belongs to,
> when a uevent for the PD object arrives.
> 
> The first patch adds a wrapper to the Type-C class code to register a PD object
> with a Type-C partner as its parent. The second patch uses that wrapper to
> register the Type-C partner USB PD object in the port driver code.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] usb: typec: Add partner PD object wrapper
    https://git.kernel.org/chrome-platform/c/032399819dd5
  - [v2,2/2] platform/chrome: cros_ec_typec: Set parent of partner PD object
    https://git.kernel.org/chrome-platform/c/ab3593eeef60

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


