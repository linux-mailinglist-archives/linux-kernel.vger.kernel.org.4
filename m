Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C82468392A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 23:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjAaWSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 17:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbjAaWS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 17:18:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F701554C
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:18:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4ACA661739
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 22:18:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559E3C433D2;
        Tue, 31 Jan 2023 22:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675203482;
        bh=MtFD+PrSGQQTZf0muhOsgnT1M3DdQLeMFUjeYHoxcn8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=NohmyKMKR74nu7omUd74/5OXMdO/iDcx5OyES7wLnc6npVRn99jb3VqcFuHV/CZr9
         oBIFf8qbYeNNvLRX1l5HUgUS832wKSf9NWCN9wXBIcn7nZEzMaQ+tGGIqVlgc4lkmh
         e8jCUZPmTnb3y1p2ci/BMZ5YCDd+ultwZim76BLAMEaZKeJOtu6gNHl6fnKW61u3s5
         jZT+uKISFQBpZJGTITcPWE76+FpibTV6K92uNr+kiHRlZuTMg3ImuPVGOpjgUa3Ezj
         orTlbzqWFGm2MkLYDkrlWrkm2t3ghYOlRXwAa+ILlAq1lutPIQWqsRRJXwH+VrcQP9
         tfALo9ET8YRcA==
From:   Mark Brown <broonie@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
In-Reply-To: <20230127165111.3010960-1-sbinding@opensource.cirrus.com>
References: <20230127165111.3010960-1-sbinding@opensource.cirrus.com>
Subject: Re: [PATCH v3 0/8] ASoC: cs42l42: Add SoundWire support
Message-Id: <167520348107.1362284.300886543996513009.b4-ty@kernel.org>
Date:   Tue, 31 Jan 2023 22:18:01 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2023 16:51:03 +0000, Stefan Binding wrote:
> The CS42L42 has a SoundWire interface for control and audio. This
> chain of patches adds support for this.
> 
> Patches #1 .. #5 split out various changes to the existing code that
> are needed for adding Soundwire. These are mostly around clocking and
> supporting the separate probe and enumeration stages in SoundWire.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/8] soundwire: stream: Add specific prep/deprep commands to port_prep callback
      commit: 43f1a7f905fcc796620c6488a7098068a05484ca
[2/8] ASoC: cs42l42: Add SOFT_RESET_REBOOT register
      commit: b558c6fd08f59b78166828c342beb2a36258e9fe
[3/8] ASoC: cs42l42: Ensure MCLKint is a multiple of the sample rate
      commit: 17cb563baef9c4f2d244035a95e361dd673941fa
[4/8] ASoC: cs42l42: Separate ASP config from PLL config
      commit: 7209d5ebb34aff3fbdd504c7deeb9b74df632086
[5/8] ASoC: cs42l42: Export some functions for SoundWire
      commit: 0998816ab2d85d67ebace9993b5a97e79a24d816
[6/8] ASoC: cs42l42: Add SoundWire support
      commit: 98fda42a85b4324b6c404ec163940371c63625df
[7/8] ASoC: cs42l42: Don't set idle_bias_on
      commit: e0bd53a4d1d5afa7d3a3bf46e2f0ec7940f94710
[8/8] ASoC: cs42l42: Wait for debounce interval after resume
      commit: 16838bfbf6e70b7a3381ab302248bd18c085aba5

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

