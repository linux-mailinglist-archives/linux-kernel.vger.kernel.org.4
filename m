Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72BD5FDB37
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 15:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiJMNm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 09:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiJMNmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:42:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63011112A81;
        Thu, 13 Oct 2022 06:41:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17F70617DB;
        Thu, 13 Oct 2022 13:41:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960D8C433C1;
        Thu, 13 Oct 2022 13:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665668515;
        bh=R7GmJ1Pa4UeNhmrZDrYdeBri3438fwvsRLGHVYf4zkg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rloKGLhjtIM8CAF93xj0IG6+Yj4icf9Ag/FduJN5yeS7vhzHb7VMBJksuwfIm4p6X
         rv6OdcC0QYYiyJIw8Z28dPjxx7+BvJxSDyRiP6gBMxQg7miotrjKTJYdTMQk1h+vN4
         CqVZlYIZSWqzGWFy8W3F4DFubdKa4742RCJE7wmyhJAnr+NtXXPoxRC3labG5hwYIY
         hP9mufFRM05roydXOaX3tNzb7i9WqhVGrn0E+inhM2Ik3o3jmBFYiSalmTcqfBz/qF
         LlnF8goCWgqcEq1AeyqzyURC6FbrspsGg4MPpIgsPy60pqERB2soQIzScwnHD5QEs7
         osXABvslLJ84w==
From:   Mark Brown <broonie@kernel.org>
To:     Mauro Lima <mauro.lima@eclypsium.com>
Cc:     linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com,
        linux-spi@vger.kernel.org
In-Reply-To: <20221012152135.28353-1-mauro.lima@eclypsium.com>
References: <20221012152135.28353-1-mauro.lima@eclypsium.com>
Subject: Re: [PATCH] spi: intel: Fix the offset to get the 64K erase opcode
Message-Id: <166566851432.143409.7076565841669803802.b4-ty@kernel.org>
Date:   Thu, 13 Oct 2022 14:41:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Oct 2022 12:21:35 -0300, Mauro Lima wrote:
> According to documentation, the 64K erase opcode is located in VSCC
> range [16:23] instead of [8:15].
> Use the proper value to shift the mask over the correct range.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: intel: Fix the offset to get the 64K erase opcode
      commit: 6a43cd02ddbc597dc9a1f82c1e433f871a2f6f06

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
