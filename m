Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B3472CC01
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237241AbjFLREa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237235AbjFLREZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:04:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B39E7D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:04:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFE8462BD0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 17:04:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39262C433D2;
        Mon, 12 Jun 2023 17:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686589463;
        bh=1VyguFfPpZTsnsIDdebfEZyQpsQaNIQOvtAByML+2og=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=IOf7sfePVU0WZP3YNWSxfmX6UGVS1YGrybYaFAUrOT+JakvWR+6PcxoXNP9iN6HpW
         Npq7Jsw1MIjuWJ68MJgZt2y3Db+pxIEf1xVRlrXGdujBoHf8nOHeDL+nantwCTCNWS
         u4hPSMydyAonZ9/iUvmRiMHXz/vlQoyP8yYz4Ck5qn6sSmqGyei4D3JuVG3Ag6T9gi
         zZCJ8ZpVnnWetxzY5OpPczRZsLSjORecVMyfKUwJh563OZW8vAGuKfXaOCEWSHRsqp
         s7l6cs+h7auMd5VzWqBJ4bE7jQ4YG5b5Xp7s00VLfhssD0HeyK1RLXvAbaOyLQNOV2
         HtXbafNfX2O7A==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
In-Reply-To: <20230611203559.827168-1-u.kleine-koenig@pengutronix.de>
References: <20230611203559.827168-1-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] regulator: Switch two more i2c drivers back to use
 .probe()
Message-Id: <168658946195.83451.5950252461383064153.b4-ty@kernel.org>
Date:   Mon, 12 Jun 2023 18:04:21 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Sun, 11 Jun 2023 22:35:59 +0200, Uwe Kleine-König wrote:
> The previous conversion back to .probe done in commit 964e186547b2
> ("regulator: Switch i2c drivers back to use .probe()") was done based on
> v6.3. Since then two more drivers were added which need to be convert
> back in the same way before eventually .probe_new() can be dropped from
> struct i2c_driver.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: Switch two more i2c drivers back to use .probe()
      commit: d692cc619247addcb9336c220ea1face91b365f0

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

