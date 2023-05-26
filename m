Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24917712529
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 12:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242526AbjEZK70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 06:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236264AbjEZK7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 06:59:22 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4075312F
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 03:59:20 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f4b0a0b557so611037e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 03:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685098758; x=1687690758;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+LLFdqd+rVHftP7KktFiZcZEDAD0B2e7kG5B77pkw5s=;
        b=o9herHqQ/9FWu/DSD5/J3kEJkhEXcm0eH2LMgnJYUcmqsXsntWzhX3Lr3/qVfVHuJK
         zw3TpJyi6e461XCUuMMASnEUaXZd5mM5W2t0tQWVLJ537zTiC3bC/KzjsVK71eV9Eebw
         VV4bJISV7k0GrVy3p8zenxczvhkrUlAB/YhuD07V7qy0tnGrcuxQHwr/EcEa+Fhmvr6H
         WK/MvtJli0flVUC1B2KeKzKrdr1UVUZaOigci/g3EuUxnj3+siy+/l4H1nFly3KLf96V
         QZ10kKRwty+ccAhsWvUHimMfrltqPn1X5huhIK7p29tDTmHIrl6TPggYeFyVEku9kASx
         RmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685098758; x=1687690758;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+LLFdqd+rVHftP7KktFiZcZEDAD0B2e7kG5B77pkw5s=;
        b=k9aBc2CCMBvpHX9mX/sw/ouim1dDhl9BDhmVXUDx/kyV0sPP5nypzgrDp+9ZpAgLsw
         8Z4gCNqDUAwyqvr0R7hEdfcBRSMI6oorMt8MaLzDGmwrKQvgSrpVXoTanDunNB7aD7AU
         4g5AKxrJHvft3Kg6Y/eUaXn45E/yzGtTqBnRuq3LPxLAhKqFzYubmJUu0/kiWbffP+mT
         3oAlOOoVE4ejR8eOBMVfr8GzE1QZOJUVaqPS7ibB7taZdnk0TBccDJ36Dh5VdsBJykmn
         Kp5nM4fO8xxxHAzjL2/8TbjBy0B9P1G9T4osWrKUbUlcQGzo1o3dX9zl5pouKqRINdAF
         qFdQ==
X-Gm-Message-State: AC+VfDzCGIhHaEtv4e9+vFvRWDzhQ1++KvB/DUVFjXxH+JTe3xuiojOE
        Ggcq9B8xS2NpDo1h1c9/zx/xww==
X-Google-Smtp-Source: ACHHUZ4ZaO9iWHBRYZOP/LlcS89s3yySWEsbhb7NkehJl+M4JeEn45RY8HM1kD6/VMB3QEGfjvsH4g==
X-Received: by 2002:ac2:596e:0:b0:4f4:b3eb:80f8 with SMTP id h14-20020ac2596e000000b004f4b3eb80f8mr462729lfp.3.1685098758514;
        Fri, 26 May 2023 03:59:18 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id u14-20020ac248ae000000b004f387e3b376sm572437lfg.150.2023.05.26.03.59.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 03:59:18 -0700 (PDT)
Message-ID: <f8731d93-b335-6d9a-183c-34a652f45455@linaro.org>
Date:   Fri, 26 May 2023 12:59:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230526-topic-opp_bw-v1-1-e881091363af@linaro.org>
 <20230526105320.pfnu3oxl2cm37ot7@vireshk-i7>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH] opp: Provide a function for just setting bandwidth
In-Reply-To: <20230526105320.pfnu3oxl2cm37ot7@vireshk-i7>
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



On 26.05.2023 12:53, Viresh Kumar wrote:
> On 26-05-23, 11:17, Konrad Dybcio wrote:
>> Currently it's not possible to set just the bandwidth if the OPP
>> describes other properties (required-opps, opp-hz etc.).
>>
>> Introduce dev_pm_opp_set_bw() to solve this problem.
> 
> The OPP core (intentionally) doesn't provide any such interface for
> freq, volt, bw, level, etc.
> 
> Setting just one of the properties for a device is potentially harmful and the
> OPP must be set as a whole and so this isn't allowed. There is
> dev_pm_opp_set_freq(), but it uses freq to just find the OPP and sets entire OPP
> only.
> 
> Why should be break this for bw ?
> 
There are some users which have tight power sequencing requirements,
like the Qualcomm Adreno GPU.

Dropping the entire OPP kills clocks, bw and required-opps at once,
but on certain Adrenos we need something like:


disable memory clock (clk)
disable all other clocks, including the opp-managed core clock (clk_bulk)
kill one, fully manually controlled genpd (manual runtime pm)
remove bus vote (func proposed in this patch)
kill another genpd (manual runtime pm)
kill the opp-managed genpd (automatic pm calls)

Changing the order kills the chip until you reboot the whole board and
setting freq=0 using dev_pm_opp_set_rate doesn't drop the bw vote.

Konrad
