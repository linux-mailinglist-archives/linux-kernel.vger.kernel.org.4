Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3461611AD6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 21:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiJ1TYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 15:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiJ1TYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 15:24:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3172303FF;
        Fri, 28 Oct 2022 12:24:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37BA56281C;
        Fri, 28 Oct 2022 19:24:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3EFC433C1;
        Fri, 28 Oct 2022 19:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666985051;
        bh=ot5Sa9Mlp08Yo/46BwMaqi/qloDRG4Ii89sgfRGOd54=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ojd1RVNw6hyaCCrYdsqnQgEpBn6ofM9IfNeBwiFPt1RQXzavRtsRoouFedFSCkv0B
         XF2PFc4N5tLNeNqZKLxMbn0TWFiVJeWF8qw4OCzV/QwioO6f//BlxEBlv941jj/MDj
         NAG0+64eerSXeiwFXtmTJLutHb4G61oEYACGK+TOppuWFA5FCMngtMrXSxvpez7F+w
         xYBvtFp2399YT7/hqBa7BLyhrf9/cuJ3n0uJ3mkL09+iUJPEL1ZENNZEoeDVl6TREk
         pcoif7BTuZgesclLg4cfnuNAxzHcWPNRX5WODORRlgtDsxdrWapBA7+70Kp1vQ+qnM
         VVvjJ09wxESzw==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     perex@perex.cz, lgirdwood@gmail.com, bgoswami@quicinc.com,
        alsa-devel@alsa-project.org, tiwai@suse.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220915123837.11591-1-srinivas.kandagatla@linaro.org>
References: <20220915123837.11591-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 0/9] ASoC: qdsp6: audioreach: add multi-port, SAL and MFC support
Message-Id: <166698504930.1386510.17260012636035709007.b4-ty@kernel.org>
Date:   Fri, 28 Oct 2022 20:24:09 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Sep 2022 13:38:28 +0100, Srinivas Kandagatla wrote:
> This patchset adds support to multi-port connections between AudioReach Modules
> which is required for sophisticated graphs like ECNS or Speaker Protection.
> Also as part of ECNS testing new module support for SAL and MFC are added.
> 
> 
> Tested on SM8450 with ECNS.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/9] ASoC: qdsp6: audioreach: topology use idr_alloc_u32
      commit: af7ed7eb70e8964514c706f8498623a2a3696657
[2/9] ASoC: qdsp6: audioreach: remove unused connection_list
      commit: 5b488e80078f09bbc197d766babf014dd52c30bf
[3/9] ASoC: qdsp6: audioreach: update dapm kcontrol private data
      commit: 1c87d3817b74b895933e9940b9de09b17c674b9b
[4/9] ASoC: qdsp6: audioreach: Simplify handing FE and BE graph connections
      commit: e4977b91cff8b00cdeb310735ef34fa4dee9485c
[5/9] ASoC: qdsp6: audioreach: simplify module_list sz calculation
      commit: 4efb98e9635b9919f2cb72cddae97b7231cf96ef
[6/9] ASoC: qdsp6: audioreach: add support for more port connections
      commit: 03365d6a58c47b3a3f2f964d0777493e293d7da4
[7/9] ASoC: qdsp6: audioreach: add support to enable SAL Module
      commit: a934afdbb022d5a7b1d20251875ecefcaf48536a
[8/9] ASoC: qdsp6: audioreach: add support for MFC Module
      commit: cf0de67d954db21002fd7521364f2ac89aabae35
[9/9] ASoC: qdsp6: audioreach: add support to enable module command
      commit: 6648a6dcfe40ae8c5e7cb5c1d7b9e59f010e285d

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
