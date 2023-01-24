Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A6B678D22
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 02:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjAXBIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 20:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjAXBId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 20:08:33 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EE42004B
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 17:08:32 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id f8so6840749ilj.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 17:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uTq8cK2fYkwDuQzoqdgDr05vh8PrY+saYx5VEXtMroI=;
        b=V6KisJSg8yQsg/cvtkOZeZ/uNI9rlP7VjVioDdkSzuhji+Pu0QLHUcQoM3+DLge4ag
         ad/75poY0RTUOk4mKvHqOhMIX+LMUXbJNUjcGQBN+DzI5mww4+8x/GK7lDaLU8n6kjVd
         FOabMUeAAt+4RFws1s44w8n+k/KgoQN9uiYlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uTq8cK2fYkwDuQzoqdgDr05vh8PrY+saYx5VEXtMroI=;
        b=L3/gIYGxMfGEEVakv57AR6ujalndIF5NbnnrUe3g4Smil1cF7vMKqr/MWAojeiOZvg
         1udnBOSfnUMGOEUyCZsqcZKWCKFpISED68LZvDVGj7pJii8LL5rW75XG4kxCd8WSgTCF
         hL7FVMT8M2qE/LpCxgPE2Ox1CthNFCtC7fog9sHxLh+ch1p2x36I4fJpu2IOltOelc8H
         9Bbt/rifqqjVV1DWMkbWc7exLu7OgV55qgwLPY07YchOjUI+3Wn/ObhvkA4BN67MSDxf
         2HLUrs9jxC4MLCHg7A9VgaSVKqHkZcuxnxNA0UjdWHCFVqoiN2zAZe50d+uwGLNzpWO9
         Ge9w==
X-Gm-Message-State: AFqh2kocfahdg/wXwRBYvWO9m0eiB1CJUZfKhZhglIQsqmRGeoJDuF4/
        Ah+IFFGCDZRUvwARRaUZtJfOQQ==
X-Google-Smtp-Source: AMrXdXtqztNAmJNM7Ysr4JODEIVVsUoTA1vFBnbysuofQf7uMKfl5m0ZNif3c/CnNxYb9av9OWTueQ==
X-Received: by 2002:a92:d841:0:b0:30e:ed5c:8c87 with SMTP id h1-20020a92d841000000b0030eed5c8c87mr3601469ilq.3.1674522511802;
        Mon, 23 Jan 2023 17:08:31 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id h3-20020a92c263000000b0030db1001846sm234182ild.82.2023.01.23.17.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 17:08:31 -0800 (PST)
Message-ID: <07826d1d-3045-9ce2-63bf-266bcbb4f428@linuxfoundation.org>
Date:   Mon, 23 Jan 2023 18:08:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 5.10 00/98] 5.10.165-rc2 review
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
References: <20230123094914.748265495@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230123094914.748265495@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/23 02:52, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.165 release.
> There are 98 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Jan 2023 09:48:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.165-rc2.gz
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

thanks,
-- Shuah
