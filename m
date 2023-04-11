Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C956DE295
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 19:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjDKReS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 13:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjDKReO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:34:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D3D65B5;
        Tue, 11 Apr 2023 10:33:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DB646200A;
        Tue, 11 Apr 2023 17:33:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA6CC4339B;
        Tue, 11 Apr 2023 17:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681234432;
        bh=ScMA2ZLrRu9taa5IpwTR7DDfb0acMaFdpECEOOkl7Oc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=i7r9+z+qDXFqq8/KDKOj1TPB+VYfdv/2dvD2gi0kaQ61lxfdOObCaXkp3Di8VY9bG
         u0geIPFCEgig+y/jEWpQmUNP1owtXZwKg7lRGCEd7KhDIgjRkxBtJ0yagyZn9NHT1n
         FJ8pAD/+Yaxp2T3iT7M+UpguZsZcueVMAchD3ONqg4Rf+2pc2S7Foa8ncUQAFsdmzm
         8SrfbZ1Y7q+X/b0ofHlQhDTtv5pnaJbMbnxg1s+lIevlCPdoHTiRKMys2waQENzo37
         U6qJ2DPp++F2VzE4m5K4n4wgsRl5G4O5hWbF+cjYDHPKGOKSel1dPBE5eVrs4U5PGr
         y1/hrMleBZ/OQ==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.baluta@nxp.com,
        Saalim Quadri <danascape@gmail.com>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230405205820.6836-1-danascape@gmail.com>
References: <20230405205820.6836-1-danascape@gmail.com>
Subject: Re: [PATCH] ASoC: dt-bindings: wm8711: Convert to dtschema
Message-Id: <168123443056.491748.13637746465528590932.b4-ty@kernel.org>
Date:   Tue, 11 Apr 2023 18:33:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Apr 2023 02:28:20 +0530, Saalim Quadri wrote:
> Convert the WM8711 audio CODEC bindings to DT schema
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: wm8711: Convert to dtschema
      commit: 25500613de4a867d16068b28faa963cd3ce0a11a

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

