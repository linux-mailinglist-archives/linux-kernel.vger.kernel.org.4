Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5166162B9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 13:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbiKBMa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 08:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiKBMaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 08:30:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14CD23170
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 05:30:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A7F06191D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 12:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC6A0C433D7;
        Wed,  2 Nov 2022 12:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667392220;
        bh=YHdwvSSp31rpaVUu1IPs5fZGMAK4yyiJLufmWI6wSHM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kusuR8MAO7EdIAJQkbteWEDXEZ2UJW9R4EnDf/yLgTTriEytXKtXeeRuxdtHnPfi8
         VJoSy9byZiJ0X5YpF4TR5Mk5vaZCqszK+UR8tFHigPioKMBN4n9Gmdx1e45wPWDgzE
         +pavTpbNU6FtRY3EgzwkoOKhJkPKqKiAu1+a8Td6Zda7l61Y/Bfw4KjH5JJ14ewjzu
         6ALwfMr90mY4IB8GyqnesBOYJpVE2K7t4umYDfz+AJeAPwa3Ab0an5NzUu6kPBW0LR
         gZBVZk11KGtdVFT2vTtN8LFPXWIzgprCnC/c6bhlV+8brwhK6y0qJaQxYQlvOp4bBi
         DV32ZNHZ1Pj7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CCC4DE270D5;
        Wed,  2 Nov 2022 12:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/5] platform/chrome: cros_ec_lpc: Move mec_init to device
 probe
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <166739221982.25408.16940321573128545413.git-patchwork-notify@kernel.org>
Date:   Wed, 02 Nov 2022 12:30:19 +0000
References: <20221101152132.v2.1.I0728421299079b104710c202d5d7095b2674fd8c@changeid>
In-Reply-To: <20221101152132.v2.1.I0728421299079b104710c202d5d7095b2674fd8c@changeid>
To:     Brian Norris <briannorris@chromium.org>
Cc:     bleung@chromium.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to chrome-platform/linux.git (for-next)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Tue,  1 Nov 2022 15:22:06 -0700 you wrote:
> Disregarding the weird global state hiding in this cros_ec_lpc_mec_*()
> stuff, it belongs in device probe. We shouldn't assume we can access
> hardware resources when the device isn't attached to the driver.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> 
> [...]

Here is the summary with links:
  - [v2,1/5] platform/chrome: cros_ec_lpc: Move mec_init to device probe
    https://git.kernel.org/chrome-platform/c/fdf84f9ae30b
  - [v2,2/5] platform/chrome: cros_ec_lpc: Mark PROBE_PREFER_ASYNCHRONOUS
    https://git.kernel.org/chrome-platform/c/bd88b965ae8c
  - [v2,3/5] platform/chrome: cros_ec_debugfs: Set PROBE_PREFER_ASYNCHRONOUS
    https://git.kernel.org/chrome-platform/c/692a68ad7f3c
  - [v2,4/5] platform/chrome: cros_ec_lightbar: Set PROBE_PREFER_ASYNCHRONOUS
    https://git.kernel.org/chrome-platform/c/873ab3e886b5
  - [v2,5/5] platform/chrome: cros_ec_spi: Set PROBE_PREFER_ASYNCHRONOUS
    https://git.kernel.org/chrome-platform/c/015e4b05c377

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


