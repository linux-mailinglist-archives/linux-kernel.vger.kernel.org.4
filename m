Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0167765DFC7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 23:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240272AbjADWSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 17:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbjADWSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 17:18:32 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83CC12779
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 14:18:31 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id z10so11924660ilq.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 14:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KKo5fPMRdKGz/7RZcIbHkPKTsudmAdqtb3BfDvd7eiI=;
        b=NOAn4CM7EZnxg3vagPtncIfpjpLv7OC9gil6WAGwp8N2XaJWrEdp+HZFRLePILULVv
         NWPB+VDRTb6xuZWPoa+qdI+fle9KwJVqkUGeL3AxCQVlZoQPgaCzwywxV3QAY8PeaIqN
         EmtZuaa1i3nk7xK4U1RdRqiA7MglylS9tYiKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KKo5fPMRdKGz/7RZcIbHkPKTsudmAdqtb3BfDvd7eiI=;
        b=W+rZpaubWiP7dUiWvVyEe6TD2CruiOIrddENVe4buFZWur2sdQ+2P9cFy80xh4Dm9f
         EF8aw4mMZ1A+Mp2zj0Po3F9Vg3cCOuaz7hL43hBo7yhyOFUXj4i4K7LNjdLkTZFGXfqr
         ngg1pLmR7LwAiU+ZttW7w+IsByA+G3hzkA1fTscXXhvTvzREANxyBsK2b5k/irYHqaF3
         v5cNiSihsNMjvWWRoB9a1f1MbVqcmVUkTGIFS1Swa1VgcnURdFivlHyjKykvxJ5Vx61e
         yEuFOhMKxlwkRIbXw2eRqSMAPSgwVrdmDLBYj0K7q3luTAGaTRLM/Fg8P2ZcstbIVK5Z
         GETw==
X-Gm-Message-State: AFqh2kq7hwqCieeECUL2d8liqDhsxI3cSLV8drdW+Z/AhwVTZDyQYlQO
        MMBTR0Bzj5+SzVWmGVLykknTBA==
X-Google-Smtp-Source: AMrXdXthTw+Kow5gRYahz4F8OuHqi2IEJEDJjoJn0MD/pP0jU50f21tl3vta1TAJAkv9LbSf5y8SBA==
X-Received: by 2002:a92:d307:0:b0:30b:d947:6bc8 with SMTP id x7-20020a92d307000000b0030bd9476bc8mr6730778ila.1.1672870711036;
        Wed, 04 Jan 2023 14:18:31 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id g62-20020a028544000000b003781331d909sm10977580jai.9.2023.01.04.14.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 14:18:29 -0800 (PST)
Message-ID: <b7bb6c30-7f6f-80f3-cd10-b68659f6e0bc@linuxfoundation.org>
Date:   Wed, 4 Jan 2023 15:18:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 6.1 000/207] 6.1.4-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230104160511.905925875@linuxfoundation.org>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230104160511.905925875@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/23 09:04, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.4 release.
> There are 207 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 06 Jan 2023 16:04:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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
