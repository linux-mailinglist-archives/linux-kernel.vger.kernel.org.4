Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3075BC265
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 07:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiISFAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 01:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiISFAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 01:00:20 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0E21A829
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 22:00:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DA3E2CE0AE8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 05:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3517C433D7;
        Mon, 19 Sep 2022 05:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663563615;
        bh=+DCEMpaMdnaYqiMZpq0fjxyahfdsk4bJFiF78SlX0g0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=L3mhGYeDZqGIjrTWfTKEUaIA3wL8wZyCsybiWRyI39jRkUoSASXeuu/SArGVYXM4e
         SG2bYFS18daWb/9Bq80tbMJHjgMfYuStkZuGPFY7jsP09QG/aAFuNAXL9+jLwigtGs
         d55URuXkbvh1NZPgyFZuRenIRWCmjknTeme7Irs4a9l7+igXtaMEcPwqu8GZXTW+kW
         TF8EMhT4MTOITEJoH8FN8gPwOUAhfMgaDceNWAIU/iW7rHhLrnymexnq6bWQ7Mn9IS
         mAsETDbFmzxAKg4C+/u8WartdneHfk2YLjtp85eCjt7KN2kSxwOlVQVSUxaZRBa0vK
         TcbJmSsIywUrg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE3E2E21ED4;
        Mon, 19 Sep 2022 05:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] platform/chrome: cros_ec: Notify the PM of wake events
 during resume
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <166356361570.17778.16769404823889593571.git-patchwork-notify@kernel.org>
Date:   Mon, 19 Sep 2022 05:00:15 +0000
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

This patch was applied to chrome-platform/linux.git (for-next)
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


