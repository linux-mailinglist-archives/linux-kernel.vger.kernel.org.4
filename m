Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF0266BDC9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjAPMZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjAPMZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:25:09 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0CC1CF6A
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:25:08 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id o15so19854353wmr.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lAPYg/ZvWBJjUQwtgLMe2yVs/QOrldZYm/bQtr2RTD4=;
        b=nlf4mxN6WlnHSI9yZLFFKUieEv+F0BHxIuXsVVf/lguDjouSr9E0dxwEeAcnkKvFs6
         RZWJKKGqMMHMzdzLpZ1zZjc4L9EwHVw/zu4ut8TaEyhMSmVXOrhlzsmDfZWhq6uPD2xJ
         M9F9ZQqLY/adKNBoJ/eNHCeT3xXbw1c2peCFV2pvqZ25D2CAoSNWz1bjcAWrDa9rZjlR
         TWXarLaYQ19gkxu3OW8DdV+aSG063daEUV6ZK/GHS2LtssChbreg7nxUfgSkkW6QjrL0
         OHgcU3Wa8fM0q2LaA2FiuqYiciAvTDDudOpllXN4Kw8I0Dx1js5l+mHwboSyBj0SIIBs
         3lSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAPYg/ZvWBJjUQwtgLMe2yVs/QOrldZYm/bQtr2RTD4=;
        b=neQRo6dW3AsegVrVXbteIpTkpJYeLRm8srSJzQLnBZznD8DYW+BsYX9zZmPk0NF+CA
         WZhdnNyv2y6KJluaOy5fFneKDgO2o3vh7JUjuELbjcy5AkRuyUj0PvvCApKM0n/vi9N/
         NM2kL10tbhE2jenSCnAOODTl/00e0n/m3ClmXM9/GB/md/B4cTMZoZRq6OteXPFxd7V6
         sv8T0dDzdft4C8xZB8xy4dXwH3I/DPCvomppLYeIO98x5rXJ1KeEhzBQIrGyqkFIonXO
         /nB7Bj33y5VPhZ78UsRExG0m/8kw5PVgEpfe3KDJYNHvrkbZBTlXGHToOcaMRYsoDxcd
         gzsg==
X-Gm-Message-State: AFqh2koKGxOh+mW5n5OnTTg82uIRokjMkSTu3oO1xTZval44uK5NsBDU
        CS69Sxz+n3UZi39ct9yytWNPihLKMt8=
X-Google-Smtp-Source: AMrXdXuDZx/3P4IJpzil2eHi6fJoaVfDCc/FM92eo7r9oqnkPDgkTEw11YP9bKcAVid1i44ckTdGtg==
X-Received: by 2002:a05:600c:2142:b0:3d5:365b:773e with SMTP id v2-20020a05600c214200b003d5365b773emr78322318wml.39.1673871906531;
        Mon, 16 Jan 2023 04:25:06 -0800 (PST)
Received: from localhost (host86-164-169-89.range86-164.btcentralplus.com. [86.164.169.89])
        by smtp.gmail.com with ESMTPSA id fl12-20020a05600c0b8c00b003dab40f9eafsm6838196wmb.35.2023.01.16.04.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 04:25:05 -0800 (PST)
Date:   Mon, 16 Jan 2023 12:25:05 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, urezki@gmail.com,
        stephen.s.brennan@oracle.com, willy@infradead.org,
        akpm@linux-foundation.org, hch@infradead.org
Subject: Re: [PATCH v3 6/7] powerpc: mm: add VM_IOREMAP flag to the vmalloc
 area
Message-ID: <Y8VCIRDcAh33OIvM@lucifer>
References: <20230113031921.64716-1-bhe@redhat.com>
 <20230113031921.64716-7-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113031921.64716-7-bhe@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 11:19:20AM +0800, Baoquan He wrote:
> Currently, for vmalloc areas with flag VM_IOREMAP set, except of the
> specific alignment clamping in __get_vm_area_node(), they will be
>  1) Shown as ioremap in /proc/vmallocinfo;
>  2) Ignored by /proc/kcore reading via vread()
>
> So for the io mapping in ioremap_phb() of ppc, we should set VM_IOREMAP
> in flag to make it handled correctly as above.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/powerpc/kernel/pci_64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
> index 0c7cfb9fab04..fd42059ae2a5 100644
> --- a/arch/powerpc/kernel/pci_64.c
> +++ b/arch/powerpc/kernel/pci_64.c
> @@ -132,7 +132,7 @@ void __iomem *ioremap_phb(phys_addr_t paddr, unsigned long size)
>  	 * address decoding but I'd rather not deal with those outside of the
>  	 * reserved 64K legacy region.
>  	 */
> -	area = __get_vm_area_caller(size, 0, PHB_IO_BASE, PHB_IO_END,
> +	area = __get_vm_area_caller(size, VM_IOREMAP, PHB_IO_BASE, PHB_IO_END,
>  				    __builtin_return_address(0));
>  	if (!area)
>  		return NULL;
> --
> 2.34.1
>

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
