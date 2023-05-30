Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D00715CEA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjE3LUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjE3LUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:20:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921B0D9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:20:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27DB462DE7
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 11:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 879A1C4339B;
        Tue, 30 May 2023 11:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685445619;
        bh=Kw0B/8XhmUXLGTGp3Rfh/cNTYSmZ/+xircdISkXbw3w=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uO4YoI90/CH58X+9SNu3TMI/CKp6tI/zRpkyYgkdUyYhFcDlwx/Q/GDDS3UGBGIRt
         2nXqiBF0Om9WzebGX5cM5j0qFLmdVd3138IFAuTbvO2ZqIO/a+GpGhmzUn7C1CPoyI
         BvvOl7EgAchv7mCS43nb5rcHGi/uC7ESyg1i4jtaVhDqDGkUzyfMhOIKwS5RHhZdgn
         sYj3hERjaMr50NbYGWASfDVslc90Zj5FjSNKZp/e2UUo0LaRgNZnff6ktEA+mXkZlN
         r6ZVup8QHoAYQBCNOytnJGlTeus38ZC5voxblZ7ME/gsQaMzG6ltvwBIVTnj2klWH6
         5Vn3x2OgpY/1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 69969E21EC5;
        Tue, 30 May 2023 11:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 1/1] dsa: lan9303: Remove stray gpiod_unexport()
 call
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168544561942.20232.5098259559740699879.git-patchwork-notify@kernel.org>
Date:   Tue, 30 May 2023 11:20:19 +0000
References: <20230528142531.38602-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230528142531.38602-1-andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     jerry.ray@microchip.com, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
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

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 28 May 2023 17:25:31 +0300 you wrote:
> There is no gpiod_export() and gpiod_unexport() looks pretty much stray.
> The gpiod_export() and gpiod_unexport() shouldn't be used in the code,
> GPIO sysfs is deprecated. That said, simply drop the stray call.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/net/dsa/lan9303-core.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next,v1,1/1] dsa: lan9303: Remove stray gpiod_unexport() call
    https://git.kernel.org/netdev/net-next/c/3ea3c9cff7f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


