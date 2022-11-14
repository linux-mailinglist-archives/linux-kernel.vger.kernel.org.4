Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8917627495
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 03:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbiKNCaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 21:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiKNCaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 21:30:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DF9DE94
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 18:30:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45BB360E97
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85112C433C1;
        Mon, 14 Nov 2022 02:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668393015;
        bh=E+pRO4Psdv/JRv9kc42IvSz5hG67spVIFpfY6ShapHA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SFTo9AZz5e/+RdnUIh1C0Gbkrs4H1+R0DjEM0C7XXwOLc/AzZMeRceJdiDawwX2+g
         taT6jpY9kInsTbg/6/Mar/Y9KsKDoAhWI6H1vSfTb5hZsQ0Rruxe4aK3lKQXO+WnWX
         5W7wMFi4Pj5Om4A2Be4HD8kH17J7qJ8lMBAUHLyUjKKMtqiGIc8ApieOkbDLXxyw0d
         fmgMqD8pzYUqHQQwszRNZchP29pOp0F8Og8sJvTmAwQenYuoCXe9KUwWqlWj7v23UV
         HI8gUTVSkcEJ/OFpCIh+jHcpes3A9fbLYGfDQNEe9NYwlUgWTzZf27P6kb5U9InaYm
         UaSy/GrQXxt8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 65CC9E270C4;
        Mon, 14 Nov 2022 02:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] platform/chrome: cros_ec_lpc: Force synchronous probe
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <166839301541.23044.14707677829311972105.git-patchwork-notify@kernel.org>
Date:   Mon, 14 Nov 2022 02:30:15 +0000
References: <20221111231302.3458191-1-briannorris@chromium.org>
In-Reply-To: <20221111231302.3458191-1-briannorris@chromium.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     bleung@chromium.org, groeck@chromium.org, tzungbi@kernel.org,
        dmitry.torokhov@gmail.com, swboyd@chromium.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
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

On Fri, 11 Nov 2022 15:13:01 -0800 you wrote:
> This reverts commit bd88b965ae8c ("platform/chrome: cros_ec_lpc: Mark
> PROBE_PREFER_ASYNCHRONOUS"), and then some.
> 
> It has been reported that there are issues with 'cros-ec-keyb' devices
> that are children of this. As noted in the initial patch for its ACPI
> support (commit ba0f32141bc5 ("Input: cros_ec_keyb - handle x86
> detachable/convertible Chromebooks")), it's possible to probe an ACPI
> child device before its parent is probed -- hence the need for
> EPROBE_DEFER. Unfortunately, poking your parent's dev_get_drvdata()
> isn't safe with asynchronous probe, as there's no locking, and the
> ordering is all wrong anyway (drvdata is set before the device is
> *really* ready).
> 
> [...]

Here is the summary with links:
  - platform/chrome: cros_ec_lpc: Force synchronous probe
    https://git.kernel.org/chrome-platform/c/ca821c1f4ec1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


