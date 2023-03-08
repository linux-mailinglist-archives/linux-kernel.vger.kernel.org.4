Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FCC6B1120
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 19:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjCHSfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 13:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjCHSew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 13:34:52 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0754DE3B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 10:34:50 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id r23-20020a05683001d700b00690eb18529fso9499282ota.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 10:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1678300489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6HXu+zn3eatDx7SiKI+A7GuE649xBYJGEVkrHC7L8Zs=;
        b=iYqDVfy0UzImC//dOpuGVlY3DI6nDDqsO7KE3PQ1VTx8a637g1OJAfT20rs8PeGTwx
         AzZx6/g0Pgp/WMA9MeqWBNcjUPQP/1+QRyZYM4vTwExf2xTfg98q8Du9/oqDRF++m6ID
         CWip04CouQ4kvgG32aI43QtdqAbPC7+2YDdSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678300489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6HXu+zn3eatDx7SiKI+A7GuE649xBYJGEVkrHC7L8Zs=;
        b=5lL0MhNKr3OVzJ9LrjiEeEjeF1gtWTs/qpB+2NpqCkIDZ/paekOSkX10Bk9ArOUFee
         e3l/IO2d5CxHU9taWbhbDi55FXOR6pEz07HWjcx971MKoMVIUordKDzbZqOUDm8+utpw
         Oxx9Rb6Rq6bOL2FcKbEHB62/eWrLvnalT/IJk/y9qvLLxIFlvNNTtNGrQONLuPM2Rds7
         /U/bdqEi7G10DDWBe8xayzcNTuAhNM7CqQcdGiS0Uk7T6O4ox6uF/a17i0mLpX+2xFjS
         6zCy1v9aoa10ZOOgF2BEmzWyg/8owTes/6SDUkZz1z3Cj/6sWyYAiDX84C8KsUMNSvdV
         CH8A==
X-Gm-Message-State: AO0yUKXXoJkoRRqEwvNRDu1tBLHRizg6IemTNAwP3hF4q0ajRQmFQyue
        bWtRMdZ3BeMLQYiIthwUwLMAbGkNyro7PL4sPWHbdn8c
X-Google-Smtp-Source: AK7set94m1RyIbOc5A8vmr28QhexJdFoJQqMmbmsL/+zIeZ7bAG7RZtVGdu2zfe8Qzq0/gOabCUV9g==
X-Received: by 2002:a9d:610a:0:b0:68d:a0e5:d31f with SMTP id i10-20020a9d610a000000b0068da0e5d31fmr8643186otj.3.1678300489667;
        Wed, 08 Mar 2023 10:34:49 -0800 (PST)
Received: from fedora64.linuxtx.org (99-47-93-78.lightspeed.rcsntx.sbcglobal.net. [99.47.93.78])
        by smtp.gmail.com with ESMTPSA id a16-20020a9d3e10000000b0068d752f1870sm6730328otd.5.2023.03.08.10.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 10:34:49 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Wed, 8 Mar 2023 12:34:47 -0600
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.2 0000/1000] 6.2.3-rc2 review
Message-ID: <ZAjVR1XpOYVZSMDh@fedora64.linuxtx.org>
References: <20230308091912.362228731@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308091912.362228731@linuxfoundation.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 10:29:21AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.2.3 release.
> There are 1000 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 10 Mar 2023 09:16:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.2.3-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.2.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc2 against the Fedora build system (aarch64, armv7, ppc64le,
s390x, x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
