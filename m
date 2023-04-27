Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276336F0844
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 17:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244088AbjD0P10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 11:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243459AbjD0P1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 11:27:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DDCE77;
        Thu, 27 Apr 2023 08:27:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3264063E03;
        Thu, 27 Apr 2023 15:27:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF75C433EF;
        Thu, 27 Apr 2023 15:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682609234;
        bh=ZMfG9rQkUBCVBemVFSxX50F+m1nW1cv86EFsQgIAWEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pnXc0ylkh9q/jM2PnA39QsHQXqVzpV7Gad/zrX6dX0xnfcEFVBT3uDfXCFPFldcNl
         f7AT1XLUa/QPO+hYHjWozOgupVJUjgZx2CozAl12i6tLUdh9Ep+d+u7w7P4H+R5704
         s6Ll1GMAIIuMsTo9cI2hpODtibFcmfDiRg5BzjqN66U8K4qn4i+GFQlxJPaW5VcnoC
         TtXwosLkItXsMUx47S+oNvw+359h0bZl8c4C+RP8FfKcyqoDkIK59FX4Am4ZwiBMZj
         G32EyI+ermUTBGaRJ+chZhndLx1jtvA4WU/xV5AZHfd1tsSryWLULrEeTsWDpUSvLs
         mXUjtTiAzuZ8w==
Date:   Thu, 27 Apr 2023 16:27:07 +0100
From:   Lee Jones <lee@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 3/8] dt-bindings: leds: qcom-lpg: Add compatible for
 PMI632 LPG block
Message-ID: <20230427152707.GZ50521@google.com>
References: <20230414-pmi632-v2-0-98bafa909c36@z3ntu.xyz>
 <20230414-pmi632-v2-3-98bafa909c36@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230414-pmi632-v2-3-98bafa909c36@z3ntu.xyz>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2023, Luca Weiss wrote:

> Document the availability of an LPG configuration for the PMI632 PMIC in
> the Qualcomm Light Pulse Generator driver.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
