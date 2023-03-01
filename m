Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5626A7625
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 22:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjCAV15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 16:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjCAV14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 16:27:56 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E39271B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 13:27:53 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id y12so10306551qvt.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 13:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Grfy1mEbjJ/uuvE5E7M7YWn6NRwWppMtzAtk4q3DIN8=;
        b=MwHwYgvlnAOCbpFwFoizuUkm+SZyL85dOgqX03fK93Q8/NSJW26dZDZnc/RdPiKwHN
         1sLnMecptskLiGczkKZOEsOSWzaooQuvV5eBpedKYD9erru4mMuXHwTtxGqpTSwvYSR9
         KfUNqaBAAegg5o2H9eFufT7EonEMMNNdtakaOhMh/PpHI1ymQOYl56PxI+lpqHsOAgYZ
         pDecnHX5+++ZbK3/Up9N2CVPFCCOsfG5RoZ4lRlW8b1turukg6jvU+/61JH2oNWel9px
         nD0HTdgHLi6UxA6BTOvfgpGbQLG90nL0mWKalxAwpOGYY2shUQ/9Ojp4gX0yh89oKyJj
         izjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Grfy1mEbjJ/uuvE5E7M7YWn6NRwWppMtzAtk4q3DIN8=;
        b=ubD7i1k4uW/vLbTKi+Ymt+PcFZlt/ftfiXq/frB4kDJSgeaQMJoDleg/NUwVPFgMcB
         2G8B+WQyo1pSqhFhI/n5cHf5xa5S7WQ82UYd0uWdHbtXPc4DJ1iz3gQRH1gYJlPD4rB9
         V3pEI3vlpgd4odlXP80jp+HGVE8MA2zw3UUvSis6TbBhO97ESflYXOqgn0XSPWsWt0Ls
         W1FLpIWomYnR0sXGW6d/FCiE8UZhUS9yvuwqrm3MXUhDhC6m5UOJUEyUQnInyz1FMEQ5
         HUlsSAQhmtGypW7Y0/XwfnC8DqiDzddMjmWLPPXNaWOOxue7bHe3ZnBBwBETqrWIw4GL
         cAJQ==
X-Gm-Message-State: AO0yUKUMc1qDXzhdL8KrQv68BcdsfxGENhyEN2To2DSJu1PXgsl/iFFH
        zxDMq1jv2+t4dih50nWiixghaA==
X-Google-Smtp-Source: AK7set8nIRTUlPvssew8JIDWDdJwai0Wu7Tb/ZwGBhaPupcc6JplngqeMx2ueRHh9X9mgXvGXT9jTg==
X-Received: by 2002:a05:6214:300e:b0:56b:ec30:67eb with SMTP id ke14-20020a056214300e00b0056bec3067ebmr15210834qvb.39.1677706072890;
        Wed, 01 Mar 2023 13:27:52 -0800 (PST)
Received: from ghost.leviathan.sladewatkins.net (pool-108-44-32-49.albyny.fios.verizon.net. [108.44.32.49])
        by smtp.gmail.com with ESMTPSA id y141-20020a376493000000b00706c1f7a608sm9632730qkb.89.2023.03.01.13.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 13:27:52 -0800 (PST)
Message-ID: <ded94867-2728-45ac-487f-89d995059022@sladewatkins.net>
Date:   Wed, 1 Mar 2023 16:27:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 5.10 00/19] 5.10.171-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de
References: <20230301180652.316428563@linuxfoundation.org>
From:   Slade Watkins <srw@sladewatkins.net>
In-Reply-To: <20230301180652.316428563@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/23 13:08, Greg Kroah-Hartman wrote:
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

5.10.171-rc1 compiled and booted on my x86_64 test system. No errors or
regressions.

Tested-by: Slade Watkins <srw@sladewatkins.net>

-- Slade

