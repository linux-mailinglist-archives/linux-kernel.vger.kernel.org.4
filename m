Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1A3640573
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 12:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbiLBLEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 06:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiLBLEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 06:04:32 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168DCBC5A6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 03:04:30 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id q1so4080393pgl.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 03:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D1KXzSfZtuAisNZ05G51clQ324jnx8aq/gsDbzWWu5w=;
        b=RF10Mb34k2R5dAeYwD2YhiPWcI2Lcs/g4SWXS3huGVHmzpcWS3aJCJjenoi5+J5qNL
         N3PGDtE7158fXkTpnGTBESokd8cDI4BVGr2BjHh9zxuiC0jIT0ixgMWzN5Cqrgd5aeqd
         1zCBIzqITcDuwDjvZ4zN50m/xb9TGNBnSluxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1KXzSfZtuAisNZ05G51clQ324jnx8aq/gsDbzWWu5w=;
        b=p1EWtl9BAJCNdsc1VCFg2N52Gy03BEGdSUNTAGHvF8uiI8MHSCclj276rqnuWOyUE+
         IfV+lOxI/6Mg9z4YU6peixIXwZdv1YoIQpBRrOcz+VOGf/Xq+WloRb9VsnnfhDVLybXJ
         o7DYqwrQYJxpQfD0NHefskKn6a8+o/oIaZKwKsn9HQi9jGQQwDMwHoRwniyoKme2yZfj
         m8nRf7hR7zeM6A9KboFIdSjhvW77fMdjgvCXeW1KQolZCWP0iZiVrhiLVa74pSHE5BOa
         ypCnNdkEow8W0Ub7p+FkZAQiQGi7mHhxN6ysVFvWdIBEg8u+H+iQPmdP1k/iK+plEFm2
         lEog==
X-Gm-Message-State: ANoB5pmmjWasV4mtxOuLqNPSCDSKP1Pkxx7qzVmuH1/OWnWDUbscZzaW
        ImgD/OaqSu0zg0HAI1MjFsKypw==
X-Google-Smtp-Source: AA0mqf7wTZc+5wt4aeoquiU5DMuMCNEz7aE23amfAwhpaX6SQfiBJKju3DcbsUGJ+ZaHl0jVjFfUGA==
X-Received: by 2002:aa7:85c8:0:b0:574:5789:b8a4 with SMTP id z8-20020aa785c8000000b005745789b8a4mr44798364pfn.47.1669979068145;
        Fri, 02 Dec 2022 03:04:28 -0800 (PST)
Received: from d86934a8d1b3 ([220.253.112.46])
        by smtp.gmail.com with ESMTPSA id mm10-20020a17090b358a00b00218f9bd50c7sm4519127pjb.50.2022.12.02.03.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 03:04:27 -0800 (PST)
Date:   Fri, 2 Dec 2022 11:04:20 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.0 000/280] 6.0.11-rc2 review
Message-ID: <20221202110420.GA20583@d86934a8d1b3>
References: <20221201131113.897261583@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201131113.897261583@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 02:11:47PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.0.11 release.
> There are 280 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Hi Greg,

6.0.11-rc2 tested.

Run tested on:
- Intel Alder Lake x86_64 (nuc12 i7-1260P)
- SolidRun Cubox-i Dual/Quad - NXP iMX6 (Cubox-i4Pro)

In addition - build tested for:
- Allwinner A64
- Allwinner H3
- Allwinner H5
- Allwinner H6
- NXP iMX8
- Qualcomm Dragonboard
- Rockchip RK3288
- Rockchip RK3328
- Rockchip RK3399pro
- Samsung Exynos

Tested-by: Rudi Heitbaum <rudi@heitbaum.com>
--
Rudi
