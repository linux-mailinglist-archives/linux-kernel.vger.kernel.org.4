Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDDD643B90
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 03:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbiLFCwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 21:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbiLFCv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 21:51:58 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B2EF21
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 18:51:57 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id x13so5970902ilp.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 18:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V3MdnT2Q8jLXM5s//gvYhHT+ZNu/mw7aKngm+TpuXkY=;
        b=hljquEFxWH9gVm57LzSmKa5Boz6niaLrsVzNGCkHuXXgG5fmUXJSOBgnQgNm+WEyJh
         QwdafYwlneQ2GWZ4PuokY3E6jUevpx9z5rKxnDS4j/d7P1znBQ82Vw5FGDtrktYlbusb
         v8vk/BkqaPmWIl0uM5gfzRIGko6MGtsZPdAlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V3MdnT2Q8jLXM5s//gvYhHT+ZNu/mw7aKngm+TpuXkY=;
        b=iHktcaBbhzC48tfhzQJ/cz404VHr831XAKy0OYAV97+2hbWDd2QvXea98KAHwyYk67
         g0YLJK9NE75IYgZlGLvKE4pnn2UM/9+fy+mjNQhfKcOxH55HUjPCnrPvnDmYyCS5AJ25
         hyilu6rj5fFNpWXGlXS5TC6l+Ai/VDE7jeZPo6gR6XQOIuTOhUmeYxXaavpZe8lBf48M
         63N+7fSWw7BT5h3+ju46vbeedJxfVj87qwJ/x/s6ZyN3AGK87KQs+G4NmxnZkMhxab2M
         6V15Ph/LOK/1ywcd+VH9YPiho/vZa6U7Gr9XUpuvJVY0y/XhhzS2WmfysD7PowrXMbC9
         cSBA==
X-Gm-Message-State: ANoB5pl5lSEQ8ZWBNo9RyhuxDa2dO+RN6+tBEbgKRosKjj26HOGpgLU1
        xE2NuhSzkSltDGd3e2qefPOWeq9iz60NzMwV
X-Google-Smtp-Source: AA0mqf4vnfK6800d5tmO8ssv2j07jmhTqhELwF6Y2JSA95pjebZYddw96ZCfwuZg/w58xuaEIu4Lwg==
X-Received: by 2002:a92:db42:0:b0:303:26c0:e1fe with SMTP id w2-20020a92db42000000b0030326c0e1femr13434267ilq.102.1670295117272;
        Mon, 05 Dec 2022 18:51:57 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id n12-20020a92d9cc000000b002f966e3900bsm5672414ilq.80.2022.12.05.18.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 18:51:57 -0800 (PST)
Message-ID: <33b0b34b-8d51-a0f8-e559-5d5bea4e2008@linuxfoundation.org>
Date:   Mon, 5 Dec 2022 19:51:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 4.9 00/62] 4.9.335-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221205190758.073114639@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221205190758.073114639@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/22 12:08, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.335 release.
> There are 62 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 07 Dec 2022 19:07:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.335-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
