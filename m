Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587045BC171
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 04:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiISCkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 22:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiISCkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 22:40:20 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F37632E
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 19:40:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B2319CE0F2C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 02:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8CDBC433D7;
        Mon, 19 Sep 2022 02:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663555215;
        bh=DI+gmo1jt0HOvuhR33uKwSgIEq8MtRFNhlVeQTS2NS4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PHruGXGGWFPVm0b/69nO3RBy7dvAEUMURI7i2qNrM5KxQXJbELu58yvsAS1K2FJpL
         gP6uNM9AJQzSyBExNlcxZSmMA3z4QFRM3PSNx2e6J4VTxdU5OQaXmINazVmwgyVQF3
         42wqwTyk1t/FaQvJuu/bCRwhzsPAlz9h64efyJWa1cYlQry2UTiv45gjaPZkjVQ7gr
         XLimLp2zrj3GgBZ9f0fxNBI/5XtbPCQ+S6NONPg64lRimk+0eWIiK3YNB0DFFQMZll
         ek1Xl1dbCs/P0dupkZBHdy7nnLpLnY2jlMmMBI8uhma0bv8RnQ1wg7Mnu8GPrTuj6O
         KU1wLufuwpNFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C95CE21ED2;
        Mon, 19 Sep 2022 02:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] platform/chrome: cros_ec: Notify the PM of wake events
 during resume
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <166355521563.20486.14302736310439629923.git-patchwork-notify@kernel.org>
Date:   Mon, 19 Sep 2022 02:40:15 +0000
References: <20220913204954.2931042-1-jthies@google.com>
In-Reply-To: <20220913204954.2931042-1-jthies@google.com>
To:     Jameson Thies <jthies@google.com>
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        pmalani@chromium.org, bleung@chromium.org, groeck@chromium.org,
        tzungbi@kernel.org
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

On Tue, 13 Sep 2022 20:49:54 +0000 you wrote:
> cros_ec_handle_event in the cros_ec driver can notify the PM of wake
> events. When a device is suspended, cros_ec_handle_event will not check
> MKBP events. Instead, received MKBP events are checked during resume by
> cros_ec_report_events_during_suspend. But
> cros_ec_report_events_during_suspend cannot notify the PM if received
> events are wake events, causing wake events to not be reported if
> received while the device is suspended.
> 
> [...]

Here is the summary with links:
  - [v4] platform/chrome: cros_ec: Notify the PM of wake events during resume
    https://git.kernel.org/chrome-platform/c/8edd2752b0aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


