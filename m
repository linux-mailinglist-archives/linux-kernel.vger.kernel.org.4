Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DF4651F4E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 11:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbiLTKyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 05:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbiLTKyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 05:54:43 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B74186DC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 02:54:41 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id bp15so17963474lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 02:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F0ytT4haaRKS+4+AS2PJdurU/Qf/a13nitxBHh9cBLs=;
        b=MNeWldNkH/aisAvBoQN+9XmJgLi2MKWpxH3caNhECyQj0gJSkhQFGD1rNToJTjEkSR
         T7CmCqhWY3s7XdfcV5jae5mO2/gP+ibsER5NeGEA6LD8atNXKwXKihH6tFshJcnnyAho
         JDJE0qs5JDLcO/V4sGY019Vin5czcbX+g12WgmxxQKWIXhhYFMxv4EWXVTU8l3eXsVUK
         QBreFv3j+bWt0Sv5juILb+U4fvhg6F71neqp8ipG34fdOtaqMJeyEEgZJaICMiUZoq7G
         GbrkwlqqS/9heFJivFgLt88Ie/d6e/+o9IbcifCBF/u7qbYs/hcx2cSIk/muMQGS2qBZ
         UW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F0ytT4haaRKS+4+AS2PJdurU/Qf/a13nitxBHh9cBLs=;
        b=fNARgPNE6bp7UXApFXQkdq0G47jZrOhHS5BXKn7ipcHUxNIMwBapPNnTjz8AFY705z
         Bu9dbKrNjmJPLmnvtePryEGOPvhzGvYPHv7sT++3ipO4d7pll548cPHNl06MQEPSV2Hf
         F+KaPh9Lzx6z8D45vzulWzzIp66r45dfED0EInQFa1jGkq31myXrDblNDFvQKq1PfoSe
         tm6f58RZfo+/ZR+wtEHh8FNWRiqef1b5lLTy5LhlRDeRsQC64PGCzOQYIHf13WT7eo9C
         EXCWx/tJiTD2LpY4ZkOAY6GArhtBMLYoDoKz+z77V/mP5utnIP++Xwz4/peGsZ9xGvc/
         dDKw==
X-Gm-Message-State: ANoB5pkYY/eUdmN7W7PoyanlzeNDlr24OxvULjT9uu6n6XUqIwF5jzkt
        6ZDLOvTGcwe/fdjJ9XI4CbVGMnUSpeSga4Dn
X-Google-Smtp-Source: AA0mqf6iPj+SI+zpVr4GGyQp8KSkc6m6aLEeHQgVs1O3HWcL0nKvcGb5wj1hWeZr8EK2QcmA9HAh/w==
X-Received: by 2002:a05:6512:2286:b0:4b5:5bcc:cbcd with SMTP id f6-20020a056512228600b004b55bcccbcdmr16970972lfu.0.1671533679932;
        Tue, 20 Dec 2022 02:54:39 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id r21-20020ac24d15000000b004b5853f0fc6sm1401292lfi.246.2022.12.20.02.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 02:54:39 -0800 (PST)
Message-ID: <b7dbf45f-8707-7e4c-63ec-c42a299803aa@linaro.org>
Date:   Tue, 20 Dec 2022 11:54:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: ep93xx: Add
 cirrus,ep9301-adc description
Content-Language: en-US
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        linux-iio@vger.kernel.org
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221219173618.1030415-1-alexander.sverdlin@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221219173618.1030415-1-alexander.sverdlin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/2022 18:36, Alexander Sverdlin wrote:
> Add device tree bindings for Cirrus Logic EP9301/EP9302 internal SoCs' ADC
> block.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> ---
> Changelog:
> v2: removed clock-names property, soc node and include as Krzysztof suggested
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

