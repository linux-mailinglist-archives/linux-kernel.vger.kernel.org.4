Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FB8610E40
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 12:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiJ1KSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 06:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiJ1KSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 06:18:14 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693EE1C20A9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 03:18:11 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so4081653pjl.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 03:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DSKJv1f/uVlp0hff+snMR0wsnevB65aMFxEQQizFBpA=;
        b=Qv3qfdxLvWItvoVyHt2AVoKll3nKREI/ZG2asPBKUQPv2SRMcjQtGtUTs3+WFQo0O8
         9HcNkQymRFA1X5r6hdlNRK725D4tZ8a3Wge4W3747Ck/ZlUPgtCd7PmnkzjXqZexAEFv
         Hn4aajmyzXT0xc5THfW/EVLed5s3VzMW2xz80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSKJv1f/uVlp0hff+snMR0wsnevB65aMFxEQQizFBpA=;
        b=CZvjnPW+TGPyt9VaFeCoHClx8mSJkPi1Kp6MKTsZ5dA1xjviyNgA2K9wOwOuh4EnD7
         6yOaWV+JHwukdSYPHJvVqL80113t24aXqu7YenPDdXe55dPS4eZXJummOUQpJJFwp741
         D8qkjcHB6OylNeCX8d3woMLb4Wj82gEw58Jb4NTLYI92h6qNzqql+IO+RSQgnzYrscth
         Ngk34RIAyjqEZ3RmQXWIGOKnOaetn7jY39ah3xo/oVr772yVCuu2MAc02+MXk204CEOV
         gqMFWDEdNbbcUlTFI4knqWfo0HXEvDSapwmoDda4gCOtcfB8rmfGXhte39/YqMHfdha7
         k3xg==
X-Gm-Message-State: ACrzQf0rAPW6Kg9FH8kJHtkCBDALp92Bwtb8lN7kVwefXjWxwQnCUjdt
        s9X7y6nBASppJqcYy2BnI8uGng==
X-Google-Smtp-Source: AMsMyM42VLGabApraSGNSPouVxxKriSgE7M0ZYJbOsPjhq0ZT8JFO8iTPEyhcjI2rjlhMo2Ky+1lGg==
X-Received: by 2002:a17:902:8685:b0:186:cb66:d77b with SMTP id g5-20020a170902868500b00186cb66d77bmr17207873plo.39.1666952290879;
        Fri, 28 Oct 2022 03:18:10 -0700 (PDT)
Received: from 377995ad3d24 ([220.253.112.46])
        by smtp.gmail.com with ESMTPSA id bt20-20020a17090af01400b001fb1de10a4dsm251163pjb.33.2022.10.28.03.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 03:18:10 -0700 (PDT)
Date:   Fri, 28 Oct 2022 10:18:02 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net
Subject: Re: [PATCH 6.0 00/94] 6.0.6-rc1 review
Message-ID: <20221028101802.GA2440677@377995ad3d24>
References: <20221027165057.208202132@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027165057.208202132@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 06:54:02PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.0.6 release.
> There are 94 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 29 Oct 2022 16:50:35 +0000.
> Anything received after that time might be too late.

Hi Greg,

6.0.6-rc1 tested.

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
