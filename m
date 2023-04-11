Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84C46DE5B0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 22:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjDKUW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 16:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjDKUW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 16:22:26 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D301B59C7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 13:21:54 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v6so8770471wrv.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 13:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681244511; x=1683836511;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DBsBC/Vn3Kv4ti4BzHA6RMnVNcTQWhiMWTwoU005B2U=;
        b=CBdx+n88gINEI3enJaeUh+60J0/Wsii+tUzAfIcqPgi5BK52WCmHBRK4A7QGqI0PK0
         JQOLWVATPcOGSjdj/OOA9wQDKMfESMz/3MP7LX2Np8qKd1ZDr6ckiPB1qn4sPlBSN9zd
         lyL5Dow5RHRtPT/xURY4cdQCBstbI+UqUFvsb5QzScX9QQIHa78bY8qmfWati8AUM49h
         VxVJkmQS7DN78A9oJHRVS2cJOeyiVUzx0Q4JRDnzO4FImfQMoSphX/Bu6+ILDbpHOYPL
         32zB9Suehs8c78lBa24wu224sJ3+jlOzZQJidCdT2OoQ5sNCvSwYc8PnfdKYbU1SyMxz
         +LIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681244511; x=1683836511;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DBsBC/Vn3Kv4ti4BzHA6RMnVNcTQWhiMWTwoU005B2U=;
        b=UMEmapnA1dKzrOgY831kB+pa8rSGrDk4XqVvHmD4ellx0e9zg/sL+oMy+Sl2wZ06U7
         JIxg5e3V80zKOOoxEkOiTyNj8XauqQrALTrmWbsotIjapQvwhLpS6GRjp3cvehtK48Rt
         PSsyyDJ3lk3YYPbxuT/pzXQlDzHAHhCFM447b+q/6LE0IypSsAkFZjWuU92CZ0szPuWa
         CtaZHcpxo0h9eRQq4wW/E85G1tGEbmzNuwDzls/lQ7hQV7ccO2JMtMnujFkgauMBD7S/
         fQpkYnAOQnB1FPkESFj1GkoXuwi3PqDOKe6eMT39oniofRfFzyl8o5sPUPKw9eWPhHBt
         LEsw==
X-Gm-Message-State: AAQBX9eevQqWdpTGrLwkAD+uLPclh0ZP4SZ/Ds8QBqsj1Updnu4tQ7jv
        nwt6fxKzNK7bCoZIVGOBpXPUnw==
X-Google-Smtp-Source: AKy350ZeLdzIrvR50rHqr2eVAX5B/6o1f+h0LDKbiEM6pdRF4cvHOWcGRDAAy9uwHAU31RTwDQ9I/w==
X-Received: by 2002:adf:f20b:0:b0:2d1:e517:4992 with SMTP id p11-20020adff20b000000b002d1e5174992mr2689390wro.69.1681244510653;
        Tue, 11 Apr 2023 13:21:50 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:3227:36b8:19f8:5420? ([2a05:6e02:1041:c10:3227:36b8:19f8:5420])
        by smtp.googlemail.com with ESMTPSA id s13-20020a5d510d000000b002d64fcb362dsm15338931wrt.111.2023.04.11.13.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 13:21:50 -0700 (PDT)
Message-ID: <f88a1c56-4078-63a2-ab52-69523c3fdcd8@linaro.org>
Date:   Tue, 11 Apr 2023 22:21:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 6/7] thermal/drivers/acpi: Make cross dev link optional
 by configuration
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Len Brown <lenb@kernel.org>,
        "open list:ACPI THERMAL DRIVER" <linux-acpi@vger.kernel.org>
References: <20230410205305.1649678-1-daniel.lezcano@linaro.org>
 <20230410205305.1649678-7-daniel.lezcano@linaro.org>
 <CAJZ5v0hqqPQ0xQqt3KgyQ5b-xTRjPicgkKgyo=+p7jgB9BuZaQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0hqqPQ0xQqt3KgyQ5b-xTRjPicgkKgyo=+p7jgB9BuZaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2023 20:26, Rafael J. Wysocki wrote:
> On Mon, Apr 10, 2023 at 10:53 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> The ACPI thermal driver creates a link in the thermal zone device
>> sysfs directory pointing to the device sysfs directory. At the same
>> time, it creates a back pointer link from the device to the thermal
>> zone device sysfs directory.
>>
>>  From a generic perspective, having a device pointer in the sysfs
>> thermal zone directory may make sense. But the opposite is not true as
>> the same driver can be related to multiple thermal zones.
>>
>> The usage of these information is very specific to ACPI and it is
>> questionable if they are really needed.
>>
>> Let's make the code optional and disable it by default.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   drivers/acpi/thermal.c | 62 ++++++++++++++++++++++++++++--------------
>>   1 file changed, 42 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
>> index 5763db4528b8..70f1d28810f2 100644
>> --- a/drivers/acpi/thermal.c
>> +++ b/drivers/acpi/thermal.c
>> @@ -787,9 +787,44 @@ static struct thermal_zone_device_ops acpi_thermal_zone_ops = {
>>          .critical = acpi_thermal_zone_device_critical,
>>   };
>>
>> +#ifdef CONFIG_THERMAL_SYSFS_OBSOLETE_SINGULARITY
> 
> It is OK to move the code to the separate functions below, but it is
> not OK to make it depend on the Kconfig option above.
> 
> The extra sysfs things were added in different drivers for different
> reasons.  Making them all depend on one Kconfig option is just wrong.

Ok, I'll do the changes accordingly.

Thanks for reviewing the series


[ ... ]


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

