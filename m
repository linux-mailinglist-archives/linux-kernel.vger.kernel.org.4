Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B11D6F6569
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 09:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjEDHEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 03:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjEDHEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 03:04:21 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208592122
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 00:04:20 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9536df4b907so18399966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 00:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683183858; x=1685775858;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MB0Lz0HLLVPcyaLPlp/1Tbli9T/ik+ZJJZYpGyPb19k=;
        b=rL+vjmWV+x8xgGj/qIy7674T56btUXPlco3nlEmTnvuJYXTNhf/H+69lan22MwZca1
         m+E2YG8S2ZUyACQEjVJ/CaIO47kTPOmLrSC8e7Y8r0JWHipTiAKV5NcoPBVyt4YOl+RR
         R5f1nVm3OAtuuA2XwtuwdDgODxIrVQ4C1m31uu0IpMbyhkoGUTgTuWhxLC6yBSfZlxM3
         PXrdjVl1Xcl6kLVL/yeZUrBP4UvADhw6v/XQXaBJPlR1D7HGS8pAO6RRgeRpSy65bP1z
         uEPQPNWb1VFqnq+dCulHUCpLvKQzJQvCeKMIGaZ/Cmfc6D0qTDRvbuCzaojBPVTeP6rT
         wqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683183858; x=1685775858;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MB0Lz0HLLVPcyaLPlp/1Tbli9T/ik+ZJJZYpGyPb19k=;
        b=HgOe8jpF+oqWYONs8WGrweo6BSycbkgc2WBEW0xqPpVbwjuzACq16aTWcFHjEZ55pj
         O2EYYfNxyNurBSO49DwzINwD4yFLsJEyAfO5VT+7YoG29ZYm3Q7J69EKWJJDBnKEAOv7
         kH8ffemwWBwFoZRy5+CszXXW9CpKMoVdqNqVmICJ/M//RTNT95IQraXAWZLnd6d1CwN0
         rKTvLQnuQ6xBOpx3rqcNfDHYsXp6cf5tXTpw2qjfzyOLg5irexPa3u5qGnaNJXR8Ja31
         HGDz4TepL/P10Rl5lT+EL7AaK601Jt3JtLjDI/BjvHH1FEwZTgm9UpQtbtc1kCtbuQBk
         tSfg==
X-Gm-Message-State: AC+VfDz73aTek3ayFBgwShztJJBHxdkp7UuBjXs+zYM/B0CK3dDC+CTa
        Bpf7edKu1phkmpy1LS1B6/PwSA==
X-Google-Smtp-Source: ACHHUZ7HdVC/fX6Z2X3qPH7Uwk0pK5Q9v2ZJv4B3xZuXGVlL9cIGnAlh+vDNm/3ibLcx4w5x/r4xEQ==
X-Received: by 2002:a17:906:4fc7:b0:862:c1d5:ea1b with SMTP id i7-20020a1709064fc700b00862c1d5ea1bmr5777903ejw.8.1683183858596;
        Thu, 04 May 2023 00:04:18 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:cbf1:e7ef:fb81:e912? ([2a02:810d:15c0:828:cbf1:e7ef:fb81:e912])
        by smtp.gmail.com with ESMTPSA id og36-20020a1709071de400b009600ce4fb53sm9449928ejc.37.2023.05.04.00.04.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 00:04:18 -0700 (PDT)
Message-ID: <089e24d1-588a-4a56-f00b-0b35d1d99295@linaro.org>
Date:   Thu, 4 May 2023 09:04:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [RESEND v2 1/6] dt-bindings: power: Add JH7110 AON PMU support
Content-Language: en-US
To:     Changhuang Liang <changhuang.liang@starfivetech.com>,
        Conor Dooley <conor@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Walker Chen <walker.chen@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, vkoul@kernel.org,
        linux-phy@lists.infradead.org
References: <20230419-labored-camper-644d51a7ca96@spud>
 <1a5b15fa-4f20-51c2-2ba1-a04a2911a694@starfivetech.com>
 <20230424-baffle-punch-ec73098f2b6a@spud>
 <d685a1d4-c07d-7dfa-f1fb-b35ceb2aa0eb@starfivetech.com>
 <20230425-unquote-eligible-09f743d81981@wendy>
 <a7cdfabf-2312-eaf3-f462-5bda7f0a120d@starfivetech.com>
 <68cb565d-bf39-10b0-9e3e-35ba7f54b90b@linaro.org>
 <0988495f-b87a-7f69-f222-37c67d6eae23@starfivetech.com>
 <20230425-resale-footrest-de667778c4fe@wendy>
 <663e9933-b9b3-a48f-98b6-2207215a8ed7@starfivetech.com>
 <20230425-commotion-prewashed-876247bed4ab@spud>
 <0b0f9187-ad6b-a1d9-6ec4-beb8989ca731@starfivetech.com>
 <3ed72340-accc-4ad1-098f-4a2eb6448828@linaro.org>
 <482e812a-05dd-105c-189c-e926b4be9d28@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <482e812a-05dd-105c-189c-e926b4be9d28@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 08:53, Changhuang Liang wrote:
>>> 	};
>>> };
>>>
>>> Add a "regmap" property which is phandle. And it can keep the present child-node
>>> structure. This is more consistent with our soc design.
>>
>> Adding property from child to parent does not make any sense. Didn't you
>> already receive comment on this?
>>
>> Best regards,
>> Krzysztof
>>
> 
> Krzysztof,
> 
> I am confused about what to do next. How to add this power-controller's
> node in device tree?
> 

You just move power-domain-cells up.

Best regards,
Krzysztof

