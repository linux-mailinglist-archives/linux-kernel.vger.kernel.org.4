Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332EF743E49
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 17:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjF3PHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 11:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjF3PHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:07:39 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A620E68
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:07:37 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b852785a65so12934865ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1688137656; x=1690729656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8EnuOO6oK/ZVqVGz3O9HMiKg2lC4Al7i/4UAuVg8htY=;
        b=PDNb3JOlAYukvjfbvtQ8ZLFvnbUoRaeNLFtvnAXu5kbH/6T7dn4pTHw5k8zpwiETGL
         v9PQYHRTz9ctIdIWj9bV9ajKu870gPZlcBRKrZcjLhCY+tLRhybDb33Z+Fd1QgoVy920
         KIdd1JfBuwockiY6424G/jo7krbCswaHzVaKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688137656; x=1690729656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EnuOO6oK/ZVqVGz3O9HMiKg2lC4Al7i/4UAuVg8htY=;
        b=B2snSpF0I9WQkLPTabdUt6IVLJ/Wn2alllI2fRHLAf+fOmsc7LN32nx6cjagXJ5EbT
         Y1JtgSuUUM/BIdmwsizCi8WXMvxxd45V69wl8H3pxLtTcOEtnDQK4LU4RanHV2N+bDOk
         ykZXTr0B0DGPqkNOdUzsXhpdgz3UrHPsjNi/rjYg6ZxvAHsnRdcWybsKiJeyu2kRbuOB
         l6Oi7RH3pmxpkxU9mxsRNf2cG0ZxWkNzNkhXmn8gLCl0daAjRjPkvoCjJwlMmF0TUB4e
         x0UFziwybZaybnMyMtWWwMEEKDPxTh79ab4MZQWsxnNz3gza6NYRtf8wwK6GecFCjA03
         6LoQ==
X-Gm-Message-State: AC+VfDzvX+sHs8cdQQJalnuDKgqWVgQhQouuzWzSaFwrMgebYAzZrbcM
        mhpn2XKvGTogaQWP4/0u6fVq/A==
X-Google-Smtp-Source: ACHHUZ5iqx/PxCy9A0NgfSEXCrVRwBebxEv2MkEa873Y9HdaqjtDpTpqnWXbi6zOPsH61dYoDU2WJA==
X-Received: by 2002:a17:902:c411:b0:1b6:92f0:b6f5 with SMTP id k17-20020a170902c41100b001b692f0b6f5mr10240571plk.14.1688137656539;
        Fri, 30 Jun 2023 08:07:36 -0700 (PDT)
Received: from 88b90ce288d3 ([122.199.31.3])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902820c00b001b3d7205401sm10867637pln.303.2023.06.30.08.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 08:07:35 -0700 (PDT)
Date:   Fri, 30 Jun 2023 15:07:27 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.4 00/31] 6.4.1-rc3 review
Message-ID: <ZJ7vr/OtdYiwqLy2@88b90ce288d3>
References: <20230630072101.040486316@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630072101.040486316@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 09:33:31AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.1 release.
> There are 31 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 02 Jul 2023 07:20:45 +0000.
> Anything received after that time might be too late.

Hi Greg,

6.4.1-rc3 tested.

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
