Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB1772730E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 01:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbjFGXfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 19:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjFGXfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 19:35:16 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F5F10F8;
        Wed,  7 Jun 2023 16:35:14 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-75d528d0811so554571785a.0;
        Wed, 07 Jun 2023 16:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686180913; x=1688772913;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6MuL2EHf6nMwXxCCdzWfY9K5gblhiCkw94oAeq9cMRI=;
        b=Ly84wFPmRYV8DYQhiOF4FSzSB6vygUsMzGI/nn+uenyk8nlnTCjscY4gHhajJioJGU
         nY2TYCLb0qfZT/lX0oLHolL1p3mJB2SOMp/cPdYoda7wAQC9IiQ04k0EeNyg+imXUnFm
         Jc5/C5qg2LtMIpIKQ7JA6mV7q31uUcNkO41QdEC+mzSD2Xut8JeUDGb3cCVnfelgNKd1
         1CdxHZC1uyjGH9ve79j44BzJtkYDqs2p3aWHekVQgu2iXCDXozi9a3xHRYKanBPCC8tr
         gSpuNhD6xyVXBoDnlM0kErLJmo1nWsIh1651WZVVMPMe2Z2nMXrLye2FC8jbLaDVvLRV
         y/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686180913; x=1688772913;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6MuL2EHf6nMwXxCCdzWfY9K5gblhiCkw94oAeq9cMRI=;
        b=aOTMrEXci4M7dcWdaRAzEM9vJVspBQ2bsuOikqSvhpYMzG4vyA44X0oXKBH+Cyx3Ay
         9DVWayIZE+ePLhJNd4ujVRmHFq8W+uKmFkYUyIxh4RQKx9aQx/3vPx2SbINpemop9YUC
         i+GnuASHUwCYAJ0e0/x2N5IE9gO/82lwHSCd7D363D0ShbCLx80fiu5IMlC1++euDiDz
         v0xjOIwaI4lKzaq/UstdoeDs1g9x3tg9AZVn9xbm22yEeBqrLCSRcCiOaK+8NphPFcHg
         KBZzb7h7pCxhHYVGdTGyjUXv8Zzn3IwWfadb4C8esDXybqcYGDKUNhDzJ1/dtmBLXjPD
         Itqg==
X-Gm-Message-State: AC+VfDzczTyT00SrmUv1TwG3ICx7RpdlpeGhlS/5vi3iUKiiFGvmXbrn
        r8srK6XrWhJpHTMnffynVk4=
X-Google-Smtp-Source: ACHHUZ6qQ9uHoTIKpG6b8jiUfCpdLDc90NHRJgYHmJ80fdTYoonKYafGF9O+cijkkIL8jOUwr2NHrA==
X-Received: by 2002:a05:620a:44c7:b0:75b:23a1:362f with SMTP id y7-20020a05620a44c700b0075b23a1362fmr4917119qkp.64.1686180913530;
        Wed, 07 Jun 2023 16:35:13 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id i25-20020a05620a075900b0075b327a2988sm214819qki.133.2023.06.07.16.35.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 16:35:12 -0700 (PDT)
Message-ID: <35d1b011-dd43-9e85-1043-1cbd9a4e807e@gmail.com>
Date:   Wed, 7 Jun 2023 16:35:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5.10 000/120] 5.10.183-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
References: <20230607200900.915613242@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230607200900.915613242@linuxfoundation.org>
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

On 6/7/23 13:15, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.183 release.
> There are 120 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.183-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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

