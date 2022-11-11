Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC68626083
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 18:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbiKKRek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 12:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbiKKRe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 12:34:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57683657E5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 09:34:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0B2662069
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 17:34:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47F1C433B5;
        Fri, 11 Nov 2022 17:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668188064;
        bh=jYqvc4WZF2KKKlUH6NAcF4EXpjN8klTXDKeZlY8Otow=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=QZ1UPMX/ria1/J65MPLUQqYQokPOpFzcAo2i8BmnXzhxk8TjPUG0AHxR4EHC4aZmX
         8SOFFTyG6AwOVRUoTUQC4N1mnXVoEXrBIBxYXXCPVgVTf+KF7ULMO6nu9aljMrJvcJ
         rYjM43jC9oEIVph/YkUALeta7WtlICvtsESJxU8Tite+VhoquLHUtouIi5+lCq7IEa
         mnpol2yMSda6PUgVLWhTF/r6b4w9zuDS4T6ASd54Uq8Ismcc3RjOn5xNysvg7OM27S
         fVmU6mvQQbYkuMbKWCzaM+EfCwG8SxIQ0lFWiHUw5ueELQwA9eH2crvx4pbGWb9HwR
         hciy8e2Rjw0qg==
From:   Mark Brown <broonie@kernel.org>
To:     Banajit Goswami <bgoswami@quicinc.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20221111091328.31549-1-krzysztof.kozlowski@linaro.org>
References: <20221111091328.31549-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: qcom: q6prm: Correct module description
Message-Id: <166818806245.535544.12168721706069566351.b4-ty@kernel.org>
Date:   Fri, 11 Nov 2022 17:34:22 +0000
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

On Fri, 11 Nov 2022 10:13:28 +0100, Krzysztof Kozlowski wrote:
> The description was copied from APM driver.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: q6prm: Correct module description
      commit: e045595be3c1548e1164f3d402cef990425b6195

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
