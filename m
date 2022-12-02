Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F8D640F8C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 21:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbiLBU65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 15:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiLBU6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 15:58:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2FFE98BF;
        Fri,  2 Dec 2022 12:58:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C33F623E3;
        Fri,  2 Dec 2022 20:58:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320A5C433C1;
        Fri,  2 Dec 2022 20:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670014734;
        bh=wGY8lJ1GJAvKkUvM3I4IjwBecvV3JJhgpdjNyFjjw7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lZojk65d1TT90I9vhsVS6+2R6TXdG7fz42pbAqnMePK1UYPfx+zZAxY051WWuUITx
         vGZ5Fn19gnRt4lgy2T+1Bqj7dttr8usJ26jQJzemvfq4nDDGr0H7p1gh92hyv/Viz8
         WhrXd4oRbHk4yrv62iA+wFAWnbEwmjdtjUfnvscmpoMUZiAIN7RAw/CcP8tMS6YoaZ
         MkLYbHtDJXKPZFXx7sEP8TAopKWPOv8S6oCut2M9jXzS/FIAFpBzWxl/wI2Pe4fIaG
         ZVqS6541T/pIOw3GcT5Ih5pyyTY2L46QZu8FiKuKuHgPcFN1c5vhcqfX/w+sNxn32+
         tuwX82LweI/Ng==
From:   Bjorn Andersson <andersson@kernel.org>
To:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        sboyd@kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        abel.vesa@linaro.org, agross@kernel.org, mturquette@baylibre.com
Cc:     linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: (subset) [PATCH v4 0/9] clk: qcom: Add support for SM8550
Date:   Fri,  2 Dec 2022 14:58:39 -0600
Message-Id: <167001472430.2721945.18371070491439646319.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221130112852.2977816-1-abel.vesa@linaro.org>
References: <20221130112852.2977816-1-abel.vesa@linaro.org>
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

On Wed, 30 Nov 2022 13:28:43 +0200, Abel Vesa wrote:
> This patchset adds clock support for the Qualcomm SM8550 SoC,
> It adds support for the new type of PLL, the TCSR clock controller
> driver, support for configurable poll timeout, the RPMh clocks
> and the bindings.
> 
> Changes since v3:
>  * Dropped the GDSC configurable poll timeout patch, like Stephen
>    suggested
>  * Added Krzysztof's R-b tag to TCSRCC and GCC binding patches
> 
> [...]

Applied, thanks!

[1/9] dt-bindings: clock: Add SM8550 GCC clocks
      commit: 47ba9c50bbeb1c5005eb06ca0a2ab92604a54b62
[3/9] clk: qcom: gdsc: Increase status poll timeout
      commit: 7364379d725fc8240a90190dc9da662ada43d9d1
[4/9] clk: qcom: Add LUCID_OLE PLL type for SM8550
      commit: 1de7e70941fff80139df8a37d4b35264543e3fc0
[5/9] clk: qcom: Add GCC driver for SM8550
      commit: 955f2ea3b9e94d0fa20ce3a78ef3063923d41b58

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
