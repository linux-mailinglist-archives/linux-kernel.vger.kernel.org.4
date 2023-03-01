Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218726A73C4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjCAStA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjCASs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:48:57 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C303B23B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 10:48:56 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id y10so10765387qtj.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 10:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lgEtVBqhYQM2xpZGmxizRfxew/mOAe3TsmV4ZLiINaw=;
        b=RsU5IMSG1sBe8t0gbZfGIvbtH9WMsbxCL0HIBI7r73OWudhZwiNkJ2YObGnL2Zv04k
         JxVdGGqOBoOZDlrIWfs/R3WB9fUbETelHfXwOVkAgu9Sqh/BPxOB4WjLODzjoANboTmg
         1g0lfzw5n6VGidrPdkQZsJ33K/iw8HptueoykObmlSEyXjYj9GeQNWZeyfvPtrWBG0fs
         lZqMsXUSwBlJiHvswDQMCgCQpE4bwqkmLhuGNWKfrWDpsolPkm0BEjZBXjUaFgtBKQTH
         9qLtbkvurAGjLkLyr0OI8h19AjxJgbiSh0JOPyC9cJzoWST/ziLtZ+R14POzbWDwcY09
         PZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lgEtVBqhYQM2xpZGmxizRfxew/mOAe3TsmV4ZLiINaw=;
        b=N2i3ChypzL/gFB675DNkBvJnetmAwjXgRJ1YbeQBGBF4FWJqkEtD8+0kSoz912CxS+
         iuBMPHwKu8lh/RcmAX70ygWmViuPzHN0K+IgCg9I143ATbK+xVgi1YF77GU1SRKrMNS0
         CNcVfM2IOsuXvEbN4gHdpzp1pV0kPrkv4y/QsxCQ5xWjr0AYXCQGIgCNGv1zC/yNYt4g
         pgFCebK097SJvXlFK77n9r1aUmSV6DUtKSauSDnywo6UD6tEa16OdnXXWumWIjtrF0Mx
         g9WIFXXKaUOLCDqlob/ov4vUcrSApeN7eRq+cG/IWjtnHpduqPZSRVQgtzY35NjELFYF
         Mb/g==
X-Gm-Message-State: AO0yUKWmu1cch/uwLMxIyHNd5FjYr/rVMQ3af1ut4K4LiQxiGrK3RKi4
        UwpKHVPes9wIPSWnjUKs+60dkg==
X-Google-Smtp-Source: AK7set+1bLqI9kSwZBv3jy3IhBPxDvILB+hOxhOtidyH7eT01aGzUUHCgN8J7MjDAUGUV0Zy+9kb/A==
X-Received: by 2002:ac8:7d42:0:b0:3bf:e005:3a85 with SMTP id h2-20020ac87d42000000b003bfe0053a85mr12492782qtb.5.1677696535305;
        Wed, 01 Mar 2023 10:48:55 -0800 (PST)
Received: from ghost.leviathan.sladewatkins.net (pool-108-44-32-49.albyny.fios.verizon.net. [108.44.32.49])
        by smtp.gmail.com with ESMTPSA id k14-20020ac8604e000000b003bffe7fdc38sm246366qtm.9.2023.03.01.10.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 10:48:54 -0800 (PST)
Message-ID: <26116769-3620-0544-cdaf-02516ab5ae60@sladewatkins.net>
Date:   Wed, 1 Mar 2023 13:48:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 5.4 00/13] 5.4.234-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de
References: <20230301180651.177668495@linuxfoundation.org>
From:   Slade Watkins <srw@sladewatkins.net>
In-Reply-To: <20230301180651.177668495@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/23 13:07, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.234 release.
> There are 13 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 03 Mar 2023 18:06:43 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.234-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.

5.4.234-rc1 compiled and booted on my x86_64 test system. No errors or
regressions.

Tested-by: Slade Watkins <srw@sladewatkins.net>

-- Slade

