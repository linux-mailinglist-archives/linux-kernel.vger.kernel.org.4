Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F895B3077
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbiIIHoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiIIHn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:43:27 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6874109D2C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 00:40:18 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id bn9so823580ljb.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 00:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=8ULEp+WlIDxfwyX+Ul0SmLJhz/rCCVaMvM2NKyHPCaA=;
        b=xQosMpjd9c9zqbElRArG5e9KduNYicN539Yiia5j3ijpQA6MpKKuYsDFBZO86ZOXL6
         BT15l0f7PpQ4yx5Ucu/o3KmX6LW94lKG6xgv2HlPHt0n9ll7boTxASwDLuR3MrQr1NvJ
         oKpgFGd3Cts6mxaSBhcqy7bhokjpNaI9UC9mdHqHtKWVweVkl8t1IOg/s174XmIoMgq0
         7K5QMLYf6I8ksCffTDNgjdRd4dK+emppAsDYk1cd/fKPPQfxBW0dPGUV5URJYIelwJFX
         upSP1g3l7Soo3oGqqc9+RrkJstXvQSHhndKxCfcMHBNR+kXNtjVBg6xXcjGcyubkOD0P
         w7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=8ULEp+WlIDxfwyX+Ul0SmLJhz/rCCVaMvM2NKyHPCaA=;
        b=ZATqOK42F03iwkADkUpbfepe/Usku+yOJ1Tv6b0fcTrktiPaeZOW2Vd0nshq7OvrNF
         3ADmxTAxQeZkrDgX2MxPlG6Z/YKQlINnHPMRPHZYWiR1C2/IWfs24st2r3WdsnmrXLmY
         MLIBigWYtEt74Pmi9kn0eRXM3r+hb6WgsV7ki/FbhgWUfw+FmpQ+DfYffRQpEkbD5oTh
         w2zmczdvw/k9cslLftLDI+onh6UeWwCeDBaKnLQYNg9/2Ou1i4m5+qbLO+/j+fYFfQZu
         JbWO5ycbSq/QzqERw7Elmgy0z2blWLFEeAR2tAWNJvMhSKxpmagZ7spiF8ccs9/ZK8CU
         oc3Q==
X-Gm-Message-State: ACgBeo0Nzv7tFN19rWtbVhTQrmRUT7rF9W20LzdAnlpICf5AajcZr960
        eo7/+fSrPlLYc6rMmzkq/IYV3Q==
X-Google-Smtp-Source: AA6agR7WASyX4osBLqnsk44pTtLygmK2pLxbitoinO6kMsAT4OgHsDFi3epynUoAOWfqktnju1rc1Q==
X-Received: by 2002:a2e:a9a9:0:b0:261:bf5a:8ff3 with SMTP id x41-20020a2ea9a9000000b00261bf5a8ff3mr3557630ljq.252.1662709104708;
        Fri, 09 Sep 2022 00:38:24 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w17-20020a197b11000000b004947f8b6266sm159979lfc.203.2022.09.09.00.38.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 00:38:23 -0700 (PDT)
Message-ID: <51e6ea21-8af4-775d-1561-6671cfc50ecf@linaro.org>
Date:   Fri, 9 Sep 2022 09:38:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] arm64: defconfig: enable ARCH_BCM
Content-Language: en-US
To:     Naresh Kamboju <naresh.kamboju@linaro.org>, f.fainelli@gmail.com
Cc:     andersson@kernel.org, arnd@arndb.de, biju.das.jz@bp.renesas.com,
        catalin.marinas@arm.com, dmitry.baryshkov@linaro.org,
        geert+renesas@glider.be, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, marcel.ziswiler@toradex.com,
        michael@walle.cc, shawnguo@kernel.org, soc@kernel.org,
        vkoul@kernel.org, will@kernel.org, lkft-triage@lists.linaro.org,
        Linux Kernel Functional Testing <lkft@linaro.org>
References: <20220906033957.4377-1-f.fainelli@gmail.com>
 <20220909073509.301363-1-naresh.kamboju@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220909073509.301363-1-naresh.kamboju@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2022 09:35, Naresh Kamboju wrote:
> From: Naresh kamboju <naresh.kamboju@linaro.org>
> 
> 
> On 2022-09-05 20:39, Florian Fainelli wrote:
>> Commit 96796c914b84 ("arm64: Kconfig.platforms: Re-organized Broadcom
>> menu") introduced a new symbol ARCH_BCM and made all of the Broadcom
>> SoCs Kconfig depend on it, but did not enable it in the defconfig.
>> Thus, now the defconfig doesn't include support for any Broadcom
>> architectures anymore. Fix it.
>>
>> Fixes: 96796c914b84 ("arm64: Kconfig.platforms: Re-organized Broadcom menu")
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

The patch was sent on 6th of September. Your report on 8th of September...

Best regards,
Krzysztof
