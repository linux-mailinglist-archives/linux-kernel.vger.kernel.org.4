Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FE170316D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242336AbjEOPWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242308AbjEOPV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:21:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B23116
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 08:21:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AF9462634
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 15:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2232C433EF;
        Mon, 15 May 2023 15:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684164115;
        bh=8Cwvxi9mbnZQGvoxy30/pFPom0P642PMjEzRXu3zyJw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Ht494WY0cQ7S5b1Ta/dnN+CYUnpeqW6dMD/+jicW1fygopjgB3c0dnLEIx+//yOc0
         ENbSTLznz4aZy9P6UJRAEl36Lv1U2vctvZTzWWhOZgx8rWIwWlLBoNttOy4poPnRG1
         2YaYu1qE7KlhaNMYZ8hgFpjh5MNfE4cTdmY76SzNP3LVftJUJtKYhsS1+FuCixOFTY
         LBrVJESBytoPFHYXFjzd7ODmdQrIh6wt5CV2ufAFWe+WaMvkH2DgXuDZ9G9EpHjGk9
         ZA2uzndcFpgQGVI6/eHgkeHZFDsQJdvQKdNhnLM4eAov7tsNxTjwySCLnvBJIqK4ev
         X7hKmR7obJ8Ig==
From:   Mark Brown <broonie@kernel.org>
To:     pierre-louis.bossart@linux.intel.com,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     lgirdwood@gmail.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, daniel.baluta@nxp.com,
        perex@perex.cz, tiwai@suse.com,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20230512064225.75358-1-jiapeng.chong@linux.alibaba.com>
References: <20230512064225.75358-1-jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH] ASoC: SOF: Simplify the calculation of variables
Message-Id: <168416411258.413889.2620877481797290392.b4-ty@kernel.org>
Date:   Tue, 16 May 2023 00:21:52 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 May 2023 14:42:25 +0800, Jiapeng Chong wrote:
> ./sound/soc/sof/pcm.c:372:27-29: WARNING !A || A && B is equivalent to !A || B.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Simplify the calculation of variables
      commit: d904942aeaa6a6fe493f2825048613ee46c0e991

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

