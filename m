Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C016393F3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 06:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiKZFHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 00:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiKZFHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 00:07:46 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF21DFB9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 21:07:43 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so4593170pjo.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 21:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XIOp2nu9uvK0guG9IHkctrJxTkczWL48KQcVVRMB+sI=;
        b=KbHbebB1AOC6FNyUoIrqEKRRU8gN4H1n3aW0W4XOxqYjk01uU6tC/ivQA1/TsaQ/vC
         vxd66ZN8e0RHI4d2NQB79eYHp0/mqsTBmND3xMnsyxixf4RMewsfnGRqFZn6fBWjCoUM
         vHSI3OSrHZbt7x+fJ4p6aHpujG/7mjR07c1G8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIOp2nu9uvK0guG9IHkctrJxTkczWL48KQcVVRMB+sI=;
        b=zKA1/zBm1/2tcsXCy1ecZXXmt976nmkwIdw/cI4DdT/UYOgsXn4cBg8sN86pDwhq+H
         Z9dAUzb6bbapFSPAY+cjeHil5R7Xz+C3axfm9mrD0awnSC6y/LaoLZzupP7nzBexptiJ
         91lvdbgfP5YrGOdWepfT+S40ZfdL4B1aJba+Rzh5K8I6uMsGASjyrW8eABtI7wILRh88
         ys9BsebXDL0b68FFj1liCxDZG/so1+OcucVSmVk60IWk8sfGyy7eyx7NYC/RIhNyxI97
         P6AVC0ROhPjB1n8kcTr754T8/xB9JR2EdLy1CWpGKi3ty88j7T1zXtRaz6fKfL+yqpv7
         QtYg==
X-Gm-Message-State: ANoB5pls+k5z0kdEc5sqgBKzDbWfR0pD06DEwRtXEghes3/tQe56apPd
        buCn8tLDhFMT/6wIFYgkMsOGRQ==
X-Google-Smtp-Source: AA0mqf7SgF9lw7W0QqWM9WGGCr1ko400p0Hj8rA6IDF/EO+wK3u6KaOCsCX7175wYeZ+1CYXYmSpzQ==
X-Received: by 2002:a17:90a:5298:b0:217:e054:9ac8 with SMTP id w24-20020a17090a529800b00217e0549ac8mr50572914pjh.246.1669439262808;
        Fri, 25 Nov 2022 21:07:42 -0800 (PST)
Received: from a6c5907d6328 ([220.253.112.46])
        by smtp.gmail.com with ESMTPSA id im16-20020a170902bb1000b00183c6784704sm3094862plb.291.2022.11.25.21.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 21:07:41 -0800 (PST)
Date:   Sat, 26 Nov 2022 05:07:32 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.0 000/313] 6.0.10-rc2 review
Message-ID: <20221126050732.GA2942465@a6c5907d6328>
References: <20221125075804.064161337@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125075804.064161337@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 08:58:38AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.0.10 release.
> There are 313 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 27 Nov 2022 07:57:07 +0000.
> Anything received after that time might be too late.

Hi Greg,

6.0.10-rc2 tested.

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
