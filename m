Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29CD67F9C7
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 18:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbjA1RSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 12:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjA1RSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 12:18:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D412005E
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 09:18:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7EC70B80189
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 17:18:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5087CC4339B;
        Sat, 28 Jan 2023 17:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674926330;
        bh=tCEziaVs3JxdlO4hxGu5XvC3DMkiL9pb8Hf2+fJU9L0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BWs0dnRI2lpt41AsPzgGB8HPTlzbqxytEMrqF0kd6PrMZDpi6R++U6GDzpErVfvWC
         mm3tCT+XkrEhLoZQVXHmT6IGY9rTEmdcUwJ4mP6RN+PQtD1kMiLFCVjN+I6oOAqb4R
         qim8jLHPsVAblNx3TUnnKrtgs+IIkGIF3Im9xc2delTS0b3C7H7155fNLd2kwG95Sx
         9CvnBMqZ6E3rGVTEo24nNMTJ3RtGf0rQembWxJVAEJMJewoRaU+qLtMo0motw5aAUh
         0Z+L+ylloIDwrG3TTiXX8ZjzVs2AapTT39xu3VajG2iRJyRED5Kg28BaLMyh3pQ17p
         4Ru/RsdRSVZlg==
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc:     alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
In-Reply-To: <20230126152412.959574-1-luca.ceresoli@bootlin.com>
References: <20230126152412.959574-1-luca.ceresoli@bootlin.com>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: constify fsl_asoc_card_dai
Message-Id: <167492632615.2479102.10999900296434144172.b4-ty@kernel.org>
Date:   Sat, 28 Jan 2023 17:18:46 +0000
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

On Thu, 26 Jan 2023 16:24:12 +0100, Luca Ceresoli wrote:
> This is never modified and can be made const.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl-asoc-card: constify fsl_asoc_card_dai
      commit: 18e16350558ac42c8cc55c5df714fd28412452ad

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

