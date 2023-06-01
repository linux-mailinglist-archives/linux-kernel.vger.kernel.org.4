Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4494371F3D4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 22:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjFAU1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 16:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjFAU1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 16:27:10 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61490D1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 13:27:05 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-33110a36153so41745ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 13:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1685651224; x=1688243224;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QWBKQP7vVkJhhBssZg4awleL2zGJW9kgrjr0/VfEE8k=;
        b=cWBGFQpN/mtiiE0qRp0NzVkvAC9GFTramLfyxZv5vxQ8dm9SrCS2C3hnG0Iys/eiLO
         707L5uSmdZhe0xS28D2gJg2eW8W/ULeHjPs3oR+j6dbfv/jxqgf/qRGIL471Sj+EtQ4E
         VZAL0Y6J/QWrpoGjFph3vDqdWeHQGI9ZJTS24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685651224; x=1688243224;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QWBKQP7vVkJhhBssZg4awleL2zGJW9kgrjr0/VfEE8k=;
        b=EUddyW6fEmF9+NyEoxYB3zLvYdQXSFslslZvF8cc8noewJu+ezu1wP+iAaBt7k93SS
         gzq8m/DCodDH9BN8nZAFv5K1QWkk8sEw2w3J9R3BUL8WiMJIupuIG8UrQbSChf2lGoN2
         W+uSMPewYxMDe20W3JwTdMZ/FQc7PPas90xxxcVQoNUxVJagaf+OO/+6evVWqi/xjDBr
         ryoAOzt3iKrlGpW+GTy6onRxO8rpxLfJeKYixM5x79YVDdmPgkJYGhZgyuKywOo1nc0c
         U55dHttrSlfDJKG1cvnNanV+BLA7EPhyR7Sv+yKxSi8wilDt6N66kGY/opiFlOKPloVA
         NicQ==
X-Gm-Message-State: AC+VfDwH84bt6Hxq5xn1U6B7xvMQrOqkBlFah+B5+dghvfRbJdlMS8Ms
        z09Wzv7CgMzvBbp7QPVVyPRezA==
X-Google-Smtp-Source: ACHHUZ6JlTDpujIStID5N1PWmlkzLws2U6mW19OXDwAS09wixvCF06e5l9QOZwBFKp5eTDQEbl7AGg==
X-Received: by 2002:a05:6602:2c49:b0:76c:5c79:81bf with SMTP id x9-20020a0566022c4900b0076c5c7981bfmr6465399iov.2.1685651224704;
        Thu, 01 Jun 2023 13:27:04 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id g186-20020a025bc3000000b0041643b78cbesm2547800jab.120.2023.06.01.13.27.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 13:27:04 -0700 (PDT)
Message-ID: <0fa8408e-81d6-db13-4f97-c975a4647aac@linuxfoundation.org>
Date:   Thu, 1 Jun 2023 14:27:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6.3 00/45] 6.3.6-rc1 review
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
References: <20230601131938.702671708@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230601131938.702671708@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/23 07:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.6 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 03 Jun 2023 13:19:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.6-rc1.gz
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
