Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C92D606091
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 14:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiJTMt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 08:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiJTMtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 08:49:21 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B2C221
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 05:49:19 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id l28so13574359qtv.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 05:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7zzLiSLuWDpRehAEZWWY+YVaKXFqQFcIBPnNnew2YXA=;
        b=PdZuxs6MjlDnlNzQz5OvgwlDa4ipQHz3SJcbSHa8GGxbWqYSCrOhrIpgIRmL0bbZyh
         cQ/sT3Wlegy+jRZn9G1hxurXh/athUMdenfE1TvCD29eTKmi6c8pjsNRtPhrotLNmDyI
         Ogiai7InvvtM1nydktd0c3f6udis80eG18SRwTqONqnpXIzVkCOtQd7VCOHq6vwPnThU
         L6zklbV08bsN+NZcOAe15qsbT0g24eNmyKRzjz5G3amKpMkDrQGfNK8lySHp4iVl+7p0
         BuAzVzXn8CEI4UPcx8eE6mZfJ4AZlZXZpqiyZYQ78xKYVX0Mfu3M7j6TgM4q4Cqf9M92
         3+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7zzLiSLuWDpRehAEZWWY+YVaKXFqQFcIBPnNnew2YXA=;
        b=lvOOuH3OwRx0RbuNxCcqeV1B+x8EzZfyZXTT+d+hFMnpsTzzPF7V4r6W8fjbM7w4Gp
         KU2Zc3AnZN+odPa+/2B7IX21wN4Ie5opi1B/ahpea+wMGO/w/e5MG+5zgUR6TDo61gjP
         s5vR1dWeOStRtIkXT1UszWOYMpK+ygb6DzSX2O3mfiUAO+Gy5SKY0t3db+0rycMKeW8P
         tnoXRWFT6cTVKmzltt3DWunwo19g6C48GtEGhy8A+E/xgLtvVAsWa5IYN73Gg+KIdDKk
         Y8h4VGvy1v/DL2gDeIN5V+nCnafL0xgISmO3csL8uFCC7PVuGfHcYjE+wuYwT4pi6IkV
         WMlA==
X-Gm-Message-State: ACrzQf3vX5mPPSk3er19sOhelMy6XGNDTgYrsqllg/+i5rdzCKh0cdoK
        uR/cAYaSHjFZTBzc6Tf5QgjOsg==
X-Google-Smtp-Source: AMsMyM4t+vrwAcBb+25n+go7JZPtlChxYQtXIsomDdytCwaeNLSbAoJXk3x6Ke4EBw9HmsWcmg8Jnw==
X-Received: by 2002:ac8:5a42:0:b0:39d:136e:8a43 with SMTP id o2-20020ac85a42000000b0039d136e8a43mr1118096qta.372.1666270158481;
        Thu, 20 Oct 2022 05:49:18 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id u7-20020a05620a430700b006cf8fc6e922sm7133652qko.119.2022.10.20.05.49.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 05:49:17 -0700 (PDT)
Message-ID: <20c115e0-0acf-dac2-2a30-0f394fa513ab@linaro.org>
Date:   Thu, 20 Oct 2022 08:49:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 1/2] spi: dt-bindings: amlogic, meson-gx-spicc: Add
 pinctrl names for SPI signal states
Content-Language: en-US
To:     neil.armstrong@linaro.org,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Da Xue <da@libre.computer>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221004-up-aml-fix-spi-v3-0-89de126fd163@baylibre.com>
 <20221004-up-aml-fix-spi-v3-1-89de126fd163@baylibre.com>
 <d355ee40-5905-4d10-8300-81e9a63117ee@linaro.org>
 <dc918114-8b89-441b-5ba1-aaf3ae084860@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <dc918114-8b89-441b-5ba1-aaf3ae084860@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> +      properties:
>>> +        pinctrl-names:
>>> +          minItems: 1
>>> +          items:
>>> +            - const: default
>>> +            - const: idle-high
>>> +            - const: idle-low
>>
>> You should also define in such case pinctrl-0 and others.
> 
> Ok I thought it would be covered by the pinctrl-consumer.yaml
> but yeah we should allow pinctrl-1 and pinctrl-2 here aswell by adding:
> 
>              pinctrl-1: true
>              pinctrl-2: true
> 
>

Yes.

Best regards,
Krzysztof

