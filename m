Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C1C64ABF9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 01:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbiLMAHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 19:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbiLMAHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 19:07:00 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD55FC7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:06:58 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id e189so921498iof.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Db+FmifZCy1uWygbKZTWCX5801TWsuTURiI7y3O7ac=;
        b=SFO+OJqeZ7SjtvEggmWRenFvL8o1MXYJKHBHTiFGu4uIpWQPDDgBbJTWbsMeYyGbQ/
         jZP3HGDcUZI+IAyHsqPXC0QxOzp+GuxRvcrG/L2dV4Brb8i4dZKqoQDx6rf6mXyrfdvf
         +3G5EutTiycaWhR75OfqVSv3d7Etxegvdyzyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Db+FmifZCy1uWygbKZTWCX5801TWsuTURiI7y3O7ac=;
        b=rSkL2NBd9dVMYyt5ROdwN6TT1quBw75/OLElft2m1BtDA/0jWEL8PBQQ+wjmWOppNz
         7hrHqn5v8YPje+rvaPzo00gwstKp9ZaCSTOjtDXROIr7kN70fq5HChZ/GVDEA8MZMx4o
         qCQdbyLPRC6QnZl48wy82MvksgqKsm9zd458OkFfvKV3kLRa+aEIxlVX6d9AlH/bGU5w
         cz5PyMp8nkr6mOyuvTjdsfVIg5qvO4iaxFi4mFJqMUL0eJ4NOHpsrjmXTNZWqxNILK70
         9NJlorof3fa/+FBF37e76OnCXIBDZ2tlMLX4JZHKIVxTEZJFM4mwzj4YzUuwrv4gsc2R
         F3Dw==
X-Gm-Message-State: ANoB5pltSeHqgw3m3dAD7DG8FUYGZKDf5Npxn7L0PzhQvR9eb7HEyn1+
        y3xwDNWEW9Nd6OC0fd4NNVUpTw==
X-Google-Smtp-Source: AA0mqf6Kf2LiWQza+25hgRAHiDpLYJIOgT3Rvr//CUSIS7h8DDu9qdUvW7InhaNvZeMMyx5NLAhr9g==
X-Received: by 2002:a6b:4916:0:b0:6dd:7096:d9bc with SMTP id u22-20020a6b4916000000b006dd7096d9bcmr1909782iob.2.1670890017737;
        Mon, 12 Dec 2022 16:06:57 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id k2-20020a0566022d8200b006ccc36c963fsm4671321iow.43.2022.12.12.16.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 16:06:57 -0800 (PST)
Message-ID: <6494f1f7-33ce-05c6-df67-e5ec8e813611@linuxfoundation.org>
Date:   Mon, 12 Dec 2022 17:06:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 4.9 00/31] 4.9.336-rc1 review
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
References: <20221212130909.943483205@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221212130909.943483205@linuxfoundation.org>
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

On 12/12/22 06:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.336 release.
> There are 31 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Dec 2022 13:08:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.336-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
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
