Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A1A6162BA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 13:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiKBMa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 08:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiKBMaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 08:30:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14CE23170
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 05:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55FB2B82236
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 12:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F239DC4347C;
        Wed,  2 Nov 2022 12:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667392220;
        bh=tJRbm7zsQBu7ns6y4PDKDFo9e65Q/MoyvUbkyu+uD8E=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bku4bzS/B5Hn0OD+nXht6T7u9j/9ha3Gg1COT/OCWeklnqREeC7TpBl3gtROAHqqV
         1H+9iBMfnz/mJ5qgHmPFVHuuRop6OP5oyClDfrrnqX4guOWFJFByanBIXzMfItr4aQ
         GgFqGF7JVofIo0FqJsqg43gJP2LUzVWmSZzR8iNmCIMZUXUDQ8oNw5U90secVsqQbh
         PaXC+4citC0ILeCq1elCu5WRn3GtnmxgYCKGxplBzW/r9Qwyyy3PW3dZ7JscSiGZMt
         839ACcjeKao3B8AnDi6466zsfe5M3mS5H8mobCa45mKQE5JtpNhPSZXdj7sBHHRPm4
         NQJ/thHXxYbkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8EF0C395FF;
        Wed,  2 Nov 2022 12:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/5] platform/chrome: cros_ec_lpc: Move mec_init/destroy to
 device probe/remove
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <166739221988.25408.11930632346687523785.git-patchwork-notify@kernel.org>
Date:   Wed, 02 Nov 2022 12:30:19 +0000
References: <20221028141411.1.I0728421299079b104710c202d5d7095b2674fd8c@changeid>
In-Reply-To: <20221028141411.1.I0728421299079b104710c202d5d7095b2674fd8c@changeid>
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

On Fri, 28 Oct 2022 14:14:45 -0700 you wrote:
> Disregarding the weird global state hiding in this cros_ec_lpc_mec_*()
> stuff, it belongs in device probe/remove. We shouldn't assume we can
> access hardware resources when the device isn't attached to the driver.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> 
> [...]

Here is the summary with links:
  - [1/5] platform/chrome: cros_ec_lpc: Move mec_init/destroy to device probe/remove
    (no matching commit)
  - [2/5] platform/chrome: cros_ec_lpc: Mark PROBE_PREFER_ASYNCHRONOUS
    https://git.kernel.org/chrome-platform/c/bd88b965ae8c
  - [3/5] platform/chrome: cros_ec_debugfs: Set PROBE_PREFER_ASYNCHRONOUS
    https://git.kernel.org/chrome-platform/c/692a68ad7f3c
  - [4/5] platform/chrome: cros_ec_lightbar: Set PROBE_PREFER_ASYNCHRONOUS
    https://git.kernel.org/chrome-platform/c/873ab3e886b5
  - [5/5] platform/chrome: cros_ec_spi: Set PROBE_PREFER_ASYNCHRONOUS
    https://git.kernel.org/chrome-platform/c/015e4b05c377

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


