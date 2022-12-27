Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22178656A34
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 12:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiL0L6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 06:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiL0L5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 06:57:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447329FE2;
        Tue, 27 Dec 2022 03:57:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01BE5B80ED9;
        Tue, 27 Dec 2022 11:57:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFFC3C433D2;
        Tue, 27 Dec 2022 11:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672142271;
        bh=bZfJB2u0JwifyT37HdrvtWpabXNKxyHB+8ikOAbuUfc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Oe8l7CqGmdtTHu5NKFrc5orRriJxmtJnJyfRPuzG4Jux8CIxuF4voUB9UD8eFgs/Q
         FfXgOsvbKddzGRjvJN7F8iUrUaxlkKy0B7rUu9hQZtyn1CN5BbtDkUgH11NgmDgDqS
         51IKuXsa9SF34JBEisoPeLF7PCcMxKA2KW3M+olaY8FOqx7Mlmy8hLUsB+qQbG3WcG
         rVegO4/Cl6RRQ/lDtvCmXQECh0p0LlSEKmTqnIHbIwBIoOkCF0pP808KMn5Jlknqdt
         AwYANQqeqZu0+Mh3Cmad2O+xads++G9JYfzpfhgWu17c++rVJfVvuyJJYixoND9KRJ
         0Z3BMtuZ1Hozw==
From:   Mark Brown <broonie@kernel.org>
To:     Witold Sadowski <wsadowski@marvell.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jpawar@cadence.com,
        pthombar@cadence.com, konrad@cadence.com, wbartczak@marvell.com,
        wzmuda@marvell.com
In-Reply-To: <20221219144254.20883-1-wsadowski@marvell.com>
References: <20221219144254.20883-1-wsadowski@marvell.com>
Subject: Re: (subset) [PATCH 0/7] Support for Marvell modifications for Cadence XSPI
Message-Id: <167214226970.88639.17320415439798476005.b4-ty@kernel.org>
Date:   Tue, 27 Dec 2022 11:57:49 +0000
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

On Mon, 19 Dec 2022 06:42:47 -0800, Witold Sadowski wrote:
> This patch series is fixing bugs, and adding support for
> Marvell changes for Cadence XSPI IP.
> It includes:
> - Polling mode support
> - Changes for modebyte handling
> - Busycycles calculations
> - Marvell specific IP changes
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/7] spi: cadence: Fix busy cycles calculation
      commit: e8bb8f19e73a1e855e54788f8673b9b49e46b5cd

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
