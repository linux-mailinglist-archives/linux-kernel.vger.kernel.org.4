Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF2763C3FA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235938AbiK2Pkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbiK2Pkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:40:46 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D8E64A10;
        Tue, 29 Nov 2022 07:40:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7EC60CE1375;
        Tue, 29 Nov 2022 15:40:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31CF4C433C1;
        Tue, 29 Nov 2022 15:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669736440;
        bh=p/2op5xe90YZqfKCHeiXyi+GWHBoal/ykuWpwuZF5HA=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=SYKIMHIh69WWqbGhnSDWnaE4HIN2P25f7edgu3zzDaJhWHikmjmi5ITve+cwQIi36
         dQ5oQ9g4/jT0Er0/VDw8wJh/Vu177KuG0Xvr/+9Tmq5IR7wwMmjh1MLljNJsY4sp7/
         nEqiFAo8whB0HvLrq7F+CDLKeSjgrpLa/1E0YBgk40pVnHc8Ud9tNS1ATkBCojTrW8
         GnkMPV5lSJH7Kxnn6XM2RLuhVxKEdkCi1VUMuaLEDoPU+uE3itul9Nbpq8sT1nIXMY
         FahjiVEEMci+O8XATbBqkuRI8w2ZOSYnLkyWlTgFZUx8uadSpkD9g4H7cbCCQKwyww
         CewGoawitoNhA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, andersson@kernel.org,
        bgoswami@quicinc.com, swboyd@chromium.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-arm-msm@vger.kernel.org, quic_plai@quicinc.com,
        judyhsiao@chromium.org, quic_rohkumar@quicinc.com,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        tiwai@suse.com, robh+dt@kernel.org, perex@perex.cz,
        srinivas.kandagatla@linaro.org, agross@kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <1669726428-3140-1-git-send-email-quic_srivasam@quicinc.com>
References: <1669726428-3140-1-git-send-email-quic_srivasam@quicinc.com>
Subject: Re: [PATCH] ASoC: qcom: lpass-sc7180: Add maybe_unused tag for system PM ops
Message-Id: <166973643691.238721.1254998116262856593.b4-ty@kernel.org>
Date:   Tue, 29 Nov 2022 15:40:36 +0000
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

On Tue, 29 Nov 2022 18:23:48 +0530, Srinivasa Rao Mandadapu wrote:
> Add __maybe_unused tag for system PM ops suspend and resume.
> This is required to fix allmodconfig compilation issue.
> Fixes: c3bf7699747c ("ASoC: qcom: lpass-sc7280: Add system suspend/resume PM ops")
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: lpass-sc7180: Add maybe_unused tag for system PM ops
      commit: e8679db2970f04ee5281c042977fff880a3c045a

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
