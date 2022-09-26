Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E585EB32C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 23:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiIZVdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 17:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiIZVdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 17:33:05 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731EE72FF9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 14:33:04 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id r3-20020a05600c35c300b003b4b5f6c6bdso4413939wmq.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 14:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=wIOOd0HRNKGuFy10Kz+AtlMUTzbAEKpZO8kvMRpugCM=;
        b=UDvIan2q9SCga0+Tn9DToxUhPulwHLSdXL+ydIL8Y5q51FUPUqRERQ0f5enFkrJebm
         4rF2zvx++aDiEfwBqHo5blTiPoh3MEWp3/8Ex5qHdS+mIFsXxczC87pXEczovaTwI7Bo
         Yi7+AOtiy6NJN53nDMBdXpxqv9w15RjfQbdm6/8NFeEgDTpr4th7Yktc7/ohwzx0UE/k
         Au2cf/Bhxd1cDU6CXGllSR0R1s/4dibBbk2LTu+UD/q04RWYm2+W2daWEEq+D4NbuNK/
         NQKCRaO0ujzZZSmCPZfXSTrLfzSA7IU1Q6rbXOc1u4iv41KA/WVhZEWiT+4KpXEbyx+0
         /g7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=wIOOd0HRNKGuFy10Kz+AtlMUTzbAEKpZO8kvMRpugCM=;
        b=jbrNw2ct6E4xwgj0kxB1KzxTZ8V5HAcT24BQcPANgKHdb+CpuhgtVwsFIsjxf6jdX6
         n397tbDZqzrbNWkLHeKfdKGHh7wjN3Iwd0gn4fL3VecHTEfE/eYASFtpJhzAojfAf/fe
         OEpgQShuC2FxXuWJEy8X3B8pwR65cR5EPvLekJUzOk0VpT4ODbWhUeHyeGQHFCOD5LSD
         hdXmRcqDjTENcX0zJtAuU4rhIRbxDO4Vu9YnyCk2tiUxU1+AfsghAdQmeUkR9aira3eW
         gojfiNDSbeLd2Ea7q2BaTUQJi6LjUGDj5uIU5SthRn32D6/8n88zefGovQG9HsAho8FV
         JFzw==
X-Gm-Message-State: ACrzQf2jADEC+Tytf2RerOEuvyu285RTXzbzEBaAGm9161xOV3iR1LDu
        VIBWoF/JkjKfLZfwn7C1/DRocw==
X-Google-Smtp-Source: AMsMyM6ynLkyoLOffipxKToiPzu+oKh9f/efArYITucPEwH3m3+s4ATbNos1kl8XmDwRpGhqZWDtGg==
X-Received: by 2002:a05:600c:2241:b0:3b4:88aa:dcba with SMTP id a1-20020a05600c224100b003b488aadcbamr416386wmm.203.1664227982899;
        Mon, 26 Sep 2022 14:33:02 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id g19-20020a05600c4ed300b003b4868eb71bsm13686989wmq.25.2022.09.26.14.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 14:33:02 -0700 (PDT)
Message-ID: <228f2d97-4816-bb37-f834-f9a2db59054a@linaro.org>
Date:   Mon, 26 Sep 2022 23:33:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 29/30] thermal/intel/int340x: Replace parameter to
 simplify
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rui.zhang@intel.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Antoine Tenart <atenart@kernel.org>
References: <20220926140604.4173723-1-daniel.lezcano@linaro.org>
 <20220926140604.4173723-30-daniel.lezcano@linaro.org>
 <YzHb50/4njPa1TR1@dev-arch.thelio-3990X>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <YzHb50/4njPa1TR1@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Nathan,

On 26/09/2022 19:05, Nathan Chancellor wrote:

[ ... ]

>> +	int34x_thermal_zone->ops = kmemdup(&int340x_thermal_zone_ops,
>> +					   sizeof(int340x_thermal_zone_ops), GFP_KERNEL);
>> +	if (!int34x_thermal_zone->ops)
>> +		goto err_ops_alloc;
> 
> I assume I was cc'd on this change due to my fix up patch:

> https://lore.kernel.org/20220923152009.1721739-1-nathan@kernel.org/

Yes, right, thanks for sending the fix.

> However, I don't see that applied here. I don't mind it being squashed
> in to keep the build as clean as possible through bisects.

Ok, that makes sense, I will merge with the change it fixes

> Additionally, I did a diff of v4 to v5 to apply on top of next-20220923
> and I noticed there were a significant number of places where there was
> whitespace added where it probably should not have been. 

Yeah, my git configuration does always trim the extra whitespaces when 
applying so I usually don't pay attention to that, but thanks for 
letting me know. I've probably something wrong with my emacs indentation 
setup

> Other than
> that, v5 works on all the machines that had issues so thank you for the
> quick fix!

Thanks for testing



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
