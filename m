Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB69E745FF0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjGCPg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGCPg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:36:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F25E44;
        Mon,  3 Jul 2023 08:36:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5783F60FA3;
        Mon,  3 Jul 2023 15:36:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84EBC433C8;
        Mon,  3 Jul 2023 15:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688398586;
        bh=PbtXTIJMyOGUJ5dY0n/KIAu/bd8TKKvRXGSl1gUJZ/s=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WRY10rosc1ofOxSiQyb4cviBwN8FjNjE+SVshqFUXdmADEm/S9iv+6GmB/ox2tUE7
         4XFA/f8wH3zp/hno3oqBbGWZ4gpBB9Cbe0qQAfVS5tmkp6xdR3XmyOHASi99YrgoWk
         UKCFl5L4kFotr0uL8YBArCh3nyEuNQiZl/fRnUgvOceoL1VexGehq5HNvPnYQY2PFI
         PIOAPtYdftQ6TWsmj97cDEa3iGla2w4LW6BJU0x1Mz/9rSgDFrIACF7DWiju/V5x6W
         Jx3Q+5lPgX00bPD8QRuDv7lwPSYwzTNOMMb75Sm6yXbtorcvXHnhjSMGArYVk32/0I
         5nXyeMvJcno9A==
From:   Mark Brown <broonie@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Steev Klimaszewski <steev@kali.org>
In-Reply-To: <20230701094723.29379-1-johan+linaro@kernel.org>
References: <20230701094723.29379-1-johan+linaro@kernel.org>
Subject: Re: [PATCH] ASoC: codecs: wcd938x: fix soundwire initialisation
 race
Message-Id: <168839858467.114514.7415760102411123285.b4-ty@kernel.org>
Date:   Mon, 03 Jul 2023 16:36:24 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 01 Jul 2023 11:47:23 +0200, Johan Hovold wrote:
> Make sure that the soundwire device used for register accesses has been
> enumerated and initialised before trying to read the codec variant
> during component probe.
> 
> This specifically avoids interpreting (a masked and shifted) -EBUSY
> errno as the variant:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wcd938x: fix soundwire initialisation race
      commit: 6f49256897083848ce9a59651f6b53fc80462397

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

