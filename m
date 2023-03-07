Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC746AE74D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjCGQxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjCGQwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:52:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CD3888A6;
        Tue,  7 Mar 2023 08:48:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 194C2B8198E;
        Tue,  7 Mar 2023 16:48:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39A8C433EF;
        Tue,  7 Mar 2023 16:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678207706;
        bh=GXI4lu3ZaljEq1OXKcXQrt5Ny7mGmhM/pubQG7ezf6I=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Nx/5zTlkQHg9uB0G6bvU+EdULhBArcMMcJEAtGSs8nDbI2J7YAAwyieXj5UQokFWM
         b0qd074nXE0Lr9yhqzWU+L6+FO4+K5/c7eUC7jTArChRcP2RHY8GlvMZ+HIfi+E51D
         Cx8puH2tIVpaB+c/nSIXVinO673GbSg57DvxjKT3lZ2DP5zYu2tOQ8CFsdvR5rDLS4
         zFja9bXfVxiXIhgOKt19tda0V5B5lvY66QFl1/tLJVEUHklmKo3GO++d+tYlvwwckj
         ibBbQYtw4GtoHvQwz+qYQljCWtFiZCK0iZMVIyLPVA4fVfx2XoolYMc5OMqeSUzzVk
         WI6LHRi3xiB6A==
From:   Mark Brown <broonie@kernel.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Md Sadre Alam <quic_mdalam@quicinc.com>
Cc:     quic_sjaganat@quicinc.com, quic_srichara@quicinc.com,
        quic_varada@quicinc.com
In-Reply-To: <20230306144404.15517-1-quic_mdalam@quicinc.com>
References: <20230306144404.15517-1-quic_mdalam@quicinc.com>
Subject: Re: (subset) [PATCH 2/5] spi: qup: Use
 devm_platform_get_and_ioremap_resource()
Message-Id: <167820770450.97370.6271727230451860246.b4-ty@kernel.org>
Date:   Tue, 07 Mar 2023 16:48:24 +0000
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

On Mon, 06 Mar 2023 20:14:04 +0530, Md Sadre Alam wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[2/5] spi: qup: Use devm_platform_get_and_ioremap_resource()
      commit: dc2eb79496322d5f4790d38776c487bf7aa69be3

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

