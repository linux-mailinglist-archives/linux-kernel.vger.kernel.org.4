Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89066A0DB3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 17:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbjBWQSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 11:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbjBWQSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 11:18:12 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C60826CCF
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 08:18:11 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id a1so5527717iln.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 08:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W7ieouCKWdhpuzaMjYjba2gKOz+Qqhrfpk7U3BSTOec=;
        b=No6oKmfN4x6eJuUxjeg+awuo12e0WHfh/o+SY7h8nvNY5mihD6tx+PByXEq8TXcUFv
         p/AQtsWPFO1Oh5/nYjJwspByaFBaXrGOHX0OZp+LYGXypYnHP/KOkJG0YnALaVzOp5O8
         /aqh6TC0HgBkV5syOKaGqznjtsV73tEHk9eb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W7ieouCKWdhpuzaMjYjba2gKOz+Qqhrfpk7U3BSTOec=;
        b=XspvOVQoQ7rD2Yk8w0k+Bnn6raQzXR8szO07rTX27s54oy+8ar4YVKzh1X/GfH5qQf
         qQWw/Mhnp/sdjZgTuFZtOyEKUrxP24qz/iqa2h1KHjC9GmVCIaEHI03SpbfQ+5YkCDZ9
         V7XJTEh9S3/t3iGc5ehUCBD6tWUpCM36zvnlqBn5zL2mha1QRgmBEqlgetVJYIMe+oEg
         knNzqvwZ5KmQ99LkyA/x+FlwCdTZFtOiHDD4aRaETavi6gduVUsAmluPfo4m+/ISHTb5
         h4OlUqq1NcrO6ye8/GxiD4rRSR3rKaQWpdP1uEmPAKAE8yXXNBiJKKzFfZJiyZNqY0dp
         OJTQ==
X-Gm-Message-State: AO0yUKVZTtdrgGGNxX/5/X0Gh7XPZV868U/UUh06V1pzS6srnqOjOVN8
        fA1cplkqNhkUqjnXbumkd8EDjw==
X-Google-Smtp-Source: AK7set8qhFbJuco+MFTgNVRUaFsTJ95/BcGOdXwLieY1yZ/ZZdlBgdiqTnYID406G66YejOhPIBrcA==
X-Received: by 2002:a05:6e02:1051:b0:317:4fc:a70c with SMTP id p17-20020a056e02105100b0031704fca70cmr862681ilj.0.1677169090588;
        Thu, 23 Feb 2023 08:18:10 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id m18-20020a056e020df200b00315785bfabfsm3546590ilj.47.2023.02.23.08.18.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 08:18:10 -0800 (PST)
Message-ID: <b1552656-7af0-42cf-017e-df919b0d0585@linuxfoundation.org>
Date:   Thu, 23 Feb 2023 09:18:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 5.15 00/37] 5.15.96-rc2 review
Content-Language: en-US
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        llvm@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <20230223141542.672463796@linuxfoundation.org>
 <CA+G9fYuhcaYO1m29-9vQr-HK7_xJYouAAkM=ouMYzOBk+otCVg@mail.gmail.com>
 <d8032a63-64e2-0769-55d7-60f9b2f46a01@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <d8032a63-64e2-0769-55d7-60f9b2f46a01@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/23 08:45, Shuah Khan wrote:
> On 2/23/23 08:40, Naresh Kamboju wrote:
>> On Thu, 23 Feb 2023 at 19:46, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>>>
>>> This is the start of the stable review cycle for the 5.15.96 release.
>>> There are 37 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Sat, 25 Feb 2023 14:15:30 +0000.
>>> Anything received after that time might be too late.
>>>
>>> The whole patch series can be found in one patch at:
>>>          https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.96-rc2.gz
>>> or in the git tree and branch at:
>>>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
>>> and the diffstat can be found below.
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> Following build warnings / error notices on 5.15-rc2
>> anyone see these build issues ?
>>
>> scripts/pahole-flags.sh: 10: scripts/pahole-version.sh: Permission denied
>> scripts/pahole-flags.sh: 12: [: Illegal number:
>> scripts/pahole-flags.sh: 16: [: Illegal number:
>> scripts/pahole-flags.sh: 20: [: Illegal number:
>> scripts/pahole-flags.sh: 10: scripts/pahole-version.sh: Permission denied
>> scripts/pahole-flags.sh: 12: [: Illegal number:
>> scripts/pahole-flags.sh: 16: [: Illegal number:
>> scripts/pahole-flags.sh: 20: [: Illegal number:
>> scripts/pahole-flags.sh: 10: scripts/pahole-version.sh: Permission denied
>> scripts/pahole-flags.sh: 12: [: Illegal number:
>> scripts/pahole-flags.sh: 16: [: Illegal number:
>> scripts/pahole-flags.sh: 20: [: Illegal number:
>> sh: 1: scripts/pahole-version.sh: Permission denied
>> init/Kconfig:97: syntax error
>> init/Kconfig:96: invalid statement
>> make[2]: *** [scripts/kconfig/Makefile:87: defconfig] Error 1
>>
>>
>> Need to bisect
>> -- 
>>
>> commit 54fab3cc806aec70d7ce8440e511d56bd53a4081
>> Author: Nathan Chancellor <nathan@kernel.org>
>> Date:   Tue Feb 1 13:56:21 2022 -0700
>>
>>      kbuild: Add CONFIG_PAHOLE_VERSION
>>
>>      commit 613fe169237785a4bb1d06397b52606b2967da53 upstream.
>>
>>      There are a few different places where pahole's version is turned into a
>>      three digit form with the exact same command. Move this command into
>>      scripts/pahole-version.sh to reduce the amount of duplication across the
>>      tree.
>>
>>      Create CONFIG_PAHOLE_VERSION so the version code can be used in Kconfig
>>      to enable and disable configuration options based on the pahole version,
>>      which is already done in a couple of places.
>>
>>      Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>>
>> -- 
>> ls -l   scripts/pahole*.sh
>> -rwxr-xr-x 1 naresh naresh 610 Feb 23 21:03 scripts/pahole-flags.sh
>> -rw-r--r-- 1 naresh naresh 269 Feb 23 21:03 scripts/pahole-version.sh
>>
>>
>>
>> -- 
>> Linaro LKFT
>> https://lkft.linaro.org
>>
> +1 seeing the same:
> 
> ./scripts/pahole-flags.sh: 10: ./scripts/pahole-version.sh: Permission denied
> ./scripts/pahole-flags.sh: 12: [: Illegal number:
> ./scripts/pahole-flags.sh: 16: [: Illegal number:
> ./scripts/pahole-flags.sh: 20: [: Illegal number:
> 
> 

Okay figured out problem now. scripts/pahole-version.sh isn't executable.
Once I made that change make is working now:

chmod +x scripts/pahole-version.sh

thanks,
-- Shuah
