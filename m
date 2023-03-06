Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6936AB875
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 09:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjCFIgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 03:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCFIgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 03:36:50 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079AB6A64
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 00:36:49 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id ay14so31449842edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 00:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678091807;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=63HRbRwWzcpKqYalyNzeBO90DICoMp8EPtmeHo1nNuY=;
        b=WaZQilGe/8pjkfbsolKohbGGZCHAzFW0NDLxH38iZC5KLYtopd/AVagWOHWt7xvWkH
         An6mMmVAiZGPhMXiPLnYk1YH0QZ/yTgrvIG6Ypdq8fWv72JpQAuOeFv/4sbiS1No6a3I
         TeD/WKXRbuXW9ISZ6SUuZImwGTZ5yh28uyt6CJMOH4UfrXr6umejdporFQLBvM1N8IgC
         P7hoFqCIlbD4eFDnVZNMhR1edBH4jBoxKph97XQiS62D1LaKmrrpZ/xEYlQPzYDXt2rf
         mWumSK5kpXF/ZzlN/TAtQiVhwEOCmOyU/blz9N6i+EAxCwB5CjPqbfg2MGda5pVlfJN+
         Jmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678091807;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=63HRbRwWzcpKqYalyNzeBO90DICoMp8EPtmeHo1nNuY=;
        b=qqQnYeBwAMP3Lj8y7BqpniH8/CCXFGGymRdQM6mBKwbd172AOXp123ea/kPL9Oq6BF
         1jRyqoWrYzSuX6gYsVti4+wApighyC0ALeD0A/K3tyubpzzFr0oYQAq2UTUSSYBkD56y
         9fzzcGqZzK507NuLeW+jdqbYkfki+JDZaMMNxM19BwLWaiESyaNQncetfgQ4wuqb4Zt+
         /z0zVrUJIAVPtb+h+ZnEmvnm22L6cynTZcE7pGcia0ki2tBYwmo0+LY2r7+GiOjHbCYD
         pfGxctW90pQTm9UAbbtXV34UxgL5+I2Op17JvlhoQj3WCES4jIbYqIYhfC3UX/+JDuMR
         yBpQ==
X-Gm-Message-State: AO0yUKXszxToFfTNno1UOe65b4lOuj0reQXN280CdhcISamzTAfKQ4QE
        w4hGCfF0Jiyo7HOLfabu8GOhHQ==
X-Google-Smtp-Source: AK7set+Q7Wa9E1bhKgOjdiBS3UQloHFzRMv4/c3qDMvX199R0Hd+uHkJr0idtxLPWDEFJq8rz0mywg==
X-Received: by 2002:a05:6402:31fb:b0:4ac:c3c0:24d7 with SMTP id dy27-20020a05640231fb00b004acc3c024d7mr10352500edb.42.1678091807520;
        Mon, 06 Mar 2023 00:36:47 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:d85d:5a4b:9830:fcfe? ([2a02:810d:15c0:828:d85d:5a4b:9830:fcfe])
        by smtp.gmail.com with ESMTPSA id p24-20020a50cd98000000b004af6163f845sm4707551edi.28.2023.03.06.00.36.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 00:36:47 -0800 (PST)
Message-ID: <e82ca6f6-0870-f9b0-172f-bc6d54a9749b@linaro.org>
Date:   Mon, 6 Mar 2023 09:36:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v10 05/15] dt-bindings: soc: amd: amd,pensando-elbasr: Add
 AMD Pensando SoC System Controller
Content-Language: en-US
To:     Brad Larson <blarson@amd.com>, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        davidgow@google.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        ulf.hansson@linaro.org, vaishnav.a@ti.com, will@kernel.org,
        devicetree@vger.kernel.org
References: <20230306040739.51488-1-blarson@amd.com>
 <20230306040739.51488-6-blarson@amd.com>
 <52fb81e2-0d9b-600d-42af-1405fdd6509b@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <52fb81e2-0d9b-600d-42af-1405fdd6509b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2023 09:35, Krzysztof Kozlowski wrote:
> On 06/03/2023 05:07, Brad Larson wrote:
>> Support the AMD Pensando SoC Controller which is a SPI connected device
>> providing a miscellaneous set of essential board control/status registers.
>> This device is present in all Pensando SoC based designs.
>>
>> Signed-off-by: Brad Larson <blarson@amd.com>
>> ---
>>
>> v10 changes:
>> - Property renamed to amd,pensando-ctrl
>> - Driver is renamed and moved to soc/drivers/amd affecting binding
>> - Delete cs property, driver handles device node creation from parent num-cs
>>   fixing schema reg error in a different way
>>
>> v9 changes:
>> - Instead of four nodes, one per chip-select, a single
>>   node is used with reset-cells in the parent.
>> - No MFD API is used anymore in the driver so it made
>>   sense to move this to drivers/spi.
>> - This driver is common for all Pensando SoC based designs
>>   so changed the name to pensando-sr.c to not make it Elba
>>   SoC specific.
>> - Added property cs for the chip-select number which is used
>>   by the driver to create /dev/pensr0.<cs>
>>
>> ---
>>  .../bindings/soc/amd/amd,pensando-ctrl.yaml   | 60 +++++++++++++++++++
>>  1 file changed, 60 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/soc/amd/amd,pensando-ctrl.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/soc/amd/amd,pensando-ctrl.yaml b/Documentation/devicetree/bindings/soc/amd/amd,pensando-ctrl.yaml
>> new file mode 100644
>> index 000000000000..36694077b2e6
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/amd/amd,pensando-ctrl.yaml
> 
> Your subject suggests this is pensando-elbasr but you write everywhere
> pensando-ctrl. Confusing. Pick one.

Actually pensando-ctrl is for sure not correct, because it misses the
name of the SoC (you call it everywhere "elba").

Best regards,
Krzysztof

