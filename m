Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C266ECC5B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 14:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjDXMup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 08:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjDXMuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 08:50:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A086A4C1F;
        Mon, 24 Apr 2023 05:50:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 398E261F5D;
        Mon, 24 Apr 2023 12:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980ADC433D2;
        Mon, 24 Apr 2023 12:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682340608;
        bh=w4fwrxhbHtuiy+0X3eyXx2fxQXeQLMpbJGUtsoKa80k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pb/0Z+3v78GtX2Kvbtxl+dWsYyspmsIXfxA7XRsR9osPJkOSYroGkRNAlsK6L4OEF
         Nlmo/YoYTivQJ1I7bYhJQRQ0VVBepFxB759nTfTWFffv7VXAuvUp+HQ983ZqJ8wF2E
         XMLyCJcAGn0STIEFir0APqFOMhrEkJ06sYEPLKXJAdNYJWpvqHC7ZOFyh8iKxusI2n
         LTqOPa88BLXotga2knNNJNql65A5kj+/KLbiyEI+MxU063Un3WLyPbKbHewFPQQLie
         m5iFixWSqMzoSKI1e3PkGKgrGylS/7NOjLNCNz0Ef70PONuxbWLuS8eBu3IXPoiD/M
         MxlaRdZoRCTvA==
Date:   Mon, 24 Apr 2023 13:50:03 +0100
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: qcom,spmi-pmic: document flash LED
 controller
Message-ID: <20230424125003.GC50521@google.com>
References: <20230416123203.299740-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230416123203.299740-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Apr 2023, Krzysztof Kozlowski wrote:

> The Qualcomm SPMI PMIC come also with a LED controller for flash LEDs,
> already used in DTS:
> 
>   sm8250-hdk.dtb: pmic@5: 'led-controller@d300' does not match any of the regexes: ...
>   From schema: Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
