Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC006AA948
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 12:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjCDLPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 06:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCDLPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 06:15:48 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EF01C7D1
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 03:15:47 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id a25so20306303edb.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 03:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677928546;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=riI8W1OeTdanG6DhLcOpMcEAV7nOWyx0CknvtQk5J5A=;
        b=mNEYt0ZBSD9Wxo3IkINZY3iH4zFidKlQUzT5GeqV5E3De2RLR6HD6C2+EyRfyzbiXv
         RqO9zYK2B5W2/a3G2uuzLRlKd0KZR65xXPSRo94HX5YS/Eo1/vp2Nc4lA+eaoIRXrl2m
         JbxzQTu/mDTqnNk+v6HlU8qXQDeC3rNQCb0Vg/Bh83kkdyJ1sChZS5S3MND5W9ySZmLw
         8H9SgAEvHZXuIEFDtgXU8L0Ylo9YuyXmmpbz839AoIHKyO5NvtzkS1uIM66NSMoEdok1
         nsqADHt+o4rRP526Ic/ASZwZM11XHgePGtDDv1bK/mF11bRfhGJMlnSkIaH3GfzIcxIR
         q3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677928546;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=riI8W1OeTdanG6DhLcOpMcEAV7nOWyx0CknvtQk5J5A=;
        b=HGVKpD42GbKBVISns0rxiTvNd9YrPfjPlmalqaIccOGb2nt4b3zBA509OicTzr3JE7
         VF6lxAS0S3gooe1m+IYpq5/NZ3iM88BZ0m3sbGucQ61+K7THO0No9FnJvf1qesNsG6Uq
         pj6flR/R25E0mawK2aqvcQr8GLKyY0KvyXkVuroUDlF6k50/3Xo9GoGjyih1tN74jEAO
         4obrVC6Cc2jwZLcVb2QSPCAEmt81xIsHwC411MAmte0bxLtveqlonT2J8s6b9wNiOVb2
         pfCEbx6Vz4BfteSE6MAkdMyKb3uFUBWTM27pKHtWkGGznj1Rbz1mAvGc/ZaHYAPyN03N
         Oeqw==
X-Gm-Message-State: AO0yUKXMUGgYFLmFd3phGr9fnU5fkVThPLjZWLVHaIGQz70D0RzsVBYG
        vtZs6l4Jfa0nfdrTLgtbQmDAHQ==
X-Google-Smtp-Source: AK7set8f87SwQanTdMZHKvUZpuyMEd19J3rFxEsNxx4MjXorqExKUzPiHhkn8y2uKTKzmH+vbvqiUQ==
X-Received: by 2002:a17:907:98e5:b0:8b3:e24:de0e with SMTP id ke5-20020a17090798e500b008b30e24de0emr5068705ejc.27.1677928546309;
        Sat, 04 Mar 2023 03:15:46 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:b758:6326:1292:e2aa? ([2a02:810d:15c0:828:b758:6326:1292:e2aa])
        by smtp.gmail.com with ESMTPSA id ss18-20020a170907039200b008d325e167f3sm1940199ejb.201.2023.03.04.03.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 03:15:45 -0800 (PST)
Message-ID: <bd314b74-6525-b790-bcc3-849c3c8bef09@linaro.org>
Date:   Sat, 4 Mar 2023 12:15:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: amlogic: Document the boards with
 the BPI-CM4 connected
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
References: <20230303-topic-amlogic-upstream-bpi-cm4-v1-0-5a23a1ade6bd@linaro.org>
 <20230303-topic-amlogic-upstream-bpi-cm4-v1-1-5a23a1ade6bd@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230303-topic-amlogic-upstream-bpi-cm4-v1-1-5a23a1ade6bd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2023 18:37, Neil Armstrong wrote:
> The BPI-CM4 module with an Amlogic A311D SoC is a module compatible
> with the Raspberry Pi CM4 specifications.
> 
> Document the boards using this module, by specifying the BananaPi CM4
> compatible in addition to the baseboard compatible.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

