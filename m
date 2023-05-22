Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259E070C1D6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbjEVPC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234209AbjEVPCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:02:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C94C1B0;
        Mon, 22 May 2023 08:02:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D060061ACC;
        Mon, 22 May 2023 15:01:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20F6C4339C;
        Mon, 22 May 2023 15:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684767717;
        bh=hlZb/BcL2ZGEAgC342RcyW00zLOd6SfQlB7LY02Pazc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fBYDK/VPEZYhjWLSZPqkAqfOdR+jeTQ71/52z1/kLFXbdegenn3u/pHS83nbqrIfy
         TKkeJIoRizqKQ5PuZy5/QOJutJwP8bJ3+2T6+mREQvdHgoi5T2MLTTlRRc8pmilO/L
         nPuAoytudjsvm2Uys1tza03C1RbYD9NDLovH0+m2GEWJoCgIhZTo40MGTmLOJVeVtJ
         7oH7KsXZmf9oYBIfaInnOxxdVGiMnh5rcl1WNhmkofyYxMzfvPtKRBOC3qcc5xknZ+
         wXu4zm9JVejw7/dneR4iT6GGtZ5lGUw87TZFstJdtOaMcaz+oNailAX5qep161S/bd
         EU/BD463hKvWg==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Epping <david.epping@missinglinkelectronics.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230519110545.GA18663@nucnuc.mle>
References: <20230519110545.GA18663@nucnuc.mle>
Subject: Re: [PATCH] ASoC: dt-bindings: tlv320aic32x4: Fix supply names
Message-Id: <168476771538.849172.7248234647913395680.b4-ty@kernel.org>
Date:   Mon, 22 May 2023 16:01:55 +0100
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

On Fri, 19 May 2023 13:05:53 +0200, David Epping wrote:
> The term "-supply" is a suffix to regulator names.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: tlv320aic32x4: Fix supply names
      commit: 3a2e3fa795052b42da013931bc2e451bcecf4f0c

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

