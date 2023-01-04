Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415AA65CBD9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 03:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbjADCUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 21:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbjADCUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 21:20:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B5165A0
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 18:20:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 350C1B811AE
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 02:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4A8EC433EF;
        Wed,  4 Jan 2023 02:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672798816;
        bh=ZUHKHBW7eF3pgJ1P2nbniqzyhJCqtgY/LQ81+kgcZoo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bWs7QOdpE5X0bN9LYtxCvPvwAGHuOJeOeLRi13YrAOvh/nuTfPfMn4FZi4MJLUIxS
         Ygx5kutn0T+lgxFzQjiJLxbSabGnn3uq18FkvKPdyHYyV4xR7cdIBe0KiHvlmzZgor
         Xo65PnpBroBRGjAfeFz1ijEpiclJ+SbRsgxfLeBLwCpAkJQJHC2y/My+muHK76BYDd
         zfpXneXsMEpB41T4LDW6+ZwRa0FBpMfHJ7ZnRJEfdn4wG9cHcqQ/u4QzzzNGIsKyyB
         RWWZ4eZlsfeW9fCD8Rlg2/F3XJ9vWLM1VuSwOsDnEwfZ6gJgOrTaJtfSSQPjLVe0ml
         99HL7OF/PyKwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8C79DC395EA;
        Wed,  4 Jan 2023 02:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 1/1] platform/chrome: cros_ec_proto: Use asm intead of
 asm-generic
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <167279881657.18893.12747939984396210121.git-patchwork-notify@kernel.org>
Date:   Wed, 04 Jan 2023 02:20:16 +0000
References: <20230103145023.40055-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230103145023.40055-1-andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     tzungbi@kernel.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        bleung@chromium.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-kernelci)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Tue,  3 Jan 2023 16:50:23 +0200 you wrote:
> There is no point to specify asm-generic for the unaligned.h.
> Drop the 'generic' suffix.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/platform/chrome/cros_ec_proto_test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [v1,1/1] platform/chrome: cros_ec_proto: Use asm intead of asm-generic
    https://git.kernel.org/chrome-platform/c/4c7cf5f290e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


