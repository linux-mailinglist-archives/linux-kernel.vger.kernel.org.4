Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4316FBF7A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 08:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbjEIGqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 02:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235019AbjEIGpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 02:45:46 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB4F59D5
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 23:45:41 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50b383222f7so8256721a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 23:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683614740; x=1686206740;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=McOr9m18Erqibf9FmkjjyIwyaTjF9UgkKUoQypwGbV4=;
        b=tWIROQeN270bb0NZ50hdFUB97HCyGugpiGGFZ9/mfCrQ8EqNt+hzhegAIXQdqANxqd
         LiHhJhxcgPWdxLfjX5EPzCpO/Ydfk0e4dDKutZfRsTdwsW7KVSzR9bM9CNh42kaRnlFg
         0onFiuFYwSoNF4TUk2wq0/tf+sQx2Y+fymur82FZVx55H5V49zc/m7CWgqY5sftUmqo3
         8THkC0xWeM0JVaN/H17wXgKotY2zJsB5SOM+NHEyjKM+aEs0kUb7knkLbC7hvKEsSuKE
         Ktr0mVoXBspVhgESC/zwNoDi5ADmEiolQg/jWBhNuBO7yvPYHUGd/5Wbp/7n4whAgpTd
         bytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683614740; x=1686206740;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=McOr9m18Erqibf9FmkjjyIwyaTjF9UgkKUoQypwGbV4=;
        b=RIEqeqL018gaQPBtCoQO3s4xCfy+x27sPEeQHfLjapbq6KSpc8RWUSQaRKsLYt68t3
         P5gLP/HL2n1dX7f8m9/v/BdJ6QJ0axGiPrWAJfXcAmFs7JusVcAdZXYRTVbqM9AmYdt2
         GbXVPB4fvQ57waw5URpdogI9/DLTJBitaya+gyYZz0QXBYP6ST3jXrMedPrjxFu/Pj+d
         Pu7vCZ8Lh7f3k9q1WgBpT8SG1krolhKKsv/JOt2MCkj1zD94HX+NrntcWoWuJEB3wnsZ
         jOQIjHkNJDP2peFVTuJhCjRGjAKOK3sU8zDBsf7oqUwMbV79JmoR4Sixi4mpEDJ+ReA8
         DvFQ==
X-Gm-Message-State: AC+VfDwiJFcUq4i8GDpKu27Yh6DQ22rj0TZNVpNrmZ+07WcaAOpn1X4M
        uU8zpjhbzWvqNwP0LfQx2Ykiww==
X-Google-Smtp-Source: ACHHUZ4RpAPfCBidoGPSDNlQCCnjjRKuHEcPFW8BcadXy47UlFNVBsgtN5KlpmR9bhXlCkcDcnXyyg==
X-Received: by 2002:a05:6402:21a:b0:50b:c25f:d695 with SMTP id t26-20020a056402021a00b0050bc25fd695mr10710994edv.41.1683614739856;
        Mon, 08 May 2023 23:45:39 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d0d5:7818:2f46:5e76? ([2a02:810d:15c0:828:d0d5:7818:2f46:5e76])
        by smtp.gmail.com with ESMTPSA id v15-20020aa7d64f000000b0050bcc5f4b44sm367557edr.94.2023.05.08.23.45.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 23:45:39 -0700 (PDT)
Message-ID: <9dd40868-cea1-e192-abbe-00d3717b9b6a@linaro.org>
Date:   Tue, 9 May 2023 08:45:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 1/2] dt-bindings: nvmem: imx-ocotp: support i.MX93
Content-Language: en-US
To:     Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>
References: <20230508114639.1525521-1-peng.fan@oss.nxp.com>
 <168354885877.927501.14485011836566521791.robh@kernel.org>
 <DU0PR04MB9417DCA5F9465792F86F648888769@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DU0PR04MB9417DCA5F9465792F86F648888769@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2023 02:49, Peng Fan wrote:
> Hi Rob,
> 
>> Subject: Re: [PATCH V2 1/2] dt-bindings: nvmem: imx-ocotp: support i.MX93
>>
>>
>> On Mon, 08 May 2023 19:46:38 +0800, Peng Fan (OSS) wrote:
>>> From: Peng Fan <peng.fan@nxp.com>
>>>
>>> Add i.MX93 OCOTP support
>>>
>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>> ---
>>>
>>> V2:
>>>  Reuse imx-ocotp.yaml
>>>  Based on
>>>
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore
>>> .kernel.org%2Fall%2F20230506064128.34005-1-
>> krzysztof.kozlowski%40linar
>>>
>> o.org%2F&data=05%7C01%7Cpeng.fan%40nxp.com%7Ca420ce0c500d4c7e7
>> 63a08db4
>>>
>> fbfa1d7%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638191456
>> 69328409
>>>
>> 9%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzI
>> iLCJBTiI6
>>>
>> Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=V7QDS9Ko3cvQ3q
>> rR%2FzlHVVI
>>> NImlIzkkqBmDHPFme5oI%3D&reserved=0
>>>
>>>  Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>
>> My bot found errors running 'make DT_CHECKER_FLAGS=-m
>> dt_binding_check'
>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>
>> yamllint warnings/errors:
> [Peng Fan] 
> 
> I think the following errors are not related this patch. I not touch
> pcie, camera in this patch.

Yes, these errors can be ignored.

Best regards,
Krzysztof

