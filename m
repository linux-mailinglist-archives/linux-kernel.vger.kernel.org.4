Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8663E72E42D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242540AbjFMNdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241871AbjFMNdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:33:39 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0989B10DF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 06:33:38 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-665a18f5643so1316271b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 06:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1686663217; x=1689255217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GDuT6deuppaGzOF76rAk+CwnbEIhY/GKVuQjsq+mDj4=;
        b=QqRliXEzkC1F3k61fEliuQzfSPewrB4iwlZ1YvEDGqemk9ukbF+Ipn5NawCn3If6T7
         wFd36rOqA+TruOiBQEfe13L0q8W4QnJIAXby5sfXFeiuXHp2vHtxC+aCQsiUgzt+vbQH
         H99/eTgz/chIyZRw9/JAtTl7JkoC9lx+GlA+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686663217; x=1689255217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDuT6deuppaGzOF76rAk+CwnbEIhY/GKVuQjsq+mDj4=;
        b=CPTgrP7BIsc6TwHRXiJWl/DmVGHiDXFZwhy5wMgKpYQEp+94lPnUcnzGclnHOYWVRn
         iaO1hLCelCSJFH9YAy4SBImLrF90xzmGfE+kcorZu0fRpeQW0FxW06PO91lsV7C90FBs
         qywXf12/GCIM1JqyGanhW5EJJqkKGvs5Jbyxh7vb/oIG7b5+8xz70kXPKdoBS0ElWpdd
         99cyzq3/tHK8GjMR/ys/abrGbsj9UjZPQhczfBJsa2LOcd9/tTzVAFgTIAp8lln/WRMD
         6YvOZYzAmk0ooBQ5ORAGDVE8+7vGcGBaTAN1AH/H8kw/n566rDS2XIrx4DF4d7PoGbdv
         33Wg==
X-Gm-Message-State: AC+VfDyOy9lb6UHTU4rcAEQL93WTp+bpdRR/6noa7aCaf+wURbq38Xy4
        aDZFOnYdquNVPKxX4UUed31fVg==
X-Google-Smtp-Source: ACHHUZ4/xdrivhTL1rQ3Gt1wk1T6Eqgqjsme0XE8IWTsyiB/3talV8VKGcBuYSmNi7D1QiDGsj0J7A==
X-Received: by 2002:a05:6a00:2d18:b0:646:6e40:b421 with SMTP id fa24-20020a056a002d1800b006466e40b421mr14852100pfb.1.1686663217099;
        Tue, 13 Jun 2023 06:33:37 -0700 (PDT)
Received: from a1e48afe476e ([122.199.31.3])
        by smtp.gmail.com with ESMTPSA id v9-20020aa78089000000b006475f831838sm2280004pff.30.2023.06.13.06.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 06:33:36 -0700 (PDT)
Date:   Tue, 13 Jun 2023 13:33:28 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.3 000/160] 6.3.8-rc1 review
Message-ID: <ZIhwKHb2B+py2SIF@a1e48afe476e>
References: <20230612101715.129581706@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 12:25:32PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.8 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> Anything received after that time might be too late.

Hi Greg,

6.3.8-rc1 tested.

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
