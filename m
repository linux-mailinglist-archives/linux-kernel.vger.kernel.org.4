Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCBB6FBB24
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 00:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbjEHWqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 18:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjEHWqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 18:46:08 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136D47D95;
        Mon,  8 May 2023 15:46:07 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6438d95f447so3484185b3a.3;
        Mon, 08 May 2023 15:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683585966; x=1686177966;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xLLOYAC59DVDjop+l8KkOqRs2bxgq3yUahEerwyPg5E=;
        b=VNkz/3aOv9WVtmwmwomnoKeAd5gQ+PTtWKmS3L8DFTSBDiQbxPcJ9aZ0SnoPVo5s01
         LFFwsNr2vcry7J8U12M2PHY6ZeferZ+j90KvH/I1Cn9Cgz/YHkoYkCj+cw0pOJZgErfT
         lQ9vtS2gDS8Lc9H1WxK/x7RVmCaJdcQUY03iJdM/mjNF40Lt2Y0iiTDovvg4eiGZI9zf
         n9QEjsFEQKephG2c4GUgs/HsBOb19EOIyYUT9k0J0ziE+Dh/t7KUlMHgcrI/mlYuChaU
         HoeEyFkDuRJRoO2EFh4og7pI3ueQ84HGo8H6CyrHUyllLvKe2BQEMAdzskCr4Y/nA+0J
         B9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683585966; x=1686177966;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xLLOYAC59DVDjop+l8KkOqRs2bxgq3yUahEerwyPg5E=;
        b=QpWLD16bfbLmlD2Kul3uIfUhFZ2V1GH2OCdfGRkP63JWe2XjcguOwrGoZlI8dw399n
         JZ25EVHIkSoRoR/ad6o2U5sLx3WvAtUdiRd0wTEeHc7YHZ5lPjwdrIVKQEeudBydlj8L
         10WRAQ2GSPzxU1SSCBG+Q2RQnXgLQPttBXYyKWmJNS2KkM4+1BXeDfL/6dlGWJLLZD4t
         vqEECfguQjJ3v6OsQ+bQFH74zuZByQhxW2rLbFlOoOk8HipxMNc90Ki7x+unhY+MKYg0
         Xu8VHMbubVezfCbA6bj405VO6KdtHd0O81P1Z3Hfbr+CxvkjMh+/IK7PFfzOLv50R7pv
         gtrw==
X-Gm-Message-State: AC+VfDyo3Ji5ab9W1W6CbGsqExl29lb4YhggugDvSLRCD2yOlxrwNMYz
        lRDq6zLTeI5L8mzIFB3PNoM=
X-Google-Smtp-Source: ACHHUZ6J3OcCBI0a+wEEdU6vdhErzLEbzra+/IDwat6zq0aX1ZuuzWP24krl79t/Dkonrtt/rOaOmg==
X-Received: by 2002:a05:6a00:1343:b0:646:c30d:e9c2 with SMTP id k3-20020a056a00134300b00646c30de9c2mr1820404pfu.28.1683585966469;
        Mon, 08 May 2023 15:46:06 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id q15-20020a62e10f000000b0062ddaa823bfsm422358pfh.185.2023.05.08.15.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 15:46:05 -0700 (PDT)
Message-ID: <0ab5fa02-c2cf-fe09-8825-a25493f6e358@gmail.com>
Date:   Mon, 8 May 2023 15:46:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 6.3 000/694] 6.3.2-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pierre Gondois <pierre.gondois@arm.com>
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
References: <20230508094432.603705160@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/23 02:37, Greg Kroah-Hartman wrote:
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

We also need to bring in this patch from upstream:

3522340199cc060b70f0094e3039bdb43c3f6ee1 ("arch_topology: Remove early 
cacheinfo error message if -ENOENT") otherwise we will be spitting out 
the "Early cacheinfo failed, ret = " messages on boot.

Thanks!
-- 
Florian

