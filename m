Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E492E6AC10E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjCFNb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjCFNbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:31:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5102ED6D;
        Mon,  6 Mar 2023 05:31:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65EC3B80E01;
        Mon,  6 Mar 2023 13:31:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB130C4339E;
        Mon,  6 Mar 2023 13:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678109509;
        bh=JHC0hb+WAOY9fqstxdj26yXXntSJNh6emfvVp8hEuGo=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=D4YBAEUOswQGwANMpLl1pETCzSNx7Ao0XyXYhOD8oGJ4poUBPTQNlY9NI+tD8Rfa4
         v2tq1GTztJjUtuMysmF3B3Il4m5jJrMQlRaGF4jAIwl8PRnRc4gI+qlCdLBCJ0ecnf
         YELopH+vQwJpWojdhKHIkVT3hl03AdnipCaHlJK9qcGPcX0MiCrPI2vjNXiLFReAEr
         JxkrbpQ8YJfOxRKxmJAROGa34Pz1nby1g2F2GV2Uu6DnRpW+8Cx3vvk8uw4ao0L4BC
         H8fFgbKjK/y+riJuIzRwl04PmsZxb3+F+nFImjhxlRfdp3OW/eU/yAJ1ixjRe5/q80
         PU20dLstNpHnw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Cernekee <cernekee@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Crt Mori <cmo@melexis.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
In-Reply-To: <20230222083300.218523-1-kamel.bouhara@bootlin.com>
References: <20230222083300.218523-1-kamel.bouhara@bootlin.com>
Subject: Re: [PATCH 0/2] Add support for the TAS5733
Message-Id: <167810950662.75807.17494624901046895740.b4-ty@kernel.org>
Date:   Mon, 06 Mar 2023 13:31:46 +0000
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

On Wed, 22 Feb 2023 09:32:58 +0100, Kamel Bouhara wrote:
> This small series extends the tas571x driver to support the TAS5733
> audio power amplifier.
> 
> Kamel Bouhara (2):
>   ASoC: tas571x: add tas5733 compatible
>   ASoC: tas571x: add support for TAS5733
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: tas571x: add tas5733 compatible
      commit: 95a29d5f626a37dbefd0883f294ec4e22a8a7911
[2/2] ASoC: tas571x: add support for TAS5733
      commit: f5db4d00f73871988beba0277ea29cff73d38445

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

