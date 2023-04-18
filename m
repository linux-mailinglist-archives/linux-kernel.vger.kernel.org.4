Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3B96E68CE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjDRQAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjDRQAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:00:40 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E973126
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:00:38 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-760dff4b701so7633639f.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1681833638; x=1684425638;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u8vIx9VD69R5bl816uCq1MsKC8zfiH5dORjrGjoaGtY=;
        b=LcNfV6J/hOT4U4V5YSIrHJg+k2afxlWk76X6lPxP3DKlE812oDkhNWz6eF4orhsL0r
         4ElzGOLA/5HobIfrM7ku0xNPErK5kzrk+cRlH3zUQBYeu45nXbUi/ezMVse8C5uE44yc
         Z4hXceAExB47vjOMGLIpohbDnq6w+6xkOs7Tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681833638; x=1684425638;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u8vIx9VD69R5bl816uCq1MsKC8zfiH5dORjrGjoaGtY=;
        b=ZB7axsAFc2jHNiEfpf4VCDqsIdjbYo0v4Htp1a6qbv0kw6WDkInfyGXckiwhfTmtdw
         fzV4KTNU3chRAGzRjpc2ykoMsc8JFmfk3ZzyDFr1/r22QiOrwejnGgDr2TjP5c8Z5nj3
         At9uIMpq5fxCwase8P+o58FHbC6NjOz3i1LWesHLjQ1LvnJtOPHkzuSs9bXeJxA5jHGX
         OIzGf1tLWAmgeMz/7e1bALC8/d4HQSZce/5vL+is1iD5Kdv59zCS4BXanrO9nNEeTqxL
         TG09fveR8g9K+A+SrzY3IQQlPrlh9SXxBZfHo8AHoHL6mtiFG2N4H2/sGa90GGoS7pmm
         BeKg==
X-Gm-Message-State: AAQBX9d783DixOlfl6Hzt2wWa/aq1pvciPRN1b+Db0TwiWr101bDXmdo
        3U5sQ6Nysr3k1DK+7ulyqJ46QA==
X-Google-Smtp-Source: AKy350ZtDcSSpat2zK7P5rG1w4pfGmcwXAGF5Km2FaZkhxyyRY0fqp+b43olWHJTvdwgY9NATmEscQ==
X-Received: by 2002:a05:6602:360f:b0:763:6aab:9f3e with SMTP id bc15-20020a056602360f00b007636aab9f3emr743540iob.1.1681833637764;
        Tue, 18 Apr 2023 09:00:37 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id l3-20020a056638144300b0040fa3029857sm2060118jad.128.2023.04.18.09.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 09:00:37 -0700 (PDT)
Message-ID: <05ebc19b-d497-ad10-b44d-35740d965627@linuxfoundation.org>
Date:   Tue, 18 Apr 2023 10:00:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 5.10 000/124] 5.10.178-rc1 review
Content-Language: en-US
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230418120309.539243408@linuxfoundation.org>
 <CA+G9fYsA+CzsxVYgQEN3c2pOV6F+1EOqY1vQrhj8yt1t-EYs7g@mail.gmail.com>
 <2023041819-canyon-unarmored-38c6@gregkh>
 <CA+G9fYuSwpBW-_PubGFYsKi08=KrmsR=g9D4HDOvZP5pd4t0MQ@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CA+G9fYuSwpBW-_PubGFYsKi08=KrmsR=g9D4HDOvZP5pd4t0MQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/23 09:45, Naresh Kamboju wrote:
> On Tue, 18 Apr 2023 at 21:04, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>
>> On Tue, Apr 18, 2023 at 08:38:47PM +0530, Naresh Kamboju wrote:
>>> On Tue, 18 Apr 2023 at 18:03, Greg Kroah-Hartman
>>> <gregkh@linuxfoundation.org> wrote:
>>>>
>>>> This is the start of the stable review cycle for the 5.10.178 release.
>>>> There are 124 patches in this series, all will be posted as a response
>>>> to this one.  If anyone has any issues with these being applied, please
>>>> let me know.
>>>>
>>>> Responses should be made by Thu, 20 Apr 2023 12:02:44 +0000.
>>>> Anything received after that time might be too late.
>>>>
>>>> The whole patch series can be found in one patch at:
>>>>          https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.178-rc1.gz
>>>> or in the git tree and branch at:
>>>>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
>>>> and the diffstat can be found below.
>>>>
>>>> thanks,
>>>>
>>>> greg k-h
>>>
>>> Following build errors noticed on 5.15 and 5.10.,
>>>
>>>
>>>> Waiman Long <longman@redhat.com>
>>>>      cgroup/cpuset: Change references of cpuset_mutex to cpuset_rwsem
>>>
>>
>> That's a documentation patch, it can not:
> 
> Sorry for my mistake in trimming the email at the wrong place.
> 
> I have pasted down of the email as this suspected patch,
> 
> cgroup/cpuset: Add cpuset_can_fork() and cpuset_cancel_fork() methods
> commit eee87853794187f6adbe19533ed79c8b44b36a91 upstream.
> 
> 
>>> kernel/cgroup/cpuset.c: In function 'cpuset_can_fork':
>>> kernel/cgroup/cpuset.c:2941:30: error: 'cgroup_mutex' undeclared
>>> (first use in this function); did you mean 'cgroup_put'?
>>>   2941 |         lockdep_assert_held(&cgroup_mutex);
>>
>> Cause this.
>>
>> What arch is failing here?  This builds for x86.
> 
> Not for me.
> 
>

It is failing for me on x86_64 with CONFIG_CGROUPS=y
and CONFIG_CGROUP_CPUACCT=y

kernel/cgroup/cpuset.c: In function ‘cpuset_can_fork’:
kernel/cgroup/cpuset.c:2941:30: error: ‘cgroup_mutex’ undeclared (first use in this function); did you mean ‘cgroup_put’?
  2941 |         lockdep_assert_held(&cgroup_mutex);
       |                              ^~~~~~~~~~~~
./include/linux/lockdep.h:393:61: note: in definition of macro ‘lockdep_assert_held’
   393 | #define lockdep_assert_held(l)                  do { (void)(l); } while (0)
       |                                                             ^
kernel/cgroup/cpuset.c:2941:30: note: each undeclared identifier is reported only once for each function it appears in
  2941 |         lockdep_assert_held(&cgroup_mutex);
       |                              ^~~~~~~~~~~~
./include/linux/lockdep.h:393:61: note: in definition of macro ‘lockdep_assert_held’
   393 | #define lockdep_assert_held(l)                  do { (void)(l); } while (0)

thanks,
-- Shuah

