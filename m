Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A878860BB99
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 23:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbiJXVFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 17:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbiJXVF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 17:05:27 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1BA8A7E5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:11:44 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id b5so9449279pgb.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Na645otuqgn0sXJO+Ctgh/B1ZgCXd78iXx+hl5nXu1k=;
        b=B6cF93wr5er8lpEPiibQIhfiA5iTuSQwOsYbycEvzRm5gTbln+YVKjSSO9Bgxkgxze
         O5g44P6rEjEB6HLMh1MwfeUn00POpfsMMKnEoio+P/0tx9iblEx5Mmlz3oFpviyxhvaB
         vxL29n6DT7QQ94OOLRrwG2aa09K8HXkcgAlU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Na645otuqgn0sXJO+Ctgh/B1ZgCXd78iXx+hl5nXu1k=;
        b=NTCKnXt7ho7NdrVk2jvCQlQusuJmPTCPfQ0ru0fUTHZEdfTGsbcKljulM9wkqyqpKq
         Pq1nmidVJ51D8GmxAM/fpuyfUXv5BB3c2wk93HLN6AJ70240QJ3pgWpQY5w495EhVQmd
         z98wLfkSdZ+1YThtcITzudIi1Cep223ysC/+gMVlaLedJ/BfL7x9vg1EVpf9nG+uVBuy
         d25SlKgcEWYg0g1fYhHLGcciw6qrwF5ROrVyTbEd6Z1JYo+PlEuioBHhfCen1199pLcj
         wUwY2WZi1hCWnfrGnVe3bUFa7NXlLgOdPF0IUePUGMaMY5rMXlGeJELZkCfK9f0R+rnE
         GxUQ==
X-Gm-Message-State: ACrzQf1uzCML4oOifqOwLItQLUvARLAULNiFTOf/GBVicmKE/x7zX8sd
        kwL6KTeViHlKPcAEIxiXHXUwFw==
X-Google-Smtp-Source: AMsMyM77llRiQENHd/42c8YhZKxxkM62T3D6oiTY87RRNHDBJWnIzG+PRJs4RSHWRZOIs9e8yFZKpA==
X-Received: by 2002:a05:6a00:198d:b0:56b:fa7b:56ed with SMTP id d13-20020a056a00198d00b0056bfa7b56edmr3349663pfl.81.1666638623065;
        Mon, 24 Oct 2022 12:10:23 -0700 (PDT)
Received: from e121e5ee19ec ([220.253.112.46])
        by smtp.gmail.com with ESMTPSA id e13-20020a17090301cd00b00186b945c0d1sm99999plh.2.2022.10.24.12.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 12:10:22 -0700 (PDT)
Date:   Mon, 24 Oct 2022 19:10:15 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net
Subject: Re: [PATCH 6.0 00/20] 6.0.4-rc1 review
Message-ID: <20221024191015.GA1811448@e121e5ee19ec>
References: <20221024112934.415391158@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024112934.415391158@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 01:31:02PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.0.4 release.
> There are 20 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 26 Oct 2022 11:29:24 +0000.
>

Hi Greg,

6.0.4-rc1 tested.

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
