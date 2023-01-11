Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472F6665A02
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbjAKLZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbjAKLZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:25:02 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43249F
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:25:01 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id e3so5484370wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qbdDKI4Ey6JY+q0XVlpG88pauoONaYof/XvXYc94UzA=;
        b=Qhw27iT/0tu/MU2cQXm2Dr6zbSB2A3n5D989VL7VYjalRm1qn5xDYtaN9B+c5b6Hm+
         K0qEVuZubWBPIcqPkvyvmdi11MhcjWkQ2Xo1N1fVK/XfdPZ8cqYcGvjUzE7oht1/Uwt2
         nc3t/s0O0DpjCietGC8WAYerFzWjjr7IxgndJbu993xkE29Y9HmZ630ur4auKA9K8ozL
         WrbeJIOv0urwLcFvMNKe4s8rOsEjL7C5CVgnazM9yTNuuZCkKHnsss5O0mUuUSQEa+4A
         D6sqEjQ73+Bh2zmdJCwE8iBFCxwIC/DodX518Q3mxomziX5LCuewJaHxwAKa+vJsCnjB
         j+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qbdDKI4Ey6JY+q0XVlpG88pauoONaYof/XvXYc94UzA=;
        b=g3xLknAjnN/9TV32lnOz/LeqroDXOhLyi1kPYBkgDJgknkPTIA+MAUZ1AMKaIH09fS
         j//adLIpd/76+ahgs20VRKR4UmRP+abUf1JvdLC0x15E2vacmUoKevV6wPI0eyU7DzKo
         D+3YjQJIUAfpZbVFdPAzfcOO87WiQzF+XJEpACW6aYRc3RZXtuEbx5RVI7Esm+CH7WDn
         CaXifI6X6a0GtZYxWMYwoDvhjD90gdJqKTt56SmfEfCnop2BwsOInmHTCWTpNMY3O/6F
         NM/BLXUyTYIXirQJVGkq5oSAgQ1E7BpaEh5dENGXKYXGytyJQk7LQsIbIWUe4cUpiUyx
         z83A==
X-Gm-Message-State: AFqh2kpR2z0+xW+H543M6Z4h9hO5qOWXdcj3jHeixH4NMk/FNGjDqWV5
        Rqn6JtpXPMg87GUa6n+SWUyc5g==
X-Google-Smtp-Source: AMrXdXs+MEEL6QPXWp25IjjQP0ytvbLLgmYxzxdMAWuUKHHACK6fUF60Dkt6yH8ZKfS6vurGKMKxag==
X-Received: by 2002:adf:dc81:0:b0:293:fff0:63b3 with SMTP id r1-20020adfdc81000000b00293fff063b3mr24022963wrj.4.1673436300202;
        Wed, 11 Jan 2023 03:25:00 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id q16-20020adff950000000b002bcaa47bf78sm4253734wrr.26.2023.01.11.03.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 03:24:59 -0800 (PST)
Message-ID: <a315e420-5fa4-21c4-e297-42480ebfa2bd@linaro.org>
Date:   Wed, 11 Jan 2023 12:24:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] thermal/drivers/qcom: Remove duplicate set next trip
 point interrupt code
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     rafael@kernel.org, dmitry.baryshkov@linaro.org,
        konrad.dybcio@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230110103420.2430518-1-daniel.lezcano@kernel.org>
 <20230110181328.el2kicyrg2j554c2@builder.lan>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230110181328.el2kicyrg2j554c2@builder.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2023 19:13, Bjorn Andersson wrote:
> On Tue, Jan 10, 2023 at 11:34:20AM +0100, Daniel Lezcano wrote:
>> From: Daniel Lezcano <daniel.lezcano@linaro.org>
>>
>> The tsens driver reprogram the next trip points in the irq
>> handler. This function then call thermal_zone_device_update().
>>
>> However, thermal_zone_device_update() calls thermal_zone_set_trips()
>> and from there it calls the backend 'set_trips' ops. This one in turn
>> reprogram the next trip points (low/high).
>>
>> Consequently, the code setting the next trip points interrupt in the
>> interrupt handle is not needed and could be removed.
>>
> 
> 
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> 
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
> 
> The last one should be the address you sent your patch from, and that
> was the first one. So I think you should drop this one.

Thanks for the review. I'll remove the duplicated SoB.

   -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

