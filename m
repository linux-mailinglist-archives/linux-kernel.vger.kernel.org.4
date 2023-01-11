Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E278665266
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 04:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbjAKDbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 22:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjAKDap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 22:30:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AD21742C
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 19:30:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A806C61A24
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B045C433EF;
        Wed, 11 Jan 2023 03:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673407824;
        bh=Gw1AmdmiVZBq3sF/ZF+37n7wMZ1O6JeczXxwErs3EQU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=g85St5edH8dqw235Go9GZYnu8g/iDrAJT+B9RMNwyoXZ4mhgrJWkbVhGlcGkH4hWH
         MDwg4dh5FXwdHC132/W5JBp63z4ZpgxQCr1o0qccTc1VF5512hM4xDxJROOxVJLIX5
         zeKVFfaS57d+udzJ/lg/NAC9S5OM3H1mVWNnGBhySPy9VwnBqjrde+9rENoDSXQF8+
         7zFVYzwdcDHq9eaTf2cu0RZK/096J9K2Kh9Bz+jZ3G3L2NDIonaCa+XByznn5++kPu
         qonn2yl8guif7Mnr/CQEG7Xc+DfDdoCHe8sbvG0L6qNNLOhHkDKYKhHtmjY72plumJ
         RLuVnXdeVIApA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DF2DEE524EE;
        Wed, 11 Jan 2023 03:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] platform/chrome: cros_ec_lpc: initialize the buf variable
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <167340782388.3713.8161675582261475081.git-patchwork-notify@kernel.org>
Date:   Wed, 11 Jan 2023 03:30:23 +0000
References: <20230110193611.3573777-1-trix@redhat.com>
In-Reply-To: <20230110193611.3573777-1-trix@redhat.com>
To:     Tom Rix <trix@redhat.com>
Cc:     bleung@chromium.org, groeck@chromium.org, nathan@kernel.org,
        ndesaulniers@google.com, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
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

On Tue, 10 Jan 2023 14:36:11 -0500 you wrote:
> Clang static analysis reports this problem
> drivers/platform/chrome/cros_ec_lpc.c:379:13: warning: The left operand
>   of '!=' is a garbage value [core.UndefinedBinaryOperatorResult]
>     if (buf[0] != 'E' || buf[1] != 'C') {
>          ~~~~~~ ^
> 
> The check depends on the side effect of the read.  When the read fails
> or is short, a buf containing garbage could be mistaken as correct.
> 
> [...]

Here is the summary with links:
  - platform/chrome: cros_ec_lpc: initialize the buf variable
    https://git.kernel.org/chrome-platform/c/2ae3c610e7d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


