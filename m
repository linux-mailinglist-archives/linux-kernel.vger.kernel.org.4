Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738515B3114
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiIIH4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiIIH4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:56:36 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC612B622
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 00:54:39 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id bs13so860909ljb.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 00:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=awBA0E2ogM2ajE8k1bTdqwTL4e3LIH+ZvAf6BsRqjE0=;
        b=e1qSnFEh+XDMkIp1/Fvzqz9XEKXEYXxS5gNTe8UEoYHZCEgpgbBrw24tArbzFr9Vvz
         xrzX1UkUmHg/RL8NY0tPbKbCa6POX7/y+JyPPWeejfg0cUiZkV8yt62nDMjAtfohgYHd
         8QZU2X7FabQQiiR8PGvxO+B+y01LORCcNs3QqmgBLQ2E80TQ2+4lMjsX1KVP3tQDqpiZ
         uaqe9AlkInKwJRk/0uvvMBqfCpFmry+nWl0MgNNDGVIh4hUxujIWnbrTMyJ3J0y6Whw6
         SZB7yqLYDLGowIusE3ccaD9hEQzscwpx23w3gF3fkKlBw8ruYZFQ2XD9eSwKQt1fRH1Q
         fDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=awBA0E2ogM2ajE8k1bTdqwTL4e3LIH+ZvAf6BsRqjE0=;
        b=yjUyfrFcNIAjbLGWEpOCup5t0+36eadET60Wch0ATRVU2lvJY+cy18TkADW7n1A2+8
         EF9zdePn1f1eoRae93RevhitSAjSelz3koUlDfMEfoFN5hvhcijUxqZ3MjmiBLZwCxhs
         M4YDyzq9n4CcLvKfh4E4YMqHnPNZR/kCXGshSd7N6zJyGh/jdsylqUUezdFdyMukxSM+
         evJkkquqkqFsrEScynOONQvPxUhHOngeuZ7/aaFc7dtMU+cdTD0fIhzFkIt61gDC5bMf
         rBDSi4M8ADhIaPPMwGzpFedfOPYAGsOARhTewZ4xhoEd7FT1uJ3+oKBgNN+i5I8JY7ZW
         qYyw==
X-Gm-Message-State: ACgBeo3n5mE3qJYEVqIkz1j1JOaQCtbt7jxlUFlm3LofEcRxXWE/IYoz
        0ht6UAulUfkT2Mc+LNVgqSonVg==
X-Google-Smtp-Source: AA6agR5qURN+aVof+MSVvttkLwY142Jq1QX7lcs5z+dRe+eN1q5YS+dBKkeop1namqdzabPPe5BnzA==
X-Received: by 2002:a2e:bd0e:0:b0:267:fad4:7f72 with SMTP id n14-20020a2ebd0e000000b00267fad47f72mr3803067ljq.130.1662710077865;
        Fri, 09 Sep 2022 00:54:37 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v11-20020ac258eb000000b0048afd0c496fsm169951lfo.156.2022.09.09.00.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 00:54:37 -0700 (PDT)
Message-ID: <79fe437e-b67c-21e3-e748-83223b8d4c15@linaro.org>
Date:   Fri, 9 Sep 2022 09:54:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v6 1/2] ARM: dts: at91: Adding documentation for
 SAMA5D3-EDS
Content-Language: en-US
To:     Jerry.Ray@microchip.com, robh@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, Claudiu.Beznea@microchip.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220902192236.14862-1-jerry.ray@microchip.com>
 <20220908211048.GA3344136-robh@kernel.org>
 <MWHPR11MB16936F4F2FE278CAFAC6E7AFEF409@MWHPR11MB1693.namprd11.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <MWHPR11MB16936F4F2FE278CAFAC6E7AFEF409@MWHPR11MB1693.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2022 23:38, Jerry.Ray@microchip.com wrote:
>>> Adding the SAMA5D3-EDS board from Microchip into the atmel AT91 board 
>>> description yaml file.
>>>
>>> Signed-off-by: Jerry Ray <jerry.ray@microchip.com>
>>> ---
>>> v5->v6:
>>>  - No code change - patch prefix naming modified to match with others.
>>
>> You did 'git log --oneline Documentation/devicetree/bindings/arm/' for inspiration?
>>
>> 'ARM: dts' would be an arm32 .dts file which this is not.
>>
>> Rob
> 
> Yes.  I'm trying to get it into the right bucket, but I guess I'm clueless as to how things get broken down.
> I tried "dts: arm: at91:" but was asked to change it.  I can keep guessing, but would prefer if someone could
> help me understand and get it right.

git log --oneline -- Documentation/devicetree/bindings/arm/

Best regards,
Krzysztof
