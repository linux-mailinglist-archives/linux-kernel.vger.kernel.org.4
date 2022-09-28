Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3B65ED347
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 05:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbiI1DHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 23:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbiI1DGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 23:06:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824681CE920;
        Tue, 27 Sep 2022 20:06:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA1C361CFA;
        Wed, 28 Sep 2022 03:06:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88291C43142;
        Wed, 28 Sep 2022 03:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664334413;
        bh=VMAzbGju3fZO1yAi48S5l4Q6uictYSwvEjvrd3Y5N1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rwjykJ0xECTbJeXauNAF9KKIHuNFYoOhuNJv5qiVzb6RcK4btYDNqEQTTUnagUX/C
         Ies3cenLmfSWjRRuou5m0MqxypX68AKd6ceCrRV0a4NVsNcyOAHgnWH9PZJzVkLwQU
         VaeH2woPHHqjPOJWN9KMdPX57y6yJSbzIThC+rz/iAq++ucsNzF28x1Zgub5q38V7i
         /CEChHalSTPgyYpibXXf5PSulkXSeGyw0e/T4+AQHF8fIZTM6BlsMKfHxxAfaYtT4Y
         J1r10mEzzqU2e0+Es+bj7w+0YlhOoqn53sdPyWte5V3VWczjO1aZgPD7D6/fB34xpV
         CuPPK90Lls3dg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, quic_bjorande@quicinc.com
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v2 0/2] clk: qcom: Add SC8280XP GPU clock controller
Date:   Tue, 27 Sep 2022 22:06:47 -0500
Message-Id: <166433439996.1849007.6883466236437791919.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220926173025.4747-1-quic_bjorande@quicinc.com>
References: <20220926173025.4747-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Sep 2022 10:30:23 -0700, Bjorn Andersson wrote:
> What the subject says.
> 
> Bjorn Andersson (2):
>   dt-bindings: clock: Add Qualcomm SC8280XP GPU binding
>   clk: qcom: Add SC8280XP GPU clock controller
> 
> .../devicetree/bindings/clock/qcom,gpucc.yaml |   2 +
>  drivers/clk/qcom/Kconfig                      |   8 +
>  drivers/clk/qcom/Makefile                     |   1 +
>  drivers/clk/qcom/gpucc-sc8280xp.c             | 461 ++++++++++++++++++
>  .../dt-bindings/clock/qcom,gpucc-sc8280xp.h   |  35 ++
>  5 files changed, 507 insertions(+)
>  create mode 100644 drivers/clk/qcom/gpucc-sc8280xp.c
>  create mode 100644 include/dt-bindings/clock/qcom,gpucc-sc8280xp.h
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: clock: Add Qualcomm SC8280XP GPU binding
      commit: 9f60eb3ec02757ab9441f2463eceddf2c71ec5e3
[2/2] clk: qcom: Add SC8280XP GPU clock controller
      commit: e55d937d8cf391c1fb9afad296948b3697ad96f7

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
