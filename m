Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEA45E82DA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 22:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbiIWUDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 16:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiIWUDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 16:03:09 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF79B121E4C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 13:03:07 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id a3so1877008lfk.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 13:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=3B4MDZ5CQTFeIT4uHSEO1DmnDlzAtH2YJIQRxEA6xj0=;
        b=xKzlIUdfHN8OhSleFQ+0E9cHJjBUQ/fxGeTghSd2ZfXkhr159t1Miz7FPIAykma77d
         G6QUla53ZglDsGll1dPFiC3HfofTQHdaURDjhpc+bPc5gtEGXhGeIjYl6iZBKWlvXAwo
         Bvf5AH0jsUon3IUts5ynoj+csMVtdXdhPoykno/snOchxOd1dN/7+RvbRdhLtuAry5mV
         ir2X5kaW9vdn71kco642jvtOkXTYuxQtBhqv6+8co762s3OHrpAwI8gPbGwDku+dopcY
         Ex6drDwMccNOGZNMp/OE49NPgy5ZVCKRTKXR9dta+sux8kmUIddUwUrMmuyIe1rKf4BL
         64Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=3B4MDZ5CQTFeIT4uHSEO1DmnDlzAtH2YJIQRxEA6xj0=;
        b=naYvHSrdc3iSmBmFX4ylPPl5kUpeLO6kUeZXPlsU5tU1Sqzy4rdgdiP/iSwMLLC4BR
         fUFGtey8ydCREoS5gSqs5oFEE4M/UOs+8se1j1wlhuunsYUjsydQY+C7gBbfOTGI57aK
         NI7XlRezMRPtsAzVjfui5TBeuuwVJBySK/uhGASmZeLfl61tOePQ4ahlCzhY8bCFQIdR
         Tcd2C7Zu3zJtk5u2QtZyaO2/EYW11ul66eiGGT0htNakXJ1dcXm8nqKrTTTcAEwMsAmZ
         29cstGP7dJpzB7N8D+4vaqJZhJYQdanRIJYjbXFvPUR6Tft5Ii4k3ZeBOju+9EIhZYKj
         Q5OA==
X-Gm-Message-State: ACrzQf3TpV5AY0xSlY2zSrzNZ15iPR8fnwqwOlTQOPTB+JWdE0gl4psa
        wRBxAl8y6tzoa5pObJ3H8IWEHw==
X-Google-Smtp-Source: AMsMyM7e7LLeD73qfxMkyrZjrCeKvATtbhRfxbzl2ZShXb7tDCcScXS4wqsXe7d62EGWyJTCAnkfMg==
X-Received: by 2002:a05:6512:3e1f:b0:49d:502b:765d with SMTP id i31-20020a0565123e1f00b0049d502b765dmr3662111lfv.17.1663963385940;
        Fri, 23 Sep 2022 13:03:05 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id j3-20020a2e8003000000b0026ad753448fsm1522862ljg.85.2022.09.23.13.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 13:03:05 -0700 (PDT)
Message-ID: <eceb4006-e5a5-fa8a-b855-f99306cc9593@linaro.org>
Date:   Fri, 23 Sep 2022 22:03:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH V13 3/7] MAINTAINERS: Add the entry for DCC(Data Capture
 and Compare) driver support
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>, vkoul@kernel.org
References: <cover.1663642051.git.quic_schowdhu@quicinc.com>
 <cdd67dd71a6c8559d2771ac453b472a5c3ee1897.1663642052.git.quic_schowdhu@quicinc.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <cdd67dd71a6c8559d2771ac453b472a5c3ee1897.1663642052.git.quic_schowdhu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 05:57, Souradeep Chowdhury wrote:
> Added the entries for all the files added as a part of driver support for
> DCC(Data Capture and Compare).
> 


> +F:	Documentation/devicetree/bindings/arm/msm/qcom,dcc.yaml

arm is only for top level nodes/properties. Please put your bindings in
respective subsystem.

Best regards,
Krzysztof

