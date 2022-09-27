Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5845EC110
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbiI0LVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiI0LUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:20:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A944F6AB
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:20:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FB7CB81B31
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 11:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7816C433D7;
        Tue, 27 Sep 2022 11:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664277621;
        bh=yyoRKDYAu9onR60+95S2nR+oSix9hlQ/RirKeQktxow=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=osdaNwN5ilz/6X8qPJ80wVeeEDaUUFrYqGQHl2qorvfs1Ogw7ARN8De9jfPRsm5bK
         qukyzj1fw1PKh8Oyp3Z9CTQGYpxevEskL7Ry0dhwZdjYn8F6zHFfsW7DvYHx3wMMGj
         pqbFF59GCMDjAXBd2yIe6K92AkIAO889qwav/q5n/DOBXSAuSkX9cdJR5xoEAIJEce
         WckRo2QHSsSAo5Y64+nEkMw5p4JNK/LXNmtRuv7lsVHQjqnHfFcO9asvHllmpGw7J+
         NLBjyKaNbR3sqpXhjppvbLtgGWEdsany9D489Dr/rILJ9i8ta/LFoZvsEcL+EU+1Vw
         TXouF93WS4NCw==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Jerome Neanne <jneanne@baylibre.com>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20220919122353.384171-1-axel.lin@ingics.com>
References: <20220919122353.384171-1-axel.lin@ingics.com>
Subject: Re: [PATCH] regulator: tps65219: Fix is_enabled checking in tps65219_set_bypass
Message-Id: <166427762040.294303.15716985071433693302.b4-ty@kernel.org>
Date:   Tue, 27 Sep 2022 12:20:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Sep 2022 20:23:53 +0800, Axel Lin wrote:
> Testing .enable cannot tell if a regulator is enabled or not, check return
> value of .is_enabled() instead.
> Also remove unneeded ret variable.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: tps65219: Fix is_enabled checking in tps65219_set_bypass
      commit: 947934e389f716d505a656d04388b2ecbe43281d

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
