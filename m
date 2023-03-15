Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550A76BAC9C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjCOJvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbjCOJur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:50:47 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFB481CD7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:49:50 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id h3so18776696lja.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678873788;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i8+OBFMHUqSZ5z1YaHCvkK/kxvR+7HJ17A1AzYgKFRQ=;
        b=uq9x0jumOYOVgQaT+BS8CFb2Zbt/rPcVSFl30E1PpihJxIT7JAqTr+6dmb/4GpwZQA
         9Tbwy4xZ56wf/IpS5TyQEjDfJYniIp88ri+YVhGvd+PPS21831TlBFj/t+yYp9VknmQr
         Lpl1XA5tzX7anr0szpik5JfuBbfbDleXfif4ksZ1tmbdpk1zjZa+c68HDNrTISupBs6z
         FnaOsxe5UQl4wKAB88la1BKKeaem6VV+Xq3/0AcIfvBVY2JP1kYE0vBA4Uob584gtQD5
         7+eGxjp6lk7BdakX7Orm27YWs0tA2J1tLzP4TwfJC/MkSZHhMUbhj6ENcrH9DAgGB+TU
         kghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678873788;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i8+OBFMHUqSZ5z1YaHCvkK/kxvR+7HJ17A1AzYgKFRQ=;
        b=6jS1oLo6HGePJfvKgfPJq8swttOeUQxnx02+U6ohtqt9z2AdqDMU/ixpN/LcsYRaAl
         L/GFrKhdsPxHmlaDrdJ5yLyPQ0RDAuKoRa9k4bvFlAKhl8amodGZVJMDf7kO4TQi5Nr7
         RBbU+Jjp+maePtsUdfFskrGUoBqKLV3nXJSeO+3qpHzZYUs9xzaMAAlD6FcIotLrvrG1
         Viom9O4NE2sESzQ70+vN+/UV6e9zfXmJLcZml6np/waHDI7PFtp4eyGXiDfPxJzDppEM
         sR/w+yfn4v96J9KjwP/OEiBJnXvm2z5c+fMDiu7dxWq344sTjgquYE09K8DtdG0kmLE+
         PGzA==
X-Gm-Message-State: AO0yUKWpBre5pZU/USderAHPMAwxpq00cQcCX3TfzcYt+un/KyPiXs/7
        4mq53lzSe/t8RxxMu7n8QB9CdQ==
X-Google-Smtp-Source: AK7set9YBZAkod0KIa27E7sPHHRoFxRok5uIBVImIJbZw9bS1TMrn/bu1HL00PJTcECy00Pfxdj0dg==
X-Received: by 2002:a2e:8e7a:0:b0:293:45dc:8b0f with SMTP id t26-20020a2e8e7a000000b0029345dc8b0fmr573112ljk.26.1678873788291;
        Wed, 15 Mar 2023 02:49:48 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id a1-20020a2e9801000000b00293534d9760sm782175ljj.127.2023.03.15.02.49.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 02:49:47 -0700 (PDT)
Message-ID: <933da956-27fa-f1ca-674f-af049d86e6fb@linaro.org>
Date:   Wed, 15 Mar 2023 10:49:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/6] QCM2290 compatibles
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230314-topic-2290_compats-v1-0-47e26c3c0365@linaro.org>
 <33ae98be-480e-8951-88d8-7624a695fcc9@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <33ae98be-480e-8951-88d8-7624a695fcc9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.03.2023 08:47, Krzysztof Kozlowski wrote:
> On 14/03/2023 13:52, Konrad Dybcio wrote:
>> Document a couple of compatibles for IPs found on the QCM2290 that don't
>> require any specific driver changes
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> I assume this is what you talked about that DTS will follow a bit later?
Yep, right after we resolve the RPM MSG RAM situation!

Konrad
> 
> Best regards,
> Krzysztof
> 
