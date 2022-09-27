Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF905EC77F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiI0PVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiI0PVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:21:00 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800A9A573A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:20:58 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id t16so7293252ljh.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=veq+G9FK2IKRofFJs4LIXDoip5Zj7zd2eyL6Dpdxun0=;
        b=ZrsdDb1V0Lp3Q8JzsRAHu9vK/6jWRz0dmk+YEjSCJIV4s6Pmr/951FQfvsO25RKzQi
         x9Po2FD8+4lMVtWXX15kWB4ZSIguELNYHNmqVkwAHln2NDbA8ctldog7uoLF0jxUaKQe
         HtkpM8uyNKSrknFQee4TNdlYQiCba/bsvzCGBuryEgByOYsb247TnHnmzICpXUepuD+R
         00zMs97JRSom3KqEtT/42OYkMD33I5z1d0huUVTvrC9GZW3Io8kAiBKctYFn3nyKQa5u
         B/tRkaukOTujPszms2SVTaZQoTW+rIbfcaVGqLTjJKonZpAbpS15xWiIREoZeIYnc8iF
         uecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=veq+G9FK2IKRofFJs4LIXDoip5Zj7zd2eyL6Dpdxun0=;
        b=pT4Zukr2L3kee2Qxdi0ogWWFwd+we4lvRMjKnfuvdUY40+5M6j6LkireDppKsLDQd+
         m3dP6BmjXp5uvzqibsXBzHpjHJ7L8sK8gNNlVi2MVIQswNrFe1pimJieLlAZw+8v+qRL
         aajQf5jt2/cyLruqYPSGiDkBWFZcGMK6GYou18zeBJeQLBjsSl4LiqT63Xa8BFnO8q1E
         P+WQoCNj8hiMBhOj4h7jPHdjre9JwnjfCKubmqiG06isiaCSy4ffazHWkag7XN9q2onX
         J9jTQqrSx5r7fFCYaSs3jEqYpfygMgUp55O7GBqPSTVbiUpvSYitUh354oVkKvNAwYBA
         JP4Q==
X-Gm-Message-State: ACrzQf0U1a4W2lqC92Gx9QE0qLijLnATa6tfMiPsFFgxu/1Cv9sqT7tT
        VUP79PBGdmb3H69XyWDMW39mtMKXOplLsw==
X-Google-Smtp-Source: AMsMyM6eRhReD4PW+oQxCPAKYWyxgZNO3b8rhIuPZuQCCqupb56gVM2GGbrKyiA/EDY2hionZOasng==
X-Received: by 2002:a05:651c:2103:b0:25d:6478:2a57 with SMTP id a3-20020a05651c210300b0025d64782a57mr9839256ljq.496.1664292056840;
        Tue, 27 Sep 2022 08:20:56 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id bd3-20020a05651c168300b00261e8e4e381sm193881ljb.2.2022.09.27.08.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 08:20:55 -0700 (PDT)
Message-ID: <923b6d27-c06c-8462-8bd5-31d6ad45efd1@linaro.org>
Date:   Tue, 27 Sep 2022 17:20:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 01/33] arm64: dts: qcom: ipq6018-cp01-c1: correct
 blspi1 pins
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220926074415.53100-1-krzysztof.kozlowski@linaro.org>
 <20220926074415.53100-2-krzysztof.kozlowski@linaro.org>
 <647d12dd-9bc6-ebe3-7a72-9b9c0d4610dd@gmail.com>
 <e7697876-f2bc-b0ef-c8bc-6737d8a54551@linaro.org>
 <6ac05eac-e6f5-b8e5-35dc-25373723f401@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <6ac05eac-e6f5-b8e5-35dc-25373723f401@gmail.com>
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

On 27/09/2022 17:20, Robert Marko wrote:
> 
> On 27. 09. 2022. 16:33, Krzysztof Kozlowski wrote:
>> On 27/09/2022 16:01, Robert Marko wrote:
>>> On 26. 09. 2022. 09:43, Krzysztof Kozlowski wrote:
>>>> When BLSPI1 (originally SPI0, later renamed in commit f82c48d46852
>>>> ("arm64: dts: qcom: ipq6018: correct QUP peripheral labels")) was added,
>>>> the device node lacked respective pin configuration assignment.   It
>>>> used also blsp0_spi function but that was probably the same mistake as
>>>> naming it SPI0.
>>> Hi,
>>>
>>> Sorry for making it confusing, but "blsp0_spi" is the correct function.
>>> Pinctrl driver and datasheets call functions blsp0-blps5, but usually in DT
>>> we call the nodes blsp1-blsp6.
>>>
>>> It would probably be better for me to rename the nodes to blsp0-5 instead.
>> OK, so instead I will add blsp0_spi to the bindings.
> 
> Can you add blsp0_uart and blsp0_i2c as well?
> All 6 of the QUP-s have same features.

Sure

Best regards,
Krzysztof

