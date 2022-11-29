Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CC263C065
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 13:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbiK2Myz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 07:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234716AbiK2Myr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 07:54:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F72303CD;
        Tue, 29 Nov 2022 04:54:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D41561712;
        Tue, 29 Nov 2022 12:54:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2745CC433D7;
        Tue, 29 Nov 2022 12:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669726486;
        bh=tjFD8CRAWN9uffc4GBtwl8R6QM4DIePk4c8zqSTRcA4=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=R757RHT9Ecn7JGMWLr73R1/J9kUryIEg7HHFOwDwwYl9hjzrJttxir7fxXPSlG9Gz
         KN+mCNm4G4IaeZYYwzdGJmSujPazBfiu+jMMUSXvi0VXu/kQoDHsRd/dyGHRnRupet
         fZJwJ81vIiIJltLl4X3Iu0lnEGcq/a7jZRl6VcmlW8aPfVoaFBbk1f0MNjmxxq7HOu
         h5jxBHxSOBY+L4CELaiCbmuOtHcCYJQ4QLixbmNjr4iODWnO1IGZfGB2CykLiOXHHZ
         xtWlwgI5PbYhM+HPBBxbB4s3g8/R1EcfCoy7kYRKoRTbC+yEa4x4xaH3B8DjzqKCEc
         uOmhtv4oTwgSg==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, srinivas.kandagatla@linaro.org,
        bgoswami@quicinc.com, quic_plai@quicinc.com, tiwai@suse.com,
        andersson@kernel.org, judyhsiao@chromium.org, perex@perex.cz,
        linux-arm-msm@vger.kernel.org,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        robh+dt@kernel.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        quic_rohkumar@quicinc.com
In-Reply-To: <1669703784-27589-1-git-send-email-quic_srivasam@quicinc.com>
References: <1669703784-27589-1-git-send-email-quic_srivasam@quicinc.com>
Subject: Re: [PATCH] ASoC: qcom: lpass-sc7280: Add system suspend/resume PM ops
Message-Id: <166972648286.69085.1348792886931183406.b4-ty@kernel.org>
Date:   Tue, 29 Nov 2022 12:54:42 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Nov 2022 12:06:24 +0530, Srinivasa Rao Mandadapu wrote:
> Update lpass sc7280 platform driver with PM ops, such as
> system supend and resume callbacks.
> This update is required to disable clocks during supend and
> avoid XO shutdown issue.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: lpass-sc7280: Add system suspend/resume PM ops
      commit: a3a96e93cc888c652e47e4d7346abe99b1b44c53

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
