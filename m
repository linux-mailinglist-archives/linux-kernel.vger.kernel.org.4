Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91DB5F3607
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 21:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiJCTCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 15:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiJCTCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 15:02:07 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4C82C12E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 12:02:06 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-131ea99262dso11755537fac.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 12:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=DaGwZX9LcSjLClWmUN+1ijO19QLFnhodEz41C/aj6Kk=;
        b=Oe2LW38CHd8hiH04XHaqcbLV3SHXbcuU9amClQbgmSbBwW0B506EUFH+yFeZzLw0E9
         8ualGTGTkFk+5ALvo6GVKCZEisOsLHcO3OI4L6sGW+Cg1ewrDALzU/IxiR3qwafsa1AI
         yZY0lS6paqW8Aps/i68YTkcH7iGPcRa37bnek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=DaGwZX9LcSjLClWmUN+1ijO19QLFnhodEz41C/aj6Kk=;
        b=6j1f9KzYvG6opc1NsHoToX/0A/uVwoXGXMXL5GxJV8j05MtB3NHr/nlSTxCfxURzOC
         BYMLHE0PxPwOXLvxL+9YcvD9xnms3Ka7d0ypQ8P15e2DNapY/3NR7h1qCweLkZYu6FTl
         yTMggDC3Lv185Bl0yI7D0stUCEjn1LpFcdxKz5JMjIWBjYBCpeWLxl4IrsGrLQDoEsP3
         L3xFWVLrXtaN2XkgQPdoIUacUAesJhn6vbtk3/gB+xWq9X2/FwuMnXfSMF+SHmeeOHnu
         2bpruwR2KH0Ij4fkQ4JD6eceR9nbsFPVXEOBTfHsL98dqExFkmPhkkjXWeXDUoyPGwaI
         AgAA==
X-Gm-Message-State: ACrzQf3ATHWFywFBQtL+Tbb2QdbXvVBUvfwF/cCgv2hKqoGdfOxKNsaV
        rN2BssiitpBOpZtfs/GeWholRw==
X-Google-Smtp-Source: AMsMyM7lW9SOfuotrVaYSrWs6Hk6XmrFW/2DEF+pNeFj7LuHj9YcrVqCXqrfS9eGNO52MmJsZcvjlQ==
X-Received: by 2002:a05:6870:828d:b0:132:c30:a8ca with SMTP id q13-20020a056870828d00b001320c30a8camr5951987oae.293.1664823725438;
        Mon, 03 Oct 2022 12:02:05 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id p21-20020a9d6955000000b00657a221eb71sm2529820oto.65.2022.10.03.12.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 12:02:04 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Mon, 3 Oct 2022 14:02:02 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net
Subject: Re: [PATCH 5.19 000/101] 5.19.13-rc1 review
Message-ID: <YzsxqvBUsRLQS30I@fedora64.linuxtx.org>
References: <20221003070724.490989164@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221003070724.490989164@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 09:09:56AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.19.13 release.
> There are 101 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 05 Oct 2022 07:07:06 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.19.13-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, armv7, ppc64le,
s390x, x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
