Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6097A721E10
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 08:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjFEGZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 02:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjFEGZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 02:25:33 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC09DC
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 23:25:32 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51458e3af68so6634429a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 23:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685946331; x=1688538331;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o226GIM7TNLn/fW/l5qPMbx7gXL+g0NzLxiZx3vJfOY=;
        b=BfV89KS7ZQpgta8igkdPdZauvLKsZGwO8BbgxPH+n4tZgvMyPSx9AKAe1+fdvkQFOp
         sNJF3snUKGHppRwRJvHGXjY5IZiyjnYYGqR8QJLiOb8rBIUkDOJ4p4XFu5xgNMdYCQOn
         03Zz6CPRnVXxvihWKfhUo/LuPuCfkiYYXymbUaMgdLzjVmYP7KsfAUgYeMFldgVlvsNY
         vYpdSILuwDbFkGIdfIIClK5d5NXDFvagmy9ZzsdrJuzSZfB2Ej98xU9Uy1ofsoBLx4Dx
         IeAThQsPU+FbObMNVu2pMHPSRTFnreWHveU1GfXjP8efTp5IWDNveWXPKe1+5IOC9NAb
         uVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685946331; x=1688538331;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o226GIM7TNLn/fW/l5qPMbx7gXL+g0NzLxiZx3vJfOY=;
        b=FaY4HccxbSFPpLNjGM1W6JNXPufItd5X698sGYHmhSktQONt9Gp7h6e+P04hZ/TNo+
         3EqGoGoRJjK8w/C/W/7Nyze3zSi4m0rqHOIDRwHtgpuHOQ3eHsCH4dh7+BYrjJbYjQ/r
         ZV21QD34uZfkpNtxlztCW4gHhoGzyL4birPKNNFyd+ofHFIArXguXs27uF8xIWkxBe/l
         iX1NpHgkq78tkIb7kfePy06TVL8u915sspkR5/SK1iFjxG3WnNTqblmvl4f4hKryD9EK
         4GGtoalnc6Hxwnl8Y5z5cZwNzPpExCwQt/mJZ833FdSufFs/R4br6bnNiPiqB2Pl8BMi
         BnNg==
X-Gm-Message-State: AC+VfDycav/1on1UmtjgY0K4uGAgIeNSBGHsEItV8tIy4RZ40vjfTd15
        hLNUP6N0KXfDrT/ccI0GpJMpDA==
X-Google-Smtp-Source: ACHHUZ46Jq0uyk0YvooixC7rES62lNsgI/qtIj1ss5urREstlbOH1QiLHaLq1qHGw55tISA2Kewiyg==
X-Received: by 2002:aa7:c64d:0:b0:515:3103:631e with SMTP id z13-20020aa7c64d000000b005153103631emr8187170edr.25.1685946330881;
        Sun, 04 Jun 2023 23:25:30 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id b11-20020a05640202cb00b005147f604965sm3563772edx.24.2023.06.04.23.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jun 2023 23:25:30 -0700 (PDT)
Message-ID: <9e2461f8-bb11-bac3-a983-5197bd1ea3ba@linaro.org>
Date:   Mon, 5 Jun 2023 08:25:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/3] dt-bindings: remoteproc: qcom,msm8996-mss-pil: Add
 SDM660 compatible
Content-Language: en-US
To:     Alexey Minnekhanov <alexeymin@postmarketos.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230604061421.3787649-1-alexeymin@postmarketos.org>
 <05658f98-ddc1-702b-ea4b-4ea95d0b3313@linaro.org>
 <06cd3bc1-ce97-3b62-c5f1-98b22c8c24b0@postmarketos.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <06cd3bc1-ce97-3b62-c5f1-98b22c8c24b0@postmarketos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/2023 15:35, Alexey Minnekhanov wrote:
> On 04.06.2023 12:11, Krzysztof Kozlowski wrote:>
>> You also need to restrict/constrain power domains and resets.
>>
>> Best regards,
>> Krzysztof
>>
> 
> If I understand correctly, power domains and resets should be already 
> restricted together with msm8996+msm8998 by "else" branch [1]?
> Am I missing something?

Ah, right.

Best regards,
Krzysztof

