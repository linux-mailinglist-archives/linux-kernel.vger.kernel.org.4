Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD57C6B8BB6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 08:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjCNHHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 03:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjCNHHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 03:07:48 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C44D87DBA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 00:07:47 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id cn21so27800952edb.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 00:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678777665;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IVAcufTRZR/UrpWh0Yo3nuXJUv0V6eRDyvqxNIliP/s=;
        b=GJAk9oFOx17JjJhMK0VsyGlGOhzG5zrPu5786NWzAXJF+WD0av4bJFhFMofPUGPyb8
         y4/H3aCyO9munJ5lNTrut2Wo7llujA/nsvm9CeyXmZLaRf8OOtGNUsIKGHJV/9E+LNdr
         AGeK58gT7Uw69zaiAcQjmKZg2ukXwq0hB2OjB+DzK44UenTomuGPRXSWWv97RYXWTgpL
         3PYqlC6Aw8kH0kcwD38+zj+tszCCi5XCcCNGBPa29jxN81GD30MfzW9KMPsNm+852I9I
         W/nt+GjI57xO/chgQgxVRNMMzhNYfDygmy55k/8rgQhmeunwGh4Kk9Xo+QOtzwym/9UJ
         veMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678777665;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IVAcufTRZR/UrpWh0Yo3nuXJUv0V6eRDyvqxNIliP/s=;
        b=mKwf9gMIBo5IS0G17FOshlZ90v7OseAXGXkqE2mPOTEP75Xb2fOxTeBF07Gmdb874E
         wOa5Tj63i8/VjJcPmgNGujtPpvgU1e35/WMLdUDDatCOmDa4VIvwfPX57H8tESXUwoRe
         icC4o8gLliSosRBaHWdcoFoN9e42OlbghXRou3hdI5xQPE4jw8OflMPMo1OCEUVm+5fM
         ya56Q1UjZK86yvGj4rqYJ/o1VFINotuPAZXvNWb5pQU0AnAS3EqeHPaw+67SGIq3//E/
         t+8MZRrGrQ3nVFBLG0AjceWQB8i/nNaPIw/v75uyeUcf1Ck9Aoub9MXF0TqNd/ibyYD9
         YGZg==
X-Gm-Message-State: AO0yUKXrFTCKS7PFgW919dZ95QYX1r6hHIONq7mr1xoHTZ0mtQ2oFYUj
        k14TLwDavHiPE+OMk10v/1wODw==
X-Google-Smtp-Source: AK7set9C2pRU6DKgdYfjPhurLaPzk2irJh99O24vkrOtwEJPJ5TuAqqyq3dScDEiQ9Vj1hBE+V3eEA==
X-Received: by 2002:a17:906:3fd2:b0:885:a62c:5a5c with SMTP id k18-20020a1709063fd200b00885a62c5a5cmr1259375ejj.46.1678777665542;
        Tue, 14 Mar 2023 00:07:45 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:6932:5570:6254:9edd? ([2a02:810d:15c0:828:6932:5570:6254:9edd])
        by smtp.gmail.com with ESMTPSA id w13-20020a1709060a0d00b0092707833d08sm695463ejf.70.2023.03.14.00.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 00:07:45 -0700 (PDT)
Message-ID: <294488c6-098b-cefc-7c56-cb0d7beeb4e7@linaro.org>
Date:   Tue, 14 Mar 2023 08:07:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/3] mailbox: qcom-apcs-ipc: drop the IPQ8074 and IPQ5332
 compatible
Content-Language: en-US
To:     Kathiravan T <quic_kathirav@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        jassisinghbrar@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230314041515.15883-1-quic_kathirav@quicinc.com>
 <20230314041515.15883-3-quic_kathirav@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230314041515.15883-3-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2023 05:15, Kathiravan T wrote:
> Since the IPQ8074 and IPQ5332 mailbox are compatible with IPQ6018, we can
> use the compatible fallback to IPQ6018. With that, we can drop the
> IPQ8074 and IPQ5332 compatible references, as well we don't bloat the
> of_device_id table.
> 
> Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

NAK. Breaks ABI and duplicates what I already sent (which you saw since
you took my patches from my thread).

https://lore.kernel.org/all/20230202161856.385825-4-krzysztof.kozlowski@linaro.org/


Best regards,
Krzysztof

