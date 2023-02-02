Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8456881BF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjBBPXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbjBBPXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:23:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE86A277;
        Thu,  2 Feb 2023 07:23:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 479DDB826AC;
        Thu,  2 Feb 2023 15:23:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD114C433D2;
        Thu,  2 Feb 2023 15:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675351414;
        bh=0YIlhLQM4vruCq5Gzqgsdm7w/F6iwRUJvFRBV7ba3nU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hGHOPS9h9OO2OydzGQsguIxn9y10+P6scImajKzEEcw0MwvTg6k5dxz20bertJZqk
         taPrZikLRyw4da7wNVyfOBx0VNrZloTZQLhgTSlkR3zfvB98JnOs9uZZBKgxWlOQW/
         E87kdo5y+I0bPnXVADWiaDujfx7O0Y+/rC8pXRchZhZKKs9fiLiBKsjk3uEu4ntbzM
         1bo//LsrbKKgrJQL+FOvGkGqzICKwZyfRrPqkVNeGni39D4QJ62Ds2q5CKph/iJNUm
         CYYdRLQ/BnP/bl7zAYNir+i8rSWgiyLbVFqdTLIoHEHIS6/P15n1CvDWZdJRG163P1
         ZO17vvtE96nuw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Bruce zhao <zhaolei@awinic.com>,
        Weidong Wang <wangweidong.a@awinic.com>,
        Nick Li <liweilei@awinic.com>, alsa-devel@alsa-project.org,
        Colin Ian King <colin.i.king@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230202103236.270057-1-colin.i.king@gmail.com>
References: <20230202103236.270057-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] ASoC: codecs: aw88395: Fix spelling mistake
 "cersion" -> "version"
Message-Id: <167535141146.392917.9691227972443524961.b4-ty@kernel.org>
Date:   Thu, 02 Feb 2023 15:23:31 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Feb 2023 10:32:36 +0000, Colin Ian King wrote:
> There are spelling mistakes in dev_err messages. Fix them.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: aw88395: Fix spelling mistake "cersion" -> "version"
      commit: 2a096315be7d8ccad883203876c4b53e7b024f12

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

