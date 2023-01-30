Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622A3681BF9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjA3VAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjA3VAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:00:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02AE460BF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:00:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4702A61254
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 21:00:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82846C433D2;
        Mon, 30 Jan 2023 21:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675112404;
        bh=NsVV/5BOHPQc7islZ776I/OBWFeiI6BU7PrKDMsT53s=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hVcfNtoqQFaAvMlN86W+G+JFHvTTXTPL47Gv8a6laBz0AZ54YaCO7qb4S0EebiZmQ
         fKWa+Gw7aqGOCzdbHZCzXvu1jNXmL5j4m0subvQ1gbpDWTfd9yNMb7tPVDaHGtxzxZ
         Z+bEM+wTL5xFk2TpsCeB51cANz24fYaOHUZbe8uHwLzJNPaZjTPpwZL3A2siB5xdRb
         ZPMx/R0k5qACRsNq9VIIyJckB8j/wKmO1SMu0R1EfCeKKglK1hUxWOlSZuSAB24lMJ
         8EvVTrQRUhPkYvCH1wdxTe4a8XKSNFq6Vnt1sLxotobs7lRrlTGU0hdfBR4bVeYhG9
         f4rNUNyHTtMNw==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc:     vsujithkumar.reddy@amd.com, Vijendar.Mukunda@amd.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        ssabakar@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20230130100104.4076640-1-venkataprasad.potturu@amd.com>
References: <20230130100104.4076640-1-venkataprasad.potturu@amd.com>
Subject: Re: [PATCH] ASoC: amd: acp: Refactor bit width calculation
Message-Id: <167511240124.2141894.6369090225666254370.b4-ty@kernel.org>
Date:   Mon, 30 Jan 2023 21:00:01 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jan 2023 15:31:00 +0530, Venkata Prasad Potturu wrote:
> Refactor bit width calculation using params_physical_width()
> instead hard-code values.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: Refactor bit width calculation
      commit: 55e681c950d89bcc9dc13bc15f5b64393ef58897

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

