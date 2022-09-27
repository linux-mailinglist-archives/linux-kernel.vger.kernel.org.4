Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83755EC36D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbiI0NAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiI0M7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:59:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B127F50185;
        Tue, 27 Sep 2022 05:59:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08E6F61965;
        Tue, 27 Sep 2022 12:59:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329B8C433D7;
        Tue, 27 Sep 2022 12:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664283591;
        bh=BSMIKJNSh2UY7QcBDbGnHiB8Z9/zuSk77eFA25iPrYA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=TP3jMC8TxSwQTANEvrCHalkWW8MMNfHVWAlA4oD7xkq4YoPkoLV+71w/28Rtx8Dpx
         Fss7T8HWH0rUxOgCPdhme2NqzMsW88PaXYQJnTsp5oXu+iivTLrgI9AO7bJeL6G9Te
         18zkBdNzghB9nFdj/g+UD7+YJN1Cc//ZtB1i/qSb+8U5tvAl3m6Q3JHBEozEuVCKeM
         NSbikZJVgMPyFLmKFuIJRFQwDbebT3QTTdZBtr28Rj/WSFIgqFp0CHhQ9L68UZ+3zD
         zdUHEJmYmwJ7WZcwsjfJYXbYlnXj6kHspv7/3lbJ783c2sy/uB+qft+Ilku/ynhdV4
         +kSUhioD9fzNw==
From:   Mark Brown <broonie@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <YzIcZ11k8RiQtS2T@work>
References: <YzIcZ11k8RiQtS2T@work>
Subject: Re: [PATCH][next] ASoC: SOF: control.h: Replace zero-length array with DECLARE_FLEX_ARRAY() helper
Message-Id: <166428358991.365276.17332366204767237765.b4-ty@kernel.org>
Date:   Tue, 27 Sep 2022 13:59:49 +0100
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

On Mon, 26 Sep 2022 16:40:55 -0500, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members in unions.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: control.h: Replace zero-length array with DECLARE_FLEX_ARRAY() helper
      commit: b264ef796959cb65cdbc811da5ab950e33df4162

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
