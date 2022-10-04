Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9893E5F462A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 17:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiJDPHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 11:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiJDPGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 11:06:48 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2E85BC16
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 08:06:42 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id a3so9505909wrt.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 08:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dWhjvi+RkdnGPd07wYz05EfDfCnGkyxqDggZwkXT7jU=;
        b=IqltpjHDo+BrQsmIWCKj9AS8GDc/lfJpyCWZC0v2tZr6Hpknr9p/7woR0LRK31owFY
         fvMgcrlsmNajjzAtqjsc+EOsnpemk1mWRChD0B+VSe3qVQG5wvSKA0v+1Aa0QbY/xauD
         4K/UvZQYQEr7+3l1EeS0APlyjXTLC3X6Aez7WM1+42LIqrsg2ixsTIPNtVNQrD8Bfc82
         diwMicSh0TluJjUgHAcvitCmja8mISi/U2h0UHDkZG24peAhVMlqb9bQzjw62zkQJfrN
         JByNrVMRMaOhYzsCNvHlAuEYAq+3JXbsYEW8cFuLyU0bf+3oDCNYuLNQZ1C/rLMMK6DD
         jtyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dWhjvi+RkdnGPd07wYz05EfDfCnGkyxqDggZwkXT7jU=;
        b=XU1J+yqsl8bHkT4SVSA9X06WebHlwfx5W7zMqr23a3FZNrty6tBcjIsKwhg1E+idp3
         +qqc/iokuteUlInqY0vYIZEieU5azlK9ytgecYumDhvU2lUOSKLN0KiZ0dIz/U8NUQpB
         Aq7KHc9nTUMLtJ8Znw9usn4Shv83kjelQLzXtejQ3aK6byI6gdaH5IDYFJG+NT24DKu5
         G+wffXhcpvjpx/3Q9SsP7OwePgedI5Ckbonv5wqlZCF8OeIbyUtCDN+z+LbEgKtCrYzR
         zHwe5roD91fNJBfZ3Y1w036ut6hgpCKOGIQd9LBFtcjDMdmNfcKbFHRjiP2LQGTHwNEc
         EoEg==
X-Gm-Message-State: ACrzQf2FZedhZfF5fWQYa01JUIkSMkaun3moh1W/7mrJHnLxG4huz3tO
        ZvcN8BlKX4SVj/MmUCsWDpMLjQ==
X-Google-Smtp-Source: AMsMyM4GTL+4JI+kqyEo598ZsbqyQHM0foO3bMnwqSvghAcAn8/Q2TXAoHnRTGGryhCMxljXivBG1A==
X-Received: by 2002:adf:fb84:0:b0:21a:10f2:1661 with SMTP id a4-20020adffb84000000b0021a10f21661mr16233305wrr.2.1664896001333;
        Tue, 04 Oct 2022 08:06:41 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c456:8337:99aa:2667? ([2a05:6e02:1041:c10:c456:8337:99aa:2667])
        by smtp.googlemail.com with ESMTPSA id v3-20020a5d6b03000000b0022860e8ae7csm5655794wrw.77.2022.10.04.08.06.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 08:06:40 -0700 (PDT)
Message-ID: <ff47d967-c2c2-60f6-6a70-66cfb417a9b0@linaro.org>
Date:   Tue, 4 Oct 2022 17:06:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [GIT PULL] thermal drivers for v6.1-rc1
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>
References: <58a7d685-e9e9-e47a-1e20-41b18302e6a7@linaro.org>
 <CAJZ5v0iMkQNwWPBegwpsr+CTtaUr_Eq=_CsQG3QSwdWEmOmPCA@mail.gmail.com>
 <088a8367-5ca4-674d-9d2f-411840d5a883@linaro.org>
 <CAJZ5v0jkbjogL79R2SOVvUVq1dRpYEGGeFS9Z_Gpd=OeKM9_bw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0jkbjogL79R2SOVvUVq1dRpYEGGeFS9Z_Gpd=OeKM9_bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2022 16:52, Rafael J. Wysocki wrote:
> On Tue, Oct 4, 2022 at 4:43 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 04/10/2022 16:36, Rafael J. Wysocki wrote:
>>> On Tue, Oct 4, 2022 at 11:41 AM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>
>>>>
>>>> Hi Rafael,
>>>>
>>>> this is a pull request for more thermal material for v6.1. I've dropped
>>>> the trip point rework as a lock issue has been spotted on exynos.
>>>>
>>>> Most of the changes are fixes. There are more pending changes for the
>>>> thermal drivers on the mailing list but they require some more review,
>>>> so they will have to wait for v6.2
>>>>
>>>> Thanks
>>>>      -- Daniel
>>>>
>>>> The following changes since commit 2e70ea7fb9873e642982f166bf9aaa4a6206fbec:
>>>>
>>>>      Merge branches 'thermal-intel' and 'thermal-drivers' (2022-10-03
>>>> 20:43:32 +0200)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>      ssh://git@git.linaro.org/people/daniel.lezcano/linux.git
>>>> tags/thermal-v6.1-rc1-2
>>>
>>> I don't think I can pull over SSH from a host where I don't have an account.
>>>
>>> Did you mean git.kernel.org?
>>
>> Yes, indeed :)
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tag/?h=thermal-v6.1-rc1-2
> 
> Well, that still didn't work, but I used this tag:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> tags/thermal-v6.1-rc1-2
> 
> and it worked.
> 
> So pulled, but let's make sure next time it's better, OK?

yes


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
