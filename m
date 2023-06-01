Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C0271F134
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjFAR5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjFAR46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:56:58 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8CE8E;
        Thu,  1 Jun 2023 10:56:57 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-651f2f38634so491476b3a.0;
        Thu, 01 Jun 2023 10:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685642217; x=1688234217;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eW3QFVF57TKq+xJSZJQaBxxKYLyfH2NJCp7Uqxfjsd8=;
        b=E3pEJVxDo3EZC5CvAjfToZZgPEP2m9NuBKb1kJurZQ+tevnlv1LScOhAn47Tzv4omZ
         qDiUGwHHNI1sJS8EXRvwStb3NvIX/oVlhKntwOXPxCXExqZkguGWUw2Bm03nnBvahh43
         mKQ5f4r1RJc5JCzWKI5vX+XM+0uXnxHUr5ksV0QUx86G7I1NA+BoXHai8rh0+4Bip+2f
         zkl+jOSGHSglRBNn4XET1A8Bg7m9ROYxlOKk0GFn3QSU9EDxrSp8NwjmYmLjJwYwRxCA
         EIo0NCKfGZEeyRgi4P+RrmIfjimf4zsRlw1v4VwugbIs+NtXVLByepdbjioh3Yqtul8e
         KVgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685642217; x=1688234217;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eW3QFVF57TKq+xJSZJQaBxxKYLyfH2NJCp7Uqxfjsd8=;
        b=XUmEicWqdUMwzwKmf5V7IsmR0IHilwqBxx8mImsp1FIYR08avmsgQqJdnRuMhDzNRY
         devT5d6iGMTk7up7UqzsD0fmyxrqYUsSecf9c3qGeH3OYInbYgyr77E5Y5Mb6BxS1lBA
         mWk8n4EkO5SHEGZoygq/vEzoMn0b3xJSuWN4nJ6Kf2eghtmam58xCrZIED1AkllBtbwa
         uTl8qflzTx8EffMz6QzUbiwxEHiV+Eyovdpf0nmnzOqfbe5FvEUkNwxQigMyKt+dGalb
         E1uQ8/e+3kMfB4BLCNwE6xeTCExpGQrxNtDlRG3j53QETxoUyf5Gcq9u0Ye+6nwwFB8L
         GTfQ==
X-Gm-Message-State: AC+VfDyQcEs0TzQ/NdVY1MgowFkIrMRwXZujFf/yT9MevAlRQyQ8U97P
        h6IDzgqnuTGJf2fY99+NqM4=
X-Google-Smtp-Source: ACHHUZ4iUp0Mo1PQUUKsMCABVAushMXRZCylzJ8g1BUdc/cieUhWDCiC+J9eJGKFewUaldTKKFKCDA==
X-Received: by 2002:a05:6a00:2450:b0:63f:2f00:c6d with SMTP id d16-20020a056a00245000b0063f2f000c6dmr9997307pfj.2.1685642216952;
        Thu, 01 Jun 2023 10:56:56 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id q24-20020a62ae18000000b006414289ab69sm5364231pff.52.2023.06.01.10.56.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 10:56:56 -0700 (PDT)
Message-ID: <de024e21-6cb9-d90f-9a0e-561ba979f242@gmail.com>
Date:   Thu, 1 Jun 2023 10:56:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.1 00/39] 6.1.32-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
References: <20230601143327.479886832@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20230601143327.479886832@linuxfoundation.org>
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



On 6/1/2023 7:35 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.32 release.
> There are 39 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 03 Jun 2023 14:33:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.32-rc2.gz
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

