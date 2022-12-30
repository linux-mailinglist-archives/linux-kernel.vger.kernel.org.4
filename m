Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BE565950D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 06:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbiL3Ff6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 00:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbiL3Ffy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 00:35:54 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5675726DE
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 21:35:49 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id 17so20959843pll.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 21:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ODk49GpDxZuuliFxoD6df4iLQLl2k/kbKceWdXGuHE=;
        b=eaaEYESO/KNWKpsKq0KRFNppqNRawyOutNV+7UhIfKLShVE9poRySfAeYp3/CWxVfL
         QPUAP7o19bYO2NQKwf7vC7ULJXFKEGDOXNR5+1T3eZt8wwOT8x8YGp3+TiU3go4BimAF
         smnqPp1wLHCYuLSMChqnRTN+/hCwtoFKt24PE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ODk49GpDxZuuliFxoD6df4iLQLl2k/kbKceWdXGuHE=;
        b=ytFCn+w5QEHO5gWFjLgxPWDNxGOwsh/PGnh7ZkGo56TdLkfHo+vE6nwv+2d4WjS4g1
         +8FEGPdIUbGBVq8yuQDqJ8FXR7ntqYNTz+g9NPO+CLutqvO3O74y/QC1VsE0SRpOqM9U
         ZpxYgbsXuP42+Oo428v7EnJ8Lx6a0fedBgFklbdqIg2fI9clMZhydKesI26Oy72O5GoZ
         NPivHUvri58bYl1WVnDOUvDt67sV0yrDi0EnZROXxyjSciVrL841XjHq7FxBTtgXzO0c
         x1LA7gQEUErMEINqNAWvLJDsMzEreSAYGRFBcNNuXR7rbRFL8QD2pRM+jsEChbbZ3d2U
         Uh+Q==
X-Gm-Message-State: AFqh2kppQlAGpax1T2kP6ykitByMEY+UZcg8RbATmqZyZAPAbrDNcvOg
        yK+YjjA1JdNxqSVL6Oex8IZCgg==
X-Google-Smtp-Source: AMrXdXvHxYrkb6oA/LY+xgb7wVy1uGetD21x1eEnvFN0CTBJ7y3zBy2MqFZV3qLpI4w4Wy3d8fFG+g==
X-Received: by 2002:a05:6a20:7da3:b0:ad:d982:4538 with SMTP id v35-20020a056a207da300b000add9824538mr48131281pzj.55.1672378548717;
        Thu, 29 Dec 2022 21:35:48 -0800 (PST)
Received: from 9137d54f73fc (lma3293270.lnk.telstra.net. [60.231.90.117])
        by smtp.gmail.com with ESMTPSA id v12-20020a655c4c000000b00478e7f87f3bsm11691781pgr.67.2022.12.29.21.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 21:35:48 -0800 (PST)
Date:   Fri, 30 Dec 2022 05:35:30 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 0000/1146] 6.1.2-rc1 review
Message-ID: <20221230053530.GA9348@9137d54f73fc>
References: <20221228144330.180012208@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221228144330.180012208@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 03:25:39PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.2 release.
> There are 1146 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Hi Greg,

6.1.2-rc1 tested.

Run tested on:
- Intel Alder Lake x86_64 (nuc12 i7-1260P)
- Tanix TX6 - Allwinner H6

In addition - build tested for:
- Allwinner A64
- Allwinner H3
- Allwinner H5
- NXP iMX6
- NXP iMX8
- Qualcomm Dragonboard
- Rockchip RK3288
- Rockchip RK3328
- Rockchip RK3399pro
- Samsung Exynos

Tested-by: Rudi Heitbaum <rudi@heitbaum.com>
--
Rudi
