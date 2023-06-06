Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D46A7245BB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbjFFOWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237300AbjFFOWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:22:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6789310C6;
        Tue,  6 Jun 2023 07:22:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0037061DB8;
        Tue,  6 Jun 2023 14:22:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C2BC433EF;
        Tue,  6 Jun 2023 14:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686061364;
        bh=8njdyfIkRN8M1oyMKTTfWNf9Bc9CabdxuFYIfsE5sL8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=eKSff40uFZqf3p5zk0WlMInJJbGL77vveD5/uMc3sqkZZ/QWK0M7SnnUutao2RT52
         L4/2/zPKwzrt1Bygmv8NMaIsu9rll4rDe4aYsdU6eqsj95k9jDyDPeBo6mvVQqhzFA
         fH18yAfFwUIsxHNlBRT2Bggk3XNeM+GHYNC8baFe6hffyEXg2rBkfnJYgm2SbOP/Qb
         QE6HTf2wZcnn2GbJZxpXzf+J9Na1oa5a3JazFObAv6mCjZlWL15TXjsAKbysmFuDd1
         S/X0leaqSylY9T6U139GXMDOe6DQHF0JMf4Qi3OFJrxwmA9Ho84s457tC6/8Y+l6W7
         x5PudHyaAclRw==
From:   Mark Brown <broonie@kernel.org>
To:     lakshmi.sai.krishna.potthuri@xilinx.com,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230606093859.27818-1-jiasheng@iscas.ac.cn>
References: <20230606093859.27818-1-jiasheng@iscas.ac.cn>
Subject: Re: [PATCH] spi: cadence-quadspi: Add missing check for
 dma_set_mask
Message-Id: <168606136320.36405.16704224342130118084.b4-ty@kernel.org>
Date:   Tue, 06 Jun 2023 15:22:43 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Jun 2023 17:38:59 +0800, Jiasheng Jiang wrote:
> Add check for dma_set_mask() and return the error if it fails.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence-quadspi: Add missing check for dma_set_mask
      commit: 947c70a213769f60e9d5aca2bc88b50a1cfaf5a6

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

