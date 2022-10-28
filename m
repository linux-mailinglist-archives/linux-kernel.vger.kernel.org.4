Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46470611B19
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 21:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiJ1TqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 15:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiJ1Tpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 15:45:51 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBCA5B50F
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 12:45:50 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id f8so4142815qkg.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 12:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K7ksD5OAGesupj2q/XJlihyrsrRV0FXKxDbYSlmixcY=;
        b=GMbLCwoELVulpoDUfdY2c5Oidtr0Q2mDZYzsKsi0Mb50lPciaEKXt/dwa0PMQcaP6V
         /uf7Ih55/qvFVQLLUHEboG0EcbvwJa3erb+DHdmqr42gMdUhmZRiDkF45RiCcYXdkBNN
         vyGHwkNLBcqovgezhsQvBTd6qggJVBiRCis96q5uGvUkXfuYiVj+zcyIB+upe6luzoUV
         2VPZuXMHwICL2dyurHHVuvpzeEYWc/Hkhk6GJNVYf7O+p1xfxth6eSMOFbo80062bd2n
         TkEFCcpFEkGKCGF50gPn9TOrAwdfe0ZEk7ymN8CP8sD3Ds83pgttoTjfKlmkgVmS+N9L
         nPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K7ksD5OAGesupj2q/XJlihyrsrRV0FXKxDbYSlmixcY=;
        b=YLiQfSYjmb79E2ePAc7Fm1QWzRDDFic1+K8nX3sE48/xqUYecP3EtyeX/lXBNxtZFN
         tO5WWUpPdK1UCLiqgMiS3WZlxtuTwD+FgJWu+GtLvT94o+oEqQs2K/yEINFCHIPLMurp
         YJdEzsFmr3oNntAQRaj6lzWM+TaP0IGb0RysA3okctDY6iS/dlPmBsDYs1b7wFOPEkj8
         SMoKEMFVwMSQ+iSuBPPQMrJB1uXaMt8l2klWotVEtinvjrCIkA9UuF0P+2LYZtQAu4bG
         0Er7pNm349B5INUzaxYkTWe+l0b4EHlszCRYV37PvqP5IzTCqewIJ16L03NUBZtGQ9LP
         xhdQ==
X-Gm-Message-State: ACrzQf1QZ6jf2n/fNcji4+JE8LiATgpiU1e3VVAuZmOdbmszE6BbIhax
        8LTSUNC9YBQC1Lt+SKk9ZWICUw==
X-Google-Smtp-Source: AMsMyM55GEMVMF1srCOUQORSp0UYryYV3Ubolr2dJzAddzVtL+bSj3gMTzd1NTTw+XMQunZCATLOdQ==
X-Received: by 2002:a05:620a:6ca:b0:6ec:553a:cf33 with SMTP id 10-20020a05620a06ca00b006ec553acf33mr756670qky.132.1666986349347;
        Fri, 28 Oct 2022 12:45:49 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id u6-20020a05622a010600b0039cc64bcb53sm2802673qtw.27.2022.10.28.12.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 12:45:48 -0700 (PDT)
Message-ID: <89a32ecf-2d9e-c50d-4da1-eb24e8f26d2f@linaro.org>
Date:   Fri, 28 Oct 2022 15:45:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 1/2] ASoC: mediatek: dt-bindings: modify machine
 bindings for two MICs case
Content-Language: en-US
To:     Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        "chunxu . li" <chunxu.li@mediatek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org
References: <20221028172215.1471235-1-ajye_huang@compal.corp-partner.google.com>
 <20221028172215.1471235-2-ajye_huang@compal.corp-partner.google.com>
 <628ac98c-0755-e6f6-e010-f1e772c4b71a@linaro.org>
 <CALprXBY8FUc_w=JO3bp9m1e=1d5Fcvrou_En1JG8Hx0BYuETKw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CALprXBY8FUc_w=JO3bp9m1e=1d5Fcvrou_En1JG8Hx0BYuETKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/2022 14:26, Ajye Huang wrote:
> On Sat, Oct 29, 2022 at 1:58 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> 
> 
>>>
>>> +  dmic-gpios:
>>> +    maxItems: 1
>>> +    description: GPIO for switching between DMICs
>>
>> Switching how? Enabling? What is the meaning of each GPIO pin value?
>>
> I think I should add more like an example,
>   description: dmic-gpios optional prop for switching between two DMICs.
>                     Ex, the GPIO can control a MUX HW component to
>                     select dmic clk and data form a Front or Rear dmic.
> 
> Do you agree with that or have other suggestions? If do, I will send
> the v3 patch for you to check, thanks

Sounds better.

Best regards,
Krzysztof

