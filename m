Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9627068AD80
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 00:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjBDXqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 18:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjBDXqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 18:46:11 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CAE22A14
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 15:46:08 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id c10-20020a17090a1d0a00b0022e63a94799so12077237pjd.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 15:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J+jdujSeP2mHDJ6PO03JdJUpF+OgLYCSJ56+6Fm8Qok=;
        b=Re0S/6cz86wse3Z6m6Kr8TIJj+1Sem2PjHzeLMsKOMQCzmlYLU17M7hHPLJbBu3jF6
         kB/QmjUN6Jm6qvE5Yeev9198dB7WAvb1emSnNRe3rIaRrvnwC0B/cqSkvm8kW269jPY3
         Abp6J+ZTyRAs1BumfTZ6gozCv7NFq5VSZYZ4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+jdujSeP2mHDJ6PO03JdJUpF+OgLYCSJ56+6Fm8Qok=;
        b=K9rdz0H6VHLHNl0At9brMyMtzvGAtt99Wv6PfyIxKVVeLIeyBCQuL4sCxAbn89O6k7
         k3LHmgJPa1Bhbyloi6DhOgJq6emkyAnHmFurIlCBPuE7paqUXuI1LHeF8FDC+g0d8Cpd
         PGbOhtBmMsA1SEnWr5bHVTIHOF8exidgxKT6ekUTmZAeOCw1kaLLq6N0/w8zG/8NUxx9
         P1Hg1JM66nQJs3nyCOLwuJJ5dHjDqSXPzUnZWh301TBXbp9vqrg758gl6mXg8PuX0chT
         LQIxx7K/taKrdpoUVnLL/OJwoYQbwumtJfT6C5uxMj0/lA4SLTULuGhVoTdelEF3xXJS
         u6ZQ==
X-Gm-Message-State: AO0yUKVcYuiLhyQWxMxBkseBlaUsQeSHpp9V14HSm46B3WAxMEFqBe0H
        DgcjglZlj+SNfct5XjBt9p4V2w==
X-Google-Smtp-Source: AK7set+1fSsPfdowmjfG5BTcGzkvXsTp7vgzLwkQGJOOmbmGBC6LN99rGP5Kj75XNJzrdKefS1bXmw==
X-Received: by 2002:a17:90b:3b8b:b0:226:3f8:5b78 with SMTP id pc11-20020a17090b3b8b00b0022603f85b78mr15636263pjb.13.1675554368018;
        Sat, 04 Feb 2023 15:46:08 -0800 (PST)
Received: from 8da818ad58c5 (124-148-239-102.tpgi.com.au. [124.148.239.102])
        by smtp.gmail.com with ESMTPSA id f3-20020a17090a8e8300b0022c08b63564sm3795121pjo.52.2023.02.04.15.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 15:46:06 -0800 (PST)
Date:   Sat, 4 Feb 2023 23:45:58 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 00/28] 6.1.10-rc1 review
Message-ID: <20230204234558.GA3214795@8da818ad58c5>
References: <20230203101009.946745030@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203101009.946745030@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 11:12:48AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.10 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 05 Feb 2023 10:09:58 +0000.
> Anything received after that time might be too late.

Hi Greg,

6.1.10-rc1 tested.

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
