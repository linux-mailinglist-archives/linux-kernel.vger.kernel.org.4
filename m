Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8556C3764
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 17:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjCUQvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 12:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjCUQvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:51:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C9A2A98D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 09:51:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A497BB818E3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 16:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2C5C433EF;
        Tue, 21 Mar 2023 16:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679417463;
        bh=AbKt52iNEb6SnYQa9HSck3GX1mTBCsjvzSB4fCNRt1Y=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=k0mQmIrmb6hJNlW1BXbDJDN7Ph0HeBy0tiqlqX6qDCCQtH6KVk6J6IKqtDHGSQilg
         QBLViDfFi/eUhPcXADNnChTBSXvK53oWdCD3qlYEFUgbNEh08EJ10bCdkxmHp6M2zL
         szBpfxVMIdELmIQCZqk9Tqd/af+RKWOWevsLbqk+Gab/azeXqchV/lswthRpodkFZg
         7vU2DY1uj1LNUdFYlZF1NSVMbojBPbntC8ADPKTsX7xSF75smXJOnoCv4bOWK7TQrC
         i9atCvW/z1Q0MRAPi7MVNw7FOL5weyf2U9qkGye8IVJkukCXKnBgUIcnJ60GLA1kPk
         /Iz8HXSMXUqsg==
From:   Mark Brown <broonie@kernel.org>
To:     pierre-louis.bossart@linux.intel.com,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
In-Reply-To: <20230320112245.115720-1-rf@opensource.cirrus.com>
References: <20230320112245.115720-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH v3 0/8] ASoC: Initial support for Cirrus Logic CS35L56
Message-Id: <167941746163.67241.16095967873543822189.b4-ty@kernel.org>
Date:   Tue, 21 Mar 2023 16:51:01 +0000
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

On Mon, 20 Mar 2023 11:22:37 +0000, Richard Fitzgerald wrote:
> The CS35L56 is a high-performance boosted mono audio amplifier.
> Supported control interfaces are I2C, SPI or SoundWire.
> Supported audio interfaces are I2S/TDM or SoundWire.
> 
> The CS35L56 has a self-booting firmware in ROM, with the ability
> to patch the firmware and/or apply tunings.
> Patches #1 to #7 add support to cs_dsp and wm_adsp for self-booting
> firmware and the ability to apply a .bin file without having to
> apply a .wmfw.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/8] firmware: cs_dsp: Introduce no_core_startstop for self-booting DSPs
      commit: 7062e1c727ec99a9c5b40586964304d60a43f240
[2/8] ASoC: wm_adsp: Use no_core_startstop to prevent creating preload control
      commit: 0cd1fd571719e19bd6824a98855382a70e47d932
[3/8] firmware: cs_dsp: Support DSPs that don't require firmware download
      commit: 107c167419e75213e078e4f2468c0f2f55fdd11a
[4/8] ASoC: wm_adsp: Support DSPs that don't require firmware download
      commit: 65a314b7ddc09f6b1bad8decc6670e68d45ef07d
[5/8] ASoC: wm_adsp: Expose the DSP boot work actions as wm_adsp_power_up()
      commit: 11520b87e2232c6e3defed69ec94f0e28fb80f84
[6/8] ASoC: wm_adsp: Add support for loading bin files without wmfw
      commit: 0e7d82cbea8bc0db8ced613aea04da17ac0f0249
[7/8] ASoC: wm_adsp: Simplify the logging of requested firmware files
      commit: 991b1de830f61076b7dc29bec081a4d2e50724cf
[8/8] ASoC: cs35l56: Add driver for Cirrus Logic CS35L56
      commit: e496112529006ce0c2cfe67d1136186e2786d2e8

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

