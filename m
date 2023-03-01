Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06B96A7628
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 22:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjCAV2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 16:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjCAV16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 16:27:58 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C9F2D5B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 13:27:54 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id ay9so15955632qtb.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 13:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q8pvJ0948Bk2bTb0EoAuertZuXCjz3BchLxRWB04Br8=;
        b=iUR84SphNv1FyhaQJhtzaO9+4MBhSlOjzCV+2WCUuwDRqrIOE0L6zYGz89lQiU4AZy
         yzJubnXadmlmV+B0iK8Hh8PCfXHiPPWDwpINBjUHGZnxIr71WemGK+ra1NabfgizxRZm
         kX7oLeaCiWmOTDSs11TgIQCs8c3Szd6q1b12PgPuw7aDC+aQKT+lwdqZlOBkq0J9mrXy
         CXioL8V1kWYdcdq7mPaH/guT1zxujVFotwLAdiDE2kDNJbiOgvvfv63dc1hUawvKMVzE
         G7D6ynOcKaEVrREA8cfvWj8xqaP7HgZScnz7fRQ0OFGPKzy4CU/YWfVN7hn/fowbK56C
         9gfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q8pvJ0948Bk2bTb0EoAuertZuXCjz3BchLxRWB04Br8=;
        b=P52QJklUwYZ/j8OlODS1nNtAtfHE7nKa+OUEg927qGJ/k+1tB7bsHeLOcCAJGikx6h
         JFdnM1nnYDKmKaR3WLvPMRTkJqyJO61lXJjM1j+Zlb2DOsf8CrNsqdoAHeLAklHEgRTA
         Az7TFUnyeyej0OItJ1JahsqxafpjPBvwLN5NlvO6cd0YTCU8I9K5E9kzvLlJv9m7gCfu
         TkaqQGLeHb+nV3JatMJ5RmUYmPe3bKL/N7v0V55+wsd/5SsqgGUZrGPrHJuv9BRG/Zb8
         ra55zNVx5nLP4xCed3c/7ktIj6/ghy5t/nWaczTE0sEp4gmp3+4HGQOSD4OVT8YugK64
         x/tg==
X-Gm-Message-State: AO0yUKWfHl2K8zxfa9gtSV4iIXIKbYo9miUMVqncyPF3d5Fzcb7Tx6tM
        QtoXHV53Njw2vClwqoSSWYJlkHtd6qGSVP1nHgDhbpjq
X-Google-Smtp-Source: AK7set+3OG7Cb+dYkOj0BWXYtK5QZz0QoBg9DJDsi1ikeYlSy4O/EqZOXG4/cstsAfa3PjdHeMyv/A==
X-Received: by 2002:a05:622a:1356:b0:3bf:da2e:8c74 with SMTP id w22-20020a05622a135600b003bfda2e8c74mr14537968qtk.25.1677706073301;
        Wed, 01 Mar 2023 13:27:53 -0800 (PST)
Received: from ghost.leviathan.sladewatkins.net (pool-108-44-32-49.albyny.fios.verizon.net. [108.44.32.49])
        by smtp.gmail.com with ESMTPSA id l20-20020a37f514000000b0074235fc7a69sm9807283qkk.68.2023.03.01.13.27.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 13:27:52 -0800 (PST)
Message-ID: <5f6aae60-89a9-81af-0c1f-4f66dbb27f41@sladewatkins.net>
Date:   Wed, 1 Mar 2023 16:27:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 5.15 00/22] 5.15.97-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de
References: <20230301180652.658125575@linuxfoundation.org>
From:   Slade Watkins <srw@sladewatkins.net>
In-Reply-To: <20230301180652.658125575@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/23 13:08, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.97 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 03 Mar 2023 18:06:43 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.97-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.

5.15.97-rc1 compiled and booted on my x86_64 test system. No errors or
regressions.

Tested-by: Slade Watkins <srw@sladewatkins.net>

-- Slade

