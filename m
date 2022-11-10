Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A213624584
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiKJPTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbiKJPT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:19:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE3F2F019;
        Thu, 10 Nov 2022 07:18:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5509761999;
        Thu, 10 Nov 2022 15:18:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE45C433D7;
        Thu, 10 Nov 2022 15:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668093530;
        bh=kgKU/u3VKcQ55T3MjhKtNEJ0t09lhJwiwebkpZz85oE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=R32zF2OSgQUuGFAwSpLH3jRKdrAWcTfoupnkVWncch4PefQFRNku2C4eUh41PewKL
         Sq3jPi5URhprM82Vx7Ba6SQpj9wT01ZNFQvCg+vvGPknblbunP4+KpYB5NVmQB14UO
         16PG0ibcyovSYX2SGbdp41X/m57KYBMbC+Eqv0fnPG8IQVR+8tYUeZKHPahkVYRfZZ
         0k37ts8hLSQueLR8GJL+e20h3Ok2yo47XIkXfXvAP6aD6DhEyZZ6xEyJKizbZMRWII
         kept+xk7nE8LFQi0YnbnhqwaMzVRT/o61SDlMW8APXyS8oH7wbSlj9EGfO1AXievEv
         MW5fh8FyyLSZg==
From:   Mark Brown <broonie@kernel.org>
To:     andersson@kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>, patches@linaro.org
In-Reply-To: <20221110121225.9216-1-konrad.dybcio@linaro.org>
References: <20221110121225.9216-1-konrad.dybcio@linaro.org>
Subject: Re: [PATCH] regulator: qcom_smd: Fix PMR735a S3 regulator spec
Message-Id: <166809352857.649202.1633856634699573936.b4-ty@kernel.org>
Date:   Thu, 10 Nov 2022 15:18:48 +0000
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

On Thu, 10 Nov 2022 13:12:25 +0100, Konrad Dybcio wrote:
> PMR735a has a wider range than previously defined. Fix it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: qcom_smd: Fix PMR735a S3 regulator spec
      commit: 91016037216b3aaa0fa1b616d388053fb4202835

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
