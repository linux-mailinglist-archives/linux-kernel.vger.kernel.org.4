Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AC06D1AAF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 10:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjCaIpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 04:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjCaIpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 04:45:30 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E341D92C
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 01:45:06 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id l12so21592821wrm.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 01:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680252290;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xxyqdIn+bk4QczcFBL4xE02Qvuk54XzxnYqApbWmQ7E=;
        b=T/C6VRoG0clsKlt9wMakpFmsJW9/eJik5Xxo338Tq2stTAGKoyZqJ6beLQsP5VWvmP
         dnvxyj9mU8lu8qyu+XXGY6Fyx7sBjawIsbGYMz4LNzyOGlJ4zg5hf9SLtX0BNdWP1BSv
         /JAgcDA9GTBLjNk7RJBvssxuXZXcTKGC2xEsWmXKM8OflqZC/C7s03VavwsBazeW+fp/
         VFAn8Anm+CA3IjUlG62nkGRaMFO+uQBHQj+LBuyZoa7Zvmrv74uKnQWuiaYmIGmaoj/5
         HsCAL59OWnPfxc3crmgdXrBL0cCCvJ8Z6TD5FAXvAjNxaRdyyQGyHm1UNvm6H0lI9Sx3
         R5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680252290;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xxyqdIn+bk4QczcFBL4xE02Qvuk54XzxnYqApbWmQ7E=;
        b=IJlY6pW++fm+qtGYSJZGfMOHWnHKdmAwZvkEX6YRL/NXYKoXYPheE7yJXAYp5td6Sj
         izCypN9Vv1CYDRyCWXWWLAmZvORKWp3AYUacaaFMJPpDgM3ZwvRHJAgFQk9HqyOYS15N
         wI7+I6x5W2cgR09wdBHYlBXhReqFWNEviNi1OMaPahIr+ND7ML3TAKQ9RzpMqVAgygzg
         fekoHFiOQ3awWB0wvbX5BMmIjGtA3eaBa3/vbsMoghxVlGfJPmuMF8a6aCAW3gVjRHJr
         ImnuxXdZ9T7++T7cS+nVkLYHkymCSXFjZLFdLD7rDOqbiN8cgu3Vz7TuKy+i72VgmpRi
         e34Q==
X-Gm-Message-State: AAQBX9f/oSB/Egef9CjkFb4sA143LVPP7IDcCR/RVZnYkAWBy5kV2Hx2
        RN6lkdwJfP6MkawQCg+ce0qAkg==
X-Google-Smtp-Source: AKy350ZHxE08ANZvF4H7bloNjkiIkHgIWRHOGVefKapS/JJkMMHtS7CHxDmiDoX5QSSpdo+bvMN3Pw==
X-Received: by 2002:adf:d08e:0:b0:2cf:f312:86dd with SMTP id y14-20020adfd08e000000b002cff31286ddmr17970572wrh.18.1680252290022;
        Fri, 31 Mar 2023 01:44:50 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:17ff:909e:1b73:8366? ([2a05:6e02:1041:c10:17ff:909e:1b73:8366])
        by smtp.googlemail.com with ESMTPSA id m7-20020a5d56c7000000b002cea9d931e6sm1590350wrw.78.2023.03.31.01.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 01:44:49 -0700 (PDT)
Message-ID: <f4592c81-af30-8289-d02d-a44e25e0fe26@linaro.org>
Date:   Fri, 31 Mar 2023 10:44:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] thermal: Use of_property_present() for testing DT
 property presence
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh@kernel.org>
Cc:     Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org
References: <20230310144726.1545543-1-robh@kernel.org>
 <CAJZ5v0hAeRa9xsp6-_um9j-9F6nf=PYuOC2mgMAmmUHP+9=RZg@mail.gmail.com>
 <CAJZ5v0i-Vum+js8c7fZJiQWwTBYByy2O=UtObR6GciLMLt41Nw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0i-Vum+js8c7fZJiQWwTBYByy2O=UtObR6GciLMLt41Nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2023 19:28, Rafael J. Wysocki wrote:
> On Mon, Mar 27, 2023 at 7:13 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Fri, Mar 10, 2023 at 3:48 PM Rob Herring <robh@kernel.org> wrote:
>>>
>>> It is preferred to use typed property access functions (i.e.
>>> of_property_read_<type> functions) rather than low-level
>>> of_get_property/of_find_property functions for reading properties. As
>>> part of this, convert of_get_property/of_find_property calls to the
>>> recently added of_property_present() helper when we just want to test
>>> for presence of a property and nothing more.
>>>
>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>
>> Daniel, are you going to apply this, or should I take it directly?
> 
> Applied as 6.4 material, thanks

Sorry, I forgot to answer. I already applied it.

Shall I drop it from my branch ?

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

