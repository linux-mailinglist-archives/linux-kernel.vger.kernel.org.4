Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826036208B8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 06:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbiKHFCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 00:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbiKHFB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 00:01:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142B9225;
        Mon,  7 Nov 2022 21:01:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A32EF6147A;
        Tue,  8 Nov 2022 05:01:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E7FC433C1;
        Tue,  8 Nov 2022 05:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667883715;
        bh=Ju69A/NQthi2O0jKv6pwT27B2nr1YF6AZ1thtCkqZbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e2eYwKeyNBml7GNO6dNP90WvE7nmnAnWY2uCngcJNOlKqM7+FDmS3+9xPcUes/B6W
         PZpBLuI2ZMTJy+OnVQuMWMldlHm2EDQgmFAeLKk00IYZOC3YT0UB2OM6kS10BK1mWR
         HYMEm/qtbj7gHCj0T7tjaXAh+on58G+QiswW1VHqYBCq5fjjjMkLXav/hRDASmFVEA
         dVxvYp/Xw+bp6ryowcqnGrPaPjJFXb66smdwJXFeMitGvcA5k69xcvlYeTTpdpXW+V
         YuXQuBjST6skxM0ObNmq/riT9anjKdP111Eib7I37chBBKpaD2KNNlEUrbSp3wNGHz
         GphLgBXJWSCIw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     mturquette@baylibre.com, Christian Marangi <ansuelsmth@gmail.com>,
        jonathan@marek.ca, shawn.guo@linaro.org, linux-clk@vger.kernel.org,
        loic.poulain@linaro.org, tdas@codeaurora.org, robh+dt@kernel.org,
        iskren.chernev@gmail.com, krzysztof.kozlowski@linaro.org,
        martin.botka@somainline.org, robert.foss@linaro.org,
        devicetree@vger.kernel.org, mani@kernel.org,
        angelogioacchino.delregno@somainline.org, stephan@gerhold.net,
        vladimir.zapolskiy@linaro.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, quic_vamslank@quicinc.com,
        krzysztof.kozlowski+dt@linaro.org, dmitry.baryshkov@linaro.org,
        vkoul@kernel.org, sboyd@kernel.org, govinds@codeaurora.org,
        srinivas.kandagatla@linaro.org, quic_jhugo@quicinc.com,
        konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org
Cc:     robh@kernel.org
Subject: Re: (subset) [PATCH v2 1/2] dt-bindings: clock: qcom,gcc-ipq8074: Use common GCC schema
Date:   Mon,  7 Nov 2022 23:01:50 -0600
Message-Id: <166788370687.629864.15449040082317704234.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221102163153.55460-1-krzysztof.kozlowski@linaro.org>
References: <20221102163153.55460-1-krzysztof.kozlowski@linaro.org>
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

On Wed, 2 Nov 2022 12:31:52 -0400, Krzysztof Kozlowski wrote:
> Reference common Qualcomm GCC schema to remove common pieces.
> 
> 

Applied, thanks!

[1/2] dt-bindings: clock: qcom,gcc-ipq8074: Use common GCC schema
      commit: 842b4ca1cb8cf547dc63cfe37342f0704454ac2f
[2/2] dt-bindings: clock: qcom: Clean-up titles and descriptions
      commit: ece3c3198182a13825a7f02844894ba6a03d58d1

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
