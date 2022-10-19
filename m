Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D628604E4E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiJSROA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiJSRN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:13:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F381D0650;
        Wed, 19 Oct 2022 10:13:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0AD79B8256F;
        Wed, 19 Oct 2022 17:13:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00C5C433D6;
        Wed, 19 Oct 2022 17:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666199631;
        bh=CL8cFgCw4ynN/G27qFiFYik2sE93rrVtsedtuYFWlfE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=cAR7LEv8bcDRMmWE4fl8ZIoXaiVuUExHveg5/wrWUUIM/jR5j5Xq3Vn6qbGZzByNM
         cHs8mqwBb0Lljtyz718ImUaOAvTUJg5hV+oCJt3UBYLsdIwQrPWfuuGf5DObnyIgLt
         l8ZWPhJ4cjQNB6OEThInIyCTdQshfe2xdLmmmbFQfALNy25HQdkRrTqx8wTFpmPnoR
         gSaQlhgry0XUOYaOgmiqU/85Mj7xtSY3+ycaUxw7hm3QOf318/8WOZF5uuqKG/eSwv
         8n+tLbInCRiHN4DFP6v34MKszzfR5yYgssVHmv7ATiiJubcCIQP8qqbfTm5cYHvxjz
         My6tJydShahdQ==
From:   Mark Brown <broonie@kernel.org>
To:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc:     linux-arm-kernel@lists.infradead.org, michal.simek@amd.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        git@amd.com, linux-spi@vger.kernel.org
In-Reply-To: <20221011062040.12116-1-amit.kumar-mahapatra@amd.com>
References: <20221011062040.12116-1-amit.kumar-mahapatra@amd.com>
Subject: Re: [PATCH v4 0/7] spi: spi-zyqnmp-gqspi: Add tap delay and Versal platform support
Message-Id: <166619962963.1416921.6108066747778177545.b4-ty@kernel.org>
Date:   Wed, 19 Oct 2022 18:13:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Oct 2022 11:50:33 +0530, Amit Kumar Mahapatra wrote:
> - Fix kernel-doc warnings in GQSPI driver.
> - Avoid setting CPOL, CPHA & baud rate multiple times.
> - Add Versal platform support in GQSPI driver.
> - Add tap delay support in GQSPI driver.
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/7] spi: spi-zynqmp-gqspi: Fix kernel-doc warnings
      commit: b3b953084b1bd0e74785bc5017444dd56952fb39
[2/7] spi: spi-zynqmp-gqspi: Set CPOL and CPHA during hardware init
      commit: 22742b8bbdd9fee1ae30be49c7e7e3becba96fc1
[3/7] spi: spi-zynqmp-gqspi: Avoid setting baud rate multiple times for same SPI frequency
      commit: 21764a49d32e041e9d118a7b38c14e3e02fae129
[4/7] firmware: xilinx: Add qspi firmware interface
      commit: 1e400cb9cff2157f89ca95aba4589f95253425ba
[5/7] spi: spi-zynqmp-gqspi: Add tap delay support for ZynqMP GQSPI Controller
      commit: fae7b3c3ecd76a911a1f0e45d2258a420559cbf6
[6/7] spi: dt-bindings: zynqmp-qspi: Add support for Xilinx Versal QSPI
      commit: 824590249b3cdf57d090d4c912f1497b8e61458f
[7/7] spi: spi-zynqmp-gqspi: Add tap delay support for GQSPI controller on Versal platform
      commit: 29f4d95b97bcabc0cd83c34495224b24490f0fe0

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
