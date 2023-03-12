Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAE86B6B7C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 21:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjCLUuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 16:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjCLUt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 16:49:59 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39158302B9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 13:49:55 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id k10so40905575edk.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 13:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678654193;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z6P7Y3e3VoDZTVPlDAOd3TSHPiGEIm9y875NR91Q0Pc=;
        b=hXbMdqZ1xwS/zlKi5AhhW3/UFLqGghmozMR1jGFrdF2E0AVA5SlahCMWlXJIwqEpj4
         ZBLkAUNvJ+lg+lXw96OWcCg6Y4WTsRoLKPFl1biZTlb7jd2xXCYiO8wp0tuwWwNnSCmk
         9qlq8CcyWdynbVhYk9jcXlU3rw2GNHDMnxVG9kYBFaGO/Kk4tce9WcIdkGCdDbaVcTzm
         7LDto7amJaDz/5lyUs9Cu228fPWayVho8/az936rSf6UYBP4DzFc8C/8HzLWG5RkIqCg
         7sDxY5rLPeu31qlHczg3uZKNm/N+Gn1A6IAozs+1b4zq/TSO+ptpQCuACjSdBt6AMgLJ
         xxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678654193;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6P7Y3e3VoDZTVPlDAOd3TSHPiGEIm9y875NR91Q0Pc=;
        b=NNuOqgsqF2SrcnORePODJFGug+39UtAJ1uqZjLPPekhvuk5+4MB5+N9Iohxa3GlbzO
         dzQpEEL+5KTMB/6nZ+EDso5C93vnDKd40vPaTVVKCal06x+3btpmZnxH8AHZEIxUyjXd
         FTF1zD1HKG5qiifcPvt5LLBW9IJh0kqRWu8IAh8+BC2U//UHZUGLChmyf23KA46BjfAk
         bYnZAITGBQpymXJ3L5YpaSmGa6wSXGALKMOJdCkpJKv80EmkPasym1H38N2uoS69Vb1S
         JHYDLH+1ONhmnTMc1ZEPsq9BOgvyCG+s/0WjkowiqaFr3pyC0yW9r9bz8Lyn7HunLoT1
         Ixnw==
X-Gm-Message-State: AO0yUKWxrBmK+wrd5Uo6wdcvQULj10UilG0Ng0paFujXI2T0mU5iR00e
        DrKEt9JE9+L7+2PbGMWBLqWtMQ==
X-Google-Smtp-Source: AK7set+eqy3c1M6X4Pz8iKUL5HusTLVWbMhmL0NNgUiW9+u2MSk5mtWernC/GwVWEJcJmuNkvV5NWg==
X-Received: by 2002:a17:906:3a48:b0:8b1:2f0e:e3a4 with SMTP id a8-20020a1709063a4800b008b12f0ee3a4mr29922367ejf.26.1678654193757;
        Sun, 12 Mar 2023 13:49:53 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id c9-20020a50d649000000b004c07b11deb8sm2500242edj.64.2023.03.12.13.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 13:49:53 -0700 (PDT)
Message-ID: <c1441d15-9f56-6512-4cc5-42ef6d954029@linaro.org>
Date:   Sun, 12 Mar 2023 21:49:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Henan Yiming
 Technology Co., Ltd.
Content-Language: en-US
To:     Yang Xiwen <forbidden405@foxmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>
References: <20230310143330.9485-1-forbidden405@foxmail.com>
 <tencent_27DD0718C3FD9C5F7D6E2FBA225CAA760405@qq.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <tencent_27DD0718C3FD9C5F7D6E2FBA225CAA760405@qq.com>
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

On 10/03/2023 15:33, Yang Xiwen wrote:
> Henan Yiming Technology Co., Ltd. was established in 2021. The business
> scope of the company includes: communication equipment (excluding radio
> control equipment).
> 
> Link: https://gw.yimingkeji.net
> Signed-off-by: Yang Xiwen <forbidden405@foxmail.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

