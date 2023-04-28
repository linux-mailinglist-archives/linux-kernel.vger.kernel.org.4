Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71426F1503
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 12:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346023AbjD1KKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 06:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346002AbjD1KKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 06:10:07 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A1949E2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 03:10:05 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f1950f5628so83220825e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 03:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682676603; x=1685268603;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1NdndAiTXiWNg2u0YXHfQ8keyIiYpuxm3CvU9zlYpN0=;
        b=AtNydsNZz7DITiVM0EZYBpno41WmsQE+AmiWQcnaOQhCE0hBAXPcFuAD/xUnR8Bv2Y
         JUGou4a5WAJP+YnIfDk7nUPhjip4z58IedvOeVJM3iW4vW0MeTl3bNTUcN6i/2gCiX3M
         I6Tw0jyZEA88VAJNp9XA7qw15zUlJ5Ih1eQ94xsPNX58vGtqfTQQzuJXemq2+uECAZ2k
         /yv+NOwoMUzA8uGf77XAV/HveBwsaJ+peSc/gyXPz5lgsxkVuEHoJ/htRMVY03iPDAra
         KGDy78En7flIUd1dZYcpyhaF2CizBoYJZKdgJW4crpr3aTtQi0TFfZrukcZiUhYuGHsn
         0+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682676603; x=1685268603;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1NdndAiTXiWNg2u0YXHfQ8keyIiYpuxm3CvU9zlYpN0=;
        b=h2pJVg/9xCOJgLNFw+ER9Ugdo+jKZZG0Zt2fqd+pD3SZcxgfNgqcokOptGcPkd/dc7
         RnH4Tu3Et8DlzptHkLPGtO0RxAcjIOdUchq/NDtynt43DKn6wcrxXSGJIVLxUX1yens5
         IwlgnPO1xu61aiy6HvlcLpAqTlNOH3NVmpYhGtEOPWd3WsfLNSghZV4QIZDlWfZ8RtD0
         zFqjgRzp2aeOH7U31wh3wRLnqrZnoaIZapWcmLLqoABOyGE44yJzqEH/0dasMEOs8T0M
         3xnHiqupSGtiDieGaGWwcolmNxXta0ExWEPGl814qIKdFuFY/P+WKuZ493uTjB3erfOr
         Tdrg==
X-Gm-Message-State: AC+VfDwteKQCvKZLfS4iS7jhwhMh+omw2qNuFDUmsHYgZv2mcUuu+XN8
        3gYABav5haoIIScjje7i7J672g==
X-Google-Smtp-Source: ACHHUZ5GI8YBzZGl5b2BCGJn7Z5rpx8+kgTSSrDTPJ/Bhju7qpO0y+i7u38R0tXwpEKW2llLnrtYNg==
X-Received: by 2002:adf:ef4b:0:b0:2f8:67ee:5ca9 with SMTP id c11-20020adfef4b000000b002f867ee5ca9mr3227987wrp.65.1682676603455;
        Fri, 28 Apr 2023 03:10:03 -0700 (PDT)
Received: from [172.23.3.169] ([195.167.132.10])
        by smtp.gmail.com with ESMTPSA id i1-20020a05600011c100b002cff06039d7sm20616598wrx.39.2023.04.28.03.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 03:10:02 -0700 (PDT)
Message-ID: <3a0bf8d2-957d-63cc-e60d-7225a2c52a7c@linaro.org>
Date:   Fri, 28 Apr 2023 11:10:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/4] dt-bindings: input: pwm-vibrator: Add enable-gpio
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Brian Masney <masneyb@onstation.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230427-hammerhead-vibra-v1-0-e87eeb94da51@z3ntu.xyz>
 <20230427-hammerhead-vibra-v1-1-e87eeb94da51@z3ntu.xyz>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20230427-hammerhead-vibra-v1-1-e87eeb94da51@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/04/2023 21:34, Luca Weiss wrote:
> Some pwm vibrators have a dedicated enable GPIO that needs to be set
> high so that the vibrator works. Document that.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   Documentation/devicetree/bindings/input/pwm-vibrator.yaml | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/pwm-vibrator.yaml b/Documentation/devicetree/bindings/input/pwm-vibrator.yaml
> index d32716c604fe..6398534b43c3 100644
> --- a/Documentation/devicetree/bindings/input/pwm-vibrator.yaml
> +++ b/Documentation/devicetree/bindings/input/pwm-vibrator.yaml
> @@ -32,6 +32,8 @@ properties:
>       minItems: 1
>       maxItems: 2
>   
> +  enable-gpios: true
> +
>     vcc-supply: true
>   
>     direction-duty-cycle-ns:
> 
