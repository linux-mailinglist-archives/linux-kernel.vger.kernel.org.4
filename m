Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB50B6AC11F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjCFNcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjCFNcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:32:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1032D2FCED
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 05:32:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D250B80E01
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 13:32:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8257CC433B4;
        Mon,  6 Mar 2023 13:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678109525;
        bh=O0NjiuKo1KTeYcFKpvLnjP0XZq5Y7WBdJ9fIWIS1EPA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=iUDwurd25ro1kA7RbCRBOaBAjZt56mRalMR2nh++cE7GCuh9CZgefYkN9+LDiA6mm
         eqw4ycytfNZsIHOdOcCIwU2xX6hAdmoWhRkZwlQ6YoHd8TIPoSaXLpkT6yKrwaV/CO
         Bo4kp0jPFxPk/CbLhmuHaLj24Ls0BQ+quPFYoPzqNX/7z6aHeJ8rkutbAoEzlDJCZ6
         oIBnPm2nH0b7uNmBlf804wiaBSfxglSyOIP51UBS8EuF0gUPF2OJrd8eULJCTLPOGj
         CF937OB/4hyr7SVq+PMo8hUoGa0ErgCyeFJ+G7gOyMKEeppWy91a159fthgZkzS02A
         94zluJx4A3hYw==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        steev@kali.org, johan+linaro@kernel.org, quic_bjorande@quicinc.com
In-Reply-To: <20230302104616.26318-1-srinivas.kandagatla@linaro.org>
References: <20230302104616.26318-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: qcom: common: add kcontrol to jack pins
Message-Id: <167810952324.75807.15238785046098203120.b4-ty@kernel.org>
Date:   Mon, 06 Mar 2023 13:32:03 +0000
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

On Thu, 02 Mar 2023 10:46:16 +0000, Srinivas Kandagatla wrote:
> Add Kcontrol to jack pins so that device switch in ucm can be done correctly.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: common: add kcontrol to jack pins
      commit: 4c2c935a278e53bf9a1713bb0a01ce299a994e9b

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

