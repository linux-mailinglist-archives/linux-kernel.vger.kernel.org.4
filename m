Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCF066D387
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 01:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbjAQABc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 19:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235344AbjAQABC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 19:01:02 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4EF241EE
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 16:00:36 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id n85so6584545iod.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 16:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k/l+OB3g+/Armp+fSkIp3SrVIT0sxAsd6AxV5MNKII0=;
        b=Z3savTuuAto05hJe+V2LfmfPv8m0RCi0ql4jmyCHuTXW0qrWFRgW60Ef5OW5NnogvU
         e7F1pajG0Jr6EQ3AWiniSliQ32lneFRN+Jep/jol/vpbhheFpFA3sB3GHGBMFXrO8M5l
         3R9+d6kLYzi9LLe0yw5DTxUomaPR3LC2fnJi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k/l+OB3g+/Armp+fSkIp3SrVIT0sxAsd6AxV5MNKII0=;
        b=jLbo6sOyWFZHToeDQqKLLip/CQMGwE5/fUivuLOvZOP0DfHa5Q+YAKkvY4VGd4+J7h
         2fPhfsdO77T6zXm1vXqrhyTMeHun2Krwpmsa3+CFet1lp04jgwC+jU9s0odsQFFEiXuQ
         x/XcOs2WOHHIPGWehHI6E2dPjrh3Wea5ARTeXiCFZ9c6OXRENN4Lw/uUggHjqxm41Y6/
         Cy3l+XxBkAp1iRQYNxvMPl2NiKq4lGuL420L8DZ1k7D5At+/tFprSsiZwsz3NGIVqesh
         hPs8Np3Ngt5dD8a7+4k+SxSmZFr50uvRK/Y5RgHbNwWqoKmQ7obLtri0F0LFoWg3X4XI
         U/mQ==
X-Gm-Message-State: AFqh2kr9XZzTMecE07whnW24rxRo64DGmOHjp0s3r2wpp9o6w3tN0q3r
        x6XpOw/14Vg/YUIb6X5M2WatdQ==
X-Google-Smtp-Source: AMrXdXvDTBZCnGHNykh2Sn+9DBpfC8zz9gkjynxsar+dFJVjPFfossRLWPdD7Q448b3xMrUG/1HDkQ==
X-Received: by 2002:a6b:3c13:0:b0:6df:128f:ca12 with SMTP id k19-20020a6b3c13000000b006df128fca12mr109045iob.1.1673913635996;
        Mon, 16 Jan 2023 16:00:35 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id y88-20020a029561000000b0039e2e4c82c8sm9087985jah.123.2023.01.16.16.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 16:00:35 -0800 (PST)
Message-ID: <28ef62ea-ea63-3969-7635-aeab5f45c55f@linuxfoundation.org>
Date:   Mon, 16 Jan 2023 17:00:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 5.4 000/658] 5.4.229-rc1 review
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
References: <20230116154909.645460653@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230116154909.645460653@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/23 08:41, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.229 release.
> There are 658 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 18 Jan 2023 15:47:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.229-rc1.gz
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
