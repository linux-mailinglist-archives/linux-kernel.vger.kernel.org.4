Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A78F6DB2C1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjDGS2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDGS2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:28:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4910F6A53
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 11:28:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C73FF6531B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 18:28:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65268C433EF;
        Fri,  7 Apr 2023 18:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680892080;
        bh=IaqEVSvO4+ec0TMhLkqBwp/Pr6mbvqqD98gAzdvOZHk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=CB6dOTtScPKXalKF3JrhUEVFMkjNB/W8xrIsDLtw7o/SNFs7/NUayzVsVrI7xZTi6
         X0uxshqcVt8/ZQ+HQFP/ISqfg2rEQM+1/7fsznDZZ1xVHaYpRO+cGUThOF0czMDS9p
         aIbj5s+dOxbhvcTm8ox6+jUwTzBb9DhE23Xa4iKQ6aNSlRw76MEzMi6DcfwEitwZ1S
         QL8as3fZZVBuzbVFXdRwX2oV1qxiRLq6w8L28SKmiDDeM6kLibtgqw7EsOwyKFqNrV
         ICy1BgUTt1BTI2EFfQ3VSlpquZQgx1VqLOoyChsryqFTYbvOzYJKzS05cDKcik2hg1
         Yh0tyYdp0SNdw==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        colin.i.king@gmail.com, fshao@chromium.org, jiaxin.yu@mediatek.com,
        allen-kh.cheng@mediatek.com, Tom Rix <trix@redhat.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
In-Reply-To: <20230407115553.1968111-1-trix@redhat.com>
References: <20230407115553.1968111-1-trix@redhat.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8186: set variable aud_pinctrl to
 static
Message-Id: <168089207711.180511.12653080399028672980.b4-ty@kernel.org>
Date:   Fri, 07 Apr 2023 19:27:57 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-2eb1a
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Apr 2023 07:55:53 -0400, Tom Rix wrote:
> smatch reports
> sound/soc/mediatek/mt8186/mt8186-afe-gpio.c:14:16: warning: symbol
>   'aud_pinctrl' was not declared. Should it be static?
> 
> This variable is only used in one file so should be static.
> 
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8186: set variable aud_pinctrl to static
      commit: 672029caa5708934817a331f3323bbe48d456c5c

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

