Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7D86B57AA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 03:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjCKCCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 21:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjCKCCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 21:02:33 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39B1140DC5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 18:02:32 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id b12so4034531ilf.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 18:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1678500152;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OyLUejJJCPWP6PVsnG0VJF+sqdtQu2YfnVNooJBJCBY=;
        b=ZDHsJq7hEJP8hojv5D8iVtFXLVGbwsTKTdM+M38lnfFBygiyb8cnjaNxOi+nBY8JZv
         XZmOLpjQmGEg3OXHfjVyT8eqXsYX2ZB5TFUD/N39Yufmo5JtAB1TXSA+O0DZYDBkTNkO
         OSwMvcBVgyrWjKsp3XguTaihLKEI7iisYiDok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678500152;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OyLUejJJCPWP6PVsnG0VJF+sqdtQu2YfnVNooJBJCBY=;
        b=thfci30BFRxD2cS1FrgnZVoF35jUKQ8JaPPUjZzfXHCzf17q9xlhfZoe4EQTYX6S0z
         54Ku+AO7TpoO8V60dxluwbU4ydodAxqRNqLxw1sru/0/CVUUMflkvq4Dt8/oTUqzx8Th
         kQgQ4nWrObsj0m3qQPOev7ye/f91RWD/RRQLY3ME29+WgRQr9nqnfe8QIobI8790R0HA
         XnZw6nLNU1sOab4vSX3Ih14R5Jf3lqA1YKF+l+5vf+I5Z/BBngz97kPrbEDWugf1Pos+
         e496m4nupLKfzwGJte4e3oCOeAaVU+K1vBrsEkGGYd++qzZF5Xge8PC8ymiRAcjICXnT
         2/cA==
X-Gm-Message-State: AO0yUKXxwk9EXMC33/aklYQR+VRneGrdqKD2OOnmcVCrHnoGVhitwQv4
        MqrkD9UNaTycLlTpgmx1FNUSp79A9LCS68J9a2tsVQ==
X-Google-Smtp-Source: AK7set+yfru95D8eXzjtb0ulLyuM2sfG/Pdgc+LL/M74Syvgmw9HVBF8Qy+53xZffrjIvJ9/A1mPOA==
X-Received: by 2002:a05:6e02:6c2:b0:317:94ad:a724 with SMTP id p2-20020a056e0206c200b0031794ada724mr5040662ils.2.1678500152190;
        Fri, 10 Mar 2023 18:02:32 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id i16-20020a056e020d9000b00315d1153ffcsm450583ilj.65.2023.03.10.18.02.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 18:02:31 -0800 (PST)
Message-ID: <9bd59ce5-5cdd-877c-26ae-3e0e4d0ec1ff@linuxfoundation.org>
Date:   Fri, 10 Mar 2023 19:02:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 5.15 000/136] 5.15.100-rc1 review
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
References: <20230310133706.811226272@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230310133706.811226272@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/23 06:42, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.100 release.
> There are 136 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 12 Mar 2023 13:36:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.100-rc1.gz
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
