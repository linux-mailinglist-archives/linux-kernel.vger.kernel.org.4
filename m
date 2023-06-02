Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEEB7202E3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 15:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235624AbjFBNPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 09:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235849AbjFBNOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:14:49 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07F3E64
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 06:14:26 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5147dce372eso3042007a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 06:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685711623; x=1688303623;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=57q4TdWvHlrEcIXeoi1W6gK5/9KE0SGJz/XNivOKPnk=;
        b=m9GaBMggEI20VXMLlKimzmXgfD2tFFpsgnDCnJnAzGBiSIil3R7xyTQsrSZ0tkBKQ2
         Dan82iwCSen/4Qc7ylIOt8DQXGEvhxbZlViE149oQ6jXGm0iWDn+RXA1eGo8J0vDX3Mc
         qYGzE3Tb04bFDQ5oz9hGJRnHjVJJgpU6m8ZmOe2V5iTi5SiokNy886+NLJrDVBOK+Wfq
         YrEoS1xUKfBU4khc/qPtsNsgb8BQAioPYPCu0YnueaAFfAUhR89gr80YqopukdfPwaHg
         zM4Ev9JbZ3Dtm1Asdwd8VYPDEs3pYrQ8nsOUW3nPQvLoqWmVbKq0aoIjDRmwnTj7Mog5
         7BPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685711623; x=1688303623;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=57q4TdWvHlrEcIXeoi1W6gK5/9KE0SGJz/XNivOKPnk=;
        b=RZwXjV/JTTo34sVlqUZf6iu6xMOnnGBOVegNvEg7sxitgtD0TeJetsx2dovIvBuqv6
         8gVgApKctb20QI8UPRJqiXjBHTlsqQLrk7VZJSm/9ns+hB5/kRd4xvqavgyEMeJZOWHh
         SSzqPSDXchYm/wt4/RVO2pb2hSHDUxySGl2EEZFmDs36LGa2F3SJSZhZifFeoqeiB1ds
         JmE7tJJqbwmn8VD9Jb9GaCjiFCQ6bw0zZNMVJoa87fTWzlNhN61MeVv4Fgm7bi3YRxKY
         qRKSAto833+/hTtORpcxpP0lz83PIurmeI3eLu2EGJtqgv8tsDtb3dktQQPtDliNVDgl
         fL4w==
X-Gm-Message-State: AC+VfDxiYBBIXOzvy54WFaxhhilRRW2av++j/KI9DF3pB+MeMEje6+ns
        h+yp+I6YTjQCeR/DRjB/JwmvGA==
X-Google-Smtp-Source: ACHHUZ43d+sUWltwQzDiB3YR6CO9kaf0tCGFKY31o/sI7+FHsx2VcAbPoNydH2HsLkQ4RBU6XfW+uw==
X-Received: by 2002:a05:6402:205c:b0:50d:8979:5722 with SMTP id bc28-20020a056402205c00b0050d89795722mr1868357edb.39.1685711622721;
        Fri, 02 Jun 2023 06:13:42 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id a15-20020a50e70f000000b0050d83a39e6fsm682708edn.4.2023.06.02.06.13.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 06:13:42 -0700 (PDT)
Message-ID: <955b84da-7d7c-1a30-680f-530c7593643d@linaro.org>
Date:   Fri, 2 Jun 2023 15:13:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 04/11] dt-bindings: stm32: add st,stm32mp25 compatibles to
 the stm32 family
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Conor Dooley <conor@kernel.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20230529162034.20481-1-alexandre.torgue@foss.st.com>
 <20230529162034.20481-5-alexandre.torgue@foss.st.com>
 <20230529-backlit-dealing-b099e4eb5210@spud>
 <c805cd5f-92b1-eb56-d9bc-66814705e848@foss.st.com>
Content-Language: en-US
In-Reply-To: <c805cd5f-92b1-eb56-d9bc-66814705e848@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2023 10:39, Alexandre TORGUE wrote:
> Hi Conor
> 
> On 5/29/23 20:05, Conor Dooley wrote:
>> On Mon, May 29, 2023 at 06:20:27PM +0200, Alexandre Torgue wrote:
>>> STM32 family is extended by the addition of the STM32MP25 SoCs. It is composed
>>> of 4 SoCs: STM32MP251, STM32MP253, STM32MP255 and STM32MP257.
>>>
>>> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
>>> index 4af5b8f4f803..7d7ca33d2e61 100644
>>> --- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
>>> @@ -161,6 +161,15 @@ properties:
>>>             - const: phytec,phycore-stm32mp157c-som
>>>             - const: st,stm32mp157
>>>   
>>> +      - items:
>>> +          - const: st,stm32mp251
>>> +      - items:
>>> +          - const: st,stm32mp253
>>> +      - items:
>>> +          - const: st,stm32mp255
>>> +      - items:
>>> +          - const: st,stm32mp257
>>
>> I assume the slightly odd format is just to avoid churn when adding
>> the board compatibles.
> 
> Yes, exactly.
> 

I don't get it. How are you going to extend it? Or rather - what are you
documenting here? If these are SoCs, then this is not valid. We do not
allow these alone.

No, please drop it.

Best regards,
Krzysztof

