Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BDE696C2B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 19:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbjBNSBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 13:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjBNSBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 13:01:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0107129E3C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 10:01:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F42FB81EA0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 18:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67734C433EF;
        Tue, 14 Feb 2023 18:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676397698;
        bh=VHUzUlzIpZCXjb2uNwe5jMI+kDtHpcMv7VqX9rFj/a0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YaeQ4rgom6KnSyAdKbm6X+b92+oY4AjQdFC0f/ZUyRwYXCcqDdf/NaSz5GpPJX6s9
         3PM14YGwXD2lHCInfynfMKzCaQ7lV+QAhUAyyOyKiAUhDNiZmEYqjmpAizwSzRsY2j
         zJI+Ok9Of7Z7pQZ4+VulZwcZnl0hqizBvqVQDOAHjdXZi1TSkqiNtRyaLHdsgkZI8R
         ZoJ3wPRH2VNYickXJNpHuBWiCyRDeYipMa9uc8vTrf19royEivarh7rIr0tWwjbA5R
         IU9ALyyNB7lJmBzQaT6gKM1oXixoA+c/FbTgdhEJdidSV5s2qLjWO5CUZXhH0z+iMb
         yADqIHTOia0EQ==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Deepak R Varma <drv@mailo.com>
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
In-Reply-To: <Y+p2Hn0nrtHiKwPR@ubun2204.myguest.virtualbox.org>
References: <Y+p2Hn0nrtHiKwPR@ubun2204.myguest.virtualbox.org>
Subject: Re: [PATCH] ASoC: codecs: wcd934x: Use min macro for comparison
 and assignment
Message-Id: <167639769504.3067697.10737050637043506910.b4-ty@kernel.org>
Date:   Tue, 14 Feb 2023 18:01:35 +0000
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

On Mon, 13 Feb 2023 23:10:46 +0530, Deepak R Varma wrote:
> Simplify code by using min helper macro for logical evaluation and value
> assignment. The change also facilitates code realignment for improved
> readability.
> Proposed change is identified using minmax.cocci Coccinelle script.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wcd934x: Use min macro for comparison and assignment
      commit: ec285cb999c145f70631f13a284b4696102d06ef

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

