Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BD07298F2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 14:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239349AbjFIMDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 08:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238814AbjFIMDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:03:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C23B1A2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 05:03:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 875C260C82
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 12:03:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE37C433EF;
        Fri,  9 Jun 2023 12:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686312201;
        bh=1jjcdKhj/+ouunvIwaeB7ZlxqlPxeod3AFpiYr+Xgnk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hswiHLpVaRU5i3syRy6zKRhlad6hHBUThRgRBxw6c27iv3jKzT6iCS6Hrxiqabr4e
         3y1R6WV6wwbPQEdpahB2cBx2Me017YjDZ+eq4yXK+64r5HzP/8QPSY4ClzAn+6qLwi
         zsIx8U5ExAR/r5d2FEuOfJkWUhkCh9Ip8txAzhNueBwLGl2gOuNXwTHFNPkYA0Qj4G
         gFap5aClVRk+1gIdGsJ6yE41CcYQi0qlYArA/c/7q7EWyr62BgLqIx1IJMoHMtSeAL
         lrJ02XTMPDZz8P5QZYOPVeODPYJ1bRujONDD0VvXPPK7xdxwz8i2FkLO6HdggSkeSe
         HwFqZjJhJKwkw==
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@collabora.com>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
In-Reply-To: <20230608221050.217968-1-nfraprado@collabora.com>
References: <20230608221050.217968-1-nfraprado@collabora.com>
Subject: Re: [PATCH] Revert "ASoC: mediatek: mt8192-mt6359: Remove " Jack"
 from Headphone pin name"
Message-Id: <168631219815.40482.7959512272039581328.b4-ty@kernel.org>
Date:   Fri, 09 Jun 2023 13:03:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Jun 2023 18:10:48 -0400, Nícolas F. R. A. Prado wrote:
> This reverts commit cbbc0ec6dea09c815f1d1ef0abaf3f2ec89ff11f. That
> commit removed the " Jack" suffix with the reasoning that it is
> automatically added to the name of the kcontrol created, which is true,
> but this name is also used to look for the DAPM widget that will be
> toggled when the jack status is updated. Since the widget is still
> called "Headphone Jack" the jack can't link to the widget and the
> following error is shown:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] Revert "ASoC: mediatek: mt8192-mt6359: Remove " Jack" from Headphone pin name"
      commit: e352f31a863f47adfa54c76b633a21b1ed562387

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

