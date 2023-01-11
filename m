Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4DD665D14
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbjAKNxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238792AbjAKNxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:53:17 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934922AC5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:52:56 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id az7so15090922wrb.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sbnCP+ufAhmrYYqJ2oavTnwAk2TMmTuAwDsYylfghJc=;
        b=GgxMAHoFjbR5is4gm57AvvDPVTMJMxfaquYLJCG5Od5GPpv/iCB0ZIkAFo/Izkzhfz
         byxVVvkbw/9YZ422FFI7pbCH/W9Z78PDlvGcb342TUjXrcUy5A+YY4UAxhoD3b/bRrjs
         kbN0xPIzDetf7fNXIZGOgbKWjV+1tVfFEQc8aILH8NgxF9fCXwvlcNRzMbRYATKgnxYX
         fLU6UFs2CWYnS5LtX0KyhmSKSxXZ+53Urqj8WFcRScO1BbrPggc798Zm1dCjHKrFnFhI
         zTm2r31TEs3ga9tDK3B1C0P6NK3XlJ73/nkyMx00zUAX8o+5LadnlthWH85miAcOWO61
         ooRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sbnCP+ufAhmrYYqJ2oavTnwAk2TMmTuAwDsYylfghJc=;
        b=bEDqvTWoOC3o2a+oR2Ur6fGoALEHlQYPO/SSo3W7JonQ8K91X43IpIJBMFqX4isflg
         WZBfG5mg3KHHtBk2go3GVvEoRlURGRbS6EKPR55LPxmxhaJWsF25CKXGqywachCGF5Lg
         nwagNCkiH6SHr4upb3f+7XlMZD8fzLk4h9WUqD0MwkMd0SqPTYD0Rucef3+cJjNsDlk0
         Aq++kSiATFfFde2+bl/+A/ARCwloCwjoNcPBOnwyVyZL+sVSDpyQtNsqllwkMt9kUyoQ
         +AyReYiyPO86jAyCC1TXn/NaTAVr7D7xLmK9QzbXzk3cif164sJyIDYRjfDymBDhAcRR
         Yuyg==
X-Gm-Message-State: AFqh2krlSzXGDqdLUJK9cBlx81Gz/q38y8lb0QVATJXhTNb+Mm3zXOpS
        17klYKUOlhEmbA0KYtsmFWiCiQ==
X-Google-Smtp-Source: AMrXdXte2o2k6td9/a4v4BCFUbyJiICVxWmJWqLkERIA5CBCMCysgQeeJ2giSqAqXFAw0U1OcDZeWA==
X-Received: by 2002:a5d:61cd:0:b0:276:d6ba:4b91 with SMTP id q13-20020a5d61cd000000b00276d6ba4b91mr39805222wrv.47.1673445175184;
        Wed, 11 Jan 2023 05:52:55 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id g2-20020a5d4882000000b00286ad197346sm13946571wrq.70.2023.01.11.05.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 05:52:54 -0800 (PST)
Message-ID: <936ef253-c98b-8cc7-32b2-69a44f964569@linaro.org>
Date:   Wed, 11 Jan 2023 14:52:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] arm64: dts: meson-gxl: jethub-j80: Fix WiFi MAC unit
 address
Content-Language: en-US
To:     Vyacheslav <adeep@lexina.in>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, neil.armstrong@linaro.org,
        jbrunet@baylibre.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
References: <20230110215926.1296650-1-martin.blumenstingl@googlemail.com>
 <39ed8a13-8b27-80d4-99b8-5693ce6d3f58@linaro.org>
 <479859f7-580c-28c7-d085-b65d2443e4cf@lexina.in>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <479859f7-580c-28c7-d085-b65d2443e4cf@lexina.in>
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

On 11/01/2023 14:20, Vyacheslav wrote:
> Hi.
> 
> arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> 
> line 236 has eth_mac: eth_mac@34
> 
>   * Should that be fixed too?

In general all incorrect namings should be fixed, but I proposed to
combined it here since this was touching this line anyway. Change of
case in address is same as other style cleanups (like underscores), so
just do it once.

Best regards,
Krzysztof

