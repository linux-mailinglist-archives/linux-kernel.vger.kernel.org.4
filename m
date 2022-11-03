Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC116183E0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbiKCQMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiKCQMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:12:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D31C7B;
        Thu,  3 Nov 2022 09:12:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A266B82930;
        Thu,  3 Nov 2022 16:12:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65ABEC433C1;
        Thu,  3 Nov 2022 16:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667491946;
        bh=rxJ+PEuX4lEDxQLdMP5WnH8IwPUpq7Xc+dBWHGFGPoo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YC0IJl6Kz+an28MXCqym+l2SQHVzJZ8Fonizg2bqJ0/0YzcAKZ2BYFgZ3VRA1NWKq
         INQTFPEauhFCx79o/y6Cf8g59EeWsc6VykrbiNWlESu7JjtljKWvaS+mA6KzldSUkN
         t3glByYfEETLGdLxH5FJiHaECJeHqLQJcg3UKkeZ8uIBPtRN7ZeRPszCUMszOdgiYP
         MNSF4dmKIyg9bSfGfl14mSvLn0rDIwlmUG4c4s/fRc3vgdcAxxYP6/oKSBhsvVB5sg
         kqYgh7WGzgHxkI2adwUG1PrL5a3B9PWIlaQAsDY/GYUUgDPVK9nxVVUahh/2a3lO+L
         Igv0FqX0oQ6uA==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Zev Weiss <zev@bewilderbeest.net>, devicetree@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <20221031233704.22575-1-zev@bewilderbeest.net>
References: <20221031233704.22575-1-zev@bewilderbeest.net>
Subject: Re: [PATCH v2 0/3] regulator: Add DT support for regulator-output connectors
Message-Id: <166749194409.389017.2951606632954136901.b4-ty@kernel.org>
Date:   Thu, 03 Nov 2022 16:12:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Oct 2022 16:37:01 -0700, Zev Weiss wrote:
> This is v2 of my recent series adding support for userspace-controlled
> regulator-supplied power outputs [2].  This is an important feature
> for some kinds of BMC (baseboard management controller) systems where
> the BMC provides an operator with manual control of a set of DC power
> outputs.
> 
> As in a broadly similar patchset that was recently almost merged [0],
> this takes the approach of providing support by extending the existing
> userspace-consumer regulator driver.  A couple questions about the
> userspace-consumer driver came up along the way, however.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] regulator: devres: Add devm_regulator_bulk_get_exclusive()
      commit: fd1845069711cdf1b1aaaa0f22311b7736396331
[2/3] dt-bindings: regulator: Add regulator-output binding
      commit: 14b8ad4c2580231fc45c2313ef822a15bb12f63f
[3/3] regulator: userspace-consumer: Handle regulator-output DT nodes
      commit: 5c51d4afcf3fd36159713556402e16cfab794ae9

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
