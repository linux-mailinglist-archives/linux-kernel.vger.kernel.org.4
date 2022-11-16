Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A665562BFF8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbiKPNsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbiKPNr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:47:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3ED14874D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:47:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C40C361DFB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:47:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08655C433D6;
        Wed, 16 Nov 2022 13:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668606472;
        bh=kWOWTI+d+y31sf5/I44KmEK4Vgs9Vsix+AryQQ5pz9M=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GeAFIY1rJw/KTbJHQ4DBU4pCsNdFyb0m9JyJUZCL3vMftqV0zG+cKuehS5drGlLlH
         HjjHD0+07AN+R2A6Cq256rjnii226j1TEXnssQYYTbOzizDepeut3muSaqTc6WRMPw
         fctFdLDTvAL9hxrAYSFCQryshGrWjG+XWmavT1NdMiEa5QYSwDgBiRFKS48OabWX3s
         +XKU2WNeIssZCUWeKFWlkzxJMeN/8SiUWTNGIxIutn6OjHOzVJswEy1NHjIzjKD8XI
         EjwVQF1shqIBNTtkm+gF86qgvosxjz5UqdehxVVuLxACvLmnTHCJ3eYiKVyeJ0sI8o
         qzaiQ09ZG24Yg==
From:   Mark Brown <broonie@kernel.org>
To:     pierre-louis.bossart@linux.intel.com,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>, steve@sk2.org,
        lgirdwood@gmail.com, ryan.lee.analog@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221116082508.17418-1-jiasheng@iscas.ac.cn>
References: <20221116082508.17418-1-jiasheng@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: max98373: Add checks for devm_kcalloc
Message-Id: <166860646973.422565.7735553281079696974.b4-ty@kernel.org>
Date:   Wed, 16 Nov 2022 13:47:49 +0000
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

On Wed, 16 Nov 2022 16:25:08 +0800, Jiasheng Jiang wrote:
> As the devm_kcalloc may return NULL pointer,
> it should be better to check the return value
> in order to avoid NULL poineter dereference.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: max98373: Add checks for devm_kcalloc
      commit: 60591bbf6d5eb44f275eb733943b7757325c1b60

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
