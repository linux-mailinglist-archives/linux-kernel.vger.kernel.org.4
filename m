Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1615BD7DD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 01:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiISXKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 19:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiISXKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 19:10:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5351CB36
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 16:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1DB8EB807ED
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 23:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78AB0C433D6;
        Mon, 19 Sep 2022 23:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663629018;
        bh=e0QF4vfam6+gxxuHUDz8GUn1DNo3hAYlR7LZMd9gIQ8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GxWaeCHHVSGeYRdRzNxnu7GAHIYHQr34SlU8w78hY/mGDgiJgAbcNc46N4eVEOdFj
         bxnGBfMTH4iPRAcNcA7da5HrTlnA3RdIe4QKQHXhdRw/xMK08Gaj2peGpKPUVPzFww
         pSSepQYeLAD5T2BC9v0QKXdNEx4K7GUIdw0HZpY7T8BAGVEoHjZpwYN6jc/jRPp1rx
         2s4VlX1vWbfIOwK8m8ZqpcH/Ab6wC8qIgSXF5b5kKABDYmm9PUMaPSbMXmxwl//gUr
         TyJJzvYnrl+1Nkxo+VHYs1WdC/KHJaqkMhnO6kWW8vdc49bRyCaWsmCcSzY5iqerpg
         0dSry+0sWZ6sg==
From:   Mark Brown <broonie@kernel.org>
To:     cgel.zte@gmail.com
Cc:     ranjani.sridharan@linux.intel.com,
        ye xingchen <ye.xingchen@zte.com.cn>, ajye.huang@gmail.com,
        linux-kernel@vger.kernel.org, tiwai@suse.com,
        vamshi.krishna.gopal@intel.com, cezary.rojewski@intel.com,
        mac.chiang@intel.com, pierre-louis.bossart@linux.intel.com,
        perex@perex.cz, yong.zhi@intel.com,
        liam.r.girdwood@linux.intel.com, kai.vehmanen@linux.intel.com,
        Zeal Robot <zealci@zte.com.cn>, alsa-devel@alsa-project.org,
        yung-chuan.liao@linux.intel.com, peter.ujfalusi@linux.intel.com,
        brent.lu@intel.com
In-Reply-To: <20220916062630.154277-1-ye.xingchen@zte.com.cn>
References: <20220916062630.154277-1-ye.xingchen@zte.com.cn>
Subject: Re: [PATCH linux-next] ASoC: Intel: sof_rt5682: use devm_kcalloc() instead of devm_kzalloc()
Message-Id: <166362901419.3419825.11809822092689370163.b4-ty@kernel.org>
Date:   Tue, 20 Sep 2022 00:10:14 +0100
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

On Fri, 16 Sep 2022 06:26:30 +0000, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Use 2-factor multiplication argument form devm_kcalloc() instead
> of devm_kzalloc().
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: sof_rt5682: use devm_kcalloc() instead of devm_kzalloc()
      commit: 54a0511067217e7039045623942e4e021ef1db84

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
