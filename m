Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7AD6BDDE4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 02:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjCQBDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 21:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCQBDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 21:03:06 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2B53A87F;
        Thu, 16 Mar 2023 18:03:05 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso6912012pjc.1;
        Thu, 16 Mar 2023 18:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679014985;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U8KNhZxtIwwnFgPoB9cKshvnNQ6ZSPfMANNSxGtCt/E=;
        b=JkrFFCsyfZ5ctVkc1+n+HgBbo6I8Bt5EUUw6DlqoHj7oE2rPzaVj1pAv3GrL6tJC+d
         MVTM/8KN01m4LymcM/E0iwkIMWryo75g1XecCEkrEPKbN6nuQe8RLvNtXPizT6Nko1GX
         lyAz46AaF+Q1hPmuLVtlzDroP10ZZnN+HnEcUzWuQ3Cty++/FhkXW9YAuhAC2YBAaxwF
         ZDnxZRu4/MJU+VnT2RHRVU99KbbeILSzrYPqOXzmpqEOrT1WP6b5uodevoFWK9zA20in
         UW9nRGrNUkz8K0Mxh1f35nhIRZE/n6vCPTKq/mgQqFNF6SHD5VosOWaM1xLfJ9ISNejI
         I3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679014985;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U8KNhZxtIwwnFgPoB9cKshvnNQ6ZSPfMANNSxGtCt/E=;
        b=7ep8jgEWFl623BIBlJ+bTzhYnQJmX1iCLy67R01FmcBY1+xhi2rS/dafcFes8P7c00
         0zUkLtdjdKK6mZbIuhDs9ymvMU05/GBzsUS9kez/nQ2sg6ghTFc5uotpaDWFO4BHRhkT
         ERUYidS2bkAFumNbjIxDe76cercPjilEp2aG1tCCLHrsdRE2dF6GT6/PFazYjZpJH0qu
         nOn6sZjfytL/W9MMNZD2untDsbD4UQm+JhUG9bStqK/en5AoPY4jmvHcsgeG8smNIz1Z
         MQksl+p0VEdlu7j6WXCslDEK/DBv+ReCQOjzmVEmAFOImtbkX+IbYRx2jjaTUEx2srvj
         OGtQ==
X-Gm-Message-State: AO0yUKUQv+7XmNZN2fl7S44fgXN/BHOshHYRYLeIz9osl1fIVpEIAofL
        /7VXQUMDdyEyn5Er+RVWMrA=
X-Google-Smtp-Source: AK7set/v4wjGRC3TH9FG8GJbcppkm0YTmHnGNZoOn/RAmXHcWRSAiWlitjQW0cpvhX7DSXTeY20cnA==
X-Received: by 2002:a05:6a20:a61b:b0:d4:979a:e31c with SMTP id bb27-20020a056a20a61b00b000d4979ae31cmr4612994pzb.62.1679014985073;
        Thu, 16 Mar 2023 18:03:05 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id j24-20020aa79298000000b005897f5436c0sm290391pfa.118.2023.03.16.18.03.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 18:03:04 -0700 (PDT)
Message-ID: <2f7d87dd-75dc-afa0-e11e-ffd1afc8de3b@gmail.com>
Date:   Fri, 17 Mar 2023 09:03:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 06/15] dt-bindings: mfd: syscon: Add nuvoton,ma35d1-sys
 compatible
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-7-ychuang570808@gmail.com>
 <84805483-b20a-8dd7-6efe-904f59e063dc@linaro.org>
Content-Language: en-US
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <84805483-b20a-8dd7-6efe-904f59e063dc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Krzysztof ,

Thank you for review.


On 2023/3/16 下午 03:31, Krzysztof Kozlowski wrote:
> On 15/03/2023 08:28, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> Add Nuvoton ma35d1 system registers compatible
> Missing full stop.

I will fix it.

>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>> ---
>>   Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
>> index c828c4f5e4a7..e7a3c6e1e77f 100644
>> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
>> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
>> @@ -57,6 +57,7 @@ properties:
>>                 - microchip,sparx5-cpu-syscon
>>                 - mstar,msc313-pmsleep
>>                 - nuvoton,wpcm450-shm
>> +              - nuvoton,ma35d1-sys
> Wrong order

I will fix the order.

>
> Best regards,
> Krzysztof
>

Best regards,

Jacky Huang

