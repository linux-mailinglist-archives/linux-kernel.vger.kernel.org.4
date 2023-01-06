Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D212865F7FC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 01:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235862AbjAFAFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 19:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235770AbjAFAFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 19:05:06 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E013C0D4
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 16:05:05 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id d10so144342pgm.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 16:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i2xgnS6P8oE/KrpMlccAZ+Y4dEgvLfcHqD32J1lx09Y=;
        b=dnJOdhDpc89F27/WUX9nX/el+s3gnF3ZFn+gfhDkX1Ru/RHLLlQw/kAE0Deju/pbny
         I85LE0iTbKlSKzqfvP8TWYcLKjVYicKGuQ+rUD/BB/weWJp8lO0X7QGvgPdfFvOgQMQg
         iCo9aRFzfyeqv2Jl9OfOaUxBOV4PWxb5uCbqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2xgnS6P8oE/KrpMlccAZ+Y4dEgvLfcHqD32J1lx09Y=;
        b=RP/Dox5WVlkInklRR2EH3Z+RhCWr5XJVv/XcYFvmCyXVWkdDwtduRlpbjDxPspA2Eq
         ZUIyN82OlMneWWhShP/JHdI2wMwhnpM/05IQUv7egjE759Yn29XZ79FnHnWrdt9x4z/M
         93atKMleBY5HYxGYKbwqN81iF0hm/Pa7mE1T9jgWdcvQ5wWJy8LrDZHJjUaW/oHvPefn
         pMo+5sidOZ60mMmRzMyUvsTrP1coleQRLlqkW6tP99Ys4/GklK2X9cmX2qG5Y4Xzpl03
         DsI6dS5HTGUS0RcAZzovDO71fseajwsp4nffgjoPpSrBnvbSjFYfIZL8zMFFgRjtnu9u
         oBRw==
X-Gm-Message-State: AFqh2kopyFXtEf0CMUZFxs28+vdV9mm3y1E2LXl3syFYxjFYa9lylSLb
        2uuLYDud/CfSYA3nTpMB8qdVqA==
X-Google-Smtp-Source: AMrXdXuxy5OrJQPhjeuVD3E7jCOyZE9sgowf8xRuV/O6+/U+amwrJK46YAwEYVaaF4IJ3A8aKJQU9A==
X-Received: by 2002:a05:6a00:706:b0:580:d409:396c with SMTP id 6-20020a056a00070600b00580d409396cmr47276929pfl.6.1672963504915;
        Thu, 05 Jan 2023 16:05:04 -0800 (PST)
Received: from 5627e7ec9cfd (124-148-239-102.tpgi.com.au. [124.148.239.102])
        by smtp.gmail.com with ESMTPSA id 9-20020a621709000000b00580e07cc338sm22768631pfx.175.2023.01.05.16.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 16:05:03 -0800 (PST)
Date:   Fri, 6 Jan 2023 00:04:55 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 000/207] 6.1.4-rc1 review
Message-ID: <20230106000455.GA1929704@5627e7ec9cfd>
References: <20230104160511.905925875@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104160511.905925875@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 05:04:18PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.4 release.
> There are 207 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 06 Jan 2023 16:04:29 +0000.
> Anything received after that time might be too late.

Hi Greg,

6.1.4-rc1 tested.

Run tested on:
- Allwinner H6 (Tanix TX6)
- Intel Alder Lake x86_64 (nuc12 i7-1260P)
- SolidRun Cubox-i Dual/Quad - NXP iMX6 (Cubox-i4Pro)

In addition - build tested for:
- Allwinner A64
- Allwinner H3
- Allwinner H5
- NXP iMX8
- Qualcomm Dragonboard
- Rockchip RK3288
- Rockchip RK3328
- Rockchip RK3399pro
- Samsung Exynos

Tested-by: Rudi Heitbaum <rudi@heitbaum.com>
--
Rudi
