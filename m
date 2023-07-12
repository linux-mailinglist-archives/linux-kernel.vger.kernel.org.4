Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33BC75068D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbjGLLq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbjGLLqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:46:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DD91BC1;
        Wed, 12 Jul 2023 04:46:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B1C76179D;
        Wed, 12 Jul 2023 11:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6FAC433CC;
        Wed, 12 Jul 2023 11:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689162408;
        bh=TfYXCDxUmVUxSwQOO9/NMcMApKt7tS2ywxqe784ZU2s=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ExmBsOQqJe3sMrBHNa6sBltdfVww5GGgVG69y/XJgG4ZToDjr+hUayOgITI3SKFnS
         9IbEe+ViobENcNR4klosGGZncfa9i+OHHA6WPQE+q2TescPnibLAohJggRPQpldSRc
         0f5ppmK5qbNAkQxJ8Bz0ReabzetYktb76AiAOoxKyykm0VnS2+fNB3V+lXvhWbaWwJ
         dWSic2EF3tcjdZAIyLwOeyyO5irRrUQv6iORKU3SqzM1UBLWK7esF37cdnhX75FEnq
         HpbWesuGjMvEa2J36BU4/IOlSzq10nmpTU2jHIwK8OB7Z1kc3tSiYJouWiVv2LKzp0
         kG9Qa0ihYrOQg==
From:   Mark Brown <broonie@kernel.org>
To:     Seven Lee <wtli@nuvoton.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, YHCHuang@nuvoton.com,
        KCHSU0@nuvoton.com, CTLIN0@nuvoton.com, WTLI@nuvoton.com,
        SJLIN0@nuvoton.com, scott6986@gmail.com, supercraig0719@gmail.com,
        dardar923@gmail.com
In-Reply-To: <20230628085009.1130318-1-wtli@nuvoton.com>
References: <20230628085009.1130318-1-wtli@nuvoton.com>
Subject: Re: [PATCH] ASoC: dt-bindings: nau8821: Convert to dtschema
Message-Id: <168916240469.46574.6320216062589774248.b4-ty@kernel.org>
Date:   Wed, 12 Jul 2023 12:46:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2023 16:50:09 +0800, Seven Lee wrote:
> Convert the NAU8821 audio CODEC bindings to DT schema.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: nau8821: Convert to dtschema
      commit: 754d1ce3ab6bec057bf94b0ec1a789fdfa2fef99

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

