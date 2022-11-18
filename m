Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AAE62F8D6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 16:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241979AbiKRPFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 10:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241719AbiKRPFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 10:05:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B5D8FF83
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 07:03:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26BE9B82424
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 15:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B74EC433D6;
        Fri, 18 Nov 2022 15:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668783797;
        bh=3m9V1HzpKpnYpIyrJLauVGqt4rc5xBD16TzOZy+ioLk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=gQ6CUJmLWVBiRDi3UprnyyZ69XFm5bD5Sfor0yyEmtaRs6LKsDyy/T82WpMDJETcq
         axVtu9ukazfahycecjPHN7Mg1P7NWZQYzOGzuof274hPscVHxL/evHfFy5cIz91zRM
         z0J8Cc/mCWTj7GlZW4cMnaRHNIFE7AbqdCIx8uf0vh3+g4otjJGAG4SdoWMVmCgAOo
         p6abyP1VRun5jAY2XzyT9qBiLIx6XsV8qbllfS0KfXle4hSgwMkB8sFl/fbZZGtw+L
         Uny8D68/E1sCO1eKxZ2GS6I0joMmGkEH0DsXOUa4e6rfl7wN+HRRpZ/JLxK2znuIWa
         pnoTZ4k2vwbig==
From:   Mark Brown <broonie@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        patches@linaro.org
In-Reply-To: <20221118131035.54874-1-konrad.dybcio@linaro.org>
References: <20221118131035.54874-1-konrad.dybcio@linaro.org>
Subject: Re: [PATCH] regulator: slg51000: Wait after asserting CS pin
Message-Id: <166878379620.937643.12916671010075524568.b4-ty@kernel.org>
Date:   Fri, 18 Nov 2022 15:03:16 +0000
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

On Fri, 18 Nov 2022 14:10:35 +0100, Konrad Dybcio wrote:
> Sony's downstream driver [1], among some other changes, adds a
> seemingly random 10ms usleep_range, which turned out to be necessary
> for the hardware to function properly on at least Sony Xperia 1 IV.
> Without this, I2C transactions with the SLG51000 straight up fail.
> 
> Relax (10-10ms -> 10-11ms) and add the aforementioned sleep to make
> sure the hardware has some time to wake up.
> 
> [...]

Applied to

   broonie/regulator.git for-next

Thanks!

[1/1] regulator: slg51000: Wait after asserting CS pin
      commit: 0b24dfa587c6cc7484cfb170da5c7dd73451f670

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
