Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA4D655A4D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 15:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiLXOLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 09:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiLXOLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 09:11:08 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E2E5FB2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 06:11:06 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 1so10503300lfz.4
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 06:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7i8PDX6l3eEw1wJuHTItF/tlr5bRZPnd8D6+DDXevgk=;
        b=bMXOXsRisi6vn7T+KXq2VpaU4rxodLZqqEkUQusMWCL3suw03pBU8B/tVfBpEZb1hd
         PPWEawv12rZVa8jCqHy3G6Dapp7Nt+KoQYPn76D5n/TDPdvylxYNJFDhBjWidNDhKITP
         vw50rkwFf4ShnXARnJZKbvNOmDwsix8JKxTdhp5Je8p9IBg1n41xUgFHA4o9RkFK1kJu
         olXcXWtUczuVuLt1lF1Py6dpScNSOdTMjE/RNgoyGAimhiWm44f44l66Bs+eVMLRuwDQ
         +MbvqAJsgxVvP4c8jfn9EPhmCw9YVWFDesm7plzeIzGhXuk6a45JtsayZZJTwi7XwSJ8
         3OtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7i8PDX6l3eEw1wJuHTItF/tlr5bRZPnd8D6+DDXevgk=;
        b=XKDT6lagAL7Z7PlFxitVCvpcWZo3mS9AaN2W5MUPW3QHbmjCk/WGXFJXQWEFm9oDnR
         J+YCiwoepKbecu8lDJcK7YQxpQ544lF6eJdkb7+KKmFst4Xv9qjlA83Auo/Q5VfdJei2
         c2v/B76XdR8M1/LksBMziyjOTYEmddT9XwQlaLrhZZTFwVZMBMiRfBSvmaXRyYKuR9VC
         6Su2HkHLOGJL7tg0wRxuYbcUzEV8pu+CAreWJfiUzz1DFIKtXu6bH3nRj9eohl8e9mj4
         l1+DY3hK3jRQZdBSCaR2Mpsa4pmw/0EIyooNgEf4EthnHaoLp7BC7AfhKj2Nr5gRPbZw
         jcBQ==
X-Gm-Message-State: AFqh2koyBrhZ6V3R0tEZ0nn6RfS3I7iZs/B65Y+4jqm27Deo9wfsHQEy
        yIl1p6huaK+4aentdyt8PtugTg==
X-Google-Smtp-Source: AMrXdXs27LWhq/R/v/bzBRXBDa3IRnApOBskMTcl11tIBIp0KzFFFda6UBLJ0OYtZ5r1i0CzPnYZ3A==
X-Received: by 2002:ac2:431a:0:b0:4c8:ae6b:ea8d with SMTP id l26-20020ac2431a000000b004c8ae6bea8dmr3223529lfh.8.1671891064815;
        Sat, 24 Dec 2022 06:11:04 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id h4-20020a056512054400b004a9b9ccfbe6sm967581lfl.51.2022.12.24.06.11.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Dec 2022 06:11:04 -0800 (PST)
Message-ID: <e1fb7474-d029-8004-709d-1d0b437f192d@linaro.org>
Date:   Sat, 24 Dec 2022 15:11:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/3] dt-bindings: leds: spmi-flash-led: Add pm6150l
 compatible
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fenglin Wu <quic_fenglinw@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221209-fp4-pm6150l-flash-v1-0-531521eb2a72@fairphone.com>
 <20221209-fp4-pm6150l-flash-v1-1-531521eb2a72@fairphone.com>
 <Y6WiQKRI/YCbMBhA@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y6WiQKRI/YCbMBhA@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/12/2022 13:42, Lee Jones wrote:
> On Fri, 09 Dec 2022, Luca Weiss wrote:
> 
>> Add the compatible for the flash-led block found on pm6150l PMIC.
>>
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>>  Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml | 1 +
>>  1 file changed, 1 insertion(+)
> 
> Who takes LED DT Bindings presently?

Preferably Pavel and/or you. Rob was taking only on exceptional cases.

Best regards,
Krzysztof

