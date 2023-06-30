Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7187C743BA6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 14:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbjF3MKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 08:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbjF3MKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 08:10:04 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7915B4207
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 05:09:47 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbc244d3a8so12384015e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 05:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688126986; x=1690718986;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UaXDbRXR16mJA/DvXoLGkVIltz9YV1CgHioJo6bSNC4=;
        b=KLr1MH/l+Z1HIOFz6gcyq5RfDHsv3Dfdi2Ot4OKJp0s73JoWGcIbVkRXO8bRfbu/kM
         1g9h3fdfzDSnxz7K0kIMAPnZwdNnmAeFirQr3C4OIXyyiazpA87MgJ7NJb7HwxFWqqst
         M4KRgHsjQyABwHjWYLTlR1h5dQuE74cgM3FXT2MnJFkH89wD4Uvmmobfnstejqsiadb6
         KVjyh9z3XDnndOFVDe+STBYlEgXHhqYNkjBki1gxA7Hs3YDIwbW/UaasmpkeOZ5Mttcu
         KKoqgZOas4fpiGHFNecLnXng6wiEm8ZvI3tBsogfu6ynAQ8bI0MLKUitrWQbF9vZGRAn
         pFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688126986; x=1690718986;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UaXDbRXR16mJA/DvXoLGkVIltz9YV1CgHioJo6bSNC4=;
        b=F6lBP+RdPo1BrnF/B6GH5gYyHtqpRNFW2hUPP585tLUFqk5tO6wJ/ABeAZsXHNr/dT
         gQlj1x8ghzWabrbXu1Ekpn8I15P7QcmLF3WMzp90nWIOFNdb09EqyU7aD8fiIn3x3xI6
         52Y4bf6HIHZKX1N/Ztxk0jjbb5sgPM10qaNHXhf2Fv7StdWGD/+Do84HIZsTfCjSpvHn
         8J1e91BJMFkImuoIr11nt8MhBeWEq+/hCfvL3dGgjvHYIuK/KWh9xliw8ogLrwZUM7oP
         +8OLKXtG5lUcHu9UGnU/ij4dYN9NfSr1EdTvP+emtkItIvU5emiS2txy4P+aukSW+9Nz
         M/Cw==
X-Gm-Message-State: AC+VfDycLPjECGDVO4uG9NuQ6Zy/7kwW1tUKiuhdh2+Z+96/5yyGhEF3
        sxWeeaBP0fwSU1WYOjPRur/nYw==
X-Google-Smtp-Source: ACHHUZ7Zr9JheT31uWfVeoOIRMYD7XEYRB6a/+4vpFtFxY8TlMJoafCn5J7IBRGnDhBFRrK2O26Msg==
X-Received: by 2002:a7b:c397:0:b0:3fa:74ae:df9f with SMTP id s23-20020a7bc397000000b003fa74aedf9fmr1907548wmj.37.1688126985695;
        Fri, 30 Jun 2023 05:09:45 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id x9-20020a05600c21c900b003fb40ec9475sm11797771wmj.11.2023.06.30.05.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 05:09:45 -0700 (PDT)
Message-ID: <1373aef0-c837-8e6f-fc94-9c6bd70a5b31@linaro.org>
Date:   Fri, 30 Jun 2023 14:09:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/1] thermal: sysfs: avoid actual readings from sysfs
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Eduardo Valentin <evalenti@kernel.org>, eduval@amazon.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
References: <20230607003721.834038-1-evalenti@kernel.org>
 <f26ac9a9-60af-a0fe-fccc-25bcd306f5a1@linaro.org>
 <ZICybSuZELhR1Ni5@uf8f119305bce5e.ant.amazon.com>
 <b2e93db5-e6f8-a9d8-53de-af5ea750f0f0@linaro.org>
 <ZIITZINvtPfjuhS6@uf8f119305bce5e.ant.amazon.com>
 <7616fd9d-aa0d-2ecd-8751-894b1c9073c0@linaro.org>
 <ZJKFar/U75+PGCRt@uf8f119305bce5e.ant.amazon.com>
 <75eba2da-593f-f3bd-4eac-5155fcf5aee8@linaro.org>
 <ZJPUchRH+3LLvuKy@uf8f119305bce5e.ant.amazon.com>
 <CAJZ5v0jAJj-Eh9tJZRMamSFSWWJqVpzaWeHmqThyPvAGpzk17w@mail.gmail.com>
 <ZJyh1Dp5WrXyv9wW@uf8f119305bce5e.ant.amazon.com>
 <CAJZ5v0jn-zCgObgNYswGQK0vLbWaK1VhPZP1L+pB5k1BhNs5bA@mail.gmail.com>
 <2d59de0d-5011-780a-cb6c-94e6e2b74156@linaro.org>
 <CAJZ5v0jQssaVMim3b3yWEqw2NGt4SYSZP6Zb4i5O++=9Tp7C3w@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0jQssaVMim3b3yWEqw2NGt4SYSZP6Zb4i5O++=9Tp7C3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2023 12:46, Rafael J. Wysocki wrote:
> Hi Daniel,
> 
> On Fri, Jun 30, 2023 at 12:11 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>>
>> Hi Rafael,
>>
>> On 30/06/2023 10:16, Rafael J. Wysocki wrote:
>>> On Wed, Jun 28, 2023 at 11:10 PM Eduardo Valentin <evalenti@kernel.org> wrote:
>>
>> [ ... ]
>>
>>> So what about adding a new zone attribute that can be used to specify
>>> the preferred caching time for the temperature?
>>>
>>> That is, if the time interval between two consecutive updates of the
>>> cached temperature value is less than the value of the new attribute,
>>> the cached temperature value will be returned by "temp".  Otherwise,
>>> it will cause the sensor to be read and the value obtained from it
>>> will be returned to user space and cached.
>>>
>>> If the value of the new attribute is 0, everything will work as it
>>> does now (which will also need to be the default behavior).
>>
>> I'm still not convinced about the feature.
>>
>> Eduardo provided some numbers but they seem based on the characteristics
>> of the I2C, not to a real use case. Eduardo?
>>
>> Before adding more complexity in the thermal framework and yet another
>> sysfs entry, it would be interesting to have an experiment and show the
>> impact of both configurations, not from a timing point of view but with
>> a temperature mitigation accuracy.
>>
>> Without a real use case, this feature does make really sense IMO.
> 
> I'm kind of unsure why you think that it is not a good idea in general
> to have a way to limit the rate of accessing a temperature sensor, for
> energy-efficiency reasons if nothing more.

I don't think it is not a good idea. I've no judgement with the proposed 
change.

But I'm not convinced it is really useful, that is why having a real use 
case and some numbers showing that feature solves the issue would be nice.

It is illogical we want a fast and accurate response on a specific 
hardware and then design it with slow sensors and contention prone bus.

In Eduardo's example, we have 100ms monitoring rate on a I2C. This rate 
is usually to monitor CPUs with very fast transitions. With a remote 
site, the monitoring rate would be much slower, so if there is a 
contention in the bus because a dumb process is reading constantly the 
temperature, then it should be negligible.

All that are hypothesis, that is why having a real use case would help 
to figure out the temperature limit drift at mitigation time.

Assuming it is really needed, I'm not sure that should be exported via 
sysfs. It is a driver issue and it may register the thermal zone with a 
parameter telling the userspace rate limit.

On the other side, hwmon and thermal are connected. hwmon drivers 
register a thermal zone and thermal drivers add themselves in the hwmon 
sysfs directory. The temperature cache is handled in the driver level in 
the hwmon subsystems and we want to handle the temperature cache at the 
thermal sysfs level. How will we cope with this inconsistency?

As a side note, slow drivers are usually going under drivers/hwmon.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

