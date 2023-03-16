Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BA66BC1F5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 01:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjCPAAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 20:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbjCPAAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 20:00:18 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5AA227A3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 17:00:14 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id bp11so109957ilb.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 17:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1678924813;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M5n6N4Kf45DWAUdDU8gCqH2UU9H1ulFevAL57GqiUGY=;
        b=UCsuKHu2bj7zopFA1WRte9Z/MDmlBS9AsRyqRGflrYMvGJRbrjvwm0IGO87DgwM73s
         oEd7qDfvdkyKbIRz1jDBuPO6U2XwwI58LomuboMuXBU19cOONe95qY9QpiC9ua2S2q/8
         9Oel2NIJSDLVo8vGcxO3JMIpmJOQwKQSYDye0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678924813;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M5n6N4Kf45DWAUdDU8gCqH2UU9H1ulFevAL57GqiUGY=;
        b=7EiyyqbZJCLn6vCgVDvNZwsbSBN/HY+D0Vo5iEsUJXyWrTNQvI7dpzVa3mD/dzN4oW
         w/E5slI/eaWkEgHhP2WWIYoH52mPrS5EXaZnAn91yMqlkdWE3tOScchY2O8BnYzPeucl
         pH/JOiR5uAwin1kQEBncPw1Y5k9QUUqCpXT+rZe+52QpuEETpqESESwvmnUM6FwEhaBg
         K76raJXwpB38DAM54Q56iW/9Z5SZvXkPLp/apY7u2UC6DZVEkZ1QkULEzeX0e0XleTFC
         8gFLWTA48Ty0QpQlnYECfbluPqP4uKW7uO/LVsatEaSTgdtrTUe0ItsAkc5VeFqgrOJE
         yP8Q==
X-Gm-Message-State: AO0yUKVHaz/7wLPY0Ses00wO4Cg6BGG/qr1nXxn4fJlDDpGvXenTBWGP
        0S4rOtAVMrfv7nHRGc/XRv19DQ==
X-Google-Smtp-Source: AK7set9j3X3dxYOjKgXnzMWtyyMmj4wF08Z8ZmecfQECcUg4gxKG34tkDHCOOfX6oZEObmCswOVK4w==
X-Received: by 2002:a05:6e02:1190:b0:323:504:cff6 with SMTP id y16-20020a056e02119000b003230504cff6mr521499ili.3.1678924813457;
        Wed, 15 Mar 2023 17:00:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id y13-20020a92950d000000b003230fd0b2eesm1953198ilh.61.2023.03.15.17.00.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 17:00:13 -0700 (PDT)
Message-ID: <4b45cea8-5881-34af-830f-c37f000e1300@linuxfoundation.org>
Date:   Wed, 15 Mar 2023 18:00:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 5.10 000/104] 5.10.175-rc1 review
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
References: <20230315115731.942692602@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230315115731.942692602@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/23 06:11, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.175 release.
> There are 104 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 17 Mar 2023 11:57:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.175-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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
