Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F37604541
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbiJSM2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbiJSM2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:28:03 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B2D1CB503
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:03:53 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 78so16028490pgb.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JhFg+I8Z30pggQd52LeEXoxZPdMxzsS1SoicPW2Qnj8=;
        b=NaXplvzwhOMeIltLtZKcP9a10bgI+nZPdZpuiJkpI4FLKsGdquxCxqAcDnRUFCK31l
         RomAFDMsxqKxYPhn0Mnd971BoY1i6v4HEtnwDzypjuYlRc2025GdTs4SCDHWJ4TOXMYK
         jOHGsnxdrlRlbTkcEyr2ern4UyhSpcA95SAHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhFg+I8Z30pggQd52LeEXoxZPdMxzsS1SoicPW2Qnj8=;
        b=XQ6sPC/uFPjO13UcgidGVurY1jPhAeTEJ7n7Qpp3adY1zpWyUn2QJCnoyk133kKuox
         x+KBosjJ8QItyTak9TXlHc7wctWGYM5EPGb0z1JH3DKePZqsmX1pVxywHgVz6PKS/w3H
         T212iM/Mm+QIaeBJ4jeq3HuvM8yFXObEymgcGb9iDmin7Hi0T1Gr8dyAAY7EUkTJUJEH
         tj5EEu07iiQCi3AZN8YcmVWCVUifarRUI8FwatFYg7UBlIEu8n0xzScldyIBO/X16i5b
         Qz/oJwmBRcDz/0BSHgABbI0hUUTi/hCjuqwW9bm8dVqLU08Rj9S1+DOph5cZuoOJ5ymk
         BGng==
X-Gm-Message-State: ACrzQf0UEhWY8TutgJWTJKWjt59XjDZf7SVBG1XuNdeoNghrhtjgnZzh
        VUJsXXdsW+v5FMSgJ0OBiVctmA==
X-Google-Smtp-Source: AMsMyM4Dxc3aBl+2slZzJ2ogfC5yNG4JAj01GK8n8y9DrCVshrj2jB3X2jMbk07YaC4gqt6NxPF6RQ==
X-Received: by 2002:a63:6a85:0:b0:43b:d845:f67d with SMTP id f127-20020a636a85000000b0043bd845f67dmr6759278pgc.349.1666180880449;
        Wed, 19 Oct 2022 05:01:20 -0700 (PDT)
Received: from 2f83a51adb98 ([220.253.112.46])
        by smtp.gmail.com with ESMTPSA id u131-20020a627989000000b00561969ea721sm11548627pfc.147.2022.10.19.05.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 05:01:19 -0700 (PDT)
Date:   Wed, 19 Oct 2022 12:01:12 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net
Subject: Re: [PATCH 6.0 000/862] 6.0.3-rc1 review
Message-ID: <20221019120112.GA796174@2f83a51adb98>
References: <20221019083249.951566199@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019083249.951566199@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 10:21:27AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.0.3 release.
> There are 862 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 21 Oct 2022 08:30:19 +0000.
> Anything received after that time might be too late.

Hi Greg,

6.0.3-rc1 tested.

Run tested on:
- Intel Alder Lake x86_64 (nuc12 i7-1260P)

In addition - build tested for:
- Allwinner A64
- Allwinner H3
- Allwinner H5
- Allwinner H6
- NXP iMX6
- NXP iMX8
- Qualcomm Dragonboard
- Rockchip RK3288
- Rockchip RK3328
- Rockchip RK3399pro
- Samsung Exynos5422

Tested-by: Rudi Heitbaum <rudi@heitbaum.com>
--
Rudi
