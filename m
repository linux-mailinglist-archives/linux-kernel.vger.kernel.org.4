Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7B264E4CF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 00:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiLOXvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 18:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiLOXvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 18:51:51 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A622CE0A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 15:51:50 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id n63so491288iod.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 15:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ILYOzGOlcnUgJAYdg3KJrA0MBjq7Mpi0z4kbn89zmV8=;
        b=EIS2cGv8LD9/kBmoKOj55rWq3IzpORr6ZL33Z9fGayOW5Q0gm5whglTj0RFgsYPAil
         EAmFanxCA0beyFP858z2OxJgGsuEp05WE0nnvEba6qzsGTOqcvO+5VVUJp6fBSk7YyHa
         d8FBL9+eobM2mi/2d2i5SNsiZNAQICjpH8dtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ILYOzGOlcnUgJAYdg3KJrA0MBjq7Mpi0z4kbn89zmV8=;
        b=qy3blZr9tr21Xs5Tt9M6J37Ke97wwd0KA87GlsOYeK7VtQZ/wbtJlJuRxD2VZ38Ljk
         7G7Er3+m2nycO1dWXPDCeVT8oaQKfc2N8rNLeQ2Fk+DGA2iQ1aq+x9rRlbaShc9VzdVs
         iUt6mE53bBkOGwUNy/yKc5fz6cZ/Ve62KRQ54eFfV5rgMetqvSc83+JnipzzZyJ5mxW+
         vQcp5LXH0T36fn9Yl0ubisB65lHe/TChMG96zeW1q//8efVRF35N2vK6XQIjpe6kbAxm
         GJjUwNxhbOh/fi/TUUbyzT3mWa8d1ICvE9OlSbRkhhxtrHjMCXy5aDjbaEyaj41GALu8
         qKvA==
X-Gm-Message-State: ANoB5pkId/Yab7ENnErfKhovRFlN9fKAQn6P4h0Tu7i7I7p6xUA+kSJR
        QTXWNfs67qMLjRkuFS/0X6FPGQ==
X-Google-Smtp-Source: AA0mqf4QVc0MpuqQNi5OeSMrV0I/CML3biumc7bMrEq4VWZB9Yt/1kWFkTSJlipkCzhzzy2IDDx55w==
X-Received: by 2002:a6b:c415:0:b0:6cc:8b29:9a73 with SMTP id y21-20020a6bc415000000b006cc8b299a73mr3385501ioa.1.1671148310101;
        Thu, 15 Dec 2022 15:51:50 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id f61-20020a0284c3000000b003717c1df569sm216114jai.165.2022.12.15.15.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 15:51:49 -0800 (PST)
Message-ID: <2103e063-a758-f13a-1402-3a9570377912@linuxfoundation.org>
Date:   Thu, 15 Dec 2022 16:51:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 5.4 0/9] 5.4.228-rc1 review
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
References: <20221215172905.468656378@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221215172905.468656378@linuxfoundation.org>
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

On 12/15/22 11:10, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.228 release.
> There are 9 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 17 Dec 2022 17:28:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.228-rc1.gz
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
