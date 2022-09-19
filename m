Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387185BD7E1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 01:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiISXLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 19:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiISXKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 19:10:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FDD25E8D;
        Mon, 19 Sep 2022 16:10:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1369B821D1;
        Mon, 19 Sep 2022 23:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13111C433D6;
        Mon, 19 Sep 2022 23:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663629029;
        bh=LDsKxnhbQrE/ZqXth8SExE7uHfC+ker6gidpn7m6tdk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=uSYOA+wPCMHEmFG1c8Twijc7L11gTw+AjncUz9pieSr1usTpz9AzWvHUXRoXKdfQI
         EihOvbmiHN+gPoYVn+Q9uD4jsBbR+fJT47Hw9PFe+Pm3BZ6eneiirvrwOmv3hVjilK
         Oz5vn/jUHAang5JQfNunoc9kTepfKDY2Ux7Ri2YgHg347z8ddWvR7/fyzW68wpnpvp
         nYwnFocZStbzryxP+K82FpKzyAKgF0OL3ngL7H7Y/oH9JDIidSNbTsYJj43qE1Ylis
         WWfGNHe1ha8mxAWgz1BChMzPeAht6vXLJV4tuICE4meS1o4wRmpuxeaL4AyUMW8LB6
         oiR1Seigm0jlQ==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, tiwai@suse.com, bgoswami@quicinc.com,
        perex@perex.cz, linux-arm-msm@vger.kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, krzysztof.kozlowski+dt@linaro.org
In-Reply-To: <20220916132427.1845-1-srinivas.kandagatla@linaro.org>
References: <20220916132427.1845-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v5 0/5] ASoC: qcom: add support for sc8280xp machine
Message-Id: <166362902680.3419825.7703076569523626210.b4-ty@kernel.org>
Date:   Tue, 20 Sep 2022 00:10:26 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-8af31
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Sep 2022 14:24:22 +0100, Srinivas Kandagatla wrote:
> This patchset adds support for SC8280XP SoC machine driver.
> 
> First patch moves some of the commonly used code to common from sm8250 machine driver
> and the follow on code adds minimal support for sc8280xp.
> 
> Currently this driver is only tested with SmartSpeakers and Headset
> on Lenovo Thinkpad X13s.
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/5] ASoC: qcom: common: use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL
      commit: a25f4e2cdd5d64408b0fa56115ebebd8cc5cb6c0
[2/5] ASoC: dt-bindings: qcom: sort compatible strings
      commit: e4f10cc23cefe16ed69987cb2648f5111e6eacb4
[3/5] ASoC: dt-bindings: qcom,sm8250: add compatibles for sm8450 and sm8250
      commit: f19097cc5adfd29bf2aecd8e0137331fab36946b
[4/5] ASoC: qcom: sm8250: move some code to common
      commit: 3bd975f3ae0a245e4b851c2b0c97b0a71e5359d6
[5/5] ASoC: qcom: add machine driver for sc8280xp
      commit: 295aeea6646ad6cf26c24f5c493ddb60b8f5a0f4

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
