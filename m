Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2706F311A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 14:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbjEAMnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 08:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbjEAMnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 08:43:47 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4261FD8
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 05:43:16 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2a8eb8db083so24151791fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 05:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682944993; x=1685536993;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xwPDq5ZTkDVgHb/uQb+f+dVIO2o0aAZpD6P70DMwUWI=;
        b=Tp4VGH2K/v86k0jAdcITs8TPICO69LbiKCESGpARv9/gOoclKMAqqyzfTaRB0gt82o
         J+kBvULZzrwHNwzfVgcNzQ20PhoOZ01drUJ4CySFSMzl+8mDACY4l7hXsSOCXYYKe0+m
         KMXTqB1HlFsDiqf9WWAJLo1PbeJ0QHhWbUJOv1QRaW08BPrVavJeDSuu58oTWcnzy4Ed
         7PaVTOivdw1qaZGJtAUnMO/1XfoKbk0S0fXDQHM8IgX16H5nG/Zo/u+5JHucub16CcIr
         foCCCm4d0ueXJWwY+MiizSt2ChiSCB8+1Yn00FnNOYyVGL85djX6t0UjtoI6+XlYUIAr
         Rx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682944993; x=1685536993;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xwPDq5ZTkDVgHb/uQb+f+dVIO2o0aAZpD6P70DMwUWI=;
        b=cDbVGZ5udIau31G+Q3oiw3jRyxXmnNBBTJUuX0GjEsS1nRYe6UJxC8iEy5ZR9Xbmoo
         eUGhzOfWPEueg5V/xs/SL5MnU2x4cYVn3qJvGUYEeAOZyXttN8ybGBam1f79YT40qXUR
         DhMJhhsGr2Dk8WPC7oYBcxvrCA49lfLfLIcosGqBJYDlOFPqSMs/f2YO+D6WNRxJBkc8
         +ofyO7oM9KC/Lu4Yh7oiCQCm4uQeoM7kmvNZgtMpJBcTpXXJPIR4Eo08hewuxKtLGNAT
         6VmFAAcBWmUPBuPM7kWTxHEZsjmdVd+dhGelRGCa8FAeK479yZ7sD/nuSvUC8YmAQvrM
         lZ9A==
X-Gm-Message-State: AC+VfDxTMGZaZe27LxvwwMRGtPawUbbBBYVrRzkvlFDUi9SZMWKKGKQ3
        IvGvYkc94zOenTwr30a8Ea8Ssw==
X-Google-Smtp-Source: ACHHUZ780umdJ9HJNYHcxHXY0b4RUYHj7BHsSAwYpBbHxTvtY/ATxjIdot2LYlFfq5/YiDwr0H6ixA==
X-Received: by 2002:a2e:934c:0:b0:2a7:6e37:ee68 with SMTP id m12-20020a2e934c000000b002a76e37ee68mr3562808ljh.12.1682944992764;
        Mon, 01 May 2023 05:43:12 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id d14-20020ac2544e000000b004eb3b6da6f5sm4673288lfn.228.2023.05.01.05.43.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 05:43:12 -0700 (PDT)
Message-ID: <d23d3757-da6f-69d7-bca9-581c489f81e6@linaro.org>
Date:   Mon, 1 May 2023 14:43:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] spi: spi-geni-qcom: Correct CS_TOGGLE bit in
 SPI_TRANS_CFG
Content-Language: en-US
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org, quic_vtanuku@quicinc.com
References: <1682412128-1913-1-git-send-email-quic_vnivarth@quicinc.com>
 <9f28dbff-ca3a-8523-5bfc-37b38bc846c3@linaro.org>
 <1b1b095e-8fcb-37d5-7542-48a6b55f35a1@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1b1b095e-8fcb-37d5-7542-48a6b55f35a1@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1.05.2023 10:05, Vijaya Krishna Nivarthi wrote:
> On 4/25/2023 7:15 PM, Konrad Dybcio wrote:
>>
>> On 4/25/23 09:42, Vijaya Krishna Nivarthi wrote:
>>> The CS_TOGGLE bit when set is supposed to instruct FW to
>>> toggle CS line between words. The driver with intent of
>>> disabling this behaviour has been unsetting BIT(0). This has
>>> not caused any trouble so far because the original BIT(1)
>>> is untouched and BIT(0) likely wasn't being used.
>>>
>>> Correct this to prevent a potential future bug.
>>>
>>> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
>>> ---
>>
>> Has this always been the case, or did the switch to BIT(1)
>> only occur on some recent platforms?
> 
> 
> Thank you very much for the review..
> 
> This has always been the case.
> 
> With intent of disabling CS_TOGGLE, currently, the driver is unsetting BIT(0), though it should have been BIT(1).
> 
> Yet no problem was encountered because
> 
> a) BIT(0) seems to be an unused bit
> 
> b) BIT(1) is probably already unset because its untouched
> 
> Further more, as Doug pointed we are mostly using GPIO for CS.
> 
> 
> Testing with the change has not caused any regressions.
Okay, with no deeper knowledge of the topic best I can give you is:

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>


Konrad
> 
> 
> Thank you,
> 
> Vijay/
> 
> 
> 
>>
>> Konrad
>>
>>>   drivers/spi/spi-geni-qcom.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
>>> index ba7be50..8a7d1c2 100644
>>> --- a/drivers/spi/spi-geni-qcom.c
>>> +++ b/drivers/spi/spi-geni-qcom.c
>>> @@ -35,7 +35,7 @@
>>>   #define CS_DEMUX_OUTPUT_SEL    GENMASK(3, 0)
>>>     #define SE_SPI_TRANS_CFG    0x25c
>>> -#define CS_TOGGLE        BIT(0)
>>> +#define CS_TOGGLE        BIT(1)
>>>     #define SE_SPI_WORD_LEN        0x268
>>>   #define WORD_LEN_MSK        GENMASK(9, 0)
