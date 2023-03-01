Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9C06A77DF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 00:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjCAXoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 18:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjCAXoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 18:44:25 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0086D302BE
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 15:43:50 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-17264e9b575so16302902fac.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 15:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BhW2gSdbv5vMwTEl6x4Xp05rj+HEUyPIAacoa6OCF4k=;
        b=E35mtK6/8sAjkRNZ2FP9bXdH50V4kdqOmdYviyhAKKLQXPgKfuRDUD8W3tIqkjbJoi
         H85Bgi+n442XfOAms5NNRYP001Ea+Z/Qfq84NxUNF6SracCH4YCNxH2AbsPb+mPEClSH
         HTfJBWINAC8ws2m/moqnXhbsKj9KPdqCITrxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BhW2gSdbv5vMwTEl6x4Xp05rj+HEUyPIAacoa6OCF4k=;
        b=o+vqQwjamBFMYyAR4E2nY/lu5UaT6rC+0/sJuNDVMC4Wvxj1h6ClYmmSbgL90e8/Z7
         nLNZi6Yogsaghtr7qcgzcOr32kAn5F90GAFvaB51n+N6mEdyi8TOW1+OOeZQhGvRRiXq
         foi8qqya5oWZK5xCbH+NLEH0k7MVoIXyWh9yZnic/BBzqANZ4xgSogCv2T8jDO4CmPmJ
         F/REy6qOZ18MbgGksLIPbMGGB86WG+8xJstPEdkQFDAfiltJzcy9glLWDecFm2JtZ1XT
         fSYETv4IGha3hi5Ejf7Uz2ViFwyCMnjaVc3zxEcX47+8xOB2WbP2jEWOg6NE5DQ6jyXf
         Ymew==
X-Gm-Message-State: AO0yUKWKXi34FR+EIbwL6dxDfDPptHhQuGKvmVJPetxgiQczo+j6+W+e
        ZqLhtGrNPbuRJfnATAGjLA5v+g==
X-Google-Smtp-Source: AK7set+978mFlFhzy0VxpuZmK0F+YK3Y1dBCQ1diTXwLhMGmdVcnUWQuvcCagDvjz5WXR5jfSlsqDA==
X-Received: by 2002:a05:6870:c192:b0:16d:f28d:3094 with SMTP id h18-20020a056870c19200b0016df28d3094mr5022083oad.53.1677714209004;
        Wed, 01 Mar 2023 15:43:29 -0800 (PST)
Received: from fedora64.linuxtx.org (99-47-93-78.lightspeed.rcsntx.sbcglobal.net. [99.47.93.78])
        by smtp.gmail.com with ESMTPSA id b5-20020a05687061c500b001435fe636f2sm4830336oah.53.2023.03.01.15.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 15:43:28 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Wed, 1 Mar 2023 17:43:27 -0600
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 00/42] 6.1.15-rc1 review
Message-ID: <Y//jH9m03FZZzjpD@fedora64.linuxtx.org>
References: <20230301180657.003689969@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301180657.003689969@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 07:08:21PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.15 release.
> There are 42 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 03 Mar 2023 18:06:43 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.15-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, armv7, ppc64le,
s390x, x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
