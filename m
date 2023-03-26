Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45576C9373
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 11:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjCZJWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 05:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjCZJWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 05:22:24 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B80C93F7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 02:22:23 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x3so24199381edb.10
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 02:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679822542;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5rXoV9ZT/umKedJfUsdr0K9co5AscuT4z2LTYT9lVJE=;
        b=hYCTtRTQIwtNTBhlkzPyuFFAPazi45fgs2gh50HZ0mVZH3WeBAIUhsM3JvkTriUX0q
         gEs+Hc+UXyBAr57Mwt+AwZ6i+yvzBLvDvMgjpyIaDswBAncOimGd8ldcdooTX3qw6spO
         AXymcTg1sLL/T1Jc19eSPapIJIVObgxB8bNp0+yNwOJGdsCKSAvGFpY/XVeYI8SnrMSH
         R0sb/nvRVPxrHg2OGTrG2zQ22HpPzaDqi2dMh9K10MVzLqo8UJGlqJzzp+xtVhyNI4CY
         higkRFpYE6RvTrHWqo5f9qUEtW/HlImSaYrJAbSt8hW0r5ePGrZXl0aQCav2zEOgJuCW
         yccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679822542;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5rXoV9ZT/umKedJfUsdr0K9co5AscuT4z2LTYT9lVJE=;
        b=BvUAzp2lG3vXk8FDa4bzje8uZ2YpF1r4Tz08rv0M3BoT+NNkTwcU2bFiSvM46NUzEx
         KOWUEXyekvgleQOkqNjmjP7lk2pSfBK6lmzmcuzQSeUPbSwQPgu7WHyfYobZY5TOPzZ1
         QPIqhQMDbqEuX53gZKJS7QGOmW1XDxCrecq06hKDemLLMZVrdHXPwpsLvD0OWk8j0pOc
         EqEMXFAVvtJFapULChM2BQN9AyrU3NBpIxkcLswNxWnNRIwagDTWhfWw/mXsCKJNENZX
         FXoHTyPRfn0bXhs5lFLUpIxZEi4pCvXeCAhrdP0awApIkru6GGc9vYtnZqlfg7IgEZxH
         2I4A==
X-Gm-Message-State: AAQBX9dCW71cAqeoFKnXN2+A7FN4U7OpiNTfuNiYXKi9IS9Klp8tDB8T
        VPob03bvvwBRGPzmSIXw8UmF2Q==
X-Google-Smtp-Source: AKy350ZEeKY6w6K1zzH/dW/xivR15vW3hQd6CLYZegluO5Sbjosmz2HaeiqG5cUr1ggyvwzbv6IOqQ==
X-Received: by 2002:aa7:c7cf:0:b0:500:50f6:dd27 with SMTP id o15-20020aa7c7cf000000b0050050f6dd27mr7533927eds.26.1679822542121;
        Sun, 26 Mar 2023 02:22:22 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:6cac:926d:a4f2:aa09? ([2a02:810d:15c0:828:6cac:926d:a4f2:aa09])
        by smtp.gmail.com with ESMTPSA id xi3-20020a170906dac300b009445d6213c0sm308958ejb.75.2023.03.26.02.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 02:22:21 -0700 (PDT)
Message-ID: <c6429b89-bdf1-a601-7cc2-a6cbb566fecd@linaro.org>
Date:   Sun, 26 Mar 2023 11:22:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] arm64: dts: qcom: sdm630: move DSI opp-table out of
 soc node
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230326091605.18908-1-krzysztof.kozlowski@linaro.org>
 <CAA8EJpqR-QisyWEHE83oFbXt8wUcn2Ofd4W6UwFmkYzGD18N9Q@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAA8EJpqR-QisyWEHE83oFbXt8wUcn2Ofd4W6UwFmkYzGD18N9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2023 11:21, Dmitry Baryshkov wrote:
> On Sun, 26 Mar 2023 at 12:16, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> The soc node is supposed to have only device nodes with MMIO addresses,
>> so move the DSI OPP out of it (it is used also by second DSI1 on
>> SDM660):
> 
> This raises a question: would it make sense to add /opps to handle all
> opp tables?

We didn't add it to any other cases like this (and we already fixed all
other boards), so why now? We can but it is a bit late for it.

Best regards,
Krzysztof

