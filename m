Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9AE66305F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbjAITa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjAITau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:30:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA7F4567F;
        Mon,  9 Jan 2023 11:30:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDFEFB80F99;
        Mon,  9 Jan 2023 19:30:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A82C433D2;
        Mon,  9 Jan 2023 19:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673292646;
        bh=D9h+LJE2T8SlbPty+fmHmTuaXHKl3hmksa7N6tUAx+E=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=kT5uNYV7Pts0HhI97BaftP14ZsQvh99iw1FkNIWveZIWCpbVgMvKA6qTKbjlLTTVR
         RiC1DqdTPSG64NJ1FB50/CM99KzG9hYXdyWXRoJKShSeSZiwIig42xWUt+mP97vKqs
         XWitwyiPWOE/XiwIp8t08uo9CKlm6wrAwgON8oub/bRsYJTtAHM2Oh46l/4Mdb0yHH
         TXtG21dV8HVIV8yfbx2ZJbHCsqHRxqTemHnURyZHsz3KdjA1qEQrnD34upxvVxd4q9
         QKQwDtskJQ+aFGkL15zxgkbW8ax+Fx/LVF5ePElrfGn77nDLWu+jzTY08yQeqE0XS9
         V3K+Ve8YwLUrQ==
From:   Mark Brown <broonie@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
In-Reply-To: <20221005-mdm9615-pinctrl-yaml-v6-1-6c913908bb85@linaro.org>
References: <20221005-mdm9615-pinctrl-yaml-v6-1-6c913908bb85@linaro.org>
Subject: Re: [PATCH v6] dt-bindings: regulators: convert non-smd RPM
 Regulators bindings to dt-schema
Message-Id: <167329264402.368499.13674722738160556788.b4-ty@kernel.org>
Date:   Mon, 09 Jan 2023 19:30:44 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-8b3d1
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Jan 2023 11:47:42 +0100, Neil Armstrong wrote:
> Convert the non-SMD Regulators bindings to dt-schema, the old text based
> bindings will be deleted later since the RPM bindings are not yet converted.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] dt-bindings: regulators: convert non-smd RPM Regulators bindings to dt-schema
      commit: fde0e25b71a90e798ce9a58525d5630c90f5aa27

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
