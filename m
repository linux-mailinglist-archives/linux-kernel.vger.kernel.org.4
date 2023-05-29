Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F107148B4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 13:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjE2LjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 07:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbjE2Li6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 07:38:58 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E8D10D
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 04:38:32 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2af2958db45so32483061fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 04:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685360310; x=1687952310;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZRz/Yo0ZuiDW5QUKS1IhzJn+gx+l8xvFdi3pCPFWD+0=;
        b=fCQ3/5Ru/Si2j74fRAyUuJ0abLnzGmDa02HR467iCn4dC39fuVivJ6Q2HBCK/0AoUL
         Rd5um7n6cqcBBHL8drtOiNMUY4dd6zKv09R001cDbM8Lz+qFpkp8RdRO8ifU5tQBwVxs
         NVTJ+vOZl+OwSJhm2sNf0aFzG4gnnySz1jRa0z2AcSjEZ+EE1DGFFgHUYdNa1RdB382I
         wWzW626UaEjT3iiCwtgbfNf3rVpzlcd2AP4W3uhwEtaOQyFHj+Xv9XaEKgf52XM5Rmts
         cWpUU49RghrHs0NrzakyyOkLGYFi7uY3CZeAbnFr/XySnvb38rP22v+D8mpPCxvAdV7K
         xVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685360310; x=1687952310;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRz/Yo0ZuiDW5QUKS1IhzJn+gx+l8xvFdi3pCPFWD+0=;
        b=JzbemXT3ESZU95kNBb7hA2CM9SEJYrtmjQTZ25kT7OXRtzrom6T3GJaVSsyBQI3Izy
         ZgGiyT/m8OGrj5G00D1Puk75fiH9itEtvZPM2d7zfxYY4pSeYV5BkHUiiA92htlLYNrU
         EzvcR5k/TBNzitKZxAnRf1Q9kDb2UqNJIJBbb1/R+nurrCh8bVdwn9Ki7S0KlLF3BGAe
         Fzw+JTade1jYQNmJU4kbqQwBS+dkJj5UGwEoAQiqCgY91JdlPP9WZAsVdXcnFlV0OD+x
         nKRwDsRWanAODUld5BKviXDvRBw4p2aYwsS++GyxwI0Zshkf8gnROM4LONv7JJdDAsej
         jFhw==
X-Gm-Message-State: AC+VfDwWmazFCVkcdaX40s4Fb0OwoL30TyQqtwOZD1uNu8j7w1Q//iyl
        +vZJ7orViRPA1xSymOwVsenL0w==
X-Google-Smtp-Source: ACHHUZ4AriAKn5EFX9Z5ftCTg18RAlrVk5rpR1C2JpH2T8Vn6quVIszDn0f7Zxr+s5HnJjryHkV6eQ==
X-Received: by 2002:a2e:870d:0:b0:2af:2626:9f25 with SMTP id m13-20020a2e870d000000b002af26269f25mr3991294lji.8.1685360310390;
        Mon, 29 May 2023 04:38:30 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id e11-20020a2e984b000000b002a9ebff8431sm2410894ljj.94.2023.05.29.04.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 04:38:30 -0700 (PDT)
Message-ID: <485cd9cf-6a0d-4a1e-0212-9afc1a41a10b@linaro.org>
Date:   Mon, 29 May 2023 13:38:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] opp: Provide a function for just setting bandwidth
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230526-topic-opp_bw-v1-1-e881091363af@linaro.org>
 <20230526105320.pfnu3oxl2cm37ot7@vireshk-i7>
 <f8731d93-b335-6d9a-183c-34a652f45455@linaro.org>
 <20230529045854.gh36k5my4i35jspc@vireshk-i7>
 <cbea8bc5-5dd2-b097-964d-3494935d4f68@linaro.org>
 <20230529094041.s4fj6gjliivugk3r@vireshk-i7>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230529094041.s4fj6gjliivugk3r@vireshk-i7>
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



On 29.05.2023 11:40, Viresh Kumar wrote:
> On 29-05-23, 11:35, Konrad Dybcio wrote:
>> I think I didn't state my intentions correctly..
>>
>> The proposed function would set *just* the bandwidth through OPP,
>> so it'd be essentially equal to
>>
>> loop over num_paths {
>> 	icc_get(...)
>>
>> 	icc_set(...)
>>
>> 	icc_put(...)
>> }
> 
> Right, but why do you need to do it ? Why isn't this done as part of
> dev_pm_opp_set_{freq|opp}() ?
> 
>> but since OPP already picked up these interconnect paths, it makes
>> little sense to mess with them through raw APIs.
> 
> I am not sure if I would want to expose an API to just configure part of the
> entire OPP switching mechanism. I would rather let you do that via ICC APIs,
> instead of going through the OPP core. Since there is a possibility of
> accidental misuse of the same here.
I did some more testing and I think that I was just trying to abuse
the APIs.. Adding power-domains + pm calls + required-opps to the genpd
provider made the set_opp func work fine on suspend.. Consider this
solved!

Konrad
> 
