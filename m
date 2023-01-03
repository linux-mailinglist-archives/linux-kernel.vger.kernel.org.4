Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1184665C492
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238338AbjACRFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238320AbjACREY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:04:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5856F13F17;
        Tue,  3 Jan 2023 09:01:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26961B8103F;
        Tue,  3 Jan 2023 17:01:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3DA6C433EF;
        Tue,  3 Jan 2023 17:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672765280;
        bh=R1Fjj1j1N9yFgter6XWQaPhPtwjErBgobqpSpsgoeHY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ICgEsrPddkbHPGy3so0hkwuZkjNfJ6CNURrXOeHlJlDaEldln8Q+ZcBJuPFfUh2GI
         iae1/JkF0HEgOIMSX5mwk3A0v9LZYQoLPF87ihUC30nwtIuFQvOPpshttWJSMxPC2n
         PJ2OaCEnru0x7eKjTB5AobR2BORjg6fiGRhQF8v/Cl/hFld5ly8xfSaELHTg/riFof
         FSw2pZwFzBBsChs3Yr1rK9A7esXsYVtgGyCebH9CQ8wBoR7Y0OkwVe+0GhUMlb7/nK
         oQOgJWFwpozH7RMeP1ficRGUGSdgY9YgxJOIt3mJKzwGpsVEEjxxv4tW87YypzvZYA
         U/Imny0AYn4RA==
From:   Mark Brown <broonie@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     kernel@axis.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230103152211.3034779-1-vincent.whitchurch@axis.com>
References: <20230103152211.3034779-1-vincent.whitchurch@axis.com>
Subject: Re: [PATCH] spi: spi-loopback-test: Allow skipping delays
Message-Id: <167276527955.184056.18435028327533008188.b4-ty@kernel.org>
Date:   Tue, 03 Jan 2023 17:01:19 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-7ab1d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Jan 2023 16:22:10 +0100, Vincent Whitchurch wrote:
> A 100 ms delay is inserted between tests by default in order to "detect
> the individual tests when using a logic analyzer".  However, such delays
> are unnecessary when using this module for automated regression testing,
> so allow them to be disabled with a module parameter.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-loopback-test: Allow skipping delays
      commit: 392af84bddcc96f1546a1ca4ffa71bccce95b897

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
