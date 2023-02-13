Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74D6694C48
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjBMQTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjBMQSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:18:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1902B1ABED
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:18:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2351B8160C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 16:18:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95EDDC433EF;
        Mon, 13 Feb 2023 16:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676305127;
        bh=Z5wDnvOGNHRIFgJc+WGtrzbrEBxSmidUa+bQ3LSxztc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BtZQE/gF/++2WEj5M0RL7Ph6EZp6UZ9k/BKk6EQZuca2DTZrylsJhjXN44fjVMG85
         jbe3E6uoOKMb0UVMsyYbtVBMCOLF5+5s/4m2esiuqqU43Wcb2MVEQyr4jsONScGHO5
         4pP/qQP6qoOMpBWTu9PYVlNSWj0scLk8hO+KVvMoljf5T9JkHul7ljNiKm4/BnY+rG
         S1HWCyetPRcOCYpIa56Jjhbi2GS3DcRmm2iRea7xGt1N0nev+EE1UgkBOmyUoIeeft
         cxI/ao42OiuiQD8kXOywoqY9TsDB3OIOutfoqOIVs99P7SFskygruJK6K1ve77IuPX
         eRw0ujLC0FsFg==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, Yang Li <yang.lee@linux.alibaba.com>
Cc:     perex@perex.cz, herve.codina@bootlin.com, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20230213010547.105312-1-yang.lee@linux.alibaba.com>
References: <20230213010547.105312-1-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next] ASoC: codecs: Remove unneeded semicolon
Message-Id: <167630512528.2770751.9782489444187002292.b4-ty@kernel.org>
Date:   Mon, 13 Feb 2023 16:18:45 +0000
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

On Mon, 13 Feb 2023 09:05:47 +0800, Yang Li wrote:
> ./sound/soc/codecs/peb2466.c:1851:2-3: Unneeded semicolon
> ./sound/soc/codecs/peb2466.c:1887:2-3: Unneeded semicolon
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: Remove unneeded semicolon
      commit: d227116c0e216da2eceba1d51a364ff025dffa58

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

