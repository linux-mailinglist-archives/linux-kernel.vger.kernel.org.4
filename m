Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DD263D5ED
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 13:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbiK3Mry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 07:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234468AbiK3Mrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 07:47:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E482529D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 04:47:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EB7C61B8A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 12:47:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBDFDC433C1;
        Wed, 30 Nov 2022 12:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669812470;
        bh=Ayte6uLLIrPFdwUeST0p7W4NcAcyN4PTRnbwPLLszyk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rKPBhpNmJFVwU6Q/QOYtguDZuwRJfnPJxGuEMuF+J+xEO/Po4HA1Vqh50YYr2Egal
         ekIv6SSF+kw6TIdhwHwxQ1i0S1jA5wqLrZ7rQuQcjzWNtz/ipjMRCDI/wiBJAOAm+Q
         3FCu5H4cpe3GMKtg2bKh9aXFXcL14yhCEJFD0cil+YXo34OE6P5BhVGW8KEZujganO
         r9lQBnZSzxGeNUXpPpKMGufZxUjgmafP3phq4mgDYGEtaL94n+a6Ratv16YF3ccp82
         6Evtk/1f4LTR7GE+7zgkMFKF8CC+gDv+keIaapWgkeNE4anTMjPsBjmM50JL8wiZGf
         90rGj8H/QsD0w==
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        sound-open-firmware@alsa-project.org,
        linux-mediatek@lists.infradead.org
In-Reply-To: <20221127-mtk-snd-v1-0-b7886faa612b@chromium.org>
References: <20221127-mtk-snd-v1-0-b7886faa612b@chromium.org>
Subject: Re: [PATCH] ASoC: SOF: mediatek: add shutdown callback
Message-Id: <166981246666.67172.3822012000949184770.b4-ty@kernel.org>
Date:   Wed, 30 Nov 2022 12:47:46 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Nov 2022 21:04:15 +0100, Ricardo Ribalda wrote:
> If we do not shutdown the peripheral properly at shutdown, the whole system
> crashes after kexec() on the first io access.
> 
> Let's implement the appropriate callback.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: mediatek: add shutdown callback
      commit: e063330a77edbdc57a142a27a82e51dc1361ab9d

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
