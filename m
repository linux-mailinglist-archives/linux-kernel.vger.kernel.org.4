Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7FD71047A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239426AbjEYExm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239164AbjEYEwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:52:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D489A10D8;
        Wed, 24 May 2023 21:51:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9A52641E8;
        Thu, 25 May 2023 04:51:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09060C433D2;
        Thu, 25 May 2023 04:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990282;
        bh=LQeU6ntrhslkMtyHhKOe5pjvKxEdX13F71zyqpT1yew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nq2jmp9pqaVZYXg/UV4ECuHKnfR8XWm5wlIWcfncUcckvrx6vpp0G/swHfeNByuWN
         Bsk2juARzn3346nbf9ETRmpprfSZYLq9jhVqcZhonOekfaqlTIdwSZK9YXRiIFOv7H
         OiM5qR6HpnrLUhAsdwC7/Xgk0pFstg+EUNRFyXsOBgklJT57l8efyMGaxYeTn1gC7x
         eXP/cdaIHbIgntTQX/y3Pu8CUCPCbMvHslO6jI1kWIXohOtYfD5unMlyCRV7vMFthD
         Q4UzvavvECDIDyZoZ6pBcDn4oYYIeUncezvgZHkJPTcf7H51CLTPc02AL7WK48oxtE
         zxNY55pG4mVrw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v4 0/2] SM8350 VIDEOCC
Date:   Wed, 24 May 2023 21:54:02 -0700
Message-Id: <168499048180.3998961.8095426719174935924.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413-topic-lahaina_vidcc-v4-0-86c714a66a81@linaro.org>
References: <20230413-topic-lahaina_vidcc-v4-0-86c714a66a81@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Apr 2023 19:32:49 +0200, Konrad Dybcio wrote:
> v3 -> v4:
> - pick up rb
> - include qcom,gcc.yaml in the binding
> 
> v3: https://lore.kernel.org/r/20230413-topic-lahaina_vidcc-v3-0-0e404765f945@linaro.org
> 
> v2 -> v3:
> - Use a consistent VIDEO_CC_ prefix for resets
> - Separate out the binding (and don't pick up the rb as a consequence)
> - drop all pm_clks code
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: clock: Add SM8350 VIDEOCC
      commit: 2aae5eaa941e356b5f6e78c207c7dc3a93286622
[2/2] clk: qcom: Introduce SM8350 VIDEOCC
      commit: fd0b5b106fcab4b1127c72eb818e0e24f0447fc7

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
