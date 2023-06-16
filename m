Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2973C733573
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjFPQJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241782AbjFPQJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:09:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BB22132;
        Fri, 16 Jun 2023 09:09:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF6E1624C5;
        Fri, 16 Jun 2023 16:09:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38088C433C0;
        Fri, 16 Jun 2023 16:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686931757;
        bh=35IP0qnBgRimZZwP/gdFMBYC6RjVrtz/V/Ojd+z4dNs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=B2R4R8QoBngnYA6Pf3b/FMfmP9iwKf08axcoCmxF9kr1cL2mgaJY2WEaGG4ssIVzC
         tqU4sCg2TOq5jO5CKSA8w5CYTc3T498aJMlEBZS+BLKZKZuq9N18yI37FdVGAiI5ZJ
         sdG5NExepz6kWdE6MX1Y/N2d8EaFtjny7p1t8LDG1sFHDJsyysgntGfcaK2Mf+aUDE
         PjWTHPiXzylGkpJoUWqixtz6zqk/vm/EFAmZyUcQM1yHz/xTdzYWRAH5aVEPEjHS6l
         nfmcIGmgAe3xqXmcVG/UYNGl6zCgitDmfdpiv5u93C/vJCDTZ1sqS2H3RE2fIh2Svw
         RmWIGD33PgVfQ==
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
Message-Id: <168693175488.294083.14854932147688937012.b4-ty@kernel.org>
Date:   Fri, 16 Jun 2023 17:09:14 +0100
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

