Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5964370CF74
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 02:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbjEWAjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 20:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235549AbjEWAbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 20:31:02 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00AFE5E
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 17:22:25 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-760dff4b701so19273439f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 17:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1684801345; x=1687393345;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m1KXf+0oVrec/1jZIsJOSJ4BWkEAOfc45tHTV/llHu0=;
        b=gygoReIEqd5oXldd2VlxgqzQrKjnHo5hYuGMTw8mK0GGvbdpyKVHIbrEgSRfzcY/NR
         TV7jiZ8JGzEyZvewrQOwocyebPeIMz8U/fFW0TYr6sJc7azCFSAsuGtt6hhxBBaXpVUl
         lMaG1G1+u9gAthZREC24zlpfvqEeVg+Rtc73U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684801345; x=1687393345;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m1KXf+0oVrec/1jZIsJOSJ4BWkEAOfc45tHTV/llHu0=;
        b=eBf7aJo3IhtyzsHq+VNUz/mVost2JpAiLuWqckjQUoqrcbembZ+H8x2lmpv0D0ScGl
         ftj3Mbe2m6LE81xbez4sDX0pzlVBtBPL+208RL8fvqs0PXKS8CwfyprAdz0Hxtd6MWqR
         4zEmGo3kvaRXqLc8511n4vuXZgJ3m6hKIaf0kpi49JODY374B53ftiJf+XiCQLOWH2aM
         xMu9uHD6QrZtuInrjCaos2GKK4FO00XjAz860uSlH1iYlti4I8uOEfubShbBVeAosvza
         HsszH2tHEIFp+ejUWCX///rgjBjEGVEfc6qi/HDRBiubJ2ZIt/ldPc5DwyPq9jUStaag
         bGUw==
X-Gm-Message-State: AC+VfDxRhbqqHANQ7Oph23ulYO3LBTiGgp6aIvXzpCc9u0C12sO2u/Dk
        6R6AVt/Xs6Uh6NfuZu2MGOnX0A==
X-Google-Smtp-Source: ACHHUZ5hHYo4gV8uQUWKVCRNzARvNo799/v9yRvPua8HHhkGITEqM4LqwLaYBr1k9K3X+T8WgUYW3A==
X-Received: by 2002:a6b:b40d:0:b0:76c:77b9:b82e with SMTP id d13-20020a6bb40d000000b0076c77b9b82emr6043040iof.0.1684801344995;
        Mon, 22 May 2023 17:22:24 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id b27-20020a05663801bb00b004063510ba0esm2180436jaq.142.2023.05.22.17.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 17:22:24 -0700 (PDT)
Message-ID: <e79352f2-6f16-5fe1-f757-39023ede4fe8@linuxfoundation.org>
Date:   Mon, 22 May 2023 18:22:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6.1 000/292] 6.1.30-rc1 review
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
References: <20230522190405.880733338@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/23 13:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.30 release.
> There are 292 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 May 2023 19:03:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.30-rc1.gz
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
