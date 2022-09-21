Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9F65BFACD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiIUJYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiIUJYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:24:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25397B57
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:24:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B669662968
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:24:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD750C433C1;
        Wed, 21 Sep 2022 09:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663752273;
        bh=saf5MjyZS/Ao0yFYu51Y1H/XCy/26iny1D/d5NZk9L8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=XRwVQHu9QfuxxYKt12h7RahLFRZMbqb4pTulq/pvntoq3u9qYtBSHwUtJfs4//ZPa
         J6/xRvABGCWPretGsGzfaWgzGdwzTs26QWNVo9MKa4AF5meWfoIy/v69iTy7tVXGx7
         tCW2QWSq/7autUIrDLcq3yBcSCq4eY0tzcqDBHcD2ZG3Yo+7hAL5koBU/DjDbGZAt2
         E5y+JlcctPfunoD8wBZaLvk6wA58UbKRUpvBC3/N+EExLkP9GiaFlXzUKvd3WT2vkG
         fGhscRUP7UVJDTXMRhjw/tfwZS/b/wK2vhda7Wu6Sckomd/j2Gd147eodO3+FHWal3
         FhU3e2McguOLA==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     lgirdwood@gmail.com, oder_chiou@realtek.com
In-Reply-To: <20220920151413.3455255-1-yangyingliang@huawei.com>
References: <20220920151413.3455255-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next] ASoC: rt5682s: simplify the return of rt5682s_probe()
Message-Id: <166375225784.526450.17898794623132964146.b4-ty@kernel.org>
Date:   Wed, 21 Sep 2022 10:24:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-8af31
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sep 2022 23:14:13 +0800, Yang Yingliang wrote:
> After commit bfc5e8b860ad ("ASoC: rt5682s: Reduce coupling of
> Micbias and Vref2 settings"), the return of rt5682s_probe()
> can be simplified. No functional changed.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt5682s: simplify the return of rt5682s_probe()
      commit: 2edd66eccfeab9734512fac352b50d17366246f5

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
