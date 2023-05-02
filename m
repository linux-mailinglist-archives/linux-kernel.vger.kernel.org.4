Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C56B6F44B4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbjEBNIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbjEBNIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:08:34 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC7159D8
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 06:08:23 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-95316faa3a8so759301966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 06:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683032902; x=1685624902;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vTdVXb6d4xnv0YmTLdS0Qi0kVGTI9rnff/94Pf5/JNU=;
        b=OTiDWyUjc5vLKmDjfmk7vFBEmIE4CpI9soc/Ksp7mPInOkA3TNy6L2M7frTwl2kzaE
         tHgRxck2zMMwnkrzOBupt0niab9C6KVELTQkYM6fF4egq3bJC5ruaJCdxck/wB+J/Q4J
         rUjVjH/5Ymwx64TrF0ZMxxtL7qfixmlnzy4h0s0zJ0NTqw4VRiojQ0TtdDTmLLbD0dmp
         FQFqu/vlqgPP0kzO6K0gBFpAQ/Irbo6CMQypZzqTo3astF/GdzyFsHWoFwQ5f+hyfeBo
         INll3QaytXjs0N3qnXo180nKkheCRvj3eji1cekBtql1r5j9k3gsP7HM1WAybQNC6hVC
         WQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683032902; x=1685624902;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vTdVXb6d4xnv0YmTLdS0Qi0kVGTI9rnff/94Pf5/JNU=;
        b=HqdkE3lWaaCihBIaAXz9RvbyjGiqzzMtwegO/O3J1Nf3H/SPDNyLnjaOJ2EKxvKpnb
         6KzHMsZkIA2MOK5jHWiUqWIROBIvHdZR6oqRvqiVv6+BmVvH+DvHKwRMLBmTUUZliC7P
         nhKz8ppM9cXYX1U12dmVsFWUDSLwC2NkVtmovIlD5WSdA9/ynF5rlk+aF+VjtdVTE6a2
         k+fcCw/6HWGMPnjGuQunBv9Nh9nzKnax03X4kI3fsM2YeNusq6V6YYxMKkk/RdPdnNbi
         fgBNPy1vg1PtGhd1iqFj2pjocXBfNO2szikLi2pmiQyGOATGT2riXBsgeTnaSyOqFvn/
         xKVw==
X-Gm-Message-State: AC+VfDwUfa1gPhzWlPkUnM0apEtVellRV7sYsURmdUEJOLZoqHPUMvda
        STrjtIrySne0VkmRAX7paJqEaw==
X-Google-Smtp-Source: ACHHUZ75BXm0BWRSmTJcDouunvHBmhjCdZtr03hxCxdUgu1OaMxH5zZSLU7E9xbmohDbZRVAPPrOjw==
X-Received: by 2002:a17:907:c0d:b0:94f:969e:c52b with SMTP id ga13-20020a1709070c0d00b0094f969ec52bmr14376500ejc.74.1683032902382;
        Tue, 02 May 2023 06:08:22 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:bafd:1283:b136:5f6a? ([2a02:810d:15c0:828:bafd:1283:b136:5f6a])
        by smtp.gmail.com with ESMTPSA id lh11-20020a170906f8cb00b0094a789256dcsm16133602ejb.111.2023.05.02.06.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 06:08:20 -0700 (PDT)
Message-ID: <665a0e0e-6320-981f-8675-95f064864837@linaro.org>
Date:   Tue, 2 May 2023 15:08:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 2/2] dt-bindings: display: novatek,nt36523: define
 ports
Content-Language: en-US
To:     Jianhua Lu <lujianhua000@gmail.com>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230502120036.47165-1-krzysztof.kozlowski@linaro.org>
 <20230502120036.47165-2-krzysztof.kozlowski@linaro.org>
 <ZFEFwwU9_h36xFvd@Gentoo>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZFEFwwU9_h36xFvd@Gentoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2023 14:44, Jianhua Lu wrote:
> On Tue, May 02, 2023 at 02:00:36PM +0200, Krzysztof Kozlowski wrote:
>>      description: regulator that supplies the I/O voltage
> [..]
>>  
>> +  ports:
>> +    $ref: /schemas/graph.yaml#/properties/ports
>> +
>> +    required:
>> +      - port@0
>> +      - port@1
> Konrad has added a single DSI panel to this bindings, so we should
> drop port@1 to allow it.
> 
> See https://lore.kernel.org/lkml/20230412-topic-lenovopanel-v3-1-bcf9ba4de46f@linaro.org/

Thanks, I'll send a v2 ~tomorrow.

Best regards,
Krzysztof

