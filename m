Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37F17375EF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 22:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjFTUSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 16:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjFTUSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:18:09 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B883D1996
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:17:43 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-77de8cc1370so57019739f.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1687292261; x=1689884261;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7VUNyOpD7UjHXpWrEPFOTh+iR0pIdYAc7/OPkzR6Y3s=;
        b=R1wJLNcmY/vqUNLf0V9PdKWGFzljenfA/lhmc+IDxCQ0uDZA8hA87x21I5Y6sAaV7n
         mFGNl5p5dAgZlTINvK4q3xpxpWhjZUG1WOcfAPIlWoZ29i1HidG72N28FUITN8Qk19J5
         3Am0x+aYVN99Pd+TdKO9V7urBhYx9K7+ygXpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687292261; x=1689884261;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7VUNyOpD7UjHXpWrEPFOTh+iR0pIdYAc7/OPkzR6Y3s=;
        b=Wd3GOkL/y5AEbfMfVGfXcjr98BBIaBrkZuFbYUX2ejCSNIZp/BWMYHYWzh0F1jQgSv
         JzgTS4PmUhNmiwhbqn1sUP4i5MX1rfSViC02oh8vYKcim0NkuMYQmKXFyz/hS9XGW7uq
         s5tL0I6G1Z/XVDR0uzhyLlFz4Jadxr1wxKzm5S9C90Av3lE8k68NVAcwFwEE2lUqllIH
         HTk2VB2jIno8tq20DWc95jDdyC436OfXYgIAFSSM7iRaLGL+AkV3rEXko6sSZjhvHurm
         wUZ92ELwmQ66XjbUOwVHJsG36Lp3kr1MZ41FpjYQe0XLCA84GsteIUQcQhE9IWVzgfFQ
         ugSg==
X-Gm-Message-State: AC+VfDx4DPQPWA8aQSs4vAv2FGFckFHtsaaMhIhGYOt8xHdvKNbuuDAM
        EL0rQPmmbI5LPJEocd/uWJsopg==
X-Google-Smtp-Source: ACHHUZ4b6WI3yGdHwyFzHgt/5IhDV+v9tOmhBgvZK+Z9ydxscF2SYMrILjsbDdB/094bq/mKF+PfIA==
X-Received: by 2002:a05:6602:1a06:b0:780:ad9c:ce57 with SMTP id bo6-20020a0566021a0600b00780ad9cce57mr1279410iob.1.1687292261020;
        Tue, 20 Jun 2023 13:17:41 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id c4-20020a02a604000000b0040f91082a4fsm840105jam.75.2023.06.20.13.17.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 13:17:40 -0700 (PDT)
Message-ID: <31a77b25-1ecf-eb61-4c29-e0f9efbdc1c1@linuxfoundation.org>
Date:   Tue, 20 Jun 2023 14:17:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6.3 000/187] 6.3.9-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/23 04:26, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.9 release.
> There are 187 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
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
