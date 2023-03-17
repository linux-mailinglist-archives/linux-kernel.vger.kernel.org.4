Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29AB6BEEA0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 17:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjCQQlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 12:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjCQQkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:40:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673A05A6CD;
        Fri, 17 Mar 2023 09:40:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20350B824F7;
        Fri, 17 Mar 2023 16:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1988AC433EF;
        Fri, 17 Mar 2023 16:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679071249;
        bh=lCxa2338SgBPuW+ok1w/jwS3okMbVkrZTlxCoSWBWcs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jMWZT1CWhPxQJXBMCg0qFk/uicDJWyPZpGQgSa3aQdwczpLSEZrA/YzPIb7sYCo1d
         qMq/rTexyCmYkm1DUVzs91yKDR3uDRZnlgScUxJBq2NZ2Fd7rZ937AZwybvbn3+SPk
         8pBfPqffZRdguiX8LTMMePOB6IBnL2Fj5PEVH87bXXm8ZOr6+bDO9Ro9m+uYOKEo6/
         haLHIJ0MuqKyjj1+/waPEP9DmVw/uOzYux+L7+UwOlxkSS/Jd+4RRUeZ9L9P8kHJSw
         kjEaX5pQ9rBe9XVX2UjkOMNZXGp8xyXq1DZItZ3h8WeIKCaeqbJoZ+fVYfIAdVhmYh
         hClcN3vxqwBDQ==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
In-Reply-To: <20230317082137.12629-1-krzysztof.kozlowski@linaro.org>
References: <20230317082137.12629-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: dt-bindings: renesas: rsnd: correct comments
 syntax
Message-Id: <167907124782.46507.1842486955927522063.b4-ty@kernel.org>
Date:   Fri, 17 Mar 2023 16:40:47 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Mar 2023 09:21:37 +0100, Krzysztof Kozlowski wrote:
> yamllint expect space after '#' comment mark:
> 
>   renesas,rsnd.yaml:282:4: [error] missing starting space in comment (comments)
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: renesas: rsnd: correct comments syntax
      commit: 47df94faa5e3775510177cdc0909e397300cc791

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

