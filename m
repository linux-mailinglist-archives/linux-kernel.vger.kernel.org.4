Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BC267C19D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 01:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236215AbjAZA3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 19:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbjAZA3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 19:29:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E971EFC9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 16:28:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D443BB81C04
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 00:28:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81687C433D2;
        Thu, 26 Jan 2023 00:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674692935;
        bh=ugZ8xqRzG/MXWFMK1A6CKCJ9dwczVVYsZvs+Zqi8Mhk=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=jBrnHhCJ6JpOpO89l4637NxJyAix4JxyQkDTe1qcS37nBu3QjluVV1fx8JjRs7o7e
         LAT9sNWMfbh22NXTnjohoTL8Yno8nS8tS6/QXI6qrwsFtTyKQQCylEfABcSu3inmmq
         zj+1P2zoRSFWHZu/aYhRgXBZ4JcfsZPAEUL9SsM2VSJcr5BZfRhCLg5rRmQd447ZXx
         fNCFc00KePZyWwG/RUlFzm1k2MaqVw0B1LO1BayW/hJ8nUY+OdO3bJTcRi9Afz2zEb
         KkPQHfVmLdCuyTf02sep6tRGKpq1ejQrrkqvq9YauPSs9VOV7hlum1YzLBWolK8DAn
         VVGQH89JWYdhg==
From:   Mark Brown <broonie@kernel.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230124163953.345949-1-krzysztof.kozlowski@linaro.org>
References: <20230124163953.345949-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/3] ASoC: codecs: constify static sdw_slave_ops struct
Message-Id: <167469293316.2696228.10033245530806500019.b4-ty@kernel.org>
Date:   Thu, 26 Jan 2023 00:28:53 +0000
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

On Tue, 24 Jan 2023 17:39:51 +0100, Krzysztof Kozlowski wrote:
> The struct sdw_slave_ops is not modified and sdw_driver takes pointer to
> const, so make it a const for code safety.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/3] ASoC: codecs: constify static sdw_slave_ops struct
      commit: 65b7b869da9bd3bd0b9fa60e6fe557bfbc0a75e8
[2/3] ASoC: codecs: constify static sdw_port_config struct
      commit: 57dc05c4e6faaab5d8e7fb631f285120d7ed4b07
[3/3] ASoC: codecs: wsa88xx: remove unneeded includes
      commit: 27681129b089d9a5d597a05f6e1821eb6d82919b

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

