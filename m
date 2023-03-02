Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA01E6A792B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 02:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjCBBsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 20:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjCBBso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 20:48:44 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6942FCF4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 17:48:42 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id b5so6212177iow.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 17:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1677721721;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LI9ktTm0KAROfKF+Tom49bo5EIIc3UNFtFo5FidgKv4=;
        b=EXm7q/w3WIA/IVlRBLgD33z8jF6s+CSYYB5aCHm3zDGtZf3MGjK2ECk2IL5YzxCnu+
         FTx9bVN/jce0Pqaj+P3BNay1BGzI1ELULYHdJ5LpkkghCEc7AbhkeQ26HetJgDgwz4/r
         jMSyh64zUHBUWzXEty/pkQtRZFaovNJhKPq8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677721721;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LI9ktTm0KAROfKF+Tom49bo5EIIc3UNFtFo5FidgKv4=;
        b=ZgYDK3AvjB9BfOOdieMdyCW12fuBeppMN5hV8ds9qr8dNPTvkOlUHj5JEktlKX5EwP
         tv+MoI6M3wz9fDqNEBFGRkgPO3FEUx2BdHWtooBogXEjqvniulMk18wDtc2S+PeQg5r1
         Us2syoUJXBznpHkh3Pn3IXwxfun8mGxsya7E6jTFw/+BohyU5f3ZL5k55aODwXaLB7x4
         oKQ6H+ZrwZRUbMOtprTecJbgvu2ASNdBhwzlkKKvm7IO0RsW9iFyoxwMTixHk5KQn4M2
         3dw5SuCRNHfu/HhpgvBY4dgC85xAY++BplQx73q828+pxT+VwPJdqnAC5ieVd9rp8Od5
         FL7w==
X-Gm-Message-State: AO0yUKWSYOXzo+QrGjBO0VKpRSjYaqjCTNRBry5FRlSkYaZAMbHl+AVv
        /rXw3B36hxV3PBmOEyOwAJyNkw==
X-Google-Smtp-Source: AK7set+h2Hmg2PVUhZc4ZIVCAowgVdcDj1RupIMahDS5XqhSqWrSaeoXudOk78dxiEOrYNpYK/pfzg==
X-Received: by 2002:a6b:c80b:0:b0:715:f031:a7f5 with SMTP id y11-20020a6bc80b000000b00715f031a7f5mr4751655iof.1.1677721721616;
        Wed, 01 Mar 2023 17:48:41 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id m16-20020a92cad0000000b00314007fdbc2sm4071526ilq.62.2023.03.01.17.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 17:48:41 -0800 (PST)
Message-ID: <80f1631a-52d9-b576-ca78-5809b74b6da5@linuxfoundation.org>
Date:   Wed, 1 Mar 2023 18:48:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 5.10 00/19] 5.10.171-rc1 review
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
References: <20230301180652.316428563@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230301180652.316428563@linuxfoundation.org>
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

On 3/1/23 11:08, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.171 release.
> There are 19 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 03 Mar 2023 18:06:43 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.171-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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
