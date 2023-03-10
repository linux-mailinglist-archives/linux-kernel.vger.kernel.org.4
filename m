Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363BA6B4948
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbjCJPLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbjCJPKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:10:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388F36A45
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 07:02:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CDAF2B82317
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 15:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A9CC433AC;
        Fri, 10 Mar 2023 15:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678460564;
        bh=YSUJSGnMzkT4PKVgsJp5gq4NAM6BAlf2/mbSSdMEWfQ=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=twrehLJotCuofLThz6lZiDhstbQJHPNdY78M5lM2ntHMsajLjOuHf5FZu5w6EcRcV
         BX3TEyfgxWVi4tl45bqZGru2danSABMVY2wUBU1ktb7/sHY2MYjXs/pl9WXO0Re8xM
         2bgMiyQP/W9JsiV4NkYqRUFCOpUOe5x8PPDnew2lI4TBV9Q/i/gpxpdNiI3YpIxztB
         sWvRu6v8qJkP/BYKz9HgNUIyHlhY3OoioRDSqBrCbp3L6HP2az2A3XMPHgV2G3P+Go
         hrJZNttUVdAdGMQ3LcrXxgfZEdOyw20thc1Ycz8kah03OpD4Xv6gVsnCgR/bjs3ANh
         6UnM4IDccDJtA==
From:   Mark Brown <broonie@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230217185326.23490-1-andriy.shevchenko@linux.intel.com>
References: <20230217185326.23490-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] regmap-irq: Place kernel doc of struct
 regmap_irq_chip in order
Message-Id: <167846056338.924636.18339070324763154632.b4-ty@kernel.org>
Date:   Fri, 10 Mar 2023 15:02:43 +0000
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

On Fri, 17 Feb 2023 20:53:26 +0200, Andy Shevchenko wrote:
> It seems that a couple of members got lost theirorder, put them back.
> Besides that, split field descriptions into groups in the same way
> as it's done in the structure definition.
> 
> 

Applied to

   broonie/regmap.git for-next

Thanks!

[1/1] regmap-irq: Place kernel doc of struct regmap_irq_chip in order
      commit: 9b400171a69d2487c3196cc3b6de60de3b08e1ee

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

