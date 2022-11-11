Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AA8625E8C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbiKKPmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbiKKPm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:42:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCE256EC0;
        Fri, 11 Nov 2022 07:42:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D65EAB82620;
        Fri, 11 Nov 2022 15:42:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA1AC433D7;
        Fri, 11 Nov 2022 15:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668181345;
        bh=GXXc/YkrgyCittXoI3dzyMhfx9G+SEtZA29qawbDu0Q=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=g42q1yfLeWX1aElcDEgHpy2fn6ocZm39/ztrtJ9/y+GN5lTLkgSAglFXN4ps/AWMp
         WoE0ea9O8L8UeE/wFNdkUZJVkuoC6Oe0YtdQPU6HKdmjC1I/e3ykbLUN8q9P25gCYe
         nhz9TAK6tAziLyLJ4/U6G9X1noX9NOL6tDgTWbE++OpxTcpsX0G49z4HPw4WQPBeUl
         50GNBmxjovMovEVwYMgVzQ3vmdNTyNb22hTFyTJ+uRUbQpVeYBxzqTHcch9r2d0H+4
         EZZvvTKGjpn46ndysZHwDiVOnsjsVsGyWBgBmTOHh7KSXRRA4gs1lIN3rdxFizERbF
         UT2W6Fq2VDWEg==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>
In-Reply-To: <20221103195341.174972-1-krzysztof.kozlowski@linaro.org>
References: <20221103195341.174972-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: qcom,lpass: do not hard-code clock-output-names
Message-Id: <166818134230.428331.5344875121746787370.b4-ty@kernel.org>
Date:   Fri, 11 Nov 2022 15:42:22 +0000
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

On Thu, 3 Nov 2022 15:53:39 -0400, Krzysztof Kozlowski wrote:
> The purpose of clock-output-names is to customize desired clock name,
> not use one, same name.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: qcom,lpass: do not hard-code clock-output-names
      commit: bcdc73e167b68cb494977cdb2b92f05ab6455fc2
[2/2] ASoC: codecs: lpass-wsa-macro: parse clock-output-names
      commit: 9f63869a5682d5fa9bc5563577fe3270e7cbf4f2

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
