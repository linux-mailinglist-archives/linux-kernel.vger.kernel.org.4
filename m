Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718BD6DFBBD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjDLQs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjDLQsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:48:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7149ECF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:47:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3A0B63724
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 16:46:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E607BC433EF;
        Wed, 12 Apr 2023 16:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681317970;
        bh=XM3VTF9dFi5YbRjKUa+Y6Ssn+YGK93m5lJAYBzcRxNM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=quou7uGDHN7Eds63IyFgKvwdkM9mv+MaJ3NVapQSQq+FaAYhmbcGbGFhX6eIR65tH
         k2hxl+BPcSA2OEfaxRJrECNdBgexCd4PR3z2urRQnVGJDXwBARvFvu4HdLA4/omtDX
         fdE/J1xDeJt/q0kNAlqjENfyIf8Y5ZIOsCKZo04RYiRlg5MZMX0fiTGDOqDXbXWCir
         UHkzfvZ8ck6kwHyH7XS7K4JY+4GPbI8AGTYuOOGGzrMNuWdkDiZuPobwZ/rXcHdJis
         aCw2FhzVM79+aA2ilAbINaAG+WTSFT5ZEHKU6ICiD5xIsu5fvDcUNSefgeOrugaqSo
         lxi7AXCjb4TmQ==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Ying Liu <lyre@hust.edu.cn>
Cc:     HUST OS Kernel Contribution 
        <hust-os-kernel-patches@googlegroups.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230411170912.1939906-1-lyre@hust.edu.cn>
References: <20230411170912.1939906-1-lyre@hust.edu.cn>
Subject: Re: [PATCH] ASoC: tas5720: add missing unwind goto in
 tas5720_codec_probe
Message-Id: <168131796756.93781.9166209265762047431.b4-ty@kernel.org>
Date:   Wed, 12 Apr 2023 17:46:07 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2023 01:09:12 +0800, Ying Liu wrote:
> Smatch complains that missing unwind goto in tas5720_codec_probe.
> 
> When tas5720 has an invalid devtype, it is expected to invoke
> regulator_bulk_disable to handle the failure. But the default
> option return an error code directly. Fix it by reusing the
> probe_fail label.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tas5720: add missing unwind goto in tas5720_codec_probe
      commit: d93ee84e3eb5d1afc081e57ca37f1411a01f2c94

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

