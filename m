Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BD1640FAF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 21:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbiLBU7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 15:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbiLBU72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 15:59:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CE0EBC84;
        Fri,  2 Dec 2022 12:59:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20D7CB822B7;
        Fri,  2 Dec 2022 20:59:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E82C43147;
        Fri,  2 Dec 2022 20:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670014744;
        bh=zwk3G/W9G3eInMd5bV6RPwk5PdxVTHRY8sMtXBmGsds=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Bnv1MLY/e9wknW7/fzS/4jzZ7EYtdtOl8n3GW3+9z4d8uicbYDzUQCafzqEHcRvnl
         Yjb2RBKEdsrpoo2choNdMFTlmsYbAHgaRD+0reRtCDmmH1Ksp5f7s7DXd/YFO0D8Fv
         qUmNl9SZDy8EbzHF/EDwMeThKJNeDVOoC+LQqeaGSL1cLplsx0QXt1K4HncSv1d7ov
         ln9/gAC+rvCv4obgrEOuUmaoXXx49LOji4ETkO5GBHClr/sj+28izjxBFTKieoUB30
         g58B3qrnfIfl4LxKdhfLeEKCRcd8omR+x0UQPWcF2QcCF28ylITWXtJBAS86uNhIHG
         9wG+/hpBaoCzA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     konrad.dybcio@somainline.org, robimarko@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        sboyd@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, agross@kernel.org,
        mturquette@baylibre.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: (subset) [PATCH 1/3] clk: qcom: reset: support resetting multiple bits
Date:   Fri,  2 Dec 2022 14:58:50 -0600
Message-Id: <167001472421.2721945.16481256998331888527.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221107132901.489240-1-robimarko@gmail.com>
References: <20221107132901.489240-1-robimarko@gmail.com>
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

On Mon, 7 Nov 2022 14:28:59 +0100, Robert Marko wrote:
> This patch adds the support for giving the complete bitmask
> in reset structure and reset operation will use this bitmask
> for all reset operations.
> 
> Currently, reset structure only takes a single bit for each reset
> and then calculates the bitmask by using the BIT() macro.
> 
> [...]

Applied, thanks!

[1/3] clk: qcom: reset: support resetting multiple bits
      commit: 4a5210893625f89723ea210d7c630b730abb37ad
[2/3] dt-bindings: clock: qcom: ipq8074: add missing networking resets
      commit: bb524058eb5635ee6ecbe3ef154d44088f7a2154
[3/3] clk: qcom: ipq8074: add missing networking resets
      commit: ce520e312918bc8f02d1c6bd58b288c2eb2d23c0

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
