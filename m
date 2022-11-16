Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FEB62BF8B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbiKPNc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbiKPNcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:32:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E439310B51;
        Wed, 16 Nov 2022 05:32:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2258B81D6B;
        Wed, 16 Nov 2022 13:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFA5C433C1;
        Wed, 16 Nov 2022 13:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668605539;
        bh=jFGKEfQQbGCD/j4UEo0N6QMzhSY1t6SzCIdm7MFDUQs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=bPyhe/ixEk1ekLVz0R2ZobNZE9k+8eymFbzjOxsKa6SSe/LPvcMRe3IYo/zfW4diR
         4wOrjXEus4EXJ0Fla2IO+Hetrr74LrCkGz98u67CS18iGtXBk9YD5MqSbbax16vPDD
         HmHEJ7oqsPRVINQOlREsljJyv6vYOwDsmOWm88DxHFPaQcHGao9x0wFoqBcQeg6z5p
         MpfVIFT21DRVV/SsfawwuGL68bZIFENYY6bcb/5i5daOXSAuf0oqAfHv2uErSqxjSW
         f8XsxNLQNrsmUCd0PJOg/7N0LLUhDN+S+sSpfexmNSn0OSLMvxuAQ4+pWdTO2CQOmP
         WzW3zeu9zvWHA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>, andersson@kernel.org,
        agross@kernel.org
Cc:     linux-kernel@vger.kernel.org, satya priya <skakit@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        marijn.suijten@somainline.org
In-Reply-To: <20221110210706.80301-1-konrad.dybcio@linaro.org>
References: <20221110210706.80301-1-konrad.dybcio@linaro.org>
Subject: Re: [PATCH] regulator: qcom-rpmh: Fix PMR735a S3 regulator spec
Message-Id: <166860553633.379853.16102975186102879241.b4-ty@kernel.org>
Date:   Wed, 16 Nov 2022 13:32:16 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-8af31
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2022 22:07:05 +0100, Konrad Dybcio wrote:
> PMR735a has a wider range than previously defined. Fix it.
> 
> 

Applied to

   broonie/regulator.git for-next

Thanks!

[1/1] regulator: qcom-rpmh: Fix PMR735a S3 regulator spec
      commit: dd801b2265c81bf0c8b0b4b8f7c1e7bfed078403

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
