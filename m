Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595366A0983
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 14:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbjBWNHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 08:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233716AbjBWNGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 08:06:52 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5EF5651C;
        Thu, 23 Feb 2023 05:06:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EF2D2CE201E;
        Thu, 23 Feb 2023 13:06:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93945C433EF;
        Thu, 23 Feb 2023 13:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677157608;
        bh=zk4Z9NhjUU4W9/EJooPy1rmIwKzBqjWLIDsnoY8KLMI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=cMNkAN9VEDwwjARfxZQ++9XOJZRfxYAG0XpP/COi1Kiqn57IQCpvPPWrog37HBLz/
         2WICqEZ8slKVV5l8oJJsN6w+B6yrZS1zRgF6FsLdhalunrQSemHLfbMesIjUfdkulE
         muTaW8tkteHCiWmmUODP1MwfVf9MxeqVMBAkcKItnEYOn4R7aL3bp5FKEYt1VtzP0S
         dQSJd43xVDTRD9VmWrq0XRv2Xr8NOZV3chJRi1jdKdHTxp57OmAmeWSxokxPXI4fY2
         w5kRRAtrdUTPJdD1n4mdm78eC4kdZhZPOMCvltCWfumYHLxxlUfkznOm8ORD9KrMQs
         +dt5A2CCsZTTw==
From:   Mark Brown <broonie@kernel.org>
To:     Hongbin Ji <jhb_ee@163.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230222092128.4237-1-jhb_ee@163.com>
References: <20230222092128.4237-1-jhb_ee@163.com>
Subject: Re: [PATCH] spi: cadence-quadspi: Fix cancel the indirect read
 mask
Message-Id: <167715760732.62178.5640570174976583616.b4-ty@kernel.org>
Date:   Thu, 23 Feb 2023 13:06:47 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Feb 2023 17:21:28 +0800, Hongbin Ji wrote:
> This is to cancel the indirect read transfer process,
> so should be use CQSPI_REG_INDIRECTRD_CANCEL_MASK
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence-quadspi: Fix cancel the indirect read mask
      commit: 152ac60677aa3760d0850de0db33d495f55e8aba

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

