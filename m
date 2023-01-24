Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B009678D2E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 02:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjAXBQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 20:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjAXBQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 20:16:23 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C50F6E90
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 17:16:22 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id n85so6433910iod.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 17:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FlP1Icr443ARU66WHZYKa6EnbCHhRztF1yDkYHAN5ho=;
        b=aHx4hxvMpYlfOapQzoBDSKute05xDQx7HptuDJP/r1WwgWNfwvMiziSqNesxbnbFpX
         KutzBUKs5jFgoBYUEZnImcrFABnSxiu0yRiTNZlUIPEbCS3inQl5CM2gOBJXKq23fedy
         QCPRHYhABuF+qmYC9UX2TgYafaNL5mg9Vtp/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FlP1Icr443ARU66WHZYKa6EnbCHhRztF1yDkYHAN5ho=;
        b=NhGNiuLPh3c9+GUGaqaZkB2tQto8BkY1W2ZPKj4XJKhFE/2kHTC58VfDED8TZvbfdO
         8gfArbNwyw3NyhqgVn5AuomNtmMU+evXHy5FyQ8GT0f/Qikg2pJ2hlv/S9CaME4m7mnw
         fHSXM7M9DcY8fTC8r9wcBDQOGXHqwyAmTIqv1mAxa6uQLq1KIyqxodznJlcix4vezNt3
         7htQkh3SBERFRj6hfqj7u8iWGARVsEITrNGzhhrxVncVHaN7nA7v8AO5+5RW0g7kvx3x
         0zXtzDThUwhlit2lXxUgqtYuVVp0qnM/PRllOeTbeuAGHy9uXY0JbGprNVbvrRzeJMNt
         6jVA==
X-Gm-Message-State: AFqh2kqid3l5JLJ1yYoE6Q4LFGxuLNvTdm6r9XuKDQ8XLsaGIGow17PC
        dpjNA6xRHlYj2M/IHdH4FizpAg==
X-Google-Smtp-Source: AMrXdXvT9jkBefDTD0v8eXxzRc77DwIqHSKbNR6Au0zExGJ2TS6TH7tBS2kTICcEQjehHDO/DUGQvA==
X-Received: by 2002:a5d:9482:0:b0:6cc:8b29:9a73 with SMTP id v2-20020a5d9482000000b006cc8b299a73mr3423444ioj.1.1674522981496;
        Mon, 23 Jan 2023 17:16:21 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id h24-20020a02c4d8000000b003a432de0547sm217517jaj.163.2023.01.23.17.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 17:16:20 -0800 (PST)
Message-ID: <17e7c853-c851-8f90-6ba0-e913c447c5de@linuxfoundation.org>
Date:   Mon, 23 Jan 2023 18:16:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 4.19 00/37] 4.19.271-rc1 review
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
References: <20230122150219.557984692@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230122150219.557984692@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/23 08:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.271 release.
> There are 37 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 24 Jan 2023 15:02:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.271-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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
