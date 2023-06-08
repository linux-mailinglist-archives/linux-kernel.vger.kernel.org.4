Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D67D72744E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 03:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjFHBaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 21:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbjFHBaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 21:30:01 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B7E269F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 18:29:59 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1a2cc92f12aso22447fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 18:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1686187798; x=1688779798;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q9wnjGe5UURJo7WWA04Rwg6yssO99190s+RUQSR8wj0=;
        b=d0sDMlHxot8jX1BOZfMCdSShbw6aKymnJQ2DEioJuL8ZGkNj/mcM2tqtmTlKZJnPeS
         4s1ddrkzMf7EDE/O6rj2OR/iNV8P2gcYHdbrQTfZkJg9IezU/p4scbIFXQzB94eFPHWB
         B7yd9k6wLhKbBm30dknQ8fgcMGou2Soou2Utk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686187798; x=1688779798;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9wnjGe5UURJo7WWA04Rwg6yssO99190s+RUQSR8wj0=;
        b=juQ4R0koTvnTSYjlWuLU3iRSRD9nOOisix809Nam/hW3veQZsztLZwDPjqoinyGrye
         Zq3emV8/xEFdZyoN+6wHA3KAwUhAKLsq3ti6z8SbCYt7ihwEXWZrvulTa4G+9yoqagU7
         XpXqM0hFpqlWxbVmvTfqCN7GqUCCDhGGwGPdNPzPRKIFD8FY4PULTFjRP5TA2bzRrIdf
         rL12GuVxEXaw9pnxmOlwAwMIKB42CIcPpdBU46AdA0I2VSwOPREKoJYIL/ajFWJjRbwR
         mfK9DTOm9dJ1vLr7kQDNrf5NNzlHDnCWz2A/2n8cOYI7xvaz3hvsbpIWvnu6WBkLWbWS
         F5rQ==
X-Gm-Message-State: AC+VfDyugUEQXnUkbG3vCSqSdzSmjayIII5bGYd5lQN2t7W6JvKZXpco
        sQIsgCMFUabrpEAKefByKWmkFA==
X-Google-Smtp-Source: ACHHUZ4Wk8tfXecvJKKETcV+6pvRSLdbTHgMZoxgrP4KT1zfyPOL324JtwfpBssrGDS76bzJtDJ4AQ==
X-Received: by 2002:aca:a996:0:b0:397:f167:e3cb with SMTP id s144-20020acaa996000000b00397f167e3cbmr2073040oie.3.1686187797773;
        Wed, 07 Jun 2023 18:29:57 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id l9-20020a02a889000000b0041631393ac9sm3950216jam.18.2023.06.07.18.29.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 18:29:57 -0700 (PDT)
Message-ID: <2731b2fc-f40e-2551-f463-b3ea2c5d0308@linuxfoundation.org>
Date:   Wed, 7 Jun 2023 19:29:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4.19 00/88] 4.19.285-rc1 review
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
References: <20230607200854.030202132@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230607200854.030202132@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/23 14:15, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.285 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.285-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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
