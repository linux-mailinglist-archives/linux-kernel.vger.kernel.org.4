Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2931686A79
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjBAPgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBAPgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:36:15 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCA8DBD5;
        Wed,  1 Feb 2023 07:36:14 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-163adf0cfc4so12732499fac.7;
        Wed, 01 Feb 2023 07:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=NFYUq1UHHpAPd1DZlwdJHjaueRcQBU3XOakS876IeHw=;
        b=fLMHcwSqAFQlV+yeyrftFdJhak/zLnuEc7k2FNTTtfw55UWXnnG+/bjM3GKCeuKSvP
         /3vTqM5K0uVPSn8D5ikg8OQ18ZJmQ7Gn26lLK/JThMc657ioMpEGfDRm+NLemq6DooJN
         N9+35wyEEYb/OpqTL8x4IqhL8kEf0iYVWw1LIJWUrListUJ1vuBFQW85EXCqXkcH8Ygf
         QRBcgWu1zQOxey6JObOV97foENfGfdPz/d/81UMZ189Fz1ZxjEo9fw8Mk0dKfAKrdUWs
         ONaPLt+7Otsi6BZB9CPcMKXSnspIysRcGzh65NHFm0ZbKTwsMqn1+FN8nmAoz7+XrtUa
         rAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NFYUq1UHHpAPd1DZlwdJHjaueRcQBU3XOakS876IeHw=;
        b=knX7hb3QMPFBXWx1eCdj2IvIyGBPwgm5o5uUaECgqqpgIAcP+vEZO9/8OhfHYKROO4
         hcbOhivstMY9BiFesxsDrcdC9Z5F3dmem1VkzzFsMgTrAj1ljQ20v42UVWpIXfW7d8Si
         n6h1wyOEeAnZd4mvct1rbHL+oKUVg1PPRE48ZndXYlewhOzjcyhs2NLphoDACvN9XJE5
         M1lIOebRSZ664HDpXc+9MMPr9P/lQA8r/l8WaDp8TprkTxEMlU9/xVNfBk0tP81+PNuM
         cX+5U+goXlsQ0h/0PYl14x/A15LkYFFibkStJJf5OHguFIAk5ZDatrsHdGl1Sbx75CAa
         HnFA==
X-Gm-Message-State: AO0yUKXdCeE9j1pNvKd3S/JXhACoukTpej++SjyJ3achKaRdef2hXJYd
        h8mnrWbYY1jA7tOuSllNw4XYDgqt+os=
X-Google-Smtp-Source: AK7set8JX0xBRBNIW+Fwk0Ten3Ro26q5ALiTbACElfPSe9co2byEHbj+qo/r+hoEbVobWUNLQ/7yig==
X-Received: by 2002:a05:6870:6487:b0:163:5c8a:d150 with SMTP id cz7-20020a056870648700b001635c8ad150mr1423715oab.14.1675265772611;
        Wed, 01 Feb 2023 07:36:12 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id et10-20020a0568705cca00b00163263f84dasm7819228oab.12.2023.02.01.07.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 07:36:11 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <fab39e83-63ed-89aa-376f-e03ebce3d3a5@roeck-us.net>
Date:   Wed, 1 Feb 2023 07:36:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 3/5] dt-bindings: watchdog: qcom-wdt: add
 qcom,apss-wdt-sa8775p compatible
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20230201152038.203387-1-brgl@bgdev.pl>
 <20230201152038.203387-4-brgl@bgdev.pl>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230201152038.203387-4-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/23 07:20, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add a compatible for the sa8775p platform's KPSS watchdog.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> index d8ac0be36e6c..27fb484d5f8d 100644
> --- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> @@ -18,6 +18,7 @@ properties:
>         - items:
>             - enum:
>                 - qcom,apss-wdt-qcs404
> +              - qcom,apss-wdt-sa8775p
>                 - qcom,apss-wdt-sc7180
>                 - qcom,apss-wdt-sc7280
>                 - qcom,apss-wdt-sc8180x

