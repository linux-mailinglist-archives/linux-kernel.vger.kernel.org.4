Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBF5678201
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbjAWQne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbjAWQnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:43:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA652CC61;
        Mon, 23 Jan 2023 08:43:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9A6A60F9B;
        Mon, 23 Jan 2023 16:43:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF77C433EF;
        Mon, 23 Jan 2023 16:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674492180;
        bh=yVswVCV3rpo6pRLtM1xxdVAc0/UTV0lZ6oclhcJUEWs=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=bKuWY1eaAfXuFWEMD8pXG7JEG5uZGmSqXAsAQDJ5+dMKnj+Z+jzKXS36dWDlfAGrO
         xhoKpPwcbuYrRBnyU94xNn/hmcnuP21SfZJEJfzY71UY11MpXs0UYKRRzUgHo+PUEV
         HPRYld4mauT7+E4CDLTE6Ux+qm00CO50i9vyVcBYictQmyFdPxPhl8FAB8Hp+6U3tC
         VkrOA7vef3+K8K1X3Dlnb4tdPtq0KL4iHkDXDGylA0YMnE7DC+6hlYgXg/v2sF675p
         lqS661UKVFpEbKSM+Z54N0arlJC4+a1saK2IOG2kR7MJ6n2QCwsf5mZ7JfAyp+nJ0m
         /2tF5v/1yFIwQ==
From:   Mark Brown <broonie@kernel.org>
To:     agross@kernel.org, andersson@kernel.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, quic_plai@quicinc.com, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        quic_rohkumar@quicinc.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        devicetree@vger.kernel.org,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
In-Reply-To: <1673508617-27410-1-git-send-email-quic_srivasam@quicinc.com>
References: <1673508617-27410-1-git-send-email-quic_srivasam@quicinc.com>
Subject: Re: [PATCH] ASoC: qdsp6: audioreach: Add ADSP ready check
Message-Id: <167449217624.1484410.5375459304519764541.b4-ty@kernel.org>
Date:   Mon, 23 Jan 2023 16:42:56 +0000
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

On Thu, 12 Jan 2023 13:00:17 +0530, Srinivasa Rao Mandadapu wrote:
> Check for SPF readiness in prm driver probe to avoid race conditions
> during ADSP pil loading.
> This patch is to avoid, sending requests to ADSP before it's
> power domains are up and ready.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: qdsp6: audioreach: Add ADSP ready check
      commit: 47bc8cf60e926d1fb0c5d990bf6f5e01e9b3352e

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

