Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0AEF678363
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjAWRga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbjAWRgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:36:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E85D279B2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:35:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57548B80E2C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 17:35:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F303C433D2;
        Mon, 23 Jan 2023 17:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674495319;
        bh=R1iHUceZscWCXtjqIe/AspeQ1sp5BCJevKW61MSxvQ8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=IyPOgwjTQkEDZPcEngMzjP1Vl3nBVJ6i7eZCZ4HUM7PSodh4fi4bNM19N7hgTOBuM
         FbhgPRNGZgmjs2fu7tMrnAPCkNhvqKQOyB++ScQbJNsRLu3MAxDerB+xjECz8DjysA
         hYtqNJQr4OBRi4G0JZJPw0nRRebAMm+UmDtWAxWwJ4dlKgJQSVKKOz6i2MmXNYchi+
         zRenD7ld33yxG/VoTl2gVsQVD/3cYFlf5+YZs/NhflIu/uR1pt+D7PfPW3/NFAS7jU
         4E1VJ5S+/lg0+tyG0YsEKds/Bmgxi2V/ZJrvu15ClIS0xMF/9fqzM1eKe5hzS+wYnj
         HRahyXTwwY6aQ==
From:   Mark Brown <broonie@kernel.org>
To:     fengwk <fengwk94@gmail.com>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <Y8wmCutc74j/tyHP@arch>
References: <Y8wmCutc74j/tyHP@arch>
Subject: Re: [PATCH] ASoC: amd: yc: Add Xiaomi Redmi Book Pro 15 2022 into
 DMI table
Message-Id: <167449531821.1496007.16660083935853354591.b4-ty@kernel.org>
Date:   Mon, 23 Jan 2023 17:35:18 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Jan 2023 01:51:06 +0800, fengwk wrote:
> This model requires an additional detection quirk to enable the
> internal microphone - BIOS doesn't seem to support AcpDmicConnected
> (nothing in acpidump output).
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Add Xiaomi Redmi Book Pro 15 2022 into DMI table
      commit: dcff8b7ca92d724bdaf474a3fa37a7748377813a

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

