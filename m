Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4076B6E50E3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 21:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjDQT2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 15:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjDQT2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 15:28:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79AE6EB7;
        Mon, 17 Apr 2023 12:28:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61FC961F9E;
        Mon, 17 Apr 2023 19:28:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09481C433D2;
        Mon, 17 Apr 2023 19:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681759688;
        bh=vUS3zjVd3+6BO4WHfibtTk9oL6xSScrdumIoUioILDA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=THajXB+ML1MMwctxmXts4VxHz2S3pGPkEBy0XyPnOJPJrBmRMoFRyVIcJ0cpnHN++
         MfcUovaySK7ez0esDbSsRS/uI+js/h+r7EuYC4Lw9FBfY1rbXniW6/zC+pHQVPAV1u
         J/5EdENWVCSqWg2Hu2YiT7lj+RYW4T1YEYPXDOhohkwJGj7581dehgHu6Oe3gSrXXi
         oo/listP0wM+6Gfs1xn3QCteWfNijUdyKFytyCvRyxxnusw/DceofFlZQxe0RPeh2p
         Z8L5keaD+Vg0bP6pdaMJTlO2Bbc9cENkbyIKZEA+62LqkdQV9sLR9iZD2avrmBxP99
         dThCqi+6OpT2Q==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        =?utf-8?q?Pawe=C5=82_Anikiel?= <pan@semihalf.com>
Cc:     perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
        lars@metafoo.de, nuno.sa@analog.com, upstream@semihalf.com
In-Reply-To: <20230414140203.707729-1-pan@semihalf.com>
References: <20230414140203.707729-1-pan@semihalf.com>
Subject: Re: (subset) [PATCH 0/9] Add Chameleon v3 ASoC audio
Message-Id: <168175968572.1283403.9162743333691420976.b4-ty@kernel.org>
Date:   Mon, 17 Apr 2023 20:28:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Apr 2023 16:01:54 +0200, Paweł Anikiel wrote:
> The Google Chameleon v3 is a device made for testing audio and video
> paths of other devices. This patchset adds support for ASoC audio on
> this device. It has two audio sources: HDMI audio from the it68051 chip
> (RX only), and analog audio from the ssm2603 chip (RX and TX).
> 
> The patchset adds the ASoC platform and machine drivers, as well as some
> changes to the existing ssm2602 codec driver.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[6/9] ASoC: ssm2602: Add support for CLKDIV2
      commit: 8076c586bbc1c62e075e58f41dafdd8b5022b24d

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

