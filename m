Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A605B4EAA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 14:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiIKMD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 08:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiIKMD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 08:03:56 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7288232EE5;
        Sun, 11 Sep 2022 05:03:55 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id az24-20020a05600c601800b003a842e4983cso5253182wmb.0;
        Sun, 11 Sep 2022 05:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=7zlEymvc9Jpu/8aSqNHdifkcQlrGNPSUjCxSE+zsZ/M=;
        b=g4sEw3AkhJIDFoZlYq8OHVw/hFBRICQFM0YpU97c0QFBnu4i5xRlxcwissOON8eC0E
         p3YS2rEiGqHLIiip0+fshOjDkp2JW2VpU+VXfrM9GD/nOYvlYea7Vdwov2F/FkxnY2Nh
         skTAtZE/UNQUPAJXEUUMHmeN0+qmmTD+QDgzk0UJ8HQIm3dUJQrdUVHIQhghWyQEdmQB
         sn+Ejg7v/AHO4cj2ULKl/xN6QygCQrZlv7iUzb5q2K6tevjS5+c8xnlG+2x4eNWDKNHK
         pSvRjC+ivRcWY5Iqb3qyXdYnAQWsMR3UPUbQg1LkYtqV5eu9maZPVlZ00Z5WgKQCLeku
         x6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=7zlEymvc9Jpu/8aSqNHdifkcQlrGNPSUjCxSE+zsZ/M=;
        b=QDQ/4k7IgG0PRxw0ClAAPZbWQ6B4IfMTKNjbkvoRs7OS8oEdkzLhwPRQPDO6FUfC3T
         TgCISqtiYqGwuMRmPuIfyiJQbzMqXdhq3FFXJ2f+uiGHpLgbu8MQQl/0CZ/dwEGO43uE
         d0JvCpurJHrS2xeJ80bjGRzAYlLG9HTDSe+QRyefYQpNbWwb1Qp9zmlY/KJwcMbFpzvH
         o5KV6DemT0VKai0+U40aTht/ATwEkvy/HztbuDEk/sCAL8e6SrcfRwU49baK7jvdrgdh
         CQwvMnDMP1QkWtkVHhCzlCvRjsGaJQG8LCvq/U1FQCzANniRSITuXJCkaFXEnaStGpBN
         DVhA==
X-Gm-Message-State: ACgBeo2wdlbjHO2QptFYU/Pqlnjq1Zg9PJDSSra6Tc1YvFOXqvJWxbg9
        7HGpwj+56MFeVUTM8pNafjk=
X-Google-Smtp-Source: AA6agR6y4Dzcndiz6luxNrPZhnU4yeRX8EyYbm/xMaE7wql1Uxn69/IrGUbXyZR6yyqil1KmVEWwGQ==
X-Received: by 2002:a05:600c:3509:b0:3a6:1888:a4bd with SMTP id h9-20020a05600c350900b003a61888a4bdmr10978670wmq.191.1662897833896;
        Sun, 11 Sep 2022 05:03:53 -0700 (PDT)
Received: from [192.168.74.101] ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id bg14-20020a05600c3c8e00b003a840690609sm8334531wmb.36.2022.09.11.05.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Sep 2022 05:03:53 -0700 (PDT)
Message-ID: <b40191c8-227f-e49d-b30c-6e4dc43a24a9@gmail.com>
Date:   Sun, 11 Sep 2022 15:03:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 7/9] arm64: dts: qcom: sm6115: Add basic soc dtsi
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20220910143213.477261-1-iskren.chernev@gmail.com>
 <20220910143213.477261-8-iskren.chernev@gmail.com>
 <d51b0a89-a151-dd5b-b026-4291031fe1ea@linaro.org>
 <ad940df1-6876-0c38-81c8-7d7ca97046de@gmail.com>
 <7e5eb29f-913a-7540-c618-fb6c5a493d5d@linaro.org>
 <cdb756fc-6a4f-3853-9570-f02b8cb03990@gmail.com>
 <6f2ec41a-a6fa-dce7-66ee-e9ac3d3ab6f5@linaro.org>
From:   Iskren Chernev <iskren.chernev@gmail.com>
In-Reply-To: <6f2ec41a-a6fa-dce7-66ee-e9ac3d3ab6f5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/11/22 13:26, Krzysztof Kozlowski wrote:
> On 11/09/2022 12:22, Iskren Chernev wrote:
>>         basic-state { // this matches the first state in oneOf
>>             pins: "gpio1";
>>             funciton: "normal";
>>         };
>>
>>         nested-state {
>>             some-pins { // this matches the second state in oneOf
>>                 pins: "gpio1";
>>                 funciton: "normal";
>>             };
>>             other-pins {
>>                 pins: "gpio2"
>>                 funciton: "normal";
>>             };
>>         }
>>
>>         // but also, matching second state in oneOf
>>         nested-basic-state {
>>             pinconf {
>>                 pins: "gpio1";
>>                 funciton: "normal";
>>             };
>>         };
>>     };
>>
>> So I'm saying, we should either choose basic-state and nested-state, in which
>> case we don't need the "^pinconf$" variant, or we can have nested-state and
>> nested-basic-state, in which case we don't need the 1st case of the oneOf.
>
> Ah, I get it.
>
>>
>> Otherwise people have to choose between basic-state and nested-basic-state,
>> which are equivalent in semantics.
>
> Yeah, I can drop pinconf. I put it in the PMIC because it was used, but
> I don't find it for TLMM pinctrl nodes.

Frankly I'm not sure which is better, to drop pinconf, or to use it (and drop
basic case). You probably have more experience and taste regarding that.
Another thing is that you normally specify one pin at a time in the nested
case, so having -pins is a bit confusing. Maybe it should allow -pin and -pins.

I understand that you technically can't change existing bindings (because
they're immutable), but at least for the future you can pick something that
will stand, so I wouldn't be too concerned about existing ones :)

>>
>> On a tangent -- why specifying the .* regex of pinctrl subnodes has effect on
>> pinctrl references in other nodes. I.e I don't understand why this fix fixes
>> the issue (but it does).
>
> Because it works on DTB and finds linux,phandle. This might be some bug
> in dtschema, but anyway better to have a bit stricter patterns in bindings.

I see, the phandle node appears only when you use a reference, not when you
define it... there should be a way to handle that more precisely. phandle is
a very special case. Also `additional-properties` is smart enough to allow it.

>
> Best regards,
> Krzysztof
