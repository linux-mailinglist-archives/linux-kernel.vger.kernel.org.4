Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD97A6BC214
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 01:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbjCPAFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 20:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbjCPAF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 20:05:27 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F50025E05
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 17:04:49 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id bp11so115555ilb.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 17:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1678925087; x=1681517087;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NcyC6TmL6Ixm3qQl5SnDBlbDITCyRh/BIzkGTxVX6dE=;
        b=JqeYTktBIO3BrZBbEHR652A3Z5I6XNVvEVx3JGn6aYhtp1iaMy+6FOlSJYUqb8DASW
         hrsnGnzkC54Gg6YAh5+XJUKqr9jVC9AZ0g+c8efHoa1zFxhix5FkuUVmGJGhL7uDmcvi
         xMl9aO8UnvfFG+OIgxXIwMOsO2oFpCH7V+Ka8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678925087; x=1681517087;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NcyC6TmL6Ixm3qQl5SnDBlbDITCyRh/BIzkGTxVX6dE=;
        b=c5SGfNbKt9wCPSAidtNefuY3xxwT+RUR677AF3ehXugZqQkoJzd9FfZaZfIgU4TvNC
         Yk2+NOOSDHCRaGwxRskDzSirqmiXqdpc4sFdnshCuEpXMxKP5aCz+I6su16ZofnntleK
         3pYeo3k+dCwKfbHmMsQU+5Hd3S4H/Lam/DFkOPmFrrgIWN6ZmKb2WAc5Rn9uqfZYiovo
         MTFKSpu+9AmaFF5xgrdyxVmWCAwp0x8elOke7b7HAoqF8vxxSyCzAmWLPPfe7R2iXv3S
         N+oH1sSB29+VSlVkW4OpA86dGOFdvHvrQ1H0/A7+QIuMraSDEuStO+tgKhC3WApU372K
         f5Rw==
X-Gm-Message-State: AO0yUKVHdjdBR3o8sXe2eGKpAjEOnA1I+yMO8aG48yfvP4PMRUhBm4dH
        OWXmNY/HB5xK6SLjNhGBCI2iiQ==
X-Google-Smtp-Source: AK7set//bjb9cEUAND1W9Tfd25P/NvhxXp9+AP7JRWZJcv8hCtN98oFPKouBJxqH5FL6VYjOUsGV3Q==
X-Received: by 2002:a92:d64f:0:b0:323:10c5:899e with SMTP id x15-20020a92d64f000000b0032310c5899emr2966919ilp.1.1678925087525;
        Wed, 15 Mar 2023 17:04:47 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id k15-20020a02cccf000000b003fe66427492sm2091514jaq.42.2023.03.15.17.04.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 17:04:47 -0700 (PDT)
Message-ID: <dee1c998-cf70-8300-8360-0cc85bd0887f@linuxfoundation.org>
Date:   Wed, 15 Mar 2023 18:04:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 4.19 00/39] 4.19.278-rc1 review
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
References: <20230315115721.234756306@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230315115721.234756306@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/23 06:12, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.278 release.
> There are 39 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 17 Mar 2023 11:57:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.278-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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

