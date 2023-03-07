Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834B86AE754
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjCGQx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjCGQwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:52:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DE699D6A;
        Tue,  7 Mar 2023 08:48:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95236B8198B;
        Tue,  7 Mar 2023 16:48:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5525C433A1;
        Tue,  7 Mar 2023 16:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678207704;
        bh=BQDWbacKIj0sZ5ntfqrCn223xIsx3mwq66IH9bAzQME=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JAogVIjjgiyqT4oIPiknavi9S+d0WhXKnvu4afiFSxI70MnlfmwiecVZ0CTYDUXjH
         vyVKzvyBQO3/6b9skUTUwrBHhP1uCUvmyUdZM/+128tAD196mqYI8Z2SntYR2AEKc3
         mK/JPK7Wj8PPo/oc21D79y3njLVB523cywRhqXdDHNtpSv1fGQ5iDP301rXNf3bOz0
         19MbIJBq+h83dbXoJbdZ4FpVl2ALmosjnvi1mQd3Zr6rd6FPV5aQx7XKUyRWXEVZQE
         bi282tqpPcfXRw1hKYGXfxcgCockvU9yAQo2V0kCkiXQ27ihILsOPyEmSDnQNSz7cj
         Ec2xEeGyszjxw==
From:   Mark Brown <broonie@kernel.org>
To:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        William Zhang <william.zhang@broadcom.com>
Cc:     joel.peshkin@broadcom.com, dregan@mail.com, jonas.gorski@gmail.com,
        dan.beygelman@broadcom.com, f.fainelli@gmail.com,
        anand.gore@broadcom.com, kursad.oney@broadcom.com,
        tomer.yacoby@broadcom.com, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230307012004.414502-1-william.zhang@broadcom.com>
References: <20230307012004.414502-1-william.zhang@broadcom.com>
Subject: Re: [PATCH] spi: Fix cocci warnings
Message-Id: <167820770115.97370.5301180632243342942.b4-ty@kernel.org>
Date:   Tue, 07 Mar 2023 16:48:21 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Mar 2023 17:20:04 -0800, William Zhang wrote:
> cocci reported warning: !A || A && B is equivalent to !A || B. This fix
> simplified the condition check to !A || B.
> 
> Fixes: 76a85704cb91 ("spi: spi-mem: Allow controller supporting mem_ops without exec_op")
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202303010051.HrHWSr9y-lkp@intel.com/
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Fix cocci warnings
      commit: 20064c47f63e995216e0dfb0a6ea37b653ed534c

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

