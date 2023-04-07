Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2616DB529
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 22:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjDGUYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 16:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjDGUYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 16:24:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCB261AC;
        Fri,  7 Apr 2023 13:24:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B642612D1;
        Fri,  7 Apr 2023 20:24:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0C9C433D2;
        Fri,  7 Apr 2023 20:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680899068;
        bh=9FClfZXbfwUUxo9TcUwkqtTlpUt1FbxWRUTVWlO/69Q=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=B2Q37Wjv8ILlngp3WFgVVGeICs02Ied7FnifoxQYKAhMiy2A5C/MM9qeCE9JDrvBK
         vmAfwLFl8oOWftgvIcFbyjz3zQBenFcwYVNLG4BUuNnMCLXYIdJIpRSziCz4gFGR0G
         enLqpdAmwhy9oQ7ReWeKSxb/C+OtlPOJ7Icca68G9nfOCDqUiVyY3I9mhZ+DFKXtls
         jsji2YM4Sw6xgqMMGTWvEyy+wb7dcJFqN7PKr6yhxrFMXxPGzovgOLxrk/HBo4cplt
         qXcPB/GvkwiZSQQ42p+3l55kTWa6Qspw5YhKC4IhRAxSFoMYBhvnMPLsPebtbWor0b
         A8U9d+LTrr7og==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Saalim Quadri <danascape@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>
In-Reply-To: <20230407170032.102412-1-krzysztof.kozlowski@linaro.org>
References: <20230407170032.102412-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: dt-bindings: asahi-kasei,ak4458: fix missing
 quotes around hash
Message-Id: <168089906578.185708.11115149871475015227.b4-ty@kernel.org>
Date:   Fri, 07 Apr 2023 21:24:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-2eb1a
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Apr 2023 19:00:32 +0200, Krzysztof Kozlowski wrote:
> The yamllint expect comments to start with hash and space ('# '), so
> quote the description to fix:
> 
>   asahi-kasei,ak4458.yaml:40:30: [error] missing starting space in comment (comments)
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: asahi-kasei,ak4458: fix missing quotes around hash
      commit: be5418dfc1460e82a005dfb9dd76e4ef846c203d

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

