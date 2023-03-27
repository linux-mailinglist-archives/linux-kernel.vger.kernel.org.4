Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA816C9EB5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 10:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbjC0I5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 04:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbjC0I41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 04:56:27 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14260527C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:53:10 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id i5so32971967eda.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679907188;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0c3Qz5i4mbw80iNAtTe2WKcT1T5j8OkpHJxwN6IS8PI=;
        b=tM5NO45pGXT4DdeIlMDaUl5FU955YZekhPqh8jButpxl32Ccjd3rzrpUGX1V/MpOSI
         C7GH5+rrz5AIXcOG84nP5nhohDPti2g1sFOnDNSKg0WMbTlllNFMCI1RBToiivpkfgcj
         uD+5CnHs2LlfI6fPP5cu7NmRyJ29FOfMAEifnltV9bAwZbY7k2AB19cOuxnZNU3Qu09e
         Ky1hgmDW1vpMAE1MyzAxvgDhMmNl8Oi3EONQ31pIDQuvZc73WkWfl6g41tmR5ZArPKqt
         spEwOOqwIwDH2zq5lECjDM4ZZxvrC9uckYuhMpI5ZUABPoIho7nKS/hfaNNchCQkPhoa
         ASgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679907188;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0c3Qz5i4mbw80iNAtTe2WKcT1T5j8OkpHJxwN6IS8PI=;
        b=GlP9wmkuF2Kx3oBPw/uK3qMeZQj0pvmtdKQo3YBsUyfLdKGcpgr7gC+FRMEG0VnrfR
         RONIL4P5u4y6bgqVuaHCyy1rTNnAKRCHJJeNXxDXaQIBnSrxAdfOwA9s+CFe3r68aza8
         pKNxg1JLHsyoBSEaowhqiiRSMEH/TzZTGeWQBJ6yi1UKGn7YRlI7It3dXCamcywcBs3c
         4BLA0HCcQuooE4pcjIkcDVbXVUiDCy+tEYrdBq96Ym1QDYeoflZQzS0sR8U2MmwzXhN0
         X1DYqhcQP2EarcLFRth+gAITtptHH0QAsW8ils+oOPuFj6CDVmBqS2g9W65+I2M+SMch
         RE3g==
X-Gm-Message-State: AAQBX9etqpgtO1dyUSAZG6tAfvCAITQIorjmLO18PTTYrVXzsLaUNU1y
        1RLw409BGsaCLNimpG6bFNK46w==
X-Google-Smtp-Source: AKy350ad3WUuXrlGszdhn1hneGSCnyPoTMuucS84Ch48RIx6MZLCPc7EwnKiYeV67mRmAm9+3U4g2w==
X-Received: by 2002:a17:907:608e:b0:932:10bf:ec4d with SMTP id ht14-20020a170907608e00b0093210bfec4dmr14580196ejc.25.1679907188604;
        Mon, 27 Mar 2023 01:53:08 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:198e:c1a5:309b:d678? ([2a02:810d:15c0:828:198e:c1a5:309b:d678])
        by smtp.gmail.com with ESMTPSA id bb14-20020a1709070a0e00b0093f322187f0sm3129651ejc.189.2023.03.27.01.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 01:53:08 -0700 (PDT)
Message-ID: <0c43019f-01b6-c466-c7d4-c2b91116b7db@linaro.org>
Date:   Mon, 27 Mar 2023 10:53:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 2/2] spi: loongson: add bus driver for the loongson spi
 controller
Content-Language: en-US
To:     zhuyinbo <zhuyinbo@loongson.cn>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
References: <20230324063317.14664-1-zhuyinbo@loongson.cn>
 <20230324063317.14664-3-zhuyinbo@loongson.cn>
 <0fff1e01-678b-a26a-084b-9aa30a0deea5@linaro.org>
 <2a24cce4-3211-3440-cc42-55499ded275e@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2a24cce4-3211-3440-cc42-55499ded275e@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2023 10:42, zhuyinbo wrote:
> 
> 
> 在 2023/3/24 下午7:31, Krzysztof Kozlowski 写道:
>> On 24/03/2023 07:33, Yinbo Zhu wrote:
>>> This bus driver supports the Loongson spi hardware controller in the
>>> Loongson platforms and supports to use DTS and PCI framework to
>>> register spi device resources.
>>>
>>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>>> ---
>>>   MAINTAINERS                     |   4 +
>>>   drivers/spi/Kconfig             |  31 ++++
>>>   drivers/spi/Makefile            |   3 +
>>>   drivers/spi/spi-loongson-core.c | 302 ++++++++++++++++++++++++++++++++
>>>   drivers/spi/spi-loongson-pci.c  |  89 ++++++++++
>>>   drivers/spi/spi-loongson-plat.c |  66 +++++++
>>>   drivers/spi/spi-loongson.h      |  41 +++++
>>>   7 files changed, 536 insertions(+)
>>>   create mode 100644 drivers/spi/spi-loongson-core.c
>>>   create mode 100644 drivers/spi/spi-loongson-pci.c
>>>   create mode 100644 drivers/spi/spi-loongson-plat.c
>>>   create mode 100644 drivers/spi/spi-loongson.h
>>
>> Your patches still have build warnings. Are these false postives or you
>> forgot to build it? Anyway, please respond to the report.
>>
>> Best regards,
>> Krzysztof
> thanks your reminder, I have already provided feedback about compile issue.

Then please test your patches before sending...

Best regards,
Krzysztof

