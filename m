Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E8C6BDDAB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 01:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjCQAbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 20:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjCQAbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 20:31:46 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B96D1BAE4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 17:31:38 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id s8so4273794lfr.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 17:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679013096;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JT58Vx7PeBixGFgGe9DPTLlFGWvkVsvJLcnD2XLlTas=;
        b=SgecCbFxPK56jfty9TriTz/7YJWycJHjOcADzDHC9ViFhnCOF420/LIHaeDBURfzTF
         VpAj3fdSYEgMSr/hwukAwF+P5Xgjpm1aI6l1LLGg5I7wehyb4Bt7HiwEfdHqwrtVo/I7
         G2ArgvXeO5pPP1yKqNInCYtr4/w2YL5iNksvrkEyOiUg4K3OlrdKEyeEiTUnc3djdpKp
         MuGE2yeWZ7wEXVlo1AxKnW1gTCySy7nr0j7lORrpNcbZ+8Q/MFTJi5uGaCUP1L6glMfG
         2Ah5g/zykXeoWGKkUlUEcgHQSDBZDJW80OIX/xlCHQpouk6dtaP/BHZMW4old2mU/iw2
         sARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679013096;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JT58Vx7PeBixGFgGe9DPTLlFGWvkVsvJLcnD2XLlTas=;
        b=HGWJtPVJFRphSdfgKf2ldzog2N2249TnXd68D6VGSdcmSuSgaUaWyi75489eO5SCsL
         t0Y9HLB5cZmqc2lauyFiokaWxfcwdQyT92ACfbW6cySkyOfwnb+HVgRfreWuphu3SZYA
         I4LgOGqrfAonwlCGAhEoH1snQW23ZnK+S4hIGf80JwwpVAHRoUWqgDhQJJRbew86haGF
         IaGy9tVgkZ0gWzqAY5lvHWoHrFel5mLn3GBrAdgikIiCPg4K+5pQ7amuBSiQTc9GyG/X
         ju8lwLN/BsNe76nekmTiHLWNiGaTDzDkPPLRfo75MMpRoZLD+EJfsOdBBzi93PtuEOWx
         BTng==
X-Gm-Message-State: AO0yUKVsNU/fZk7eq/kLlQ/G81usCwmE6bvMoAgBiTlF4hf/uh0HprMY
        jB9yNd2MiLsPgdeM4ayOIt2oIg==
X-Google-Smtp-Source: AK7set8IUHEOoYqVErKttc3lllC78z7DRaGMJAaDIAhR3P2OuBSxd1j185k2YIZZCUJBxqISbNLzKA==
X-Received: by 2002:ac2:532b:0:b0:4b5:b46d:e60 with SMTP id f11-20020ac2532b000000b004b5b46d0e60mr3269390lfh.27.1679013096276;
        Thu, 16 Mar 2023 17:31:36 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id y3-20020ac24463000000b004db00b4c671sm124615lfl.7.2023.03.16.17.31.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 17:31:35 -0700 (PDT)
Message-ID: <62533d5a-f39a-0806-b4d9-932e2af6beef@linaro.org>
Date:   Fri, 17 Mar 2023 01:31:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH RFT v2 01/14] dt-bindings: clock: qcom,rpmcc: Add a way to
 enable unused clock cleanup
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org
References: <20230303-topic-rpmcc_sleep-v2-0-ae80a325fe94@linaro.org>
 <20230303-topic-rpmcc_sleep-v2-1-ae80a325fe94@linaro.org>
 <20230316225803.GA4036689-robh@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230316225803.GA4036689-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.03.2023 23:58, Rob Herring wrote:
> On Wed, Mar 08, 2023 at 10:35:17PM +0100, Konrad Dybcio wrote:
>> Disabling RPMCC clocks can be a bit touchy. If we can't guarantee all
>> (or at least most) of the oneline peripherals ask the interconnect
>> framework to keep their buses online and guarantee enough bandwidth,
>> we're relying on bootloader defaults to keep the said buses alive through
>> RPM requests and rate setting on RPM clocks.
>>
>> Without that in place, the RPM clocks are never enabled in the CCF, which
>> qualifies them to be cleaned up, since - as far as Linux is concerned -
>> nobody's using them and they're just wasting power. Doing so will end
>> tragically, as within miliseconds we'll get *some* access attempt on an
>> unlocked bus which will cause a platform crash.
>>
>> On the other hand, if we want to save power and put well-supported
>> platforms to sleep, we should be shutting off at least some of these
>> clocks (this time with a clear distinction of which ones are *actually*
>> not in use, coming from the interconnect driver).
>>
>> To differentiate between these two cases while not breaking older DTs,
>> introduce an opt-in property to correctly mark RPM clocks as enabled
>> after handoff (the initial max freq vote) and hence qualify them for the
>> common unused clock cleanup.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
>> index 2a95bf8664f9..386153f61971 100644
>> --- a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
>> +++ b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
>> @@ -58,6 +58,12 @@ properties:
>>      minItems: 1
>>      maxItems: 2
>>  
>> +  qcom,clk-disable-unused:
>> +    type: boolean
>> +    description:
>> +      Indicates whether unused RPM clocks can be shut down with the common
>> +      unused clock cleanup. Requires a functional interconnect driver.
> 
> I don't think this should be QCom specific. Come up with something 
> common (which will probably have some debate). 
Generally the opposite (ignoring unused clocks during the cleanup) is
the thing you need to opt into.

I can however see how (especially with the focus on not breaking things
for older DTs) somebody else may also decide to only allow them to be
cleaned up conditionally (by marking the clocks that were enabled earlier
as enabled in Linux OR not addding clk.flags |= CLK_IGNORE_UNUSED) as we
do here.

Stephen, Rob, would `clk-disable-unused` be a fitting generic property
name for that? Should we also think about `clk-ignore-unused` as a
clock-controller-specific alternative to the CCF-wide clk_ignore_unused
cmdline?

Konrad


> 
> Rob
