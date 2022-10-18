Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD1160239D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 07:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiJRFBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 01:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiJRFAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 01:00:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E926745D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 22:00:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8CCC1B81CF3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 05:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B885C433D6;
        Tue, 18 Oct 2022 05:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666069217;
        bh=w7QphWyjGK/WYfbY/3FSQAteBAcnMbqJVv9qbe1FMmc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=HmSm0HUUFEcl58PP8GbMK8oAhJpHD1bplW46/ttCr15gAwc1lm3kO2Mty+rr/qG6e
         nfvCvl7OhLZON4tLmGA1R4RvH0DO9dPtAyegtq93WBzxnbQG3wFXwmM9NH//CldgYE
         kJInZVN4j6GqcimlLpqzSbCqlprGvRJPYmMOSFrwjACW+Gm/vY2bvPhl3pex9T96BL
         8zCI3ddOIldVfJyqNvsNaKR6QCnAx6VdmWNlk4BevyCFlpMQClqcE0bmuPz6j+OkYo
         qhOEz50O6tMwV7PpBN+crqMDP+QbD2ecGbMnAPaWlOvc1Z/Jrz2ZML0Bmb4R3h680N
         EyOehrRZi8g7w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C0B1E270E9;
        Tue, 18 Oct 2022 05:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6] platform/chrome: add a driver for HPS
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <166606921704.4690.3565166154461436779.git-patchwork-notify@kernel.org>
Date:   Tue, 18 Oct 2022 05:00:17 +0000
References: <20221018040623.2173441-1-dcallagh@chromium.org>
In-Reply-To: <20221018040623.2173441-1-dcallagh@chromium.org>
To:     Dan Callaghan <dcallagh@chromium.org>
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        skyostil@chromium.org, bleung@chromium.org, tzungbi@kernel.org
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Tue, 18 Oct 2022 15:06:23 +1100 you wrote:
> This patch introduces a driver for the ChromeOS human presence
> sensor (aka. HPS). The driver supports a sensor connected to the I2C bus
> and identified as "GOOG0020" in the ACPI tables.
> 
> When loaded, the driver exports the sensor to userspace through a
> character device. This device only supports power management, i.e.,
> communication with the sensor must be done through regular I2C
> transmissions from userspace.
> 
> [...]

Here is the summary with links:
  - [v6] platform/chrome: add a driver for HPS
    https://git.kernel.org/chrome-platform/c/5f9952548d91

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


