Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148F56989AD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 02:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjBPBKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 20:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjBPBKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 20:10:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F462941F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 17:10:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 429EAB824E6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:10:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EAC0C433D2;
        Thu, 16 Feb 2023 01:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676509799;
        bh=8bU5ot4UEC9oCBGcLSId91PlCnKLheeqvb9yICvFccs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=h89PGSRfq9ydIrkeTw1S+DUHXI94JmM7olmcN/gqYcV3b9jmWoNitITHkMIi+n2mk
         jlbucI1ER9YJxg9pqSy+g+JE+ShbtJBvMISAK2NJd6bAImjmN52PLaw7AOQIPcvgQw
         MKCFFKd49+k571g9sA4nhlmg492XtSITpwB9T+k2d2476fxPTBV07N8TTfR9CjV2Pp
         isDGrkiFaPvMVLlhPo3TqyzA63jAW4zWS07Wr2psvJsES2ynWsqL8HKrOmJGdrfFhW
         FE4LOVQMa37BuWCsZUXVSs3i+E7XrKSRp1G7SSE5Jyu62oX4rCFmIlWI6vvt7e/BvU
         dW86OD7viS4sA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Lucas Tanure <lucas.tanure@collabora.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
In-Reply-To: <20230215132851.1626881-1-lucas.tanure@collabora.com>
References: <20230215132851.1626881-1-lucas.tanure@collabora.com>
Subject: Re: [PATCH v2] ASoC: soc-dapm.h: fixup warning struct
 snd_pcm_substream not declared
Message-Id: <167650979674.3620645.17156084970442028190.b4-ty@kernel.org>
Date:   Thu, 16 Feb 2023 01:09:56 +0000
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

On Wed, 15 Feb 2023 13:28:51 +0000, Lucas Tanure wrote:
> Add struct snd_pcm_substream forward declaration
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-dapm.h: fixup warning struct snd_pcm_substream not declared
      commit: fdff966bfde7cf0c85562d2bfb1ff1ba83da5f7b

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

