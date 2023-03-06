Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668D86AC11D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbjCFNcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjCFNcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:32:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275E42F7A9;
        Mon,  6 Mar 2023 05:32:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C64A60EB8;
        Mon,  6 Mar 2023 13:32:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDACFC433A1;
        Mon,  6 Mar 2023 13:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678109523;
        bh=BXZROgul7p0wR6XPSJeK7cD2IBPYqzyTYqEG61d9fQA=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=Xkcd6yRNgOGHBjHNbbLGAOG7yAFGErGuCY7rckfNPUe+AJSuG9vvdGjuHw2QSaB1c
         /rinzeDi+OMSawmiZcK1sMeyrrsTGKZVyIYKJBhGXkJUiANE2vnZjnjF/jpO9nYNOB
         xsP9/ZBNIgBfdBg1U6gEdeA763/A1GKu/uG7JEv0cSp1NmPNIHvYXJbyB/sPs0DcBO
         nHF+4DYdts0eWeXHSltVcGw3Enoqy8CffF3ngS+aj0KuMLIq7IRBt6+nve3lq/bLPp
         Gc4yKJ5uy8UdnmTHAvmMYvrSrv/Eq3V/TRWZX9k7mQ9IoGx6a4tw5ahaSEk0ZAK81g
         GvgkMpGYD8ceg==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Chancel Liu <chancel.liu@nxp.com>
In-Reply-To: <20230227091938.1671416-1-chancel.liu@nxp.com>
References: <20230227091938.1671416-1-chancel.liu@nxp.com>
Subject: Re: (subset) [PATCH v2 1/2] ASoC: dt-bindings: wlf,wm8524: Convert
 to json-schema
Message-Id: <167810952063.75807.2679139979822517456.b4-ty@kernel.org>
Date:   Mon, 06 Mar 2023 13:32:00 +0000
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

On Mon, 27 Feb 2023 17:19:37 +0800, Chancel Liu wrote:
> Convert the Wolfson WM8524 24-bit 192KHz Stereo DAC device tree
> binding documentation to json-schema.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: wlf,wm8524: Convert to json-schema
      commit: 5ddcf9768f7a15da997259038c16a9e00c06aa87

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

