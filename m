Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808396C2559
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjCTXDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjCTXDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:03:45 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640692B62A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:03:42 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id i19so7291464ila.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1679353421;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ol+B8Rm7LVaQanwklijT53+0nw4R6I7B4CbLiSGN/Pk=;
        b=RgYCX9O06NwGjLyuHV2WomU4VjXgs36NaRYJ0sE4B8OL458JDfwZ7SguBvR6fpVpsJ
         E1pqiN23oVloOKu/jZ/GI4lwGArFTBgJ4SPYnvHh6kvnQ8bP7JE48Mo1eQaEFmphfSD4
         0CrK5CLjWMqvfbiKh13UKqHgWt0jbxtJa28WQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679353421;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ol+B8Rm7LVaQanwklijT53+0nw4R6I7B4CbLiSGN/Pk=;
        b=5Cm5I6Akg/KaMYINMkGJMOVjv/Xmbz970vVdvKKRRWEZ3FxDvP1JvjBNF9edumpmqM
         bTAf59mJrHbRxclKwy89FmlANCJxhfr8B+cljQUau9da8luKg/LrlsJNivtMid2ESmcq
         sPx7hub093rTipVcoOT7cPSWSPPvy7JX+394N+oV1/XO1CgRsMQUiq+WYd5r/Iq3QH4y
         eqTrI09W8C/P0PzfXRiHyDikQV4Sb1D06GpLUgAHE8q3w1F9kfImb14DLnAGkTutfBeU
         cMEPpzIcTcrK+m79ll+27GF5FvNAm3oY/rjt4Pau5Tn9WRpsbAEpJkuXaBBy43sISI5t
         Q4ew==
X-Gm-Message-State: AO0yUKXpRFGoq+mYVZmfxPbPI1tS6zP67/E+pQ7PiK9HeBKmiNQTjVer
        GDlA45P6+6o3dAYipsCc4TkX6g==
X-Google-Smtp-Source: AK7set+qoYIZU3pybFsXNLjZfkMU3+Ix9iiBcaZ7cGlom31OU6hykJgVvVq6i0d4ySEK6jtvlWiY5Q==
X-Received: by 2002:a05:6e02:1152:b0:31f:9b6e:2f52 with SMTP id o18-20020a056e02115200b0031f9b6e2f52mr686717ill.0.1679353421695;
        Mon, 20 Mar 2023 16:03:41 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id s12-20020a056e02216c00b0031798b87a14sm3167497ilv.19.2023.03.20.16.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 16:03:41 -0700 (PDT)
Message-ID: <03bfee60-e4f8-3b47-9c09-7d997fc801d9@linuxfoundation.org>
Date:   Mon, 20 Mar 2023 17:03:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 6.2 000/211] 6.2.8-rc1 review
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
References: <20230320145513.305686421@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230320145513.305686421@linuxfoundation.org>
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

On 3/20/23 08:52, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.2.8 release.
> There are 211 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Mar 2023 14:54:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.2.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.2.y
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
