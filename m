Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B959A6C36DF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 17:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjCUQZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 12:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCUQZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:25:36 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFAC2CFF9;
        Tue, 21 Mar 2023 09:25:33 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id i5so15043041eda.0;
        Tue, 21 Mar 2023 09:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679415932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hHMT9Xr2+W+0aZObi2mrOj/GJsmUfVzdBpDa2xFjqFw=;
        b=fFzSM5JkCjlmXiD09LOwSN9/IftvYM/eJdR+B6K1aOMJB2NIqughDWOlTBdy53jryF
         6Zqjemy9MJO0nRzqV0XcXaZg5lLbncmqTAYaA8SBl0fwdqPo7a5oibu9TkvOwnTz5xYS
         2uKemtqGytoIiQqBSD5Ku4rCma+jT0XbPU44/tCYvM9WypBtgnJCfvq4k6/GRDHKLRLk
         scK/YfIkqowJ3bVi0wG890w4I2UCIAi+VZKVDtZrziSqv5bQJkB78eoCMnYqcg8yJf3l
         bUDRQYG0KFAeBFpFj64r5v9UCNr9+Vco/Ra786LiwPpqD4B33raDG85crulo3voxj9tB
         +tWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679415932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hHMT9Xr2+W+0aZObi2mrOj/GJsmUfVzdBpDa2xFjqFw=;
        b=JUgp+4KPulyrsbr+UdG8QYjK6IRy80/XWawtnRuCswM9rBbyEbYrDC28YRLS0lJcfH
         HKChMRxZMnWcn5EEvzR6LXIX90xxoc13jYDRSzjtMO4qnzXP0SB3gHkREgZMy1/K+sc/
         E7ArX60Vazq4bWEnGBy+LEnbQlNOx2/S3ezRvbddVxX9hNCMsrTva/uR3BuKP4gWOUw7
         YD90xTKPYvisTE+Lpr21y38P32mwqig+a2Cc/z9g5PCVxITVbZvZHeE2tMs51ZUNCU5q
         cySepNCrNKnwjvZ9k0zajQLrxiDzMoPcFAzhWdYpEpkekyRYwTePhJvc0nim5xseDhv+
         tfMw==
X-Gm-Message-State: AO0yUKVRMuaTyUId1zV8CwxWyKfayl4h4Skeq2EeXAwWJDi+USMBGX1Q
        g63NLnThvKl+z4mrqoyVPyV+NDdzwyk=
X-Google-Smtp-Source: AK7set9s5dirn8v7ylCH0oBwYIq+eEI2x+SguvYsPnh+vHgtJ9ZDva1ItQo9ylvDURpwutqCgjRDSg==
X-Received: by 2002:aa7:c7d4:0:b0:4fa:7679:d44c with SMTP id o20-20020aa7c7d4000000b004fa7679d44cmr3402124eds.11.1679415932175;
        Tue, 21 Mar 2023 09:25:32 -0700 (PDT)
Received: from [192.168.1.16] ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id a13-20020a509e8d000000b00501d73cfc86sm1483658edf.9.2023.03.21.09.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 09:25:31 -0700 (PDT)
Message-ID: <7c883bac-382c-b429-ab21-4675dce02474@gmail.com>
Date:   Tue, 21 Mar 2023 18:25:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/3] staging: greybus: use inline function for macros
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        johan@kernel.org, elder@kernel.org, vireshk@kernel.org,
        thierry.reding@gmail.com, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-pwm@vger.kernel.org, Julia Lawall <julia.lawall@inria.fr>
References: <cover.1679352669.git.eng.mennamahmoud.mm@gmail.com>
 <1274302b52ae905dab6f75377d625598facbbdf1.1679352669.git.eng.mennamahmoud.mm@gmail.com>
 <20230321154728.3r7ut3rl2pccmo2e@pengutronix.de>
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
In-Reply-To: <20230321154728.3r7ut3rl2pccmo2e@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On ٢١‏/٣‏/٢٠٢٣ ١٧:٤٧, Uwe Kleine-König wrote:
> Hello,
>
> just some nitpicks:
>
> On Tue, Mar 21, 2023 at 01:04:33AM +0200, Menna Mahmoud wrote:
>> Convert `to_gbphy_dev` and `to_gbphy_driver` macros into a
>> static inline function.
>>
>> it is not great to have macro that use `container_of` macro,
> s/it/It/; s/macro/macros/; s/use/use the/;
Okay, I will fix it.
>
>> because from looking at the definition one cannot tell what type
>> it applies to.
>> [...]
>> -#define to_gbphy_dev(d) container_of(d, struct gbphy_device, dev)
>> +static inline struct gbphy_device *to_gbphy_dev(const struct device *d)
> drivers/staging/greybus/gbphy.c always passes a variable named
> "dev" to this macro. So I'd call the parameter "dev", too, instead of
> "d". This is also a more typical name for variables of that type.
>
>> +{
>> +	return container_of(d, struct gbphy_device, dev);
>> +}
>> [...]
>>   };
>> -#define to_gbphy_driver(d) container_of(d, struct gbphy_driver, driver)
>> +static inline struct gbphy_driver *to_gbphy_driver(struct device_driver *d)
>> +{
>> +	return container_of(d, struct gbphy_driver, driver);
>> +}
> With a similar reasoning (and also to not have "d"s that are either
> device or device_driver) I'd recommend "drv" here.


please check this with Julia, because she said they should different.


Thanks,

Menna

>
> Best regards
> Uwe
>
