Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973B96198A1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbiKDN6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbiKDN55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:57:57 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70D12F66D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 06:57:48 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id w10so3230049qvr.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 06:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qhzgv1KpNF95EEHpLoq66m5LBpsayMOKdYESA76s0js=;
        b=zxilIA0Fs4zbbUdB672h7ugyUJe1uPwi6JXWBQDCKcVg78XzJP0Xv6k+r5/o++MQkY
         ztlYC+Oi2fivbMGK9LnwFD6z92tw7BdpAf60prgqBMd6/brzu/h/wumUcw6/VtSJ5T5I
         ZPS6dMNOD5UcGzSixhsu8FHeo4QZ3c5LTWXmJbxYCEQL8i5ASvbqDBPdCvjHE37SRspi
         dNic6HxtZE5e3cX9jihvyvlF0Gm2b8r9StPRhdtL+hdJzKv8rSDMvCERUpuWUXzYmu2A
         1BsIr6OCGDFzb8UR7zYUoHO1ePCtUIKC8iPwqrb3efC6hgk09uIXi/Y5PI94Gv6H0uBn
         86kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qhzgv1KpNF95EEHpLoq66m5LBpsayMOKdYESA76s0js=;
        b=W6nzhUY5WoKocFnTUcRwgHleN1MZpwd2E64grNPGCpzQPP18r4NIwD8U59lbAix9J2
         EpljZk4kFJPKqAy5Kp3IWFSkVvDOJD4n03PViSD9s/HbSQ1FXtkVQ8dD5hMcDjjBlBUk
         8AuLjAQOypGKpd/w/K2F6FtfHic8KJh/P8T7XJbLxHb2Dac7Fpzej0dPwDO/yDIsYXSQ
         r4rTLtY5LlLZkthF3HiWOIIEMUdjgD6i3T+8kO0wMYv/cUNcX0ddkQZxJCBIoFjeKQCC
         4tNOr8/QBkDVl8BA+WSfkRyKGxsJ6pSFaKCBpFiMeZzaL/ymo/hmjcg7BZiLnwJSze3U
         IUBg==
X-Gm-Message-State: ACrzQf1VtjoNPHhhDCZcO0P5uaHJYsPLdgg8yKdObDpsU/HAnPDpj5Cn
        2aPAQe5z/+K9I+hxkK5An4Rivw==
X-Google-Smtp-Source: AMsMyM4mUU4Nr7fu+a8ccJKelKEROzGeWiovIx605bSMi89vFC11e0ut3vkDueZ7NUUyjwdLlCJ9gA==
X-Received: by 2002:a05:6214:242b:b0:4bb:5e7e:715a with SMTP id gy11-20020a056214242b00b004bb5e7e715amr31976356qvb.8.1667570267351;
        Fri, 04 Nov 2022 06:57:47 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id w25-20020a05620a0e9900b006f9f714cb6asm2871899qkm.50.2022.11.04.06.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 06:57:46 -0700 (PDT)
Message-ID: <9c4b08e8-3ef7-133f-a71a-d80075f5073d@linaro.org>
Date:   Fri, 4 Nov 2022 09:57:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: msm8916-alcatel-idol347: add LED
 indicator
Content-Language: en-US
To:     Vincent Knecht <vincent.knecht@mailoo.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221104132400.1763218-1-vincent.knecht@mailoo.org>
 <20221104132400.1763218-4-vincent.knecht@mailoo.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221104132400.1763218-4-vincent.knecht@mailoo.org>
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

On 04/11/2022 09:24, Vincent Knecht wrote:
> Add si-en,sn3190 LED controller to enable white LED indicator.
> 
> This requires adding the additional "enable" gpio that the OEM
> choose to use, despite it not being mentioned in si-en,sn3190
> datasheet nor supported by the driver.
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

