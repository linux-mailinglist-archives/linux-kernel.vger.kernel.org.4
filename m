Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31E15EF074
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbiI2I3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235538AbiI2I32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:29:28 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F004B13EAFA
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:29:25 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id m4so985406wrr.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date;
        bh=bpujdPbvMkKZc5tbT0tesQargul5oOFWG757hhJb/PI=;
        b=S+MBQ80rqHpEy6NEzdghu7ouA0nlstzMZO9Saw2V8CTa/0OE+fpOyEtEpWnJ5a33MZ
         2zwKxqsKiGGlhR/4NLysLq43VTA2zD4e1z9PcdNGWaTFDPTZoZgmMgJmpzQLLdSuXQki
         3UxJ5CNla358jTuqu4ssay4iY3uunEAjeUnNzs6uH0RQbOux2hAcJgwpZcaRvKB2DW25
         sHoBQ24LKekSRT/apOh73b0ZExISLGEUYJSiTewZC4btdD67F7IzGpGxTAlG4Ip+2Q/+
         Udesxn69qPH0WMUMoGAmU2sl3+VyQpVoVmiDlE6MI4C5LpxdKhafAm7PkHE7RaOKPQGI
         /8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=bpujdPbvMkKZc5tbT0tesQargul5oOFWG757hhJb/PI=;
        b=HUwckgiTfT30W3hgtiVZKGo7KGW0wWVL2+tEJ/lhACLpFZracqs9JBzN8ClYbw1tLu
         gWUZioSukC6nKThBGDaGwxcMyt9pc9wze30ueuPKDgBqwJA3jwy5XqE+Dfl8BvH2sDnD
         o23T3O6zcvZH1dPemz432kF1OgM1MtqyF1kYrgf80dbbgPc05Uw0ROtDitMsFFuYxTu9
         J+pDdtG0me0pWUakL7Zs5VOHSjxGzcSXZJzXGSMHLvkmcwO/4/hoOxytd71IEYFFCWMS
         eb2jS3zyW60h3BfrrNgKXw7/bK6YPsPdwU8Dd4+0buh8p6UEg9U1maODSgilQ4QN92If
         a0bw==
X-Gm-Message-State: ACrzQf3lalBS8L6/CHUcUKiH/EJmXJY5GV6KFMfC5j1iOTliQbMfbqqJ
        +wCARnFbppz73w6hUXX+7rJ+sg==
X-Google-Smtp-Source: AMsMyM6kYyKnh1/JwTgKQ0f0DN5Ba74UeFtjFSwCtJ6Xed8FffnuPm3vCjv67+qK5DVvgDx79qu+mQ==
X-Received: by 2002:a05:6000:797:b0:22c:be73:ff82 with SMTP id bu23-20020a056000079700b0022cbe73ff82mr1331315wrb.618.1664440164403;
        Thu, 29 Sep 2022 01:29:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:1f17:3ea3:4e46:dff? ([2a01:e0a:982:cbb0:1f17:3ea3:4e46:dff])
        by smtp.gmail.com with ESMTPSA id z2-20020a05600c0a0200b003a4efb794d7sm4102412wmp.36.2022.09.29.01.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 01:29:23 -0700 (PDT)
Message-ID: <6ed642ea-424d-49ed-eb30-e09588720373@linaro.org>
Date:   Thu, 29 Sep 2022 10:29:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 5/7] arm: dts: qcom: mdm9615: remove invalid pmic
 subnodes compatibles
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20220928-mdm9615-dt-schema-fixes-v1-0-b6e63a7df1e8@linaro.org>
 <20220928-mdm9615-dt-schema-fixes-v1-5-b6e63a7df1e8@linaro.org>
 <0636d53f-508f-8a86-0973-2641c9020622@linaro.org>
Reply-To: neil.armstrong@linaro.org
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <0636d53f-508f-8a86-0973-2641c9020622@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28/09/2022 20:03, Krzysztof Kozlowski wrote:
> On 28/09/2022 11:14, Neil Armstrong wrote:
>> The PMIC is an PM8018, but was compatible with the PM8921. Both compatibles
>> was left but it makes no sense anymore the leave both.
> 
> Why? It makes sense for backwards compatibility. If you think it does
> not make sense, please say why.

We had the same debate at submission 7y ago, some of the pm8018 new compatible
were rejected in bindings & drivers so I left both...

As of today only the pwrkey bindings is missing, so should I resubmit the pm8018-pwrkey bidings and
drop the pm8921-pwrkey compatible ?

> 
>>
>> The pwrkey compatible is left to PM8921, unlike the others because
>> the interface is stricly compatible with the PM9821 pwrkey.
> 
> typo: strictly
> typo: PM8921
> 
> Again, why? The old code looked correct. In all three places.

The qcom,pm8018-rtc require a single compatible, same for qcom,pm8018, so what's the way to fix it ?

> 
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>
> 
> Best regards,
> Krzysztof
> 
Thanks,
Neil

