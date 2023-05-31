Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B347189BE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 21:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjEaTAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 15:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjEaTAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 15:00:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A62126;
        Wed, 31 May 2023 12:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29F6063C5A;
        Wed, 31 May 2023 19:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65E4BC4339E;
        Wed, 31 May 2023 19:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685559621;
        bh=hyY/JqW6K6nLzKDxiXx2110t3c/QHoR5jzju90vkioQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=smjiBPfSmG3K855Fps/QfhPC6bhUa9KJVAKE/WUyvBiS+ohdkE4+jR0f0uyof/XQ3
         gshglM9nJVQyQVErYwiz8PrdSsf9PnZweNnd1erNwRDantBorRzQZmMd0xXD/4XteK
         PrjwTEs4aXVSSDsYXXvJIAyBCECIZYH2udKvXPkuNCOPXJZh9fWF2TXTOIowERZCw6
         9B5tgr8JyEhuUaDNhx1z2HMWuX014GtCvUxxQl112OaIlMECP3CzVFnRBo9goVI6+q
         NAJj+fFZk/DGohVmT5V5b94iXwsGPJxBUc6L0xT7NCB/R92FHwETCTvtkCVVnZrZaw
         9fcYsxN+VKerg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A385E21EC7;
        Wed, 31 May 2023 19:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND 0/2] Bluetooth: fix debugfs registration
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168555962130.19706.12623481688693032536.git-patchwork-notify@kernel.org>
Date:   Wed, 31 May 2023 19:00:21 +0000
References: <20230531085759.2803-1-johan+linaro@kernel.org>
In-Reply-To: <20230531085759.2803-1-johan+linaro@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
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

On Wed, 31 May 2023 10:57:57 +0200 you wrote:
> The HCI controller debugfs interface is created during setup or when a
> controller is configured, but there is nothing preventing a controller
> from being configured multiple times (e.g. by setting the device
> address), which results in a host of errors in the logs:
> 
> 	debugfs: File 'features' in directory 'hci0' already present!
> 	debugfs: File 'manufacturer' in directory 'hci0' already present!
> 	debugfs: File 'hci_version' in directory 'hci0' already present!
> 	...
> 	debugfs: File 'quirk_simultaneous_discovery' in directory 'hci0' already present!
> 
> [...]

Here is the summary with links:
  - [RESEND,1/2] Bluetooth: fix debugfs registration
    https://git.kernel.org/bluetooth/bluetooth-next/c/3e972279b782
  - [RESEND,2/2] Bluetooth: hci_qca: fix debugfs registration
    https://git.kernel.org/bluetooth/bluetooth-next/c/22307d477e3f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


