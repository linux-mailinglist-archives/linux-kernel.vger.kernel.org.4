Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D24604A63
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiJSPEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbiJSPD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:03:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542A91C2F0C;
        Wed, 19 Oct 2022 07:58:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95E6861908;
        Wed, 19 Oct 2022 14:56:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4C3C433D6;
        Wed, 19 Oct 2022 14:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666191419;
        bh=9Bw0aFAkSLNwxg2hqGz9POPzhqsT/j8ihEWCR51Rcjs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qcg74Qw7KGsQEqZONGxvf3iDzilD0efRtWaDnjLieM38EazJhyp0okwur0gSZovND
         Zw2Chlw0qEVxWQ/s8nD5v689CrMoLSMfum6CYuCA7yk/CN6ZE3OlLLCixoYk4LMbKG
         Huaz0kqakGRjRK8C3wFVWvo7LtpPtbJdfJLpMsTz0xT+Ln+hd+N/UOzr+qGwLhSJ4G
         La+vXCKf6uJkRT0Zb5pMJt0m4DGL/YmdJUUDa2rlRH13fEtlQeDYkS9Vg07weePl5w
         TwOKgYup16B44vdK7FDK2oClVcSfwFA4omrzB4MzTEJDg+/23wM0gIFSX3nfb7QngB
         93J9NNAGxCrFg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        linux-raid@vger.kernel.org, linux-spi@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Song Liu <song@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
In-Reply-To: <20221018215755.33566-1-giulio.benetti@benettiengineering.com>
References: <20221018215755.33566-1-giulio.benetti@benettiengineering.com>
Subject: Re: (subset) [PATCH 1/3] ACPI: scan: substitute empty_zero_page with helper ZERO_PAGE(0)
Message-Id: <166619141690.565256.8563939546728659746.b4-ty@kernel.org>
Date:   Wed, 19 Oct 2022 15:56:56 +0100
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

On Tue, 18 Oct 2022 23:57:53 +0200, Giulio Benetti wrote:
> Not all zero page implementations use empty_zero_page global pointer so
> let's substitute empty_zero_page occurence with helper ZERO_PAGE(0).
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[2/3] spi: fsl-cpm: substitute empty_zero_page with helper ZERO_PAGE(0)
      commit: 3be6acda8241352c57d47b4d7d9968cadcb954ea

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
