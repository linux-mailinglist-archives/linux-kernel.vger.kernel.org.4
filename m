Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BABD74A050
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbjGFPDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjGFPDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:03:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03268F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 08:03:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D315608C3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 15:03:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A539CC433C8;
        Thu,  6 Jul 2023 15:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688655826;
        bh=a3v2wGBajJZF0CvLHigKspo+k63gSagvdfIpaZ/IkOc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fQDVSwz0rwZEIcbaL/N2Nf4vurD/ORJ0ov2jommSOnKZLwV6S+Ye/oPs5ixonH9Z9
         bWQrbkjQ7M5n7chGlgHqpULe/OXXszzpWAIECJpitEfFBASzVMypwjuvlZqj+OZEid
         y0VNCl5Zu6lmbOcPOujV6zT7uz6qYq7YbXNRCIq1hkhb5I43J1gqtnLBOimRCdXa0u
         3gCqKjlrt7CNhsCrJhjPh/WZ84HfEufniV9b6mSD2ZudjpPGF3aWkM859chBkySE55
         D4oli166hf2zWGLOA8NwQsywqlSEOQEMps69Ji+gqbiBPznU5Bdz4BjTrqHzVBISFW
         skop5VwxvNpTw==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, Amit Pundir <amit.pundir@linaro.org>
In-Reply-To: <20230705124850.40069-1-srinivas.kandagatla@linaro.org>
References: <20230705124850.40069-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: qcom: q6afe-dai: fix Display Port Playback
 stream name
Message-Id: <168865582438.36989.3459774757107985233.b4-ty@kernel.org>
Date:   Thu, 06 Jul 2023 16:03:44 +0100
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

On Wed, 05 Jul 2023 13:48:50 +0100, Srinivas Kandagatla wrote:
> With recent changes to add more display ports did not change the Stream
> name in q6afe-dai. This results in below error
> "ASoC: Failed to add route DISPLAY_PORT_RX -> Display Port Playback(*)"
> and sound card fails to probe.
> 
> Fix this by adding correct stream name.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: q6afe-dai: fix Display Port Playback stream name
      commit: 4f3fcf5f6dc8ab561e152c8747fd7e502b32266c

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

