Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3B47062AF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjEQIYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjEQIXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:23:54 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915703AB0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:23:52 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-510a59ead3fso707213a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684311831; x=1686903831;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LKUIs50mnG/Knu4CLF/A96KY4SWKyjHZGjCyjw2baO4=;
        b=xDvL5sQ+DjWEIr5GoQyOeWMPcVUdgea2iobHJW1TnN8/cjb3uYuoxBRO5ONKv0BZAT
         8981ycPq0MWXiUIx/ecTG4EynrbkzKAzVyGJ4AfOdNF3Qm0veuDInBrds2quBika/Xmv
         s4/4KgK0NTl+h2wEbi7ACJc1JIEISD0N3hjtuCKVgzyINzPK5TQv9aSKLyiM5delIPH3
         vDb5vngLmWMvttRB8+2vsHUrjl/9yqscY1ROOfTpcuWk+RxvDXpsrJ7BKmzw3eD0ElCA
         CASgBv2+/2qRJfVTw6CMUr3knbtLadmBmjcLPgKMJSoCOGL1jPCkcbwX76zooIaE6DpB
         Beog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684311831; x=1686903831;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LKUIs50mnG/Knu4CLF/A96KY4SWKyjHZGjCyjw2baO4=;
        b=HgVtQNotNK6pmEaYPMZxgYr28fxH22PguwgBlfrk48fRm1ovIjjss1AYn3cg39cd62
         PX+PHK0OPKqkLWK5s0XKiR4l8nifUuCnGhgy1UY6xEXpIq901b8b0YKmZ2kBvDIZwTxI
         6VMOK0WRHD8AIjcdYdLq7k/SoLcGetQOV3cK9BJQ+kf4dBoxJbFqNoqnsFdmLEyjUGMQ
         fTndnrAQocz5T3+H0oQwLmkO2EU1e+CSA0d7+Y2BmgbymB4RXIQRUyHXFcv4Qrw6UsT5
         mJhExx6SbvuMRMGH0M+S5FEM+sOEXEsvtjC7+NUye6O8+v2c1Y2njRKRwS9E1/LRCNa3
         0Dxw==
X-Gm-Message-State: AC+VfDy7Q7hHVyHPF/fldOTEKDak31lX/jQfQJEKMe2yGQ4RtjMb1YX9
        n0uGGq4Ktr5L+yofZcCw+za9MQ==
X-Google-Smtp-Source: ACHHUZ6JAU9IyvwDF7lt/LO8E3EuXYi5lw61lPs7XcWdpC28r6MFpbSeQVAKg2TYT4dhri6K8nNUhA==
X-Received: by 2002:a17:907:a46:b0:94f:2b80:f3b4 with SMTP id be6-20020a1709070a4600b0094f2b80f3b4mr32901870ejc.69.1684311830969;
        Wed, 17 May 2023 01:23:50 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c9ff:4c84:dd21:568d? ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id mm30-20020a170906cc5e00b0096595cc87cesm11997266ejb.132.2023.05.17.01.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 01:23:50 -0700 (PDT)
Message-ID: <c585ef60-1482-ad53-3b7b-44163754c0fa@linaro.org>
Date:   Wed, 17 May 2023 10:23:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5] dt-bindings: net: nxp,sja1105: document spi-cpol/cpha
Content-Language: en-US
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
References: <20230515074525.53592-1-krzysztof.kozlowski@linaro.org>
 <20230515074525.53592-1-krzysztof.kozlowski@linaro.org>
 <20230515105035.kzmygf2ru2jhusek@skbuf> <20230516201000.49216ca0@kernel.org>
 <124a5697-9bcf-38ec-ca0e-5fbcae069646@linaro.org>
 <20230517070437.ixgvnru4a2wjgele@skbuf>
 <20230517070826.ywncgnuyoi67zttg@skbuf>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230517070826.ywncgnuyoi67zttg@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2023 09:08, Vladimir Oltean wrote:
> On Wed, May 17, 2023 at 10:04:37AM +0300, Vladimir Oltean wrote:
>> On Wed, May 17, 2023 at 09:01:38AM +0200, Krzysztof Kozlowski wrote:
>>> Yes, apologies, I usually forget the net-next tag.
>>>
>>> Shall I resend?
>>
>> Probably not.
> 
> Although patchwork marked it as "not a local patch", so no tests ran on
> it. Let's see what Jakub says.
> https://patchwork.kernel.org/project/netdevbpf/patch/20230515074525.53592-1-krzysztof.kozlowski@linaro.org/

I will just resend in such case.

Best regards,
Krzysztof

