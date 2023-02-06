Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79ABF68C8D6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 22:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjBFVhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 16:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjBFVhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 16:37:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187E51448C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 13:37:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BCDF6B81624
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 21:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F28C433EF;
        Mon,  6 Feb 2023 21:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675719452;
        bh=QwaT+uJL/hJru5ZOlxoiZKTJPcnsFBXbvupQfgZvSkQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Ix0IJHSIFXQySAea5+p1zqW+CUM4NQuaLh4P2Ij+y39Qmgg41vavbV43EbATOAMfU
         UhR+wZOi905vysyAewh2ktpU9RFFnFdey7rVehmEbka53rGioCxLdryXeQFDw+SG20
         9r+ycXj+G51hKwuLCH2IphLm4pmm1QYJv6OsTqkzWmiBCEMSAHa5Y1rV9tmkE1uKRY
         YVlFq/UvHnBYT+qZA1xeLy/hsECV8d3P1L1lGlwBvoYyq93kEw/xeddtsms6XTD+lH
         FXY8pXOND9RQ9UxzABVzUg9F9+k8Od8vvdtD7onP24yFb404db2h+cSYHtMFcm9sqf
         rH8wjVnGGrUhg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Alexey Firago <a.firago@yadro.com>
Cc:     alsa-devel@alsa-project.org, zhuning0077@gmail.com,
        yangyingliang@huawei.com, yangxiaohua@everest-semi.com,
        tiwai@suse.com
In-Reply-To: <20230204195106.46539-1-a.firago@yadro.com>
References: <20230204195106.46539-1-a.firago@yadro.com>
Subject: Re: [PATCH] ASoC: codecs: es8326: Fix DTS properties reading
Message-Id: <167571945073.1296981.607333949793064897.b4-ty@kernel.org>
Date:   Mon, 06 Feb 2023 21:37:30 +0000
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

On Sat, 04 Feb 2023 22:51:06 +0300, Alexey Firago wrote:
> Seems like properties parsing and reading was copy-pasted,
> so "everest,interrupt-src" and "everest,interrupt-clk" are saved into
> the es8326->jack_pol variable. This might lead to wrong settings
> being saved into the reg 57 (ES8326_HP_DET).
> 
> Fix this by using proper variables while reading properties.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: es8326: Fix DTS properties reading
      commit: fe1e7e8ce2c47bd8fd9885eab63fca0a522e94c9

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

