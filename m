Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513506CC341
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbjC1Owd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233519AbjC1OwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:52:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F365DBE6;
        Tue, 28 Mar 2023 07:52:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2036B81D68;
        Tue, 28 Mar 2023 14:52:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2383C4339C;
        Tue, 28 Mar 2023 14:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680015122;
        bh=KX7IJV912x3GONHn/38qR81S/BRxmOK0zLKhQFw3hWY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=DztcWDb2N5B9PG9axChu6NJkJ8RdEUUNnl5O+iUV0ZAufXJlcJNaQ18rj/GmwOvnE
         iaErxzdJOJ2ep0vzds8Vzp/aafl+Zmo45IMG0CgU67EL6NtI1/yRMUPq0j4dYPP84b
         9687f1T/lW4ly/Vh0VB3/0sy6A4XgSOp736XciCu9Ir9A5vkvpzvIrEEPsxRsDCAOZ
         n2tkbS0YvGxCscig3d5RnKuj1KbI3nPf0dEKmlSxtjkiNGDn4CSZ5LjHEaZmqTWScp
         3BgjuDnMkNEZyw3ujnDYNzb4okaPlBhqRnU1YZ9EtZ9/PnoA32ANoApwPFERcKR4vR
         vy64mHXJ5WAjw==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     michal.simek@xilinx.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230328061524.77529-1-yang.lee@linux.alibaba.com>
References: <20230328061524.77529-1-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next] spi: xilinx: Use
 devm_platform_get_and_ioremap_resource()
Message-Id: <168001512138.38474.12518288863480198713.b4-ty@kernel.org>
Date:   Tue, 28 Mar 2023 15:52:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2023 14:15:24 +0800, Yang Li wrote:
> According to commit 890cc39a8799 ("drivers: provide
> devm_platform_get_and_ioremap_resource()"), convert
> platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: xilinx: Use devm_platform_get_and_ioremap_resource()
      commit: 0623ec17c45ed3e96880453f69461d526dc97f41

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

