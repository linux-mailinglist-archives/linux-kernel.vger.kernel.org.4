Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB66710512
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240011AbjEYE6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238359AbjEYE6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:58:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744EE1FD6;
        Wed, 24 May 2023 21:52:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77959642BB;
        Thu, 25 May 2023 04:51:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9D1C433D2;
        Thu, 25 May 2023 04:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990294;
        bh=zTM6DdMQNVdtwAM/1d0VLKSLo6VWjufkAf79npGHoNo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=uHd3kJCos02om/GjtraZ5TAWsdyExa4KHzK/fh8Gm+nxMEJgfHukxSt0PWSpfBELC
         VBSxF/X0R0ICOShJJ6zSubjI175rmSDD3wSiFtPgdVLNT5ENpR16j9fIIhAZHZZS2G
         IwXqdAQoQ43dz6egSkB0p76Ch3kZP/9VOPIfa70kEqquHh9jB49locZjtrfhRFopN1
         DFs0BR9qdYaBxEC+oVTKjHOhjIrQVXVZpoT3hkLr6EfDgt89a4aMXQFl4YcFeTBCaE
         jVghG56J+9q0eM4o3OyxkJ4IV8ZGxB4HvNg0KC/MiRDiu3HaShyfuFjd0msBJ0Z0r4
         iBDQXIYwy0QzQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Adam Skladowski <a_skl39@protonmail.com>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-clk@vger.kernel.org,
        Sireesh Kodali <sireeshkodali@protonmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Taniya Das <tdas@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH] dt-bindings: clock: qcom,gcc-msm8953: split to separate schema
Date:   Wed, 24 May 2023 21:54:14 -0700
Message-Id: <168499048182.3998961.8632788520430791444.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230408143729.84097-1-krzysztof.kozlowski@linaro.org>
References: <20230408143729.84097-1-krzysztof.kozlowski@linaro.org>
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

On Sat, 8 Apr 2023 16:37:29 +0200, Krzysztof Kozlowski wrote:
> The Qualcomm MSM8953 GCC clock controller has clock inputs, thus
> existing gcc-other.yaml was not describing it fully.  Move the binding
> to its own schema file and document the clocks based on DTS.  Add driver
> contributors as its maintainers.
> 
> 

Applied, thanks!

[1/1] dt-bindings: clock: qcom,gcc-msm8953: split to separate schema
      commit: 2f9b2096465da9f7eada1c3b297689b666a015cf

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
