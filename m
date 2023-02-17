Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147E669A3C8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 03:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjBQCPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 21:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjBQCPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 21:15:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80634FC8A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 18:15:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C5656121D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A307C433D2;
        Fri, 17 Feb 2023 02:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676600103;
        bh=BkSrC7Py+5Z9A7r2WhnpcUW+2uMS7Yv7sa7V+ZBwk+s=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=k2XcrgZ8i+CzkTNGPlEEjgTeD8wqJ51ax+T549eQGTDafqgw6f+qXkhJTMhWcA3MU
         A/CUi0ZyFCWyzT2DtsGdTD52Ae79TtgFs4Cy/I7gRUuP9/jPIRiGm1c2GL/kOKlCqz
         eOJzuAHQTCcR1cqZE1cv+RwlSd8NfJerGNgBpStakNp04Mo3Oyy1GGpqhqMITfjnzC
         Tc/0xJEofI80ea64Zgum6JZqDb2EtLGF+3xKdqF4SJAGAqAHlNm378bxM1p+yRvEFk
         VmJWlU2jkgHkqYaSjkVCCi0EHh3y3NdIWW1F3cwf0btrGeqCc9Fcz9VfkEWu4oaLBA
         keLAgZdSqS8FQ==
From:   Mark Brown <broonie@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230216223200.150679-1-aidanmacdonald.0x0@gmail.com>
References: <20230216223200.150679-1-aidanmacdonald.0x0@gmail.com>
Subject: Re: [PATCH v1 1/2] regmap-irq: Remove unused type_invert flag
Message-Id: <167660010179.68139.12889888972386660880.b4-ty@kernel.org>
Date:   Fri, 17 Feb 2023 02:15:01 +0000
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

On Thu, 16 Feb 2023 22:31:59 +0000, Aidan MacDonald wrote:
> type_invert is deprecated and no longer used; it can now be removed.
> 
> 

Applied to

   broonie/regmap.git for-next

Thanks!

[1/2] regmap-irq: Remove unused type_invert flag
      commit: 483e6ea1b35aaeffd9b6e6e660d756be49c2a9f5
[2/2] regmap-irq: Remove unused mask_invert flag
      commit: c74e7af1245b2073930afc9a2a340d91e08f0f14

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

