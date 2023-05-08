Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B856FBB1C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 00:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbjEHWh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 18:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjEHWh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 18:37:58 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A28C7AB0;
        Mon,  8 May 2023 15:37:57 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-61b40562054so25810796d6.2;
        Mon, 08 May 2023 15:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683585476; x=1686177476;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MJkBy5EhvULhTIUWG0tl2IkSQVaZ72VNBGuYy2i26s0=;
        b=EnPPvxkasliKAFV0S5FBDMJU5GlsgYqLJCJW6mFeVhF8OLKOJsHuoLxdP7Q1v1AjVI
         0+zRgvGP/OKGkydl2UJ5Job/F69SEsR40IntmodAhgsm3sP6hagiwKEBJXOCkbcj8wtO
         hgYZPSBxAwK31+fu9icI2Y+V2e1S/rnTuHrlSz0tr20KiykOl51q3fKcvSMeU7E5qf2X
         KWMmML7FlqkycOWg2AN/LK9FRRRjTw4fO6XdjdcBCBcJhggfKbtOQSrdZBru++62rQan
         +T5ZYfN+B1UOV0bxNsUc+JQ7prEMwPSR5iimEOurfdlTsF5LTGIyhOI/OpaS3h/JO1NQ
         dSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683585476; x=1686177476;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MJkBy5EhvULhTIUWG0tl2IkSQVaZ72VNBGuYy2i26s0=;
        b=ePGCZVvdvKjWDxsQKdr0LaynSGJqMxXT3dQdRMXa8c8Xzzt+DP+anL/6ue8DPJjJeZ
         VMmDxDctuaoGWzLzR1HNB1PIad3qrD17Zyu3wTic5khSQ4JIBMZB49LwJNrTlXAUB2cJ
         icqZoWlHQovRX4cR0/2qPHtrJgtZycLc2kaf3IAS/YDEvinadPkbj375oNlnrmue/ZDt
         SAJj+svAflUOHwGJ8NzmlYPCg1V84PardAM6u8FUAv6Eh0GNfoKKcVfOKXvFmncuw5aH
         PQxW/0oadJkB8xRTMTqsCrefzLZiKMxncmrgZk0mU9xIGVgKXB2eqAIzpit07AD6od3d
         II7A==
X-Gm-Message-State: AC+VfDzMZkVIBGl0CZAJGamS0o3QbfQqmTK6EClzUG1ioPnM8ZUQW+Vv
        NWa/0dWSfD5e35hy/bIu474=
X-Google-Smtp-Source: ACHHUZ5OwMyCitYHah+w9aQCDUs8Wtq3PhzO/6Lf6RIKL760ylUrBGsJUx9djMI/3TmDM7N7a7r0kg==
X-Received: by 2002:a05:6214:528b:b0:5ef:50a3:f9ca with SMTP id kj11-20020a056214528b00b005ef50a3f9camr14950747qvb.47.1683585476323;
        Mon, 08 May 2023 15:37:56 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id o16-20020a0ce410000000b005dd8b93459esm316406qvl.54.2023.05.08.15.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 15:37:55 -0700 (PDT)
Message-ID: <b590760f-af50-5b01-079d-546724a3c21c@gmail.com>
Date:   Mon, 8 May 2023 15:37:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 6.3 000/694] 6.3.2-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
References: <20230508094432.603705160@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/23 02:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.2 release.
> There are 694 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 10 May 2023 09:42:40 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

