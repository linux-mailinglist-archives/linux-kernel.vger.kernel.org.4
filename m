Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C390A60B463
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbiJXRlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbiJXRjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:39:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98F312793F;
        Mon, 24 Oct 2022 09:15:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CCA2612B9;
        Mon, 24 Oct 2022 12:54:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6396CC43470;
        Mon, 24 Oct 2022 12:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666616071;
        bh=eeZYPvtwVp+JRNB1Md+vcFGippA6sW+UcxlVr7+SUcg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UsGupU67EwMHVV33LZE0Cb9ylxlWiUq+US0bTzDouaG8frWvO20c04zCV0kSSS+U/
         Dr+HAuy7ZHVb/FGusmioz/O916c7sOD5HHg/4zKq4Z4rg4Zls298Vyy5HRG/LZFrEd
         5/sCgtMAzAM1Ptj7oGpQ6i+jX2LDU23aeZK/DdRGHrvMAdsE2tU8weJgm35da93pEL
         U509qPro7h5ranOlTxt5j7RbEC6zi9nTUxFyjPiU2ZtrzFhgnZfUI9zXXjzTI9MqeN
         ogvZ2Ft5AppnUCscNG/tGECXKnVNvCGJ4kZxGcTzAHxelwKV5BM6D77S0YSwVywjxJ
         IOEQIwKAs37mQ==
From:   Mark Brown <broonie@kernel.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20221011184119.3754096-1-robh@kernel.org>
References: <20221011184119.3754096-1-robh@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: Convert dmic-codec to DT schema
Message-Id: <166661607011.206380.11913993879232819414.b4-ty@kernel.org>
Date:   Mon, 24 Oct 2022 13:54:30 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Oct 2022 13:41:19 -0500, Rob Herring wrote:
> Convert the dmic-codec binding to DT schema format.
> 
> The '#sound-dai-cells' and 'sound-name-prefix' properties were not
> documented, but are in use, so add them.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: Convert dmic-codec to DT schema
      commit: 8da313ad1bd020859e2ee8a3e8e97e52425e539c

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
