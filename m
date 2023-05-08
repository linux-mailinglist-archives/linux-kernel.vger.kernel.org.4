Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11FF6FBA3A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 23:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbjEHVtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 17:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjEHVtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 17:49:13 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622C52704
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 14:49:12 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-38e692c0918so2505475b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 14:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1683582551; x=1686174551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fehA/P0nQb9AOIPJIL+h5u2kmPqGkpBLIR0S5RMmSKI=;
        b=JFgseqpeK7kU17cYODycdW5zMKCclYUit04E0+ylKKwaMoR9PROe3bQ7HM7L38PXns
         a902OkAH0fPnD4P/9Z4t7BvqN8A/Q04woEy3McO/b/NIMTL1Q1CAaGyCMFv4HlXMi8xj
         QjvlLsOUcG4q9nT6ebGMv99tTCzTXFvHbvfkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683582551; x=1686174551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fehA/P0nQb9AOIPJIL+h5u2kmPqGkpBLIR0S5RMmSKI=;
        b=hDzoU4HNklfB72MJnLphYJzZo/v6BVPz8dUOx52pRjDptCSe/Z+jVhxVxOJ/HMBU7G
         /lboS9vuJaeIEO6CmzEOm3YVMMKars4sGonUBxPuJiMm17H31apuZ2A/58Z3AP5jaCCn
         8SySYry17T21I8OfzBtWnrWf6eJpSOFrKFRQ4VzgrMp6vlNG/8tkS9UvZ+I5qGZ3f5t7
         wbTt8b0H5BmuKEf7djegthnDIfZjD5akMfHO1fGO6y8oZcVsOokNbh6mccGZKhQJJ2Q+
         so2+S9Ne79t+JShSIrSte/p9chXyvd/ftnz0zepqi53eJoneu0ztpvEDPWBX2PI/muWp
         eoUg==
X-Gm-Message-State: AC+VfDzc/5AxU9HmuwOVFkQMA0FpbmM5C9TxH9NBrDP4rQTsCU70Er6t
        39ybeDU1GZ//onlbkfAqetkENg==
X-Google-Smtp-Source: ACHHUZ6GXb//BsLxdDYdHqYWGIQYHQX09BeAL9X247lAM3+D6OTn9XN2RfPNoqJoB1J7oHi7q/8WLw==
X-Received: by 2002:a54:4499:0:b0:387:4984:ea81 with SMTP id v25-20020a544499000000b003874984ea81mr278633oiv.17.1683582551378;
        Mon, 08 May 2023 14:49:11 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id s11-20020acac20b000000b003895430852dsm466559oif.54.2023.05.08.14.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 14:49:10 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Mon, 8 May 2023 16:49:09 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.2 000/663] 6.2.15-rc1 review
Message-ID: <ZFluVYBfjfyS8eLd@fedora64.linuxtx.org>
References: <20230508094428.384831245@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 11:37:06AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.2.15 release.
> There are 663 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 10 May 2023 09:42:40 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.2.15-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.2.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, armv7, ppc64le,
s390x, x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
