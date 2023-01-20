Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7386675A1B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjATQgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjATQgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:36:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C996D917FF;
        Fri, 20 Jan 2023 08:36:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8276061FFE;
        Fri, 20 Jan 2023 16:35:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A07DC4339B;
        Fri, 20 Jan 2023 16:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674232549;
        bh=r7K+Ya5L1lTN5wHwgGTJIKfXMxPBDnujeeK5v157kB4=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=QqJae6/KoJEjT+YlHt6Ax4bIYKhR2ElNfUU4VM1c+uOOOAw+ArFNNkF05QjSDmQ3j
         yVM7CmnOPNhaFUKOxQlCB5qG8xd3KogywribmeUqC1Eh+rhWy9NArEGzc9pmTqky2x
         GtNJP8nBfOYKVCdlMROJX4+48hv2nH9vPZ825a4K5A/y2BYVlQNHWaYSdhVD9mUGTw
         7/W9fCoGWGfFskotm2g32pUBySomRq1g3P9OoaP2ZgmVJFR/cw5+PaKKPBxJXjx9nW
         EocxLbbyun+qcgPLaKQDpsu/aJwNnvP47ntZQnh2vfdeiWzb/HaXoCN3xaHfzWigE/
         xdHUPbov5pKSw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230120133010.299797-1-krzysztof.kozlowski@linaro.org>
References: <20230120133010.299797-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] regulator: dt-bindings: fixed-regulator: allow gpios
 property
Message-Id: <167423254806.1373484.8432300435483887839.b4-ty@kernel.org>
Date:   Fri, 20 Jan 2023 16:35:48 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-77e06
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2023 14:30:10 +0100, Krzysztof Kozlowski wrote:
> 'gpios' is in general preferred even for single GPIO specifiers and
> there are DTS boards using it (exynos4412-p4note.dtsi), so allow both
> versions.
> 
> 

Applied to

   broonie/regulator.git for-next

Thanks!

[1/1] regulator: dt-bindings: fixed-regulator: allow gpios property
      commit: 12df2c182ccb850988d2680a422211a812fb5cb2

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

