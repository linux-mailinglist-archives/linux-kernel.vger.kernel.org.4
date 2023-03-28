Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4F96CC721
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbjC1Pwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbjC1Pwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:52:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7056EB748;
        Tue, 28 Mar 2023 08:52:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1C66B81D84;
        Tue, 28 Mar 2023 15:52:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BC4C433EF;
        Tue, 28 Mar 2023 15:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680018753;
        bh=oaYXnYL3k5XJ7rcl8FZ3ZRhC7UK60jVE0lVqu7yuxPI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=lzlB1yd8ToUWC1DJLIyxqyC++6UWnFPRdmWibwXxAf6giHUgYjPZrrMoDytU9ZJNR
         aeTkBapH5qM6SIBPbDd7t2q8xg0JYTwcihz+/55SDmd5fR4NduYr6mpySR68hRC2Td
         rqTVRry8S/Om07+WMri7n5iqSfwCpSCXYZbLuROgbxGD2qtZq31cbfyrAOfuTK3mOh
         DRtAf2owPyrJFG7zHSWlUQBYsV/AVGUtfbeQqU87iH7b0PkrfzEqGWsOsyywZS+KdY
         dpzsZcs6Od7kSOjTeKnmUi7BwFLtunf4fUj4qY82RBJyIKoNjj2GYevouDk99nEAVY
         q2+JMBrs5zwAA==
From:   Mark Brown <broonie@kernel.org>
To:     jagan@amarulasolutions.com, lgirdwood@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        troy.kisky@boundarydevices.com,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
In-Reply-To: <20230328060032.1983381-1-peng.fan@oss.nxp.com>
References: <20230328060032.1983381-1-peng.fan@oss.nxp.com>
Subject: Re: [PATCH] dt-bindings: regulator: pf8x00: Remove restrictions
 for regulator-name
Message-Id: <168001875147.43736.11643500553079057410.b4-ty@kernel.org>
Date:   Tue, 28 Mar 2023 16:52:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2023 14:00:32 +0800, Peng Fan (OSS) wrote:
> Following commit b0de7fa706506
> ("regulator: pca9450: Remove restrictions for regulator-name") to remove
> the constraints on the regulator-name to allow using arbitrary and
> descriptive names for the regulators.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] dt-bindings: regulator: pf8x00: Remove restrictions for regulator-name
      commit: 9aa5ef3da6742bb2228308e738c22b49efa6efcc

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

