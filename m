Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2835F5FE3F0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiJMVMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiJMVMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:12:40 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFF3192B90
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:12:21 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id g9so2082577qvo.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VhdSaTr9lZQh5cYzAQHcQOcRplcOKFNVHqEgaa0+cVE=;
        b=Lq9rotAcSBAzJV6OVaX7W+7m/0q4zM+4jT2UBdjq7u5p8HkUHHq1zvU2ZAoKRf7ogv
         r/e/6O+cU1asm4JeDzxPQ1FLKPLCbRkFaKocwwaCpz7bMSuQrvW+uOV4x/A4V7EhSWdy
         3WbAZ+1fe380jgh7bkLmuz71T1HVhLiOwSBH0/zXkE2Yy0Xit1Dszu6yAtUSy2B/M5TJ
         sqRSQERc5ER5eCm9zeRk4rNv3rGYVO1XhbWrtXzMlXT9Z421rZ6mpQvg2givfmeVUBIR
         VBs9W4hHk1dPGKeGw0rFa2X5CovRiDDolTQobHobaIo8mRPJgqo8OqK8BCT6vlrtovLL
         MRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VhdSaTr9lZQh5cYzAQHcQOcRplcOKFNVHqEgaa0+cVE=;
        b=onuN6Ku1+pbQVpDcZ86cBEHpuGuyw1Q6m73+hak/vmJDWDX1UoSzp/aho6fwUcQnqm
         kLkB+Zz4bgkCcW+gudpFi+w/kbjiTbofs91BDauE+hCzGop7qtvTvaR80cHhzivCgY4P
         YO5pZp9CAepfoTVntd3eVsE+vjdoxcUAKvzx8LCtPZwaaoeS7HF9DqqJa2A1ysiFlaJU
         +/wmeqoTZ5Rafalkbq06bjJatCdJnCDghq4GJ8G+SQkA5WNRs3WSRlsvKCejrMF+MwEt
         AjOKZCr3z6qytqZv/jDt1N6DAVkmkPn701OphKhHerYV8VVdcI+uab9IWQwA7aHS7jRU
         Xa2g==
X-Gm-Message-State: ACrzQf1BqYDyAeTmq2AXSX9D7RksZmDGkY6sT/kvvW5z887icTxeCdlk
        vO3Io1bqezRe6960Z+RoSBQ=
X-Google-Smtp-Source: AMsMyM5zObA81qNXMxMFou3UXwHwqN5PSQTvCuQ5DbvSWYxGxXxC3f+FUdlV86IK2bqHLAwXETQxyA==
X-Received: by 2002:a05:6214:caf:b0:4b1:7904:5425 with SMTP id s15-20020a0562140caf00b004b179045425mr1541529qvs.32.1665695539366;
        Thu, 13 Oct 2022 14:12:19 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id s1-20020a05620a29c100b006eeb3165554sm762079qkp.19.2022.10.13.14.12.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 14:12:18 -0700 (PDT)
Message-ID: <4ce08aac-fda0-0db1-14e5-1d45d4421342@gmail.com>
Date:   Thu, 13 Oct 2022 14:12:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] MAINTAINERS: Move from git://github.com to
 https://github.com
Content-Language: en-US
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Conor Dooley <conor@kernel.org>, sbranden@broadcom.com,
        linux-kernel@vger.kernel.org
References: <mhng-216dc4fc-3a64-4ccb-b428-bbb13ce30199@palmer-ri-x1c9a>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <mhng-216dc4fc-3a64-4ccb-b428-bbb13ce30199@palmer-ri-x1c9a>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/22 12:38, Palmer Dabbelt wrote:
> On Thu, 13 Oct 2022 11:20:51 PDT (-0700), f.fainelli@gmail.com wrote:
>> On 10/13/22 10:02, Conor Dooley wrote:
>>> On Thu, Oct 13, 2022 at 08:32:58AM -0700, Palmer Dabbelt wrote:
>>>> Github deprecated the git:// links about a year ago, but it looks like
>>>> there's still a handful of them in the MAINTAINERS file.  Conor pointed
>>>> this out about the RISC-V KVM tree, but I figured it'd be better to 
>>>> just
>>>> fix them all -- I've got a bunch of insteadOf so I didn't even notice
>>>> the deprecation, but new contributors probably don't and might get a 
>>>> bit
>>>> confused.
>>>>
>>>> Reported-by: Conor Dooley <conor@kernel.org>
>>>> Link: 
>>>> https://github.blog/2021-09-01-improving-git-protocol-security-github/
>>>> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>>>> ---
>>>> @@ -3990,7 +3990,7 @@ M:    Ray Jui <rjui@broadcom.com>
>>>>   M:    Scott Branden <sbranden@broadcom.com>
>>>>   R:    Broadcom internal kernel review list 
>>>> <bcm-kernel-feedback-list@broadcom.com>
>>>>   S:    Maintained
>>>> -T:    git git://github.com/broadcom/mach-bcm
>>>> +T:    git https://github.com/broadcom/mach-bcm
>>>
>>> This link is dead, I can't find a repo with that name on their GitHub
>>> profile.
>>> @Florian, should this be updated to the stblinux repo instead?
>>
>> Yes this should be updated to the stblinux repository, thanks! If you
>> want to split on a per-maintainer basis, I can take the Broadcom entries
>> separately  through the Broadcom ARM SoC pull request, else:
>>
>> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> I'll split them up and send a v2.

It is fine either way with me, up to you.
-- 
Florian
