Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836EB612F72
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 05:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiJaEKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 00:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJaEKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 00:10:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F077672;
        Sun, 30 Oct 2022 21:10:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 291EA60F99;
        Mon, 31 Oct 2022 04:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80B05C433D6;
        Mon, 31 Oct 2022 04:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667189415;
        bh=mWUC04VwzWceu16syPxNcDe+4fCXuAcJ/FBDTTxD9b4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=V34jTBkSWJ6ZAto9O4Pg1UXYxwmqWku7+qIC+sEnHOICyeEGCjSctjsiRFic+d5yd
         MsIE1eht5pXh8CzxPbSpsLx7T3ZiJkRxa4dgAih3oKaWLcfweCDBzzUfVS98aWRkcU
         +xExDowfldWAHaWZYwiBQhoKzzhLlb66z2hjgTKLjrklWHB/0+loDKYwXdWO55t/iq
         SDzqI71jS+gztqWYkR3Pkmtkq7hssKQS8XUVtinYkEEMp3a+HGVuh/K3CUloNUmI1S
         ARnizyXZ6oq4dwFD42D+eMrj+Fl8AydBFvIh/vS5ArkNkabfXj7EzdesPObfVDbgv+
         o2MmKJ4m0scRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 624C5E4D03A;
        Mon, 31 Oct 2022 04:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 0/2] dt-bindings: cros-ec: Update for fingerprint devices
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <166718941539.790.4332712127794687523.git-patchwork-notify@kernel.org>
Date:   Mon, 31 Oct 2022 04:10:15 +0000
References: <20221026003641.2688765-1-swboyd@chromium.org>
In-Reply-To: <20221026003641.2688765-1-swboyd@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
        groeck@chromium.org, dianders@chromium.org, hesling@chromium.org,
        tomhughes@chromium.org, amstan@chromium.org, tzungbi@kernel.org,
        mka@chromium.org, bleung@chromium.org, lee.jones@linaro.org
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to chrome-platform/linux.git (for-kernelci)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Tue, 25 Oct 2022 17:36:39 -0700 you wrote:
> This patch series introduces a DT binding for chromeos fingerprint
> devices. The first patch tightens up the existing cros-ec binding and
> the second patch introduces the fingerprint binding. As there aren't any
> driver patches this can go directly through the chrome platform
> tree or the dt-binding tree or the mfd tree. I sent it to the binding
> maintainers in hopes it can go there directly but it doesn't really
> matter.
> 
> [...]

Here is the summary with links:
  - [v7,1/2] dt-bindings: cros-ec: Reorganize and enforce property availability
    https://git.kernel.org/chrome-platform/c/7a2f36828c7b
  - [v7,2/2] dt-bindings: cros-ec: Add ChromeOS fingerprint binding
    https://git.kernel.org/chrome-platform/c/e068bc0b01cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


