Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCDB6D4561
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 15:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjDCNMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 09:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjDCNMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:12:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0430D1994
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 06:12:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4282B819F4
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 13:12:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C34C433D2;
        Mon,  3 Apr 2023 13:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680527557;
        bh=F5CFUHwGzYRrtVKymtsE/5/KwA6knBt8fQtzTdR38xI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Lh+jxwdA/eVlkOPh3u7h0EVnXPkd4iRaczihFZA9cagOIN9NdC0lka8q83CYM8qYy
         /ci6X+5udMbC2dpKF1rUnw6/oPE1wQreXbhXpISv/LEJM/64NDPyV+qVh2f/k+oj1C
         DnoNlLz6bvRLlEtTRQ1q+F9RmdFtEfGL8L+gFNm7mG5BC57ntg3qVkFcqztgdkOAex
         6qUKUWY0ltRIBbvKssN8cWpBnZz9aEgZ7aXodg4GpjelfLz1zL1NTD8c7W6yPZmRlT
         A7pSgDhmlSrsdSyMsTvc3E/GjjIyvj7LB3yVu1hnCL1zoNoRz5Zvb6SOT3MkgIzZ9F
         sC59Lz54UtxkQ==
From:   Mark Brown <broonie@kernel.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230325-regcache-maple-v3-0-23e271f93dc7@kernel.org>
References: <20230325-regcache-maple-v3-0-23e271f93dc7@kernel.org>
Subject: Re: [PATCH v3 0/2] regmap: Add basic maple tree register cache
Message-Id: <168052755618.39566.9880941918652790444.b4-ty@kernel.org>
Date:   Mon, 03 Apr 2023 14:12:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2023 01:10:22 +0100, Mark Brown wrote:
> The current state of the art for sparse register maps is the
> rbtree cache.  This works well for most applications but isn't
> always ideal for sparser register maps since the rbtree can get
> deep, requiring a lot of walking.  Fortunately the kernel has a
> data structure intended to address this very problem, the maple
> tree.  Provide an initial implementation of a register cache
> based on the maple tree to start taking advantage of it.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/2] regmap: Factor out single value register syncing
      commit: 05933e2d44607767ecb4937a33df4e882bdf9ad3
[2/2] regmap: Add maple tree based register cache
      commit: f033c26de5a5734625d2dd1dc196745fae186f1b

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

