Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534DE6C257D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjCTXOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjCTXOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:14:30 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6184F231EF
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:14:29 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id w4so7351491ilv.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1679354068; x=1681946068;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wp9Ma1tXiomJIM+Ccb5K6YpKhjZGXmIfWaW8gLzKl4g=;
        b=eH/EfirbNVoFw/M9nI2MrjyBdBoXhcbFlHWxVsVXqUY8yrehDxzPmuj8CKfDRNa742
         C6bxo9pxEPt+C4Ee53vmachwZeurPtp0T0zlHVplqSTvFfBsW5+OcKGBn6Qr0f8hRejR
         y3QZcCEwacgWY7J0fsC4sB50hsYUo+LMn4pQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679354068; x=1681946068;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wp9Ma1tXiomJIM+Ccb5K6YpKhjZGXmIfWaW8gLzKl4g=;
        b=cfJEFpUAWwgmIeUwXxssvlbmEN/Hu3kwcAtsFpqTCEgE4Ve2CptR6s+04LzogZKGfb
         jakMEIrzz+rLZFYiVgAn2ojmvzyZ93m/Iy/PxQZH6HJlqY4Ix9fqQpHWKHXo7raIeEda
         HLOP8eCV+lTwjIfHDVCjW1UXQmNjujhgqSDYAeHRaaTeBOPEa9BHkqli862ol9/1HkUB
         aKU9FV+Dxmo+h7g8UG8Ul1tD7BeSEgZgm7h4Cb9eFquBvTXhWLmsRmMQhrL8mpqxCP0M
         3jz/plggaPXtRcPoS/gZB6chXTKPiv06S3M+iQKBQkuWGDSad576rvPqPfNZX6UFcuK5
         Q6zA==
X-Gm-Message-State: AO0yUKV6zkwA4Wxp0eFpud2kZCDgoSHW99JjxmxfIGzXSmHh0WFXLz4o
        oD9W5ez6eY3NQCLIXfvFeVPp6w==
X-Google-Smtp-Source: AK7set+I3uVCBqzyU8Lu237ZB3b5GNNfmxHdjKmghf5RbckgpSFCEvPqT6Fx6ORVGok9AqogCqbO+g==
X-Received: by 2002:a92:7b06:0:b0:317:36d8:cfc6 with SMTP id w6-20020a927b06000000b0031736d8cfc6mr564522ilc.3.1679354068654;
        Mon, 20 Mar 2023 16:14:28 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id ay24-20020a056638411800b00406633b7dddsm1593250jab.68.2023.03.20.16.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 16:14:28 -0700 (PDT)
Message-ID: <79ce03fc-84f7-b343-5054-2e7d6533107b@linuxfoundation.org>
Date:   Mon, 20 Mar 2023 17:14:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 5.4 00/60] 5.4.238-rc1 review
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
References: <20230320145430.861072439@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230320145430.861072439@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/23 08:54, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.238 release.
> There are 60 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Mar 2023 14:54:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.238-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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
