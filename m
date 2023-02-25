Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0519B6A2757
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 06:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjBYFOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 00:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBYFOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 00:14:46 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F282F78A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 21:14:42 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id n5so667712pfv.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 21:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X7+3E0JQU0FxnGZ5BiSmvm8Hsg7HD/6qbOk5w5ZRHjM=;
        b=bp8w2aAldxm/p/OyqulRx8jUytLCNBv+0zrDx+48+YYCEIEgvcekPK+EOvzaMhXmdm
         K2tIHohT8IF4hLdjyQ+6otPmdFxt/27jK3erFllZEVRwRrVX+F1NosY9FFIS8MLx4JtI
         km+YcszsNlpD2cG9tCM8K3x6oreYS0/P/qUz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7+3E0JQU0FxnGZ5BiSmvm8Hsg7HD/6qbOk5w5ZRHjM=;
        b=fYkR1vNHltRWO8xHNzHVdV4LdpZa9ybaOJNMCfwcys8h+o8WvnmUd4A0soNO3qbvii
         CHJkDJDzsKr2+Z3ODJULJ7IfWXgn/JVo0nwlJ2ONZMGjA8qz8soShr35RuVh4nkykZMS
         aL7fowFSOdVOUF5mt0whTWw916Tdsoj0Zg8ulGuzC+9Rd/73a6Cr+X51wyrkpXvc7q4e
         CwpwsmDi56M181yPPxBlZB1Ok/U9/420Q2dt5uROp3rnBxdaGfvrGyncOhmrDF/Xjk+R
         EDZ2K+WL2svuETrNJ4ngAyJU1eNDHwAgLHQocpP8jhB9U7E9hCcJUzQkNTCXh08iIuiw
         ZHMg==
X-Gm-Message-State: AO0yUKXPspDnqBKmQGQrUrYcxfhD5/oGEvJmR97dWn2rZDej0Zu+q1IA
        Qj6/jIAl1EyrevkWbqWJ7PXuLg==
X-Google-Smtp-Source: AK7set8C3FnBa3BGaJvZ19hytTcjHR88q+nZp1elea7y2fP70VuzavEATg6qUnTZ4FAD1YUGwalOCw==
X-Received: by 2002:a62:184f:0:b0:5a8:b705:4dd3 with SMTP id 76-20020a62184f000000b005a8b7054dd3mr16642468pfy.13.1677302081607;
        Fri, 24 Feb 2023 21:14:41 -0800 (PST)
Received: from 5d49c37e6aa9 (124-148-239-102.tpgi.com.au. [124.148.239.102])
        by smtp.gmail.com with ESMTPSA id c1-20020aa78801000000b005d866d184b5sm404294pfo.46.2023.02.24.21.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 21:14:40 -0800 (PST)
Date:   Sat, 25 Feb 2023 05:14:32 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 00/47] 6.1.14-rc2 review
Message-ID: <20230225051432.GA704396@5d49c37e6aa9>
References: <20230223141545.280864003@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223141545.280864003@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Hi Greg,

6.1.14-rc2 tested.

Run tested on:
- Allwinner H6 (Tanix TX6)
- Intel Alder Lake x86_64 (nuc12 i7-1260P)

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
