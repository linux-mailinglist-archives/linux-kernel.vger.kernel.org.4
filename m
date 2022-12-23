Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CF965508B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 13:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbiLWMmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 07:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiLWMmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 07:42:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0875BA0;
        Fri, 23 Dec 2022 04:42:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44C7B60018;
        Fri, 23 Dec 2022 12:42:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7E2C433EF;
        Fri, 23 Dec 2022 12:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671799366;
        bh=YfD3JVV5sP68kj+ErzGkuyDkQFWq3S77ymCFb9/TpcU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BB5iKxjv20Ep2TPL8aCghEaIxAlo/QbacO2MCgx8YEfHOBTDq4WHZKxTha9i6KU+B
         47+9a1g5fKIqKfu8+T9MrYHVFI8TDmaGY1+AHaRSSthXddMNIFdpS10BHZKx9c5GV/
         YV/ux0ou9uQHWPQE9bfYzigBgoAjCtgTaLtmyOHMJ9/cl7T7Eim3v/c3tY+hsR+tXc
         yc/W4TNVHhbDc56OyvmQ6QOWjL73HloUeBtgaff5HCY6WsZYp7HBYHDi0QOgFJh7DJ
         odtPgKFMK41L45mnnTSP+tUF+Z0DwUxEZSo9AJ9/M/jQ6ofGIQO07YGgQfu5J+di1r
         u+3uJuW5gkOXA==
Date:   Fri, 23 Dec 2022 12:42:40 +0000
From:   Lee Jones <lee@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fenglin Wu <quic_fenglinw@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: leds: spmi-flash-led: Add pm6150l
 compatible
Message-ID: <Y6WiQKRI/YCbMBhA@google.com>
References: <20221209-fp4-pm6150l-flash-v1-0-531521eb2a72@fairphone.com>
 <20221209-fp4-pm6150l-flash-v1-1-531521eb2a72@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221209-fp4-pm6150l-flash-v1-1-531521eb2a72@fairphone.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Dec 2022, Luca Weiss wrote:

> Add the compatible for the flash-led block found on pm6150l PMIC.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml | 1 +
>  1 file changed, 1 insertion(+)

Who takes LED DT Bindings presently?

> diff --git a/Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml b/Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml
> index 1b273aecaaec..ffacf703d9f9 100644
> --- a/Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml
> +++ b/Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml
> @@ -22,6 +22,7 @@ properties:
>    compatible:
>      items:
>        - enum:
> +          - qcom,pm6150l-flash-led
>            - qcom,pm8150c-flash-led
>            - qcom,pm8150l-flash-led
>            - qcom,pm8350c-flash-led
> 
> -- 
> 2.38.1

-- 
Lee Jones [李琼斯]
