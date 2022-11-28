Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E74C63B424
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 22:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbiK1VZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 16:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234529AbiK1VZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 16:25:24 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FABD1F2E8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 13:25:23 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id be13so19484625lfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 13:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BhkGzyayEhzFlH79fCSzFbDtX/mxwG1Or6+Fpd9F1RI=;
        b=bBJyzDvYiIYKtcktEuJznebPLt1oQDlI15ssrIcP9Oys3vCaKndpbTqYhQr6Zpkzpm
         g0OceVt9AAa8UThdcgnHylCGWtwYmJEZBiNm8RTn8N7AgDF5g15Z6VWPHceTV3BdDs6Z
         KUbIue9u4LUsnCV2aaHP9AHb6kT2fvpE5cQ30uRQ45oi2bOMmN6FncQ0fl2qtvAFDOLr
         O9k4g6aA6XOIT49ieNuwIDgOyp4RWri4JNZb4+AwP7O9Azkv+xgNRCXDgZe/n5zthapE
         04GD5WrlylKyyP2RlyIy2FIxyK/OoAVlKrMjzqZBgVmAlfNQWRYDVMp/ANiwIweb4cGr
         WJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BhkGzyayEhzFlH79fCSzFbDtX/mxwG1Or6+Fpd9F1RI=;
        b=vzCPKZRsZGbl4HM4/KE8qFj1MKzBC/zDHPfPE3wZetD7IDYoxqONjkgD5sHX6pYhzB
         R2gVZo2/pzppkyIRPtwO9oc29++Z03YrFzTZO56b9Byyipx+pw9lgTOoCUq/8FvWZYGH
         q+04CBZtbprgQAild2HM/0U9NZd+E+wwVLzBJWGBCLPCn/Wol0Fg4b4froyW0oN9hWp5
         Hxvvh5qWMksZcFrolyR2Ega8qosS9RJ+QQfHtei1MJr4rPKr7Y7oYP75nr59FBQsENGC
         9OXlM7LVSIWqyVi/yNZb18MOpuTKoR6B6SVrjoO7dhQ06e92kmapLi7eyd+navH6m8XX
         X8bA==
X-Gm-Message-State: ANoB5pnmoRc6xqVEYjhtNqtLc+aTOGMjphihTTpHx8TE+ILqxDdzEXKk
        hxGj00KQFMxuQUNX+4YzgnbUuQ==
X-Google-Smtp-Source: AA0mqf40GtMOgsCbBP3GTvZsXjlsIIfYGyiQP0e2U5nXCe06xry/jWgmfDJnnU23z6wPkf/m3B67Gg==
X-Received: by 2002:a05:6512:250f:b0:4b4:abb4:c34d with SMTP id be15-20020a056512250f00b004b4abb4c34dmr14913763lfb.218.1669670721912;
        Mon, 28 Nov 2022 13:25:21 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bp29-20020a056512159d00b0048aee825e2esm1878301lfb.282.2022.11.28.13.25.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 13:25:21 -0800 (PST)
Message-ID: <997ba29d-6fc3-529a-c069-3688d5a72bc8@linaro.org>
Date:   Mon, 28 Nov 2022 22:25:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: add TI LMP92064 controller
Content-Language: en-US
To:     =?UTF-8?Q?Leonard_G=c3=b6hrs?= <l.goehrs@pengutronix.de>,
        kernel@pengutronix.de, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221128133503.1355898-1-l.goehrs@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221128133503.1355898-1-l.goehrs@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2022 14:35, Leonard Göhrs wrote:
> Add binding documentation for the TI LMP92064 dual channel SPI ADC.
> 
> Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
> ---
> 



Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

