Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F155638C5F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiKYOib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiKYOi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:38:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9481C108
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:38:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1481CB82B0C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 14:38:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8A7C433D6;
        Fri, 25 Nov 2022 14:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669387102;
        bh=iuTi+FfhIxjv1xdL+qu3A8EUi5IhPdwJ2hWZj4UxQlA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UInR8Tp9VfIP1TsXq7DZrl14Tk2LkRVLxwnnVahrgi9yU9WjnGX3IKd+b9BZKtgYf
         jTSvV870xpbnmB5GU/k9tESu66Dnelmz+qAwLaOYNwRSlVvIUCGulMu48Y9gWi8OUU
         vF9d1YdC31PF+V30mYxPvWtG64HrClFz46/je9KKI2y2IUsCBvwIKi4Pl1rjWpbxRM
         ToJ+RiQKTdGLu1u+JOXSIE3vBO1hnto5s6Rc3g9UCnFh0/y732yVwqul9HQPSLcqND
         vVEBPPDz1yfTTe0YEKQCcmHFf+xyvUfkA3UzvwGRZk+uUrZhWvoIzpSw8bf7zxAovY
         fsKDn6iRv/vjg==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com
In-Reply-To: <20221124134556.3343784-1-rf@opensource.cirrus.com>
References: <20221124134556.3343784-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH 0/2] firmware: cs_dsp: Switch to using namespaced exports
Message-Id: <166938710147.543323.1489768823749219688.b4-ty@kernel.org>
Date:   Fri, 25 Nov 2022 14:38:21 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Nov 2022 13:45:54 +0000, Richard Fitzgerald wrote:
> Use EXPORT_SYMBOL_NS_GPL() instead of EXPORT_SYMBOL_GPL() and patch the
> three drivers that use cs_dsp to add the MODULE_IMPORT_NS().
> 
> To make the namespace more specific the KConfig symbol for cs_dsp is
> changed from CS_DSP to FW_CS_DSP.
> 
> Richard Fitzgerald (2):
>   firmware: cs_dsp: Rename KConfig symbol CS_DSP -> FW_CS_DSP
>   firmware: cs_dsp: Make the exports namespaced
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] firmware: cs_dsp: Rename KConfig symbol CS_DSP -> FW_CS_DSP
      commit: d7cfdf17cb9d072b41547e7cc882ecd900aa6589
[2/2] firmware: cs_dsp: Make the exports namespaced
      commit: e57d904ac4be6de7ecc9083f51a9a38f72482f82

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
