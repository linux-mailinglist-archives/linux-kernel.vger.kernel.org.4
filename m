Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E78873A889
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 20:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjFVSqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 14:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbjFVSqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 14:46:47 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43352118
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 11:46:36 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-338bd590bc1so5145055ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 11:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1687459596; x=1690051596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=manSCipOOhmWOPB1AQ+dPEX6xxX8Josbxr+cGJcmDTw=;
        b=BF0clXInxT/cyf32LbIk93WOsKiO08d4WNaZaiK5Jlzy1NZ1uHoiZtnlIMZuCQfkrD
         6KiPrvyI1cIyL440IlfvkV9mvxuiTnRSaZLjGM/R0LrSfRjkmYtiI2O4Cuqh7KUZlDen
         CDCI52XDqLUV16ARPWW5rdJnTccK6UKgy3aLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687459596; x=1690051596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=manSCipOOhmWOPB1AQ+dPEX6xxX8Josbxr+cGJcmDTw=;
        b=dv9ulvsnEEVSvLbs9RnolaAn3bAr8er1KqNSJO00NkYvduPQaDQMWhek0vsiwc3D1c
         VMxuRPXDDloV7pd+52K+tK9v3059GIy0aHmz6KOn0gpT8yxFzn4hei1dzNlTs6ck93mv
         vsRVSwFuNw23CoW0PGcVLzIzmQqRgPYAuX3BoiCtk4VHcfBlQGd0eykFNSqZdon9pA/y
         NEC5ost+RjKEAABYmruvXZpBD1Kuyk4gYu+dkR+LeDxryv+TUHXJZ8iTmuLB0t8pRa1e
         MUAfq879AvfS2OcIaJGUdoMu6ee/kWqORS2HXL/IurLTQbkFF9/X/30BJaAMPxBddCpV
         DZZg==
X-Gm-Message-State: AC+VfDx4DjhY37tSrRfM5lyET2S+dqDmykYygXFKm3UVpP+dkOjflPzV
        T1dvXMtnE/euk6eoBzLGWANzcQ==
X-Google-Smtp-Source: ACHHUZ5qRksVQUc529ilEx05M1/JeEvBhIQIatLjK3cFdJpcMXoMxSJVzYBIbdbPXvmVV1YjZ8jF/g==
X-Received: by 2002:a92:740d:0:b0:338:4b36:5097 with SMTP id p13-20020a92740d000000b003384b365097mr18131055ilc.1.1687459596143;
        Thu, 22 Jun 2023 11:46:36 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id x10-20020a92060a000000b0034255d2d3c5sm2143703ilg.48.2023.06.22.11.46.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 11:46:35 -0700 (PDT)
Message-ID: <74c961a0-4a36-51db-5ed7-6f0185e499ce@linuxfoundation.org>
Date:   Thu, 22 Jun 2023 12:46:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5.15 000/107] 5.15.118-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230619102141.541044823@linuxfoundation.org>
 <f7bf3aa8-f1b8-a1b5-8e51-46d51d002633@linuxfoundation.org>
 <2023062150-expansive-polygon-7b5f@gregkh>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <2023062150-expansive-polygon-7b5f@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/23 07:59, Greg Kroah-Hartman wrote:
> On Tue, Jun 20, 2023 at 03:04:12PM -0600, Shuah Khan wrote:
>> On 6/19/23 04:29, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 5.15.118 release.
>>> There are 107 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
>>> Anything received after that time might be too late.
>>>
>>> The whole patch series can be found in one patch at:
>>> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.118-rc1.gz
>>> or in the git tree and branch at:
>>> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
>>> and the diffstat can be found below.
>>>
>>> thanks,
>>>
>>> greg k-h
>>>
>>
>> Compiled and boots, but doesn't get to login prompt. Keeps running
>> into NMIs and watchdog detects had lockups.
>>
>> I am starting bisect and will keep you updated.
> 
> Very odd, let me know what you find, thanks!
> 
> greg k-h

Bisect flagged the following commit and I don't think
this commit could be the cause on an AMD system

# first bad commit: [17627e3f8f0cca041becbec376c07724968c1bf5] of: overlay: rename variables to be consistent

Please go ahead with the release. I will keep debugging.

thanks,
-- Shuah


