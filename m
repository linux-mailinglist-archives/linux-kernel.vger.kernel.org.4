Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7066E6949
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjDRQVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbjDRQVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:21:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEAAB741
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:21:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF9626366C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 16:21:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87589C433EF;
        Tue, 18 Apr 2023 16:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681834893;
        bh=rAgsuDa+7Pw63OR9zM8//Nv8m91idOrprj7EvLoy3FI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WyqiCs44P4Kb7gLh9H9uqgDW2H6Bx8yIMSHiJPrxdvPlDEqdP0xmnk7GxSVuyAUca
         0w4TSlGmQUH5WqL5uSFS8TdWQ6/CWIjN9gcbMOT6YNshR99UnERaVFRLrh2BV5UuYI
         x9uR1AJ/tqjsdpgOgUfRmI+mNPAqs5MzjnEypY/u8+D9ZNPrQ2akNfJNW54ta9ZW7D
         mK0px3CDBSP2g/ogw2XlCQ8GxvKMP6Am4+kN0vYwcq+vNIX45URCm0x6N3sQz9KuA8
         Qn7XGu8Ke+th0gsASc4Vjp4a1HwBly+0af3Y8ZxrDugy7kXBnbVxdx/4Iht0L0nxpW
         bQeUzeSJXj06g==
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230413173359.1.I1ae92b25689bd6579952e6d458b79f5f8054a0c9@changeid>
References: <20230413173359.1.I1ae92b25689bd6579952e6d458b79f5f8054a0c9@changeid>
Subject: Re: [PATCH] regulator: core: Make regulator_lock_two() logic
 easier to follow
Message-Id: <168183489228.88061.1184221871697829544.b4-ty@kernel.org>
Date:   Tue, 18 Apr 2023 17:21:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Apr 2023 17:34:17 -0700, Douglas Anderson wrote:
> The regulator_lock_two() function could be made clearer in the case of
> lock contention by having a local variable for each of the held and
> contended locks. Let's do that. At the same time, let's use the swap()
> function instead of open coding it.
> 
> This change is expected to be a no-op and simply improves code
> clarity.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: core: Make regulator_lock_two() logic easier to follow
      commit: 37473397b852f556d8b9428ccbfd51886037842d

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

