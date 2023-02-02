Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD4B6880DE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjBBPAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjBBPAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:00:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D83FF16;
        Thu,  2 Feb 2023 07:00:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66112B82668;
        Thu,  2 Feb 2023 15:00:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB93C433D2;
        Thu,  2 Feb 2023 14:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675349999;
        bh=CnUBlFZhISK+wfDeUEEFaanpxxSxzsCaFAeWIcOTX3E=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=FhEzZT1Y1yOboVcZwqN1KloTtfVDv2fYazSn7YxIVfE4ih/OBlm5pDQLGyI2KLAnd
         O+svJyQ3jKl0nXOFI7EJdP2zXmO2igGoAguiGGS0PSY8V3WBLgbWTMfd5Xb0WykrJU
         1aEmDhpDj9Z3SNTdTNXKYExADCsgeA5hltkA8auZUJshy7+/gLfrcYzkJSa5NEbG+C
         971Ke4vYHhE/J+DSZIC4jNAqP/RU9UJTGq5H1/XorktPKzqJKf9t9s17S0KGL9Hpvv
         h+CFbKonikP2LjB/3+eAl8hgSwNMRx9Lj3CDqr9BqF+lIABa4HkLiDDXtx9p2DEfzF
         oKA2nMAjR6SQg==
From:   Mark Brown <broonie@kernel.org>
To:     mika.westerberg@linux.intel.com,
        Mauro Lima <mauro.lima@eclypsium.com>
Cc:     alok.a.tiwari@oracle.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230201205455.550308-1-mauro.lima@eclypsium.com>
References: <20230201205455.550308-1-mauro.lima@eclypsium.com>
Subject: Re: [PATCH v2 0/2] spi: intel: PCI driver housekeeping
Message-Id: <167534999769.359854.6364951616234994334.b4-ty@kernel.org>
Date:   Thu, 02 Feb 2023 14:59:57 +0000
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

On Wed, 01 Feb 2023 17:54:53 -0300, Mauro Lima wrote:
> Found some controllers' private data that were wrong according
> to the documentation. Also, the number of Protected Regions from
> Broxton types was changed.
> The second patch adds more Device IDs to the module table.
> Probably good candidates to stable?
> 
> Changes since v1:
> 	* Change BXT to Broxton in commit message
> 	* Sort new Device IDs by hex value in the driver's module table
> 	* Add ack from Mika Westerberg to the first patch
> 	Link: https://lore.kernel.org/r/20230201050455.505135-1-mauro.lima@eclypsium.com
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: intel: Fix device private data and PR_NUM for Broxton controllers
      commit: b4c58d540777124f31ab0cb37a14c6573438d381
[2/2] spi: intel: Add support for controllers
      commit: 7c62a2279b9e88f2cbfa3b92dc49c8b7806c56f8

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

