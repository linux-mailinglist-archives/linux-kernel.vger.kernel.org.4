Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B296B4951
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbjCJPLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbjCJPKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:10:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA58A6EBD;
        Fri, 10 Mar 2023 07:03:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3752BB822E7;
        Fri, 10 Mar 2023 15:02:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0828FC4339E;
        Fri, 10 Mar 2023 15:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678460570;
        bh=bR6o38pte2bX2RJ2Qi0Md1WJSFY/WN5nA5yKZB+fd+k=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=FSYzEDovf3oeByWBK8kGqK2XKsY3ygIZ4TnNd1DCIrQ5bY5Xg4hx27scoKGQJ/gqC
         0pOyus4PjwbYHs8HvBDh/6hsJv12XKaeD3VMPzVg0c25u51feifRSv7QXrCRXr1jCQ
         FkKZlSNsFrDQnRUja/RUxlc3Ndy9fLQe8b0FDEQfxrm3Q7uoN/fNL2xDraIjTh7isb
         JH5YG1jAFgnj8fgK/sHdqPvnFpEbmDX4jCoK6+l9gTC3ayyZT7teQziZXfLtb7rCEE
         BqmfDaK/J8Y+5fZtfowIypORnLl8aDlQPp4HeoIZQa10Ma8X8PPdNWNOh3BIXIACAc
         iwWdXhkcVWixA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     kernel test robot <lkp@intel.com>
In-Reply-To: <20230310111544.57342-1-andriy.shevchenko@linux.intel.com>
References: <20230310111544.57342-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: mpc5xxx-psc: Remove goto to the unexisted
 label
Message-Id: <167846056875.924688.11655271939766506433.b4-ty@kernel.org>
Date:   Fri, 10 Mar 2023 15:02:48 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2023 13:15:44 +0200, Andy Shevchenko wrote:
> The previous cleanup patch had lost one of its parts in a crack,
> Finish the cleanup by removing the leftovers.
> 
> 

Applied to

   broonie/spi.git for-next

Thanks!

[1/1] spi: mpc5xxx-psc: Remove goto to the unexisted label
      commit: 21d19e601fd221cd61105286b0b6ec2f9c5a2576

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

