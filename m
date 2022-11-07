Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355C661E96F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbiKGDPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbiKGDOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:14:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B3B12740;
        Sun,  6 Nov 2022 19:13:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4208DB80D9C;
        Mon,  7 Nov 2022 03:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD299C4347C;
        Mon,  7 Nov 2022 03:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667790797;
        bh=98zvi7moc2WiLI5Eo8TJ6PFp+Posb4WFHuUDE9xceUo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MH8AoAjmQi4ySd2aJbgv4TRJm2+TCPP2CQiFg3bpBDIBNGefhaV2baD7LKlZUReJd
         w5aybzpA78BrfKrEt0SJJNCe7U/VgngjQhoQb5hgXhzGfAecUgSdXW5wWHHl3iPtz2
         +6jHWyVMYFhcb+/GFyWBfBCBb9B6aHPfwGTjFDMcG4LOrXI4YhyKsRYk9WvcObNDuJ
         xjsB6Ei4u0f+jpxQ3PWxt24YRsHrrWOwReQVbHvuSbDbyGqWZf9v0Gpz+v3OpHEhcx
         bayx9MJCiEeh0dBHaClYtklKTGepg1EZe99bRxL/13YuV2+XS1xQuXMNIuCk7Qe7Fi
         hJ9QdcfKF1Vzg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     mturquette@baylibre.com, dmitry.baryshkov@linaro.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, konrad.dybcio@somainline.org, jonathan@marek.ca,
        Bjorn Andersson <andersson@kernel.org>, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        quic_bjorande@quicinc.com, robert.foss@linaro.org
Subject: Re: [PATCH v2 0/5] dispcc-sm8250 misc fixes
Date:   Sun,  6 Nov 2022 21:12:33 -0600
Message-Id: <166779074273.500303.15465744246402461201.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221102090140.965450-1-robert.foss@linaro.org>
References: <20221102090140.965450-1-robert.foss@linaro.org>
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

On Wed, 2 Nov 2022 10:01:35 +0100, Robert Foss wrote:
> Changes since v1:
>  - Added new a-b/r-b tags
>  - Improved commit message - Dmitry
>  - Configure dp/edp link parent_hw for sm8150/sc8180
> 
> Robert Foss (5):
>   clk: qcom: dispcc-sm8250: Disable EDP_GTC for sm8350
>   clk: qcom: dispcc-sm8250: Add RETAIN_FF_ENABLE flag for mdss_gdsc
>   dt-bindings: clock: dispcc-sm8250: Add EDP_LINK_DIV_CLK_SRC index
>   clk: qcom: dispcc-sm8250: Add missing EDP clocks for sm8350
>   clk: qcom: dispcc-sm8250: Disable link_div_clk_src for sm8150
> 
> [...]

Applied, thanks!

[1/5] clk: qcom: dispcc-sm8250: Disable EDP_GTC for sm8350
      commit: b5f84650fb0d6ebaa48a5f99183de70d32d0b115
[2/5] clk: qcom: dispcc-sm8250: Add RETAIN_FF_ENABLE flag for mdss_gdsc
      commit: e1a297a681bc4ab2c5cfe31eb4b59bb6f202035a
[3/5] dt-bindings: clock: dispcc-sm8250: Add EDP_LINK_DIV_CLK_SRC index
      commit: c2b6ad72959771730806bbab76aa69e99444bf29
[4/5] clk: qcom: dispcc-sm8250: Add missing EDP clocks for sm8350
      commit: 8305ff41c7426b49090b236da659e2e9bb05fcb9
[5/5] clk: qcom: dispcc-sm8250: Disable link_div_clk_src for sm8150
      commit: f05dbd1a500661a9e3af59f0690301d031140da7

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
