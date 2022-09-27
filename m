Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0D75EC109
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbiI0LVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbiI0LUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:20:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE919E0D6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:20:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 500BC617BE
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 11:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA1BC43470;
        Tue, 27 Sep 2022 11:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664277613;
        bh=46E4hEqTXKtt3oYNYZmUQp96STvltVuR/8PwPOxvs5M=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=F/BZt7oXeXYKGeuTfx4diaRQDTewf7FAdiLUQZZX/uKSP6z+ukj2P4rBJHo+w2dPg
         LaJ8U8n7bLXfCCL34Gx7JJF6lRC6oxB/no+5QU7FrWZgoNISSUY+cOySe2elXG8EB7
         AnBl5J4jSS3U1nsYDrVS3A8+CfwWhXFSQYji8obIjBxpZiRcBOroWS0QjeiukA/mKJ
         EKaokeougXAVuQZrHVTnM7jwGqhnA2gpY+GHMsNmW12/fDFTgBIs35eSlL1v1dAZUW
         /zQ8cD4AcPlpWkkqitb6mbypZmydtQKrOrVjy7R6iuNuseFPG9kuhTz8h1Z7DIkNwG
         I3XVesSYafT/w==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        Banajit Goswami <bgoswami@quicinc.com>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Bjorn Andersson <andersson@kernel.org>
In-Reply-To: <20220923203140.514730-1-krzysztof.kozlowski@linaro.org>
References: <20220923203140.514730-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH RESEND] ASoC: MAINTAINERS: add bindings and APR to Qualcomm Audio entry
Message-Id: <166427760891.294040.2558313442791079333.b4-ty@kernel.org>
Date:   Tue, 27 Sep 2022 12:20:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Sep 2022 22:31:40 +0200, Krzysztof Kozlowski wrote:
> Extend the Qualcomm Audio maintainer entry to include sound related
> bindings and the Qualcomm APR/GPR (Asynchronous/Generic Packet Router)
> IPC driver, which is tightly related to the Audio DSP.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: MAINTAINERS: add bindings and APR to Qualcomm Audio entry
      commit: 2b381b4a91e94bd1d328de6e66cf97dec13bb40c

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
