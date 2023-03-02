Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774036A792E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 02:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjCBBuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 20:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjCBBuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 20:50:21 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810A54AFD5
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 17:50:20 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id r4so9610526ila.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 17:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1677721819;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mF+UwKlmCIUoktbLWxpu0pnFzasKfLV4sm8o38QfDX0=;
        b=WCGqRtES4FcHT9mXRPgt9cYM//xPtt2BjatZYD74NQCcti2ydDnknqmXluXZCOE5uY
         BFZEj+UvfgbC2WBrHAXJ40MqRNzVzQc6jSVuRozi4v6rkXqaoCA1/nZDQplM0RbiCORG
         ryzT0wTvUuakaGTCk6edop+/nfz3c3WgW0XIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677721819;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mF+UwKlmCIUoktbLWxpu0pnFzasKfLV4sm8o38QfDX0=;
        b=LB+SlyHa7CzVH50FgNgxh4pnIN/bEGSpZeLoctNvW/fX+4VHsENcl2Xq3qAX4UIWPZ
         zFUY7UYnCVjanAe2X0kI5w58w6ry46pUhv4zB+HgebBwFmmdSQuI3q5m80oDjjnpxGF6
         mvT8ZelrxFZZSTi92yqJL7klOTepvtLGrB4InkfTv0bWy7B51V9pfIapjrmZr0dRgphO
         iU7AJgv4lmLm2ApQ+xxv3BdQnhZtz814sGjOK7urNlb1eTD58Nn2sVC1Y5a6obEj07q3
         7ABogTH9RbVWyg3bQgLCdhqSmhhXPMKVP9HOyQC0vJmuI+UF8F3Oia0rifNApPRc2zQ7
         wnuw==
X-Gm-Message-State: AO0yUKVO3vfm0V5hv+JsEuaLHpVAvt+8aIveaNiSCn3SUCsj63hZpfQ0
        /arbjt5F+vHIj+dRxNlxCJp+iQ==
X-Google-Smtp-Source: AK7set/mZA34+COiGh8CSis1f5GXLDYkgGpBiGLxdA8/3DdMo4BMIz5aUORczQaONBZ9sNNSSWhD+A==
X-Received: by 2002:a92:8749:0:b0:317:2ccd:3896 with SMTP id d9-20020a928749000000b003172ccd3896mr5075355ilm.3.1677721819453;
        Wed, 01 Mar 2023 17:50:19 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id m3-20020a02c883000000b003bada974a13sm4331061jao.165.2023.03.01.17.50.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 17:50:18 -0800 (PST)
Message-ID: <61575aec-ecc7-0a20-3e5e-6f38df6cded8@linuxfoundation.org>
Date:   Wed, 1 Mar 2023 18:50:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 5.4 00/13] 5.4.234-rc1 review
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
References: <20230301180651.177668495@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230301180651.177668495@linuxfoundation.org>
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

On 3/1/23 11:07, Greg Kroah-Hartman wrote:
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
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
