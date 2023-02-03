Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5A268A08F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 18:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjBCRnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 12:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbjBCRnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 12:43:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC073BD88;
        Fri,  3 Feb 2023 09:43:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F88BB82B51;
        Fri,  3 Feb 2023 17:43:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B4FC433D2;
        Fri,  3 Feb 2023 17:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675446208;
        bh=e6yTEooKfk3WEQTuQrtNRVDKU8hw7pP938U9WCgGoYI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=b8OCK5UcsdO2smKGMHZNdzHuerDz79NVoaTpz5JZ8Ksl0/uhen7V4Ekg9pqdX/LTS
         VHI6bMj/mFTifgoFtRpbBa1r4KjXAyRFPvCaXB32SD1QLySf9Oy/ybWDIfTuG5Kzgh
         oxUAoR4/FLG79hApQhjJRCFJlg8Itmq1cKi/W5MsOclqeH9MwbzUPZNturhF8FUnqG
         DH503N33RC/4gAPonGsegLNHT/gOwbPF0+VUOqNEmKqZuzT0QoWlr09YRv4umND85d
         8Z/eOIfUmm2QtDWscND0K19TWi7EGDJ1pcUHqV73jjJ3k1/7r16aIBY8Bo6iUi6PL5
         hlEELLrElQJng==
From:   Mark Brown <broonie@kernel.org>
To:     tony@atomide.com, lgirdwood@gmail.com,
        Jerome Neanne <jneanne@baylibre.com>
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, nm@ti.com, msp@baylibre.com
In-Reply-To: <20230203140119.13029-1-jneanne@baylibre.com>
References: <20230203140119.13029-1-jneanne@baylibre.com>
Subject: Re: [PATCH] regulator: tps65219: use generic set_bypass()
Message-Id: <167544620617.1020619.12568195566452835847.b4-ty@kernel.org>
Date:   Fri, 03 Feb 2023 17:43:26 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Feb 2023 15:01:19 +0100, Jerome Neanne wrote:
> Due to wrong interpretation of the specification,
> custom implementation was used instead of standard regmap helper.
> LINK: https://lore.kernel.org/all/c2014039-f1e8-6976-33d6-52e2dd4e7b66@baylibre.com/
> 
> Fixes: c12ac5fc3e0a ("regulator: drivers: Add TI TPS65219 PMIC regulators support")
> 
> Regulator does NOT require to be off to be switched to bypass mode.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: tps65219: use generic set_bypass()
      commit: 0365df81145a4cfaae5f4da896160de512256e6d

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

