Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3655863613B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236548AbiKWOMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238091AbiKWOMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:12:36 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CA1CE6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:12:28 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id s8so28320072lfc.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YpScT/PLZhW9m/mc8mS4KdOL1HgAD8oZWMFJX7jIr5M=;
        b=dVw7XBd3kFmPkaiQVhTxkTxRTXfXPM2I5cBO1BHdipcu1xZUATDW3nqvCXHSJHNjkG
         Saq4PQcGqWeTRcsEBw+SoTuEWDyarGTLZS7tyefqZMUT4tfAG9qNjBQPdJBzFFJY4zde
         cq8lLYQqft+3Pp6JhU7YBgBAml7uUKP+8lhWRS2CHTvlFdzTn9QKPaEYPncuHSTY+0Ac
         caMiN5HuJTr7cdk2bBZ+dfO+1kewrN6lfF/PGFTWzkY4N0mMTvZVvDnotGyjVaZ+DeUz
         7jVx5CyB8Iq+8PCQgVa0WFVeihPaEtKsmTU7HmeJ02eGcdn3/yvIDo5oy20WEkfdX0LD
         lVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YpScT/PLZhW9m/mc8mS4KdOL1HgAD8oZWMFJX7jIr5M=;
        b=VnhKZYCYInvNLucJKfDdF5faJw433eL4+oe7vZSGe8OgtUfOjn/Nx4YijhbIy4oVR+
         ltGaXFuCXwRimSYuk9D3Ap3XT11hUBWJMQchViC47zGsHsITPN9hgs9XMo+lyIxZLWWS
         LhLFmZmZEvNJAHVKyaS/d51vd2WDFh3IuA3tLv+QACicLoJ/NF0KOJ7w3rs+HxpYnY0S
         sTJdcr7RNV9e85tH/E314IduvZcgeNJcT/o0X15HiW9QsFDQ1ZeDV/HhmfSzyWCuuvLl
         38VcU/S/7pj85ya6cCkczK5F+wyw5IZFfz9YxaJ+jRHrzV/78ca10+1zkKRqy8hrNHpd
         Ml5A==
X-Gm-Message-State: ANoB5pkeK094UYsWoXbLOv78S06VKy4fLb50lmDRsYtsuqzksl82Blu5
        EiKYkskScsSeQ0942uDJUWYkTw==
X-Google-Smtp-Source: AA0mqf65irOcr+aB/hyQQfJeHM7Hq1+nPrF12N6FMB1oep9oKnjE/+MQX7mNMHiHEpGS4c3FQkZxMg==
X-Received: by 2002:ac2:4209:0:b0:499:f8e4:6dd0 with SMTP id y9-20020ac24209000000b00499f8e46dd0mr9925093lfh.162.1669212746994;
        Wed, 23 Nov 2022 06:12:26 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s29-20020a19771d000000b004afeacffb84sm2899160lfc.98.2022.11.23.06.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 06:12:26 -0800 (PST)
Message-ID: <663d8e29-b47f-8135-8b4e-c95b68559367@linaro.org>
Date:   Wed, 23 Nov 2022 15:12:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V5 4/4] arm64: dts: meson: add S4 Soc Peripheral clock
 controller in DT
Content-Language: en-US
To:     Yu Tu <yu.tu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     kelvin.zhang@amlogic.com
References: <20221123021346.18136-1-yu.tu@amlogic.com>
 <20221123021346.18136-5-yu.tu@amlogic.com>
 <ae43fadf-9255-7db7-8b5e-01200e02a2c6@linaro.org>
 <9858039f-e635-2749-80a2-75072d6e9cea@amlogic.com>
 <8dbb3ce2-c8d9-70be-d1de-ed875de0ea1b@linaro.org>
 <3bdaa648-c607-a79c-f6bb-c75baa1e8509@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3bdaa648-c607-a79c-f6bb-c75baa1e8509@amlogic.com>
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

On 23/11/2022 14:23, Yu Tu wrote:
>>> ../patch_clk_v5_1122/0004-arm64-dts-meson-add-S4-Soc-Peripheral-clock-controll.patch
>>> has no obvious style problems and is ready for submission.
>>>
>>
>> This is a checkpatch output. I am talking about DTS broken. dtc should
>> warn you.
> 
> Do you mean I will have wraning in compiling?
> I actually compiled without warning.
> ccf$ make ARCH=arm64 dtbs -j12
>    DTC     arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dtb
> 

Nope:

../arch/arm64/boot/dts/amlogic/meson-s4.dtsi:105.35-127.6: Warning
(unit_address_vs_reg): /soc/apb4@fe000000/clock-controller: node has a
reg or ranges property, but no unit name

Test your patches better before using reviewers time for trivial
compile-time fixes. The same rules for C code apply for DTS.

Best regards,
Krzysztof

