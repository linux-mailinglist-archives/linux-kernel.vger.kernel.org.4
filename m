Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CE96D5509
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 00:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbjDCW71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 18:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbjDCW7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 18:59:24 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B50FE7C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 15:59:23 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-752fe6c6d5fso16456639f.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 15:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1680562762;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fkd2TX1vf4QdQsQX67c28kv3YBAJ32wfaLNOMhERik8=;
        b=byH49yTiJZ/bNBw+blnWrUs2iYagANWxDUZ0B/m9rs2BP1EcbBpqxuy2co+ghBSbIV
         z39BcU6zrKsPZBOXGRUxpOs5WkPhX8gEHy1fqwKhndy03glJrYNYDVMH2zOnXCiBIMnR
         z/s3x07FxOMqDcERXWkAV4FxyiDjwsMxcQqjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680562762;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fkd2TX1vf4QdQsQX67c28kv3YBAJ32wfaLNOMhERik8=;
        b=SIf0SaESjp8Rbx2PTb/bajq9oobi88IUaTSDJ0S4kt3b6tVh2fVd/FYCR4ow7UJsES
         JJyHblDwt1sib9Rj3QklNM+nY3qd1dDhfE4t4bME5hWQx1YgZVue99vgdgCljNrvw39x
         4FAlcDy1znf8Phkjx5kEaS6HWGS+01QkT+Zxfc9+0VLbMQ2FM/+dICAlEFfA9WCjiuik
         jBZjqvPTR9O2M6MOiuXwVXKtOVE3bvp6gqwOn7KTx0EL6ilgFsMfquO4T6Mjrg1vYQIE
         Hwfqb+5YOQEt6pvMEC/ZV5yvPDpjgn6LxINcuQ9oV45qQK1/X3XV/CIoeVhU1mqaE1Hy
         jjZg==
X-Gm-Message-State: AAQBX9d2Uvu1Br5leLgoUx4kvAQD0FVukRp4mUkz6wCL5+dOyTzE2UFV
        vf3ig/CCWYsjHI5zBPhoDAqpiA==
X-Google-Smtp-Source: AKy350ZRbNyEi4Jdca0Ftmjo2kjCwv02cN2cPgzbKUN8wVvCZu02OWnhv+g9RimOYMYrUzDERgBrNQ==
X-Received: by 2002:a05:6602:1304:b0:759:485:41d with SMTP id h4-20020a056602130400b007590485041dmr617082iov.0.1680562762719;
        Mon, 03 Apr 2023 15:59:22 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id q29-20020a02b05d000000b00406356481c0sm2887964jah.57.2023.04.03.15.59.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 15:59:22 -0700 (PDT)
Message-ID: <d681cdd7-b455-080f-9b19-3510f6bc7a8f@linuxfoundation.org>
Date:   Mon, 3 Apr 2023 16:59:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 5.15 00/99] 5.15.106-rc1 review
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
References: <20230403140356.079638751@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230403140356.079638751@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/23 08:08, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.106 release.
> There are 99 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 05 Apr 2023 14:03:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.106-rc1.gz
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
