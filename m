Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72011637882
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiKXMF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiKXMFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:05:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DBD1CB22;
        Thu, 24 Nov 2022 04:04:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DD69620F6;
        Thu, 24 Nov 2022 12:03:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA79C433D6;
        Thu, 24 Nov 2022 12:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669291434;
        bh=qNZnjGHtGYW9pPQzs/B7JclTgfPdNAJ786KvxxzKN3c=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YrlQbqOAf42JMLcJWWIVy5ymygMwlrtxR4kSMMF9yFf8J3HA/iLxUs+W2pzimm3nT
         L2a4cDcawMTl5pFj9suJfUad29lzrC0sK2aRXHjXXUmIPwWs1xjn2tEcmj9dJq6Z9+
         SFjhQnweyCD1cvtavDbX7tZdA8aj1LQ0a5isjNmSnKv24h1OCtQByP3oQIKGZtqh52
         0d6MW3zbjY5vjEbUBEDHUG4VSEE99deq4Em7TUPuGeF+Iu7K5fHVU4/m9EntAdMNHJ
         QkXjFxM+BZFGh6VCWqZZybj9XCVZigI9+2HopNZVaNv99Y/m2SUb6TC2Db/CCT4j0N
         rqU+yBhFT4Xpw==
From:   Mark Brown <broonie@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20221123153638.721254-1-abel.vesa@linaro.org>
References: <20221123153638.721254-1-abel.vesa@linaro.org>
Subject: Re: [PATCH v2 0/2] regulator: qcom-rpmh: Add support for PM8550
Message-Id: <166929143255.146433.17935978441581244094.b4-ty@kernel.org>
Date:   Thu, 24 Nov 2022 12:03:52 +0000
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

On Wed, 23 Nov 2022 17:36:36 +0200, Abel Vesa wrote:
> This patchset adds regulator support for the new Qualcomm PM8550 PMIC.
> 
> To: Andy Gross <agross@kernel.org>
> To: Bjorn Andersson <andersson@kernel.org>
> To: Konrad Dybcio <konrad.dybcio@linaro.org>
> To: Liam Girdwood <lgirdwood@gmail.com>
> To: Mark Brown <broonie@kernel.org>
> To: Rob Herring <robh+dt@kernel.org>
> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: dt-bindings: qcom,rpmh: Add compatible for PM8550
      commit: 0a60d098261dfdf2d7e892ab1faf935fea612826
[2/2] regulator: qcom-rpmh: Add support for PM8550 regulators
      commit: e6e3776d682d7f06e1a49be0d2a95dc6456f8be2

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
