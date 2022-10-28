Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B1A6113AF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiJ1N4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJ1N4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:56:06 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D4D1C19CB
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 06:56:01 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id m2so4751688pjr.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 06:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zFm9xq1TuqjUkOGgoKTO6KG604kBsjeVMKaXSBwq70g=;
        b=BgT2unWoRr1lc5bXspAu5oW1cRgbl9kXawGzoyVmNN5OA7sTzrz543Eq9EPkjShx20
         1FZwnBIaSjPsyY946p6omwNbNdByU5iW+m3LUOpj3/QDV7XaQt2yXPGQRnUs3hDoiAcM
         YMcRokJWeUjOHYIoBhQVkByYple/+QRPngGlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFm9xq1TuqjUkOGgoKTO6KG604kBsjeVMKaXSBwq70g=;
        b=3uuk9RUTXJbJUg5W2Or4QKv026qSNVTw1YwSpAA4urxMrc8k42VXRtkMFYiSVbPKen
         +XPkYfLH+PrxooZefO84ajs7TWJEQW3O7oEUyA3jEV1y8URRZqUV494IZ8L8Q2GDVY5O
         X49HtXbJ9fz0+1laWKaP0tV9IKpKjK5Uk76v8ncmevAoR0LiTqLhX5vISZfZtuTSyaaM
         QzWB9W0/MELpxoxN0j7kFa9cVYiUGsLO7AX86ijHMhh3l6pVsr7Ac7dVNO4L0Qwxt6WI
         n0dwMPFixR16hTVz/7GJ49SonhYsKbVNpticTdWAutQ3VjXYFOXH/Z0pnPM8A1BnretE
         d1MQ==
X-Gm-Message-State: ACrzQf3ShOpokiIdz/wHj69s3nxZzM3wxO0ZW5MVRtwLxmBs/16iK/xi
        4bvBJONlC6nwZ6oLbpTuC3uwmA==
X-Google-Smtp-Source: AMsMyM5rpfY/PuNZgOMTGmOro1CmO/Q7My7E3N0aU2dbPMc2ot+ZJ7NjJ8IZIEScoXyDiN0n0HrLiw==
X-Received: by 2002:a17:90b:3ec4:b0:20d:93bc:32fb with SMTP id rm4-20020a17090b3ec400b0020d93bc32fbmr16328691pjb.124.1666965360373;
        Fri, 28 Oct 2022 06:56:00 -0700 (PDT)
Received: from 21e111714c80 ([220.253.112.46])
        by smtp.gmail.com with ESMTPSA id y5-20020a17090a86c500b00213216a0d92sm2621382pjv.5.2022.10.28.06.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 06:55:59 -0700 (PDT)
Date:   Fri, 28 Oct 2022 13:55:51 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net
Subject: Re: [PATCH 5.10 00/73] 5.10.152-rc1 review
Message-ID: <20221028135551.GA950780@21e111714c80>
References: <20221028120232.344548477@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028120232.344548477@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 02:02:57PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.152 release.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 30 Oct 2022 12:02:13 +0000.
> Anything received after that time might be too late.

Hi Greg,

5.10.152-rc1 tested.

Run tested on:
- Intel Skylake x86_64 (nuc6 i5-6260U)

In addition - build tested for:
- Allwinner A64
- Allwinner H3
- Allwinner H5
- Allwinner H6
- Rockchip RK3288
- Rockchip RK3328
- Rockchip RK3399pro

Tested-by: Rudi Heitbaum <rudi@heitbaum.com>
--
Rudi
