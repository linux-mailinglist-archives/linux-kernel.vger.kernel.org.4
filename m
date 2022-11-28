Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BD563ADF4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 17:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbiK1Qjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 11:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbiK1Qj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:39:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302BC25298;
        Mon, 28 Nov 2022 08:39:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB6C5B80E16;
        Mon, 28 Nov 2022 16:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E98AC433C1;
        Mon, 28 Nov 2022 16:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669653562;
        bh=YgLMfdUQGT5lCNVStZjrAhw/JJQl8Py7iBEVi6NQUWU=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=GCaiCE/RId707JCrW1iO/GbCIZHMIChWSU4fpgaV+8FwWX0amz55f/k8hXTgLO0rX
         P4q+VYSVHZhIetlY+5IbKJGA5hAyL1znsNzSdylfaRZ14lGexG8SMgrOhlXxEnglct
         fUIIzm+EpSPAlpXet+h+M3HDMASkisxqc72gXdL1DVZLe9hp3M/RAKhKEQrLa1rgc5
         G4Y2rA5XRqHW5d9rZSnw0kDgt8iTdaeQonLwUIP8rlNWcgZbEUD6nYfm8dyKMVigd3
         VhC1ow+9y03ee2P++zJCeud/fPBNvEevmcndgTy3b+nDVc/pMVa+2lqdPt43BfEGyg
         6JwgyPhgERAgQ==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, quic_rohkumar@quicinc.com,
        linux-arm-msm@vger.kernel.org, judyhsiao@chromium.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_plai@quicinc.com,
        perex@perex.cz, agross@kernel.org,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        srinivas.kandagatla@linaro.org, swboyd@chromium.org,
        tiwai@suse.com, bgoswami@quicinc.com, robh+dt@kernel.org,
        andersson@kernel.org
In-Reply-To: <1669621742-28524-1-git-send-email-quic_srivasam@quicinc.com>
References: <1669621742-28524-1-git-send-email-quic_srivasam@quicinc.com>
Subject: Re: [PATCH] ASoC: qcom: lpass-sc7180: Add system suspend/resume PM ops
Message-Id: <166965355923.629583.3946711311315912094.b4-ty@kernel.org>
Date:   Mon, 28 Nov 2022 16:39:19 +0000
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

On Mon, 28 Nov 2022 13:19:02 +0530, Srinivasa Rao Mandadapu wrote:
> Update lpass sc7180 platform driver with PM ops, such as
> system supend and resume callbacks.
> This update is required to disable clocks during supend and
> avoid XO shutdown issue.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: lpass-sc7180: Add system suspend/resume PM ops
      commit: 2d68148f8f85ca5a4bf5e80c821b56167cfc0f8b

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
