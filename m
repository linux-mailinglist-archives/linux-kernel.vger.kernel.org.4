Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A697A60FC94
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 18:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbiJ0QAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 12:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbiJ0QAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 12:00:17 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36F53E77B;
        Thu, 27 Oct 2022 09:00:16 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id n12so5882906eja.11;
        Thu, 27 Oct 2022 09:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Q+FhdFfWXCodxANna05rQkLf68c4F7yR8oJG26j/8I=;
        b=PGhAtJg71umuNe9hEDkN5++IWfnmk90PX9PuHKnYfJDitaKwi+XWXt1BYwOnouqeQe
         MLjN8Vaze98KOrxnWYSiJCJBepFyDI3fdtZ+udiIzikucdrQ5qUmUu0o7qE1YIG+ndAn
         7p1F0m8d75SnJfpHtJwSjaHlbMJSEcqZq3Hhy9uKGT11fp8FzH8NL+WMxSQutGN0thUy
         eY5S8irzdDq21hifbgPF1r7UjvYaMTuUnFG3WKaYIagd1WTNJ7OGdIh8ni/st2UEaIS6
         2RWfUfOcB5/PyK4rEbHde9A5llS2KvSzpUAuU2KaJ93pcveQm+7BbNIFpkn/L2OyPojI
         sVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Q+FhdFfWXCodxANna05rQkLf68c4F7yR8oJG26j/8I=;
        b=vOUDy3L8Nb2z9eSUVvJ6w7czWtPqc/4y3CUorkMw5QE2UnUjs3moVFSxAzXb1POdIk
         ywYJyVgarLU8syxyySxjftw5K52JnYl7LpBfoLpAaq4UMGJGDkuyfW58kEuPqipioU7p
         bWlUXYR0Ps4bdeY4pjzrqDD7xAI2BsLczVDcrQVHxkveCConxxoDRW5eKSAD/0GhORI3
         xyeIyzODXAW7SaLGYz3OenoHIP8NYbhHUmkRDzuLl7TcfLzkcTR8D/m8cEEje/U4C0Bu
         KJusenxOEeU5zv8NHCIK/kSSgA6lq7GshkJyAPb0AJtMeg8CJzK3e6Zo6gWZRLjge4z5
         KjGA==
X-Gm-Message-State: ACrzQf3QSorDi+mxP3I6M8q6MvnMAjycugUXTJ9qtV5BhAR/bC63GZBo
        FhZDYMl6LSOZyg3YlLng4pDsjAgMD5E=
X-Google-Smtp-Source: AMsMyM4ha8qSxDMf4y7djfvLJtt8clxvlapNvWVxOlVc0diAa5i9x+gJDUkbUa+ez2Mup3R/WhFL3w==
X-Received: by 2002:a05:6402:5483:b0:45c:1336:6d9b with SMTP id fg3-20020a056402548300b0045c13366d9bmr46426634edb.100.1666886404555;
        Thu, 27 Oct 2022 09:00:04 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id f1-20020a05640214c100b004623028c594sm1214536edx.49.2022.10.27.09.00.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 09:00:04 -0700 (PDT)
Message-ID: <f5e8193b-8671-6b9d-2290-cea1962848c4@gmail.com>
Date:   Thu, 27 Oct 2022 18:00:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1 1/3] dt-bindings: rtc: convert haoyu,hym8563.txt to
 yaml
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        heiko@sntech.de
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <f7127f87-05fd-5e20-eb2d-a3fd04674229@gmail.com>
 <2a09aec9-96c3-0ea9-a2b5-4a04c9982bb5@linaro.org>
Content-Language: en-US
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <2a09aec9-96c3-0ea9-a2b5-4a04c9982bb5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/27/22 17:00, Krzysztof Kozlowski wrote:
> On 26/10/2022 18:58, Johan Jonker wrote:
>> Convert haoyu,hym8563.txt to yaml.
>>
>> Changed:
>>   Add clock-frequency property
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> ---
>>  .../devicetree/bindings/rtc/haoyu,hym8563.txt | 30 ----------
>>  .../bindings/rtc/haoyu,hym8563.yaml           | 60 +++++++++++++++++++
> 

> https://lore.kernel.org/all/20221024165549.74574-7-sebastian.reichel@collabora.com/

Ooops, didn't see that one...
Needed it for the rk3128-evb board to pass without notifications.

Johan

> 
> Best regards,
> Krzysztof
> 
