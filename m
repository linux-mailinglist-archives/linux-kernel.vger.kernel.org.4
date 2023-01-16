Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8611666C308
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjAPO7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbjAPO6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:58:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1513629E27
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:48:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B70FBB80FEC
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 14:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FDAFC433EF;
        Mon, 16 Jan 2023 14:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673880534;
        bh=f2dRy9DEZaZXHnJafqlaDPBfDccF+ACeuVkBazxU81w=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=C3n8BZx2YcPLI0dyc51vJ14D/jLocX7Q7KwIlZ60SoZh22zWvskc8LF/4e3dALwtD
         gupGf75oKXTrGXhMDlwj0sJxRywUHcFYeuEyIrHRwUbOvYPbrb+W8FTQ6l+TlW621w
         GOJBflXeUnv9mdCigsXyVZMRvwKwYjzC4Vcfgb2NmhsYzdIPHXsxZod7xqWWb4yx30
         5FqUV8IU1K/9R2WcekHPh+zNE1BNgXEVloS58OBcsuzsxMzJGcd7v4//2Avardp+YQ
         cI0jpipGlhdksXD24uZcmPPded8UOmblkUp3czhzo4RtEYWS9tN8XJMkSCo6py568R
         cS5iyz5CVvDqw==
From:   Mark Brown <broonie@kernel.org>
To:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1673852874-32200-1-git-send-email-shengjiu.wang@nxp.com>
References: <1673852874-32200-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_sai: initialize is_dsp_mode flag
Message-Id: <167388053087.388539.12925338339363701914.b4-ty@kernel.org>
Date:   Mon, 16 Jan 2023 14:48:50 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-69c4d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2023 15:07:54 +0800, Shengjiu Wang wrote:
> Initialize is_dsp_mode flag in the beginning of function
> fsl_sai_set_dai_fmt_tr().
> 
> When the DAIFMT is DAIFMT_DSP_B the first time, is_dsp_mode is
> true, then the second time DAIFMT is DAIFMT_I2S, is_dsp_mode
> still true, which is a wrong state. So need to initialize
> is_dsp_mode flag every time.
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_sai: initialize is_dsp_mode flag
      commit: a23924b7dd7b748fff8e305e1daf590fed2af21b

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
