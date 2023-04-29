Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CC66F21B1
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 02:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347026AbjD2AhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 20:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347128AbjD2AhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 20:37:21 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6177E1FCF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 17:37:19 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-247122e9845so411830a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 17:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1682728639; x=1685320639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fFTwTFgfpbct6eGfmZUAE1l/8Y7e2QTTmTdpZloJxgo=;
        b=a9Y2JI73PE0/P2LphZdQuIeX21T/zbMqgnk2hcKSsUKr0UWhzGDQsRWE5sP21tP0fp
         pdLw9xV19z6QsMKa1MaM50RaUDRnddhma8LqtdO1DP2KuC02QxiPNpio8OHOfyesBELS
         hOSoYjgSvzIhzSxX39IWrMZ5RmWwuw8s8Z8mQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682728639; x=1685320639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFTwTFgfpbct6eGfmZUAE1l/8Y7e2QTTmTdpZloJxgo=;
        b=eWkt+SKoBTn+ft9SACTnQ9JRsHsvxH+GQsSQ7PDZvQJBAjupVADDQ/O9XiosnSmbVV
         0aZBUwdH3HVP0yMtLwjzhyBBsr3CS87KtgokGrqay4C/Bv5jeBSSM2a2FY40+vsP4o8i
         PG6hGTt0k3u2ew5iI4NeQXEzmlCZLBUNhoIaPC+sY8ujNTh3YmHBD1m4cIb3fm3mO2UQ
         jUW51Am9UjiYUxEjEVkKuBf38dSmUtGECIco5KyRanzJg/JOU1sOdXDPjZWCPDO6Ldjc
         Ab/KRlAWGr8bdOF7V0rMGAF6+qGGuVPqT62wQsFZo/xryJcsFypj8W45jwgrKnrcrrIP
         l+Ow==
X-Gm-Message-State: AC+VfDyiVA8ZKsTTY9TErOXJUdmUA3aSxAaVNhgogxoi6hsL8vNwD7Jf
        UPKC5z3wBd+tbN2u8QEHwT88UQ==
X-Google-Smtp-Source: ACHHUZ7AaM7lFfHo5Pv4E1GlexT7X9j78VcNfpQ5SFUaPuV9zpadCcSjk/1t1Qd6XuNwQg8u8VP4/w==
X-Received: by 2002:a17:90b:30c5:b0:24d:d8d2:ec90 with SMTP id hi5-20020a17090b30c500b0024dd8d2ec90mr158295pjb.8.1682728638520;
        Fri, 28 Apr 2023 17:37:18 -0700 (PDT)
Received: from 7fe0d01b56a2 ([122.199.31.200])
        by smtp.gmail.com with ESMTPSA id np9-20020a17090b4c4900b002367325203fsm15400876pjb.50.2023.04.28.17.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 17:37:17 -0700 (PDT)
Date:   Sat, 29 Apr 2023 00:37:10 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.3 00/11] 6.3.1-rc1 review
Message-ID: <20230429003710.GA4461@7fe0d01b56a2>
References: <20230428112039.886496777@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428112039.886496777@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 01:27:35PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.1 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 30 Apr 2023 11:20:30 +0000.
> Anything received after that time might be too late.

Hi Greg,

6.3.1-rc1 tested.

Run tested on:
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
