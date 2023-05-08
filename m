Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010D46FB16E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbjEHN1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbjEHN1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:27:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63CD2BCD1;
        Mon,  8 May 2023 06:27:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AF8963D29;
        Mon,  8 May 2023 13:27:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFCACC433D2;
        Mon,  8 May 2023 13:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683552430;
        bh=7iCcI0DNvSLl/NTUgHfYpRIkdfoakjSi68PDmFXmJaM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ZzYUoCFMA/1U2gEMq+vxbladK1oykOpmEljyNfKOAUEjEYNbMQNQnfJfIEav0mWAx
         YWUz+OV3d2nzwdtvfH4SqfT5E6eossN9uC8wdTyOYzX8y7FygL8RI9rr2s2zz20EYU
         J8DExFpyPqp/ZFMijc/RppTDwk36jwUH2tXQnqJNOynmH5PD79dmeHTZRYMPII4B++
         C2VxKK5UPX5RJkn3UNmI1GX+fE6jnQt+/OSc1jymLp62uGezJV4SKr2jfSkeU1n7yn
         XtH7YecmkIkCQmI4Ka9qun9haRrRr4o9Ca/sfqdmX6ozf4MYvnI4LRYc7nNGl3Arkh
         fc0Apu0N6INoQ==
From:   Mark Brown <broonie@kernel.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org, quic_vtanuku@quicinc.com
In-Reply-To: <1682412128-1913-1-git-send-email-quic_vnivarth@quicinc.com>
References: <1682412128-1913-1-git-send-email-quic_vnivarth@quicinc.com>
Subject: Re: [PATCH] spi: spi-geni-qcom: Correct CS_TOGGLE bit in
 SPI_TRANS_CFG
Message-Id: <168355242802.260152.2725624088610740089.b4-ty@kernel.org>
Date:   Mon, 08 May 2023 22:27:08 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Apr 2023 14:12:08 +0530, Vijaya Krishna Nivarthi wrote:
> The CS_TOGGLE bit when set is supposed to instruct FW to
> toggle CS line between words. The driver with intent of
> disabling this behaviour has been unsetting BIT(0). This has
> not caused any trouble so far because the original BIT(1)
> is untouched and BIT(0) likely wasn't being used.
> 
> Correct this to prevent a potential future bug.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-geni-qcom: Correct CS_TOGGLE bit in SPI_TRANS_CFG
      commit: 5fd7c99ecf45c8ee8a9b1268f0ffc91cc6271da2

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

