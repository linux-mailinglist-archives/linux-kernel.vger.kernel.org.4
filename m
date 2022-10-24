Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C330E60AD3E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 16:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbiJXOTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 10:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236997AbiJXOP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 10:15:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CABF50BAB;
        Mon, 24 Oct 2022 05:55:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BFDF61346;
        Mon, 24 Oct 2022 12:54:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45FAAC433C1;
        Mon, 24 Oct 2022 12:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666616073;
        bh=R1hLjeE/13RmZT9ufBz7rWLCq9H/tdDCnbvNc5MNSl8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=S7KytBzrEgUtUvhGpSBPw7Ci7Dxyb9OFPQEbkKVNQlekdg+ZQ4mJD3y8aEOzncjew
         raradZC55KujNvnu2t3Wkr/opFo1x5/QrOcSlOD8p5SmKKiBZKiEK8ainnHCkV7Vam
         cc//z2BK+Sj83zqcBD74KQGINKt9CztkjbKXhm0OSmmu1z9avL875s4v8UTegY4LDu
         VzG8SFuGv3N55n3iVRXsQgxIv6sHe5cPPLv/Zr1LlnDau04jbbR483flnOBHVK47hD
         OUTWxy+IJwIobFo/Qk3bZuy21AXjptm2Z5gCKLHj5/h5AvSUUkzVsFXkmls4YqSosP
         DhWPGoEo8Zmgw==
From:   Mark Brown <broonie@kernel.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20221021175721.4005601-1-robh@kernel.org>
References: <20221021175721.4005601-1-robh@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: Convert dmic-codec to DT schema
Message-Id: <166661607199.206380.14009012211378211408.b4-ty@kernel.org>
Date:   Mon, 24 Oct 2022 13:54:31 +0100
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

On Fri, 21 Oct 2022 12:57:21 -0500, Rob Herring wrote:
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
