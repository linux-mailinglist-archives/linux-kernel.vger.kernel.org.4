Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927E867C1A5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 01:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236341AbjAZA3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 19:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236345AbjAZA3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 19:29:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE7664D91;
        Wed, 25 Jan 2023 16:29:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB59B616EF;
        Thu, 26 Jan 2023 00:29:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893E0C433D2;
        Thu, 26 Jan 2023 00:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674692954;
        bh=U/RjiAM4uG/wh8EGg1npYK86Uc6lL2JtiVq3YnbKfmo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MhXO1LwBwA7mmsgVGrVArhpmQ/3+dsDoiWTsi8kGUBu0hBe8tg7N2gbpE8DyouV30
         UFMaLigzh9TjTyhq2lZB9uzh6dvdUkzm+xyM76EPDB/NKLJtqQ0WmRGO1emifbHRUa
         hpLxqCPbQGmqaOqM/LUtQ8igi09O7BCu393aRGFUAFjoCYOCeYRU9BC27hk09/uj8g
         VelpShBhRO4SKsH6NbWnXSypLCpW76pmk8aewdLEZOsuHSg+HPGJqnr3fx2yQByTST
         MI5tFo8SyEWgPYy2AG60piAHq6n0WUrT5hBS74QER/42pMC0d3kSvwz4pNSQ24tf4O
         KNVA+6AeQbMsQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     marijn.suijten@somainline.org, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20230118181810.119922-1-konrad.dybcio@linaro.org>
References: <20230118181810.119922-1-konrad.dybcio@linaro.org>
Subject: Re: [PATCH v2] regulator: dt-bindings: qcom-labibb: Allow
 regulator-common properties
Message-Id: <167469295122.2698045.16881835440025059289.b4-ty@kernel.org>
Date:   Thu, 26 Jan 2023 00:29:11 +0000
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

On Wed, 18 Jan 2023 19:18:10 +0100, Konrad Dybcio wrote:
> Allow regulator-common properties on lab/ibb regulators, such as
> regulator-always-on, etc.
> 
> 

Applied to

   broonie/regulator.git for-next

Thanks!

[1/1] regulator: dt-bindings: qcom-labibb: Allow regulator-common properties
      commit: 8966a72c1964f74e5a415fee8629f698ccb13342

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

