Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52FD6F20D0
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 00:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346748AbjD1WdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 18:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346512AbjD1WdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 18:33:16 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B792019B0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 15:33:15 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-760f040ecccso2609139f.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 15:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1682721195; x=1685313195;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G8jNhWuB6QPfRL2uGVj0UCIlGE4abIZaUuGliYF8a2I=;
        b=V48gAT+ayqif3cVBazHQl1bU2l45V2Cs70fNluwtcAOTRecCsW5srVFbbmu7kXG5lS
         7WXsunlPU7FSGMaYDQQaLknVmfujp5PB6Or8FMmwhdQgeZCY4QYvc7+nYxnO5y+6q1v/
         X9n1/M9nJPvkyIck9q+otbXuHlQmwuuVtYncI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682721195; x=1685313195;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G8jNhWuB6QPfRL2uGVj0UCIlGE4abIZaUuGliYF8a2I=;
        b=WbGvtIVd0e3HAV5UGkuDl6FCKnMc4yk226W1BBhNAXhrspR8+AGLjqE7v0YOen5RD1
         0da+u54HZNJ3rErPUGZTUGbqzx/EIjHhpzxm0SKvd+X6PNsjqBUWvI+hBoU+zoDBVXBU
         7wHeIFmudlgR/GcdLgzrYNH1LcL9oQIowv6/3mhif/tP0+oXUSVKMWAQD+efhqTrkkcR
         3HdD05rOe0nDeYbSVFZP6cTHvo9argDmbKCkGQmwqmZx6tyOr1zCPbduloMJy3jGNTck
         efgb9X6WSX16HTRpMOh+P+PFLZrkysHRyla+L+HklsTk6QZ15oI4oGo1lqFA1aNOmeUP
         0hUg==
X-Gm-Message-State: AC+VfDx+o8rI5UjzkgmpudYwFklDnzKyAeZdnhXlbzglktO+rNRmR7/R
        Pa3Xxmmyq87u5A8qNrlPnw+z5A==
X-Google-Smtp-Source: ACHHUZ5i6Ry0f1tvWmLo0dYlF6FrrdM/f8TEuP6XPURp6wNHyiLrdXxbcBuQbdy/oNZPWvK9rgGiag==
X-Received: by 2002:a92:cd82:0:b0:32c:a864:6eb3 with SMTP id r2-20020a92cd82000000b0032ca8646eb3mr3645130ilb.1.1682721195091;
        Fri, 28 Apr 2023 15:33:15 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id x6-20020a029486000000b0040da7ae3ef9sm6758782jah.100.2023.04.28.15.33.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 15:33:14 -0700 (PDT)
Message-ID: <9c7ca752-e11e-2aaa-0362-28d5c195e549@linuxfoundation.org>
Date:   Fri, 28 Apr 2023 16:33:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 5.15 00/13] 5.15.110-rc1 review
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
References: <20230428112039.133978540@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230428112039.133978540@linuxfoundation.org>
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

On 4/28/23 05:28, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.110 release.
> There are 13 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 30 Apr 2023 11:20:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.110-rc1.gz
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
