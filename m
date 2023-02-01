Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757A5686078
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 08:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjBAHTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 02:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjBAHTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 02:19:40 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C9D27D4C
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 23:19:38 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id q8so11920138wmo.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 23:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=raudraL3zAjAAmoNIOlfcGUuWKzInNWE+GXv3K4A1Wo=;
        b=m9se2slJYwQkxrv9qNzIutCcs0g1mnQWEBAIxZ1DvKc6ZSuBNDqfNZD2xZmD3Govuh
         LYBYhPi3ArKQl5KHFiRQtzLmw4nYKnG/HCGenL+QGpN4gyOEKl0t7FI1GtAhPGb+2KS5
         Km58jaFgYBMmZl1VCTDVROCLxzJBfeTxVVA32ptuptpS/7Sv65P8lkHa/4TN7U3CkqrR
         OljkP0UB06Kx9eLrQA3+TGKHs8eSRfFv7aPJ/PiLEOTh/b1i/Gxy5w+ouyXYzsixuXZ4
         uol97sFvIgr0GOrrGxOw3CgSkLSWMNouZRzEbuvGF23Oz8EnRTt8h4o0s8VJV6kczDut
         AbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=raudraL3zAjAAmoNIOlfcGUuWKzInNWE+GXv3K4A1Wo=;
        b=nxqKYsjxjaVgmEkNQ7ekqBJrFi2LKR7beEHDuw4RBJ+0yc8PlOdVsKN7PqJvYjXpol
         60TmGY5ubo3s8YF8qgcPvAmBUbf5oKhq3vVwCUXOd14qPTfAxf0n4WCKADtTK+K1Kele
         iklzHS9JFdkXcyqFrelKTUulNSt345Ygd2NiLRYc/O4a1p60ISsJhF/6w8hpv8uGwsCW
         inzEfXh6RDpqEXr6EK5unS+tcpXx0Foi3o/GVslT8r8+LK5F50Q49XE+u250MqkCCprd
         +IK/uTogeHwLLSfQxqGxDvcDRNV4UYvWCbzA4EGVCeFAU1DZ2TJVAWMITd3/Bw9q8RFA
         /QXQ==
X-Gm-Message-State: AO0yUKWm6iJh5nrxECPMQS0A27NpmBgvLLNqSQeB7xMuLav2ypZmqmAX
        jjtPiMgNwOaIhZ0Rkpb+in0yOgC2+SoIIen3
X-Google-Smtp-Source: AK7set/zj6tX2KJgI7hwRv5MVFG0m283U6CNWH1TBdX/5vF7J3XXXtOAyPRI5ejKGCHGilNLZPrZbw==
X-Received: by 2002:a05:600c:3c9a:b0:3dc:c5c:b94f with SMTP id bg26-20020a05600c3c9a00b003dc0c5cb94fmr596981wmb.39.1675235976640;
        Tue, 31 Jan 2023 23:19:36 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j33-20020a05600c1c2100b003db0ad636d1sm798556wms.28.2023.01.31.23.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 23:19:36 -0800 (PST)
Message-ID: <472e86b4-2f81-1bd9-13e1-30778d10c89f@linaro.org>
Date:   Wed, 1 Feb 2023 08:19:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 2/4] Bluetooth: hci_qca: Add support for QTI Bluetooth
 chip wcn6855
Content-Language: en-US
To:     Steev Klimaszewski <steev@kali.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Sven Peter <sven@svenpeter.dev>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Mark Pearson <markpearson@lenovo.com>
References: <a18751a0-f51b-0a3a-58ff-2062a9dc46fb@linaro.org>
 <20230201030538.56293-1-steev@kali.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230201030538.56293-1-steev@kali.org>
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

On 01/02/2023 04:05, Steev Klimaszewski wrote:
>> On 31/01/2023 05:38, Steev Klimaszewski wrote:
>>> Added regulators,GPIOs and changes required to power on/off wcn6855.
>>> Added support for firmware download for wcn6855.
>>>
>>> This is based on commit d8f97da1b92d ("Bluetooth: hci_qca: Add support for QTI Bluetooth chip wcn6750")
> 
>> Drop. If that commit is merged, how is it useful to keep it in git
>> history forever?
> 
> Sorry if that wasn't clear enough, what I meant to say here is that I used that
> commit id as the basis for my work, and it's not based on having access to the
> schematics or spec sheets.

Hm, I still don't find it useful then.

Best regards,
Krzysztof

