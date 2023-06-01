Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A5871F424
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 22:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjFAUrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 16:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjFAUro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 16:47:44 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4161A4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 13:47:36 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-557b27de8a7so135459eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 13:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1685652456; x=1688244456;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jkYCXrweN4xo12j9HaIou/Xwed4BuCxxv8hy0/0Zvow=;
        b=LaJuKOtBA4jgaPUgDSjx4U/mxwv4A3B72x9AcYRIqsIvTX7qnpG+4iS9s0IVZoZ1Jy
         gh0CzeIKabQ0tMHhgoSDDp924upC7anpppMTriJQUqjfRNSDVUEiKPiLQbQaJeKUDvqe
         aNcJXkuTn4SRQOSaLaqllnt7MSnAFzuTV+/KE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685652456; x=1688244456;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jkYCXrweN4xo12j9HaIou/Xwed4BuCxxv8hy0/0Zvow=;
        b=WdhNH/JGTvt2Ep8X7v86ENqcqSA9EQJ9cY8pNO5OuijymzVeGYMHvPSCld9plNR18U
         svo6/uayIOsl8u7KsRgHJQ70Eu50yMorgTWc/Yh9POOusYgwgCj22Kyx7xU4giaQwHBr
         NTpMeE3XNYZ/334AHL9GkI9UG1VMNcdIL+m0K+qOq4VveZ9+tGKCMRT2u2mfwWprDtT0
         ftPpNQD5UtWv6ytsooJx8J6JDEaSpZZiKVezODsb9suPrmDvZMz5aI0hnC7+eQiu+9pd
         z4vvJev5X+r59OCxAZg6cEJCOrkMHh2z+HvXAMgUmovGRa0labo34NMsE7MZTyGTJEO+
         8+yw==
X-Gm-Message-State: AC+VfDwBtuz/cd3EtXbD1A3d4GTjoFKhipL+rREcrfBxqPwWJZD9225I
        gdhZBcv8EiDkD+OvceaUXZBA8w==
X-Google-Smtp-Source: ACHHUZ53NdItFixaXUuAIPT88TETpOTFkhhyXKBM0zlQyDnVh+KzGubZ7MnxWxm237l4NK8hdQJg1g==
X-Received: by 2002:a05:6870:9713:b0:19f:21c3:9771 with SMTP id n19-20020a056870971300b0019f21c39771mr5016111oaq.3.1685652455375;
        Thu, 01 Jun 2023 13:47:35 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id s4-20020a056638258400b004161a1fbb06sm2550602jat.121.2023.06.01.13.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 13:47:34 -0700 (PDT)
Message-ID: <32d74445-883e-6a0a-f726-f259bf23098e@linuxfoundation.org>
Date:   Thu, 1 Jun 2023 14:47:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5.10 00/22] 5.10.182-rc1 review
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
References: <20230601131933.727832920@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230601131933.727832920@linuxfoundation.org>
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
> This is the start of the stable review cycle for the 5.10.182 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 03 Jun 2023 13:19:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.182-rc1.gz
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
