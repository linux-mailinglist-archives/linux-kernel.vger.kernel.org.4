Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB206BC16D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbjCOXfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbjCOXem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:34:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C55BA72A0;
        Wed, 15 Mar 2023 16:33:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4394B81F97;
        Wed, 15 Mar 2023 23:32:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBBB9C433AC;
        Wed, 15 Mar 2023 23:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923166;
        bh=jBs6pMzD2j7fxNvrhZNGt6mKNoP+X//nIqAWVmGR7Fc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IvQRicoKr0NUqHPPl7EIuyZBOWh9LIRPtd07T5VlAStwrAiQS98Vw7TSJyVNBGXvr
         5vZNqZNwcU6lGASXpxEGfOebOmtJgOHUmtHOwSYkMzAUvAP7ISXqlyh2RBh61MB6RD
         a4tH8wM07miX256bJh4aXrJEnTArwdm2gCNCp4dKc4K/I6ANmY56gPIr9U3k33329N
         aEEz6CtmTYetF0O8d3mPKQwTXRUHgWOmT0F7g3D8zyYTNZirWka+M8WTn/cT/NNhIv
         +RksrN9pYjrg+XEowNsSJdIEfSSvrngWaDqpMlWtkUI1KFXjEDjyZSFJNTPsQgr3vl
         2RDVfWchnuEMA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 00/12] arm64: dts: qcom: Supply clock from cpufreq node to CPUs
Date:   Wed, 15 Mar 2023 16:35:18 -0700
Message-Id: <167892332566.4030021.3841746461139459755.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230215070400.5901-1-manivannan.sadhasivam@linaro.org>
References: <20230215070400.5901-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Feb 2023 12:33:48 +0530, Manivannan Sadhasivam wrote:
> As a follow-up of [1], this series adds support for supplying clock from
> cpufreq node to CPUs for rest of the SoCs.
> 
> This series has been tested on SDM845, SM8450 and SC8280XP based boards.
> 
> Thanks,
> Mani
> 
> [...]

Applied, thanks!

[01/12] arm64: dts: qcom: sdm845: Supply clock from cpufreq node to CPUs
        commit: 2af2ef08c0ba052aefca20609572d67e0633b1ef
[02/12] arm64: dts: qcom: sc7280: Supply clock from cpufreq node to CPUs
        commit: 667d8a2039608c4c848179cb45282204eadeb157
[03/12] arm64: dts: qcom: sm6350: Supply clock from cpufreq node to CPUs
        commit: afa34380d973491e87ab01d13c387528e2e1c476
[04/12] arm64: dts: qcom: sm8550: Supply clock from cpufreq node to CPUs
        commit: 1b0911fe3edb0895c43db4c19729b3c300028189
[05/12] arm64: dts: qcom: sm8250: Supply clock from cpufreq node to CPUs
        commit: d78cb07dbc1d384a8665b08918d188ee670ec45b
[06/12] arm64: dts: qcom: qdu1000: Supply clock from cpufreq node to CPUs
        commit: fcca74d893f3511a1e95869b1b3db3abb69bfb3b
[07/12] arm64: dts: qcom: sc7180: Supply clock from cpufreq node to CPUs
        commit: 7b39c98ff7e80f7e2bdf3c73829480e6ac123fb5
[08/12] arm64: dts: qcom: sm8150: Supply clock from cpufreq node to CPUs
        commit: fc7258948c4a9e5dd2670adfcc80b13c621fbcd1
[09/12] arm64: dts: qcom: sm8350: Supply clock from cpufreq node to CPUs
        commit: c2a18730f0aaa2088a259f123e5fedf05f8a7041
[10/12] arm64: dts: qcom: sc8280xp: Supply clock from cpufreq node to CPUs
        commit: 2051f735b37d8e49f84914df11eb7b4a3a16349f
[11/12] arm64: dts: qcom: sm6375: Supply clock from cpufreq node to CPUs
        commit: d9ab57eec39db8bf72951e00cde5ab117bcad6d8
[12/12] arm64: dts: qcom: sm6115: Supply clock from cpufreq node to CPUs
        commit: 0e6538e2d973bdfdf4d65a7d4b8baf1b7cdf75f0

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
