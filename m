Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13EF672409C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbjFFLO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbjFFLOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:14:25 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E70D18E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 04:14:23 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-977c72b116fso475967966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 04:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686050062; x=1688642062;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lZSmA8DY0eTLKSTs9zFUI42k53ST/DbB3g3jLk/VVH4=;
        b=rCaOS62Yrkxmzf8yxhctHVMGqbGEnvBbPAPUum2pPYYLMqQ16bKL7AcLgocA1/0Lec
         jcBSGmJ/YMduP30NT0m33MVzOgohuUQxM22FbiVRT5+KBSqpeZb01zlIiD3amv5cewKF
         HNo+uOfiN1lOJjmKumu1r2ABFRFtTazGXI2OuBTMl+vMoUPy18+pcQaQqlJIqc21no4D
         /mdFcxLbSIpqfM5gL7K9RQn+KNyU5KP6wBOdpgTwtAbx+P1IETZi341c4Vortt5X5Y5O
         mcNJu2XF/X1JpLT+dzDDJ997Db+0z1jgnPOQMrsTh1CVNRugZGQf4L7oxpcDky4jH8iI
         3jtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686050062; x=1688642062;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lZSmA8DY0eTLKSTs9zFUI42k53ST/DbB3g3jLk/VVH4=;
        b=j//mA2l2HlmmcR+05Yb72h2GKDfE6/577Dt+7RcWH/SLhjnAEJ3VB5DeJHZRluE3gY
         gJHJQc3PcCSvk6/lmdspZ7nr9PJ7QitdXqLVHQcmsiXarf52+FAQzEW3V+s3w+TS/DY/
         LCsshqId87F7giJo0r6gJDUgzmn2PvxQJNnIFydmKznItiMrEwI0tK3utVMz7nBT/TUh
         LvAteVr/ltEd81BZRDekJDqxCHcHwUteIyXYm7QpBtAWBMiAw2VFmEuoqFSXvbboWCvT
         KE/hT9CPgcQ5+0XVsxy1et85Isjl6ZqQUACypv/i/o1gNJ6sgqb8/pu9b0yr0QNUm/tj
         eicw==
X-Gm-Message-State: AC+VfDyi6z5RzXg5DeuRJg2gT0EIYHVelG7uxQkR2le+z355M9ZeCn6f
        mCgOwdgQQwLjs1QNYlyvFwy/cg==
X-Google-Smtp-Source: ACHHUZ7Te2mWiSqGZNgHvL+5bOOq01EPLyHtb7WGfPbOM1p4qruYTL10yBMBpLJ3aF5t8VoUPsjUQQ==
X-Received: by 2002:a17:907:3f8f:b0:969:f54c:dee2 with SMTP id hr15-20020a1709073f8f00b00969f54cdee2mr2171446ejc.26.1686050062111;
        Tue, 06 Jun 2023 04:14:22 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id o18-20020a170906601200b0096f71ace804sm5463236ejj.99.2023.06.06.04.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 04:14:21 -0700 (PDT)
Message-ID: <49a33caf-e310-fcfb-7786-6731dcc747f5@linaro.org>
Date:   Tue, 6 Jun 2023 13:14:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v8 3/3] dt-bindings: mtd: marvell-nand: Convert to YAML DT
 scheme
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "conor@kernel.org" <conor@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "enachman@marvell.com" <enachman@marvell.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>
References: <20230531234923.2307013-1-chris.packham@alliedtelesis.co.nz>
 <20230531234923.2307013-4-chris.packham@alliedtelesis.co.nz>
 <a23dd485-a3d9-e31f-be3e-0ab293fcfc4a@linaro.org>
 <785368df-1881-e62e-6172-d902cee814a8@alliedtelesis.co.nz>
 <eaf9d7cf-c9f5-a5d5-67af-c43761c3c6cf@linaro.org>
 <4ea0b16e-0cec-00db-c598-e0364a7edef8@alliedtelesis.co.nz>
 <9fc57052-5049-ed50-ca95-cfd1d0420dd9@alliedtelesis.co.nz>
 <20230606094855.1ab005eb@xps-13>
 <845924ba-d9bf-d0ec-e1f2-f721366f43c0@linaro.org>
 <20230606122812.411b223a@xps-13>
 <e0d14527-8147-5e8b-6a43-ee043e0d0f8b@linaro.org>
 <d0b2cdc5-12fd-9a19-b38c-0653b4147c2b@linaro.org>
 <20230606125724.126a4685@xps-13> <20230606130719.5350174c@xps-13>
 <037f5455-35c1-e13d-814c-16317a2a15f3@linaro.org>
In-Reply-To: <037f5455-35c1-e13d-814c-16317a2a15f3@linaro.org>
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

On 06/06/2023 13:11, Krzysztof Kozlowski wrote:
>>> If yes, please ignore the series sent aside, I will work on it again
>>> and send a v2.
>>
>> Actually I already see a problem, let's the ingenic,nand.yaml example.
>> The goal, IIUC, is to do:
>>
>>  patternProperties:
>>    "^nand@[a-f0-9]$":
>>      type: object
>> +    $ref: nand-chip.yaml
>>      properties:
>>
>>        ...
>>
>> +    unevaluatedProperties: false
>>
>> The example in this file uses a property, nand-on-flash-bbt, which is
>> described inside nand-controller.yaml instead of nand-chip.yaml.
>> Indeed, the former actually describes many properties which are a bit
>> more controller related than chip related. With the above description,
>> the example fails because nand-on-flash-bbt is not allowed (it is not
>> listed in nand-chip.yaml).
>>
>> How would you proceed in this case?
>>
>> Maybe I could move all the NAND chip properties which are somehow
>> related to NAND controllers (and defined in nand-controller.yaml) in a
>> dedicated file and reference it from nand-chip.yaml? Any other idea is
>> welcome.
> 
> Yes, this would work and seems reasonable. 

Actually, since nand-chip is used by both SPI and NAND, then I think
better would be to create separate file - nand-only-chip.yaml (name to
be discussed):

nand-controller.yaml:
  "^nand@[a-f0-9]$":
    $ref: nand-only-chip.yaml

nand-only-chip.yaml:
  $ref: nand-chip.yaml
  all nand-controller-chip properties follow



> Other way could be to add
> unevaluatedProperties:false on this level (so after ref:nand-chip.yaml)
> in nand-controller.yaml. This however would not allow any new properties
> to be defined in device bindings.

Best regards,
Krzysztof

