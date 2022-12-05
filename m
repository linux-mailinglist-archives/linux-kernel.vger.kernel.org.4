Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE3D642EC5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 18:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbiLER34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 12:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbiLER3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 12:29:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D15921E12;
        Mon,  5 Dec 2022 09:29:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA589B81193;
        Mon,  5 Dec 2022 17:29:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E68FC433D6;
        Mon,  5 Dec 2022 17:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670261369;
        bh=0uTGIuEBp5/Yv/xATwCrLsgELl6xETLxJwbbf9T7tjs=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=TBXtT8yf/8wq5ve5atb5btpuDC5rvHUw+4grdwQNyt3cU3/Y/lG+SM1Y5XeIKYLSb
         sSuU29KA8BxnquU4bKwBsc9GXZuw7d55Zh3MPoBZTh28AubCIUiWKLG1eFt0qPJTj7
         sQyibAArQAAbqcyqxVpH5UWsovoWghYSV321ffFoaG9VhcWRKkW1EBMN8Bs5/5iN4n
         fPx0ycweDEhciX76wmsS/Ilz2txrs492Y3SCSGfx/d5KNv0QTf679xRoTIIo0qxvak
         +mbtPgrMlMaF6MFyl0Hg3lVKZoYrrwljlP13iaqywzj/+VNjKNJWVlnuBa9y5cUYD+
         KO23iIH0pZn/g==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-kernel@vger.kernel.org, judyhsiao@chromium.org,
        andersson@kernel.org, lgirdwood@gmail.com, bgoswami@quicinc.com,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        quic_rohkumar@quicinc.com, tiwai@suse.com, swboyd@chromium.org,
        srinivas.kandagatla@linaro.org, agross@kernel.org,
        quic_plai@quicinc.com
In-Reply-To: <1670219333-32526-1-git-send-email-quic_srivasam@quicinc.com>
References: <1670219333-32526-1-git-send-email-quic_srivasam@quicinc.com>
Subject: Re: [PATCH] ASoC: qcom: lpass-sc7280: Add maybe_unused tag for system PM ops
Message-Id: <167026136595.536379.7143811448400492677.b4-ty@kernel.org>
Date:   Mon, 05 Dec 2022 17:29:25 +0000
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

On Mon, 5 Dec 2022 11:18:53 +0530, Srinivasa Rao Mandadapu wrote:
> Add __maybe_unused tag for system PM ops suspend and resume.
> This is required to fix allmodconfig compilation issue.
> 
> Fixes: a3a96e93cc88 ("ASoC: qcom: lpass-sc7280: Add system suspend/resume PM ops")
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: lpass-sc7280: Add maybe_unused tag for system PM ops
      commit: ab148b461c5cd767762bfcba5749c770ca836079

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
