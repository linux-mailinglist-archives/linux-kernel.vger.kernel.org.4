Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D607E6C93B6
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 12:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjCZKNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 06:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCZKNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 06:13:16 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E3040C0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 03:13:13 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id eg48so24372839edb.13
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 03:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679825592;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MOh4lC4EpmD6D3IsSXbrUjZG6ycDZwmCNEwAzeoH1FQ=;
        b=xe3VuwN4Ew16g8dK3fS72dD7DoMqWCfpxH2cYkvrulfZLAAFccoNSAP1wDTjJPg7so
         2miZ3d/n6zwx2aLARZVLLw3X4gRqznCFw7Rllq560862ZmkDgfwdfFUO86qin8uFv/td
         c+Ttf5lrMlasAnGarYO36lM3pbJBpwuakPbhTyzb8m3TPfTx53/SFLELNt4yPCh8lFeI
         nD9inVGSNGPnTtfuoqr+ki32H+M03jUAMMJpUmPSnv20ijJ/OoEq/QD8zQ1Ex2X/QtrN
         k8jJXDO2ICGxbC30kijnumArQx+wd5oMJgNUOcUBoSra6fap5VFIzYaZStOsGpPPQbTR
         4GoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679825592;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MOh4lC4EpmD6D3IsSXbrUjZG6ycDZwmCNEwAzeoH1FQ=;
        b=TiRSE1i5FfXc7E3Un2oU6nfTw1LExfUxdMmA7I0SNr2hNn8DCR26C+K+AXr0h3+MS7
         86a45JDHHZ0yrxawT/3T92Zdeg9SDJxlHLZA/z9clu8u9QZO0j2NADjHBZDdJHdvosmS
         PzSdQT13LEW2qubrFcO7VyC9HiManVL523LRTbTcOYnG2x3ri54P7gYFi/FE1Y1cRkfz
         MHv2lDCNV6SpSuuPx5f/ty84rfZBq57Nqdf7MI3NlhQXg04+M9Fgi8HUAOBi/ig9v98E
         RULI2XnDQtuqVzooIMU7BPUtdPDJ4C+Zf6M3i9KsFUG4/IJKpEGeg5HyWLLci7OBNz5k
         p+fg==
X-Gm-Message-State: AAQBX9crWQQAfD14lW8YGRJ//VzYXcKWl0LT5R3aW/tVem8q9VJmDm9N
        5G7vuzVIQpjbQtQKoeX0F/baxQ==
X-Google-Smtp-Source: AKy350b/CpcoRKdk5/rSN0V752Q+031uCPvdlGTc1KTIxeFnGCZF//nkNLeyvGT5IiBmK3/EG7pg4g==
X-Received: by 2002:aa7:d291:0:b0:4fb:59bb:ce7c with SMTP id w17-20020aa7d291000000b004fb59bbce7cmr8324123edq.32.1679825591993;
        Sun, 26 Mar 2023 03:13:11 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:6cac:926d:a4f2:aa09? ([2a02:810d:15c0:828:6cac:926d:a4f2:aa09])
        by smtp.gmail.com with ESMTPSA id r3-20020a50aac3000000b004fccef39ec9sm13384888edc.70.2023.03.26.03.13.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 03:13:11 -0700 (PDT)
Message-ID: <83b657c3-5a78-1c81-fea5-5679a30bd517@linaro.org>
Date:   Sun, 26 Mar 2023 12:13:10 +0200
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
 <c6429b89-bdf1-a601-7cc2-a6cbb566fecd@linaro.org>
 <CAA8EJppPHVZbseXFx8g+m9PxgODuenLEBHeDT3z6MojzVALKqA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAA8EJppPHVZbseXFx8g+m9PxgODuenLEBHeDT3z6MojzVALKqA@mail.gmail.com>
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

On 26/03/2023 12:03, Dmitry Baryshkov wrote:
> On Sun, 26 Mar 2023 at 12:22, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 26/03/2023 11:21, Dmitry Baryshkov wrote:
>>> On Sun, 26 Mar 2023 at 12:16, Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> The soc node is supposed to have only device nodes with MMIO addresses,
>>>> so move the DSI OPP out of it (it is used also by second DSI1 on
>>>> SDM660):
>>>
>>> This raises a question: would it make sense to add /opps to handle all
>>> opp tables?
>>
>> We didn't add it to any other cases like this (and we already fixed all
>> other boards), so why now? We can but it is a bit late for it.
> 
> Because nobody expressed this idea beforehand? I'm not insisting here,
> you have a better understanding of DT. Just wondering if it makes
> sense.

It will not change much of ordering - all nodes will be close to each
other anyway (opp-table-XYZ), thus is rather a matter of readability and
subjective preference. No other platforms have "opps" or "opp-tables".

Best regards,
Krzysztof

