Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739C86E13BE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 19:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjDMRwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 13:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjDMRwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 13:52:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42CD5B82;
        Thu, 13 Apr 2023 10:52:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59CEF63FEA;
        Thu, 13 Apr 2023 17:52:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897EDC433EF;
        Thu, 13 Apr 2023 17:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681408367;
        bh=qyS91PanHzUMeAfQVgrySxY+HrWjuWNS+hGwyw6sQYI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=koRJE3om4iIi5S70DPfJu+Iwl5ocTun+J7QPwivsMwDNP+M1Je8Lcy0BtURnPm4uS
         6f+A8/1oNs0d1Oyhn8RRFU4Jw8TAXrTho+964bAhg5Ls1jKLwK7UZRppXl1V8aUTfl
         UBRDFiGFWfYASUueo6eEhzaiz/FF27Rl/b5Sq3RNbHwn7p6I7aKiguL25PxXniM9Qp
         giAGeSSUB9ON9NzmQdBaHLreKvBXr62WHrnGy3OyWDY7OGryMmurpFwrhh9rKl7h3w
         KBNLmO/BzwmqkYdhC+4/FVI6gUM/aA9v8U8GsIZFOY/9gZqR5kgWX1+hIninRemouj
         oOaeqYM7sTFYw==
From:   Mark Brown <broonie@kernel.org>
To:     Rohit Ner <rohitner@google.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, joychakr@google.com
In-Reply-To: <20230412202009.3750955-1-rohitner@google.com>
References: <20230412202009.3750955-1-rohitner@google.com>
Subject: Re: [PATCH v2 0/1] SPI loopback testing framework updates
Message-Id: <168140836629.1052939.12481894863365636618.b4-ty@kernel.org>
Date:   Thu, 13 Apr 2023 18:52:46 +0100
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

On Wed, 12 Apr 2023 13:20:08 -0700, Rohit Ner wrote:
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

