Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A8F6E273C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 17:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjDNPqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 11:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjDNPq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:46:27 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C86FAD2D
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 08:46:24 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n19-20020a05600c501300b003f064936c3eso15092513wmr.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 08:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681487183; x=1684079183;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4YvFDcXCxH0IHAlEOnTr7X8C2ZaoaLvqC8PQViNwb+0=;
        b=CGo8j1W2FmAqMnJH4qAKnNiqxbf8gAuLuQXj3WINrZZa2nZXrtKScsRfz+ZfBs9CJu
         MstNB5C5MjYfLqx24lPYBblayV3WVt+GN1vWPW01aBZVxvxBw5r4ib8Zz1hDE2aqM/Ru
         BoLvB6Nn6II6x/0EBKVFKSgjHR4yB9IODMTVz1Uw+YsgEDSzyLVvnJ4pH+dlKuFJ8p3J
         VHg5q6CWFrUmLJuFQUV4+K9vZefK0Qc0huP8lmoyJiSIN8YJ/Gq0l0b+4tjwm+gsPfc2
         eWJLWXDMnQ2cflu3GD3SF2QCB2aYePTtkw9lpn0G+jRsKYxRZDRjkH7YiBeMfXg04ooF
         f9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681487183; x=1684079183;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4YvFDcXCxH0IHAlEOnTr7X8C2ZaoaLvqC8PQViNwb+0=;
        b=WHbVKOht0YWmwqcymxqbCHCGis4bVTVWjost3Zjj3KBWxpbNvQ1d7Rx4G7qxsdUjG9
         V6F8GKhWb25FyQY1K98ATM2hHmVM9rot3hCisqrqlD7oJRFO1mQDE0e5DmeQfKolggoe
         BA448/f3dXeInuPWKYLY3hMR7LnFx2f2U0ifmqij9cI8d79ohy9VyOSkE7R0TTg9+BuN
         5MkzoLnPp2bfbNwSxl7guXcGrgniEy8N85+vyJZ+3PRZ8uV44RLv/1yl4d2fG5DXb2yY
         /9oKi72eBNu6yS6I4RDMJDMEs3JPT5h7zt8IC109JH+p+mN/PmfB5U7/Qs0OT4lFWmlB
         Jlcg==
X-Gm-Message-State: AAQBX9fH/n0MElyKh4/CmwFJ7okCfhKx+8mQiJEMAnHkr0t6i73BYY88
        y7i7mKUQev8bJNzsBxomH9M=
X-Google-Smtp-Source: AKy350ax94Q0q1onTnwQMV5EE3TpgRfQw3R3Ni+6sgIb+LfrPtBcUh9No7WTr/RfBPPvrV2RcFkbIA==
X-Received: by 2002:a05:600c:231a:b0:3ef:1745:518e with SMTP id 26-20020a05600c231a00b003ef1745518emr4976351wmo.26.1681487183309;
        Fri, 14 Apr 2023 08:46:23 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id n21-20020a7bc5d5000000b003e91b9a92c9sm4607383wmk.24.2023.04.14.08.46.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 08:46:22 -0700 (PDT)
Message-ID: <40cf026f-61db-2fe0-f941-bfe5c9aa20e7@gmail.com>
Date:   Fri, 14 Apr 2023 17:46:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] phy: mediatek: fix returning garbage
Content-Language: en-US
From:   Matthias Brugger <matthias.bgg@gmail.com>
To:     Tom Rix <trix@redhat.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, chunfeng.yun@mediatek.com,
        vkoul@kernel.org, kishon@kernel.org,
        angelogioacchino.delregno@collabora.com, nathan@kernel.org,
        ndesaulniers@google.com, granquet@baylibre.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20230414122253.3171524-1-trix@redhat.com>
 <3242b862-0e7c-b7e9-14cd-3fbcbb87ba04@gmail.com>
In-Reply-To: <3242b862-0e7c-b7e9-14cd-3fbcbb87ba04@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/04/2023 17:43, Matthias Brugger wrote:
> 
> 
> On 14/04/2023 14:22, Tom Rix wrote:
>> clang reports
>> drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:298:6: error: variable
>>    'ret' is uninitialized when used here [-Werror,-Wuninitialized]
>>          if (ret)
>>              ^~~
>> ret should have been set by the preceding call to mtk_hdmi_pll_set_hw.
>>
>> Fixes: 45810d486bb4 ("phy: mediatek: add support for phy-mtk-hdmi-mt8195")
>> Signed-off-by: Tom Rix <trix@redhat.com>
> 
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> 

Please also add
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

see CA+G9fYu4o0-ZKSthi7kdCjz_kFazZS-rn17Z2NPz3=1Oayr9cw@mail.gmail.com

Regards,
Matthias

>> ---
>>   drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c 
>> b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
>> index abfc077fb0a8..c63294e451d6 100644
>> --- a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
>> +++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
>> @@ -292,9 +292,9 @@ static int mtk_hdmi_pll_calc(struct mtk_hdmi_phy 
>> *hdmi_phy, struct clk_hw *hw,
>>       if (!(digital_div <= 32 && digital_div >= 1))
>>           return -EINVAL;
>> -    mtk_hdmi_pll_set_hw(hw, PLL_PREDIV, fbkdiv_high, fbkdiv_low,
>> -                PLL_FBKDIV_HS3, posdiv1, posdiv2, txprediv,
>> -                txposdiv, digital_div);
>> +    ret = mtk_hdmi_pll_set_hw(hw, PLL_PREDIV, fbkdiv_high, fbkdiv_low,
>> +                  PLL_FBKDIV_HS3, posdiv1, posdiv2, txprediv,
>> +                  txposdiv, digital_div);
>>       if (ret)
>>           return -EINVAL;
