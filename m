Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBA36EAEAB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 18:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbjDUQGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 12:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjDUQGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 12:06:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EED9034
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 09:06:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A00D65192
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 16:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7B4C4339B;
        Fri, 21 Apr 2023 16:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682093193;
        bh=HBtnEN10dlxDAlEslSga5MfRXYbeXLnzwIotPTBvICg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=lHWv2ZqhEMVBo5WAIy8OItuM02p9xcRX/BfoCJJBmUa/8VoWJmejLiXSiMjQ+XHKM
         c67XnmtEaZpZBT/g81BmFl9aFGY/BSz/E3XhkWWGCnyk316vQ2zZz26/RG667EI/1I
         1aA4yw85krqaRNDubOiXSbpfJzn+yQLadXTs7tt4mS3juDKD6xCUXYqhe+wUKkkyxH
         KuTUFciIb+cs1FaRR83wmtER9B2166wyhXx8PmUveD05U9gIO/fswjA/svBkFeEpeK
         TFzN4kQTRqM8RxOa0WHTcGMIF8no8hii5+m8ezkuVH+Xfup35Mhz4Eq1Stc1pIKj1M
         dLsZMmlaYgjGA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230419-asoc-es8316-volatile-v1-1-2074ec93d8f1@kernel.org>
References: <20230419-asoc-es8316-volatile-v1-1-2074ec93d8f1@kernel.org>
Subject: Re: [PATCH] ASoC: es8316: Don't use ranges based register lookup
 for a single register
Message-Id: <168209319150.108546.8396846755495110996.b4-ty@kernel.org>
Date:   Fri, 21 Apr 2023 17:06:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00e42
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2023 19:45:06 +0100, Mark Brown wrote:
> The es8316 driver uses a register range to specify the single volatile
> register it has. While the cost will be in the noise this is a bunch of
> overhead compared to just having a volatile_reg() callback so switch to
> the callback.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: es8316: Don't use ranges based register lookup for a single register
      commit: 2cc3fdcddc86644c070223c522e418416cb7b1a2

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

