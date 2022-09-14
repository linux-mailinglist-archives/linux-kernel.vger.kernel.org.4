Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CFB5B854D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbiINJlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiINJkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:40:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F134E85E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 02:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87332B80E02
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 09:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD36C43141;
        Wed, 14 Sep 2022 09:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663148420;
        bh=9d25q7djykcHE0hT6Fq9ch208cDtKJYVQfvbgze86aM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=M20tsW8JimtW/0pw2xZm3L1G3Ax1P8M1qasEDF7rc57ZKVhl21vmyOJDq1PanYHU3
         K1CMf/zLtsJ0o4WGe87Bt0GT94k6vPT62O3AmxdZDujbeVjzd8mrGtiVEBNNga/cRH
         L6QWPx435XADr1l3S/5CPrvPJwLCspPx0eQQkVnxdrblo1Gs7AcoNm+KNGEQP0xS1d
         KQoxlHN4n8MIf5lD1UVyqdY0R2JjJQXceBlGJDEyiFvQEeWRLF9IUlCSilPg1DPKff
         wfgZPU+k7F7JXrGVMlKxYlcDipssxmQWUVifu/GiXcnzHWPiQ6KVyP/xYKlyWby2Pv
         CG0wqLYuXD4iA==
From:   Mark Brown <broonie@kernel.org>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>, cezary.rojewski@intel.com,
        tiwai@suse.com, ranjani.sridharan@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, perex@perex.cz,
        liam.r.girdwood@linux.intel.com, kai.vehmanen@linux.intel.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20220822035133.2147381-1-cuigaosheng1@huawei.com>
References: <20220822035133.2147381-1-cuigaosheng1@huawei.com>
Subject: Re: [PATCH -next] ASoC: Intel: fix unused-variable warning in probe_codec
Message-Id: <166314841746.314266.6045600836637107787.b4-ty@kernel.org>
Date:   Wed, 14 Sep 2022 10:40:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-7dade
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Aug 2022 11:51:33 +0800, Gaosheng Cui wrote:
> In configurations with CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC=n,
> gcc warns about an unused variable:
> 
> sound/soc/intel/skylake/skl.c: In function ‘probe_codec’:
> sound/soc/intel/skylake/skl.c:729:18: error: unused variable ‘skl’ [-Werror=unused-variable]
>   struct skl_dev *skl = bus_to_skl(bus);
>                   ^~~
> cc1: all warnings being treated as errors
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: fix unused-variable warning in probe_codec
      commit: 515626a33a194c4caaf2879dbf9e00e882582af0

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
