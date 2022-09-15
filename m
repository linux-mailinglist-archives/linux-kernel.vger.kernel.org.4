Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395C05B9357
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 05:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiIODiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 23:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiIODhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 23:37:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCE39321A;
        Wed, 14 Sep 2022 20:37:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB528B81D09;
        Thu, 15 Sep 2022 03:37:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550A3C43152;
        Thu, 15 Sep 2022 03:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663213036;
        bh=HRk4TI/jrSBRyB95U3j2n9f8xwzK0CzqkaoD0MH3gjw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m9xwAtsfEwJ9R5xsuGnP0xsyhE+MOObYZagyyQcd5e96vRUmgsaiU7y4ftOTLbUqV
         bFWXPBoTBG7j9ng3SWgki7h18m9+fAaKxoP6+AUNq/Gl/pyCsskhSIQ2ar34IpFTJL
         y4i24ZlvY1meSYlgJRfyJHaLbPdQEjEh4+J94G7NPCaofdo+wvo1b1pMl+ToZsdcfH
         cpl1JaOdvOpW/Gbh2wGJ2pIbQX9f3x3eE185V7fF+8FTDZqpSp+r8WfEBwP2TByadQ
         l2oS1JqsiaBvEHZeRVv0vbe3stipwJB1UruzoWee2Boxh2y8rfFEeRx9ShCgA6+9Du
         XKvYc0eB32xfg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     mailingradian@gmail.com, linux-arm-msm@vger.kernel.org
Cc:     mturquette@baylibre.com, agross@kernel.org, sboyd@kernel.org,
        konrad.dybcio@somainline.org, jo@jsfamily.in,
        linux-clk@vger.kernel.org, robh+dt@kernel.org, caleb@connolly.tech,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        krzysztof.kozlowski+dt@linaro.org, tdas@codeaurora.org
Subject: Re: [PATCH v3 0/3] SDM670 Global Clocks
Date:   Wed, 14 Sep 2022 22:36:58 -0500
Message-Id: <166321302049.788007.6695561688193069480.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220908231224.209020-1-mailingradian@gmail.com>
References: <20220908231224.209020-1-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Sep 2022 19:12:21 -0400, Richard Acayan wrote:
> Changes since v2:
>  - drop GCC_SDCC1_BCR reset
>  - reorder gcc-sdm845 and gcc-sdm670 if statements in bindings
>  - add space
>  - accumulate review tags
> 
> Changes since v1:
>  - regenerate patches to fixed malformed patch
>  - fix schema so that the parent clocks are specified correctly
>  - remove core_bi_test_pll_se from new parent_data to match array sizes
>  - reference correct frequency table for gcc_sdm670_cpuss_rbcpr_clk_src
>  - set correct index for sdcc1_ice_core_clk_src
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: clock: gcc-sdm845: add sdm670 global clocks
      commit: 657e9326658c1c570eb1e8fd122a4a7936433673
[2/3] clk: qcom: gcc-sdm845: use device tree match data
      commit: 8e90216d2db99f0b883be3b40d5b581437dc4a5d
[3/3] clk: qcom: gcc-sdm845: add sdm670 global clock data
      commit: ae66b1fe48e2dd91229f2b8f25295bce629382d0

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
