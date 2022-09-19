Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EFB5BD7D5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 01:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiISXJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 19:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiISXJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 19:09:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F51101E4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 16:09:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDCE861F3B
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 23:09:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC22C433D7;
        Mon, 19 Sep 2022 23:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663628989;
        bh=MROo2XMbqbwo7kp5pNKP6bB1k6dqwbTItS+Uef+RX34=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dNoQMJ3Ma4URZbgEyxLCMEJNEKIz3YVainvQfvITGuhLcGWk0cmNdA4cDZyjGHck3
         t3u27rk2Hq8dJiJvyqccq2G++3HvhRzu0PpGrgZIkQhkJgcb64hXEVWhx58fbRi49h
         pEJbXxXYn4ytkeiT16ljacG6ATNc7ppbK+QOnP0gGUz6ncnzdtk8xIx5dejd9yN077
         zhkvvaHadxYtSNP2fnqGRoM7RMdVSZMsqBuduZtTxlNrN+wE8sJ5WmzmyNcdGZcjg6
         IgE+adqHBl4y7yhUiOG+nUYtzixTu/YEIT2Y0CDScCyJ+jo7KHDZm0EWgBFgixQlP9
         PJKM1VR9ANGRg==
From:   Mark Brown <broonie@kernel.org>
To:     cgel.zte@gmail.com
Cc:     ye xingchen <ye.xingchen@zte.com.cn>, Vsujithkumar.Reddy@amd.com,
        linux-kernel@vger.kernel.org, tiwai@suse.com,
        AjitKumar.Pandey@amd.com, venkataprasad.potturu@amd.com,
        perex@perex.cz, Zeal Robot <zealci@zte.com.cn>,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        Vijendar.Mukunda@amd.com, yangyingliang@huawei.com
In-Reply-To: <20220916061906.152434-1-ye.xingchen@zte.com.cn>
References: <20220916061906.152434-1-ye.xingchen@zte.com.cn>
Subject: Re: [PATCH linux-next] ASoC: amd: acp: use devm_kcalloc() instead of devm_kzalloc()
Message-Id: <166362898554.3419825.13173032039628568145.b4-ty@kernel.org>
Date:   Tue, 20 Sep 2022 00:09:45 +0100
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

On Fri, 16 Sep 2022 06:19:06 +0000, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Use 2-factor multiplication argument form devm_kcalloc() instead
> of devm_kzalloc().
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: use devm_kcalloc() instead of devm_kzalloc()
      commit: 8e34d743f97f151824a2dc0803695752de80bf7d

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
