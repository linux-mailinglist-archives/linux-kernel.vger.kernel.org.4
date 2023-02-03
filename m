Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD0D68A0EA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 18:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbjBCRyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 12:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbjBCRyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 12:54:07 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045E339CD5
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 09:54:06 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id r27so1538514wrr.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 09:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=64/VDuUQiW+Vf3xea9SdqjgxeztAbXQzDh6Wov0b1Zo=;
        b=MiESMRJeHTeosOgc+Zit64s/0KsfzCYox3nX5HMgTerJ3Vj2/PxImwLUOXO63HifSb
         hY3i9w0/7z8R6dgpA4+G7ra2D/4T4R78aOAEX/uO0O9sPEZqswM1GQsn9jdSA+vE2RXq
         Re+XeIT491Pu8UBDPZszcyWJLScsV2l69Q7Hta+LEWvBODzDgT6M4obDhmUmzoK4cHp4
         hCbkorq1HjQGsO+CmZgZPWrv91+Q0qXQx9Uq99XYoaBpsk0OSiRe5DuOrLTrARIbX/Rw
         3I7fkc9QTVWdKznZz3utw7nPd+CMewiTKbBBUMcrD0PmrVFJtviCGdEKWZTt4IgL3bAu
         OhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=64/VDuUQiW+Vf3xea9SdqjgxeztAbXQzDh6Wov0b1Zo=;
        b=JGxjauxFeLrSBmUDIyVAlaG7izu8JlxDiXLJ1ZOqVANoRmHFhk0S+0rHPs+AgXBYeT
         5Zak8mORtwAf1sY/1SyeDC+fy/zvChLGGC6rvh2EtBzzm9X0qtvyMUHzhiZQL3q6WWKr
         GKrc0q22I5Zc7lUTa489D7f76FFXu1GwbTC0IdOERCEiDchBtBDO7iU2BycrKw7MYucR
         ZvgaSba+yOIqMV3Q/f+aWgl4cCVNeXP09LnvOzA9ZK9RMyLFKt3z7lLUghEisuNNHKyM
         zDNkV+xSOZJP8aKr6FdU6SlIPPCbTHDyajVI22KKGs7BoMSH+aHoc9VVM7q4voNCI9j7
         5Z5Q==
X-Gm-Message-State: AO0yUKVs1JrQ3Hh0JLCsK82LAK+NlrzkP1OVeXJG5y5ucgONR7Obso8b
        c5SHh+su0HowLWsV3flTmIjm9w==
X-Google-Smtp-Source: AK7set8C1hagDBeGxpuByAoF/bYki9T5Zrg5yh+v7Y7uNnn+YhIqnqw3/BynIyQMxVUgLdzFTAdj5A==
X-Received: by 2002:a5d:5c09:0:b0:2be:5c4a:de6b with SMTP id cc9-20020a5d5c09000000b002be5c4ade6bmr10102366wrb.3.1675446844584;
        Fri, 03 Feb 2023 09:54:04 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f17-20020a5d4dd1000000b002bfad438811sm2480187wru.74.2023.02.03.09.54.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 09:54:04 -0800 (PST)
Message-ID: <3b81bd45-766b-fe26-d9ec-2097e1fe5a0b@linaro.org>
Date:   Fri, 3 Feb 2023 18:54:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 1/2] dt-bindings: leds-lp55xx: add ti,charge-pump-mode
Content-Language: en-US
To:     Maarten Zanders <maarten.zanders@mind.be>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230202101032.26737-1-maarten.zanders@mind.be>
 <20230202101032.26737-2-maarten.zanders@mind.be>
 <28cf0c1f-ee5f-79e4-609a-2cdd24db9f1c@linaro.org>
 <1452beba-19b0-7417-716e-a255c6aaa739@mind.be>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1452beba-19b0-7417-716e-a255c6aaa739@mind.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2023 16:38, Maarten Zanders wrote:
> 
> On 2/2/23 21:13, Krzysztof Kozlowski wrote:
>> + ti,charge-pump-mode:
>>> +    description:
>>> +      Set the operating mode of the internal charge pump as defined in
>>> +      <dt-bindings/leds/leds-lp55xx.h>. Defaults to auto.
>>> +    $ref: /schemas/types.yaml#/definitions/uint8
>> This should be then uint32
> 
> Why is that? I specifically chose uint8 because other settings for LED 
> are also uint8. The implementation is also uint8. I surely hope we'll 
> never get to >256 modes for a charge pump.

Because all IDs are unsigned int.

Best regards,
Krzysztof

