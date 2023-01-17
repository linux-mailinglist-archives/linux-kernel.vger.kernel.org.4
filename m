Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66A166D863
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 09:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236044AbjAQIkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 03:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235862AbjAQIkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:40:37 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CD02748C
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 00:40:35 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id g23so17220524plq.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 00:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AST8wGQKJArsqYW0kCGPhdVZT3sTkTmujS4WjL+NxjI=;
        b=NgpjJG/PXpBxQj62UCoL4HVIcqRe2KNPmjaQBsKSBPDKMCyRJT7uRiJM0uhkPPyvgT
         +OxRJk/Uczyh4GdZA4gdx9N5hv46pSwLdLXV4r0soC8kyD/TWDnugUWdrgdjhBLUi3Zq
         4RrJvg+Iaw7r2Rt3aKf2zTs+22fZLsaV304H8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AST8wGQKJArsqYW0kCGPhdVZT3sTkTmujS4WjL+NxjI=;
        b=mE4qmrHAo68/u90lPsFj3t9/EKV1nOMum2amkZYgejip8BhhkzJ2zASNhoNJsIwWLl
         yYs5EDC6F0aeN6jXB37UsKvHvssWkbwxixi5qYHBg3ktyV4drLJ4PccMU/WFon71T3Uy
         1syKfHymVs6mFBKDfbDRGA9XZYoWarJzX5FgFnz6+UKXvIwz5g8LkBR7enpeqBS7OW/C
         PfWyByvA83SOESdvxvCP0k8/L2muEDm5LBi7Nv3mTfvdcatS79n9eGL2O+5ua3Tj2kjF
         s/OfokPDhtOksSRYJqB1CIyURA/pwcPPDA62ZzUh+RqLLKvF+iU7hrdcl6iZJRHwStCN
         9Zeg==
X-Gm-Message-State: AFqh2kr3AVPh4C1WbKC28WNobzwutbhom8hOioo7J1faw+0w2bzG2RTP
        u2a7jM9rf2rOxxk9RecnOyN1bTe4EapnoVhrhPE=
X-Google-Smtp-Source: AMrXdXuPpQNF/nPCZyv4sWaHWIsXo4q/4J5nG2Vi04UxUG6u+WPIGskqjdNLXMuFW2uCNIbn10Gl3A==
X-Received: by 2002:a17:90a:cb84:b0:229:7110:712d with SMTP id a4-20020a17090acb8400b002297110712dmr2303896pju.45.1673944835035;
        Tue, 17 Jan 2023 00:40:35 -0800 (PST)
Received: from 80aa54ac8722 (124-148-239-102.tpgi.com.au. [124.148.239.102])
        by smtp.gmail.com with ESMTPSA id fy11-20020a17090b020b00b00219cf5c3829sm248105pjb.57.2023.01.17.00.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 00:40:34 -0800 (PST)
Date:   Tue, 17 Jan 2023 08:40:26 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 000/183] 6.1.7-rc1 review
Message-ID: <20230117084026.GA10@80aa54ac8722>
References: <20230116154803.321528435@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116154803.321528435@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 04:48:43PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.7 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 18 Jan 2023 15:47:28 +0000.
> Anything received after that time might be too late.

Hi Greg,

6.1.7-rc1 tested.

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
