Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517625B42AF
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 00:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiIIW5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 18:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiIIW5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 18:57:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70642F16D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 15:57:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B86162109
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 22:57:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6055BC433C1;
        Fri,  9 Sep 2022 22:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662764220;
        bh=D7LR6k5R4/eW1eEyJm5gBaN50zfTXQgjgX+zG82s6Rs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SBXqY3sPVyUWeqVWUOEt9MC+QvySfOKYXTsxd9MtCmgZl4niFXZ7pTE99E6LzadoJ
         1ClS/NQOKzMEOmXwtoHedB9P7NNV/sCM1ik6h25ULqLbGeqbn0Tgd8WjYf1YmYnOPc
         ONppxYKxxOmWJcL5c3OOsvSCQGlG/wRjOhjeud+eptDTsfN9764q0GOBJWQK0RPSvG
         ZVQeT2Tg/tQOhXMcn5QavjvJVnxY68zALRVifGmJTJMZTpxLN+36s5h6IGOJXrGplw
         Dw2LnQEHgKn8jTbLjs4BoONeKUetIsYPr7JEZFvH+4cOofTkpafyYzmNDojiPUAATK
         4NSmRog5ugJ/A==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     linux-kernel@vger.kernel.org, Jerome Neanne <jneanne@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20220828120153.1512508-1-axel.lin@ingics.com>
References: <20220828120153.1512508-1-axel.lin@ingics.com>
Subject: Re: [RFT] [PATCH] regulator: tps65219: Fix .bypass_val_on setting
Message-Id: <166276421911.339577.1528725955840823989.b4-ty@kernel.org>
Date:   Fri, 09 Sep 2022 23:56:59 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Aug 2022 20:01:53 +0800, Axel Lin wrote:
> The .bypass_val_on setting does not match the .bypass_mask setting, so the
> .bypass_mask bit will never get set.  Fix it by removing .bypass_val_on
> setting, the regulator_set_bypass_regmap and regulator_get_bypass_regmap
> helpers will use rdev->desc->bypass_mask as val_on if the val_on is 0.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: tps65219: Fix .bypass_val_on setting
      commit: 69a673c9e54d952cf404f80169d3100b7a9645bb

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
