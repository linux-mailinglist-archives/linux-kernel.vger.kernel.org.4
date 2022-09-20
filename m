Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE43D5BEAA1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 17:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbiITP7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 11:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiITP7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 11:59:48 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5954564CB
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:59:47 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a8so4492043lff.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=QMYsP28bPSxiuVehnUkq9TPK8zyTroEstE6jb5tgTaI=;
        b=n+AtSohyyJIp32sHBo57AZXXa9T8x1CpBYXcbLur2iNqWsjX86/ihr9MnLKwNgYyMU
         GX9N2pZkMEFhQPl5ZlxgTeHD1n8+BlFjeRBzYXYiZCKlcV8qGgCAS3d6oMd+EWQPrrhM
         1GvoqjjI2oLhq7zDxpcx+A9APdo/yShIyhz0Lmt0q6zLIHsOu5Awg5HdG4Z5sMtO/U7u
         ApAdEV+RKdeShp7eyK3o7adbqHxXJuU/0yG7rucfjVihMwKgdGSiXxju9YI8u6fAGHgm
         3XIZl1mAlsVHRToObmHU9YsmdfsePs24ygAC7ZBi3+7hEUj0vBbSh7XPprr5QasfCBzr
         L8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=QMYsP28bPSxiuVehnUkq9TPK8zyTroEstE6jb5tgTaI=;
        b=aSl5Xb83BkfkDGkxc7W9PCA4kv2O5BkMJNDJaI9DKb14R+WzYF9Mh4GJq1/YA3iKgy
         f1hdHteeIRZ7WcdGQJhuz42LwmPHD2B2PZ6MSRHSYyFhsgGA5MNPjqJWp8hcX1hzpzkh
         DxDILMCeYSh4Bjt3FOacQXGgX27yqa6KUlgq78Z5wO/07CrThZTLupkGZsBW8Vzq/8H+
         2U+gY2Gpr0AgBmOm0EPxXt0IhpPznlAP/BY05FA698wjhPISjskSDx/YqiYW6po7E9ag
         mZtGr0wTLk55rKdCKJ2Q3ngC8h9sRX95FdnDR8aCVYmVIwp7ZNC8uyJKHAPtMNqqu1Bf
         gZEQ==
X-Gm-Message-State: ACrzQf38LHlYvOAA57iIDcvTq9hkYN8stAHTvEtPcafnWNI/VUpbdT9Z
        oEVsQHy2/aUAmklQm/zGCdJnBw==
X-Google-Smtp-Source: AMsMyM4wZ4bHQzY1QM+2MvHkJrH6aFzjE1xLqU7NFFllPA01l1cq/QNVqFQhjz6U4JGkLgammgllmQ==
X-Received: by 2002:a05:6512:2210:b0:499:d710:9c0d with SMTP id h16-20020a056512221000b00499d7109c0dmr9097083lfu.325.1663689585682;
        Tue, 20 Sep 2022 08:59:45 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id l17-20020a2e8691000000b0026b2094f6fcsm19677lji.73.2022.09.20.08.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 08:59:44 -0700 (PDT)
Message-ID: <10bd1f39-3971-90ee-5fe4-c44005cdfcc8@linaro.org>
Date:   Tue, 20 Sep 2022 17:59:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3] dt-bindings: firmware: imx: sync with SCFW kit v1.13.0
Content-Language: en-US
To:     Viorel Suman <viorel.suman@oss.nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220919132236.264382-1-viorel.suman@oss.nxp.com>
 <c86d39c9-82d2-0f9f-9836-76ad3b6d8ede@linaro.org>
 <20220919180631.x2telgn6d7woggmz@fsr-ub1664-116>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220919180631.x2telgn6d7woggmz@fsr-ub1664-116>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2022 20:06, Viorel Suman wrote:
43
>>>  #define IMX_SC_R_SECVIO			44
>>>  #define IMX_SC_R_DC_1_VIDEO0		45
>>>  #define IMX_SC_R_DC_1_VIDEO1		46
>>>  #define IMX_SC_R_DC_1_FRAC0		47
>>> +#define IMX_SC_R_V2X			48
>>>  #define IMX_SC_R_DC_1			49
>>> +#define IMX_SC_R_UNUSED14		50
>>>  #define IMX_SC_R_DC_1_PLL_0		51
>>>  #define IMX_SC_R_DC_1_PLL_1		52
>>>  #define IMX_SC_R_SPI_0			53
>>> @@ -151,10 +154,10 @@
>>>  #define IMX_SC_R_DMA_1_CH29		137
>>>  #define IMX_SC_R_DMA_1_CH30		138
>>>  #define IMX_SC_R_DMA_1_CH31		139
>>> -#define IMX_SC_R_UNUSED1		140
>>
>> This one disappears...
> 
> Hi Krzysztof,
> 
> Right, it was renamed in the subsequent SCFW kit
> versions to IMX_SC_R_V2X_PID0, thus - this patch
> rename it in include/dt-bindings/firmware/imx/rsrc.h
> file in order to have this file and SCFW kit defines
> synchronized.
> 
> IMX_SC_R_UNUSED1 is not referenced somehow in kernel,
> thus - no compilation issues if renamed to IMX_SC_R_V2X_PID0,
> IMHO it does not make sense to me to add the related
> backward compatibility define like below:
> 
> #define IMX_SC_R_UNUSED1 IMX_SC_R_V2X_PID0

The bindings are used by other people (other Linux kernel forks) and by
other projects (like bootloaders and other operating systems). This is
why once set, we do not change them, with some exceptions.

Best regards,
Krzysztof
