Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5787C702B1A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241188AbjEOLJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbjEOLJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:09:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC0610F1;
        Mon, 15 May 2023 04:09:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F4646227B;
        Mon, 15 May 2023 11:09:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76DBC433EF;
        Mon, 15 May 2023 11:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684148975;
        bh=lwjgziLcEsIzBPxxZ1N8abCwzxvPGfURke6CIpHvtww=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YuNMzPkbzr28+j0Zo8hTdy3k5Ja8MNwey/47bnhvvp39UClQ1RjDBJwvXkB3vK9jb
         +FrQrprKO/3/gtG3k7KoorIUtPuMv/luFfVAxrafGmthNLmIDUmKqGIwaWAF/SATn7
         DUPtBx9KtK8L5f05ze+WfcJA40mLLtEa0+X7KAE9GVOmHT9xQx0WirJgS7VZdHM5uq
         aUYxWWdb6FD/9QlHZvIIlvG1pSS56OmLLhdZCQq7WLyl7x3Fmp4DsRcDBQPu39Lhk2
         KcJG5M1oISFsZBpcXsU/H4ckjQ8TmGFpIf/eLrVmvTEARafIxwNF6EanGDG9HGgYmS
         i3fXELO7XL3mg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
In-Reply-To: <20230513090228.4340-1-krzysztof.kozlowski@linaro.org>
References: <20230513090228.4340-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: MAINTAINERS: drop Krzysztof Kozlowski from
 Samsung audio
Message-Id: <168414897357.394037.3389766402303422512.b4-ty@kernel.org>
Date:   Mon, 15 May 2023 20:09:33 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

On Sat, 13 May 2023 11:02:28 +0200, Krzysztof Kozlowski wrote:
> Remove Krzysztof Kozlowski from maintainer of Samsung SoC Audio drivers
> and change the status to maintenance (no one is reality being paid for
> looking at this).
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: MAINTAINERS: drop Krzysztof Kozlowski from Samsung audio
      commit: 647b5f5fdcbaba6f6fd8db69508fcbeb1fdfc2a6

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

