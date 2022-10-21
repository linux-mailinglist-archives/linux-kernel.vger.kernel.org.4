Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A9F6078C1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiJUNm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbiJUNms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:42:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B5E277098;
        Fri, 21 Oct 2022 06:42:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 764F6B82BCF;
        Fri, 21 Oct 2022 13:42:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418EDC433D6;
        Fri, 21 Oct 2022 13:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666359753;
        bh=1Pk0UzocGR/jmjtE7icFYr7u0R9X7fgYwnoCaNSLAbo=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=iYmxUYp13JU4OaVbmFvH0xjqzmw4Uh0HhqYYtGLvTPa/cN+b6rZop4rAQ6yB4obgY
         SjUo8F/Py9XmxaF72z0pMuYcSjxiH6j7YJLPhUznyEJMBCNEplfLeeeZcPYX5bmOSB
         uXNDxrCULwiG99xSAMvqUwPBjW2N6I4Ot6KQCmT/RfdAGLoOOkSBA6iTRteK+QSlEU
         oo3l9Tkz0cWINWWQepBLdLfe++4WY/37RWsSpPSs3J9r2VanremLhJbaOrfjmddw8k
         au9JyfG3lOMMXpQuaB/5PR1rQvhPjqElAKA3Gi9/3Lfk2PyyGGH81KQr0J/Wc4ozTB
         PPXmiKgLGjemA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Jander <david@protonic.nl>
In-Reply-To: <20221020195421.10482-1-andriy.shevchenko@linux.intel.com>
References: <20221020195421.10482-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/1] spi: Introduce spi_get_device_match_data() helper
Message-Id: <166635975198.117321.370272790760800433.b4-ty@kernel.org>
Date:   Fri, 21 Oct 2022 14:42:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Oct 2022 22:54:21 +0300, Andy Shevchenko wrote:
> The proposed spi_get_device_match_data() helper is for retrieving
> a driver data associated with the ID in an ID table. First, it tries
> to get driver data of the device enumerated by firmware interface
> (usually Device Tree or ACPI). If none is found it falls back to
> the SPI ID table matching.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Introduce spi_get_device_match_data() helper
      commit: aea672d054a21782ed8450c75febb6ba3c208ca4

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
