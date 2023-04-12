Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09F06DFFA5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 22:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjDLUXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 16:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjDLUXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 16:23:45 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C5E76B0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 13:23:30 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id a23so16793846lfk.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 13:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681331009; x=1683923009;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q8uCcC1oUeBpF8jXjRvuwLCtZFpxzHXpamdPQ1jWqYI=;
        b=RSNf+1hQ29B8qpFw0wBDbUeUi60GczZmZVHc269kpnTkObytIkHn8gpakIBx2w1+cB
         GiryUMSy4qqIVQidXbOasPkLVYK0hcEDZ3MZy1qBqgo+fIyCT+/fTUsaXo0bD/U6JXFq
         1mjhc9iz8H+GkGgmPgrI55Zmot+7+r2wUlj5gMzdqj5n3GeV07brknlvobqHelpLchOZ
         gp1T4Z16w7E2tOkQdBeGIpq47JJS6HUYex3msS9G/te+Zjzae7+eu+BrvDulOLB0qgCm
         sF4h2Rb+Si24Vw4tZWgLxt6Jf/EruXHSxeOfImTSYA1RGcidMk6Ut9njoGCv5lQbKceW
         fPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681331009; x=1683923009;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8uCcC1oUeBpF8jXjRvuwLCtZFpxzHXpamdPQ1jWqYI=;
        b=KXyyOCzzKG5vneVBn9QGz1Ir7spwRzTXUbSjtblCeJ/o7M43vD8QPPCBeV4qrI7FUz
         ON3x8+ACUF5Xrl4SLYYMU2JRf38cAObDqu7sQkiQpMYWF/CJeTuouvxmTYZEc/0Cvq3s
         981yLPG/pfSfcI5/IlHqJ5Mt5gXMBONonWWyaMddDm6MC5fNSeGLSqeDVXr9/ZH1Whzq
         r+V5n67/tS9Swhg0AvemO3zLgv+wQKk/npRpI6hYEHs6bOn7X3sefuvolQk7dINE/Kdm
         L/IYQF9SjRl1INWXnqaen3IYsgWScbNaTVJ9qxPyIcth1ZQFl2wTy0UnutdYEdU8i9Ee
         Szcg==
X-Gm-Message-State: AAQBX9cCHxpYImnBdy9ZlJepz7cPofb6Y+rFaGLpbL9gNCUhwkiyJmMT
        H9S1EfZ9b/jkd71sXD5BEtZzKg==
X-Google-Smtp-Source: AKy350bsZIanKBDEQO5w7bI0JvsDJuynOO8vLY8MJ2d8n2QIVYeyyRDJeJqFhEjYIvM71/VB+rpA7A==
X-Received: by 2002:ac2:5d48:0:b0:4bb:9415:38a2 with SMTP id w8-20020ac25d48000000b004bb941538a2mr24836lfd.51.1681331008983;
        Wed, 12 Apr 2023 13:23:28 -0700 (PDT)
Received: from [192.168.1.101] (abxj23.neoplus.adsl.tpnet.pl. [83.9.3.23])
        by smtp.gmail.com with ESMTPSA id x4-20020a19f604000000b004ebae99cc1dsm3146882lfe.159.2023.04.12.13.23.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 13:23:28 -0700 (PDT)
Message-ID: <e0320172-65e0-d58f-8960-6f11a328df20@linaro.org>
Date:   Wed, 12 Apr 2023 22:23:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] arm64: dts: qcom: sm8250-elish-*: Fix panel compatibles
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jianhua Lu <lujianhua000@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230412-topic-elish_compat-v1-1-4e03f95d5410@linaro.org>
 <ec2rxutblwlm2wxm6e4zlu3v5d3f6l2eqxjafq2emky6t2kvgt@3u2lo4e53ixs>
 <66851ec3-b797-6b40-865c-ec375b5ded68@linaro.org>
In-Reply-To: <66851ec3-b797-6b40-865c-ec375b5ded68@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.04.2023 22:22, Konrad Dybcio wrote:
> 
> 
> On 12.04.2023 22:20, Marijn Suijten wrote:
>> On 2023-04-12 21:47:20, Konrad Dybcio wrote:
>>> The fallback compatible was missing, resulting in dtbs_check failing.
>>> Fix it.
>>>
>>> Fixes: 51c4c2bd6f31 ("arm64: dts: qcom: sm8250-xiaomi-elish-boe: Add mdss and dsi panel")
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>
>> As usual: Krzysztof already sent these:
>>
>>     https://lore.kernel.org/linux-arm-msm/20230408130809.52319-2-krzysztof.kozlowski@linaro.org/T/#u
> Right.
> 
>>
>>> ---
>>> foo b4 requires i put something here
>>
>> What?
> git checkout linux-next/master
> <craft a single patch>
git checkout -b branchname
> b4 prep -e $(cat localversion-next| cut -c 2-)
> b4 prep --edit-cover
> /* you get a bunch of EDITMEs that b4 really insists you fill out */
> 
Konrad

> Konrad
>>
>>> ---
>>>  arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts  | 2 +-
>>>  arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-csot.dts | 2 +-
>>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts
>>> index 8b2ae39950ff..de6101ddebe7 100644
>>> --- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts
>>> +++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts
>>> @@ -13,6 +13,6 @@ / {
>>>  };
>>>  
>>>  &display_panel {
>>> -	compatible = "xiaomi,elish-boe-nt36523";
>>> +	compatible = "xiaomi,elish-boe-nt36523", "novatek,nt36523";
>>>  	status = "okay";
>>>  };
>>> diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-csot.dts b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-csot.dts
>>> index a4d5341495cf..4cffe9c703df 100644
>>> --- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-csot.dts
>>> +++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-csot.dts
>>> @@ -13,6 +13,6 @@ / {
>>>  };
>>>  
>>>  &display_panel {
>>> -	compatible = "xiaomi,elish-csot-nt36523";
>>> +	compatible = "xiaomi,elish-csot-nt36523", "novatek,nt36523";
>>>  	status = "okay";
>>>  };
>>>
>>> ---
>>> base-commit: 7d8214bba44c1aa6a75921a09a691945d26a8d43
>>> change-id: 20230412-topic-elish_compat-73c4511957a5
>>>
>>> Best regards,
>>> -- 
>>> Konrad Dybcio <konrad.dybcio@linaro.org>
>>>
