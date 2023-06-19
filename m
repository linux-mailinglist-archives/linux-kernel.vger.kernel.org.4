Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAD2735FD4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 00:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjFSW3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 18:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFSW3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 18:29:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28EC118
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 15:29:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6828B60E84
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 22:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1966C433CA;
        Mon, 19 Jun 2023 22:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687213747;
        bh=H00mx55kuat8LHbKg+m1U0otLiA7SnikJsD1uUzjQeY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=CnNz6mVMqm4dIS1eU4ZFW/Lj1epriJPXJzQgcjhAjLLMY9STCAfSL2aqOaZvdbz+4
         /EYge/j6NomUrA4i70IZ3UcNrsmnHGxVjphVmbuPuetKDtvOMH+EAxZe1qLnyLQKaF
         ejhq1yZlIkrzlhQpTTe/1yKx16x7sU2u/V86iEfJwRrjbakt8DgNv34i/54d8zl7CD
         us4GXsjsS5MBCZ2NyiScvuUqGApy1tpElSo+G8kEyYXiBCsGSsCuds20Ibh2okARkK
         Cte2Q/qilfGHyZCuxah7WRHpRKaBoGLxllOfZnh7ty40pDK4RjeYhtnngeXv0QXPvJ
         5pEUfGFaNVWpA==
From:   Mark Brown <broonie@kernel.org>
To:     shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, linux-imx@nxp.com, viorel.suman@nxp.com,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230614121509.443926-1-claudiu.beznea@microchip.com>
References: <20230614121509.443926-1-claudiu.beznea@microchip.com>
Subject: Re: [PATCH] ASoC: imx-audmix: check return value of
 devm_kasprintf()
Message-Id: <168721374438.200161.9016810536762850752.b4-ty@kernel.org>
Date:   Mon, 19 Jun 2023 23:29:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023 15:15:09 +0300, Claudiu Beznea wrote:
> devm_kasprintf() returns a pointer to dynamically allocated memory.
> Pointer could be NULL in case allocation fails. Check pointer validity.
> Identified with coccinelle (kmerr.cocci script).
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: imx-audmix: check return value of devm_kasprintf()
      commit: 2f76e1d6ca524a888d29aafe29f2ad2003857971

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

