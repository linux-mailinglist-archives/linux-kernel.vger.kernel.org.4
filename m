Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB80730062
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245117AbjFNNrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245104AbjFNNrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:47:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3816E180;
        Wed, 14 Jun 2023 06:47:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCDEE63FCE;
        Wed, 14 Jun 2023 13:47:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80DD1C433C8;
        Wed, 14 Jun 2023 13:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686750457;
        bh=p/0VE/rByCIyvGAL4zC37aNdWZD6WdRSZcHy56kY3M0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=O9qDYGflnqx/TygYKkvzkqHZfn65jqamRxhTQSp9tSNd5pSPwygQaJr1t5rL4dEEL
         76+q2plxIlFjh0T/IwRNh2MninYJQm8kdHyR6ypFTl1fpXr9dYPkia4qPk/ZfIILoQ
         ArT/iaoOoyC7GuWMJTjsXWCmsC0w89sGSC/yE8iXws2sH80B+CwBbt33BFxCUIPhCF
         idsGrbAGu85MLBKF5cIvQlUdWIWKmxzZ2gRL8yIA0LPkdsjxpsDZ08mtTU1q6qm8D3
         ebBkwz0Jwz0JenOiGrDdvcFtDEjCZVj/y8JVEmts4A040A42PF6H4M4daRhi+Sk1UQ
         vzBIWlMhhvjNA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jai Luthra <j-luthra@ti.com>, Rob Herring <robh@kernel.org>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230613201006.2822985-1-robh@kernel.org>
References: <20230613201006.2822985-1-robh@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: ti,tlv320aic3x: Add missing type
 for "gpio-reset"
Message-Id: <168675045523.162323.250624917490081736.b4-ty@kernel.org>
Date:   Wed, 14 Jun 2023 14:47:35 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2023 14:10:05 -0600, Rob Herring wrote:
> "gpio-reset" may be deprecated, but it still needs a type.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: ti,tlv320aic3x: Add missing type for "gpio-reset"
      commit: a3f6df1bf514516d276e90d38ca11581701f2e8e

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

