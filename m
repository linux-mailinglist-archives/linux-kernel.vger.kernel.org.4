Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477F071699E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjE3QdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjE3QdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:33:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B44E1B6
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:32:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA678626FD
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:32:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655A4C433EF;
        Tue, 30 May 2023 16:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685464354;
        bh=DNwpD4OplMyhLT5dVEs1KQZfjWEPePdvQ4W++l8K88Q=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=unghP9Aa+yOD5ZyOgg8us62DMte4l0C4kSMmmBtINXTl/dDjrpor651IDOYP9EfYx
         tSjUbw7QfpfpiL0jNaePVOVp/cEj8RvgqfoKGix6TX/jGQXMnNh5jGTU+mmYlnHMQw
         q7sQ04YDtAMGH9ETN24VD6065D63GNTbxJeV/6VyOyrXooTabjzYwIsYxsmcPhwPj2
         GvE6P3rKmThzhI8l9H1Tvp9DyW0aRDN+JGmTj6ppsgEbtJwgBtm/5phAT9ZqtZKgXY
         6fgbUfW1Kao7sZEhHNnnpof0Vns6gyE5yJ9lcJcjabs4RQBHAiJRGMkfU5vCXezOAQ
         ZGf1jvZoJ7ozQ==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, drosdeck <edson.drosdeck@gmail.com>
Cc:     perex@perex.cz, tiwai@suse.com, ckeepax@opensource.cirrus.com,
        savagecin@gmail.com, SJLIN0@nuvoton.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230529181911.632851-1-edson.drosdeck@gmail.com>
References: <20230529181911.632851-1-edson.drosdeck@gmail.com>
Subject: Re: [PATCH] ASoC: nau8824: Add quirk to active-high jack-detect
Message-Id: <168546435213.570240.2930478439187494724.b4-ty@kernel.org>
Date:   Tue, 30 May 2023 17:32:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2023 15:19:11 -0300, drosdeck wrote:
> Add  entries for Positivo laptops: CW14Q01P, K1424G, N14ZP74G to the
> DMI table, so that  active-high jack-detect will work properly on
> these laptops.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: nau8824: Add quirk to active-high jack-detect
      commit: e384dba03e3294ce7ea69e4da558e9bf8f0e8946

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

