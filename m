Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A80621EFA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 23:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiKHWTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 17:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiKHWTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 17:19:02 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540E663162
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 14:18:59 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-13d9a3bb27aso17046795fac.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 14:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vKUbdUX3qdflcVWi2z65DPQbJco33U25TAhGa9To338=;
        b=g+QrmWAS9mrAm2NJ3L595Koub6YGAgrJAnsHt+xCQMOyNMtdIBXi9yTt2E1+j4C01I
         9uCI0pHSqpWRtYt4aPdJJ2V5d7Jo5CGpI2TKVGKwv/xv6F34JhFQssWW0PZ2FYfmVrQF
         IFw3Uv3pfiXMbRPIu4xccSn3BXcxvV7WOdm+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vKUbdUX3qdflcVWi2z65DPQbJco33U25TAhGa9To338=;
        b=PMWkq2eiHqfQnsvCNf/sm72g8Mbv6g9O+AO0qiJ6HM5iKCh4Gz8icFo8dUII0QbA8W
         oKUNoUjJ9z0f58IDvAA7B0LFwC478dpiFnw1gDK3ofKSR6kj/teKWCNWGiWb4MGlHVyM
         b2tuLDBKfV3GkL5hR7rjKm73W/Vgrb4m9D1SA3nsyW0/EuoJ3Siu6V95/YMlgGNj50lo
         VoKFHdZdWX15ir0lcSlIGDxNdkDyvfYlT1rS085Az+LJ7PhJhqqWxWJbn+mkr91FyKq5
         UBS7zqiAu3GUebkRfpk8d6I/cda4ADyaASX00Y0ExjYzIHGSFb8ASSk1LDsZszukSp3G
         9Gkw==
X-Gm-Message-State: ACrzQf19NxRfPj87WDy1Xa1bmHsyF7f/vp7radn1FFjzPGCTaH7NfVCG
        rCWH6B9SqhcoSYubX2oXvyUPTQ==
X-Google-Smtp-Source: AMsMyM6Vc4kPAkvYK6wM2lKQRgXSGyuamtYWKlliPsldhkcjQKMlqRS3k0u3UAUG6cLq1cBzcSfWmw==
X-Received: by 2002:a05:6870:96a7:b0:13b:ceea:baf8 with SMTP id o39-20020a05687096a700b0013bceeabaf8mr44646620oaq.88.1667945937746;
        Tue, 08 Nov 2022 14:18:57 -0800 (PST)
Received: from fedora64.linuxtx.org (99-47-93-78.lightspeed.rcsntx.sbcglobal.net. [99.47.93.78])
        by smtp.gmail.com with ESMTPSA id d132-20020aca368a000000b00359ba124b07sm3931285oia.36.2022.11.08.14.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 14:18:56 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Tue, 8 Nov 2022 16:18:54 -0600
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net
Subject: Re: [PATCH 6.0 000/197] 6.0.8-rc1 review
Message-ID: <Y2rVztl+lEUftkAF@fedora64.linuxtx.org>
References: <20221108133354.787209461@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108133354.787209461@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 02:37:18PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.0.8 release.
> There are 197 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Nov 2022 13:33:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.0.8-rc1.gz
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
