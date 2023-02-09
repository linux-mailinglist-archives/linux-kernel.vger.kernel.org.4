Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DCE690012
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 06:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjBIFyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 00:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBIFyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 00:54:17 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE3359E2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 21:54:16 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id s89-20020a17090a2f6200b0023125ebb4b1so1269569pjd.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 21:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d7TFb8XDrlHhSX4AMlpcSukotYRX1ULZv1KvAGm5TWI=;
        b=wRIIZNlQneBoIPNhNzoc57T3PqGEEQEUfpX+9cE1ZWqU+eSvJw0CIQharyyZqErB9c
         EVI+6yST//AK5p0L5LZwYcVfOcqYvlE+T9dzUMCCsgtlN5AnvCS3z2vjHntaM7qHWwNL
         tJGQcv5eET76kZu1L6VyK/pboWxwb2hkQQSOG0LITR66wxXoswGHkl6A7bykoKDlaq7X
         dhhvGC7kpJKKZIPMbmgK3o4ciYTbg0WAbOHvGQTC/wBdSDiUCt52+YDvRBvdQrdlp+77
         xzZ9PGqGM7V6r+Nj3kW8853JFosDSvMywHvpo5xLUdjQebfi1PfUqKry2HyZGTq5VQ3q
         ABTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7TFb8XDrlHhSX4AMlpcSukotYRX1ULZv1KvAGm5TWI=;
        b=MzvudeNrLfblFPv5eZWO1OcP4zoRt+6p9IH4PHs5T6CrdOBDsgN3qABQ/gdMrSGSHv
         8pb0EIKzbo5FkFMsOnCEB/krZ9nd9ytpg6RHJ7/jfJxG7goHZz25lHyNJ9SECUzOmKu8
         nDKr3rryBu5QCz6T2AUciHyHl5cRimkyPzOTsiDb34sCuKrKw0qRLPu021GYZ9Gi6Vdm
         TbV6A9TmCB5IIJDKHxEBKKi6grG9PicC1AVFtCvy9mp7SzOdA4nAud2vNCNL0WvbFT5N
         D+c8B/fi4ogzfvC5nwtDyK/CcryBf1J53fZ1S4fsV2Ed6nX41DLBaELpX2Y6xcrnrCYq
         iikg==
X-Gm-Message-State: AO0yUKWqhODZ2lyuKKRBZ/qRAa3yH+/5Was0Xn9XcuDxocnbP22nPjWE
        Rjxez0B3tLYGALEVOVTBPG3T6Q==
X-Google-Smtp-Source: AK7set9gpKfCzCj2Ll21QW8zIUO4z1bmq1VMSVFsF72HERDXfuh9ya2AaWtEKox4BHH+HKVEuiZr8g==
X-Received: by 2002:a17:90b:1b07:b0:230:8956:79f1 with SMTP id nu7-20020a17090b1b0700b00230895679f1mr12011918pjb.36.1675922056018;
        Wed, 08 Feb 2023 21:54:16 -0800 (PST)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id z14-20020a17090a1fce00b002311a83e333sm2098575pjz.44.2023.02.08.21.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 21:54:15 -0800 (PST)
Date:   Thu, 9 Feb 2023 11:24:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH] xen/grant-dma-iommu: Implement a dummy probe_device()
 callback
Message-ID: <20230209055413.k2jbmqvqg636jrgw@vireshk-i7>
References: <20230208153649.3604857-1-olekstysh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208153649.3604857-1-olekstysh@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-02-23, 17:36, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> Update stub IOMMU driver (which main purpose is to reuse generic
> IOMMU device-tree bindings by Xen grant DMA-mapping layer on Arm)
> according to the recent changes done in the following
> commit 57365a04c921 ("iommu: Move bus setup to IOMMU device registration").
> 
> With probe_device() callback being called during IOMMU device registration,
> the uninitialized callback just leads to the "kernel NULL pointer
> dereference" issue during boot. Fix that by adding a dummy callback.
> 
> Looks like the release_device() callback is not mandatory to be
> implemented as IOMMU framework makes sure that callback is initialized
> before dereferencing.
> 
> Reported-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> ---
>  drivers/xen/grant-dma-iommu.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Tested-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
