Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7A36BEE9E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 17:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjCQQlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 12:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjCQQkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:40:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B235A6CD;
        Fri, 17 Mar 2023 09:40:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34BDD60C7F;
        Fri, 17 Mar 2023 16:40:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9820C4339C;
        Fri, 17 Mar 2023 16:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679071244;
        bh=Pfx1OfplKXtSZ7oy2GQi8FZJpWIVZujUx3snzJWO+HY=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=SwqzyT+9mL3loVh0nPKiufOKPHJmshnp7tQL45K8kmh7/R6YgmTaLKHKi5+Qlf1QS
         R/QDHJSbOmdco385Q6LnNYcxwA6sFTmOygDSiXBKUPnZmewMtGB8VlQHgnaWRD5jj2
         60ECubpEaNIDt/nCqLtzrbcIkt6aeJwqseaHeHUrrHCJatDJtd7weW7lAzstMs3KeA
         wFTJ6YmqWc+4Y0e2IFsfHK2E9JFwaaPvp4CK5sNkKI4x7VJNRnj09fNeCMazaTtFFa
         e+t31ZgW61kvLfdObkR0EA+N283ZEKZzOlpup6qR8Nh6lBkcLvj2E7tzX7DKB/nOC2
         j6oMWP2KrM8og==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vijaya Anand <sunrockers8@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230317092900.16770-1-krzysztof.kozlowski@linaro.org>
References: <20230317092900.16770-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] ASoC: dt-bindings: adi,adau17x1: fix indentation
 and example
Message-Id: <167907124254.46507.14257812881099935258.b4-ty@kernel.org>
Date:   Fri, 17 Mar 2023 16:40:42 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Mar 2023 10:29:00 +0100, Krzysztof Kozlowski wrote:
> Fix errors in binding indentation and example:
> 
>   adi,adau17x1.yaml:8:2: [warning] wrong indentation: expected 2 but found 1 (indentation)
>   adi,adau17x1.example.dts:29.3-30.1 syntax error
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: adi,adau17x1: fix indentation and example
      commit: b36bf721578bfe8229c1d7f2fcd0bd021cc8b2f4

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

