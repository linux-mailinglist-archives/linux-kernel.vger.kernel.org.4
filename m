Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5199D62D9C5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234533AbiKQLsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239305AbiKQLsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:48:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE2110DF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:48:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6809CB81FF8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 11:48:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784B4C433D6;
        Thu, 17 Nov 2022 11:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668685705;
        bh=8hqDUOlFccqGwQGl9Wukt97CQepf0GZhn00KESa5/WY=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=iCIiLI9FN2S8qq2r1+isOvr8QXea1XCuGP0VvNuPT+sFemUvWyXlT2XJ7mb67QjxU
         8gSh2epstObXVC1HTx/seJkdvTpIMSiD6ZLHzInd8AInAvhmx6CJsnguMT12tvSun/
         VHyyoXCJK+HTitXbArprmInoyeRCos8QsV38BJRf5AonHky87FpxCahp8CrPanfNdh
         Z8ZVF0QUDOZ2axzgc0cjxZVLOdwb2x2fP0g2nmYtIb7PpYh1ucWUMWzu+Jkad9JINW
         KryAaTavrgck0iBJxCHdm9rtXLctJWgJAwHpoeyw/m1sFQ2skdRiB0VHZKF+Bg8+2T
         N2nwH51U/zeKQ==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        alsa-devel@alsa-project.org,
        Banajit Goswami <bgoswami@quicinc.com>,
        Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20221109163759.1158837-1-krzysztof.kozlowski@linaro.org>
References: <20221109163759.1158837-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] ASoC: codecs: wsa883x: Shutdown on error path
Message-Id: <166868570315.693995.134292755299481172.b4-ty@kernel.org>
Date:   Thu, 17 Nov 2022 11:48:23 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-8af31
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Nov 2022 17:37:58 +0100, Krzysztof Kozlowski wrote:
> If probe fails, toggle shutdown via GPIO to save power and reverse
> probe actions.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/2] ASoC: codecs: wsa883x: Shutdown on error path
      commit: 8e022387444bc5039a271fbf5a778551c4a1926b
[2/2] ASoC: codecs: wsa883x: Simplify with dev_err_probe
      commit: 6b6ab406cedaf70f58961d4ea82e88e65e721d06

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
