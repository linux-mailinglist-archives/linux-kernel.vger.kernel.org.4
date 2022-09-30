Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE215F0C19
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 14:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiI3M7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 08:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbiI3M72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 08:59:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CE0176ACC;
        Fri, 30 Sep 2022 05:59:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D267CB8289D;
        Fri, 30 Sep 2022 12:59:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD37C433C1;
        Fri, 30 Sep 2022 12:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664542765;
        bh=+uP6RNd0zA7eYt8+5SUH77eiekJsemLzVXuGter0scY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SsoCu8VL8DFop6sdDT6PpkIFJAkqtOZivsuPzO9rgyWyYUYyZeOqAQ8RZ8ar8CEI3
         wXNW18JeXqjtEo0sgV0MM+yio4jTZURXH2rW5yES3V90ZMFYT1yeuvRUhpHCNHvs+I
         y8w6QgqDFg1R8J0zjpFy+IBYJbcm4wh+IphXkciFqoekAmmIJ6kr8QuEkqNnyp8QDy
         ELk0UyGe0kI/uvZhE4L723YWWsZEg/t8SR7R5t4johkC51oTdEKoYToQAG4/CZLgLY
         Ju/tzYJxJWZXCw/y3muYD61mUfpMZqrRFX4+/kCx74HAuWwYOIT02QLkBOG7jS+Ahv
         ZDqhT9G2id5kw==
From:   Mark Brown <broonie@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>
In-Reply-To: <20220930113408.19720-1-m.szyprowski@samsung.com>
References: <CGME20220930113421eucas1p27f2dcbac6790e7f6232c3ae88e55723c@eucas1p2.samsung.com>
 <20220930113408.19720-1-m.szyprowski@samsung.com>
Subject: Re: [PATCH] spi: Ensure that sg_table won't be used after being freed
Message-Id: <166454276436.255916.3302149825937071589.b4-ty@kernel.org>
Date:   Fri, 30 Sep 2022 13:59:24 +0100
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

On Fri, 30 Sep 2022 13:34:08 +0200, Marek Szyprowski wrote:
> SPI code checks for non-zero sgt->orig_nents to determine if the buffer
> has been DMA-mapped. Ensure that sg_table is really zeroed after free to
> avoid potential NULL pointer dereference if the given SPI xfer object is
> reused again without being DMA-mapped.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Ensure that sg_table won't be used after being freed
      commit: 8e9204cddcc3fea9affcfa411715ba4f66e97587

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
