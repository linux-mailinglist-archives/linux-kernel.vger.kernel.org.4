Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4D4621BA5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 19:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbiKHSO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 13:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbiKHSOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 13:14:19 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC97BB2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 10:14:18 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id d20so22307613ljc.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 10:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0GyWg1daeDccNXjrI+B0yVZa3Sl7JetIr7fZq5Z0LNk=;
        b=BPTRcNU4j8Rvd6wUs31/H0cTLzJJBDSYOtkL+C+8SKsMj2ygiznlGR/TSsjYXPzOLo
         uU5JI/DcOKyNJjNQQdB57KC222x10FwRHUaKv9q1I588zfUPBwOPa/QJR71IAsz8QqRk
         oVk3RbCKcED47wQNCh1n+A230d7D0A6XUhl6n3NhKI5OlmoTTC3Py/HycH3eIZgakerN
         +WNOoj+s4QbQEeqmrEW6bqR7N+teHQrg1Fl+WKoV2jTKlar4syXZUj5m0lGcG4/s/a+1
         qSheNkp68grHiD17H4FwTyAkg+VvPn1hsWTSWMt5dZSJ04ApIwIubia732A/qoyJaerM
         ZwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0GyWg1daeDccNXjrI+B0yVZa3Sl7JetIr7fZq5Z0LNk=;
        b=J89CE0LP3cv1niDBDRQc2PdzjPXNuN0er4BDzwGjo7SZhBC4nWPNKmYfQ2J+czgBVu
         ML7uH4ewPsF2J2VCY6KTVZR6h5Ocg12HauIUg91i6YaJBUxaDNlbSHT3R5pwX5a8+SWg
         L7SCJ3r5mRXRMid3VxoEo3LnuhmxqSMqGTrVGW70+JcyOO2FjHSIwFINc+ULnvsX1quK
         Vp/BrWV9f2WUggwOKXZrRMaOtHfrlw5DjW7wkMqKm+JhXfgHYsnWpH+RXINc37P2tXrT
         tfqYlkNGDDmCehFPI1u+uV3AszRVvDwYLP24CixzEf1Jlsrld62Ro4fAbONmW6iexQtt
         5RIQ==
X-Gm-Message-State: ACrzQf20GvBvwvQIKOjLILEX0Rwds9FnWaZP14fHAUvwwSASxXQ2+GtH
        PifLGKuCJx5TJedZdMjSFUHttA==
X-Google-Smtp-Source: AMsMyM4qTRlN1Qd13pnleiLmpWWmMxomV2Sl1DEUk4hPtuYobHVzMbcDTmCjuS46E+NmVSyIpQKrKg==
X-Received: by 2002:a2e:9589:0:b0:277:54ee:e8e1 with SMTP id w9-20020a2e9589000000b0027754eee8e1mr18438487ljh.352.1667931256828;
        Tue, 08 Nov 2022 10:14:16 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id f27-20020a19381b000000b0049ad315cfc3sm1872562lfa.162.2022.11.08.10.14.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 10:14:16 -0800 (PST)
Message-ID: <791837b0-4feb-a8cf-3d2e-ca78504a4786@linaro.org>
Date:   Tue, 8 Nov 2022 19:14:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] iio: imu: inv_icm42600: Add icm42631 documentation
Content-Language: en-US
To:     Jay Greco <grecojay@amazon.com>, linux-iio@vger.kernel.org
Cc:     jorcrous@amazon.com,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221107223351.61142-1-grecojay@amazon.com>
 <20221107223351.61142-3-grecojay@amazon.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221107223351.61142-3-grecojay@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2022 23:33, Jay Greco wrote:
> Update the required documentation for the icm42631.
> 
> Signed-off-by: Jay Greco <grecojay@amazon.com>

Use subject prefixes matching the subsystem (git log --oneline -- ...).

> ---
> 
>  .../devicetree/bindings/iio/imu/invensense,icm42600.yaml         | 1 +


Best regards,
Krzysztof

