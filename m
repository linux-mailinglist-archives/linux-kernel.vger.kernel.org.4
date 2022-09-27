Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1F65EBFD1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbiI0Ke0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiI0KeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:34:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63903E953B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 03:34:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0EE42B81A0D
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:34:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B36C433D6;
        Tue, 27 Sep 2022 10:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664274859;
        bh=0r0L2iUcElk7msgyXX001Y0IZKkcWjtg+9SlV70egg4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=kr3AUvhDPsOXlpDZoHG/I2hJFICJspmZ6X6g8VC0UsjRTEpF9wGD3U/nddsFdDO3b
         pCjSDIdRs0DHKsLwW8frw16jgHMAoqUdcp8EK8YtiYxKzIV0HAhmIlAy2/n44nyMHC
         Z/RW+vY2sHMGS2tHqQEWvtL+2q3fGx2b3SERHVzerc8zr7ycxXs4UkKMirDH9HlaEV
         waqeD+M6R5w4hIYM9D3oyy8eSfqgfnnsP+2yPwvEIdCzn5p/rBNIcnWTwsQzNb6qAy
         K/lmblp6Px0LXR0sQgRmDa7EsHZiedUoQFNZ5OjCyJXxG+gpi0+l65hNim2CCLQDmw
         vv+Kx0Ovv+TaA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>,
        alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, cezary.rojewski@intel.com,
        pierre-louis.bossart@linux.intel.com
In-Reply-To: <20220916140757.681414-1-yangyingliang@huawei.com>
References: <20220916140757.681414-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next] ASoC: Intel: skylake: remove unnecessary dev_set_drvdata()
Message-Id: <166427485820.60697.7549055145038298678.b4-ty@kernel.org>
Date:   Tue, 27 Sep 2022 11:34:18 +0100
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

On Fri, 16 Sep 2022 22:07:57 +0800, Yang Yingliang wrote:
> Remove unnecessary dev_set_drvdata() in skl_remove(), the driver_data
> will be set to NULL in device_unbind_cleanup() after calling ->remove().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: skylake: remove unnecessary dev_set_drvdata()
      commit: d508260e89a7d1889bbb5788fdfc52cc3eb8ddb6

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
