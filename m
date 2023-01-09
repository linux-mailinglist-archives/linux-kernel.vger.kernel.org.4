Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6C2662BB3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237207AbjAIQva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237134AbjAIQuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:50:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B53E3C701;
        Mon,  9 Jan 2023 08:49:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 183CA611E2;
        Mon,  9 Jan 2023 16:49:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1B8C433F0;
        Mon,  9 Jan 2023 16:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673282952;
        bh=DXzx4CNv2chUEU2incZa90cyOE5Pn9XEg8JMTsYyue8=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=ttnkkIco2rzsDwWwQXYUHdG+C57D1AHwmz2k0DtimzBcY/47pQiMlhSB9BORq5Bgl
         NyiqSXw+Le4yi9UhN/gVP3p0j2Fo0xskUxu+zcbBTCR3IudGZHEILw8ioI4bwsojhU
         ywpvrymd4x4oQu8BMePUA23Fxt0PtKF42ZxsKLqMngdui/N4YXCQOe7C5ByxfJj/hH
         c4++K3I4fV4FHrNg61UZsdmd9cYvqXIK6sc+UxstP1KQdqZxen8ha8qnykb8qmEXhx
         raQHeaYqITGoEOcOrrTICOKCH7Lpo+3nAtntAeJwP0EHSaD5m1IE3ntjeaCa8B/cct
         3nw/XDPltrS7Q==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shengjiu.wang@gmail.com,
        Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        perex@perex.cz, tiwai@suse.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Chancel Liu <chancel.liu@nxp.com>
In-Reply-To: <20230104023953.2973362-1-chancel.liu@nxp.com>
References: <20230104023953.2973362-1-chancel.liu@nxp.com>
Subject: Re: [RESEND v2 0/3] Add support for XCVR on i.MX93 platform
Message-Id: <167328294977.323147.11170247431537947432.b4-ty@kernel.org>
Date:   Mon, 09 Jan 2023 16:49:09 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-8b3d1
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Jan 2023 10:39:50 +0800, Chancel Liu wrote:
> This patchset supports XCVR on i.MX93 platform.
> 
> changes in v2:
> - remove unnecessary code which causes kernel test robot reporting error
> 
> Chancel Liu (3):
>   ASoC: dt-bindings: fsl,xcvr: Add compatible string for i.MX93 platform
>   ASoC: fsl_xcvr: Add support for i.MX93 platform
>   ASoC: fsl_xcvr: Add constraints of period size while using eDMA
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: dt-bindings: fsl,xcvr: Add compatible string for i.MX93 platform
      commit: 0a22003c637b71a1dbd8bb521c09736b52349256
[2/3] ASoC: fsl_xcvr: Add support for i.MX93 platform
      commit: e240b9329a300af7b7c1eba2ce0abbf19e6c540b
[3/3] ASoC: fsl_xcvr: Add constraints of period size while using eDMA
      commit: 1760df5b7ee6a0bfc8ad47f4db490c36c5546be8

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
