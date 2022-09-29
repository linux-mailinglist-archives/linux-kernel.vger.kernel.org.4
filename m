Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E175EF60D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 15:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235643AbiI2NII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 09:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbiI2NIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 09:08:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797C2155649;
        Thu, 29 Sep 2022 06:07:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2AFE8B823A5;
        Thu, 29 Sep 2022 13:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F72C433C1;
        Thu, 29 Sep 2022 13:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664456875;
        bh=sj+OdEAtykHcBziJ2ilGZDg/T4fIfEtsnxrbhj4A+U0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=s3E375LbnG4eXybX2ENtevXcY20C0PZdCx3Q3e6yp/kZXN7zNECGzVmHl32719qh/
         raW4MuWEJZvdJiJQCVTlE7KErEZv8Lk215c1IvjuZmAhYY1SqupUdapxcZ+ofl+rrQ
         oqA2Dm1oqRfXid7alPVTyIDylj18xPf+x6sss1RJJcz6uR53Lzldb3Qp4/q5LMtMpG
         yt6W2CcQiS9OIxn4Fj9N3/CpN5LnqlhsGUrSZqOkAYAQVjnDP/pPag0RU/iSlH7ULl
         qIDu7AewPCAFjTtOCm27Coc+pVraVBWFzSPD3Ro6umAKSEGWBtRTJVpjPR2dtSNJGq
         sP2+Bn4vk7bIQ==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        linux-mediatek@lists.infradead.org, alsa-devel@alsa-project.org,
        Colin Ian King <colin.i.king@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220928220417.66799-1-colin.i.king@gmail.com>
References: <20220928220417.66799-1-colin.i.king@gmail.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8186: Fix spelling mistake "slect" -> "select"
Message-Id: <166445687286.114358.7172094686592004129.b4-ty@kernel.org>
Date:   Thu, 29 Sep 2022 14:07:52 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sep 2022 23:04:17 +0100, Colin Ian King wrote:
> There are some spelling mistakes in dev_err messages. Fix them.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8186: Fix spelling mistake "slect" -> "select"
      commit: 65c94e4d15830406a31a55085887e97bacd25434

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
