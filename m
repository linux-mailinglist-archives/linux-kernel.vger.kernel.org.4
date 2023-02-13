Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18125694C43
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjBMQSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjBMQSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:18:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1DF72B1;
        Mon, 13 Feb 2023 08:18:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84C4EB81601;
        Mon, 13 Feb 2023 16:18:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9130C433D2;
        Mon, 13 Feb 2023 16:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676305121;
        bh=jTHm/4ykwEJ9eDqHDCB2uHcKXEGZgh285sd6r6Jztq4=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=X58wAKg88Hma4ARlnmkcyNvFHTWSaJTuMAh8/AY0nzXznGtDhS20ws2Q/1Mqn0KxY
         ANgnl6UZ5Z1FXP6PNu6244hRGRb2zkwI9ezlxu2DIhB3jAypgBzboPO9kl6lQLKYNQ
         BHB2hG9omkOk6YDSmbsYqAiI6bZOzGidm/s3Y6fhbx3rj5DnNG0MnYrbaSl8BOhk+G
         tHPwLG3nqxecULze/Zw4QzGF0hx5i5pNOBpfVusj6v4KkrDhIMKGCr5CGdVXwR+QUw
         RA5KzNqrnnv+X0Zd4TRPaeRS0MY/CJK7xH3ErkadJ/LdnhtW9KXwBm0whDnO5n1x/V
         RNCLJOBnfacTw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230211134755.86061-1-krzysztof.kozlowski@linaro.org>
References: <20230211134755.86061-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: dt-bindings: maxim,max98095: Convert to dtschema
Message-Id: <167630511939.2770751.18419134199965979310.b4-ty@kernel.org>
Date:   Mon, 13 Feb 2023 16:18:39 +0000
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

On Sat, 11 Feb 2023 14:47:55 +0100, Krzysztof Kozlowski wrote:
> Convert the Maxim Integrated MAX98095 audio codec bindings to DT schema.
> Add missing sound-dai-cells during conversion.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: maxim,max98095: Convert to dtschema
      commit: 46f5c98e158449a1ddbf9b22e046810184c92d43

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

