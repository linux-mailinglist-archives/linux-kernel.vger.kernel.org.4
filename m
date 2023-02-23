Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6EF6A11DE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 22:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjBWVWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 16:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBWVWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 16:22:16 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DA038658
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 13:22:13 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-17227cba608so14548519fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 13:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MR/wZWU2MfoFRQ1v+7cKSnHFZsY23JIISa7d2BB/xDw=;
        b=gnlm6qqm+pKeTnQUt25QkCdqaKjsMqxEzdxBT2onwFCGeeoU/RX6AiJvOKSNz2vu8t
         WWhTLNa71MwiwFbPcOsojyIOB93o/chFjDCOZ5emsnliYFtutOOIByme3ZvwTfS7pNi7
         1QzSQu7H5DuoLcGgRc3x35WvnGW6ZXRYykvXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MR/wZWU2MfoFRQ1v+7cKSnHFZsY23JIISa7d2BB/xDw=;
        b=kfWnlO97B3Nq+j+tZtgUyUCmyxruMybJvUe/30tBM1USQFgAp2s3iZ71s1TiSn17JB
         hNK0HRIyIgfmVSg4ke9ghAA/yUKWCsGvKW86AF9eb1Nz17HnUm4HLODnuuywHwZclgUJ
         6YarHE9sA7UHKhN2ZuTZCIGfoogpvwZsFcHLC1N5EU61iPF7ZVzrH97sUP9VsxvviBCP
         owGfaoi3Q6egVTt9km32WCC/2ys2x62ZAH7W8hZ0U9q4Jv8MlRSNzxx455+SoLmrVS2s
         vzXyrLX17xwL2hpEKJsBZlqXWA1UTj3UsxPXSFwNdHKIkUd4QaJcE+JZ/1ykFE5iDrkk
         2eHA==
X-Gm-Message-State: AO0yUKVX3eoOToLNcydismVxpYyUfCrcWouTysst+Xw8e0/1rhv705uk
        KeTl6gUrydOqsJeaJ2AhUaEgCw==
X-Google-Smtp-Source: AK7set/sNTT/yVsjpy2r6Q45tjgpi4iYIES3szcYTXf/crw9zO/9Jy3SH3xCxYjDgrQkEB4gcdy05Q==
X-Received: by 2002:a05:6870:b529:b0:172:1f39:2b9b with SMTP id v41-20020a056870b52900b001721f392b9bmr7747035oap.44.1677187333019;
        Thu, 23 Feb 2023 13:22:13 -0800 (PST)
Received: from fedora64.linuxtx.org (99-47-93-78.lightspeed.rcsntx.sbcglobal.net. [99.47.93.78])
        by smtp.gmail.com with ESMTPSA id dy26-20020a056870c79a00b001723d62f997sm2386066oab.32.2023.02.23.13.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 13:22:12 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Thu, 23 Feb 2023 15:22:10 -0600
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 00/47] 6.1.14-rc2 review
Message-ID: <Y/fZAqSWZOpL5xPZ@fedora64.linuxtx.org>
References: <20230223141545.280864003@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223141545.280864003@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 03:16:15PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.14 release.
> There are 47 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 25 Feb 2023 14:15:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.14-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc2 against the Fedora build system (aarch64, armv7, ppc64le,
s390x, x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
