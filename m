Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F0D6FB9B6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 23:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbjEHVaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 17:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbjEHVaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 17:30:03 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0681994
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 14:30:02 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-76c56d0e265so1533639f.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 14:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1683581401; x=1686173401;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4aWrgKo0KCjqs44bpXAfvA4ZqQoaxuHBLhlatswZ7io=;
        b=bh94yh6SgENk3JX/j5hSR2YoTFILkcgMWznMypE2g+k1ZmURDVX+2Its+1G434XqcQ
         z9M88J8Q6kXsfJBKgbQNB5TGLVDk8NEQpX5PXJ32RO2ftGo7xkAmixc0YFtFTTRvOvhN
         9vUtJ4xgRMq+kc+htuQ6HgFusR+OsXK7w1EeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683581401; x=1686173401;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4aWrgKo0KCjqs44bpXAfvA4ZqQoaxuHBLhlatswZ7io=;
        b=Zbq7oD6wPubilBKvpl54jBL8N15M1SuXOjArMnfA0tlr2WMcqu2vDxcoWvynRkK9Wu
         UbfdTROv7OzDC3HSAa02lV5P7stR/jpL1NoPqGzihi4LNB/77DcT9QiP9qBkcGqvycy+
         L/g9L3P4B2wz3P3KgVPRS+4NUxYD0aIbjMncFVR6LMIwZb9NrRnpBzSZ4GsuF8f8fZQ9
         fdoExTMV1KDBAaB0IvBdCLXTkmQ6eH13hFr2LJoBsWCwSBXJYdS01nTqHaaKgRMNES6w
         mRh6dI4Ef4ckklTjCedS9FOFb17iydL77KL4hpl95IclDPUAaEXlU6w0Jd1pMPiEvIaK
         nD5g==
X-Gm-Message-State: AC+VfDzttsb7lcakqE/XuRVFwBcg5icv8bVM9YWLoq4smZppxXqhu1fa
        9z+pvXMSfmZR20SVDajIuOzwpg==
X-Google-Smtp-Source: ACHHUZ5wg5Glntzt6FEJOgeM9pJxKb98jumhL21u83nHb2Qz7T8eZzlRBm0MyFziU9TYc1r9rfDrUw==
X-Received: by 2002:a05:6e02:1541:b0:32a:a8d7:f099 with SMTP id j1-20020a056e02154100b0032aa8d7f099mr5773464ilu.3.1683581401679;
        Mon, 08 May 2023 14:30:01 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id x14-20020a02948e000000b0040fa3029857sm2308720jah.128.2023.05.08.14.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 14:30:01 -0700 (PDT)
Message-ID: <b23432a1-593d-73d5-6bcf-bacd16f0bc10@linuxfoundation.org>
Date:   Mon, 8 May 2023 15:30:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 5.15 000/371] 5.15.111-rc1 review
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
References: <20230508094811.912279944@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/23 03:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.111 release.
> There are 371 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 10 May 2023 09:47:07 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.111-rc1.gz
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
