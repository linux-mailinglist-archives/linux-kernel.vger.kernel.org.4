Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6E0735FD8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 00:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjFSW3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 18:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjFSW3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 18:29:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B93E4A;
        Mon, 19 Jun 2023 15:29:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BB5D60F28;
        Mon, 19 Jun 2023 22:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32074C433CA;
        Mon, 19 Jun 2023 22:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687213757;
        bh=1Fai1c9PqtR1nbAseq/sPKVMxOFXSch7MmBt+o0w9SE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=W7bI+Z4RXdoKnSAQfVmWdPXZIz6ju2OLKJyLf75gQ3sLjh1VUnG4zk+WskfVUk4j7
         vowDxMBzOLKs5fPcVMXgXrdyacOdwhtb9q3OCK2rYE3BuAP1iD3OSrTpqHu4t7M07k
         bOsbtyvti6RUptBz1ITex243pDdP0LED/em/IHfz1WIgs45P3e2Q8lraGG/pXNoKxW
         fKeGSkC8YtsX+7THc2ljZeTLsxCzJuAaDjcqs2tfyTZ4VJ7qBhUGh9dCGpQyFffuJH
         bN8VzmlNpCYqwYR4gG9UY8CYe/mpo/4fxtqh1ZnYcCRDqOafZJRTTJfLnwsubokOKh
         XmjGSeEKybNyA==
From:   Mark Brown <broonie@kernel.org>
To:     devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com,
        Shenghao Ding <13916275206@139.com>
Cc:     kevin-lu@ti.com, shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, x1077012@ti.com, peeyush@ti.com,
        navada@ti.com, gentuser@gmail.com, Ryan_Chu@wistron.com,
        Sam_Wu@wistron.com, tiwai@suse.de
In-Reply-To: <20230618122819.23143-1-13916275206@139.com>
References: <20230618122819.23143-1-13916275206@139.com>
Subject: Re: [PATCH v6 1/4] ASoC: tas2781: Add Header file for tas2781
 driver
Message-Id: <168721375392.200161.3235917580792681848.b4-ty@kernel.org>
Date:   Mon, 19 Jun 2023 23:29:13 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

On Sun, 18 Jun 2023 20:28:16 +0800, Shenghao Ding wrote:
> Create Header file for  tas2781 driver.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: tas2781: Add Header file for tas2781 driver
      commit: 678f38eba1f2fe33ff700e85390ac98393e609ef
[2/4] ASoC: tas2781: firmware lib
      commit: 915f5eadebd29ba185ac506766a90120153b7e14
[3/4] ASoC: tas2781: Add tas2781 driver
      commit: ef3bcde75d06d65f78ba38a30d5a87fb83a5cdae
[4/4] ASoC: dt-bindings: Add tas2781 amplifier
      commit: 3e4ecd6c4e14e1eff8f52bd89240399e7dac881c

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

