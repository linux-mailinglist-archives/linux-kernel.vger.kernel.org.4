Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECB26C3766
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 17:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjCUQvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 12:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjCUQvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:51:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF6D279AE;
        Tue, 21 Mar 2023 09:51:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DAB6FB818E7;
        Tue, 21 Mar 2023 16:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D963DC4339B;
        Tue, 21 Mar 2023 16:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679417466;
        bh=JtUlGAZMXgUNcqufA6J7cwV2ToEYYL5jW3Tbh1xClAc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=tOzkW1uNUz1v7Go4gsYwSzpYycomUajHGJIl3lGZelBbAe8TZo6TQTxapIiWJfLO8
         SutzO7dH/M/pPQhsQovO4TeBJSUSqZj5m53q2/INCFKcOAPUtIkTyU9SLDd+stfnti
         TSYiK/Ql8hrWS8LrE4Hq+HQNy8OFA0Vuiv+3ShLxVW6qHrqNv9puJxc4Sz7db9jyLM
         pAQHFjhA+xHJgKAUF/Tuudq+cjPnCQERU1AKRVlB5EJWbIv4LVODb6NdH0lPZie8cD
         h6OV6+nSDFsRX6sCl47QgBzCpFiEreaqQ4bg/H+qSIgz3M6wgHGggcLLOVPzibwK8U
         FhinZRHsORQGQ==
From:   Mark Brown <broonie@kernel.org>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vlad Karpovich <vkarpovi@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20230315154722.3911463-1-vkarpovi@opensource.cirrus.com>
References: <20230315154722.3911463-1-vkarpovi@opensource.cirrus.com>
Subject: Re: [PATCH v3 1/5] ASoC: cs35l45: Support for GPIO pins
 configuration.
Message-Id: <167941746356.67241.8098477595420536001.b4-ty@kernel.org>
Date:   Tue, 21 Mar 2023 16:51:03 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2023 10:47:18 -0500, Vlad Karpovich wrote:
> Adds device tree configuration for cs35l45 GPIOs
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: cs35l45: Support for GPIO pins configuration.
      commit: fa8c052b4c614aa1d2d60e5c9f40e9d885bf9511
[2/5] ASoC: dt-bindings: cs35l45: GPIOs configuration
      commit: c6cec088ab037b57e08e0694e2b150b1b034826c
[3/5] ASoC: cs35l45: IRQ support
      commit: 6085f9e6dc1973cf98ee7f5dcf629939e50f1b84
[4/5] ASoC: cs35l45: DSP Support
      commit: 74b14e2850a34740c121cf2758d4181063d4c77c
[5/5] ASoC: cs35l45: Hibernation support
      commit: 6c07be8fe92c6b0c24ee1c599601dce3506b83c7

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

