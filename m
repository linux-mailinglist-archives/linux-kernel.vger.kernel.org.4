Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0113E5B6E69
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 15:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbiIMNcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 09:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiIMNcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 09:32:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B2C1B78B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 06:32:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F255861474
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 13:32:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4674C433D6;
        Tue, 13 Sep 2022 13:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663075921;
        bh=F0cqZytYnDM1UyPSUoRFaYeWA37WWne+bdR5WeTUuDU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=RVeOTrx70ClhJ+u3/hFZKiE4NdznV8itDQ54ZlvRZTayU0imDhgxDux0kiR3LYGkF
         SExpFFn+xFNKoMKeI0Yc+DP46uBLCyIUGN+05lYIL6wUdhkzMBjrH5JfKccH5bAKq6
         xCIjiA6gM6/yBkocCWnJYU072SRbShqmumLKnKK0eOkimaTic3PiK4DS27vpV4FPff
         HcEA3HSuxw79hZbO9wEJdyR6AN6TAhEYJ4wHQlnNbQQd7d1ws/adm5KFSeEMRm/0/Q
         MVCjEIWykRyQV1ySASIObu5T+peSkd/VnK8LtviFdAfQhuM5KVkCly4ADv7TeSmall
         lVggVdBoHkLRQ==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, Shengjiu Wang <shengjiu.wang@nxp.com>,
        alsa-devel@alsa-project.org, tiwai@suse.com, Xiubo.Lee@gmail.com,
        lgirdwood@gmail.com, nicoleotsuka@gmail.com,
        shengjiu.wang@gmail.com, festevam@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1663059601-29259-1-git-send-email-shengjiu.wang@nxp.com>
References: <1663059601-29259-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: imx-card: Fix refcount issue with of_node_put
Message-Id: <166307591852.124960.4909394552213550357.b4-ty@kernel.org>
Date:   Tue, 13 Sep 2022 14:31:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-95855
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2022 17:00:01 +0800, Shengjiu Wang wrote:
> imx_card_parse_of will search all the node with loop,
> if there is defer probe happen in the middle of loop,
> the previous released codec node will be released
> twice, then cause refcount issue.
> 
> Here assign NULL to pointer of released nodes to fix
> the issue.
> 
> [...]

Applied to

   broonie/sound.git for-linus

Thanks!

[1/1] ASoC: imx-card: Fix refcount issue with of_node_put
      commit: d56ba9a04d7548d4149c46ec86a0e3cc41a70f4a

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
