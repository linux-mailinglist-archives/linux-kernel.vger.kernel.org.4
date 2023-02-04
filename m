Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B64168A755
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 01:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjBDAyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 19:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjBDAyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 19:54:00 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B48728D5
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 16:53:58 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id i17so2771322ils.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 16:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BW4GZm3BU02bbcJ/C7il67qLf+uzYfRkVWlY4FUNarM=;
        b=bCcJlsKbLQm8nY6SlBhi0hNbah3pff5bXeEz0qiGAHpiYmooO8vkLono54CLVhYjnI
         4n0MtCxfM9gdDluGMvDT+7ogMVsVrIhDjBsyp9V/7Z/ex6LF9k3iRwIXguaYJxKc+z6P
         f8PM1BspLfrKhIMwK8z7iadoOG/sHzb8cDrN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BW4GZm3BU02bbcJ/C7il67qLf+uzYfRkVWlY4FUNarM=;
        b=0+Bkzwx7VpqpB8ivP97FqGhLT8IPaMrFjTrhQ5tGahi8gLZc17rgGXhaH4D3I4z7G+
         pUJXtF60Fow0DcFa8Ewou1meyhmvwMei9WUJpIr5ed9ZUP/31EswRlaFwLbY4n0lfUp3
         jSAqfARa2gX5VNTdjS+kzvt3PI1qrV7dchGCHpZ71lHfg2REk8sAKZoe+uEgw8f/HUc9
         3tK1io2iLNM/UAIhXfjZ+YiujQZRBnd2cOF5YFXBTL4oAVJoyI+HdlGJdqyTVA6EFi2i
         pl3dpVBvmJ+SyOkCUe3oWLS0Ta1gsLKWQij3AwgdSlaEMmIySQiy8mSpXLa+KBoOwABx
         p5dA==
X-Gm-Message-State: AO0yUKVU9tG0AgkU0rgDKNeQxC84gZMSdaHV6RS3uIqEZT15V3Z7HoPY
        g8riIkEBkiYYGHScf93Y490YbA==
X-Google-Smtp-Source: AK7set/LMNVNMG8rFbs3SjKBLpsKgzIqoKGGqneev/Wr0wOz/EZjrkquoVEZyy6kOX934t0H470l9Q==
X-Received: by 2002:a92:c5b2:0:b0:310:9adc:e1bb with SMTP id r18-20020a92c5b2000000b003109adce1bbmr7603510ilt.0.1675472037792;
        Fri, 03 Feb 2023 16:53:57 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id q9-20020a92d409000000b00310bde806e8sm1229395ilm.12.2023.02.03.16.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 16:53:57 -0800 (PST)
Message-ID: <86f541e0-43eb-0926-c71c-c6a006cecded@linuxfoundation.org>
Date:   Fri, 3 Feb 2023 17:53:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 5.15 00/20] 5.15.92-rc1 review
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
References: <20230203101007.985835823@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230203101007.985835823@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/23 03:13, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.92 release.
> There are 20 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 05 Feb 2023 10:09:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.92-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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
