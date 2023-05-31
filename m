Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513797189BD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 21:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjEaTAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 15:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjEaTAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 15:00:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4D9123;
        Wed, 31 May 2023 12:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D6B66369E;
        Wed, 31 May 2023 19:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CD96C4339B;
        Wed, 31 May 2023 19:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685559621;
        bh=Fh8a6WqGbJo7SQiuYVBoQYDz5txFiTpj+2rQCKzZDoo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ap85i4OKRXygBr1A4PNTnz5fcWseTwzB6SyWK3NUoStAYkz+zQvjHp3tI1yLs/kHP
         2aWzXMTUKO2boMPY7A8qB4D6rW06qr8zdX3lggD0sitqDzvBfo0ftqOWgR3mlmliC9
         19mmXsphBb4Ie5PtBbxG0uV38AsbfyEzw2AcsHMZRWlELdTFhoJsWiBno76TfRt32f
         rb8iOyqtw9VOwkS+v3lLKBMrEvjRzfn3UHx4vd4wPsOpNkokQZwrRklGbSzCZM80wb
         XnW5VUaUf4mUh4POw8MvEpgmkWVeYHAH/+J7wygJKcoUShlX/yS/3IC/61fImTwoyU
         dihTakLNvlwPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 418FCE52BFB;
        Wed, 31 May 2023 19:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: HCI: fix use-after-free in
 hci_remove_ltk/hci_remove_irk
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168555962126.19706.755347480767573163.git-patchwork-notify@kernel.org>
Date:   Wed, 31 May 2023 19:00:21 +0000
References: <20230523115637.14541-1-lm0963hack@gmail.com>
In-Reply-To: <20230523115637.14541-1-lm0963hack@gmail.com>
To:     lm0963 <lm0963hack@gmail.com>
Cc:     luiz.dentz@gmail.com, marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

On Tue, 23 May 2023 19:56:37 +0800 you wrote:
> Similar to commit 0f7d9b31ce7a ("netfilter: nf_tables: fix use-after-free
> in nft_set_catchall_destroy()"). We can not access k after kfree_rcu()
> call.
> 
> Signed-off-by: Min Li <lm0963hack@gmail.com>
> ---
>  net/bluetooth/hci_core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Here is the summary with links:
  - Bluetooth: HCI: fix use-after-free in hci_remove_ltk/hci_remove_irk
    https://git.kernel.org/bluetooth/bluetooth-next/c/ca646650e617

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


