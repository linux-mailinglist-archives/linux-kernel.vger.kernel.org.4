Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7F967933C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 09:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbjAXIgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 03:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjAXIgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 03:36:19 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E287EF7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 00:36:17 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id g10so10823642wmo.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 00:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+DHAHqm5mVrdyz4PxCFvnliRLiDdHHafIf1mzcKDvns=;
        b=mVnjvE2s1a9WXq6NVhTnCnlMlrcB0t4g8HtTagw/livwWU9M2TNbPPAnFGNu7wMV5w
         p7S41sleaY9OAnp5hcsFq33lpXA2LD55vjPjZR8imXG0WHcvn8yXnSDhaX+oUr/YqGCc
         Ous99brkpsYno9LrL7bkm6bfbm5ee+RtEFKsHSbZzJr+FSgFwVHJKapEAvaxhfzs5mE/
         w5PsuVQf0wZygT6HoGiXtGz2JPzq7W4zalPINmXOKYL3QTa0YTyFtdsxYTexIBQ6DoGK
         VNkP2P5Jh4volMp3GhhTsBly5JuF5kWGY9CW/fw30y6jwSWIyjKiEyWeht1Vl8iM1wxI
         V1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+DHAHqm5mVrdyz4PxCFvnliRLiDdHHafIf1mzcKDvns=;
        b=no4iiVUMQKWgUW3EAGzDxb2CGXcXkSr4KEfdFSjPmG6Brlhw2ckdegs4wt2j8YfEwC
         pXbdbHyraWkD6j76o8nT8Wgi6dxxNFGW/Em/tGfg6nWjX3KL9QFwvyEp2tcUMJ9NlsMe
         xLOGEtIFihqkFR+ZRMeG+r8RbjoEGL3a/EbOnvYr9E5YI4AJvYdQDVfVi+mPN1E5UKzk
         uUlIj283CkPKXozafF41NmyCWKoIaCdgYViI6Czj65/QJGCQ0XEujB9Lk3Hg7Yd7v+QS
         t5FoaKdwrx+oaggaAKG9qIzLpNpBZLQUwWFbxT6gKP1nevZUeszmPOvrMEBaMcdOtQw0
         yGEw==
X-Gm-Message-State: AFqh2kqIJ0zhuDRhQ9RrWpekd77fQyBFxlj+uS9agvyKJq0EtbrSd1n1
        kxDkYjh9/cnGHsZc96RI0898Qg==
X-Google-Smtp-Source: AMrXdXvqFer9U2gpvrkA9katgZ3v+FI8mwsJhUFMGM29c0UiNV1/dLmZ0rvPr3GsXvG9rXnwONePew==
X-Received: by 2002:a05:600c:310e:b0:3db:fc3:6de4 with SMTP id g14-20020a05600c310e00b003db0fc36de4mr23498044wmo.35.1674549375874;
        Tue, 24 Jan 2023 00:36:15 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n15-20020a5d4c4f000000b002bfad438811sm658147wrt.74.2023.01.24.00.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 00:36:14 -0800 (PST)
Message-ID: <3fdf9e1d-456a-c538-89b6-82b299aabd48@linaro.org>
Date:   Tue, 24 Jan 2023 09:36:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 6/7] arm64: dts: Add ipq9574 SoC and AL02 board support
Content-Language: en-US
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linus.walleij@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        shawnguo@kernel.org, arnd@arndb.de, marcel.ziswiler@toradex.com,
        dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        broonie@kernel.org, tdas@codeaurora.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
References: <20230110121316.24892-1-quic_devipriy@quicinc.com>
 <20230110121316.24892-7-quic_devipriy@quicinc.com>
 <f6ef1834-b629-b76c-9cde-55af56320665@linaro.org>
 <7f157b73-f856-04d2-1b39-e1f8861d0439@quicinc.com>
 <84aa79c3-b793-0d0e-d6a5-035aff5a17b4@linaro.org>
 <278a2e6e-69e0-81b0-f476-571edea950ff@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <278a2e6e-69e0-81b0-f476-571edea950ff@quicinc.com>
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

On 24/01/2023 08:19, Devi Priya wrote:
>>>>> +			gpio-ranges = <&tlmm 0 0 65>;
>>>>> +			gpio-reserved-ranges = <59 1>;
>>>>
>>>> Hm, why reserved ranges are in SoC?
>>> As the gpio is forbidden on all ipq9574 boards, we have added it in SoC
>>
>> Why it is forbidden on all boards? I guess it depends on the firmware
>> and this can differ, can't it?
>>
> This GPIO is protected and used by the TZ firmware and is forbidden on 
> all the boards & firmware

OK

Best regards,
Krzysztof

