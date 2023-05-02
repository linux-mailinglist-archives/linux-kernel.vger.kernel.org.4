Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2606F3DEA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 08:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbjEBGzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 02:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbjEBGzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 02:55:07 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BD549ED
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 23:54:59 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50bc34b98edso3491445a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 23:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683010498; x=1685602498;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MyPP+G2oB4NR99xi+mLJB0lVJW/KBDw98DjQ+N/w9e4=;
        b=pWQ1ct/+JlBf25GRV5DEJD9CU2cQPd4cY1PVe7tqzCZ+yoO0ZgzKcbdXtJb+qI3bHZ
         VMG5jV1TcsQUfON1Zr8D7f9qefX7r89IzkL/fgM0B/qcbSE/5cjzdHUFzbUMSyBZqPbo
         9uXHMgIjDDgw4Pu8JjTszgWuAObQaHzZDPzUUwm0LCTQylIbjqNWVjAsJ0S4RvC7QBmu
         iELydVyPYCLO2kfIUqh1ILll/8KugzlF4bba60mgeU85uMeSmINsf/cL7o+qdntJB6zu
         FUFPU73iFhqioJ0SVUJq2Dcc/JSpNan+jj5JyNimgg1wokQiAkGvWvZTGd5YVfZwJsun
         iLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683010498; x=1685602498;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MyPP+G2oB4NR99xi+mLJB0lVJW/KBDw98DjQ+N/w9e4=;
        b=hHWJHzKJUaQdPDbIgVMiIqo7LIs27LZUGanbhyuzGhnw5EfxZ24sfnzm56H2DiWoHw
         F6v+DXlJ0OmnnJJrZoWwA/rzfFhmYBKdBDb3z0+wS7SGF/YvuydfYmdOFn1gE4g4Ih3q
         bSSTpHDcZYzUxAQaK+AwnHLr/24Tfsi4tXfE3d1IIRLojYtKTGVLeSwap34yGVMPIlWd
         8GztLoUHLt1q7T2o1A76FvqQu2geoodGdEO5bDTXjxscV8dxcsdkrmdZ23+x0P6etcSA
         J8LazI7zMxHx306L2FWVUyIeulbYj0X9BSLTU3CPG7lFtpt8iPrAD+yYexRErrZdPpZt
         hEow==
X-Gm-Message-State: AC+VfDxY8OIr6lldTSy/StSdFqW+ZY7dhzV7XcG5Mn/XwyJHb++4y5Xa
        6XOFSBPa41Z82ULquTaCkUX/jQ==
X-Google-Smtp-Source: ACHHUZ63xWY8+0Vtw0D3NZziMzM43irH1/YildIr5NvyVZcCukpF36WSZIcoQJJh7qLKl3R1fJBbDg==
X-Received: by 2002:aa7:d4d0:0:b0:50b:cd17:12a7 with SMTP id t16-20020aa7d4d0000000b0050bcd1712a7mr1945284edr.15.1683010498347;
        Mon, 01 May 2023 23:54:58 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:bafd:1283:b136:5f6a? ([2a02:810d:15c0:828:bafd:1283:b136:5f6a])
        by smtp.gmail.com with ESMTPSA id u11-20020aa7d0cb000000b0050687dbb5dasm12950407edo.31.2023.05.01.23.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 23:54:57 -0700 (PDT)
Message-ID: <4ef41597-c905-5c3f-f8b5-3e91f09a7501@linaro.org>
Date:   Tue, 2 May 2023 08:54:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 1/2] ARM: dts: mvebu: Add device tree binding for
 Marvell Armada 38x
Content-Language: en-US
To:     Tony Dinh <mibodhi@gmail.com>, Rob Herring <robh@kernel.org>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
References: <20230412025737.20280-1-mibodhi@gmail.com>
 <20230412025737.20280-2-mibodhi@gmail.com>
 <168130276446.1439316.3427548118074442016.robh@kernel.org>
 <CAJaLiFyJcMxcJ-z0LRtazoMtGZCqdNXWMv7ZnvCdXREVDeMGEw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAJaLiFyJcMxcJ-z0LRtazoMtGZCqdNXWMv7ZnvCdXREVDeMGEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2023 00:46, Tony Dinh wrote:
> Hi Rob,
> 
> On Wed, Apr 12, 2023 at 5:36 AM Rob Herring <robh@kernel.org> wrote:
>>
>>
>> On Tue, 11 Apr 2023 19:57:35 -0700, Tony Dinh wrote:
>>> Add device tree binding for Marvell Armada 38x.
>>>
>>> Signed-off-by: Tony Dinh <mibodhi@gmail.com>
>>> ---
>>>
>>> Changes in v2:
>>> - Add marvell,38x.yaml. For now, add this binding to the Marvell
>>> directory to keep it consistent with other Marvell yaml files.
>>> At a later date and a separate patch, consolidate the Marvell
>>> yaml files into  marvell.yaml.
>>>
>>>  .../bindings/arm/marvell/armada-38x.yaml      | 27 +++++++++++++++++++
>>>  1 file changed, 27 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
>>>
>>
>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>> ./Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml: $id: relative path/filename doesn't match actual path or filename
>>         expected: http://devicetree.org/schemas/arm/marvell/armada-38x.yaml#
>>
>> doc reference errors (make refcheckdocs):
>>
>> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230412025737.20280-2-mibodhi@gmail.com
>>
>> The base for the series is generally the latest rc1. A different dependency
>> should be noted in *this* patch.
>>
>> If you already ran 'make dt_binding_check' and didn't see the above
>> error(s), then make sure 'yamllint' is installed and dt-schema is up to
>> date:
>>
>> pip3 install dtschema --upgrade
>>
>> Please check and re-submit after running the above command yourself. Note
>> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
>> your schema. However, it must be unset to test all examples with your schema.
>>
> 
> Would dt-schema in Debian 12 work? or must it be the latest dtschema
> installed by pip3 or from GitHub?

If Debian 12 has latest schema, it would work.

Best regards,
Krzysztof

