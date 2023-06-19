Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988D0735607
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjFSLnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 07:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjFSLnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:43:02 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1250D1;
        Mon, 19 Jun 2023 04:43:01 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-62ffcc309bfso22529286d6.1;
        Mon, 19 Jun 2023 04:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687174981; x=1689766981;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xTBAhkNEAfivnk42N/MFkAxpYvk7m//AEyhvZcmNRzo=;
        b=NiVr6xLhrXpongF3PI3mhC9/bYP7HlHDnCovgkQMEFWnC+lwDITWQwgkyl0MMjxTF9
         6Gb2uFiZHFYs0KKl5xftXF+/Sp9t/5ZBh5P/5l+5blmAYfnEXEO7gCXdFX/5mHxPCjEo
         h63Qr/cqxDOUjujxReqsDGOkkSWxv3aO5TVTeqL5ammZle5hDlUt4B+lhhA8/0h+mhAe
         G0BNTN2OIbtf3iJuCLsVAxVOfQcGirdMIgwc41SxNivJPjw7vW9/lBBNlotjYbIhS421
         7Eh+NLKFjnTIMrvaeNbSf3YUR5xnkhltHnh9Q0NLjlTG1hKxJ/VhA28Krr+4KsHNUMnY
         xD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687174981; x=1689766981;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xTBAhkNEAfivnk42N/MFkAxpYvk7m//AEyhvZcmNRzo=;
        b=gGu+nuD+MUIFPiAzkeAQopCF9MBOB53Ca6lxTNpEPDTGYFIi43Ldnhlb9OSppfZpuZ
         Kcr38zS9hgaGoV4SzrEGV4XXzQ3dce/cRluEoAStBdk4b1mVWP/Jzd9yWjTWqRhidsU7
         TWrcGZnvrJSfnkAfa1pKcLnm8DqPedmKmlgXhOzxYHJmY/Qw0WgPCZXVlQdHD57ZHthp
         czIAw74zqiuTETBb/66ZmE8ofrg7znfOByTSQvJk3GuI+kkaykZidauzmEwkXxiaPwwV
         YLyUw+7VYOi81sxjJ1/E3YxCPIHZtepna1sIiNXqINoH+DNWFbzAglLcVsR/giNi2FSE
         2Auw==
X-Gm-Message-State: AC+VfDwtquJH41Wj7qb6soFONFBcMqj89QCVZjvvZpYJz4UlsB7H93J9
        cCoCoRqJ2XwMoOgvdeSL+nU=
X-Google-Smtp-Source: ACHHUZ5lU7mEdDjnTyUD7XRJituWNTi2xBw5Vavk0uAHv8cfxcQUL1c/ybCv7UiWS386WA/GlL6KdA==
X-Received: by 2002:a05:6214:21a3:b0:5ef:5138:1e5d with SMTP id t3-20020a05621421a300b005ef51381e5dmr11365499qvc.49.1687174980696;
        Mon, 19 Jun 2023 04:43:00 -0700 (PDT)
Received: from [10.178.67.29] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id oj2-20020a056214440200b005ef442226bbsm10390842qvb.8.2023.06.19.04.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 04:42:59 -0700 (PDT)
Message-ID: <cf3cbd12-f108-685d-38db-9a4a448acd1b@gmail.com>
Date:   Mon, 19 Jun 2023 12:42:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 5.4 00/64] 5.4.248-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
References: <20230619102132.808972458@linuxfoundation.org>
Content-Language: en-US
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230619102132.808972458@linuxfoundation.org>
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



On 6/19/2023 11:29 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.248 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.248-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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
