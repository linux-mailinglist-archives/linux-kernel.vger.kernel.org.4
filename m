Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE07702A01
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 12:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240996AbjEOKFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 06:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241217AbjEOKFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 06:05:13 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C26D2713
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 03:04:27 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2ac8cc8829fso118003611fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 03:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684145064; x=1686737064;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KxrM2kkTlI57HpsOdAUD12smB/KhTYxaGhBNIwmCl6s=;
        b=Wph6tLIeb7qIkq1vDskAhPNWxniqXrEnzEHdmGRxynD3fChA0v7l+E+VcpH9fdlPPp
         9FRpIzT/RLW1+mxbVj6JUbEv0dcEzUPEZVjsZKGLK1d3A8a1mRrIKdwgjJeur6+GnX3V
         9RIJNrruC56lqquqerDH1wCjZ2bEt/hC+vOA7LwjNpK/E2jVKiKbO08XN9W3oB4LsuW3
         jjgWlGLwVWgQ1jig2jgqOHsi6xoSZ+S4m/P5DZ6Zs1TpvGY1sDASBrzzBlseknFjpfx4
         /ZU4XdXmLdyhGmUTS7EislPHjcuahGqEe0o5AJILHL9qODqgxWQPgJkqU0qx/+l1lX1F
         HtqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684145064; x=1686737064;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KxrM2kkTlI57HpsOdAUD12smB/KhTYxaGhBNIwmCl6s=;
        b=eq6ZKOpl5BbPw704+7qmTjVqppyuhduDoWkt0G/p2wz9H+9GCqFfYR95LcDtqB/JRU
         UX7FbOrLEp28gxBqdxooXbCpXOHNH+mcc8YHctjHocDNYVuQ14nRlxhjFmOyas4U9L5T
         22h2EJnli0pINkafZsWi0TeqK1E8UKz52l2ekB7L3Btq0DR0VbOj3eTE6JdvkYceBlLm
         q2Ip65UG8Awnpf3MC9Y0wAbPeVUe4vy3mlo+E+qbyh9i9WOol1ol8xqsbfRtVLRss+Y4
         QTlC1j1VY4n1OdEt2IWg9CDkBgbl3Ngr+gGkEIPqDcb1xEo4TWFJt5tSWKhRsV9hKADq
         0R3Q==
X-Gm-Message-State: AC+VfDyMKdXOB6Ag7x/iEP1GZCqtyWbZ+F1TyI7nrP5KnWTzY2HBUrgL
        pVHWaIl6pWn8Lok1tXXkQquiLA==
X-Google-Smtp-Source: ACHHUZ58gHyFeZh/4ypWE5HjND53MM46JwEfAFYUu43QztBVc6abPKjvZwDFe0TOWT+xUSrBdp4qmA==
X-Received: by 2002:a2e:870d:0:b0:2a8:e480:a3c8 with SMTP id m13-20020a2e870d000000b002a8e480a3c8mr6860380lji.44.1684145064252;
        Mon, 15 May 2023 03:04:24 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id v4-20020a197404000000b004f01ae1e63esm2543124lfe.272.2023.05.15.03.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 03:04:23 -0700 (PDT)
Message-ID: <0a031f87-ba9a-120f-6331-a15872e23e73@linaro.org>
Date:   Mon, 15 May 2023 12:04:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] soc: qcom: rpmh-rsc: drop redundant unsigned >=0
 comparision
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230513112913.176009-1-krzysztof.kozlowski@linaro.org>
 <c6bcbf6b-2fa0-a6bb-a44c-6b0bd84e194f@linaro.org>
 <df82a955-9de9-5c53-fe59-059273ced83d@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <df82a955-9de9-5c53-fe59-059273ced83d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.05.2023 12:03, Krzysztof Kozlowski wrote:
> On 15/05/2023 11:36, Konrad Dybcio wrote:
>>
>>
>> On 13.05.2023 13:29, Krzysztof Kozlowski wrote:
>>> Unsigned int "minor" is always >= 0 as reported by Smatch:
>>>
>>>   drivers/soc/qcom/rpmh-rsc.c:1076 rpmh_rsc_probe() warn: always true condition '(drv->ver.minor >= 0) => (0-u32max >= 0)'
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>> I can see how it made sense from a human POV, but then it still
>> does with the right hand side removed..
> 
> I would argue that for human it does not make sense. Why checking minor
> for >=0? Even if minor ver could be negative (error case?), what would
> that mean in that context? major ver == 3 but minor == ERRNO, so we will
> have drv->regs == 2.7?
I'd say that's just a direct natural-to-computer-language translation of
"above version 3.0", but yeah it does not really make sense to check
for negative versions..

Konrad
> 
> Best regards,
> Krzysztof
> 
