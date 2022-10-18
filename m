Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9D760227E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiJRDVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiJRDUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:20:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FDD9C2D9;
        Mon, 17 Oct 2022 20:17:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E0FC6142A;
        Tue, 18 Oct 2022 03:15:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B508CC433D6;
        Tue, 18 Oct 2022 03:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062900;
        bh=XSc/xOHMku0byyKMX33l4+YBlkxl0uqGG660+PyYv9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oZ7xSE0kdA2UsPhdEWZUwdbRfdr1Y4BQIFAB9Muj68uPpwdRACCVRe77raUrYcWli
         M2LZWys2mJT0SLzA/ikDxB0ppW15SId0EKiqtFMfIVNDRKCKsElnyd6Vf3C4Kjv3wh
         IbP4Phmig3+F1J2IEC7jrRTsP2g+Re/DYuTHThCG7wtT3kHQu6weYSsGoBfIgPPu9x
         LtctesHcvb8q9ZZpziBxYMIYeNp66Yz89DpWh7rsPNw005vTwWI+KBA2kihppdPeje
         cieg2/kbBh8YJ6hbJyql5SCg9cDeejIZQ88aTsHidGN/GA0NT1N+zP1dtwAn9+EcHm
         EZdhetuzr5Kyw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     sivaprak@codeaurora.org, Bjorn Andersson <andersson@kernel.org>,
        mturquette@baylibre.com, konrad.dybcio@somainline.org,
        dmitry.baryshkov@linaro.org, devicetree@vger.kernel.org,
        sboyd@kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        linux-clk@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, robimarko@gmail.com
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: (subset) [PATCH v3 1/9] clk: qcom: clk-rcg2: add rcg2 mux ops
Date:   Mon, 17 Oct 2022 22:14:54 -0500
Message-Id: <166606235833.3553294.4443950708165085561.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220818220628.339366-1-robimarko@gmail.com>
References: <20220818220628.339366-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Aug 2022 00:06:20 +0200, Robert Marko wrote:
> From: Christian Marangi <ansuelsmth@gmail.com>
> 
> An RCG may act as a mux that switch between 2 parents.
> This is the case on IPQ6018 and IPQ8074 where the APCS core clk that feeds
> the CPU cluster clock just switches between XO and the PLL that feeds it.
> 
> Add the required ops to add support for this special configuration and use
> the generic mux function to determine the rate.
> 
> [...]

Applied, thanks!

[9/9] arm64: dts: qcom: ipq8074: add A53 PLL node
      commit: fe6d5b8de04780e7ec27037b836324b59fade45b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
