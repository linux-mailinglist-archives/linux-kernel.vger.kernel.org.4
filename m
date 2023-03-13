Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D3D6B8167
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 20:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjCMTIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 15:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjCMTIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 15:08:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDFD9740;
        Mon, 13 Mar 2023 12:08:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 898916148F;
        Mon, 13 Mar 2023 19:08:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4587EC433D2;
        Mon, 13 Mar 2023 19:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678734480;
        bh=5jfl9/hlfxAkBs3SczAn6QYlPXw9oRLcWoCeAZ5s0Zk=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=qy4U8EsWT9qdg/BRniO8wddtjYJExE2O0HT9PPvdGgN9jxC9enNuu0Z2Xtn6G5UV6
         bC2miBMO0DXSvemVXs/Hszmr1FNrHmFOE7RB+89UH8vKMXUESE5FPnILrYViv7OGND
         Ujak4aldgjlCMSP3Kxf0WBF7ll03WguZ6QiafKA9bJqTwbXFJst7It72+zJ36tOr7n
         hA2wnnUlRTAwHVynEBeKhK7Tuze5tkj5aEza8sWAfagHejYDOQsY+FCUOEeFV+sr7h
         CAeElN01aEgm7N6Dh8pFbIsc3bBpxnphPQlc5Kt83f/PNAjReRabIhaizmmBcarWh7
         8/KD0VLoPzSAA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tony Lindgren <tony@atomide.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230310214553.275450-1-krzysztof.kozlowski@linaro.org>
References: <20230310214553.275450-1-krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH 1/9] regulator: lp872x: Mark OF related data
 as maybe unused
Message-Id: <167873447700.106292.3339315429044423313.b4-ty@kernel.org>
Date:   Mon, 13 Mar 2023 19:07:57 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2023 22:45:45 +0100, Krzysztof Kozlowski wrote:
> The driver can be compile tested with !CONFIG_OF making certain data
> unused:
> 
>   drivers/regulator/lp872x.c:931:34: error: ‘lp872x_dt_ids’ defined but not used [-Werror=unused-const-variable=]
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/9] regulator: lp872x: Mark OF related data as maybe unused
      commit: 70b26bb55f719e2900404459128d41c8425c8dde
[2/9] regulator: max20086: Mark OF related data as maybe unused
      commit: 4a5850865641d0b83caaad81ca0bbd722ac514fb
[3/9] regulator: mp8859: Mark OF related data as maybe unused
      commit: 334e6b85a348a79bb018003f09e1cc94accd53a2
[4/9] regulator: mt6397-regulator: Mark OF related data as maybe unused
      commit: 38cc873cb1cf27965dacbbc5957a7a8aee89679c

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

