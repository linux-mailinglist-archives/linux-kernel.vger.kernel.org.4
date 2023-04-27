Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A486F0A5F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 18:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243984AbjD0Q7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 12:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244168AbjD0Q7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:59:23 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2951019A7;
        Thu, 27 Apr 2023 09:59:20 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b87d23729so6894496b3a.0;
        Thu, 27 Apr 2023 09:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682614759; x=1685206759;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o8LOlQxTIdbQ+IzAHnUqOC/2u9FmJraQW0FTsQjxN60=;
        b=B/6GqE4OSMSWiH6xQlvCPJ4id3oEL5l5Eq+3umJ0wMdOHVJ/o2zAP5RbiEs3zeVl47
         dmbt7xWFKbshgRw+zYcPdXJnYPLwu4sXUe2QRaCrltwyWf0EIE36a62QzWmOadHOzzHg
         Gc0HQe5W0CUFKrzVsWEoFNz0lZbsJX3A2OXUEUXfwaZa59Yoe5x+bYpRmJhPIIOMwoVD
         ud3nz2SnTr9KPBmubLvEm+0S9kowc75AtVfAwlAkqIgBzaVlgwOb7jD2PwKyc2q75Ch4
         IjZUpZloAF+IYYb3t/xtNJVAZtM9hRuA+kWgMJH61UO+Wb2+gZ0fI3rKMquOVGMWd8WM
         nQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682614759; x=1685206759;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o8LOlQxTIdbQ+IzAHnUqOC/2u9FmJraQW0FTsQjxN60=;
        b=SH/IsNVAsJozaUHh6FB/LDfwzm7FX7UpHVfK5yLQ/AriayMKQ1w1G+XU0gweOIbupX
         f+ZgTcA/QCqcyy/Q7rVb3DZPjeyQxPdgmHkldjwdAyxPI5PpnMZZBWfF968zI1t3otVI
         ltLNXN64nDRRdRFIcFZNpzNWZjYHfvh3PqJ9/GTqZ5RoeC6PgJUj9zFWG05yJoWyX+o+
         xkVQfOVoIyFrnq0ilM8CobMwkCUZaRz246nNb1nfU2prFk+ibtbHZICK/5aXYtHWIGL0
         HNYNMQEtyd7ssUvQkiy6e2gzSrFxSWU1UbUOPpEP0nZiHwoyRd+B1m5ZUhN5tQ5NwFSI
         3PFg==
X-Gm-Message-State: AC+VfDxBbNdx0RHxdsxC7Z0Jtmujof5K4sdXlcgtb2Sja1MLBj/1acyc
        4QFwBBkQ3DJUpRNXh2YgiDs=
X-Google-Smtp-Source: ACHHUZ6cYSRKQQfS64osEWW+S4XU1WRg6LHtftlL5q6CGU8rN8kejqLNUzjT0cgzaal3hR6SSlUHHQ==
X-Received: by 2002:a05:6a20:72a2:b0:ee:d266:32bb with SMTP id o34-20020a056a2072a200b000eed26632bbmr3023702pzk.7.1682614759311;
        Thu, 27 Apr 2023 09:59:19 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id h11-20020a056a00218b00b0063b8ada8777sm13496813pfi.112.2023.04.27.09.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 09:59:18 -0700 (PDT)
Message-ID: <d2edbd36-df75-92be-e247-507c82124505@gmail.com>
Date:   Thu, 27 Apr 2023 09:59:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] dt-bindings: timer: brcm,kona-timer: convert to YAML
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ray Jui <rjui@broadcom.com>, devicetree@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        Scott Branden <sbranden@broadcom.com>
References: <20230426182854.GA9571@standask-GA-A55M-S2HP>
 <168261469911.3163242.999660035852888472.robh@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <168261469911.3163242.999660035852888472.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/23 09:58, Rob Herring wrote:
> 
> On Wed, 26 Apr 2023 20:28:54 +0200, Stanislav Jakubek wrote:
>> Convert Broadcom Kona family timer bindings to DT schema.
>>
>> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
>> ---
>>   .../bindings/timer/brcm,kona-timer.txt        | 25 ---------
>>   .../bindings/timer/brcm,kona-timer.yaml       | 55 +++++++++++++++++++
>>   2 files changed, 55 insertions(+), 25 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/timer/brcm,kona-timer.txt
>>   create mode 100644 Documentation/devicetree/bindings/timer/brcm,kona-timer.yaml
>>
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
Rob, do you want me to take this patch, or will you take it via the DT tree?
-- 
Florian

