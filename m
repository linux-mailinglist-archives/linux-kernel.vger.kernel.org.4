Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1884B66599A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236777AbjAKK7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238814AbjAKK6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:58:41 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24600F48
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 02:58:39 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id 17so16439197pll.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 02:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fxhv4QkDrldLenO5lrQ3LjOcD7YvqwRwzw2LufBgbsE=;
        b=RFoVrcQyO6qxmEoyl0HWaOre3WfSMCrNVzTBJPzBB6DI1p1k6u+sR/2AL27WRawEx0
         EdJV0SKf2VyU8eM1skvgHv+hCDcfRrOM8rPLhh/vynS0urPNSAi4TJ6UpMzDBXQZTUaw
         lVE11GxyyFNvbaFIVI3/ko83+Qw3iVG8t8Mtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxhv4QkDrldLenO5lrQ3LjOcD7YvqwRwzw2LufBgbsE=;
        b=n1a+nrrfGwJVARnj8p1NlswKVT/eiR2EcGNuXwG82azBUyIBNcaRugrH0jF3SJ8IYQ
         Z5oce/1vpWNbER3oZvqbFCXbow+D4gYd9D7hffaXZ9ScWptn98QzEYQ7UANm+lXN4pNk
         HNmxkUrcrFtW7FsFv4/WDgC8Df4v9ykdBZWHp+1E3JO39F91nCNHUvrZ8zmYyaUf7gt2
         ZgvxuAsY68EaBV0qlw64nMXkHXQyynjRrJXi7/yS8mzwnwhtJVqkjUSdFjMOvhd8hx+g
         +8SZAOGqtoXmupyO11Gde50DDz3ssO8eQQJ8uCyx7y8yvZzcqSCEVlitOqGkWzOZp68Y
         8kLw==
X-Gm-Message-State: AFqh2kryY86/HKlRSedrBLTNGy9zTU4RA+tPLvghHJwFp0SzSBYpIN/2
        Dew/W0A26qVUpWll2+IW4RvCxg==
X-Google-Smtp-Source: AMrXdXtKarQD1JhMpONsWVMgA6XJI0xr4rJxbaVh14tjNsEoR4+23h6jtCyBZrNpr28mzhOMvT8dCA==
X-Received: by 2002:a05:6a20:e189:b0:ac:5671:adfa with SMTP id ks9-20020a056a20e18900b000ac5671adfamr2073123pzb.18.1673434718187;
        Wed, 11 Jan 2023 02:58:38 -0800 (PST)
Received: from 8da649e65097 (124-148-239-102.tpgi.com.au. [124.148.239.102])
        by smtp.gmail.com with ESMTPSA id o33-20020a17090a0a2400b00226463cd239sm10469946pjo.15.2023.01.11.02.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 02:58:37 -0800 (PST)
Date:   Wed, 11 Jan 2023 10:58:29 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 000/159] 6.1.5-rc1 review
Message-ID: <20230111105829.GA7@8da649e65097>
References: <20230110180018.288460217@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110180018.288460217@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 07:02:28PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.5 release.
> There are 159 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 12 Jan 2023 17:59:42 +0000.
> Anything received after that time might be too late.

Hi Greg,

6.1.5-rc1 tested.

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
