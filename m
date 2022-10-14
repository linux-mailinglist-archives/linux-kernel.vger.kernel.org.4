Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956CA5FF256
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 18:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiJNQhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 12:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiJNQhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 12:37:32 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAA2FC1E8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 09:37:31 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id y17so2786206ilq.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 09:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kQ3ynZAgs6f93DRp+wIAkOPgGAVpfwvo4gIS1jIMlzc=;
        b=U2eQoqGPbnBoEGENJnnVdLSayXv+bE75HZJPNN8ktQDRYAJ5/UEm9YpkZ9F8T5lsXN
         3UV+r/HMdI3G7VSQ2zoKNTT4p00rivWdDhKk93pcfPhyoaVvl+bnZHYhByCFYyUB17jN
         8Z8aVrdB6EQKrVyrA/VbbE9ODfy9B595g5ZeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kQ3ynZAgs6f93DRp+wIAkOPgGAVpfwvo4gIS1jIMlzc=;
        b=krMSfs1AP3g5U2+MCSi1dBM41pAL7o9Ke1YDwqNIgRZtJTYrA8lqNtMNwChnXRruHb
         tGWRFd5/XF2sLt8YkUOmo3Rj8qyXbAAz9B0okI2Cgl8xC6hlOosun0LMe8H+BfnIULPQ
         nhh5K0YmYfvCmR5KPB9TcTSWBAviJqsAC+J4pItxMqDueseb29A4DlQQUDbhwYb/yPun
         aHP1yFw6K+G93DW55IdiGHIh2cor74mnpeCOH9cZHNErIBCNFhHjf6OnCocws060KMFl
         DaY5u5VxG5mgQmNyncrQS1l6L+NdJBvH7ONrkToxa6S/jcfHV8s/MLAWOtX35LRl/YG4
         7JrA==
X-Gm-Message-State: ACrzQf0BimTy6upXaGDjt/YX2Zz9+MZDQ8RaQdQLPmjqxznVXYltARJd
        tqYNppQCVD4cdnpvZp55ns2fhQ==
X-Google-Smtp-Source: AMsMyM7eiGtMZnwH12IbKsq3RUoWkr1OlGDtmJJ6RpA7tyYHXqzFepYZbgsHc3nMtImyZoqLBury8A==
X-Received: by 2002:a92:d686:0:b0:2fa:6226:6247 with SMTP id p6-20020a92d686000000b002fa62266247mr3008321iln.79.1665765450793;
        Fri, 14 Oct 2022 09:37:30 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id q4-20020a02cf04000000b0034c0e8829c0sm1284578jar.0.2022.10.14.09.37.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 09:37:30 -0700 (PDT)
Message-ID: <3c26b75a-270f-727b-23e3-e38e59dbac4c@linuxfoundation.org>
Date:   Fri, 14 Oct 2022 10:37:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 5.10 00/54] 5.10.148-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221013175147.337501757@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221013175147.337501757@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/22 11:51, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.148 release.
> There are 54 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 15 Oct 2022 17:51:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.148-rc1.gz
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

Just a note: I am debugging drm issue from a previous rc (5.10.146) and
I will let you know once I bisect and figure the offending patch.

This is not related to this rc - doesn't stop from releasing this one.

thanks,
-- Shuah
