Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643E35E8A11
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 10:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbiIXITw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 04:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbiIXITM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 04:19:12 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E4926488
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 01:17:53 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bu25so1650922lfb.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 01:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=G0Cd545zoyt2uV3cv+LL+pRrlOK+J3gIEO+qMm/Z++s=;
        b=kC3bdn2phshxXtaQAHXy/lPnY0H/Yvuxby1fDz8gJPQ7l8f9eDAqi8HbCugk5MZTEV
         l54P9OIlhxg6X3ESDdCco0jkryOB8b1fZIhXIu36QfU3ZbfrEyRQtlkH9O+TDRF0ppoh
         HpEKjvt71CSbhz7D75hJBUadpusqhbmIHLwPQt42an73vPZH2QqW2z8Qim8/V06YezvW
         Q1eMs+miDpJMp1o0ylAVjq5j7Mz5kAg4IBqxBdjRG0PkqGtOOUUqS/OZ3MgHiuG97GIQ
         ckaqaVysh95jmtToDu4fB/Fjd4Fi6Q9wdEbPb+vfkXnAnZg+NOgZJ3CoDK1Vx3pDLV7a
         A3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=G0Cd545zoyt2uV3cv+LL+pRrlOK+J3gIEO+qMm/Z++s=;
        b=5SBV8LA7ASw+3dp6fXyv4hz7L0QLlR+NUA+K79F8g+56XHNR9CaVnyxoqKbcvuu/7V
         Kyqt5/aQPYsVWqiyx/MA4DHQ9K1aJWt1gFSGP1NoQvEZ6ffs8feuuL1EPHt3R5oh53Um
         q2XzXuwHbiEb3QXf+Qr88KF5NCEsPjNT5TRr4UZWsjh7I/l89gw391rImzd8jlFOaMrD
         Y600JrTUAcm6nrvFRSxnPuHWysE3bE1LzEcgMS9L5vj342JF4eOQWo01VZ/uQ0DnFi9x
         zvSYaDfMqva74SBiqQkM1el/nm/J4jWl1PAmX0qazeHe9Ee7ThiMTHI7I1/zjPFXTPRd
         kxiQ==
X-Gm-Message-State: ACrzQf19ItIk4dSwJzd0KKK+1EfLpUrZi4Y6/AIpulqKy59NdEOApTZb
        r+T1cxTCqpk95UEiC5u69L3rYA==
X-Google-Smtp-Source: AMsMyM4tghzIdOGBXILS6lHyrC72YsMTH8jxcA/ciXOtxo6om0KnDPDYhNJomsfKbkxtSdhZBEMzIQ==
X-Received: by 2002:ac2:44ca:0:b0:499:b6ff:bc75 with SMTP id d10-20020ac244ca000000b00499b6ffbc75mr5124114lfm.233.1664007471670;
        Sat, 24 Sep 2022 01:17:51 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id s9-20020a056512202900b00494b2d8030fsm1813343lfs.177.2022.09.24.01.17.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Sep 2022 01:17:51 -0700 (PDT)
Message-ID: <fcc5bc9f-6b6b-b9ca-45aa-ff2c880a4774@linaro.org>
Date:   Sat, 24 Sep 2022 10:17:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] dt-bindings: firmware: document Qualcomm SM6375 SCM
Content-Language: en-US
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220921001020.55307-1-konrad.dybcio@somainline.org>
 <95fb2bfb-6eb8-012d-88f8-c739d229ef70@linaro.org>
 <8faecd72-0cfd-18eb-d07a-53b3a23ed05a@somainline.org>
 <20220924000932.GA1450@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220924000932.GA1450@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/2022 02:09, Guru Das Srinagesh wrote:
> On Sep 21 2022 20:43, Konrad Dybcio wrote:
>> Does it? I did not define this compatible in the driver, so it does
>> not consume any clocks.
> 
> The bindings should describe only those compatibles that the driver supports -
> that is, both the driver and its bindings should be in sync.

That's not entirely true. Bindings describe the hardware in the most
complete way we can. Not the driver. Whether driver supports something
or not, is not relevant here, except that we don't want to document
non-existing things or stuff out of tree.

> 
> Could you please update the driver with this compatible as well? Let's not
> merge this change without that first.

This could be even merged without change in the driver. However it's not
the case here as driver already supports it, so your request is fulfilled.


Best regards,
Krzysztof

