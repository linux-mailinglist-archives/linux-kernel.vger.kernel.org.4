Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2EBE6AC326
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjCFOZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbjCFOZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:25:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D99311E2
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 06:24:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78B33B80E61
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 14:09:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D02CC433EF;
        Mon,  6 Mar 2023 14:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678111753;
        bh=hE/VzkAOWSh6yuWv5z9a/H2QyPRXAG2dukM7IvVtMOk=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=V6fZLstDP2LhhxuL9l153uwBp5xLLC8ZXWfvNhXV5WfUgroYR4NQ+Skk3ig89b8va
         bipJEQduQHbGgXuwsWM7QfNXINW33Gcqn8AASVZkN8P2T8YzG94IwQ5pzyni7cvjyh
         hEYcKnZ7V+6nh+6HLDZnHSft02yvjCt+ruhB9A/I9OkqvEWpQYDh2WY97bAOtr8tG6
         rkxoq06ma88CXI+kyMAnoyG+X87xwLmeNVE03dq/rHT4pZekhjIHTrpeaxSevHqKpw
         ZBjxA9KGBMpINuVtCJd1BTwqVqG37en/F0f8QFLkQEwHLyHH2buzAsxq4xDVSzGTyW
         QMWmsEYbnof3g==
From:   Mark Brown <broonie@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230220153334.87049-1-andriy.shevchenko@linux.intel.com>
References: <20230220153334.87049-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/1] regmap-irq: Place kernel doc of struct
 regmap_irq_chip in order
Message-Id: <167811175194.98202.365026661920126063.b4-ty@kernel.org>
Date:   Mon, 06 Mar 2023 14:09:11 +0000
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

On Mon, 20 Feb 2023 17:33:34 +0200, Andy Shevchenko wrote:
> It seems that a couple of members got lost theirorder, put them back.
> Besides that, split field descriptions into groups in the same way
> as it's done in the structure definition.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

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

