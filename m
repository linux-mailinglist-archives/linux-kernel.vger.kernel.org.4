Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889C366538D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 06:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbjAKFUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 00:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjAKFSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:18:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE8413E22;
        Tue, 10 Jan 2023 21:10:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 971C7B81ACD;
        Wed, 11 Jan 2023 05:09:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E091C433EF;
        Wed, 11 Jan 2023 05:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673413798;
        bh=DWfNxBHjl/xswddFCqoT/ztLVWhx0Jz2Y6haU3VbnTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hKaHrvFs5JTbKtWyzkoA+eybCLbuwN5XzJS9Q+OO/PFUq/cIprZWVM+JQ+QtIQbkQ
         gsk+qg7HuaLFXsREtF/Zz3Ol9508jFgVMh5IuycycweuwId4dQXNzRZaDKrsuB/2Tw
         b06UHF5hcH4VQNyczKZ8d01Fh3FaMscasa9YjxA4x/Qlp5SNhOOWn4/2TWVO3LboBt
         eRAn/P4clhqAryngvXGMXSmcgcl5q9m9ACu+d7KjXpmz/SnUKR1KiJD/zM/2JaYLgu
         0WMIU8AnEuaszqGS8NAroUkOeAU8FMCj4JpmrNExnmJ+jxW1DqmqD5BIH2ikyZje1+
         4XbdCJAHoYSeQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, vkoul@kernel.org,
        konrad.dybcio@somainline.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
Subject: Re: (subset) [PATCH v2 1/7] arm64: dts: qcom: sm8450: add spmi node
Date:   Tue, 10 Jan 2023 23:09:23 -0600
Message-Id: <167341377719.2246479.15307317315205485244.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221229103212.984324-1-konrad.dybcio@linaro.org>
References: <20221229103212.984324-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Dec 2022 11:32:06 +0100, Konrad Dybcio wrote:
> From: Vinod Koul <vkoul@kernel.org>
> 
> Add the spmi bus as found in the SM8450 SoC
> 
> 

Applied, thanks!

[1/7] arm64: dts: qcom: sm8450: add spmi node
      commit: f891f86e47c3208986b0985ca1fbc94647ba2ad0
[2/7] arm64: dts: qcom: sm8450-nagara: Include PMIC DTSIs
      commit: 25deb75e99bc57a7860cef2688b032d0e2f979dc
[3/7] arm64: dts: qcom: sm8450-nagara: Add GPIO line names for PMIC GPIOs
      commit: 4c5ab70d11ba591e28d4b07e50847084141c2374
[4/7] arm64: dts: qcom: sm8450-nagara: Add GPIO keys
      commit: 7b2557697890a947e178d4dc20848b479e384123
[5/7] arm64: dts: qcom: sm8450-nagara: Set up camera regulators
      commit: 40430a7c485b5463247b28691ad6a4fc5e280235
[6/7] arm64: dts: qcom: sm8450-nagara: Enable PMIC RESIN+PON
      commit: e9090691e48d2ceabec70448ac893637fbf0e27e
[7/7] arm64: dts: qcom: sm8450-nagara: Configure SLG51000 PMIC
      commit: 0d89bfbcd6d4c2691f5d70b8f2938aeb7774e7f6

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
