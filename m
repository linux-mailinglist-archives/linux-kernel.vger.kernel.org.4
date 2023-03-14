Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408706B98FE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 16:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjCNP2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 11:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCNP2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 11:28:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8381844B1;
        Tue, 14 Mar 2023 08:28:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38CEFB819C7;
        Tue, 14 Mar 2023 15:28:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8346FC433D2;
        Tue, 14 Mar 2023 15:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678807697;
        bh=65I5JNrjq3L2NB/1GDeSH5LJoqTISGdDomt4jD2nldE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SZAHD7znl/GkqgTFkA77v7vPan/XhmIZU6Yp68c6FGE4T0BGmzPusl8tuG1a2Li9p
         39W45QlVvW/i21IrKl7hrWYbYqJv/BS0nkaocgc5JBURVLvu9OD7y8mHnKkAvHlJcb
         wNpV3QA0tqHjd2HTZ/frg+b8hk0bjfR4ujdhl68P30ip4Qw6/dp4Ey6timHWXZPC4r
         J4QtRytW9oXZVVHnteDIdcfmA7l7a6pUlgg2IHx3e43ygEPprP66HjpliFlZhFQzVh
         rqM3o0jNAxJkFbt2ewA13JyE1MFmOxWsvMWsGmZesjm7Q+W2qcq/bBBY+ZTA3i85aM
         BWYxEk1ZgcOVA==
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     kernel-janitors@vger.kernel.org
In-Reply-To: <20230314075609.5232-1-lukas.bulwahn@gmail.com>
References: <20230314075609.5232-1-lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] spi: docs: adjust summary to CONFIG_SYSFS_DEPRECATED
 removal
Message-Id: <167880769625.45617.10639491792263901775.b4-ty@kernel.org>
Date:   Tue, 14 Mar 2023 15:28:16 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2023 08:56:09 +0100, Lukas Bulwahn wrote:
> With commit 721da5cee9d4 ("driver core: remove CONFIG_SYSFS_DEPRECATED and
> CONFIG_SYSFS_DEPRECATED_V2"), ./scripts/checkkconfigsymbols.py indicated
> an unresolved reference to the config SYSFS_DEPRECATED in the SPI summary
> documentation.
> 
> Simply, delete the sentence referring to the removed config there. Also
> update the documentation, as these sys/class entries should always be
> symlinks, as the commit message of the commit above suggests.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: docs: adjust summary to CONFIG_SYSFS_DEPRECATED removal
      commit: 93d205457dcda137e73dbfdcaa6a3c4c3b6d505f

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

