Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A377A5EC10A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbiI0LVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiI0LUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:20:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A099F0F8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:20:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A641161828
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 11:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4425EC433D7;
        Tue, 27 Sep 2022 11:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664277617;
        bh=bvLdn54WLXXGn2K8gs+IJk07fcYXo6kaZWU8LNj08H0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=eQ3OSM6hORTvgyGe/6NEH0F5/Wc89CERpmLGFFegS6jDIZDe0mZLnyJaTtE6DGDHZ
         0Lshm/pylr1Grnd25nhLXrHTin3YxaW06YF5svmYzC43o/KReM3L/8P4YDKALsS9pC
         /5D22R/L+lBdCd2xO1MzfkZxtuz8JhX2htkfQXDun/AcGnjpO/N8hxqWYnbIc0NaPx
         pkBPm2TLHaMjoEI6oIQFs3DMbdrYjWEBofGkOYV8JzuYJOFUX6+20Uj6EIj/WgcIJq
         XcOEgkWxPw45NR7jDq2zkZGMp2f5IpkMqxIiCVzpFsvqd5hcOY/iCi09hiYGadyYdZ
         aDltiXSQNzPmg==
From:   Mark Brown <broonie@kernel.org>
To:     cy_huang@richtek.com, perex@perex.cz,
        ckeepax@opensource.cirrus.com, james.schulman@cirrus.com,
        tiwai@suse.com, Ren Zhijie <renzhijie2@huawei.com>,
        lukas.bulwahn@gmail.com, flatmax@flatmax.com,
        pierre-louis.bossart@linux.intel.com,
        tanureal@opensource.cirrus.com, srinivas.kandagatla@linaro.org,
        lgirdwood@gmail.com, krzysztof.kozlowski@linaro.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220926074042.13297-1-renzhijie2@huawei.com>
References: <20220926074042.13297-1-renzhijie2@huawei.com>
Subject: Re: [PATCH -next] ASoC: codecs: wcd934x: Fix Kconfig dependency
Message-Id: <166427761398.294040.9515810041975112450.b4-ty@kernel.org>
Date:   Tue, 27 Sep 2022 12:20:13 +0100
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

On Mon, 26 Sep 2022 07:40:42 +0000, Ren Zhijie wrote:
> If CONFIG_REGMAP_SLIMBUS is not set,
> make ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-,
> will be failed, like this:
> 
> sound/soc/codecs/wcd934x.o: In function `wcd934x_codec_probe':
> wcd934x.c:(.text+0x3310): undefined reference to `__regmap_init_slimbus'
> make: *** [vmlinux] Error 1
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wcd934x: Fix Kconfig dependency
      commit: 4d73b97b8dbaf09af6e5878ce3288ba93956a3fd

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
