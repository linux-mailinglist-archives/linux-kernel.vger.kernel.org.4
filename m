Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067B9665391
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 06:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbjAKFUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 00:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjAKFSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:18:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B4CD2D1;
        Tue, 10 Jan 2023 21:10:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD3C5B81AC7;
        Wed, 11 Jan 2023 05:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B9DC43392;
        Wed, 11 Jan 2023 05:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673413802;
        bh=sBGq/6gm6lHYU6JbQMcf6XYftdsY4Hf33Iya+7biK5Y=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=vIGuflyUGB4GWYui2FkWc5OzcanZe1tbKNdIr+I8/NAm0WOdCuQjZL4+H21c/2AHV
         8MKqZ9sHaALzikdC2NMxatrh0fiRMdY4Pj8lVR70qEkKGDF19WDdRUPaDNl6XC5ByV
         JzO5qxaWcleHGDL3ee8lhZ3GjS4UgA4+tN2ZvvHdBWVppPnIvxikMCe09ko8KPskjn
         bZI1nvNFBvKGvvyr8wKTx56gpxlsTXEibRKJ33awu1XERAQwPeNvrOnmJY1BVDj07L
         jYMSmCkFKpXg/59umHorOvn1R0EjiZwjPwHntXhAK1C5AJNdQfEU6qGyCft4JBTrSj
         xECxSVJdel06g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-clk@vger.kernel.org, vkoul@kernel.org,
        konrad.dybcio@linaro.org, devicetree@vger.kernel.org,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, linux-arm-msm@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@kernel.org,
        robh+dt@kernel.org
Subject: Re: (subset) [PATCH 1/3] dt-bindings: clock: qcom,gcc-sm8350: drop core_bi_pll_test_se input
Date:   Tue, 10 Jan 2023 23:09:27 -0600
Message-Id: <167341377731.2246479.7421647362671607353.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221228140917.118861-1-krzysztof.kozlowski@linaro.org>
References: <20221228140917.118861-1-krzysztof.kozlowski@linaro.org>
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

On Wed, 28 Dec 2022 15:09:15 +0100, Krzysztof Kozlowski wrote:
> Drop unused core_bi_pll_test_se clock input to the clock controller.
> 
> 

Applied, thanks!

[1/3] dt-bindings: clock: qcom,gcc-sm8350: drop core_bi_pll_test_se input
      commit: 3db8732c55c0109ea3a9ff9cadc10871eaba058c
[2/3] clk: gcc-sm8150: drop PLL test clock
      commit: 412df0f95a528dcafd7b21a711ca5deffca68db9
[3/3] clk: gcc-sm8350: drop PLL test clock
      commit: e35b4b9e8353df22c2f3dfa01631af79d0f44d59

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
