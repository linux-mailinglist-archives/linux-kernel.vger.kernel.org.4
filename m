Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00B3728AC6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 00:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbjFHWA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 18:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjFHWAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 18:00:25 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6701FE9;
        Thu,  8 Jun 2023 15:00:23 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-75d558c18d0so91940785a.1;
        Thu, 08 Jun 2023 15:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686261623; x=1688853623;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0FoCzygeVaKTYwoTk6+wAeoJQ0ZdkPvrWvOdKLWqiaA=;
        b=QuIpwTQOa7UC7Y2z48TOxbIQOwAC4vdaoY82fXO6j3FliB1i8brYH3FvyHY4wJjdcP
         EpI9HqGeTLtxArYOu+XSpXonYxf58g4UeU0nCHggTINDS0m3soU/HAKPjUoeLEkP7jl8
         Kh8DbQX2sXoQGvwQ0cAmeDn890xlqUg0XSu8HrF9Knn3sY5z76lRvL2R8Tnsdez6YLoU
         /BQwztQdeGg92UsmiQhEvx8Pr4M5S2emPMbdPumsI+gEJ6jLlgZ90+/GzQsiPVRfsOlG
         /cbZEmRcNWSzGNvSjvgx3gIv1JWkj148Zxg9NMF0ed4KaLI2/B8bL3SMczoy0YdQt8qv
         amuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686261623; x=1688853623;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0FoCzygeVaKTYwoTk6+wAeoJQ0ZdkPvrWvOdKLWqiaA=;
        b=XAlZFOS7PeLMUXH0rHIu/szZjJ0OgiwAf7RaBveVfOGk2351KVYJSbWD33NoCjTC1u
         f2tmTMcgbtVtK7q2ddXD2rI6ZbGB5eEhDcurz0pu0PKtVFzrzF/OzvGLczkYWMyCTQZ/
         kEdSTJUbsQVCuu+gyBzrV2CzNwBJvbQd4iUHNWIEyLowu1TsjjgAkv42XrfAYd0bXda6
         Ah0WOfMwpYdqV1id/2isTZiL9+63sZyoDGoEXbNvF+d0ifQDBCNMwo7833+pbPz7JYU2
         5W3q8Mwkn+SRJI7zbYp+HktJakLSXNGGaMrbVsNSMYWPpxqPrSRRdRwJf6N+6dws6GHv
         whoQ==
X-Gm-Message-State: AC+VfDzdP/UIrznSEMi4jQWAPyGTLYVeB5XMlHMhJZu5F1AGrtAIgO5P
        ea2puhCrwNfZFlzpsmU4QRY=
X-Google-Smtp-Source: ACHHUZ5K48vPB/DRyHdpkRd9NNEpvW+f2kZM6GW7XXTb08uGNo1PgJTTs2KFyG0C1mi618GVAeu/pw==
X-Received: by 2002:a05:620a:6598:b0:75e:c4b8:8d6d with SMTP id qd24-20020a05620a659800b0075ec4b88d6dmr6068432qkn.25.1686261622900;
        Thu, 08 Jun 2023 15:00:22 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id k27-20020a05620a139b00b0075b1f0e950dsm635538qki.5.2023.06.08.15.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 15:00:22 -0700 (PDT)
Message-ID: <6bb4aca7-dd0f-16c9-0cb5-c09859d73801@gmail.com>
Date:   Thu, 8 Jun 2023 15:00:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6.1 000/224] 6.1.33-rc2 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
References: <20230608175726.909746266@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230608175726.909746266@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/23 11:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.33 release.
> There are 224 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 10 Jun 2023 17:56:43 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.33-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

