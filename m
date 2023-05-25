Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CF2710FDE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 17:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241486AbjEYPqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 11:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbjEYPqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 11:46:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6467BB6;
        Thu, 25 May 2023 08:46:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01432646F7;
        Thu, 25 May 2023 15:46:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80648C433D2;
        Thu, 25 May 2023 15:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685029574;
        bh=HAMXQ7eYyMpNN5eFdaxJ+MXRIlrr5kTcFjDxNo3yGV0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Fi/gsGTWmhOeHLKZcwFtc50qZBywJ6IeWY8ltkbnKWY8SjiwIdXXMiwnj6fZfncW3
         upLfFvmPmrepSo3SfUMEa7pYQ/ZAePqldIIWi4UZoOk4SMCBtDJe6atGLvCwpclcO9
         lbWgE7/EImZVKWKpkWVFKq5vz0LLZLW2iFu8lvTkVlgWcHNkAL6t4kkHFS0OLtLmAe
         NgEzGpw+XbubiIDiXetRVGe2/Bw4VSVQwIyfvSUdLk6qvRytHKm5a126+oD+H/ymxR
         bHwlgTmEAIo78b3mwg1QM8PhlfwQt+lJAGtzyeId90jgU8EouXDxeHvpmWC2I9UJtR
         pKUTI63bJTGTg==
From:   Mark Brown <broonie@kernel.org>
To:     qii.wang@mediatek.com
Cc:     matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com, leilk.liu@mediatek.com,
        "Tim . Kuo" <Tim.kuo@mediatek.com>
In-Reply-To: <20230523112608.10298-1-qii.wang@mediatek.com>
References: <20230523112608.10298-1-qii.wang@mediatek.com>
Subject: Re: [PATCH] spi: mediatek: advertise the availability of Dual and
 Quad mode
Message-Id: <168502957225.307668.278901745390078945.b4-ty@kernel.org>
Date:   Thu, 25 May 2023 16:46:12 +0100
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

On Tue, 23 May 2023 19:26:08 +0800, qii.wang@mediatek.com wrote:
> this patch advertise the availability of Dual and Quad SPI mode
> for ipm design.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mediatek: advertise the availability of Dual and Quad mode
      commit: dcb2d27444baeba91701bcab38d60c219cb47463

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

