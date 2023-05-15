Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1256C702474
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238418AbjEOGV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239223AbjEOGVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:21:52 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC9226A8
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:21:44 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9659e9bbff5so2281589366b.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684131702; x=1686723702;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gCdYehuHtMBJkQhcQnnc18frs4/zKzkQbtorybO4QbE=;
        b=YE2d18qXjOcHQ0iNB9GPzwMndPYTSYsGBWPDbDjd2uMYaxOF5eAogLkX3ZJJJq2C5E
         2vhZ8/W0NRVQrLyrB1QN4Vl/ZaNOjNxQM/KL6AC2s9GjjaWLA/UEirVZpteo+C60ZpAL
         UwohJdhqto6EN4kmXUvstDm82pKDqVPAccb7PEguZxmvWbuRYmdsdTwsn6aXX2Fe+7jm
         paXIhkeavQ/NyRt4MFh2wTua1ksy+XN93HpGBBFZ8cqpIRUsmz/UIP2jXI/DwphrJO3P
         rECDcfOTWJ6+eunaAZ7Puvdn9ovynMNbx7VH35Attpang8/69rwchZCC+8MVPR8fcz1P
         NH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684131702; x=1686723702;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gCdYehuHtMBJkQhcQnnc18frs4/zKzkQbtorybO4QbE=;
        b=fsMlO7zTaDaQeO22er2tCL/IfqJnOBZ5Pltb3QWG1lHHpjArYsHi8LjCe2axKGlT0E
         upQMMX7F3Fdb9yQKbqX8jaBlyFPGIihkUpuOkxdu+ckEKBD5N5nJkRJ+eWa+CQ6cC2ki
         mMujdlmD8wvQqp3rjTrTgdpEyKV8pJc46cdWZqEuil02N63EYq8XER5f/6bPpQEsq60w
         TEuHM/ONO84by6oI9+fbmQE38ictqnV+Jwwc6zNU3+aFZtr4zTtt41Er5/AAKzm6U7Gm
         Q1xTTk3HPOuzCDrJKfI1ZT7YCnYmd0q4HWWRHTexZUB8SoqbZW2zhfyA8DhUxj+LImxB
         XbMw==
X-Gm-Message-State: AC+VfDyW2v2b1/vax6h2CIQ+j2JMReT7pZSv/nSnfkl8QzsC4TnsbzhS
        s9kbt6AxAabv/A1VVssEMSj1dA==
X-Google-Smtp-Source: ACHHUZ5jIhr9vUXrfjLJi04VXD0aXHCRRjFBQbUN4Qcl5Y/Ch0674b/4pc9EH/oV2mRGaehrBbbhWw==
X-Received: by 2002:a17:907:318b:b0:957:17c5:8705 with SMTP id xe11-20020a170907318b00b0095717c58705mr26963506ejb.51.1684131702568;
        Sun, 14 May 2023 23:21:42 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:6470:25b8:7c2d:1992? ([2a02:810d:15c0:828:6470:25b8:7c2d:1992])
        by smtp.gmail.com with ESMTPSA id qh20-20020a170906ecb400b009655eb8be26sm9026817ejb.73.2023.05.14.23.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 May 2023 23:21:42 -0700 (PDT)
Message-ID: <f38c8762-2aff-737e-a1a3-0e457f9d3810@linaro.org>
Date:   Mon, 15 May 2023 08:21:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4] dt-bindings: net: nxp,sja1105: document spi-cpol/cpha
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230514115741.40423-1-krzysztof.kozlowski@linaro.org>
 <20230514-turf-phrase-10b6d87ff953@spud>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230514-turf-phrase-10b6d87ff953@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/05/2023 20:32, Conor Dooley wrote:
> On Sun, May 14, 2023 at 01:57:41PM +0200, Krzysztof Kozlowski wrote:
> 
>> +allOf:
>> +  - $ref: dsa.yaml#/$defs/ethernet-ports
>> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          enum:
>> +            - nxp,sja1105e
>> +            - nxp,sja1105t
> 
> Is there a particular reason you did not put the "t" variant after the
> "s" one?

Order is the same as in compatible list. I could sort them here, less
changes in the future.

Best regards,
Krzysztof

