Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8785B4297
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 00:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiIIWqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 18:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiIIWqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 18:46:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08407B5144
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 15:46:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B37E6B82320
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 22:45:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376EDC433D7;
        Fri,  9 Sep 2022 22:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662763557;
        bh=TycSWmIMYfOSFcfvx1izVknLB7zi2sU9zxghk1psAn0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=TQrhTw/WTISdbvOky6upC7pi3MCfxDIBq6BubhPfF3Ya4IjiAx64xIX2TyXUaStAB
         w/P4uIF6cQbg4UCSSHJ50w/jj264AVy/+cJ084DOOjmgRa7G5f/v2sHe2YaDQDw+xC
         hmmWgS99WHTKvpPaDN/SQuCNXN6wW3Bv2Q6jldrz/6Dtyiwitdg9b7hqNVn3JVDurj
         5LGCL8U0dACQ6kFWIyYXjCukCxWpGHB+azWZBdZO4+RBp9Ug6sbf8W1RJLqobm3cES
         paEwbB8ldUexsyqBQxGfMQ87uwzpvNqz2vvusIG5Z1Qh5y2voQyrbESLoi0xzEMjHS
         Tgcdm8DU3C9dg==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
        tiwai@suse.com, lgirdwood@gmail.com, nicoleotsuka@gmail.com,
        shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, perex@perex.cz,
        festevam@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1662695098-24602-1-git-send-email-shengjiu.wang@nxp.com>
References: <1662695098-24602-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v3] ASoC: fsl_asrc: Add initialization finishing check in runtime resume
Message-Id: <166276355495.332114.11561275882220746760.b4-ty@kernel.org>
Date:   Fri, 09 Sep 2022 23:45:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Sep 2022 11:44:58 +0800, Shengjiu Wang wrote:
> If the initialization is not finished, then filling input data to
> the FIFO may fail. So it is better to add initialization finishing
> check in the runtime resume for suspend & resume case.
> 
> And consider the case of three instances working in parallel,
> increase the retry times to 50 for more initialization time.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_asrc: Add initialization finishing check in runtime resume
      commit: d2de3f5ead84e230f4651cddf7658ab74ce1a70c

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
