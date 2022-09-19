Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED27C5BD7D9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 01:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiISXKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 19:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiISXKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 19:10:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AB2275FB
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 16:10:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABA0BB807ED
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 23:10:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1841C43149;
        Mon, 19 Sep 2022 23:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663629005;
        bh=KxyL/YMTe3xp5VtT+ZYbXU19kolGIuUiR4jK0OHYe5M=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=cZiSGmFXTQnHujmqd/9zcOtcpGeNhtNZV5SZ/yZ58Y6NmzKL3BD9RIbYM/jYkr5Jk
         N2RGyOB3qceEkm8Oz5apptH6k7ATE8xpXksbJ76rcP45pSpPY/iSFvMeKkmG8nbf3H
         rltB+tskfA1KX3RAJn1j3BAYQUzpaoRUO3vo5hle4WTPAAzgGGNWdrhTWvcJbPPgqC
         xSk2MppbWYII+tuUNU10nhnt/kBccUDwZNW0OhZlc1fKv2v4yU9JDFiNkweHg5ZH3N
         cxB01Q2ffcMwmfmj0i5BT6kvqsETNLHHBaB7HyciqQUGXFvjN8pv+Hdtw0MMRH4BMo
         1GnK1FG6XGDNg==
From:   Mark Brown <broonie@kernel.org>
To:     cgel.zte@gmail.com
Cc:     ranjani.sridharan@linux.intel.com,
        ye xingchen <ye.xingchen@zte.com.cn>,
        muralidhar.reddy@intel.com, linux-kernel@vger.kernel.org,
        andrey.turkin@gmail.com, tiwai@suse.com, mchehab@kernel.org,
        cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com,
        perex@perex.cz, kai.vehmanen@linux.intel.com,
        liam.r.girdwood@linux.intel.com, Zeal Robot <zealci@zte.com.cn>,
        alsa-devel@alsa-project.org, yung-chuan.liao@linux.intel.com,
        peter.ujfalusi@linux.intel.com
In-Reply-To: <20220916062415.153659-1-ye.xingchen@zte.com.cn>
References: <20220916062415.153659-1-ye.xingchen@zte.com.cn>
Subject: Re: [PATCH linux-next] ASoC: Intel: sof_es8336: use function devm_kcalloc() instead of devm_kzalloc()
Message-Id: <166362900145.3419825.1680084874127824841.b4-ty@kernel.org>
Date:   Tue, 20 Sep 2022 00:10:01 +0100
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

On Fri, 16 Sep 2022 06:24:15 +0000, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Use 2-factor multiplication argument form devm_kcalloc() instead
> of devm_kzalloc().
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: sof_es8336: use function devm_kcalloc() instead of devm_kzalloc()
      commit: 59f84d2dd76ad6e681b5135db6e6cc8c8238cd89

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
