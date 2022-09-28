Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2755ED706
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbiI1IBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbiI1IBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:01:40 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A931133CB4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:01:36 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id k10so19191658lfm.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=/tJFSKHI3KE+2w8Mp5fH7AqdtUfhsF9MOlEfNhHwM7I=;
        b=sZNK31UuiHEMJfT8TgQ1DF3bkj2FDYT+XYHsuJ5D7t/0VNkyDCF4GMpRWhZZf4/wGo
         ZD2kE+L5ISVXseZzlL7xBjh0tWnXSqTV8tYwhOPhEDO3pIvXIjQ7F53Sh6+QCL8aFJno
         YRswSUWfxeP/80mumiLIqa4GXxA5Y/MyQ+hZ7IEO7qFhyopNrKkTWgr9FW9Yt9yCZT9o
         LCbWTfmzYwJ7wXIzDNdSK9EaMHYqPGIT1dQDrHnCyn6xviu8HM1o+mSIJs4EgVR+iqfw
         819Y9ZTIB2LSwCHSFCAmyGaiDYHeXx0jLZSezFb/fb49/2EPqLU/dhoa3E8ozPCtgoio
         CVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/tJFSKHI3KE+2w8Mp5fH7AqdtUfhsF9MOlEfNhHwM7I=;
        b=qibSsaMlwyzckHHr/aZK/PK9AO9kGCBEHb7bCZ/vgxke0L/Mh1ODkXJVThB+IkWsFq
         2Napc6qOtqfOwNwALrGxKNIpK7MnK6O6lQ8N1fxVC3c+37BqS4fxLM74UbOch23ofsB4
         ETyvIqzm9H/pmY9GXDza3juuYVmWcmAgkECDPtEGp5p8qohn0Rlo0SPfSfUloFT0z1Tg
         bzxaLYGxhdkidgEDbMbeAr5kWR8GMWkvfvH+30zYK/RTcGCChFwL2szqxTdVszYzjgvB
         OK/4HNIoXwElZXsRDTEy/HdE0bhxABW9E6Sbaq9Kd2OUTkVXGg9jR8oJ+EftfXrZ2qne
         LgWA==
X-Gm-Message-State: ACrzQf0+dceJYmt2j6eButblB/cUFEVEJ/R2X7Wp0KXILWtzd1dgTRF6
        /xkU2YOI0Xx4DkttGe/EepHkoQ==
X-Google-Smtp-Source: AMsMyM5+OHfsYNiw9519Tq7XbP5R9nzBpq18Ms24ne3Ny6o05PjkBLEQZWX4oKBVghzP7qhGQV+ADA==
X-Received: by 2002:a05:6512:10c8:b0:49c:14c5:e081 with SMTP id k8-20020a05651210c800b0049c14c5e081mr13054391lfg.615.1664352094458;
        Wed, 28 Sep 2022 01:01:34 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id cf32-20020a056512282000b0048a934168c0sm403159lfb.35.2022.09.28.01.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 01:01:33 -0700 (PDT)
Message-ID: <1b2d1e4f-6b95-cf20-8c2d-f87a91ae599c@linaro.org>
Date:   Wed, 28 Sep 2022 10:01:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4 2/3] dt-bindings: thermal: add loongson2k thermal
 binding
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     zhanghongchen <zhanghongchen@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>
References: <20220928031628.6463-1-zhuyinbo@loongson.cn>
 <20220928031628.6463-2-zhuyinbo@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220928031628.6463-2-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 05:16, Yinbo Zhu wrote:
> Add the loongson2k thermal binding with DT schema format using
> json-schema.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>

Thank you for your patch. There is something to discuss/improve.

> +$id: http://devicetree.org/schemas/thermal/loongson,ls2k-thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Thermal sensors on loongson2k SoCs
> +
> +maintainers:
> +  - zhanghongchen <zhanghongchen@loongson.cn>
> +  - Yinbo Zhu <zhuyinbo@loongson.cn>
> +
> +properties:
> +  compatible:
> +    const: loongson,ls2k-thermal
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#thermal-sensor-cells":

Use same quotes in all places - either ' or "

> +    const: 1> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - '#thermal-sensor-cells'

With quotes fixed:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

