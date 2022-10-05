Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D3D5F507C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 09:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiJEHyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 03:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiJEHyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 03:54:37 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CE71D5
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 00:54:33 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bp15so10946795lfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 00:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=HIQiD4rxFsd5dH3nMVqlPOd1Sb3NYZbeQQm1mzSwnV4=;
        b=lrgyI70bsWbp6T2v7mNCaLIuB2btVF3QBrquibHb4YuoEbB/LL30jCk7wEHi3W7Sto
         /64YHSSOvR7YECjnltjVOoklXfKYLpzjrfj7hqrt1vPKp2mTQZsj3pYBiNjC3oovOSno
         Zi60hP/DjPZbTsys7nsfpg5LSgCarbFaHXonOAZxntd3QoWUtfXRYkukAoFyMeC+1tEt
         or+StY099N0tPoQKBykzlylAFpJH0bmSrvswMN/4fUUOtiw6kYHfs1MBnZ5KxvzrN177
         P6dlu77ryIf6clf3mfs+9PIztUF1X8eW1cLoi0+cwCka1f3sGtMuOaQsPjsxga87b771
         wQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=HIQiD4rxFsd5dH3nMVqlPOd1Sb3NYZbeQQm1mzSwnV4=;
        b=UnVmuB/5fvTBkNYthws5gV8tIwxDXLfYsJ6yyP5DaFijPIJeqOlukICk9F24txzLxz
         jOu1Rmfc/sugz/tRjpC4IUfG+iF+cQ4Xw8Si0F2ou6hovslpEmdMtelc6Al8dGXszB34
         AJl6kY5qts/sLljnktfOh5D5wUjcGflQP7n9TkL9mhcigrlTlI5mCxWcuoXStTThS3JU
         aB7jqPBuE4q70xLMahIQGcA2AZNk82OAx8qFAqryD0nXDeCC1slQug88LiIY3/dLVshl
         DKWLR8G3PuXSdBhNcyDCyLrzTMiIEomH+FIYpkX/StAgjIbM8yvxbIKnOe6ODB+RRpYD
         vdcg==
X-Gm-Message-State: ACrzQf3nGRzcPLPYa1ygo/d79GZJ5CTI3/muVU0DCH/8Ii+rjXOeCSJ7
        uOLjbKp4j+a8NxgshMN1Oqwhm/wjw1SA0A==
X-Google-Smtp-Source: AMsMyM647KSEfdK1s9YqL1xht+20nnUv8L2EKDFihJnKCCc3CfaHAi84e2yc4z9pIoM+3cSTyI8Bug==
X-Received: by 2002:a05:6512:1522:b0:4a0:2dd4:bab3 with SMTP id bq34-20020a056512152200b004a02dd4bab3mr11163828lfb.130.1664956472274;
        Wed, 05 Oct 2022 00:54:32 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id i8-20020a056512318800b00498f1eddad0sm2249573lfe.122.2022.10.05.00.54.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 00:54:31 -0700 (PDT)
Message-ID: <2ab2940d-36b5-d4b3-da8c-9dc0bded7bd8@linaro.org>
Date:   Wed, 5 Oct 2022 09:54:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [net-next][PATCH v4] dt-bindings: dsa: Add lan9303 yaml
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jerry Ray <jerry.ray@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221003164624.4823-1-jerry.ray@microchip.com>
 <c1b64758-219b-9251-cea8-d5301f01ee7f@linaro.org>
In-Reply-To: <c1b64758-219b-9251-cea8-d5301f01ee7f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/2022 19:48, Krzysztof Kozlowski wrote:
> On 03/10/2022 18:46, Jerry Ray wrote:
>> Adding the dt binding yaml for the lan9303 3-port ethernet switch.
>> The microchip lan9354 3-port ethernet switch will also use the
>> same binding.
>>
>> Signed-off-by: Jerry Ray <jerry.ray@microchip.com>
>> ---
>> v3->v4:
>>  - Addressed v3 community feedback
>> v2->v3:
>>  - removed cpu labels
>>  - now patching against latest net-next
>> v1->v2:
>>  - fixed dt_binding_check warning
>>  - added max-speed setting on the switches 10/100 ports.
>> ---
>>  .../devicetree/bindings/net/dsa/lan9303.txt   | 100 -------------

Beside that you got errors reported by kernel test robot.

Best regards,
Krzysztof

