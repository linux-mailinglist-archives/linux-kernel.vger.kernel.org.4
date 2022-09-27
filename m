Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E32F5EC779
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbiI0PUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbiI0PUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:20:11 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D698B9412F;
        Tue, 27 Sep 2022 08:20:09 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id a41so13668020edf.4;
        Tue, 27 Sep 2022 08:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=NMtmptc2HDRjrjmmdoUIZuav0SUAivIB9wNOA7ujGnE=;
        b=gasiRgkVT5Ft/qqBvWsfyzhICytsXf+idmA0WOy/7W5eUIbSPmuAl4JkziR936O9Xv
         QzcNCioztLnDVsayJUrkXZiyHArS4VKt2wvZaYZiQkCLfvR3neEEYfCBLueq2Wgey6JU
         4ysmveUnizQty4srdBX5NVrcvbD19/T1IbzNXsRPfo1J8OnUk/sN1yUMpMlyXy8ceIWU
         v8CshJnv2aXMp5K9gBbLLlF7nrRGHHJjNfNy1JT8gLmWqXXTCRaURBR3Koc0nApzQk6o
         /nddys1Mh/sFxjjMdJS5bSGgTLEYxavASf9qq9EcIxTnSXM5aJEkScGmenZcs3FobCWc
         8PFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=NMtmptc2HDRjrjmmdoUIZuav0SUAivIB9wNOA7ujGnE=;
        b=vLCXRYktxBig9mJwzibGRwoQCg3ck0TFD8B5vlLABAJEMnfQCHaJ3679+0IbmrpHX1
         ofwPawlYQjqFbpx+gBZkXLpOO74bpPDAT95RfLAf4uHIw88Neug1BiFmMJnSy02Utgg4
         Gc8CZ3Cb2j9G8OE9QdNoVuvWajw3f3yZhR/R0xjnrVvOREYESgblGFfERgcxVdaUX/SI
         7hsbptQlUEuUVqv7EG43CI5aYd5/CkWUgA4dy9CqwpHGccWH37ar5qBy2DX+IIi71qSz
         pgHeKY7r1xOsTnlXw/fs85OVa9cicuvOr1FxsMkQ9GZli/12jEtgdMP0sP4uAcxKnv/Z
         T/Lg==
X-Gm-Message-State: ACrzQf35xEea9PSTZd4f0qEjRqQa6Gb7monsyCPy90/EOUEdI+xLOQ77
        2aOBzJQl6uWBL8qAjbWKHko=
X-Google-Smtp-Source: AMsMyM7pGd+rRA66qdBumrBGic6j5vjWO3BN6pPsTagpKSqkaZjGhABZxEVCqQwKusj8x4QMIdB1kA==
X-Received: by 2002:a05:6402:520c:b0:451:4213:49db with SMTP id s12-20020a056402520c00b00451421349dbmr28321627edd.130.1664292008165;
        Tue, 27 Sep 2022 08:20:08 -0700 (PDT)
Received: from [192.168.3.32] (dh207-97-176.xnet.hr. [88.207.97.176])
        by smtp.gmail.com with ESMTPSA id ne22-20020a1709077b9600b0073d8ad7feeasm931650ejc.213.2022.09.27.08.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 08:20:07 -0700 (PDT)
Message-ID: <6ac05eac-e6f5-b8e5-35dc-25373723f401@gmail.com>
Date:   Tue, 27 Sep 2022 17:20:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v2 01/33] arm64: dts: qcom: ipq6018-cp01-c1: correct
 blspi1 pins
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220926074415.53100-1-krzysztof.kozlowski@linaro.org>
 <20220926074415.53100-2-krzysztof.kozlowski@linaro.org>
 <647d12dd-9bc6-ebe3-7a72-9b9c0d4610dd@gmail.com>
 <e7697876-f2bc-b0ef-c8bc-6737d8a54551@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
In-Reply-To: <e7697876-f2bc-b0ef-c8bc-6737d8a54551@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27. 09. 2022. 16:33, Krzysztof Kozlowski wrote:
> On 27/09/2022 16:01, Robert Marko wrote:
>> On 26. 09. 2022. 09:43, Krzysztof Kozlowski wrote:
>>> When BLSPI1 (originally SPI0, later renamed in commit f82c48d46852
>>> ("arm64: dts: qcom: ipq6018: correct QUP peripheral labels")) was added,
>>> the device node lacked respective pin configuration assignment.   It
>>> used also blsp0_spi function but that was probably the same mistake as
>>> naming it SPI0.
>> Hi,
>>
>> Sorry for making it confusing, but "blsp0_spi" is the correct function.
>> Pinctrl driver and datasheets call functions blsp0-blps5, but usually in DT
>> we call the nodes blsp1-blsp6.
>>
>> It would probably be better for me to rename the nodes to blsp0-5 instead.
> OK, so instead I will add blsp0_spi to the bindings.

Can you add blsp0_uart and blsp0_i2c as well?
All 6 of the QUP-s have same features.

I am adding MDIO to CP01, so I can add mdc and mdio to bindings
as they are lacking there as well.

Regards,
Robert

>
> Best regards,
> Krzysztof
>
