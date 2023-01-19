Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC20D673B55
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 15:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjASOJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 09:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjASOI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 09:08:56 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48669577FB
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 06:07:54 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id h16so1950302wrz.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 06:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HGeDeVwuQc3H2AtP0kFhOH1dH/kCaJpXBCxGVVfYvqI=;
        b=p9KNOOF9WyUBlnr0e1jSHHOVjYq1gZMPPgIX6LNhGVxRpFhtQU+0xS3ceNhnYLHXaV
         0zGMVv31mS7DB/LueUWi3pd1WqmxUtDmVibpC4tWKKKyF3fhIJsxGFhoPwqqcCPXHww3
         4XG6++YzGGl1gDE4Fk1ROfrMfj/Llhpbz9q/hdD2abZBAhVYtDiTicsZhI4WV/JC9L9B
         /5mmaugTgC/oGMLB3wau972Lmwqhs3RZqlYnBAg2JwMd2SiGwKVLArqNpI3uK1/9QHy3
         H3uIFbbYwivuwA1/35HyUUBenllM0KTc9YrfstbcIQWouNmFWLAIv3OQdcuIC9I78cjI
         0ntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HGeDeVwuQc3H2AtP0kFhOH1dH/kCaJpXBCxGVVfYvqI=;
        b=xVdYiXYuxS/qUSG801QgVrCJrX8QYIxZCTBwz+s/YAtv1bvuXYo1iOrtbykL6krKjl
         5eWOcJVXjSd3FJ4zqNXTn6c/5UuBN6p0opEZ4UDNZWyQ4iEHd9KflubBQF63OBweRruE
         LOavf+ASgVxAiTZ8WlUjVxe32NAjPciGXvw8gyingmjIPoU5mBbueQUSYK/VhYL1kOFA
         jpdAVurApTDBNK/kW0W9VxfgbKl04rZQZ2spQzGRfRdx542XKwckyprZA/V973ZID5SJ
         L+jlZqV7zPgsY8ZuEeAL4Xj3hdnbUKAfH5L16lgBgdB1y+t1uQVyOK79rE7t+YO09ZMb
         iKHg==
X-Gm-Message-State: AFqh2kprqQOOX+Pd1tmGAqKqXsc3dkI+wO6DrcQko7spssww6K/rP8KO
        cka37tjMSbiCY/4xTV4+sWH0UHyj9ONOvrxY
X-Google-Smtp-Source: AMrXdXtR3I2cegmfLtK3MsfPKnGq9FPE0PF40uH9KT0VrCFbvPlr5aepLZXPx7ur7NebX+sDsrYlKw==
X-Received: by 2002:adf:ff90:0:b0:2bd:de40:3a45 with SMTP id j16-20020adfff90000000b002bdde403a45mr9225071wrr.51.1674137247647;
        Thu, 19 Jan 2023 06:07:27 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id f7-20020a5d6647000000b002bbeb700c38sm28731082wrw.91.2023.01.19.06.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 06:07:27 -0800 (PST)
Message-ID: <5a4c029b-cb1d-ef76-45b6-4c080ed1b621@linaro.org>
Date:   Thu, 19 Jan 2023 15:07:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/5] thermal/core: Fix unregistering netlink at thermal
 init time
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230118211123.111493-1-daniel.lezcano@linaro.org>
 <CAJZ5v0h-QkrgyLYLn9S_mkWN5nN1fUXej8zmarU425xW-Lei0Q@mail.gmail.com>
 <5f90aef1-93e1-832a-6cee-6e2cb4d7ec25@linaro.org>
 <CAJZ5v0g+E9C_ruDZ-8zYxsR-+HCO_M__v9SNb_Kr_UL3B6ud0Q@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0g+E9C_ruDZ-8zYxsR-+HCO_M__v9SNb_Kr_UL3B6ud0Q@mail.gmail.com>
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

On 19/01/2023 14:45, Rafael J. Wysocki wrote:
> On Thu, Jan 19, 2023 at 2:40 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 19/01/2023 14:28, Rafael J. Wysocki wrote:
>>> On Wed, Jan 18, 2023 at 10:11 PM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> The thermal subsystem initialization miss an netlink unregistering
>>>> function in the error. Add it.
>>>>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>
>>> What tree is this series based on?
>>
>> It is based on
>> https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/log/?h=thermal/linux-next
> 
> OK
> 
> Can this information be added to the patches or to a cover letter of
> the series next time?

Sure

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

