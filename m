Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC856EEB6E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 02:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238429AbjDZAap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 20:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236413AbjDZAan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 20:30:43 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5ABCC12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 17:30:42 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-763970c9a9eso13289939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 17:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1682469042; x=1685061042;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9r2n61XQ2tavEnqazBzHxzy9CxgS4MxG6ODhVmjzzO4=;
        b=emwickuX3pToJ7a+2euZf1fTcQX8qM16FUyr280BGOsM9eJd0koFamWyMgj8xt4zCS
         DEdOh6v6JiDHl0HD7fObCtYDBAWqD8VrTgfqAMbNol53u2DchsNqad4VzQomUV8pc3MA
         DcT34CluFmb6RFDfheWuYyPCR98Yio39/h6so=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682469042; x=1685061042;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9r2n61XQ2tavEnqazBzHxzy9CxgS4MxG6ODhVmjzzO4=;
        b=Ax37Ds22vu3d3g7ojG+fsP12xEbuz+nb17t2wYxItdlsaDOEh/n7aKAlUL/bKvHRvz
         rrpZDqT6AvjSzweMIdr7P2PdeeWz6E0TIUfgfsaKCxBSm9qDOeObfuIjgW5Nenfjuzcq
         YMKqsmhg14EUf1u4FwbIzY+nvj/r3LBGKeNTN+6jykKAHfAtgvo5Y6F0cfA+gEezIRa7
         p3SzoRFYnXuR1mHy+jSdDxk6KISRrhStr2lkNrBw+vi2cBerrbLMkntptCOR9Lz3JEwv
         5hjEXenTa6IPVhBv5GTP2caUbq1hvgykAKLLsA/K+/XQQLv6Bk4GDIhC1K194ejuQ0QV
         oUeA==
X-Gm-Message-State: AAQBX9fAel1xvyYZ9rUu5t01BKluHhDiH/7piys/vSW4yMWb8QYog+Rb
        jJK1mY0VAP8+Jfgh9ye93xEonQ==
X-Google-Smtp-Source: AKy350ZjCHRbeWBKeFGPldyJwe1amgMDnqjftO6jFhmxd9on5UGZ7D3hVzYYSogDnw6rGvCex2DBDQ==
X-Received: by 2002:a05:6602:379a:b0:760:f7e4:7941 with SMTP id be26-20020a056602379a00b00760f7e47941mr10668374iob.0.1682469041983;
        Tue, 25 Apr 2023 17:30:41 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id bt6-20020a056638430600b0040f98da8c45sm4303128jab.72.2023.04.25.17.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 17:30:41 -0700 (PDT)
Message-ID: <5c095468-7c35-ac80-fa29-97256f3e5f55@linuxfoundation.org>
Date:   Tue, 25 Apr 2023 18:30:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 5.4 00/39] 5.4.242-rc1 review
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
References: <20230424131123.040556994@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230424131123.040556994@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/23 07:17, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.242 release.
> There are 39 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 26 Apr 2023 13:11:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.242-rc1.gz
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
