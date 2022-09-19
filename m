Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E465BC0C6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 02:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiISAM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 20:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiISAMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 20:12:24 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D75CDFF9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 17:12:22 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-127dca21a7dso59735029fac.12
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 17:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=CoC1+/7JgLAjxGpmyihA853JBeEKV8t/kTyn9LWVIr4=;
        b=iZtmVDvLqx+DvvOTa4fAJh3wJgY8SDKChRsbB2bvbevAiJfsu/JW052RcSii691EXo
         Ci0xpQASbj5ta9skCB96l5ziGL7cC8jRt0aYMSDYhimwD0+wjeFZLWZRf7Jlh+n2sKO/
         mvf9+JQKY5bY2j6YdubqP984KyHAhEH9f1NSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=CoC1+/7JgLAjxGpmyihA853JBeEKV8t/kTyn9LWVIr4=;
        b=idzO+Sfs/6uDu6TBOWW6wAxGw+GxIQrqzXa6DH0t6mrgL1RO/9dOFFF1v0XWRL7gdv
         D4Qpe4gsNepZw6mGWssDqLhx7nfCLXz6Q/h69GL/RMTsmI4Bg8VgLFg/mKNLNdF30sik
         ypYoNxERWolXFnHvgm6CvHxhFFoR76voHIM+o+7ygJMpPC7OD+foLuz3FtON7ub72rvH
         R8xcapuXhv7YXwNvGFY4/fpuUViZ6MJfR9IE32JYchO1+bPUTk+HAlBl/8PmJ3pGC4/c
         aeewVyGpHGXqq0yqzzH/8kdbMNrtlgeKIAJ4OjO45DiCx7ibWGBy0Tx9a3W/U0Lnb0ka
         VCVQ==
X-Gm-Message-State: ACgBeo2YTaghWtZfZyNpzprC4/XW4HxGhBcLalWGEmkh4+8IuNa4/fVZ
        asDhu1+3mw2tMLmqx+BufmUzkZhmtbMch1+WVEc=
X-Google-Smtp-Source: AA6agR6dsLOHBFfBs3YhlwcSN1ExCqE2/qz/GuD8G2LOM9lkguqqgeBsDaNUwiAKRncmEI1vyd7V+A==
X-Received: by 2002:a05:6870:d686:b0:12a:f869:cb90 with SMTP id z6-20020a056870d68600b0012af869cb90mr14141581oap.242.1663546341741;
        Sun, 18 Sep 2022 17:12:21 -0700 (PDT)
Received: from fedora64.linuxtx.org (99-47-93-78.lightspeed.rcsntx.sbcglobal.net. [99.47.93.78])
        by smtp.gmail.com with ESMTPSA id cv36-20020a056870c6a400b0011e37fb5493sm6885010oab.30.2022.09.18.17.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 17:12:20 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Sun, 18 Sep 2022 19:12:18 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.19 00/38] 5.19.10-rc1 review
Message-ID: <Yyez4jmP4wbTeNxg@fedora64.linuxtx.org>
References: <20220916100448.431016349@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916100448.431016349@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 12:08:34PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.19.10 release.
> There are 38 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 18 Sep 2022 10:04:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.19.10-rc1.gz
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
