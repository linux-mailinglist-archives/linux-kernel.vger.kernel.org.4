Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839F05EC6E5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbiI0OvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbiI0OuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:50:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D449A465
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:48:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE288619F2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 14:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7BAC433D6;
        Tue, 27 Sep 2022 14:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664290122;
        bh=oW2GlI27eoYpEACDh9WXB1kbVwlV6tTbo8tfVLYs1tg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ljSsMs6yGMFG8QDrdU9Ff24nYRnOwWJ8toPTJ+sG610laF9brbINOA4nSxaRlKt6T
         QCQqgdq2xJEF4yO+dFwbVaupusWDikmxrpShQgjRNdDMZxZg3neejvIjKuNNTXoByV
         7Te1C8f6zXuXbW6972psmWh/YFCsz4OboD8byKyQq7472UOxlpxlwHaAh7dctxnt8+
         9h43dRBMFtzyCpEBeFBiXqlUZT45xGAy9jED7WHRkgeL8zL6RqBokQOqExtZEbwn9A
         O2FXgD8O7rZsi4zDFHvNj59Bqp81IoUkaeM0swehBGZOJ3IVovaOcJfINYcI/n80Wj
         pi9qJY+M5s3kg==
From:   Mark Brown <broonie@kernel.org>
To:     Stefan Binding <sbinding@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
In-Reply-To: <20220927121440.2506632-1-sbinding@opensource.cirrus.com>
References: <20220927121440.2506632-1-sbinding@opensource.cirrus.com>
Subject: Re: [PATCH v1] ASoC: cs42l42: Fallback to headphones for type detect
Message-Id: <166429012122.444806.6143435073545852825.b4-ty@kernel.org>
Date:   Tue, 27 Sep 2022 15:48:41 +0100
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

On Tue, 27 Sep 2022 13:14:40 +0100, Stefan Binding wrote:
> After tip sense detects a jack insertion, if automatic
> type detection, and manual type detection fails, then
> fall back to assume the jack connected belongs to
> headphones.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42l42: Fallback to headphones for type detect
      commit: 45560891506fae31be66f2a73693c5c8bd7dbedb

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
