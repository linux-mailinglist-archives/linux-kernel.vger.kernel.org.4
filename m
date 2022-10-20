Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDE8606809
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiJTSPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiJTSPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:15:31 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9F9BC46E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 11:15:26 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id s125-20020a4a5183000000b0047fbaf2fcbcso84430ooa.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 11:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1+pWbAD1M2vNKvKxtdRsmSPgl3psNK2Gs/LGU6NGnbc=;
        b=LX8/mIYryI54+i1NEERYLBmXHXy830UqM7EaLz3WrFUBdIBLq0gwHI+IESCj3YAhVe
         E1Mc6hvyGLo16IgschP6IMoc+iklWUWDvXfrFL6GMvyLUiLTlSDNttv3h6o41CMBDk1S
         /0GxYBcUuQJ1nmyrIw2vb+mDtlh1gwSt+powQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+pWbAD1M2vNKvKxtdRsmSPgl3psNK2Gs/LGU6NGnbc=;
        b=yK8KzgUjtu2i6Wd7omEoqF7AEx33/l7LMdKqkKoMRe7osrOvheNtROt4Ai9Tm617rE
         URZhIHHx8bqQylIWO8dqgHrQItKjgxTlNII6D+o+RfvAdqZCZg7bh3gNO4ueE/RXsOaN
         d2piQlWp3GZscIopcI0mjnAaqslg5tkSGqza7Ib4GlJKpo0vj23w1g3GmYP1LO6eKCau
         Gc4c4dQOCQPCfWkg8e70Xp6JJRPXhXuhXYyZ/m7gTEFljzReZWXXQKFFmICCQhBL2Q4/
         nCB0jzP8QHiyTKWH65p1UVVtdqUn0gQWeVklSv+nM32QUOqTS59oQf0MQHJ8tD2Q+TI2
         pUWw==
X-Gm-Message-State: ACrzQf3fQQwYvWiY+7UBraEE4pSNqd2zy+/BGbEp19vpArYXFcOtJ7il
        GJOISJkjwctGA5lP4Eq1B0z+Ww==
X-Google-Smtp-Source: AMsMyM6laKFJIOC7Ta8SxjYf1tmUGZ/3HXYIFdO7ngRvFSu/9alIlq8++rLRijWj0rkmkzeWWF8ATw==
X-Received: by 2002:a4a:e645:0:b0:480:9cf5:d4e4 with SMTP id q5-20020a4ae645000000b004809cf5d4e4mr6965876oot.77.1666289725686;
        Thu, 20 Oct 2022 11:15:25 -0700 (PDT)
Received: from fedora64.linuxtx.org (99-47-93-78.lightspeed.rcsntx.sbcglobal.net. [99.47.93.78])
        by smtp.gmail.com with ESMTPSA id ep10-20020a056870a98a00b00136f3e4bc29sm9155456oab.9.2022.10.20.11.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 11:15:24 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Thu, 20 Oct 2022 13:15:22 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net
Subject: Re: [PATCH 6.0 000/862] 6.0.3-rc1 review
Message-ID: <Y1GQOrWWDe11Ae95@fedora64.linuxtx.org>
References: <20221019083249.951566199@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019083249.951566199@linuxfoundation.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 10:21:27AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.0.3 release.
> There are 862 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 21 Oct 2022 08:30:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.0.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.0.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, armv7, ppc64le,
s390x, x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
