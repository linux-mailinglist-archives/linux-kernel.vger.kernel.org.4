Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067B161EE44
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbiKGJIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiKGJI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:08:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA98F14;
        Mon,  7 Nov 2022 01:08:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A803B80E81;
        Mon,  7 Nov 2022 09:08:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7391CC433D6;
        Mon,  7 Nov 2022 09:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667812103;
        bh=jG8Tb8i3mhlhXZOJ4XYVPxyXO5zYPYcYgiSrwK5hUZg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QT612n31SdiGoT49wT6+GvlM/2RsIGpkw161we8RA6E4DDJfbEM2/OIvzEifTEK8n
         2r19moJ5gvxJlS1L9AjGIOlM8/e9NGbTb8z0e/qH8Zr86b4kschRH+qUE9am8P2+gn
         sgOaKUZEUs+M2DWa/mWhMyoCYLyOrTOtMPiuhM/45Q5sLXG2lO2cxtgYhDTjbxX4vH
         cSYfQoqrIz+9nZ5lMbaimj9lgD3fqdoUQcfdydMGUmZxqlUz18vkzo0HJSAErb959q
         dChyUZGqGxR0J93pXd+7ruevFFKkZVlg35tR4w9ZZh9XcDdtusX8OYAXRvC35je9xA
         xJqRqct8irtDQ==
Date:   Mon, 7 Nov 2022 09:08:16 +0000
From:   Lee Jones <lee@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afd@ti.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: mfd: qcom,spmi-pmic: rename extcon node
 name
Message-ID: <Y2jLAIQcthVLWU9e@google.com>
References: <20221031175717.942237-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221031175717.942237-1-luca@z3ntu.xyz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Oct 2022, Luca Weiss wrote:

> extcon is a Linux-specific name and shouldn't be a part of the dts. Make
> it be called usb-detect@ instead.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> This patch builds on top of
> https://lore.kernel.org/linux-arm-msm/20221031173933.936147-1-luca@z3ntu.xyz/
> But could also be applied without, if conflicts are resolved.
> 
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Same here.  Only 1/3 received.

Can I take this on its own?

> diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> index cf10d62ace54..14aa42057d6f 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> +++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> @@ -123,10 +123,6 @@ patternProperties:
>        - $ref: /schemas/power/supply/qcom,pm8941-charger.yaml#
>        - $ref: /schemas/power/supply/qcom,pm8941-coincell.yaml#
>  
> -  "extcon@[0-9a-f]+$":
> -    type: object
> -    $ref: /schemas/extcon/qcom,pm8941-misc.yaml#
> -
>    "gpio(s)?@[0-9a-f]+$":
>      type: object
>      $ref: /schemas/pinctrl/qcom,pmic-gpio.yaml#
> @@ -143,6 +139,10 @@ patternProperties:
>      type: object
>      $ref: /schemas/thermal/qcom,spmi-temp-alarm.yaml#
>  
> +  "^usb-detect@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/extcon/qcom,pm8941-misc.yaml#
> +
>    "^usb-vbus-regulator@[0-9a-f]+$":
>      type: object
>      $ref: /schemas/regulator/qcom,usb-vbus-regulator.yaml#

-- 
Lee Jones [李琼斯]
