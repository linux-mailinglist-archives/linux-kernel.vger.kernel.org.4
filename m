Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C90F6C748B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 01:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjCXAYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 20:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjCXAY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 20:24:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A4F2F7BF;
        Thu, 23 Mar 2023 17:24:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE9E36289E;
        Fri, 24 Mar 2023 00:24:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696F9C433EF;
        Fri, 24 Mar 2023 00:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679617448;
        bh=LMA50TR+ueiQ5J8dwpRDrkMnxhAmzBh6bOouAxz3Els=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=q6kIxRE1LVstF8sifnewiev66MEBPwTsR+DxN1sSoqr1dTWStLo9ULTu98fBRdkYw
         OlAmzscJqsyVJSGsuh1ur/p9FKrkryUpY9lrsC2RGCGmnKeyGbK0CivhMnmKns/NRj
         3CmVgkQlEljrXekfYaSzmQL2hnfydaLkNkqphgQ9BsCsrEICBcmGUsa1dZ43jYx/q0
         9xTULSmiaJkeDdtF2P3KOGwTI/xwPSSoRkbTlbiIskJBme81ZDFyPih43ztidH/uzz
         7ISsdvmK3rXLUHX3IzbntF64S6BqQRh43/cjFxfDO9mxXmki1pzwxGXm4LRYBrDJDH
         DG0lZ0EgsnMaQ==
From:   Mark Brown <broonie@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230323220518.3247530-1-m.szyprowski@samsung.com>
References: <CGME20230323220529eucas1p12e5e1bbe2a31fe775cd9e6244f9282ce@eucas1p1.samsung.com>
 <20230323220518.3247530-1-m.szyprowski@samsung.com>
Subject: Re: [PATCH] regulator: qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS
Message-Id: <167961744607.174517.3298842464664713586.b4-ty@kernel.org>
Date:   Fri, 24 Mar 2023 00:24:06 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2023 23:05:18 +0100, Marek Szyprowski wrote:
> Restore synchronous probing for 'qcom,pm8150-rpmh-regulators' because
> otherwise the UFSHC device is not properly initialized on QRB5165-RB5
> board.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS
      commit: 58973046c1bf782cac01644a9dcd8e5bba9c2f16

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

