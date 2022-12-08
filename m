Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDB964705D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 14:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiLHNCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 08:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiLHNCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 08:02:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C40631F;
        Thu,  8 Dec 2022 05:02:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 377ADB823B2;
        Thu,  8 Dec 2022 13:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D752EC433C1;
        Thu,  8 Dec 2022 13:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670504553;
        bh=HF/CT0qe8YpFOKtPjeRHyYkiJf0CwH4GR79yo9n3q3U=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jH5e6c8f849b8XDNRljqZMzdQjJUarDYzIfv9F1yBeld8zD/0aRo/sJfPTnt7sV1A
         vihQJrDaeqAPCkSJEF3929KEVyVZLcRjaBgwft+3zvWH4dDLeRqmPvzakPZplUV29o
         QxLJZi2q8QIbw9Jk9zIm4j66lufJD2HGxZOjyQVqTYai9ze8Ze/E8ogATA10bokRYA
         7rSZF0lvpNacNjOGYJS4um3efdxrADYZrIveP00ieN2znQddVIuHDZMWg0cD2VMMqE
         Vdi2h6NQVYLcpT7bmZelyOsBD70dDzcjgBDA9Z3HZtG0hwZ2qG6esrqJcfJVXpBHrw
         rilDxPN/YI3Aw==
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Gene Chen <gene_chen@richtek.com>,
        Daniel Mack <zonque@gmail.com>, Rob Herring <robh@kernel.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
In-Reply-To: <20221206211554.92005-1-robh@kernel.org>
References: <20221206211554.92005-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: Add missing 'unevaluatedProperties' to
 regulator nodes
Message-Id: <167050455059.159009.6147291983377925638.b4-ty@kernel.org>
Date:   Thu, 08 Dec 2022 13:02:30 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-b77ec
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Dec 2022 15:15:55 -0600, Rob Herring wrote:
> Several regulator schemas are missing 'unevaluatedProperties' constraint
> which means any extra properties are allowed. Upon adding the
> constraint, there's numerous warnings from using the deprecated
> 'regulator-compatible' property. Remove the usage as examples shouldn't
> be using long since deprecated properties.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] dt-bindings: Add missing 'unevaluatedProperties' to regulator nodes
      commit: 2a17ddfdca25ac4cbb0d317362608ec32f98fd82

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
