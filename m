Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81201714720
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 11:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjE2JfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 05:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjE2JfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 05:35:10 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4FC90
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 02:35:09 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f4b384c09fso3487794e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 02:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685352907; x=1687944907;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EOKCBUL648q97kLRF9tfMFKtwd6LoXtmMXWYb2u6bRk=;
        b=JVg1Trzmwy2eoA06j0namth1kL0WPHXxv80mECAM3b/CUsdb0Dkf98mBF6g4MIxmvp
         jKPKcAs3VTZxDquiltTYH7h4+ncDB4yGEl7NI/SguvFTuvZjuGtr0R6dwfl/f7eenT0m
         +TWLkDfK6XeMPQiwlVVcKznqCtyxfswe/ULyd/tx5LXV9/oNKi/EJ2rhNgG1MAfcuOQg
         1Ag0cyV35/djicQDH1wnnO/GRmUPc5YZH7xNbMMHyFBOAfOD0IfpoAJbmpgEEoLwmjow
         3NVRULnGDZiCJVQtDDiPiYL9mkaWN5DYt2QXCFCt0k+HgM0BoQVb55P1Tiu52Ib6hFwi
         kBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685352907; x=1687944907;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EOKCBUL648q97kLRF9tfMFKtwd6LoXtmMXWYb2u6bRk=;
        b=jmMPuht9lVKlOACPenaxC4/O4TcMmKiRpSXAnYsjuxjAZeEbre5K6V8KwC1aLoTDMw
         bFr13GLNisxmsaoasuV9jGvMz4pqKCMv0u29zQE4mCyvKQUycJM8S9guQTixr5Xkte7y
         0ytn2zrvvVN2RKEUWAXx9KNBACiB3yXJLdtaSs01rNq7ogYVXMfteHQhutFpRnq7Z4Qs
         jPnkbp1wbpEMxQ4XboKXcMzwvqeosBFd2sEkcBnLtLH7mI2H4cvyJkZhMxRTyTEZvk42
         JjCB0/YnhHEddzNZlS01arbw9oPE9KUP44K9Xdfmft7SyxZw4KfkDG8atu6UWD/A1NjA
         +DZg==
X-Gm-Message-State: AC+VfDw/6De6daWqR8VmQdrkJgETsjUb/B36iXzTVlQWPOPMn8bFHkVD
        S6YWdrKxcTFEUYE9rKQX9CDihg==
X-Google-Smtp-Source: ACHHUZ5k6Jz2kHv+nXZor5o1b9WEfEPLB6caKN8Zn2RiFU78OHEwZDH0Q0ZhTu0o+mhwNv/254YUFA==
X-Received: by 2002:a05:6512:64:b0:4f0:c18:5114 with SMTP id i4-20020a056512006400b004f00c185114mr3436816lfo.26.1685352907550;
        Mon, 29 May 2023 02:35:07 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id g21-20020a19ee15000000b004f13bc97b00sm1880535lfb.119.2023.05.29.02.35.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 02:35:07 -0700 (PDT)
Message-ID: <cbea8bc5-5dd2-b097-964d-3494935d4f68@linaro.org>
Date:   Mon, 29 May 2023 11:35:06 +0200
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
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230529045854.gh36k5my4i35jspc@vireshk-i7>
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



On 29.05.2023 06:58, Viresh Kumar wrote:
> On 26-05-23, 12:59, Konrad Dybcio wrote:
>> There are some users which have tight power sequencing requirements,
>> like the Qualcomm Adreno GPU.
>>
>> Dropping the entire OPP kills clocks, bw and required-opps at once,
>> but on certain Adrenos we need something like:
>>
>>
>> disable memory clock (clk)
>> disable all other clocks, including the opp-managed core clock (clk_bulk)
>> kill one, fully manually controlled genpd (manual runtime pm)
>> remove bus vote (func proposed in this patch)
>> kill another genpd (manual runtime pm)
>> kill the opp-managed genpd (automatic pm calls)
>>
>> Changing the order kills the chip until you reboot the whole board and
>> setting freq=0 using dev_pm_opp_set_rate doesn't drop the bw vote.
> 
> I am a bit confused now.
> 
> What's the exact problem with dev_pm_opp_set_rate(dev, 0) ? It does set the
> bandwidth too, from what I can see.
I think I didn't state my intentions correctly..

The proposed function would set *just* the bandwidth through OPP,
so it'd be essentially equal to

loop over num_paths {
	icc_get(...)

	icc_set(...)

	icc_put(...)
}

but since OPP already picked up these interconnect paths, it makes
little sense to mess with them through raw APIs.

Konrad
> 
