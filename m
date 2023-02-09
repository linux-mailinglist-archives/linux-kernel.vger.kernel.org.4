Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8529C690DF1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 17:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjBIQHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 11:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjBIQG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 11:06:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D42658CC;
        Thu,  9 Feb 2023 08:06:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D9DB61B29;
        Thu,  9 Feb 2023 16:06:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F961C433EF;
        Thu,  9 Feb 2023 16:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675958795;
        bh=T4VIMR/tzQuwfeVBQ2ksYdSEBgoAycBIAu8jyPAnMKY=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=HzmbNhf7+ikl96209BumKZWyN0sqqK+GyVUB/ep2x87Lf/3s1uexROtJDPHyM/PeC
         UDW5soYdlskeE+XU9X6l1PXQxbxI26nlhzx4ZJWRa3/yHsifQpPlRVy+eBbc+S2flK
         eUWDU4MjS/ru/ZWMJQoNKvFA0SrU/7KQ3YeFtxI4u7j8vBvRaWobJc6ZvLxadP6BJF
         TG8k38GEIW05m9T+C527fEACdD0fzXrWoX/7dVnRuGaSe0k0KsZVs/hG0fVr9gMawg
         kbFXNdZlczm4hmM7WHas7c/Ivx1W1lTSrVw47w31B621NM+MRsfoorbzBS9xiwST0Q
         AuV4yn32lxOkg==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230208160410.371609-1-krzysztof.kozlowski@linaro.org>
References: <20230208160410.371609-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: maxim,max98090: Convert to
 dtschema
Message-Id: <167595879391.443322.9482805543558463715.b4-ty@kernel.org>
Date:   Thu, 09 Feb 2023 16:06:33 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Feb 2023 17:04:09 +0100, Krzysztof Kozlowski wrote:
> Convert the Maxim Integrated MAX98090/MAX98091 audio codecs bindings to
> DT schema.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: maxim,max98090: Convert to dtschema
      commit: 0551ff7cf51abefe7351a8c486e6318196b3b6fe
[2/2] ASoC: codecs: max98090: simplify snd_soc_dai_driver
      commit: 35ff1051b9594b05041eb2444a339345944b3241

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

