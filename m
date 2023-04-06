Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5F26D9FE0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 20:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240203AbjDFSa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 14:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjDFSaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 14:30:55 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475A7618B
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 11:30:53 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id l17so3582716ejp.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 11:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680805852;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x/9T8X0aJGHx3fxYyKXLVBxSn1+GBp9A84npgBtxwpQ=;
        b=rTJAZMeAk8kQps82Fl2QjyfHxMfDmnwPODIiNEWQF04PsneOdC7VSCbZ4UexBAQ6js
         SwPlM7FXnVBx1GyrIpIAskjllZGuoN1u8WayX9TrPXS9y3CaPQpbKY5CxTtjDzs+Pk/D
         Uhkg/Wr/ZOl7A4PIY4qgY6FPv1RRG2G8lhG5iRVBSEnqE5p9qmSREBHupbthnA6MYsWC
         KcAwmVzgeXUi7XfDE6EVTPY3elVw2K/wGcP/paiCYepU1smywjlhxlUEZFAb/8cKBiNF
         ki8BK9tOVsU6/T1pEKBNjYxilS7F/8wVv3lNhNZ6iSVh6Dv9WFI3o1eyslRjXj3/GPcM
         7bRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680805852;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x/9T8X0aJGHx3fxYyKXLVBxSn1+GBp9A84npgBtxwpQ=;
        b=vS/yoaZOzRTlmisQQlnxNIASS/mFm+F+lArONfYzcdAcSFHhDwiNKkOljs06h2QepY
         8YBrfwtj63W4VoyepJKhqKZthrOcZ6NN/CHqy0nNVB9nqFHJSg1zsYWgHdPftJiaeYmg
         k5M9G87sv30LhLyH/DUs84Ppw5XW3a7Chg/iU7ScaGwCA45LLV27uJQMrXgAb2258XbC
         hmDvvZED61y8sQFzXB1GgQRZCR03myonOVcmCpv0KCU90VimKOiLF6LbGvBsEPx2JLX3
         ca0BSQncO1vMoYn2kdA7yErASm9//OcxGlCCoXMQC0rXYauSkUp0yVW+XU/ercB2/jKA
         /5Ug==
X-Gm-Message-State: AAQBX9dqTTPoxcpdpCtk7vM/MWLiwN8aeiMT/xOv5Sa4ay66Q2vSyvFk
        /dUy11PSIK+BiONmCTOGa3YB2A==
X-Google-Smtp-Source: AKy350bDMKSCylnIPj1Ksoj4IJGQIYTiAs8Q2jfaOhuGPgSR8H22JsRbXfT+Le5UTWJl6pi5F11lzg==
X-Received: by 2002:a17:907:9870:b0:944:18e0:6ef2 with SMTP id ko16-20020a170907987000b0094418e06ef2mr6970633ejc.73.1680805851773;
        Thu, 06 Apr 2023 11:30:51 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id i18-20020a170906251200b009447277c2aasm1124481ejb.39.2023.04.06.11.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 11:30:51 -0700 (PDT)
Message-ID: <6720f61e-550f-6e16-8860-54233a3ea069@linaro.org>
Date:   Thu, 6 Apr 2023 20:30:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 1/2] dt-bindings: net: Convert ATH10K to YAML
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230406-topic-ath10k_bindings-v3-0-00895afc7764@linaro.org>
 <20230406-topic-ath10k_bindings-v3-1-00895afc7764@linaro.org>
 <223892d0-9b1b-9459-dec1-574875f7c1c6@linaro.org>
 <8c818f95-b4a4-658f-701d-3151afdd5179@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8c818f95-b4a4-658f-701d-3151afdd5179@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 20:26, Konrad Dybcio wrote:

>>> +        interrupts:
>>> +          items:
>>> +            - description: CE0
>>> +            - description: CE1
>>> +            - description: CE2
>>> +            - description: CE3
>>> +            - description: CE4
>>> +            - description: CE5
>>> +            - description: CE6
>>> +            - description: CE7
>>> +            - description: CE8
>>> +            - description: CE9
>>> +            - description: CE10
>>> +            - description: CE11
>>
>> What about interrupt-names here? If they are not expected, then just
>> interrupt-names: false
> They obviously wouldn't hurt, but they're unused on the driver side:
> 
> for (i = 0; i < CE_COUNT; i++) {
> 		ret = platform_get_irq(ar_snoc->dev, i);
> 
> So I will forbid them.

Assuming DTS does not have them.

Best regards,
Krzysztof

