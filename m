Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C27E6989AB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 02:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjBPBKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 20:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjBPBJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 20:09:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DA72CC50
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 17:09:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2FBCB824E8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:09:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC500C4339B;
        Thu, 16 Feb 2023 01:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676509796;
        bh=xNdqVa3Vj9dpZHH5NFRkFb1vvoPFguNMFCvVdLtMjog=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ksqQqXwW+dsztZioHbF4bKLQTljX+JNXMAFDpUPL7bBvosYEJv/Q1z4BeYibo9lkL
         vu3apCBZeUX0jztpFOa9COUeR7z9VQLvujCqAkrCGQBPZRbZRKkX2AdA3V6PMlWJGe
         G9b9guZCa5JmoaqKzCQNypWfYdi9Uh1Dr4VMgOY5/uzlPtiS7v/UE1cL7a4qvgwdy+
         EUa916gc30V1zueqRoTpKI5OWTFSzRKAdK7Z8b+2hvB9FngJpjjQQlCJ0Bkx1KhZwS
         8alc24259dOWMqhpBP5FQU5KnJej87bippnDzWcPLDSxj+oDPGoagAHYUBXfQaQix0
         ImN2ftLyLFXoA==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
In-Reply-To: <20230215132343.35547-1-andriy.shevchenko@linux.intel.com>
References: <20230215132343.35547-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] ASoC: soc-ac97: Return correct error codes
Message-Id: <167650979440.3620645.14876076040377125402.b4-ty@kernel.org>
Date:   Thu, 16 Feb 2023 01:09:54 +0000
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

On Wed, 15 Feb 2023 15:23:43 +0200, Andy Shevchenko wrote:
> With the switching to dev_err_probe(), during the conversion
> of GPIO calls, the return code is passed is a paratemer to it.
> At the same time a copy'n'paste mistake was made, so the wrong
> variable has been taken for the error reporting. Fix this.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-ac97: Return correct error codes
      commit: 76f5aaabce492aa6991c28c96bb78b00b05d06c5

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

