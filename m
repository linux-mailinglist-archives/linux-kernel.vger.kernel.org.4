Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3181A69F081
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 09:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjBVIkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 03:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjBVIkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 03:40:15 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD8F3344F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 00:40:12 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id eg37so23396391edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 00:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lR+ISQQSb0vmBiGpqXlpCKGu34UyCzsJKioNfm+3xdA=;
        b=KIr+5u8tc47eHv6DkkJqDeie1JQk4hY22L8yH26fDT81Zx+yYccFRNvZfGErS/JwgE
         CkFTu4B3dTBom6tlDAwOKATkapR/iOJYg+iJK4VHTkXHpOfJVFgSH5DXftj8ZU/agotq
         35qCt4kfM1oA7fUFnXluAKK8qz9YXpPBBmC4oqmjx1kpKurIgc2q5bHCEJIImZa6Vl29
         LDxG5C/+Io3PGuebh/xBRhqYtOJ5AbzvYMLWtPKn6Hw37AKvuI/w/050rIMCDvSIGFdj
         TY7LrQmsvqagR/tB59EO3jMP3aZyI9yO1hgVgCjWYZlMnCRN+9T20pPlUrxmfQvsNtSi
         IBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lR+ISQQSb0vmBiGpqXlpCKGu34UyCzsJKioNfm+3xdA=;
        b=JhV8e+NtgCM93diaTNj8uth3HZLi7Hf3/nmZDPY3fw7dqTcqwqXO4mRfw2VkkhjkXF
         ot1BSOwZANH4r3MHpj84SNWDOoSQiSFzuIJyUCB0MZg/9oJQGY+ob1p0KjuJyl4oWPel
         arpOR9AarllC5bd3nm6kthDVgDU/ntGe0TqlJzTHSeFSXN+9oEi8GwBPtizGtxKO3t6/
         0f4CJxBu518aEZ7dW4JgwXBz+aAkDro+MffpR6Z0Jj86tCarruRj2JlN84+h1L+w3g9d
         9P16uzEsTPSYbzFAfqzhwmlRZIZH32I979n/RY733ZNk0aeH7umP1q7SV5heTHiPUKp/
         KaYg==
X-Gm-Message-State: AO0yUKXYfwXnF3//8c72EAwNZmTT+drQxTo4Ts039aAvYjw61FGGPU51
        k2WDebaIXHSLInZ1NbS7GicBJg==
X-Google-Smtp-Source: AK7set8iXoGezZDOE3ZDJrGYpXVqhY+danP4XJR6egsj0cAxZ2DnpxbBKjpo8ym6+Oa7myY+JjJauQ==
X-Received: by 2002:a17:907:3e22:b0:8e3:8543:8e71 with SMTP id hp34-20020a1709073e2200b008e385438e71mr5006300ejc.40.1677055211264;
        Wed, 22 Feb 2023 00:40:11 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id 6-20020a170906318600b008e03af7e7c9sm1708450ejy.188.2023.02.22.00.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 00:40:10 -0800 (PST)
Message-ID: <939ffe2e-9b03-528a-3d27-e9eac7a04ded@linaro.org>
Date:   Wed, 22 Feb 2023 09:40:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 1/4] dt-bindings: mfd: Add DT bindings for TI TPS6594
 PMIC
Content-Language: en-US
To:     Julien Panis <jpanis@baylibre.com>, lee@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        corbet@lwn.net
Cc:     hdegoede@redhat.com, eric.auger@redhat.com, jgg@ziepe.ca,
        razor@blackwall.org, suma.hegde@amd.com,
        stephen@networkplumber.org, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, eblanc@baylibre.com,
        jneanne@baylibre.com
References: <20230216114410.183489-1-jpanis@baylibre.com>
 <20230216114410.183489-2-jpanis@baylibre.com>
 <c50503f0-dce1-a3b0-2973-8a22b5ef8bc2@linaro.org>
 <4e64838c-b727-923b-b6d5-413a0681977c@baylibre.com>
 <8de5a3bb-a0b1-8d69-cf61-0c33f42c56f6@linaro.org>
 <85183c04-40e3-fd97-c4ca-06795fe99e40@baylibre.com>
 <ce5f8e9c-0e05-3391-1393-25ea8086f10c@linaro.org>
 <633753f7-2b8a-15bb-ba55-1c5a6f2eb3f1@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <633753f7-2b8a-15bb-ba55-1c5a6f2eb3f1@baylibre.com>
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

On 21/02/2023 16:18, Julien Panis wrote:
>>>> It looks the property should be only in the drivers, not in the DT.
>>> I will remove 'ti,use-crc;' property from the DT. This will be only in
>>> the driver.
>>> Do you also consider that a property such as 'ti,is-secondary-pmic;'
>>> would not be acceptable either ? From driver point of view, this
>>> primary/secondary role on SPMI bus is a 'built-in' property of the
>>> PMIC (CRC must be enabled only via primary PMIC but using the
>>> primary PMIC does not imply that CRC is necessarily used).
>> Depends, I am not sure. Are the PMICs in some kind of hierarchical
>> topology? Like one is parent of another? If not (so both are
>> parallel/equal children of SPMI bus), then some property to indicate
>> which one is the main PMIC makes sense.
> 
> There is no hierarchical topology.
> So, I will consider identifying in DT which one is the main PMIC.

Yes. Such property would be also better than the "use-crc" as it
describes the hardware, not desired Linux driver behavior.


Best regards,
Krzysztof

