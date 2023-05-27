Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8991713136
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 03:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242694AbjE0BEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 21:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238055AbjE0BDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 21:03:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9661A8;
        Fri, 26 May 2023 18:03:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0C2C654D2;
        Sat, 27 May 2023 01:03:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7565BC4331D;
        Sat, 27 May 2023 01:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685149432;
        bh=1YZMBlAxeMpfDXnXCePbfFkRQKb4pI+4S7UKHvuJhys=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=M0ITsRX31rY/lUUH+l3FFKz0SIvLBUT2tZUuemO677cN2Zp4OD3TdSvncswD3ax3f
         UzquPoqV7xgY1tcoYOLvXlclJPGBDvq/tCvfNgPyKFlQxp5w/bqd/mIzi9ZyMu+a6z
         XvlgfwvUpnBhOmshBmgIQmExUEGd1LYMY25LMh/1iZ7m1ALUMrC0bIGhW50Q6nlKwA
         eplQkTeH3Saw5hmEoaM4mPSQGgH/YUVQXxYSU5+P5jjcQ7Zm5VKhZoyvY9IRjiiFWf
         8MIQouklg67MqPBnHeyTOJ6Pgb7w1Y2X6QPsx7qVIlTKXX7+DzYN+GqqNlmgFgzL6i
         kaqqEHozLUeHA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [RFT RFC PATCH] arm64: dts: qcom: sdm630-nile: correct duplicated reserved memory node
Date:   Fri, 26 May 2023 18:07:27 -0700
Message-Id: <168514964950.348612.12469992113660973985.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230419211921.79871-1-krzysztof.kozlowski@linaro.org>
References: <20230419211921.79871-1-krzysztof.kozlowski@linaro.org>
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

On Wed, 19 Apr 2023 23:19:21 +0200, Krzysztof Kozlowski wrote:
> SoC DTSI already comes with 85800000 reserved memory node, so assume the
> author wanted to update its length.  This fixes dtbs W=1 warning:
> 
>   Warning (unique_unit_address_if_enabled): /reserved-memory/qhee-code@85800000: duplicate unit-address (also used in node /reserved-memory/reserved@85800000)
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sdm630-nile: correct duplicated reserved memory node
      commit: 5b85de0d51776cae7c165ec2785d1be06ebc9f21

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
