Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E9E6D867D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 21:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbjDETDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 15:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjDETDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 15:03:41 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F4A6E88
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 12:03:39 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id s13so21454761wmr.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 12:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680721418;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gmucir5jyM4jMHrONrMhWbS5Zw1yHw/RNM5pJeUcriQ=;
        b=XZbc2YhHoxJWcvIWYgoom1znxFSN4xi8BaxZ7VJ8am+/YXSfN16Eg6gEYhCKpEGX/R
         GpN+Z2bWqEBrK2X/g7LDSMcWHEk/O5NGLuGfGBlgmQwH4ZgzcnvmPKbQsjbM6fedbdmp
         Nel3IPB2Z1PSCTmCVlopSuPHDGFMAB+A9B7CwoHLVRaCde0zDZXSHWvKig3rxwgzGbhW
         D7LBYjrayFxd+HMp3dfAt7yoctVrbVe16fl/AlT6x3g4stY+Kc/JLHm8hRAxLThIRh6i
         KmSCNV8w8EI6Qh9su3vmifFMyqwAAs6cSMt8vLp5BNvdjAeh1ClQ4ZM8TGEnSChA1KZi
         kxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680721418;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gmucir5jyM4jMHrONrMhWbS5Zw1yHw/RNM5pJeUcriQ=;
        b=orsaE5knBVCuOyiNEXLisRa9zPg0z7MVDkx7ad3/FB/iOOl/eST8f2OQKum2yHaDjF
         F1sf3eIwHvnM4wLlWDokc1Q1sApYAwy7QEoRVMQFv2bNdJv/0KJzbhLokGyDQXJUHC4A
         pUvGej/doJxjX/5LcgpGpxbLomu7yTZV8ppl6AbKZNfph67XZulaD/eL/tWNOaKxSACc
         Mlf+4EmQCdjfJiy/V9kkkCbXGmk0n2XLqv26q0UlvA74FerVVSvNdmMhc1dGBFsS21Ds
         xLGq8oBdXcdb3JUy6bqgWurLcemwNLbh0MXzAKdR6pd7Xe5yaBdyvyWRSRR0BzDkA9VR
         fDWg==
X-Gm-Message-State: AAQBX9d89jQuj/hdu4nl3pz70l/i1jgl//hdLstfzr65Gka1W7nXam3U
        JfrlyrVULskWMvv1VlBF0fRJ6A==
X-Google-Smtp-Source: AKy350YpNGKeRKZP33gK9YmIL4mDmK+sRs8CyQw7mRzx2tHZ2G1FIcnA6cA++5fQtxzasIGUUFOhhQ==
X-Received: by 2002:a7b:c419:0:b0:3f0:3a43:aa70 with SMTP id k25-20020a7bc419000000b003f03a43aa70mr5251617wmi.24.1680721417541;
        Wed, 05 Apr 2023 12:03:37 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:6630:ee96:3710:24c8? ([2a05:6e02:1041:c10:6630:ee96:3710:24c8])
        by smtp.googlemail.com with ESMTPSA id t16-20020a05600c451000b003ef66c89af0sm6425837wmo.0.2023.04.05.12.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 12:03:37 -0700 (PDT)
Message-ID: <c230ab3a-9cc3-e989-1e49-7d38be471a5c@linaro.org>
Date:   Wed, 5 Apr 2023 21:03:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [GIT PULL] thermal for v6.4-rc1
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yang Li <yang.lee@linux.alibaba.com>
References: <ab323c72-61f9-9ac6-48ce-366f62e82091@linaro.org>
 <3e64e6b2-7c3f-d149-2f7d-6c41be4c4d14@linaro.org>
 <CAJZ5v0ji6SxrgiMRMwNDwGspxifo0FSi3d5+2O02SKM_q_OaFA@mail.gmail.com>
 <CAJZ5v0iNbA0rt3QyaFA7ved19yK8-nabyJi7yCfbnVKQaMPCmA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0iNbA0rt3QyaFA7ved19yK8-nabyJi7yCfbnVKQaMPCmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2023 20:48, Rafael J. Wysocki wrote:
> On Wed, Apr 5, 2023 at 8:39 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Wed, Apr 5, 2023 at 8:32 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>>
>>>
>>> Hi Rafael,
>>>
>>> just a gentle reminder
>>
>> This is in my linux-next branch, I'll merge it into thermal tomorrow.
>>
>>>   because more material will come in the next days
>>
>> So why can't it wait?
> 
> BTW, I get a merge conflict in
> drivers/thermal/mediatek/auxadc_thermal.c on an attempt to merge
> thermal/linux-next into my linux-next branch.

Ah?

I did an update and rebased thermal/linux-next on top of 
linux-pm/thermal without conflict

Is it possible you have a change in a different branch conflicting with it ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

