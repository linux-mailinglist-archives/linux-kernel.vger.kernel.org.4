Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41ED35EDE9F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbiI1OS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234285AbiI1OSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:18:24 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A26A6AC7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 07:18:22 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bu25so18707816lfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 07:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=1YTPEs2grmzd8FfasAPccFml/qOKmBaeOYlbAL2/Wvo=;
        b=hEeRxnQ8aIgTaPN2jPgNpHFkdpZ/TOoWu0jXE2jk1LZZy1nvYG4DzBs8Ow8G5LCV70
         Vy8ViykKw3YsPCOC0g/RuVeBZOSEghW76CupRv0bVJyY/adyiNyeCTcHU5s/l5AReYwf
         rTbsPlm/Ly9OdK2HK+AZE2cqu/D0l8NhHLm4EVcyrBso2LXNYHJz3PvEtnjwkGxXcXYS
         2odGgP4D7l3X1Kt25PVhKrobvVEk8S2o/JyCAqv5MDYN5oLFOwWSdRGPQyIHkfCnsJsJ
         QFj80xDHdCwoUmMnTCB9d4l6kwqh6bOFAfm1OhF2PSAFl0F9B3hY1nyMYzbT5pt/4BhW
         GFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=1YTPEs2grmzd8FfasAPccFml/qOKmBaeOYlbAL2/Wvo=;
        b=dbIgqqkf4KjN5FSRlttyfybZB9MGXfnJSc6JzNOhU7sPQ4lRfxvAaLUNqcUvbkv9vi
         +623Nyqfn/LtigUpYT+Tt7eqsQZLvNzyxMR4SpX5dQaKSGobH6NROZ04PBWTqGUnkqyP
         TWH5PAlPRRhKe6J1fSMcTD0oLO8IEdg84QxgXVQkGg1vmefutfxit+dkohKVLK0NwM2O
         Orb+wBiOlxqzsejID7bNcpWBBi6/IMOZ3t6SFWzLPoqDCmx1iuqCxgGZX4tm8nECo9ux
         gy2VurlHZXeac3Fwo/evQahFpqa3sCxPS+GmjQlVvPZCiYNEslUnPiOen5LhNZuS0T0A
         DasA==
X-Gm-Message-State: ACrzQf3WG//5Y0bXWIjJ9n5FQGboktOYx3w6w4a5htk49oFkHOE6axwI
        E+k0DXjADbv6wy91TAG0yitzZA==
X-Google-Smtp-Source: AMsMyM4Bc4KIMAmbgDB0KdFkipqTgkuVUPDPRiqpPqk9UR5ow83xb4fJOlEf8jtxYz9Oq2nIdPBJlA==
X-Received: by 2002:ac2:5493:0:b0:498:f55c:7fc7 with SMTP id t19-20020ac25493000000b00498f55c7fc7mr12876584lfk.381.1664374701152;
        Wed, 28 Sep 2022 07:18:21 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g19-20020ac25393000000b0049482adb3basm487642lfh.63.2022.09.28.07.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 07:18:19 -0700 (PDT)
Message-ID: <9b2f2d43-981d-3ffb-7526-dc3e58a9f367@linaro.org>
Date:   Wed, 28 Sep 2022 16:18:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v5 2/3] dt-bindings: thermal: add loongson2k thermal
 binding
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     zhanghongchen <zhanghongchen@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>
References: <20220928083702.17309-1-zhuyinbo@loongson.cn>
 <20220928083702.17309-2-zhuyinbo@loongson.cn>
 <066b55cf-4a28-89a2-56ab-572590c97c30@linaro.org>
In-Reply-To: <066b55cf-4a28-89a2-56ab-572590c97c30@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 10:37, Krzysztof Kozlowski wrote:
> On 28/09/2022 10:37, Yinbo Zhu wrote:
>> Add the loongson2k thermal binding with DT schema format using
>> json-schema.
>>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> 
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
> 
> https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540
> 
> If a tag was not added on purpose, please state why and what changed.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

... and please test your patches before sending :(

Best regards,
Krzysztof

