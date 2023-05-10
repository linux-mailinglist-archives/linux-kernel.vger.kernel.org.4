Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6F26FD86A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236120AbjEJHm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235765AbjEJHmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:42:54 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE75F26A2
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 00:42:52 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50bc040c7b8so10529534a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 00:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683704571; x=1686296571;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LSvYi8ezsl6O/bO/+mRMMF1WJ2AcmYFcBwK0eCs1+B0=;
        b=V8UM4jVtflYukiqfJ9daE7lswh754lFdgNUeJFumYN1MiTcH0SS1tuszj9z6OqTP5b
         A52iwYjsInfhvrPyXZ4alUPGF4Q09JHJTVs3oTSEndjj53IGVxAa7P+UlVfN+lAk1LgW
         YWXH6QfQ1bzUBh90SIxOfUMirK2FY2iOQzgqlLlIwtAsnkOYm4N0M8NOUHOfD54DcBjY
         ZdZc68E1E6SJJP0orv0ToU97w7MgeDKLrUan+VEmzqUEsP/WqqyOAvACYrIlbRRjY3TT
         q5rKnDlmNTm0GxS5mkr+NxSTP0ad/7bEQHEOS3/84+G7pKQgWaSmsTV3oHdwYF0kQVrK
         3DAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683704571; x=1686296571;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LSvYi8ezsl6O/bO/+mRMMF1WJ2AcmYFcBwK0eCs1+B0=;
        b=eYQKysdBEyaSrz93kTwaUV8kPZKr8If4XfxDlGLjZiBQADWdow4h53El8OL1sZD3ka
         D+Q34pmdf+kf1IIJjzxWOcUeRZn5cbYEwp6ZWhoy0qEc7pDMyv+GZ6n518b5ueslLmbJ
         +Fwv1LgDbkOios9a1KH8FJkinEKO3NTszy3NHeKY9v7W5E5hjXBBDLINfT4seJ6U/vel
         c3XW0aZvnIEYbge1A4qpoObGJTLU+0ksU4cwHKlyryfgx0pj2/WH6Nj5vamW02F0jNfZ
         R2eT/GfNcP9S66EenisFfSulIv/VUftEqDpxe1lrqyk7Xa8UPZa2iMbCkzKS4wKfJjkY
         0bKA==
X-Gm-Message-State: AC+VfDy1JF7K8g+b1Bx1WuYtFRT6g/pheSfGpjrDEkUdkBSI6NJPkanM
        36Qs+zsVSyTIQMmPNTF/1t4BgA==
X-Google-Smtp-Source: ACHHUZ58UJ91o2BbbMuSuhkpixMMpyByW/Dt7rOLTp6FTQzWMvixrA/vIOCJ6JTen0nmU64qgRX5Lg==
X-Received: by 2002:aa7:c68c:0:b0:50b:d495:106c with SMTP id n12-20020aa7c68c000000b0050bd495106cmr13720697edq.8.1683704571368;
        Wed, 10 May 2023 00:42:51 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c175:a0f9:6928:8c9d? ([2a02:810d:15c0:828:c175:a0f9:6928:8c9d])
        by smtp.gmail.com with ESMTPSA id s24-20020aa7d798000000b0050bc37ff74asm1626913edq.44.2023.05.10.00.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 00:42:50 -0700 (PDT)
Message-ID: <f40daf65-ac65-5df6-828b-c5ded00c4c8a@linaro.org>
Date:   Wed, 10 May 2023 09:42:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] ASoC: dt-bindings: Adjust #sound-dai-cells on TI's
 single-DAI codecs
Content-Language: en-US
To:     =?UTF-8?Q?Martin_Povi=c5=a1er?= <povik+lin@cutebit.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
        Shi Fu <shifu0704@thundersoft.com>,
        Shenghao Ding <shenghao-ding@ti.com>, kevin-lu@ti.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
References: <20230509153412.62847-1-povik+lin@cutebit.org>
 <baf338a7-1e63-4842-32a1-8f63f850bd2d@linaro.org>
 <A8647EF5-566A-4B99-9020-772810CB2BF7@cutebit.org>
 <F12DE31C-E167-47F0-BAE0-C09538C5C3C8@cutebit.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <F12DE31C-E167-47F0-BAE0-C09538C5C3C8@cutebit.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2023 09:33, Martin Povišer wrote:
> 
>> On 10. 5. 2023, at 9:30, Martin Povišer <povik+lin@cutebit.org> wrote:
>>
>>> On 10. 5. 2023, at 9:17, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>> On 09/05/2023 17:34, Martin Povišer wrote:
>>>> A bunch of TI's codecs have binding schemas which force #sound-dai-cells
>>>> to one despite those codecs only having a single DAI. Allow for bindings
>>>> with zero DAI cells and deprecate the former non-zero value.
>>>>
>>>> Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
>>>> ---
> 
>>>>  '#sound-dai-cells':
>>>> -    const: 1
>>>> +    # The codec has a single DAI, the #sound-dai-cells=<1>; case is left in for backward
>>>> +    # compatibility but is deprecated.
>>>> +    enum: [0, 1]
>>>
>>> Does it? I see playback and capture.
>>
>> I think so. Playback and capture are not separate DAIs.
>>
>> Martin
> 
> I double checked, I am pretty sure. There’s a single snd_soc_dai_driver,
> which becomes a single DAI.

Indeed, I see now one entry... Ehh... -ENOTENOUGHCOFFEE

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

