Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2402E68FF29
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjBIEdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjBIEdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:33:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3944615F;
        Wed,  8 Feb 2023 20:32:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62A96B8200D;
        Thu,  9 Feb 2023 04:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB6EC433A0;
        Thu,  9 Feb 2023 04:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916515;
        bh=G2r3kSQ1Co7MVTjNBMPUvFWBM5qFAEB7sHgj5pWaJUk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Kjw5M8UH6+kVFIupYwCDNns/EpZjB/xuTMvQQVAthtq9E+OTPb5fONR19mBjVwJUk
         Amo7LZ/l38k3Px3zg60dGeUmcF97xs98B7Q1dZvBEg772G3MSseZrkHev4aJ6uDdzX
         R7vv/fJ4RpWxoWQUYhqUWgo06oQ7jwi+oymb5y0atbju/BQcov94mpr3zv5IzEXqGe
         mp14INmtZwKRxymT3j4EdHR4XLIRg5Aw4jPNBuZG02TABwFEE7vx7Yg/tI0GKvtT1u
         gicRD2FR2BZ+L5cwYsZuabKnQ8O5/XgpnJ31/eQjDxHKaDoo3+jeTEq/xEDfooPMKH
         xD1PZEneYSEwQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Iskren Chernev <me@iskren.info>, Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        Rob Herring <robh+dt@kernel.org>, Luca Weiss <luca@z3ntu.xyz>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH v2 00/10] pinctrl/ARM/arm64: qcom: correct TLMM gpio-ranges and GPIO pin names
Date:   Wed,  8 Feb 2023 20:23:11 -0800
Message-Id: <167591660371.1230100.12926809817038643079.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202104452.299048-1-krzysztof.kozlowski@linaro.org>
References: <20230202104452.299048-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Feb 2023 11:44:42 +0100, Krzysztof Kozlowski wrote:
> Changes since v1:
> 1. Match the driver's ngpios (so usually include the ufs-reset where
>    applicable). Several patches were dropped, other rewritten.
> 2. Add tags
> 
> Best regards,
> Krzysztof
> 
> [...]

Applied, thanks!

[08/10] ARM: dts: qcom: sdx55: correct TLMM gpio-ranges
        commit: 2291bbd74f3869fb0400a6f867e2ec6d2620b1c2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
