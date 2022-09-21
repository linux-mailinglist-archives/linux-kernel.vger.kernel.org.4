Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626535E559E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 23:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiIUVyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 17:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiIUVyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 17:54:03 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0231CA6C7C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 14:53:59 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id u131so9891541oie.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 14:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=QY0i6YmPnO9ZZtqS7ahzcSC4piz+HMS6IVIojfNO00Y=;
        b=CsPeGPDDHcoCfK3GQeclKrHlek7ySOjzLPJp06aYSio/a3xolLRBrFt/D3fLKSjTzX
         pmoHULWu4iMj/Xc3s2CPSnKE7J6bASz3bInes+ZU75msVG4MHrkuffQVeg34v4Ocb8Hx
         KnYFZydinV01P/5rLvhUgWCEZBQp32dSDViwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=QY0i6YmPnO9ZZtqS7ahzcSC4piz+HMS6IVIojfNO00Y=;
        b=JqQf2Ih1vZhhPIIwo0GjuAghgyRBWeWkiPlV6G14W6SO5SCCYyWNVF5xqF4A5EfLvm
         uIBhsz/MVqcDnoom8WWs8HduZd1zVUt4qT1qZLnY8umH9J6+7FpciiDBxzTXEZcwtIMR
         TJ2xb8P3zwhuo7e7o/3X80YrQHdO+5pJw4fOcdaHgRUpstCFzsDQNOXEQjdMjfFJoezH
         nSAH70wIUezLn/YNI67N54gzU5FnlFAPQn6WEMZiCFKSPdofh2tqCRX0xwcgnGi62A8T
         jEy7cFF092bD98QNwB1MbZAIuxPL2kCQS7BHgj3azQc2n9s8EVb1bwUZTcZQ0WX0LmFK
         nGLA==
X-Gm-Message-State: ACrzQf06ul1AGtz+H/kUyJgDhaVYoj1u5JpvtE/QdMLzQepFez5MS/cR
        M0Kt2aGehHMf2ISL0lm6WJTiOg==
X-Google-Smtp-Source: AMsMyM7k5Lqanb729NFiXRPHyamFeJIsn6YZXl/oTaoPLlcCpULQxCwidPmlBmxkS+90pL2kmqQY9Q==
X-Received: by 2002:a05:6808:2127:b0:350:2ff8:7e16 with SMTP id r39-20020a056808212700b003502ff87e16mr171375oiw.93.1663797239104;
        Wed, 21 Sep 2022 14:53:59 -0700 (PDT)
Received: from fedora64.linuxtx.org (99-47-93-78.lightspeed.rcsntx.sbcglobal.net. [99.47.93.78])
        by smtp.gmail.com with ESMTPSA id a8-20020a9d2608000000b0063a82e6f3f9sm1838272otb.14.2022.09.21.14.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 14:53:58 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Wed, 21 Sep 2022 16:53:55 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.19 00/39] 5.19.11-rc2 review
Message-ID: <YyuH8xWRjhN9jlCn@fedora64.linuxtx.org>
References: <20220921164741.757857192@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921164741.757857192@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 06:47:57PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.19.11 release.
> There are 39 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 23 Sep 2022 16:47:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.19.11-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc2 against the Fedora build system (aarch64, armv7, ppc64le,
s390x, x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
