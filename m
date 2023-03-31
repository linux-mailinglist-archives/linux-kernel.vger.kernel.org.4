Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A726D1584
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 04:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjCaCPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 22:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCaCPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 22:15:22 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9963E18B;
        Thu, 30 Mar 2023 19:15:21 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j13so19059810pjd.1;
        Thu, 30 Mar 2023 19:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680228921;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zFs1M4FHeogHRWVUs63pLt774ztEF1h66obdsW+D9oo=;
        b=hoNgpgf4aLzwSLP/BeB7GheyN/ekC/VIniLYkDG8Bzjw8dAusZoKtuLdkWW/RIlJ/F
         rrwcBwWq2TZm9mpbTDoY90Q/sj13Chrmy1Rl3JBS/XOsLcB3AGbltI8IQnF1KxxzqB+6
         BIVxyZ7hwg4b1fLb4t2Vj2E9paTpeUB9jnXORN3+MvGoQ9+7NFO9e+dUDXoSQLiPIOk8
         qIFcKSlH7OGb1QrmRRdrzaSOAOp1Gkmq0+8vyKaoWStp4YlfH6s5K4/OClHx3lNshl40
         RWvrkpEQTDdPgVj2EQblhYQ1pVj17kvgFDgQqKbzt1WsVMQEAA7Ms7EXLV/ug4XfMXOS
         In/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680228921;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zFs1M4FHeogHRWVUs63pLt774ztEF1h66obdsW+D9oo=;
        b=UVIvn3+uNPUnKcmaOGO0Hkh++BSen9w5EGZY2F1rrnclVcFcH+pTmiLDwQ80YItruR
         w6v3s81qe49FYZhuGpSITFk8PBBvqa+g8X0aa8yqYJmJ1KktKI/GizOU9wjemP/e1E/K
         GJXXGlEW7vmaCThLgccasb+vPFM9DBzLml2EK/brPAAUylo/srT1/ExtFReOmLIGaCcj
         onM28Va0Srl0LU+pc7C4qhswd+3DH2380kYK26WEYtAx+H2GcWkcMT4SKn44+1rotSrT
         qI6rE3/5TntwHzoLPjTJhNzFpld8e1AQo0v8Xqlxi/9++pZJg+xbYt+CUleCMlQPb7XN
         BOZA==
X-Gm-Message-State: AAQBX9dCRxbGViB7YXXjjz53Onc92EGvPyNLJhXMiqERFJRt+/fvIjlT
        mbuHCwWlfww1XK8Bx9YE6wcqR5/yA8npmg==
X-Google-Smtp-Source: AKy350Z25zRGMGsijn+lkfwgpeoLaG0vQTga3fyakeBYu0nJOmIM+xWkUKhvVhuhSHcb82X4GMUJoQ==
X-Received: by 2002:a17:90b:4094:b0:23f:d487:1bc8 with SMTP id jb20-20020a17090b409400b0023fd4871bc8mr8650609pjb.13.1680228921239;
        Thu, 30 Mar 2023 19:15:21 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id gq16-20020a17090b105000b002309279baf8sm3866155pjb.43.2023.03.30.19.15.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 19:15:20 -0700 (PDT)
Message-ID: <f39edbfe-75bd-3b39-e325-8d24673a4501@gmail.com>
Date:   Fri, 31 Mar 2023 10:15:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 06/12] dt-bindings: arm: Add initial bindings for
 Nuvoton platform
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com>
 <20230328021912.177301-7-ychuang570808@gmail.com>
 <CAL_JsqKrrWyOKGUAaT-8r-nKvtS5f_gHAhE5=XaXuGtuYC2gCw@mail.gmail.com>
 <a497eb9c-8279-d4e9-3b8d-537ffa1f7522@gmail.com>
 <cfa5904e-8ae4-6d39-ed4e-35d1b55e2b04@linaro.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <cfa5904e-8ae4-6d39-ed4e-35d1b55e2b04@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/30 下午 09:25, Krzysztof Kozlowski wrote:
> On 30/03/2023 12:41, Jacky Huang wrote:
>> Dear Rob,
>>
>>
>> On 2023/3/29 下午 09:07, Rob Herring wrote:
>>> On Mon, Mar 27, 2023 at 9:19 PM Jacky Huang <ychuang570808@gmail.com> wrote:
>>>> From: Jacky Huang <ychuang3@nuvoton.com>
>>>>
>>>> Rename the bindings/arm/npcm directory as nuvoton.
>>>> Add binding for ARMv8 based Nuvotn SoCs and platform boards.
>>>> Add initial bindings for ma35d1 series development boards.
>>>>
>>>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>>>> ---
>>>>    .../bindings/arm/nuvoton/nuvoton,ma35d1.yaml  | 30 +++++++++++++++++++
>>>>    .../nuvoton,npcm-gcr.yaml}                    |  2 +-
>>>>    .../npcm.yaml => nuvoton/nuvoton,npcm.yaml}   |  2 +-
>>>>    3 files changed, 32 insertions(+), 2 deletions(-)
>>>>    create mode 100644 Documentation/devicetree/bindings/arm/nuvoton/nuvoton,ma35d1.yaml
>>>>    rename Documentation/devicetree/bindings/arm/{npcm/nuvoton,gcr.yaml => nuvoton/nuvoton,npcm-gcr.yaml} (93%)
>>> Since you are moving it, this one should be moved to bindings/soc/nuvoton/
>>>
>>>>    rename Documentation/devicetree/bindings/arm/{npcm/npcm.yaml => nuvoton/nuvoton,npcm.yaml} (93%)
>> OK, I will move "Documentation/devicetree/bindings/arm/npcm" to
>> "Documentation/devicetree/bindings/soc/nuvoton".
> To clarify - Rob asked *this one*. Not all.
>
>
>
> Best regards,
> Krzysztof
>

Dear Krzysztof,

I am sorry that still cannot get it exactly.

1. Just only submit  the nuvoton,ma35d1.yaml to
Documentation/devicetree/bindings/soc/nuvoton/nuvoton,ma35d1.yaml
     and keep Documentation/devicetree/bindings/arm/npcm unchanged

2. Move the directory "Documentation/devicetree/bindings/arm/npcm" to 
"Documentation/devicetree/bindings/soc/nuvoton"
    and submit  the nuvoton,ma35d1.yaml to 
"Documentation/devicetree/bindings/soc/nuvoton"

I should do 1 or 2?  Thank you very much.


Best regards,
Jacky Huang


