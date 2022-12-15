Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CA764D934
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 11:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiLOKFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 05:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiLOKE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 05:04:59 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8B026A92
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 02:04:58 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id g7so14874911lfv.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 02:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PhN2XYtn7J73jwwatawtlTCUvIuMzsdbJcid9hDLoL4=;
        b=Lm8OTSWWTKOIaHrz9Gx/4tWZyTEcio/UBx0u2JTuyhKfHjTdus4LM9pWuv3t8qqBRS
         gWRhfP6W3heLyjpC4SuM5rqeojK8Ez/M2Hi2XvYlRLClUBxs/gieJ+t0uij+xK29ivan
         ngdQdEKYDxMVNAfC7fX8j908QSyjYTGXnaqOJpyv8Rw+eBuNGAIozzwHWoBqsFprs+dV
         yEsyV7SAcb2rrXwpnrZz/qUE46JqDVf0KFQxI+tEvFErTRjRkzXheu7aSgHroPzugabK
         9sUH+4ipOHUFxrRMdEsIydEmifwAwZKB6w76dstUxr/Qyfl+FQkAbtED85G9me4Mda5v
         tCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PhN2XYtn7J73jwwatawtlTCUvIuMzsdbJcid9hDLoL4=;
        b=ICCuOZG6V6eJVtsgvvHQmeAd/Wa+uj5oGlCKxzT/lIFYxjvCsY4jhsQIudJhL4YpLR
         hJHl+kga1WWtHdkD9Mwz//wFPTEUIRMKf1zDxjDna445rq7LSW36SLmkz0829NlGF0nP
         EA+SYVdjfFx7rVYslfCn4qqxtl8H4pqZmowBu+3Y6ZXyOok63JJS/nOrddu1wOdKyIE7
         U9xJ4ZB+vCDVLnRbtdqpaLm7wrmCA6nsAyDOl79RT+51G32LBPFTz4hGoexAJ3/BWilH
         ietl9bOvChnQgi4lXlCsti6KPesYWL0f76LMx1q6ovo0WZDWkbiFvEs5o6qd1Sh5ec65
         Mpxw==
X-Gm-Message-State: ANoB5pk966IWQrOUKoE5RcdpxzZri1lo0pTRXoiuHv+sxYdsLTKE4Xu0
        2uczSm5xGRD3IQychOeW36oywg==
X-Google-Smtp-Source: AA0mqf4ZdrUQKHCtrfWWP18oWgat1XAbxhaSPVuYNg18b4kxcqa43GhH+V5v3jgPX+Pwyr64hiJg+w==
X-Received: by 2002:a19:f00b:0:b0:4b5:7dd6:4df0 with SMTP id p11-20020a19f00b000000b004b57dd64df0mr6635691lfc.32.1671098696529;
        Thu, 15 Dec 2022 02:04:56 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q8-20020ac25fc8000000b004b6efcb7bb5sm1122284lfg.169.2022.12.15.02.04.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 02:04:56 -0800 (PST)
Message-ID: <f3942ee4-46df-c36f-7d08-bd4d43389496@linaro.org>
Date:   Thu, 15 Dec 2022 11:04:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v4] regulator: dt-bindings: Convert active-semi PMIC docs
 to YAML schemas
Content-Language: en-US
To:     Paul Cercueil <paul@crapouillou.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     list@opendingux.net, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221214155152.14349-1-paul@crapouillou.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221214155152.14349-1-paul@crapouillou.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2022 16:51, Paul Cercueil wrote:
> Create YAML bindings for the Active-semi PMICs and remove the old text
> files.
> 
> The bindings aren't perfect, for instance I couldn't find good
> descriptions for the vendor properties in the "charger" node of the
> ACT8945A because I am not familiar with the hardware and these
> properties were not documented anywhere.
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

