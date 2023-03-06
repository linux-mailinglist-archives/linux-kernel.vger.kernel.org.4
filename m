Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A221E6AC03E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjCFNFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjCFNFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:05:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7502C656;
        Mon,  6 Mar 2023 05:05:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CED4BB80DA9;
        Mon,  6 Mar 2023 13:05:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611D1C433D2;
        Mon,  6 Mar 2023 13:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678107906;
        bh=OmU8l36xufyDkaO9yoRR1VAuUSrBSxNw7CTRX3T1zAc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=TIOAWS2yZAMhm5gM3FjHwBpnqcfNmstb1sm/7d62iOOb8xvjAqgDlwWOW0qxCQVru
         KVB+cTvg41NwKfEyidHR4qXBdSxrmfZAjnXXt1PubhMb8ZdXMzwi3fWquWzqpJ12SP
         XUnv5ocWunPLxcYKV+6iHXM0Kj05Tml1Oua3hsaMEHZrbhsPwS11zAHOLONSL55M8I
         jJl2OnSLDeuuqCG4H1xxRxg8d+4TY6YSKrwUXT4QBjw9y0TWhS/x4oyq4hpZGGvdx0
         TEoiJJtVkWKInAmf1Sp8sx96z/vC6ClW5gQuUlLkrCrGyMYbirewUm2iHzEmFwehn9
         wcHexJUYOni2Q==
From:   Mark Brown <broonie@kernel.org>
To:     heiko@sntech.de, Lizhe <sensor1010@163.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230226065125.14086-1-sensor1010@163.com>
References: <20230226065125.14086-1-sensor1010@163.com>
Subject: Re: [PATCH v1] drivers/spi-rockchip.c : Use
 devm_platform_get_and_ioremap_resource makes code better
Message-Id: <167810790510.67440.1015244482940855027.b4-ty@kernel.org>
Date:   Mon, 06 Mar 2023 13:05:05 +0000
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

On Sun, 26 Feb 2023 14:51:25 +0800, Lizhe wrote:
> use devm_platform_get_and_ioremap replace platform_get_resource()
> and devm_ioremap_resource()
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] drivers/spi-rockchip.c : Use devm_platform_get_and_ioremap_resource makes code better
      commit: d447fa6564788af2b8729f66157e1220ecf6d136

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

