Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D246568A605
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 23:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjBCWTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 17:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjBCWTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 17:19:12 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10FC5274;
        Fri,  3 Feb 2023 14:19:04 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id p185so5425027oif.2;
        Fri, 03 Feb 2023 14:19:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xz7mkrAc9rf4bEO9DpYPqziiB6T4pUaDTbPT9kD5rv4=;
        b=NodZIamsdJOtJN3YyfEMAysb6tWgdjPvkwPqwhHeN1YGsJp/Uh4iVORIWbp5RJtkBF
         2T81yQ72SUPp3+Sy7O0z6erAl03ip99IFUmJ/o1wf3EUBjus0i8IfJq1MQuX+la5ge15
         V/skGJlGnIVbK6DzU95HoLw5JpYonPrj9lKk9Vs/Vc2xpl2+MHT1GKu0wG6zebno/WVF
         6gMT1ATWcFStXRflpJP93fhH7SMXMaVW7svM5OrkqSGyHwtLddGAQJVU2rFpWl8v2ObO
         T7rv/BGyBDbhevadCZqutY7vmMY+GJxd+ZtHfQC/kph7fNVn4hJpin3cvGvpwo2WDfVJ
         H58w==
X-Gm-Message-State: AO0yUKV0A1HLaYP28V/e06Q7DiS2jRO7AjMPsOicqVupHm1S7+T4lhWV
        3QM40XAZ9qCCYzvs/+8QS/YtVheBrw==
X-Google-Smtp-Source: AK7set996pMn13s0+JVwnxBhq8tsU1OIPQspa04bKgq7Mk39OnuHF5ORb+d0WuVlw+/0Gc0z1KYK2g==
X-Received: by 2002:aca:2816:0:b0:37a:bc9b:5a4f with SMTP id 22-20020aca2816000000b0037abc9b5a4fmr4098759oix.55.1675462743812;
        Fri, 03 Feb 2023 14:19:03 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s191-20020acaa9c8000000b003631fe1810dsm1257429oie.47.2023.02.03.14.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 14:19:03 -0800 (PST)
Received: (nullmailer pid 974028 invoked by uid 1000);
        Fri, 03 Feb 2023 22:19:02 -0000
Date:   Fri, 3 Feb 2023 16:19:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] dt-bindings: pinctrl: qcom,sc8280xp-lpass-lpi:
 correct gpio-ranges
Message-ID: <20230203221902.GA973487-robh@kernel.org>
References: <20230203164854.390080-1-krzysztof.kozlowski@linaro.org>
 <20230203164854.390080-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203164854.390080-4-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 05:48:53PM +0100, Krzysztof Kozlowski wrote:
> The SC8280XP LPASS pin controller has GPIOs 0-18, so correct the number
> of GPIOs in gpio-ranges.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml       | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
