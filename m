Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A2F73ADC8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 02:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjFWAcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 20:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjFWAcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 20:32:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB491FF6;
        Thu, 22 Jun 2023 17:32:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E465F61901;
        Fri, 23 Jun 2023 00:32:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC72C433D9;
        Fri, 23 Jun 2023 00:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687480341;
        bh=EjrF3HDt3RyfZDfXrX+WQ/ORgsApGiY+Cl6RD/uJWfg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=LOHG41zn1XS4ny8ZCgGD1vPbFadZKjmexxkSYAsxKoiLS//ssEbPthdsd80wsR6ph
         Ka3CXEaJNh+DnWDjr1UVVbT3ItiBTCTMGsxsIPEsV7fk6MaLEkn3dnlme505VU37ai
         xse9AJsKKSf7sKCOjwRD2zHXD0xSIX+sWlR59mjQdILbFZ9MX9tjx5y9w3ZmMaYkCI
         l9tnjQg9+PVpWLFJ2brDQpRPFS65B9FhqVFPgSYuDMyD8GDsBhbSNYFPGr/CW2An5f
         thB1Z1h93S3HIbT5BCZ2rBNB4JAQCM8SaKJO/5TCY0l8ZmSlm8VIEPwEwbhoTDgjFp
         A7khtKt/0Bi1Q==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Valentin Caron <valentin.caron@foss.st.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230621115523.923176-1-valentin.caron@foss.st.com>
References: <20230621115523.923176-1-valentin.caron@foss.st.com>
Subject: Re: (subset) [PATCH 0/2] spi: stm32: disable spi device mode for
 stm32f4-f7
Message-Id: <168748033693.332493.10302724879165095478.b4-ty@kernel.org>
Date:   Fri, 23 Jun 2023 01:32:16 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2023 13:55:21 +0200, Valentin Caron wrote:
> This series follows this thread:
> https://lore.kernel.org/all/20230615075815.310261-1-valentin.caron@foss.st.com/
> 
> As STM32F4-F7 hardware can handle device mode and stm32 spi kernel
> driver can't, a restriction should be put in the kernel driver and
> not in the device-tree bindings. This series fixes that.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[2/2] spi: dt-bindings: stm32: do not disable spi-slave property for stm32f4-f7
      commit: 01fa9edd8bcf1c4fe330ea000c3da9ecf76c76a0

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

