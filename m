Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AE36E13BC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 19:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjDMRwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 13:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDMRws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 13:52:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F5E5B82;
        Thu, 13 Apr 2023 10:52:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBB1E63BF3;
        Thu, 13 Apr 2023 17:52:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C93C433D2;
        Thu, 13 Apr 2023 17:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681408366;
        bh=LCzKofwLOiSwAfZihSLFgN+hzyIGSTBPOrKf5+PrROk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=LaJiNxk5sDcXUE3Sgb0WJcGxKY4LJvbXt+eLDDAj5Y85zNqhvIWkcikRuMCjJz7hg
         Zqvj9kRmrw2lVA+qi/+ZQSV+FkXYmYLPAjPckODiB55ny0OKDGksjma6Pwvyyy1stj
         +ky/F9WNHedom2Q5j7ecRNAQ5/G1yOwH1oaqwLhR94czYchFifF+Zi6q/8FS0kBuE1
         Y0voDzon3zf/eMw3iovzdv7lLKkS+eJRDKFEqGhKdjG5FOtTHLFYDmmJB6qw/SGYh8
         wiCHUoD/5eyGU4Yn+grYtcqk8PdBGzpcjnCxM3P8txVldhs5FKDszsBuTmv0e+0uw0
         YPxQIjhNprMDw==
From:   Mark Brown <broonie@kernel.org>
To:     Rohit Ner <rohitner@google.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manu Gautam <manugautam@google.com>,
        Joy Chakraborty <joychakr@google.com>
In-Reply-To: <CAGt9f=TBi3qcbhUPymFGjCFeNNZZ0KQoXSUOT5uA6Dn8PMmnWw@mail.gmail.com>
References: <CAGt9f=TBi3qcbhUPymFGjCFeNNZZ0KQoXSUOT5uA6Dn8PMmnWw@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-loopback-test: Add module param for iteration
 length
Message-Id: <168140836477.1052939.3678951813615163039.b4-ty@kernel.org>
Date:   Thu, 13 Apr 2023 18:52:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Apr 2023 09:39:10 +0530, Rohit Ner wrote:
> SPI test framework is designed to run each test case for
> a list of lengths.
> Introduce a module parameter to limit the iterations
> to a single value among the list of lengths.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-loopback-test: Add module param for iteration length
      commit: 6d87552c0b86b9677d762002082df5f5b7e3c33f

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

