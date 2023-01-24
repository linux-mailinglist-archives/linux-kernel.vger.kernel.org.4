Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E2267A269
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 20:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbjAXTKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 14:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbjAXTKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:10:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BBA30FD
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 11:10:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7BEDB816AC
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 19:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 664C1C433D2;
        Tue, 24 Jan 2023 19:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674587417;
        bh=z8WUK+HPL2awbGmddUVcrNGnZmbDk79rNx9Mp87xnUA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=asnJDSWFMSHKyR2NeqMm59iju/xUwGZvnBWdMpOPjvD/qT01PTFoyC8aBsLVLl14i
         7EyqBz0Vt75r5AjSsQ9e18ebQkqM4YolawDqQHhkgOum20bvnf0ezTEbkKIAErmfpM
         j3Saw2iqXAVOtT8M6X3Osg9WZBvbRDgqzJsMpPlx2ZNj551nTC7/ZNcf1i2SJ1oknN
         KJ/qWycGdzAX4YB2WNKdLstZ6XXTskXxWSMIwuitrPvmygoW7lctg8F7TFrW1KBhLQ
         xcT+syxI6VsY+FCj79rukUqTSBAc7zOIU709gP8hrJWgKo29hR9+UUKdbDEwicsTwz
         8Nk7eNo4bct2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 449F4E5250F;
        Tue, 24 Jan 2023 19:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] platform/chrome: cros_ec_typec: allow deferred probe of
 switch handles
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <167458741726.8497.18044467079478030041.git-patchwork-notify@kernel.org>
Date:   Tue, 24 Jan 2023 19:10:17 +0000
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

This patch was applied to chrome-platform/linux.git (for-kernelci)
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


