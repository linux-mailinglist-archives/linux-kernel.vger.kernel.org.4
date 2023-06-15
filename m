Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584B6731BCE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344611AbjFOOv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344731AbjFOOvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:51:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A26A2962;
        Thu, 15 Jun 2023 07:51:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92DC66267B;
        Thu, 15 Jun 2023 14:51:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C47EC433C8;
        Thu, 15 Jun 2023 14:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686840707;
        bh=35IP0qnBgRimZZwP/gdFMBYC6RjVrtz/V/Ojd+z4dNs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=lhvvoeomcJXsSNNPQzcw26So9kTQAKyrUIah7vPX6Vd7qwiEBWDbnoILQ7odPtHAF
         EoVWZKPU/gzRQa7Bmz0EHCR97OoTXMMUL3pcRz0YzDbx9WgkhaSIEIa7U3BTP/4R0f
         1AJsE2vTYNkBdM1ZxLfV581DRCCnE3ZdGeLxCjHf7zQnYhG4NBpIF9Z7vn+RTtDKne
         pBoYLBMJzwLYrVHGZKimIa4DI94uzWrAoshuSm8lfhrBX5Gxpc+OwvzajYOWbO3A2I
         YQak09dza+dhpiYc/8S+PEikq0n3eh56o5fbjbSRPDiZWGIUfspLkswNbfxtQA4IwY
         uFqaLVceRfT0A==
From:   Mark Brown <broonie@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Carpenter <error27@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230615-topic-sm8550-upstream-fix-spi-geni-qcom-probe-v2-1-670c3d9e8c9c@linaro.org>
References: <20230615-topic-sm8550-upstream-fix-spi-geni-qcom-probe-v2-1-670c3d9e8c9c@linaro.org>
Subject: Re: [PATCH v2] spi: spi-geni-qcom: correctly handle -EPROBE_DEFER
 from dma_request_chan()
Message-Id: <168684070419.561998.2376284587741517242.b4-ty@kernel.org>
Date:   Thu, 15 Jun 2023 15:51:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jun 2023 14:51:45 +0200, Neil Armstrong wrote:
> Now spi_geni_grab_gpi_chan() errors are correctly reported, the
> -EPROBE_DEFER error should be returned from probe in case the
> GPI dma driver is built as module and/or not probed yet.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-geni-qcom: correctly handle -EPROBE_DEFER from dma_request_chan()
      commit: 9d7054fb3ac2e8d252aae1268f20623f244e644f

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

