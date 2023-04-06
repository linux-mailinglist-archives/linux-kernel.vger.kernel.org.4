Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF806DA441
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 23:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239964AbjDFVA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 17:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjDFVAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:00:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B447AA0;
        Thu,  6 Apr 2023 14:00:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 552CA64CA1;
        Thu,  6 Apr 2023 21:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6B78C4339E;
        Thu,  6 Apr 2023 21:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680814820;
        bh=lxPVkhPmUYtm3jDwsxt8qNEdEZ0oXkG23WIBFwHOauI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TXPl0+2Wnh3BPGasq4HB513RBatX1VFF60+2t9xCSQdsYoGtj1A37ODU3Nk3lTtl7
         fVl2fDjTV357KTvSkODiijIfobNDxXf6l7GgUPtZF+dcH69Q98J2hdM7KR0PKGi5Zy
         4xNPlpqX+Pzlk9aRcwUK2MYRezhPKHaKyONQkFW0h9gSbv8Kq9HaM6983coZU5p8qO
         BQrYbw67t1u9fxoRLOIBA0mdDGJR0+iVodldq5j3TbO3BRb0kPHk24BCvjzvCLh+Tb
         eqruqakdhFfpwEDQwzilm3zffqOOIbZFg/7O/l1Q0zSeC/63ejZmmqnjkkxhZl6SMs
         yq/g8HwWYTLlw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 97743E4F153;
        Thu,  6 Apr 2023 21:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btnxpuart: No need to check the received
 bootloader signature
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168081482061.2619.11741204657524521970.git-patchwork-notify@kernel.org>
Date:   Thu, 06 Apr 2023 21:00:20 +0000
References: <20230403122430.1024235-4-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20230403122430.1024235-4-neeraj.sanjaykale@nxp.com>
To:     Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  3 Apr 2023 17:54:30 +0530 you wrote:
> We can never assume the uart will deliver a complete packet to the BT
> layer at once, the expected packet may be divided into several parts by
> uart as uart doesn't know the received packet size, the received data
> count may mismatch with the expected packet size, so here
> is_valid_bootloader_signature() check may always return false.
> 
> Even we remove the count check in is_valid_bootloader_signature(), then
> the first part of the data which includes the packet type can pass the
> is_valid_bootloader_signature() check, but the remaining parts don't
> have the packet type data still cannot pass the check, here return
> directly will cause the data loss.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: btnxpuart: No need to check the received bootloader signature
    https://git.kernel.org/bluetooth/bluetooth-next/c/b1ff41fd0ee6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


