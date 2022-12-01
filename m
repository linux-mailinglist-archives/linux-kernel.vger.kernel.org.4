Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB0363F17E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 14:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiLANW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 08:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiLANWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:22:23 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9137CA1C2E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 05:22:22 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id q7so1843902ljp.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 05:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WyQawYit9lLZInOCq3g0j1Ztdmfwj5fvP6/cKOuQ4T8=;
        b=bT5dnp2zEMGz5HB4ydLvpAnoqepKcklDia7j09ZySBqE5jTueQ+Nvvbpr4YZGh1ovI
         hkttYWNhHIHL0EHQ1f6jRmsaxwMCKhW7CQg/wM4WQeypvy0Vepm1IbvAPcH7crN42DnG
         h3L89oHdebH4fTo6YqMsTDROuljLO/7/vRPK8yCReo8CAsStBnX+hN42z2th1MnR4B6Q
         zDIc+9u9hkb5BUttRci152xqpY/fWA/4TDcbnn/zgRj9cg7LqVCEZGum83O6aTX67QzX
         YKJL6XxPp2aueCZrWhbQq3LCkDza/zQZEfT9T+PU7ivvSejPzltGsD094G9JAlX31LhA
         FJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WyQawYit9lLZInOCq3g0j1Ztdmfwj5fvP6/cKOuQ4T8=;
        b=IRDY3lDDEK3gsPmNt/Zf0xOxdQpQRTNycrolAczabiwPAD76blZlRkLiNpyzG9vrKN
         v06+9388Vjv5uz7dph0n7JPwRLO7icUcSotKA2FDZDjD7D0vcxXrzaV/Fydxo7IgBkvX
         oYOqGyg0hN/I1mji7G4EyJALWrYz/JupUiSiPtACTOD8/2ZgT+FxxmbC4293lL8xZr8N
         6BkKaiqGG/MhO4O29uaWnmLgFPxObf6HQoxHD3qg3ONZL82tsM7qnvTt7aAWPJCWJom/
         34DAi0wi2TwreJOWYWE2bq6GwRxvLFl9FejAHEur7wBWG4Lx3H0Ir3G0jmw19aXL+35U
         RQmQ==
X-Gm-Message-State: ANoB5plyK6XgJ8Z0NONDtLJzEaDfVNrhDj+lO+qP8FDp69eJgVa4pK9w
        uMAX3qgXhYMtRErcQ2z32pBIAQ==
X-Google-Smtp-Source: AA0mqf7I/YMv5A1pkXzYkyN//geQ0DmC/fF+wcRMWDbsDc4h4FNrYDBO9frwL7EGnDLbj7ep1oHRug==
X-Received: by 2002:a2e:bd06:0:b0:277:2437:e977 with SMTP id n6-20020a2ebd06000000b002772437e977mr22531568ljq.195.1669900940981;
        Thu, 01 Dec 2022 05:22:20 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id h9-20020a05651211c900b004b52f4ea0d3sm641191lfr.192.2022.12.01.05.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 05:22:20 -0800 (PST)
Message-ID: <e8a86b3e-7a2f-3434-52d8-6a827b720f92@linaro.org>
Date:   Thu, 1 Dec 2022 14:22:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 4/9] dt-bindings: remoteproc: qcom: wcnss: Convert to YAML
Content-Language: en-US
To:     Sireesh Kodali <sireeshkodali1@gmail.com>,
        linux-remoteproc@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20220511161602.117772-1-sireeshkodali1@gmail.com>
 <20220511161602.117772-5-sireeshkodali1@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220511161602.117772-5-sireeshkodali1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2022 18:15, Sireesh Kodali wrote:
> Convert the dt-bindings from txt to YAML. This is in preparation for
> including the relevant bindings for the MSM8953 platform's wcnss pil.
> 
> Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
> ---
>  .../bindings/remoteproc/qcom,wcnss-pil.txt    | 177 --------------
>  .../bindings/remoteproc/qcom,wcnss-pil.yaml   | 228 ++++++++++++++++++
>  2 files changed, 228 insertions(+), 177 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.txt
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
> 

Half year passed, so I wonder if these series are abandoned or shall we
expect v2?

Best regards,
Krzysztof

