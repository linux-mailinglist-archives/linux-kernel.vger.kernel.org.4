Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850786FB91F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 23:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbjEHVEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 17:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbjEHVET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 17:04:19 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67877ABA
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 14:04:16 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-76c56d0e265so1352739f.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 14:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1683579856; x=1686171856;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GVXgA2/yKlvvCi/fNq3LAF2WhpqNYS7jROBS62P7jtk=;
        b=bhDFKdOYBkDlJlIyfJ6oeEaUD4FXDyCIJbqbPJuK3AbN3iPZe64yXwaqtenCwnWLHI
         UfIxT/4Apv8UEl/KUkBRBsb5X7IhBAsLs8nB0ahFeBDcPG0mcnYAkW8YnUw0DBJ9e16b
         Gg4bP7dpRars8SwZgt+nS9amSCPdkyXrLWBCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683579856; x=1686171856;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GVXgA2/yKlvvCi/fNq3LAF2WhpqNYS7jROBS62P7jtk=;
        b=hKLz8SrLQmgljFjwscxco/rJqVEFCqygAv5P15DSsYJRsOISbbcTu6Xi5aTlvOF2IN
         NCCh80/ErvPWF7z3OghA7nrQMnRK1soQXC1lH92Y+o9XeQ4jdhDd/6iqM3/mGlo9LvTg
         ZV1ZkMsqRunyUg0gV+OVWbQJLkPSOgzARJiguiQSkWqjknUUtD4nCnAvE6/nMnb4O3xN
         zD2mTVtmVicvbYTEVvNuzf7yHP6+Md99qRydVyE3inamj4f2l30xNdqArfhfCVWD3JdW
         QjfstOxLbTch3kRyqVu8Ps5OQ4a4qDee0KLG5pZUNjzhBzoqSNO5vcxxwVgWPDsZfFLU
         tW9Q==
X-Gm-Message-State: AC+VfDwvWEr59FipcFSyAiUBATUfkfKfr14BZNLF8EAcbQZKTYqhvbmE
        api6tY2ydsk7hKvEV6c0MOvPeA==
X-Google-Smtp-Source: ACHHUZ4t04uSHpQwGrXiKWff4IIvHQkJNAdWLVy7AQ3UmpbqbOY4HE0p5FbLVqTv8NnyYz/3+mUPtw==
X-Received: by 2002:a05:6602:150c:b0:769:8d14:7d15 with SMTP id g12-20020a056602150c00b007698d147d15mr8047686iow.0.1683579856123;
        Mon, 08 May 2023 14:04:16 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id k35-20020a056638372300b0040f99b59cbbsm2299330jav.166.2023.05.08.14.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 14:04:15 -0700 (PDT)
Message-ID: <24e0163b-b7fd-e88b-2bee-479147a91d91@linuxfoundation.org>
Date:   Mon, 8 May 2023 15:04:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 6.3 000/694] 6.3.2-rc1 review
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
References: <20230508094432.603705160@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/23 03:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.2 release.
> There are 694 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 10 May 2023 09:42:40 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
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
