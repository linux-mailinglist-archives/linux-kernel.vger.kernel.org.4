Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA9170F5C5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 13:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbjEXL6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 07:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbjEXL6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 07:58:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476E019D
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 04:58:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFD3663C67
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 11:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6BEC4339C;
        Wed, 24 May 2023 11:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684929522;
        bh=UMiHL7ethwa+018lGBl2r8MGW4Lj2YlyfJiTZIjuQVk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=O5mHpTzthzLsO1nX1RVg8URiT3Q4rvVlypW+BB2EbR+YMZZb21twVFEs3RLysTiXg
         C/Tjba7bl/AohPlk2PYE16mrg8HTXO/fvOHXEnDIZmy4JUPlCHJykZSlu4gG/qdFK/
         Xbf1RXA+0D8xmiRYDDSAL2Qm9rvvKpMw0Firp3WBFRll1YGDDWj4TvqHL1gNDrRU5W
         NSU+2xfupwMNlruwnXdsWRU5q1ceHdr5uO1uaWKQ+Q/nxU2dMryLUkGjxEbRhvFpUO
         2SjD04QvlDT7h/AMm5iS9tWNSs2Up6WvwxV143q6CXAkFTMv5/mCay90lJ8oXAl/CP
         HaSoaj8zGt2xA==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        ckeepax@opensource.cirrus.com, tanureal@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20230523154747.5429-1-srinivas.kandagatla@linaro.org>
References: <20230523154747.5429-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] regmap: sdw: check for invalid multi-register writes
 config
Message-Id: <168492952043.55912.13195955442624432460.b4-ty@kernel.org>
Date:   Wed, 24 May 2023 12:58:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023 16:47:47 +0100, Srinivas Kandagatla wrote:
> SoundWire code as it is only supports Bulk register writes and
> it does not support multi-register writes.
> 
> Any drivers that set can_multi_write and use regmap_multi_reg_write() will
> easily endup with programming the hardware incorrectly without any errors.
> 
> So, add this check in bus code to be able to validate the drivers config.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: sdw: check for invalid multi-register writes config
      commit: 95856d1f3c223c015780fffb8373a827fc4efd2e

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

