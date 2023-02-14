Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8628B696EE6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 22:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjBNVLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 16:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBNVLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 16:11:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9242C64F;
        Tue, 14 Feb 2023 13:10:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5353DB81F45;
        Tue, 14 Feb 2023 21:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32572C433EF;
        Tue, 14 Feb 2023 21:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676409057;
        bh=HD1ISLM5lR2mxdGtaRP5sSSF6X+8UXQiKbNdusbp/DU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=HB4xruaRmvHLzor2o8vsVzmCxN4VoU+S/gYg2g6rpOpOCGKEjUbuey8Ze9MA08rEX
         +D1pdSSiuhARUgl6Qu26gt5rvtjoC6Ha3PDW8NzPKMUzUgBwY7/VpV76pSbT+eFxZz
         2Fxmq0Z1R08gmn5v9zmimtMwAaQG0QIvRdg1bEDysuL5ZXLF+6une6p0nqutKvPPnF
         sl2f1NFQ0YLNLQ1yJ+SMPeEyzqrSFkIElGu4DqkVQ8KjOU/9SJzZ9Omh6GHTFSPTNJ
         PmODppzxpK1krUPPlFNAJGfYtxf4KJUmg7c8A6f6o97voXNbaXaq78WhXruGRgHGhr
         Sa4tuEHXR/wvw==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Alain Volmat <avolmat@me.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20230213192349.17101-1-avolmat@me.com>
References: <20230213192349.17101-1-avolmat@me.com>
Subject: Re: [PATCH v2] dt-bindings: spi: spi-st-ssc: convert to DT schema
Message-Id: <167640905417.3115947.11894015148325637579.b4-ty@kernel.org>
Date:   Tue, 14 Feb 2023 21:10:54 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2023 20:23:48 +0100, Alain Volmat wrote:
> Convert spi-st-ssc.txt into st,ssc-spi.yaml for the
> ST Microelectronics SSC SPI driver.
> 
> 

Applied to

   broonie/spi.git for-next

Thanks!

[1/1] dt-bindings: spi: spi-st-ssc: convert to DT schema
      commit: 7ec844a2c7535e4c4991e7e453baca85e156f7c1

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

