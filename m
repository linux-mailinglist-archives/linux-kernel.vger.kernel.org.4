Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4E06DFED5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 21:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjDLTjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 15:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjDLTj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 15:39:29 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516B71738
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 12:39:26 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-328790455e2so671375ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 12:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1681328365;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fcgOS+OKSCDO8NzRjq8eZKuY5z5xA1+GHktFaJ0VUuo=;
        b=K+THEKrRDwroGrTQQOzJx3ru0btMd/QcNESrSF+0jeNwdifIzNatRJaajfOTJyZs1r
         vDc+AYWrf0o9tP3IlheEUurV5e89oDuzzhce418KxSJaJv40cAkVflI7DN2at1c/gotJ
         DMKEeDBwDFR7zwL6nB6RZET5jHncL+yLxGD3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681328365;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fcgOS+OKSCDO8NzRjq8eZKuY5z5xA1+GHktFaJ0VUuo=;
        b=dHpSyZBpcZYkscya+/jb9Q2uN0ns30HzKeSw079yc7ght7Q6oQJ4EM6y77QFODG6KO
         oYNmkdqgx2rbo3e3LkOPYPBYSPtuPU4spaHFYO8e2hjQwC6joOzABEs1SVuyH1u1R0Rs
         bnfXzdRYNOcsGjUSErN3tY6k21QJCQrV30hyTON906Yk9TbKL0T4Ru/MICYdd0cdqvse
         PeCZpMSqbKV6qgQexxRlb+qyGclzSw7sNyKGlt6TucZ6A0td8zoNEZ+suaYt2wSyVjZR
         s12DLWDQeFMada8OBh+0U9d9HaMxeQm3bGH1aJaDZxXfQI3zwT3NpplRwLmx82vA1MsT
         QojA==
X-Gm-Message-State: AAQBX9fRNSVYcJUPKsmA3r97ZlSnLB6O297hlXGfpxbfJB+hL69j09c2
        lBlRV1ZflbaC0k8BqVtbeyb+vQ==
X-Google-Smtp-Source: AKy350YbbFMakOATb9v3PBISR7YtOBKNcGKFoPiIsoYlJstGgeU78BZ4LCWB8aagUoy2LY9Pbx6Eog==
X-Received: by 2002:a05:6602:70a:b0:758:6ae8:8e92 with SMTP id f10-20020a056602070a00b007586ae88e92mr1457619iox.1.1681328365635;
        Wed, 12 Apr 2023 12:39:25 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id y32-20020a029523000000b0040bd91e4803sm1922883jah.155.2023.04.12.12.39.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 12:39:25 -0700 (PDT)
Message-ID: <276effcd-c83d-92a7-7cac-24fabf7aff35@linuxfoundation.org>
Date:   Wed, 12 Apr 2023 13:39:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 6.1 000/164] 6.1.24-rc1 review
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
References: <20230412082836.695875037@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230412082836.695875037@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/23 02:32, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.24 release.
> There are 164 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 14 Apr 2023 08:28:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.24-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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
