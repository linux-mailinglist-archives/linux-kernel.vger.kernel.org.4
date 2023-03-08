Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0E06B09FF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjCHNxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjCHNxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:53:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945914C6F3;
        Wed,  8 Mar 2023 05:53:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17E26B81CE5;
        Wed,  8 Mar 2023 13:53:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A86C4339B;
        Wed,  8 Mar 2023 13:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678283584;
        bh=z6Fl1IZWcy0KRIvlPtXRkINhMxXIEpmPhQork/dwI7o=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=KrSLM8/PvZvSU1n/mv6jFpQS9K/SJmnvHaHdNiunwWuFgzyJcTLms0X013zKKsdBu
         kxJPfvAmEPgXos1p4UTT4kru4dVakOD49+2RgYEySYdSfMm0pKNITskxwBEw6OeIdq
         IYCZpNfaVsFwbpGgEavFc8QVCTvcvW8bLbIvzLm2eYdX68jh724CBLL3DsbtE2Bi48
         lL3FCfXOfyg9+ebMP7B/lzKTqbxmeMzYFF8TQJG8y3RxhHaoJCtwAYgkQu8VMA6fWI
         W3rWg4oIDf29JHEayMw9yHYZienmAUDP6CkdlXbAzqDHWhYhMlC95xu3pC9EsoZ1wG
         /QaZNJpTXXsvQ==
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        cy_huang@richtek.com
Cc:     lgirdwood@gmail.com, u0084500@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <1678063358-18128-1-git-send-email-cy_huang@richtek.com>
References: <1678063358-18128-1-git-send-email-cy_huang@richtek.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: regulator: Add Richtek RT5739
Message-Id: <167828358298.32113.17014444602601238459.b4-ty@kernel.org>
Date:   Wed, 08 Mar 2023 13:53:02 +0000
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

On Mon, 06 Mar 2023 08:42:37 +0800, cy_huang@richtek.com wrote:
> Add the binding document for Richtek RT5739.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] dt-bindings: regulator: Add Richtek RT5739
      commit: 2e238605a9d631fc8b9b130ba79cd54f2a22df10
[2/2] regulator: Add support for Richtek RT5739 voltage regulator
      commit: 4536f3b93a3373cac21911103cbaa8c4c2932c38

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

