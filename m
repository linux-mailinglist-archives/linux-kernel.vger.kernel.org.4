Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895AC6BA36B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 00:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjCNXKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 19:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjCNXK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 19:10:27 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D67F460AD;
        Tue, 14 Mar 2023 16:10:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EA81BCE17BB;
        Tue, 14 Mar 2023 23:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12013C4339E;
        Tue, 14 Mar 2023 23:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678835421;
        bh=he9+eX/qxlOVc5NLfphaepMaTzE+siMIMb5ZhSybN3U=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=eShUVvEjx9pzxhAFgf7uqPLbKQ2BoGzMZYdN2oTD4B1+g9wKnyGzK1eOAXopgPtcW
         Wk6/TxWtgDvBP58ivKzDNQ2HvMYSmduY/SdgaW7fxd3276pxDiWNw8tth9sWzUML7n
         3sAbSNekKxUapDGfQqQpRX5KAJ1TC77wJU9g6CkakhQy47v3AN/fOjQGfvko7eIn25
         KsOOC+kl0c3ilKMFAuCXS62SOCq5i4iqmC9HdZxmf13oI14RcRtAk6c3/QqFYll+31
         5TYj40ujrgUD/vDaPcj1kRlmnXCzAXp+uy10vQBFp+FqNVamwQ4n4aPSHn5vnr+2VF
         pABGIzgswHbTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA155E524FF;
        Tue, 14 Mar 2023 23:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btsdio: fix use after free bug in btsdio_remove
 due to unfinished work
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167883542095.4543.7797236411801708072.git-patchwork-notify@kernel.org>
Date:   Tue, 14 Mar 2023 23:10:20 +0000
References: <20230309080739.3714610-1-zyytlz.wz@163.com>
In-Reply-To: <20230309080739.3714610-1-zyytlz.wz@163.com>
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
        alex000young@gmail.com
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

On Thu,  9 Mar 2023 16:07:39 +0800 you wrote:
> In btsdio_probe, &data->work was bound with btsdio_work.In
> btsdio_send_frame, it was started by schedule_work.
> 
> If we call btsdio_remove with an unfinished job, there may
> be a race condition and cause UAF bug on hdev.
> 
> Fixes: ddbaf13e3609 ("[Bluetooth] Add generic driver for Bluetooth SDIO devices")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: btsdio: fix use after free bug in btsdio_remove due to unfinished work
    https://git.kernel.org/bluetooth/bluetooth-next/c/f132c2d13088

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


