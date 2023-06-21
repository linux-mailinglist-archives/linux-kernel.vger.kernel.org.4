Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4920737B08
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 08:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjFUGGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjFUGF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:05:58 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C54D1738
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:05:55 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51a4088c4ebso5375097a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687327553; x=1689919553;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rl1Qby0u21Iv2rmR9JLr9d/ig7PQZex8yz2AvojYw5k=;
        b=f6cTeKkXAVR90n3ajc6KdT0AvLuCf7rE8O5SWg5HYFe4r6daBoExzrCHY4k9VjtLne
         35eHIix5pq4cczk28QvhmMRZJFIdJjVFFA+fbTmqniBmYr/JJkSTMDFiIiIvjgImKzjw
         ipRLeCzskx28qwtDx+IYK8qMVOm55oORpv9rjj5k5RMH15WVHkOPbpCWXX2sOFcskKLH
         AJ+IKcPSB1ft1XunPFSYCwEo15fDILZw0mmOOEP9V3o+vh/Op91jtrB/s0I5TKgOUbwu
         TUBxhNZIvJbFnJF1WwjWwXb7PGxhaxpvQFmv4JkQfF15/GnSDkg+0bJXgnZaDhlsKPjf
         grXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687327553; x=1689919553;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rl1Qby0u21Iv2rmR9JLr9d/ig7PQZex8yz2AvojYw5k=;
        b=aCRhV9rrty843NlwTMLRYdtzP2Rw4lOfjeabDEtgOEfpn+NI4syxI9lfMyCHOCOQp3
         S9p/9Bb/8vxsGlzn2CUcwjqktXADbPdCnecRqpI3EgbDXmqN8RT4Hm3F5cbfJoQQIPui
         n1I4fqFbZtBHVuzOuIuuqKj81hmXiksikQA3ZhonJZYdQHF5z0NH3UKjmyY8ZrM81J1a
         2xRkqPM/IZKwNvEq6IpwXKX9dQvclnubCBHBvgupDOHjNSNIhvsZU9cLl9lvzxLDs12D
         bcr4drg7g9hKJWe33FmwoPEmcXWYjQsdq3XODywnp+SRwYE7L6Cic/LstIvCDPnqWezv
         4TOw==
X-Gm-Message-State: AC+VfDxMweQOoOjIajLQrEdfQDJgRArWIeyZjpIQ/vmpQ9bci3UEnLMy
        mVu1BTaGKIrrSvvcRVMifzH6ig==
X-Google-Smtp-Source: ACHHUZ5LvRIbZZcBlOt6s5zzU9Jeyo74a4+RXayHEeu5KUpcAefp32b6yjQerwjo87A40cQ8FOnSwA==
X-Received: by 2002:aa7:db89:0:b0:51a:265a:8fca with SMTP id u9-20020aa7db89000000b0051a265a8fcamr8538702edt.27.1687327553420;
        Tue, 20 Jun 2023 23:05:53 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id g25-20020a056402181900b00515c8024cb9sm2074751edy.55.2023.06.20.23.05.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 23:05:52 -0700 (PDT)
Message-ID: <74788626-231c-ccfb-ecc8-87dbc6a4ecea@linaro.org>
Date:   Wed, 21 Jun 2023 08:05:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next] dt-bindings: net: bluetooth: qualcomm: document
 VDD_CH1
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230617165716.279857-1-krzysztof.kozlowski@linaro.org>
 <20230620111456.48aae53c@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230620111456.48aae53c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2023 20:14, Jakub Kicinski wrote:
> On Sat, 17 Jun 2023 18:57:16 +0200 Krzysztof Kozlowski wrote:
>> WCN3990 comes with two chains - CH0 and CH1 - where each takes VDD
>> regulator.  It seems VDD_CH1 is optional (Linux driver does not care
>> about it), so document it to fix dtbs_check warnings like:
>>
>>   sdm850-lenovo-yoga-c630.dtb: bluetooth: 'vddch1-supply' does not match any of the regexes: 'pinctrl-[0-9]+'
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Hi Luiz, I don't see you CCed here, should we take it directly 
> to net-next?

Bluetooth bindings are not part of BLUETOOTH entry, so obviously no Cc
for bluetooth maintainers. I'll send a patch to update maintainers.

Best regards,
Krzysztof

