Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44D86FC147
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 10:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235138AbjEIIIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 04:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbjEIIHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 04:07:46 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DFA6A59
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 01:07:07 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6439b410679so3378680b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 01:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1683619627; x=1686211627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f4cw59kPp6A8r0eMeccn+YgGUjrNQrYf3COqrBqWzs0=;
        b=iPcDFbd1lygQ4F1Bu7qfUjBBUUcYBUdy99AVsmAlYCaYknGCUjhMKTTb6PZdvuQ2MX
         zgYx8Fn9O0L2wIhejJ4bSuNtC83Z3iCQpu8sk8Ihw7saNEfeNaO5lYlua/ZPIA3gKmk3
         wSrnuT6pA8yinGPw0duk8IUjv/DwdM3883ynM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683619627; x=1686211627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4cw59kPp6A8r0eMeccn+YgGUjrNQrYf3COqrBqWzs0=;
        b=iBtXIoVKv3fGeU6BwG55iT/oDHuXvFIqN0po8o5ie+Vnp4KAda3Tl3Hvs/uqQwN3V5
         OflSq0C6a6VfOcjUrz3a2tYIZ0mYNkFG/Gw90dJJKb0xDWvdj7EjK+z96Qz0Yhuyrg/b
         zDpArxyn5vh14TO2Athfmh5sd0bsl7SM9nBZba/R9SCgsNMt0yF7P/Ytuv3RB9uhN8Y7
         bA3oKci/cYL56msnGedIWfHAJBua163m5KZFgZ0pNiBP09TTO6MqPAUa+Vlqnwl4cR4W
         1T2XWDOhTHiMXUN1BmFXUA4vz77FHs3gVmcsfZ2FCs61MBpA8IttR+77j/SlqVF+ptWn
         /2DA==
X-Gm-Message-State: AC+VfDxDxBDh3LEdKCfRhFvCSqWw0IOmUIi4FfyjCVY+eyYANipvV5L1
        McM6mmI0QqE7GB84fs8hnj+BDg==
X-Google-Smtp-Source: ACHHUZ5mtkoo5NjkUfi/hBEfAL0GATyBF6WKT+ImyGPyuyHfKi6mBlfFBGUBQQLAyoZHVqKrByc9iA==
X-Received: by 2002:a05:6a00:14d0:b0:63d:2f13:1f3 with SMTP id w16-20020a056a0014d000b0063d2f1301f3mr17321113pfu.33.1683619626805;
        Tue, 09 May 2023 01:07:06 -0700 (PDT)
Received: from d6921c044a31 ([122.199.31.200])
        by smtp.gmail.com with ESMTPSA id j11-20020a62e90b000000b00571cdbd0771sm1165640pfh.102.2023.05.09.01.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 01:07:06 -0700 (PDT)
Date:   Tue, 9 May 2023 08:06:58 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.3 000/694] 6.3.2-rc2 review
Message-ID: <20230509080658.GA152864@d6921c044a31>
References: <20230509030705.399628514@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509030705.399628514@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 05:26:44AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.2 release.
> There are 694 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 May 2023 03:05:05 +0000.
> Anything received after that time might be too late.

Hi Greg,

6.3.2-rc2 tested.

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
