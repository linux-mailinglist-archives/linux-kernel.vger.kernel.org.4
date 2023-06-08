Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37410728396
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236961AbjFHPTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236978AbjFHPS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:18:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BE52D6B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 08:18:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CDA26429C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 15:18:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08915C4339B;
        Thu,  8 Jun 2023 15:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686237535;
        bh=888/DxeFCwjXrc+J1zDYpuICndnlmtRdgBJJ0xu/IAg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=I+DycyAhSkOd+4Wez5SB1rOYpE7PV3N4tkT7idceTf0k9T4OM4hW1SkcXmjdpvON2
         nU6tMvndC4VV/pon/gjLXqteWE9kSP+K0QhgTui9XnpTtb7KD9GJ7W9nywMqhIVqtb
         +dGXLiPuWm4+Rijjwcsuv8oddu0tAAOhCKGju7K8Gf2mRRRxkwZhscJqv9ANBfpK93
         FaB01lE6Ieqr53h0Lfe5Hg8XUdWSftcGJrBdYuJdY0ovCvlQBAhe3Ek2p80Wm8p/Fc
         z0s5/yysdeThANACa72wFpv7/etM1fNKbCIs10zlHDA991iReAmHRnQaAnc3H16W/D
         aj3g2Dc8jUnDA==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20230608075540.61575-1-jiapeng.chong@linux.alibaba.com>
References: <20230608075540.61575-1-jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH] ASoC: max98088: clean up some inconsistent indenting
Message-Id: <168623753375.1002486.15353648412458244656.b4-ty@kernel.org>
Date:   Thu, 08 Jun 2023 16:18:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Jun 2023 15:55:40 +0800, Jiapeng Chong wrote:
> No functional modification involved.
> 
> sound/soc/codecs/max98088.c:316 m98088_eq_band() warn: inconsistent indenting.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: max98088: clean up some inconsistent indenting
      commit: 3b3a8d6d34a3ace4d49beb6f69ebb0d3cfaf0479

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

