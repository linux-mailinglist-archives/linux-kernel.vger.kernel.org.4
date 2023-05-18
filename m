Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3898F7086FF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjERRdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjERRd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:33:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E7E10C1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 10:33:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 260F36514F
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:33:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE560C433A1;
        Thu, 18 May 2023 17:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684431206;
        bh=8g604RQtGDYqVxRbodA1GNAzcaFUInIXvN/XS2wjnMQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=IbQt+C8i2MSKRx23a6Y5VDsVm/DahgJApeFIijPhY0TIs9nIt4MnDfyEQ4gfXVHNC
         V3tIw0HKx6WN8oeKORJHszstQHcsYej9unu9tcSmbpQsdr3MZoE7dwEDqdnFrjvVtZ
         sVzN7tqmiAyv0HCbNwas8uTQa6R+0KNjL+2x6waEGifw776DT8BonXMsNdvSAY/N65
         y70BIPcHMihq5kMVDOgqbhuaM+9kWt7/gcRJFMgp2NI9NTNoYqrk1OkVlIHj3zv6fs
         AUddRshKbXEf7wyBbOzl4coUOOEahDUh/Pxm7o4DxLZNqDOWwtarY3yEklEfNr9jYY
         pPxsfezlPBdnA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Sen Chu <sen.chu@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
In-Reply-To: <20230518040646.8730-1-sen.chu@mediatek.com>
References: <20230518040646.8730-1-sen.chu@mediatek.com>
Subject: Re: [PATCH v2] regulator: mt6359: add read check for PMIC MT6359
Message-Id: <168443120482.483131.18246545493507680908.b4-ty@kernel.org>
Date:   Fri, 19 May 2023 02:33:24 +0900
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

On Thu, 18 May 2023 12:06:46 +0800, Sen Chu wrote:
> Add hardware version read check for PMIC MT6359
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: mt6359: add read check for PMIC MT6359
      commit: a511637502b1caa135046d0f8fdabd55a31af8ef

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

