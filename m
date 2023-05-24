Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D08D70F53C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 13:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjEXL2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 07:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEXL2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 07:28:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6472CB6
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 04:28:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC91363C59
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 11:28:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9104DC433EF;
        Wed, 24 May 2023 11:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684927692;
        bh=lEERwyoUcstq6rJVbG1zvefRvh8OPRxnWhDbydxtCfw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=oVe0N9qwwyfroM4hTkC+7avZPqmgaIn5OU1RVM66CR1GKBIEL30cfPMmC10Ap0Yyk
         XSlrPIONc5x4NH+Xo/VaNXH6vAZrFovMkjoaQVumnZ/Q45h7rFoBcKrugZr9XY+SC8
         SZuZv/qtxdN3cY4pPKovio3BjH9Xmx0MuDesXrM2k4iip69hSZycKfja09dV9Taxxc
         C4oE+vzZ4X86vB6efvGE/TPRlz9zqpQ+B+CGOvtdYg/tnFVi8XMvk+lvVFjRYqxIvQ
         bsyUWFNGASd/Qsro11KYQhG+DKcazZ42tflfm2rXysGna0J1garnZlTfvrVN/chhL3
         M+hgySyKcl5ng==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org
In-Reply-To: <20230523154605.4284-1-srinivas.kandagatla@linaro.org>
References: <20230523154605.4284-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 1/2] ASoC: codecs: wsa883x: do not set can_multi_write
 flag
Message-Id: <168492769030.49784.4719862081052299023.b4-ty@kernel.org>
Date:   Wed, 24 May 2023 12:28:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023 16:46:04 +0100, Srinivas Kandagatla wrote:
> regmap-sdw does not support multi register writes, so there is
> no point in setting this flag. This also leads to incorrect
> programming of WSA codecs with regmap_multi_reg_write() call.
> 
> This invalid configuration should have been rejected by regmap-sdw.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: codecs: wsa883x: do not set can_multi_write flag
      commit: 40ba0411074485e2cf1bf8ee0f3db27bdff88394
[2/2] ASoC: codecs: wsa881x: do not set can_multi_write flag
      commit: 6e7a6d4797ef521c0762914610ed682e102b9d36

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

