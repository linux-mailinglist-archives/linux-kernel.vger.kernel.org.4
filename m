Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41FE5BD7DB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 01:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiISXKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 19:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiISXKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 19:10:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76AD29809
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 16:10:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBF55B821D4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 23:10:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE474C433B5;
        Mon, 19 Sep 2022 23:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663629009;
        bh=8/D3JnwU0fDpp4yI4U64lVkY6DwN9AQz/S/fXprKgGo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=PiKcIoG6mxg/eQfMMvxVjJ/L0+FxCZDOpGEyYAfZHvTVUwrhZg7stNmNI1ldlxpMV
         eBVQbrqpUtrp7wY2ir3BsUIvRCNvPeKitlfSH0AnfYjWdc4fP6HsCzbbXM7aaemNRt
         SSb2PdRlR8lmtSbjoCdjxar0HghTIwvvNs4nn47Vmvhxur1gCq+bFz8hiXlhJLW/bw
         70OQtol93p7LX+TsG3QTvl6fUpCf8xy9wmkp3NpJufmM9713vxaA01H9pHYIWaY++/
         TLKQabQ5CjEyU3zRkbdxbt9Gl10/v+egv1/jhXqR6W6EXBjHZjD28XoU77vZz8WQO9
         H4Edvb3ZJMvDQ==
From:   Mark Brown <broonie@kernel.org>
To:     cgel.zte@gmail.com
Cc:     ranjani.sridharan@linux.intel.com,
        ye xingchen <ye.xingchen@zte.com.cn>,
        linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org,
        tiwai@suse.com, pierre-louis.bossart@linux.intel.com,
        perex@perex.cz, kai.vehmanen@linux.intel.com,
        Zeal Robot <zealci@zte.com.cn>, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, daniel.baluta@nxp.com,
        yung-chuan.liao@linux.intel.com, peter.ujfalusi@linux.intel.com
In-Reply-To: <20220916062511.153962-1-ye.xingchen@zte.com.cn>
References: <20220916062511.153962-1-ye.xingchen@zte.com.cn>
Subject: Re: [PATCH linux-next] ASOC: SOF: use devm_kcalloc() instead of devm_kzalloc()
Message-Id: <166362900561.3419825.13047486503989578103.b4-ty@kernel.org>
Date:   Tue, 20 Sep 2022 00:10:05 +0100
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

On Fri, 16 Sep 2022 06:25:11 +0000, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Use 2-factor multiplication argument form devm_kcalloc() instead
> of devm_kzalloc().
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASOC: SOF: use devm_kcalloc() instead of devm_kzalloc()
      commit: 7b88552c26971ccbc6ff35e9d544f7fac94ffef1

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
