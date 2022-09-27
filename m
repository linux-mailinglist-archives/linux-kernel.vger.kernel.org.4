Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8635EC1B3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbiI0LmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiI0LmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:42:06 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D9833E3D
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:42:04 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id a3so15251418lfk.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=+GQR5IFQqnjRQiDNFQ5CKn2gZiB0uB/yzawzfbvOf+Y=;
        b=ERKBfibgVYEQo5koYh5J5HJX9uYGKCU1paa596nwxyhbfn3zJuyOAJjsDKMw7p0nXj
         LIiMOwL5jIgHG22SrVBwGF/K8RC2g627oUJ0C46F1ldvwAISxRb9FIr0mDFRZomdbfP1
         frK/dtgsDL7dHTSssHvROExcYzaNXM8ihH1vQwyo/dtPAwGYTMBEJsYsD7WuFhpys8ti
         s3VSUu2ClAzesrmPC6bM6SXoxgJvzl1xgXROY+5ZkB59hPc/IVEAe6uZYz7xpDafDYYh
         UzMDocNxxGXLq4uy8+M9MgPQslBd949hFHG4cmQ/tyMDgXiMOEDLShaSQI7Wcmsuf8Q/
         l/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+GQR5IFQqnjRQiDNFQ5CKn2gZiB0uB/yzawzfbvOf+Y=;
        b=i/9AE0jReIXJ6QKR+w2inss/R3ZinX+z98Y50xUwm4SMi6zMKDHdmbXfj8XeNGrR5Y
         +HcWQviNS/riaI3/UEhZ94rK3Wi+Rt25W+3QROEMUP7b1QJGeC/IbSJ4uW2uoBKUL2lg
         Wk/H3CfkMigGbQYuEMf9oa+huxIe8pXWKd7fHTaqaMBUDYT9GuQsUBkfVkjZYmClEWjA
         5Cxid4UInY6wxzYRuUONisNGBIV59O/HZIu+e1UmiLoOfk3LCGAiyVEGK51UEOZFp340
         sjBQsmK2JT1Czsp7fHPyye0GTUKVI8EXxZ0LxivYV13TfAFbYF4Sl1yCc0udAbHIC2ph
         bjLA==
X-Gm-Message-State: ACrzQf00k7I+a9QDcvBWKDRllpKkUKp6+1p8QTGgvSH7RFLTUQhNy+C5
        tJVuATISlY5SqeR1twPC7Py2Uw==
X-Google-Smtp-Source: AMsMyM62iqIkSxr/8mX9Xurq+uMCwc9rSBW0pB4Mh3YKwJST/KZg9/fm4oLrF3aBmDVkFRBip6tITw==
X-Received: by 2002:a05:6512:10d3:b0:499:cce2:37a8 with SMTP id k19-20020a05651210d300b00499cce237a8mr10585691lfg.169.1664278923222;
        Tue, 27 Sep 2022 04:42:03 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id bj37-20020a2eaaa5000000b0026be23f24efsm141075ljb.18.2022.09.27.04.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 04:42:02 -0700 (PDT)
Message-ID: <90185f20-f91a-54b9-bb46-d186419b5169@linaro.org>
Date:   Tue, 27 Sep 2022 13:42:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] dt-bindings: firmware: document Qualcomm SM6375 SCM
Content-Language: en-US
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220921001020.55307-1-konrad.dybcio@somainline.org>
 <95fb2bfb-6eb8-012d-88f8-c739d229ef70@linaro.org>
 <8faecd72-0cfd-18eb-d07a-53b3a23ed05a@somainline.org>
 <20220924000932.GA1450@quicinc.com>
 <fcc5bc9f-6b6b-b9ca-45aa-ff2c880a4774@linaro.org>
 <20220926165904.GA17938@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220926165904.GA17938@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2022 18:59, Guru Das Srinagesh wrote:
> On Sep 24 2022 10:17, Krzysztof Kozlowski wrote:
>> On 24/09/2022 02:09, Guru Das Srinagesh wrote:
>>> On Sep 21 2022 20:43, Konrad Dybcio wrote:
>>>> Does it? I did not define this compatible in the driver, so it does
>>>> not consume any clocks.
>>>
>>> The bindings should describe only those compatibles that the driver supports -
>>> that is, both the driver and its bindings should be in sync.
>>
>> That's not entirely true. Bindings describe the hardware in the most
>> complete way we can. Not the driver. Whether driver supports something
>> or not, is not relevant here, except that we don't want to document
>> non-existing things or stuff out of tree.
> 
> Is this only applicable to compatibles or device tree properties in general?

This applies to everything.

> 
>>>
>>> Could you please update the driver with this compatible as well? Let's not
>>> merge this change without that first.
>>
>> This could be even merged without change in the driver. However it's not
>> the case here as driver already supports it, so your request is fulfilled.
> 
> My concern is that if somebody specifies a compatible/device tree property that
> the driver doesn't support, their expectations from adding that change will not
> be met. In addition to having the bindings describe HW in full, I think the
> driver should also be in sync with it for this reason.

As Rob answered, it might be difficult to keep all drivers in all
operating systems, bootloaders and firmware components to be in sync. :)

Best regards,
Krzysztof

