Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D01A70DF29
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237100AbjEWO22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbjEWO20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:28:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A67E9;
        Tue, 23 May 2023 07:28:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B322F6158A;
        Tue, 23 May 2023 14:28:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5D0C433EF;
        Tue, 23 May 2023 14:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684852104;
        bh=YV/fSjveRhxaxPVhHKWJb6aaBFirYi5GNXQxhdG0qsQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=p/V5oFoDjTdncti0gFXfVQac01Vf63UAW60svjZkcpmmLo/YSSWE7fCgsc5kloD9g
         Hi8KFNuu5apH1I+JAjSOhiPYscItU5Hc7CvnAAc/XU8Gi/+YDoKH0nZHH27ERipxfl
         gn/n/zLdx7+vkNMJQHrWI3UyDd2EnXeI3pIcFb06myhBWbeqaWJHz/2Ui3L5m6+E1B
         eVO38Ur804tkZdPqO54Z5B7x0Sm30JmY6e8w76ndkX8bMBWRapDLtTHaF9uWPBNzPT
         bqnaHuFk3pCmxwI4kkUa1qaLRDk4a1seSqmk8O8br7iTkfKV7rIU0XAY53qjTqtQav
         c0Ktiu8ggCuIQ==
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     srinivas.goud@amd.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20230523090124.3132-1-ckeepax@opensource.cirrus.com>
References: <20230523090124.3132-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v3] spi: spi-cadence: Add missing kernel doc for
 clk_rate in cdns_spi
Message-Id: <168485210277.188599.652228420789425195.b4-ty@kernel.org>
Date:   Tue, 23 May 2023 15:28:22 +0100
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

On Tue, 23 May 2023 10:01:24 +0100, Charles Keepax wrote:
> Add the missing kernel documentation to silence the build warning.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-cadence: Add missing kernel doc for clk_rate in cdns_spi
      commit: b6e4686ca8c3932ed0eee66c016c05c870e44f5d

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

