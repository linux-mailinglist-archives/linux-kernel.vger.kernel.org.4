Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A1A7029FA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 12:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240878AbjEOKEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 06:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240673AbjEOKDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 06:03:23 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CF1DA
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 03:03:14 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50bcb4a81ceso22167712a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 03:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684144992; x=1686736992;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kKf8U82vGzXqtgebcF1d8EIvWWa4iFtUuPSm3XBP/rA=;
        b=Leg5iHHkhPp/ZSr+vZKqXNP8XfYkppk0A52+POG/l3CO4t364Xhh+vdRIO1eqjnB+2
         sh2/lAQ7mfWlq8SlyaIRmOwxYL8ZbhrIqUO61ibwPn07WZMw0FLNr7zlCu3cZvVYWphx
         04SDke0XszDA3dDYnsKzUOsxW6AoAz9SVusIxwIv5Dd2k4qFUgC8bdArDY0NjVcGnpGu
         Pp5s6TGSAnCSyG1dUJXiMzDPVUxRk08VhdUex4H1UebZCT2hnmiksyHM9W/gk7JNGw6E
         zGCQj3iX5jqg/47fTnvXe9xkdUtaSQ1kb8n6fZ6XBt0mQ0Kuj1N8/MNLzdS8PtMxl9Xn
         1vDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684144992; x=1686736992;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kKf8U82vGzXqtgebcF1d8EIvWWa4iFtUuPSm3XBP/rA=;
        b=DOw2PkLmrhE/MniynZ9cpRkcmji0Ez0JJJWbFXEqOed8Ilb/8FXiDrocLG/LA5tQPm
         NIgQarPrHNc4vBuvgdw5DCl5HOGxKLE/fU32yyor+KvC+z3Uu6z7ehw3nIbOKLEsVEBf
         jCXkeocOAipSRpExArLHzrutGeCePwkISYN1iaMKZTR7zxZzc76lU+ipM18D+baz6zUH
         MnlNnXZ6zahzB1pHHQSp98ts8/rI94Xc7fPyTLCcHxqPON1AoHHeMLCjvCwswICG2RfJ
         1e/4wE1aTsNMdu9u5G2TVEOhaE9LZeYvvm9opvsElagvd9v+z+3WUt5wOunWEokeQou2
         CM+A==
X-Gm-Message-State: AC+VfDwcOzYdB8goAM7DqjWmj+wqlGm9BrUtc3+/ZaFwmoNFchLjM/7H
        oBNRelQGmEdK0J52pTtUCnKEP2eWf7B/T/UCeqeJdw==
X-Google-Smtp-Source: ACHHUZ4UFirsoIrEs9vXqdf1B+FvmC6aYuPzfrM65ltEpNN/jwt0E+TWIE1PpqRa6MhOd3gUdRm+UA==
X-Received: by 2002:aa7:d88f:0:b0:50b:c1e3:6f02 with SMTP id u15-20020aa7d88f000000b0050bc1e36f02mr26170416edq.21.1684144992592;
        Mon, 15 May 2023 03:03:12 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:6470:25b8:7c2d:1992? ([2a02:810d:15c0:828:6470:25b8:7c2d:1992])
        by smtp.gmail.com with ESMTPSA id u24-20020a056402111800b0050bc4eb9846sm6971044edv.1.2023.05.15.03.03.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 03:03:12 -0700 (PDT)
Message-ID: <df82a955-9de9-5c53-fe59-059273ced83d@linaro.org>
Date:   Mon, 15 May 2023 12:03:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] soc: qcom: rpmh-rsc: drop redundant unsigned >=0
 comparision
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230513112913.176009-1-krzysztof.kozlowski@linaro.org>
 <c6bcbf6b-2fa0-a6bb-a44c-6b0bd84e194f@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c6bcbf6b-2fa0-a6bb-a44c-6b0bd84e194f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2023 11:36, Konrad Dybcio wrote:
> 
> 
> On 13.05.2023 13:29, Krzysztof Kozlowski wrote:
>> Unsigned int "minor" is always >= 0 as reported by Smatch:
>>
>>   drivers/soc/qcom/rpmh-rsc.c:1076 rpmh_rsc_probe() warn: always true condition '(drv->ver.minor >= 0) => (0-u32max >= 0)'
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
> I can see how it made sense from a human POV, but then it still
> does with the right hand side removed..

I would argue that for human it does not make sense. Why checking minor
for >=0? Even if minor ver could be negative (error case?), what would
that mean in that context? major ver == 3 but minor == ERRNO, so we will
have drv->regs == 2.7?

Best regards,
Krzysztof

