Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557FF6B343F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 03:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjCJC0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 21:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCJC0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 21:26:51 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD0B101F25
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 18:26:40 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id y11so4156470plg.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 18:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1678415200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8n96jBDj6U8/0HiuamqOgxHV9NLL2L/E5rBePzKD8o4=;
        b=I7rd0ImirBXyHnnNTVPfhY3MVC3hc8ULMj8UGlsEltLBKEIm/J9l8sES9VP1BtXeXx
         luwSD+PZbmfcvvTA37U25F89+C0R3XDiA2vLCsltzdkLn1MPAUDnsbsqdbdmLWw0xdJl
         p9D14hbgQk3NkDdT/3m5WIxJpGK149doGAdvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678415200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8n96jBDj6U8/0HiuamqOgxHV9NLL2L/E5rBePzKD8o4=;
        b=jTm2oSphd7bDCMb7LOP20xoG9bgJJf++HU94ukUieB86l7+VE8CHCyjAE6fehme0Gz
         4bat4VFCTI3zvKhm4mRq4Jq6C8RAThppQfFMBglF5vXjPG6cWKWgVKJ/wigYHDpSTeWc
         Q7HoWHRVIskp/0IaQRLmvbr8h93K2ZllttGPCPqb/wVlgYRTWPfEGPmDdWIWjPs2Y54q
         4K8+rrnouNKrWaJqVnhqc1yfPEV+dtS5N/GH54SBlsfaq8IPFQYFkB4Jwh5LbRifp/fY
         JUJf9ilLxQ2C5XpuVpZkPW/rR9/KoQVKplN0HT5zP/lqEd9ej3brji9dtiLiWi+K+baO
         b+UA==
X-Gm-Message-State: AO0yUKUnQcj6ENR0Xa1RDI/dwzBdRrGNElSxrCVp9/JkjlGtUCBMJjUG
        DmCvnXggB16oTtKoBL84+yyreQ==
X-Google-Smtp-Source: AK7set9pzQ9I8F/ZqVL/8w6lsggmI04JDkdDcXTVEUnMqBWkkBjGhrn9uYkx4mr//ebYveJ0sKKiIA==
X-Received: by 2002:a05:6a20:430f:b0:cd:1367:3b69 with SMTP id h15-20020a056a20430f00b000cd13673b69mr24116204pzk.17.1678415199651;
        Thu, 09 Mar 2023 18:26:39 -0800 (PST)
Received: from b836f21f488f (124-148-239-102.tpgi.com.au. [124.148.239.102])
        by smtp.gmail.com with ESMTPSA id n18-20020a62e512000000b005a79596c795sm248402pff.29.2023.03.09.18.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 18:26:38 -0800 (PST)
Date:   Fri, 10 Mar 2023 02:26:31 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 000/887] 6.1.16-rc2 review
Message-ID: <20230310022631.GA457080@b836f21f488f>
References: <20230308091853.132772149@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308091853.132772149@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 10:29:31AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.16 release.
> There are 887 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 10 Mar 2023 09:16:12 +0000.
> Anything received after that time might be too late.

Hi Greg,

6.1.16-rc2 tested.

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
