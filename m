Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCCC5F0B29
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiI3L47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiI3L4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:56:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A0F1490BC
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 04:56:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C8B2622E3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 11:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9466FC433C1;
        Fri, 30 Sep 2022 11:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664538985;
        bh=3zIKxbAiLcToLZncGPUrO0dreSdU2PDyLp+eRwEjvcA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=IzCe/3daJ4C60NF5EAhgksN1oPs8ws7ZV4hhtGN0CUbWBnbFmOI6kPRJdt55I/yEc
         vLFnYojGDEn0deAyZQmEYRNLQj4DGcACC32DL/4+73Bz4puMXJV5erSxRiZISyLHqj
         Op3Me8IzQMh2RC1x3c7Gp7p7WeJ7pGUw8YSrhPeMPOQ/IQZMfccH+uDFUMEUAVcSyP
         aqcE95mQKUVCY9jnc0zuW0NNkE/RKjewIML7TgzDD6eH2RpfvnNg7u4qilydNzFNqI
         zKZf0Gwfe2bqYJRogMHs3eNRe/ga4iPogHCZLBAWTcMPazQcpVMtHMm2H/WhDKbDJo
         DwJJPxJwAaMKw==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        alsa-devel@alsa-project.org
In-Reply-To: <20220930105347.41127-1-srinivas.kandagatla@linaro.org>
References: <20220930105347.41127-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: qcom: fix unmet direct dependencies for SND_SOC_QDSP6
Message-Id: <166453898431.127290.17469866447860994691.b4-ty@kernel.org>
Date:   Fri, 30 Sep 2022 12:56:24 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2022 11:53:47 +0100, Srinivas Kandagatla wrote:
> SND_SOC_QDSP6 already has COMPILE_TEST so remove that from
> SND_SOC_SC8280XP and also add QCOM_APR dependencies to
> SND_SOC_SC8280XP like other Qualcomm machine drivers.
> 
> This should also fix below warning:
> on x86_64, when QCOM_APR is not set and COMPILE_TEST=y:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: fix unmet direct dependencies for SND_SOC_QDSP6
      commit: 7bc08355a4917f2bbd38e7af5207f339f47e5d36

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
