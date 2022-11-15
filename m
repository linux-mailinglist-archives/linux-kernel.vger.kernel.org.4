Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8040D629306
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 09:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbiKOINC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 03:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbiKOIM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 03:12:59 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C481CB25
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 00:12:57 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id b9so16521340ljr.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 00:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JDkqh0tAJJ4X7eNluhZEGW7LBA4YZb7PqjBBGMFZ9o8=;
        b=xAYAcYiqz6vAihbiQR5GhFuz1tcemWPVKQgq85Cxv/HD3SYZ1whRQelsHKBF+5/G4j
         I9am9IWQeZk/s4NVUQlr/GG/5pCD9GgypXy4S7Kwop9mp2lBCGbcaG8ztDCaWngpEDbj
         HyVca9Xi9F63aGv8ELFQZez0V/i7MM7Pcv/Ac1XYG2YhFmgvTryuF5XY92bsnkkEMCTv
         qt94KP13Vin3Fbf48xnKfWosutfGpKUuY3nw9Xoow1TsTWiXaGqOOx++L8exdwVi/saq
         9Cc1NQNmts2U/s6r/xiddO454NQjvqQDYIxmJHCBzkLHfofNAXA1dOjupTOC2/3+ZMIv
         7pZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JDkqh0tAJJ4X7eNluhZEGW7LBA4YZb7PqjBBGMFZ9o8=;
        b=PsPLHZRTIwegw6dEnI8k1q4XJAopaiQispVJxNzqUcmNGn7nXfziKbD9/l7S/hKDNi
         Lr5KYjiO0utqReO8o6zeR6qAN1iJNEdQPhIfXGuuSrrTpU3xAUXWJpc900Xrj/LHmXJf
         P8RXhQg/OTd3kEmonk7L0bOLBwLI5d834RqwhE9dUz58u30EPotf+GsWcmrzppzQDcqF
         rpDnGWD54LtlhMpE95rfjHjPpwUB9cuQRhlQ7Xhv/e4BUcr80pD2a951S+f0cGRgF2hG
         UaAfNxKAobvR/FbY5306y9rjx3PSXR176pU8NMabxHPgjGBzZLAOuNsBzqeaD+mmsacF
         fRgA==
X-Gm-Message-State: ANoB5pmYgvqbvF2kxLb1rQtiQpbHKjv21zSxKBjOOSAB0NK6UN4ROFEX
        3jX3QUyjglVgANZNlQwu2tFjKQ==
X-Google-Smtp-Source: AA0mqf47HmClxjlAW9DxMF2bgWVxgI7npM2Ar0tsu0fsJS2xY8RI9H87d0FG/XSIJ41uOriL/+Xzcw==
X-Received: by 2002:a2e:b706:0:b0:277:d75:f1de with SMTP id j6-20020a2eb706000000b002770d75f1demr5794184ljo.272.1668499976198;
        Tue, 15 Nov 2022 00:12:56 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id 28-20020ac25f5c000000b004b491fe071fsm1635595lfz.36.2022.11.15.00.12.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 00:12:55 -0800 (PST)
Message-ID: <61df3c4f-f41c-9525-606d-1b8261163080@linaro.org>
Date:   Tue, 15 Nov 2022 09:12:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 02/14] dt-bindings: phy: qcom,qmp-usb3-dp: fix sc8280xp
 bindings
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221111092457.10546-3-johan+linaro@kernel.org>
 <a22888cd-34cb-3453-0dc2-096da208564c@linaro.org>
 <Y3JCVzJ74YsfcDz4@hovoldconsulting.com>
 <de3a426a-03e8-ed15-a9a1-bb300e776e5f@linaro.org>
 <Y3JOO0kNnaNhnW3K@hovoldconsulting.com>
 <02725b78-04ad-8f4a-25c2-9cdaa1e37ab7@linaro.org>
 <Y3JthM1jC2vH1Kn+@hovoldconsulting.com>
 <efd412d0-7411-8b0b-4700-9e183a592048@linaro.org>
 <Y3JxZ+yFMLZkwNBi@hovoldconsulting.com>
 <8420c342-9dce-aea7-8d1e-f141e0c1ebb5@linaro.org>
 <Y3J2AjjjsybI9mKd@hovoldconsulting.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y3J2AjjjsybI9mKd@hovoldconsulting.com>
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

On 14/11/2022 18:08, Johan Hovold wrote:
>>
>> Which is also fine. I don't understand still why it is a problem - even
>> if you have multiple files, one for each SoC/phy. If USB4 brings here 10
>> more clocks and other SoCs/phys might bring many more options, then what
>> else can you do? Grow the binding file with big text-based mapping of
>> IDs? It's not a viable solution. Header or headers is the only
>> maintainable way for such cases.
> 
> So then we must add per-SoC (and PHY type) headers even if we can
> possibly reuse defines from one platform for another as long as they
> appear to be similar enough?

No, you don't have to. I just got impression that future devices will
bring so many changes that anyway you will end up with per-SoC defines.

> For example, using a "SC7180_USB3_DP" infix
> for the current platforms and add a new series of indexes for SC8280XP:
> 
> 	QMP_SC7180_USB3_DP_USB3_PIPE			0
> 	QMP_SC7180_USB3_DP_DP_LINK			1
> 	QMP_SC7180_USB3_DP_DP_VCO_DIV			2
> 
> 	QMP_SC8280XP_USB4_USB3_DP_USB3_PIPE		0
> 	QMP_SC8280XP_USB4_USB3_DP_DP_LINK		1
> 	QMP_SC8280XP_USB4_USB3_DP_DP_VCO_DIV		2
> 	QMP_SC8280XP_USB4_USB3_DP_USB4_PCIE_PIPE	3
> 	...
> 	QMP_SC8280XP_USB4_USB3_DP_USB4_RX1		9

The names are just a names, you can even use QMP_SC7180_* on SC8280XP.
You can skip the SoC part and have something shared. We already have
such patterns - although maybe more often for outside components (like
PMICs). The differences are:
1. For per-SoC name it's quite obvious which clock is supported on fiven
SoC,
2. With shared names, you should document somewhere mapping between
supported clocks and SoCs. Also what to do if new device comes with 10
new clocks entirely different - re-use/map existing defines or add
completely new set of 10 of them?

Best regards,
Krzysztof

