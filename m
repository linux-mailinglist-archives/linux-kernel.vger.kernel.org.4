Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0765BC070
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 00:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiIRWlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 18:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiIRWlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 18:41:45 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2618513DD7;
        Sun, 18 Sep 2022 15:41:44 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id i3so14758794qkl.3;
        Sun, 18 Sep 2022 15:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=T3gVy8PY5F80NKzToZR+FbLhKAMIz93GHIgxt0CrUHc=;
        b=IdhMRMeVpLQC67KcBFbCc/Jk0NGq4dg7JkjAwoTSwVgFyHVLpmo57WQ2VAAFPSpOJR
         r/9qz+pdnTpAd4aPzMyGQSWik9rG81luFOikAvBJeo/smV0jCiTpWVQRbtdBD11hJ5k5
         l0DbhUSUT8rbGhN/x730+aAlpW9MR1K1+gYSN2IJK+rVK5hpDSv1JYkHcMi45dtuqGjR
         fSgMTT+gm/9mlBfp9hEjn7wRVetzg1vsIXa0ief0VysCXiH+e5dsCFW1G4DCBFE8A40K
         xr4IsApIfjEqUZLbzo/a9wIdVKrsR8252r9e6m7jTn8timZ9ipitjOxOwiqosjNzfFUQ
         jjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=T3gVy8PY5F80NKzToZR+FbLhKAMIz93GHIgxt0CrUHc=;
        b=6DKLWM9edlfAXYNAIZIvrCMIrD44HXIuIGnLUUPPdNCoR64HIQ7FM40iw69+qOnPAP
         +nkavXj0qdPdeUXl1o8OzaunKjlx059iU3PUeNVKV6wvsgmuWIGtO1FmByYQIfgDlRGV
         q02/Ch2BmEEKIaUIpKnrNaSRCHEtAfhICthaDtT0yPFDhwlajy5zZbfyNOFPnUoemd+O
         Js0y79X0MU34dzc2SqAb3IkJLpkL6AMYOlNIiSPtmuy9u5CXixo0OrXlKEIHxCmnUZKp
         cUg7T4wg/gNx2eXrZnnouNOixkDTsMoK+bl65Tgy4G96imKZL3sLOgnrmo2O2YCdoV2s
         x0MA==
X-Gm-Message-State: ACrzQf1BoccWkNDEM5Vu1ZlZ5hWtPH1n2+ri6afoqgCZel5f4x8QGZRS
        vwCjaRf58sWWK7ZZ/Sfqbg8=
X-Google-Smtp-Source: AMsMyM79ModVLCgaO51KZdimfwEWQbDJb0RVfNll2I2jhJXQhJFNDD2szD3/oSle4SS7VVvj1xrxgQ==
X-Received: by 2002:a05:620a:2441:b0:6ce:bc87:a3b7 with SMTP id h1-20020a05620a244100b006cebc87a3b7mr11277117qkn.113.1663540903292;
        Sun, 18 Sep 2022 15:41:43 -0700 (PDT)
Received: from [192.168.1.50] (ip70-191-40-110.oc.oc.cox.net. [70.191.40.110])
        by smtp.gmail.com with ESMTPSA id d8-20020a05620a166800b006ce0733caebsm11017959qko.14.2022.09.18.15.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 15:41:42 -0700 (PDT)
Message-ID: <32303ffa-3f0c-5a83-fe97-69fca07c3b32@gmail.com>
Date:   Sun, 18 Sep 2022 15:41:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 16/21] dt-bindings: reserved-memory: introduce
 designated-movable-block
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Rapoport <rppt@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Oscar Salvador <osalvador@suse.de>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        - <devicetree-spec@vger.kernel.org>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux.dev
References: <20220913195508.3511038-1-opendmb@gmail.com>
 <20220913195508.3511038-17-opendmb@gmail.com>
 <be75776d-c55a-ddce-81f3-aeacc2f29592@linaro.org>
From:   Doug Berger <opendmb@gmail.com>
In-Reply-To: <be75776d-c55a-ddce-81f3-aeacc2f29592@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/2022 3:28 AM, Krzysztof Kozlowski wrote:
> On 13/09/2022 20:55, Doug Berger wrote:
>> Introduce designated-movable-block.yaml to document the
>> devicetree binding for Designated Movable Block children of the
>> reserved-memory node.
>>
>> Signed-off-by: Doug Berger <opendmb@gmail.com>
>> ---
>>   .../designated-movable-block.yaml             | 51 +++++++++++++++++++
>>   1 file changed, 51 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/reserved-memory/designated-movable-block.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/reserved-memory/designated-movable-block.yaml b/Documentation/devicetree/bindings/reserved-memory/designated-movable-block.yaml
>> new file mode 100644
>> index 000000000000..42f846069a2e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/reserved-memory/designated-movable-block.yaml
>> @@ -0,0 +1,51 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/reserved-memory/designated-movable-block.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: /reserved-memory Designated Movable Block node binding
> 
> Drop "binding"
> 
>> +
>> +maintainers:
>> +  - devicetree-spec@vger.kernel.org
>> +
>> +allOf:
>> +  - $ref: "reserved-memory.yaml"
> 
> Skip quotes
> 
>> +
>> +properties:
>> +  compatible:
>> +    const: designated-movable-block
>> +    description:
>> +      This indicates a region of memory meant to be placed into
>> +      ZONE_MOVABLE.
>> +
>> +unevaluatedProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - reusable
>> +
>> +examples:
>> +  - |
>> +      reserved-memory {
> 
> Use 4 spaces for example indentation.
> 
>> +          #address-cells = <0x2>;
>> +          #size-cells = <0x2>;
>> +
>> +          DMB0@10800000 {
> 
> The convention for node names is to use lowercase and generic node
> names, so just "dmb".
> 
> 
> 
> Best regards,
> Krzysztof
Thanks for taking the time to review and provide feedback on this patch.
-Doug
