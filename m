Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478B9748905
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 18:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjGEQOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 12:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjGEQOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 12:14:03 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B54D1700;
        Wed,  5 Jul 2023 09:14:02 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5700b15c12fso83297937b3.1;
        Wed, 05 Jul 2023 09:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688573642; x=1691165642;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gw0Zxy/BztVceHNcMVwFl+OZGpEJCXfDTHiq05LhgNY=;
        b=cwhVaL0WPmlt6G8uw55JHBvxf0gLJlkWQVyU97BY6hKoJcWlzXWTGwsLOY9QO2GNOV
         WduX2BNFm83bvQJ7NpFcmMWKYeakc6QWPMh9EJ4fd/3xTZs6v04IyqDDPiA0bEpvO9oC
         by4Z5xMdC+Dj2KPnmeLiGRUG1SkHtLmEoDEyUmVE9fk7J2assaapvKvhd2bJ9B/lUk7p
         IHep/QC/pvff7OUQHSF5WZz/+Mij6dP86h3bL9uden6A8GI7TGh1OGbet7lkwvxN7Cnj
         bvpDtMnGcX4QqTriMDyDaDQzBGqmPj2QeG/R89pVviI6SITGHYJ1TAO3HY6X86GHpl3a
         b88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688573642; x=1691165642;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gw0Zxy/BztVceHNcMVwFl+OZGpEJCXfDTHiq05LhgNY=;
        b=BAcEDxLeeCPxgW0PbU0Odx8F5ApbRUodhEWcKqCY/nrfOf1piplhK9QBBLjdau1axG
         RQTPnzQWzkG39moJ2ANMFk3KHDWpJc3Kzw0tn8fC+xOFDmkW76MwVRKkdRY12LaPAtXj
         L1Ysxp7PHJpq4Q2HBro/fnSKmXc4Fvnq8mhDCwiY01sR8wSTH8OizgJEbejnnImLWfFB
         5Fnwrv241FTw0aQtU9hwV9Xnvxgr34ZxkVXdGy+sTP4jjTLd0hWIQKS74SEmHHM8K6gS
         VaWIViZZC4HsXM2VdKWyB+oQ3dufsJI80N759KYVKxIRdT4GELCJ2oAIXrTTjOO6x6qb
         wKuQ==
X-Gm-Message-State: ABy/qLb7fepOcY9E5Levpoq/AkT3+2KAsTMKAst/hqJVP1lxWg535QF2
        7JZMRecRmVe6hNeKWo8j7S4=
X-Google-Smtp-Source: APBJJlHxEL2paOtCv9rxpg7Abk1vFgYqFDHbvEfj/0Lp0TueL+kAX91299cyBSuzGI7RjBJ5IXwrVg==
X-Received: by 2002:a81:6c0a:0:b0:57a:135a:1bd6 with SMTP id h10-20020a816c0a000000b0057a135a1bd6mr7177738ywc.42.1688573641715;
        Wed, 05 Jul 2023 09:14:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i18-20020a0ddf12000000b0057328423a05sm6207948ywe.80.2023.07.05.09.13.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 09:14:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2bbf215e-840d-138b-511f-b2602a3eeda8@roeck-us.net>
Date:   Wed, 5 Jul 2023 09:13:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20230704084611.071971014@linuxfoundation.org>
 <824705ec-38ca-1587-573c-595b146ee2e1@roeck-us.net>
 <2023070529-barcode-unpleased-5705@gregkh>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 6.1 00/13] 6.1.38-rc2 review
In-Reply-To: <2023070529-barcode-unpleased-5705@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/23 09:06, Greg Kroah-Hartman wrote:
> On Wed, Jul 05, 2023 at 07:23:30AM -0700, Guenter Roeck wrote:
>> On 7/4/23 01:48, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 6.1.38 release.
>>> There are 13 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Thu, 06 Jul 2023 08:46:01 +0000.
>>> Anything received after that time might be too late.
>>>
>>> The whole patch series can be found in one patch at:
>>> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.38-rc2.gz
>>> or in the git tree and branch at:
>>> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
>>> and the diffstat can be found below.
>>>
>>> thanks,
>>>
>>> greg k-h
>>>
>>> -------------
>>> Pseudo-Shortlog of commits:
>>>
>>> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>       Linux 6.1.38-rc2
>>>
>>> Linus Torvalds <torvalds@linux-foundation.org>
>>>       gup: avoid stack expansion warning for known-good case
>>>
>>
>> I am a bit puzzled by this patch. It avoids a warning introduced with
>> upstream commit a425ac5365f6 ("gup: add warning if some caller would
>> seem to want stack expansion"), or at least it says so, but that patch
>> is not in v6.1.y. Why is this patch needed here ?
> 
> It isn't, and was dropped for -rc2, right?
> 

The above is from the -rc2 log so, no, it was not dropped. I checked in the
repository to be sure. It is also in v6.3.12-rc2 and v6.4.2-rc2, but there
it makes sense because a425ac5365f6 was applied/backported to those branches.

Thanks,
Guenter

