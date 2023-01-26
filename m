Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD1067D5AA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjAZTuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjAZTuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:50:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973AB12060
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:50:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A9F8B81EDE
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 19:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE4A0C4339B;
        Thu, 26 Jan 2023 19:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674762616;
        bh=kUJy/y9iRFtiWWJgoHU6wDqG16Th7B9H6olXKbHU+WY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Q+TcdLtKqN/biuJhdT0A5b8eK6klucuG4EXXBr/6GUdwugS4tynBJOgThchR6sr6v
         5ZWg6qD1PgR94l95NurG7uIzkObXvIXEYyNSjvkRtGKBlykVm+Zf3bpuw6CwkOPu48
         +5dJ57uCeXF2pINsn27/G16DnTJfG1046gEmWiuWsTce8GgAFP6sBvtpAVOZYJCYlw
         lZyODo33P5cKuCrfjjT5rKaXfXFhlUtxc8GZKYsV6xftHXiVVhHdxooGsLnbl0jnsE
         yv0pU32by17MRR4mTAy3I89hnq4XsRpbMrzdDd4Il+ScvB6QwpsN0Z1c6S/7a9Wqbf
         UBgjESuuIb7gg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C4EC0E54D2D;
        Thu, 26 Jan 2023 19:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] platform/chrome: cros_ec_typec: allow deferred probe of
 switch handles
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <167476261680.7258.4736559242747511129.git-patchwork-notify@kernel.org>
Date:   Thu, 26 Jan 2023 19:50:16 +0000
References: <20230124075555.v3.1.I6c0a089123fdf143f94ef4cca8677639031856cf@changeid>
In-Reply-To: <20230124075555.v3.1.I6c0a089123fdf143f94ef4cca8677639031856cf@changeid>
To:     Victor Ding <victording@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        heikki.krogerus@linux.intel.com, lee.jones@linaro.org,
        groeck@chromium.org, enric.balletbo@collabora.com,
        tzungbi@kernel.org, sebastian.reichel@collabora.com,
        gregkh@linuxfoundation.org, gustavoars@kernel.org,
        bleung@chromium.org, dustin@howett.net, dnojiri@chromium.org,
        tinghan.shen@mediatek.com, pmalani@chromium.org
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
by Prashant Malani <pmalani@chromium.org>:

On Tue, 24 Jan 2023 07:56:32 +0000 you wrote:
> `fwnode_typec_{retimer,mux,switch}_get()` could return `-EPROBE_DEFER`,
> which is called from `cros_typec_get_switch_handles`. When this happens,
> it does not indicate absence of switches; instead, it only hints that
> probing of switches should occur at a later time.
> 
> Progagate `-EPROBE_DEFER` to upper layer logic so that they can re-try
> probing switches as a better time.
> 
> [...]

Here is the summary with links:
  - [v3] platform/chrome: cros_ec_typec: allow deferred probe of switch handles
    https://git.kernel.org/chrome-platform/c/13aba1e532f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


