Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996506C8279
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 17:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjCXQhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 12:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjCXQhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 12:37:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3491911164
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 09:37:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C732B62BE2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 16:37:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B795C4339C;
        Fri, 24 Mar 2023 16:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679675838;
        bh=DQY9ctg3T+c6abapIIjPB3Hmid4K/GBraiBtzjZ+RI8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=DCD+lb6IJt2QwJB8SJwL8szjw+XqxJt/CqpGGgr/CPpDbacxr2MJvPKclFmAsOsHt
         AEDigOOkXKXCcG+E1S65Qev0bJ1n2AgKX3lEN89uYQzYG8TV4cjbI4JevxpoFUJjaW
         Ise7lvI4btSE7/uypS3ZX0mF7lo4QWmP/yQTup4e3raNMT55gQTLzVN5CL/CSaFUMw
         fegC9OBzwd02KsTt8X/bAdNTmqsJnc+W/1+Ptnq0Ml1Hy2Usw3eM6VGWwD4VukKjrP
         0s22Oehpdh5ixSm0Jt7Cj9uznttock+nhUL6QX/h9E1VhdITddhbosYezRdKLbM+hV
         uD6vWTFqhcCrw==
From:   Mark Brown <broonie@kernel.org>
To:     pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, lgirdwood@gmail.com,
        vkoul@kernel.org, daniel.baluta@gmail.com
In-Reply-To: <20230324124019.30826-1-daniel.baluta@oss.nxp.com>
References: <20230324124019.30826-1-daniel.baluta@oss.nxp.com>
Subject: Re: [RESEND PATCH] ASoC: soc-compress: Inherit atomicity from DAI
 link for Compress FE
Message-Id: <167967583502.2616375.6057575229781952766.b4-ty@kernel.org>
Date:   Fri, 24 Mar 2023 16:37:15 +0000
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

On Fri, 24 Mar 2023 14:40:19 +0200, Daniel Baluta wrote:
> After commit bbf7d3b1c4f40 ("ASoC: soc-pcm: align BE 'atomicity' with
> that of the FE") BE and FE atomicity must match.
> 
> In the case of Compress PCM there is a mismatch in atomicity between FE
> and BE and we get errors like this:
> 
> [   36.434566]  sai1-wm8960-hifi: dpcm_be_connect: FE is atomic but BE
> is nonatomic, invalid configuration
> [   36.444278]  PCM Deep Buffer: ASoC: can't connect SAI1.OUT
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-compress: Inherit atomicity from DAI link for Compress FE
      commit: 37b58becc1cee4d591024f2056d7ffa99c6089e0

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

