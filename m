Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5A96D7CEF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 14:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238061AbjDEMsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 08:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237870AbjDEMsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 08:48:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F4B55B4;
        Wed,  5 Apr 2023 05:48:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3019604EF;
        Wed,  5 Apr 2023 12:48:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23EA6C433D2;
        Wed,  5 Apr 2023 12:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680698883;
        bh=y8D4JsSVPlGId9eNBSR3wx7RWUtrjJxcw38jfOGksRI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QR1rOQlbWS2YXFXg8W7CviYUw2rM73reuzZSdVNEFRJ1FFRKSCnWA/Kt5buVjPUtX
         gUxn+fFlbbgSnHXdRbgFs96ZQy9mgYg5ncBESfPNlxMTKk6UYH/uww1bLvtR+9Y0N4
         Ph35dF5yEKvjYjfD/Yb1OexqIhR09USJFc6pDxVgm7lAn2BN35VZ3yRLEEGcGGoEHw
         wKeq1ZTL4f3UFF9jaHmby7vWrxx5/FScCvsHy7XqmnSEzufrgQdFTUi2l482xveQe2
         suGVxB5B2wvuEXW/jyJalotxfPBELkbK4Iez9kXWZzax1ggRbWvyi8tn8ePyrnof0R
         v37uBR5Usmjvw==
From:   Mark Brown <broonie@kernel.org>
To:     krzysztof.kozlowski@linaro.org, daniel.baluta@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        shengjiu.wang@nxp.com, Saalim Quadri <danascape@gmail.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230328091831.55690-1-danascape@gmail.com>
References: <20230328091831.55690-1-danascape@gmail.com>
Subject: Re: [PATCH v5] ASoC: dt-bindings: ak4458: Convert to dtschema
Message-Id: <168069888086.54726.4811007524578047000.b4-ty@kernel.org>
Date:   Wed, 05 Apr 2023 13:48:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2023 14:48:31 +0530, Saalim Quadri wrote:
> Convert the AK4458 audio DAC bindings to DT schema.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: ak4458: Convert to dtschema
      commit: 009e83b591ddcd945f0d48209debfb8dca967166

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

