Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CD3731AA5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344809AbjFON6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344227AbjFON6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:58:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A691BDB;
        Thu, 15 Jun 2023 06:58:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F126A63194;
        Thu, 15 Jun 2023 13:58:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C54C433C8;
        Thu, 15 Jun 2023 13:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686837514;
        bh=e3VpKCzPbeixM3x4B0QVKu3+2GIDQ2j5ljGAZGiHfbk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BVPxbAVxrZptCpmaDFfQqJWSOS4K9YsBmnXB5FJCY/QuHm6yYMLSxeloirAIvT5tE
         LgJTW5I+jVz7JishsNAnVudHcKpVwd1mrmyNtiRdd5bufP/y0p5UYEz43qYulEKvWR
         CwVC7eCkQQLkpavOfMxJgBDrWLGdOwgPKGNVMhwO3sE/sxStwhbpfRQJ/QU0Tgw8eY
         gN4XYivS0ZUcXb4CY3dv0aQleoluY0CtfEaHnxBM6kSya77Stu1wNOPzD06ltdxRAf
         /+M09WcccRkonSLutPnEkLIUsbGDoIGthxr1O9n2KnAdGB6EesHMjH417GZBBfL8Zx
         AzDw1Dnr1nHlg==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, rf@opensource.cirrus.com,
        shumingf@realtek.com, povik+lin@cutebit.org,
        herve.codina@bootlin.com, ryans.lee@analog.com,
        wangweidong.a@awinic.com, ckeepax@opensource.cirrus.com,
        ajye_huang@compal.corp-partner.google.com,
        sebastian.reichel@collabora.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?=E2=80=9CRyan?= <ryan.lee.analog@gmail.com>
Cc:     venkataprasad.potturu@amd.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230613060945.183128-1-ryan.lee.analog@gmail.com>
References: <20230613060945.183128-1-ryan.lee.analog@gmail.com>
Subject: Re: [PATCH V3 1/2] ASoC: dt-bindings: max98388: add amplifier
 driver
Message-Id: <168683750761.557448.3503529701068446770.b4-ty@kernel.org>
Date:   Thu, 15 Jun 2023 14:58:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2023 23:09:44 -0700, “Ryan wrote:
> Add dt-bindings information for Analog Devices MAX98388 I2S Amplifier
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: max98388: add amplifier driver
      commit: 4cab2d5faf7eff9896a15be3b301150b6fbfcaba
[2/2] ASoC: max98388: add amplifier driver
      commit: 6a8e1d46f0621c15d2993c5e847f4f264102f93d

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

