Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09DE6F82A6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 14:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjEEMJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 08:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjEEMJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 08:09:44 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE621AECC
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 05:09:23 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50bc4ba28cbso3053375a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 05:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683288562; x=1685880562;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IgB4QgM1yECi7w3uQUentakzBrJPTPMX/E/zSU5My38=;
        b=F/1DoSW5PpbcfkcqC19rebXR8nuff4fL9IOsqw6Nn6SlUhj3wIfy+8qM/XT0ljUwre
         jkwPBMHYlTLILs+exAu801N1K/GOs1DxAGJIsFbQ0Tu7tAG0SHUtdPIEhuGyzAe9DiZs
         SQpTeoxHGD1d1/mYpNaUvp7b9MXN3MZdonX7blDKmuVGZnxprVdaG80sqL6Rqfl1mm+v
         dBa1Ec6kCod6GgKPRYAwPEPYLhl3os1SFPcILrQsNY0Ml1jJ7+guw2KzVqhPs9iFs7tB
         3EM/p7kO0vNYAIKYoTeiQn99iMKwjw0GvqTwStw4nObGuOflIbUReNdxijFqk0DbqQiv
         TO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683288562; x=1685880562;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IgB4QgM1yECi7w3uQUentakzBrJPTPMX/E/zSU5My38=;
        b=aegXtFT19/g+q7rA2PMkD8E9qiz+K8pMBODaeTHZL8BWchtfOTlayLJ75qDDk1F8c9
         aAFUDiDFrRaNjOKbypvI16DTaoRFFOMZt5BmQ64aUssklRM3Fh9Q9t0vdzex8/9nL56Y
         yTowu/NS/zmuPvqlvck1GRnGmKxNlDNKwJMJ6492lRa1YsEm1+6xaf9HS7pfFEHyL7yZ
         DB9TbOzjiZDBDhNOd/KanODScGPNsNLOKppJALAuS1QU11WTo7NSnUlW5ksWyxqBmRoP
         a0KrOI0/VxPg9c91ApEMkZa66/DOX/g8BFMILeXXALN73ZLuMFMRjTN1/jf9IF98dWeL
         dWHA==
X-Gm-Message-State: AC+VfDwTGsHTxorUdt6jp71UuCb/DxpyXFnnu44b1asA4085go4eq20o
        V4v1sLHtHVJnyU3FEtEaPyozrw==
X-Google-Smtp-Source: ACHHUZ6Sab7WEqAi9O00UdPyemL3Yfzg1mXVyAhJjcCrYWBw6dPGXk1PvLm91r4WtClPEwsTnbix+Q==
X-Received: by 2002:a17:907:9287:b0:959:6fb2:1c3b with SMTP id bw7-20020a170907928700b009596fb21c3bmr944834ejc.39.1683288561845;
        Fri, 05 May 2023 05:09:21 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:52e:24ce:bbc1:127d? ([2a02:810d:15c0:828:52e:24ce:bbc1:127d])
        by smtp.gmail.com with ESMTPSA id ka7-20020a170907990700b00947ed087a2csm860359ejc.154.2023.05.05.05.09.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 05:09:21 -0700 (PDT)
Message-ID: <c7f11b40-e4d7-3c4e-53d7-6549f840b702@linaro.org>
Date:   Fri, 5 May 2023 14:09:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/2] dt-bindings: nvmem: add binding doc for i.MX
 OCOTP/ELE
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
References: <20230505091733.1819521-1-peng.fan@oss.nxp.com>
 <bb3d374d-0dc1-cf15-2458-f294c5ef23fd@linaro.org>
In-Reply-To: <bb3d374d-0dc1-cf15-2458-f294c5ef23fd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2023 14:01, Krzysztof Kozlowski wrote:
> On 05/05/2023 11:17, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> There are two parts of i.MX93 OCOTP, with 1st part Fuse shadow block(fsb),
>> 2nd part managed by ELE firmware. This binding doc supports both.
> 
> Subject: drop second/last, redundant "binding doc for". The
> "dt-bindings" prefix is already stating that these are bindings and
> documentation.
> 
>>
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>  .../bindings/nvmem/imx-ocotp-ele.yaml         | 65 +++++++++++++++++++
>>  1 file changed, 65 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/nvmem/imx-ocotp-ele.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp-ele.yaml b/Documentation/devicetree/bindings/nvmem/imx-ocotp-ele.yaml
>> new file mode 100644
>> index 000000000000..024594a2bcb4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp-ele.yaml
> 
> Filename matching compatible style. fsl,imx93-ocotp.yaml
> 
> 
>> @@ -0,0 +1,65 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/nvmem/imx-ocotp-ele.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: NXP i.MX9 On-Chip OTP Controller (OCOTP)
>> +
>> +maintainers:
>> +  - Peng Fan <peng.fan@nxp.com>
>> +
>> +allOf:
>> +  - $ref: nvmem.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - items:
>> +          - const: fsl,imx93-ocotp-fsb
>> +          - const: syscon
>> +      - items:
>> +          - const: fsl,imx93-ocotp-ele
>> +

Actually this is the same as existing bindings. Just squash it.

However I wonder - why this is syscon?

Best regards,
Krzysztof

