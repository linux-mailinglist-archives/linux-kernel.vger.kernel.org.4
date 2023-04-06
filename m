Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1206DA4B0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 23:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjDFVbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 17:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbjDFVbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:31:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8AF977F;
        Thu,  6 Apr 2023 14:31:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8377064B73;
        Thu,  6 Apr 2023 21:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B473CC433EF;
        Thu,  6 Apr 2023 21:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680816663;
        bh=jo/kNXgU9Ka5Ghg8YOyzyFth7IbB7LLr68pBOvSHhLk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UyCvrLo2QqxcfY3lpx6SkZE2r9RpBcHiAUL84yInLaQelwepevl7eXCypyyLo9nrJ
         sv4HOeK7Aiw0L8S26BF1jlji7wW0uf1iAw4krtUUgH3wNVJH9aZTChNXQyqOMlodRr
         ORRFD3Rrf9sDmXWQ5jZJxJ+/VcnlcAmMOspO0bOBuWDV88phBhFHpsSxZmH3Qi8uND
         oCtMLsuEHc3bDAVnR8DEgyHAlHPlxZJ6CMPHamxHllInoGHG0lu6ZFlEKr0TsgbeXV
         RBrKeqCBU48UacnapM8XL/bTfdmn318pS7e0NN9DWG7MkwKvC2YJAjyVPVlX9om4zm
         PjYuDZTeadXKg==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Joseph Chen <chenjh@rock-chips.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@collabora.com
In-Reply-To: <20230406171806.948290-1-cristian.ciocaltea@collabora.com>
References: <20230406171806.948290-1-cristian.ciocaltea@collabora.com>
Subject: Re: (subset) [PATCH v2 0/8] Add support for Rockchip RK860X
 regulators
Message-Id: <168081666144.315518.8879348580089402745.b4-ty@kernel.org>
Date:   Thu, 06 Apr 2023 22:31:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Apr 2023 20:17:58 +0300, Cristian Ciocaltea wrote:
> This patch series introduces support for the Rockchip RK860X regulators,
> while also providing a few fixes and improvements to the existing fan53555
> driver.
> 
> RK8600/RK8601 are fully compatible with the FAN53555 regulators.
> 
> RK8602/RK8603 are a bit different, having a wider output voltage
> selection range, from 0.5 V to 1.5 V in 6.25 mV steps. They are used
> in the Rock 5B board to power the ARM Cortex-A76 cores and the NPU.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[2/8] regulator: fan53555: Explicitly include bits header
      commit: 4fb9a5060f73627303bc531ceaab1b19d0a24aef
[3/8] regulator: fan53555: Fix wrong TCS_SLEW_MASK
      commit: c5d5b55b3c1a314137a251efc1001dfd435c6242

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

