Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DF3675C72
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 19:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjATSI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 13:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjATSIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 13:08:25 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87CB7B2DB
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 10:08:23 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d14so1883264wrr.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 10:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AYDLNXJWoiyDdXocdBDY3OI8vBR4rf1NLXYkAgc4tGo=;
        b=c1FbpnPnGM7Xh3+EWEej3EnCU5G7+FyDKOQNB0HVGgm5J1F1a69x4YNugpan6qB52Y
         eyUCebH67DjGaZnr1QiVRLiI8so9Dah2zqUR8eNk+rLAQB70S0Vv0aBxOP8CGUuM9wA0
         uAKX4aNykJp4hb6DIVZC71uvGpWLSF6opNlbVuwa1ApVHK2UNmnM8H8c1vKfvM7OCLJu
         coCCNZ32T9hZQPHB33Cw6i5D72IqGqnHlNNKmxm7fL9GG+RctqlFsGsRu6VYMOpZmAM+
         +48zzMS+IqxjULEB+EaMbvZ9QJWnF7pzTFr/X7Wk5APiEf8NxbbiV0iwwBw80DMqJLrn
         FAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AYDLNXJWoiyDdXocdBDY3OI8vBR4rf1NLXYkAgc4tGo=;
        b=qvdQ1+nY7VQ20GQGpVH3cNqOhj5t3Cu7cH7JrJhktJSmsMKWgifjjPBQce4wVhTcF0
         Q+iyjljMii/UdW8KJJNelJNIQKIq6/hVL16jZTKT7X12Y0IPb6JJGgMoHFdem+1kyfkU
         4EgQ4Lup+vcZGAn+YBX7LqLiAqZYSxCZDpFkq3/M+oMpB3tyc+uKhFUCJBU7BKeDV3oe
         N7AI3ypgsWaNXWiCI2v+z1OZc+rZatCtU4NKd+usgFi7f9CpI4GYygD/HNEvuyZgC3Ej
         KpHne1qW9CffxRHix5VrsGmA3i7uq1b3mfXJ1s0YQzgcdH3Xgj5WI3BkI6ny28ZkVTKe
         HiYQ==
X-Gm-Message-State: AFqh2koLvtDZboHN8GDCnsZK/UdjzH/oSjNEHaD2HzLojINsrY8q53pz
        q73/YksRR5z1KjX5IkKSKOoEMA==
X-Google-Smtp-Source: AMrXdXu5jlctrHfweOx4hVb1gm1jhsRmqdCjdEkgYjXhBx2MefSTOm5niiAzO/T6tIevf/LTpEkv2w==
X-Received: by 2002:a5d:6a86:0:b0:2bb:e805:c1ef with SMTP id s6-20020a5d6a86000000b002bbe805c1efmr13602174wru.52.1674238102394;
        Fri, 20 Jan 2023 10:08:22 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id r11-20020adff70b000000b002bdf290efdasm13809413wrp.58.2023.01.20.10.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 10:08:21 -0800 (PST)
Message-ID: <e4468710-1336-847e-89e4-51c745a0a79b@linaro.org>
Date:   Fri, 20 Jan 2023 19:08:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 1/3] thermal/acpi: Add ACPI trip point routines
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rui.zhang@intel.com, christophe.jaillet@wanadoo.fr
References: <20230113180235.1604526-1-daniel.lezcano@linaro.org>
 <20230113180235.1604526-2-daniel.lezcano@linaro.org>
 <CAJZ5v0jDF9qrQAQM1AhT-Q4A3Nzyht9XxZoZyS1afoAPt1h_=A@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0jDF9qrQAQM1AhT-Q4A3Nzyht9XxZoZyS1afoAPt1h_=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rafael,


On 19/01/2023 14:15, Rafael J. Wysocki wrote:

[ ... ]

>> +static int thermal_acpi_get_temperature_object(struct acpi_device *adev,
>> +                                              char *object, int *temperature)
> 
> So this would become thermal_acpi_get_temp_object(). or even
> thermal_acpi_get_temp() because it really returns the temperature
> value.
> 
> I also don't particularly like returning values via pointers, which is
> entirely avoidable here, because the temperature value obtained from
> the ACPI control methods must be a positive number.
> 
> So I would make it
> 
> static int thermal_acpi_get_temp(struct acpi_device *adev, char *object_name)
> {

We are converting decikelvin -> millicelsius. Even it is very unlikely, 
the result could be less than zero (eg. -1°C). We won't be able to 
differentiate -ENODATA with a negative value, no ?

In the future, it is possible we will have to deal with cold trip points 
in order to warm a board. May be we should don't care for now ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

