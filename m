Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0664960002F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 17:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJPPAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 11:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiJPPAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 11:00:33 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3023A32EFA
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 08:00:30 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id de14so6155528qvb.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 08:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MhyJ9kSsGoqkricVuEjx2rUhNBR6iYWU2ibxeNvXxZo=;
        b=S6/ESCfheAAmuIByvcb4pa8bOY/zIsbiCOMrtaVy7qew2upsh2lHpGfC0+gxa/aw6e
         1PAtQ+5eKEDW7WgpM+XqVwDu2Xsm2KgIfpEGH7OGacT4zn2rQq6XqP0rcTdrbU2ivZRq
         qiPgmdUohraDTMN5o++ZXQcrurGVQzILchawV6lzaJ6pmRX5kdavv46mL1kIK422196g
         S4y4yX/A/CXUQtX+SUYPjzjmakWLihrZ+k6xmthEGaCzFUrd2Uo7jt2d1q/L06QsW7M+
         tlIGeJyv5Fy9DY8PlzDYU53etbgSKKVwJNjl32UGgblV+3km8rtILmyVnB5znCYpOJWX
         EczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MhyJ9kSsGoqkricVuEjx2rUhNBR6iYWU2ibxeNvXxZo=;
        b=pXjtoACkSeXzVC9lR8PSw4GPUK6VxwoHQsSTZUHW14eeLUEK5UCl61XrrrmHdOrOgI
         keFvPXzT3i/7ymicG2flD+OGFBjdANEMHAX1U5iBeq6iGRdvbbzo15yGhINvSeasc7xj
         GbQbdo5CJBSHNiRGB+tR1obgHoJyvWOxi8ftosNZ5x5A8kS0HDjqHmU3fC3THTnpfixI
         l1iwy057V1lwnyqL4FpD6OtgYDzh9+YoLS0INwTTRO5FjXIOkJaJVRIxZXUwtLLemjIY
         tybVGVv349PcppzIVFnP2iEgYtyIpRLSejIklSEhtUHoQaoQCsqiGmQog2z2D2cb1AML
         3qkQ==
X-Gm-Message-State: ACrzQf2BPOjwS7kKEIPAJBYr+LrtbZsl2JiT39J0Ljzrwo8PP18yr59D
        nbNOj83JCuCC5iFbSRC+h5/UAQ==
X-Google-Smtp-Source: AMsMyM4WMEkymJd2edJSMuAyGF4z+MDhJjyqJl83lqmGJWh8L+BFduBreQBbJIJjFV1Ywvet4FDkxw==
X-Received: by 2002:a0c:f148:0:b0:4b1:4996:13d9 with SMTP id y8-20020a0cf148000000b004b1499613d9mr5364648qvl.100.1665932429306;
        Sun, 16 Oct 2022 08:00:29 -0700 (PDT)
Received: from ?IPV6:2601:42:0:3450:9b13:d679:7b5b:6921? ([2601:42:0:3450:9b13:d679:7b5b:6921])
        by smtp.gmail.com with ESMTPSA id cn4-20020a05622a248400b00304fe5247bfsm6019756qtb.36.2022.10.16.08.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 08:00:27 -0700 (PDT)
Message-ID: <08a98921-592f-fe70-1591-367f9c4063b6@linaro.org>
Date:   Sun, 16 Oct 2022 11:00:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v3 1/3] dt-bindings: touchscreen: add Himax hx83112b
 bindings
Content-Language: en-US
To:     Job Noorman <job@noorman.info>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Luca Weiss <luca@z3ntu.xyz>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221016102756.40345-1-job@noorman.info>
 <20221016102756.40345-2-job@noorman.info>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221016102756.40345-2-job@noorman.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/2022 06:27, Job Noorman wrote:
> This patch adds device tree bindings for Himax 83112b touchscreen
> devices.
> 
> Signed-off-by: Job Noorman <job@noorman.info>

You got here tag from Rob, so keep it. The change was minor so did not
justify tag-drop.

Best regards,
Krzysztof

