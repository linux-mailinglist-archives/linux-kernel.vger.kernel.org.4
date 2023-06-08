Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50318727596
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 05:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbjFHDWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 23:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjFHDWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 23:22:06 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B06F1BF7;
        Wed,  7 Jun 2023 20:22:00 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3f9b7345fb1so958361cf.1;
        Wed, 07 Jun 2023 20:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686194519; x=1688786519;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rDmhgUMptgqCFAaGR0cnds2IP5rF8+pIzv9UtuKqWTY=;
        b=cKwJ6kFqes47BOu4iEPfOaj9ttsuyInQFORlR8iAcM5YTvW9hT4IZ7MJYlrx/AyNll
         zHT3Sl0ZJbAQfWgfCYspZomCPXIGZ52gmyvpt/oWc/wsJUjjXIHigOnFyzyzFClKd7RO
         CouXmlEerStu8lyYTJNgybY1TkjK9eIPF8jiig0/LV5f/K9GBI3yM5tiegaaX3DcLHQK
         tgZheVBnnEW4SpeWXVavnhNEXu603k1J4iW8NX70QKMc0lcQGr33FhIHgpwzWpAgMlON
         7xKMRXZyMmciV3uD/Ic1KeZpSSMMk9qlViPcpaozhfFcvVnBZNe651xp4sl3j0ILBxNJ
         hskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686194519; x=1688786519;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rDmhgUMptgqCFAaGR0cnds2IP5rF8+pIzv9UtuKqWTY=;
        b=AfSPx2oVYTTyZ/u03CeZp32eSfV0JEyFs8epPKXuN0syNZVTJUjpvTlRDmYM2RXFEZ
         1kuCNt6e29/PHHCOpQSWVFG9xjEhmpBS25pMceA66pX79ZK1kxFM21y8mUg8ux9aa4ST
         UALL0vxzygPOEuvO1eX47lSQ4GWoFgZc6I/IS68ineuEfjzKt5CiWlV6FuzJ0H1pCWfY
         V1/euJhjCrSasGEYcWc/jbp9JgMKDp098/HAyeVArdJW1OyU5xSaGxxQo6td4hvb1VRb
         oRZUaovjmsbM2v+SE9vfobwm0T5GVxVC+TEzhq47/OSYCjg5FXN0lW28yNHRaW1m0f+5
         7CFg==
X-Gm-Message-State: AC+VfDwcswOSJojvjiKxSpI80ud12FPVGG3xresvaabTkDXbHbsUXH2W
        PzebdUyab7nB1eElyxSt2fk=
X-Google-Smtp-Source: ACHHUZ6RqAlxXsSrX+hRrfDYWW2JotPzFT1yrNwtA/YelaG06ni4T5XggcY3gkvqWPMj8fYhSQ9QnQ==
X-Received: by 2002:ac8:5a11:0:b0:3f6:e3aa:a61f with SMTP id n17-20020ac85a11000000b003f6e3aaa61fmr6010229qta.19.1686194519561;
        Wed, 07 Jun 2023 20:21:59 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id c12-20020ac853cc000000b003f517e1fed2sm38224qtq.15.2023.06.07.20.21.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 20:21:59 -0700 (PDT)
Message-ID: <3d8a4762-c244-fcd1-f5f0-e4b48602fa68@gmail.com>
Date:   Wed, 7 Jun 2023 20:21:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.1 000/225] 6.1.33-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
References: <20230607200913.334991024@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
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

On 6/7/23 13:13, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.33 release.
> There are 225 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.33-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tseted on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

