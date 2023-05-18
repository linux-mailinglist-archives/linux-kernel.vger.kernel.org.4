Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7E37080BF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 14:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjERMIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 08:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjERMIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 08:08:20 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D49B10A
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 05:08:19 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-61b58779b93so17565956d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 05:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1684411698; x=1687003698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vlSicM60M4dOjJmxLJdTJyVXpqMpmrkkdEYFA1QkhPE=;
        b=jXhbGwJYk+ucvKbOBXk9WSgeJcL3XBMB2oa3nevNUqtzUVeZ8g0iTX2cviMuUPVK95
         BQihpwuuJEweV2yyrM4IL8PBMZvQBL0c3xq2CZieXROU8/pAIGkzt7Du9V84OKSqWVa2
         Fmaup6LyQllNdQhTLl6BDsdSt4uKUWNmqAZYSGgsy0Ig9WrRRVwSYBI2WdO+rbDcX6dP
         ZHDkZsrwBLEfGkdL77B/DNN8d0hrQ0AB06V2qRbzdl6gVkrx1QZ9lhG4j5FVzlai9Vdo
         CwWrJuIH+r4avhI/j4oqn22bBWtZGlopVE5yl+AqPepXDxbBFyz4orMZqXgaamG+erIA
         Wopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684411698; x=1687003698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlSicM60M4dOjJmxLJdTJyVXpqMpmrkkdEYFA1QkhPE=;
        b=QGpMXW6YIBgncn0LnY1YsB3LNLvGAcSwy40O06CcNwtWKmvO3NdWJ0aqhn8XzI2VOZ
         c9C4+/70iwzARBEXCm04Vs02jznDr/jI4A2mT7/Dtsife+uxyAjjKIqP5kJld0KkevfQ
         nyALpmtoSihCP10BiqF0AGjZk+2LymYl12sWefOaMgQiK12eucd6DwwREjXvNhVBiMsR
         5+hOjQZVneC0BrsVrKWK7L+6pjkBImvjezcYwYjAsH2BFRF5onWiJN7nszATprF4v2yp
         CFCVLE21rryVsisPg7EpPv+UReThlMK4IWKQr9twV3cAndMscbcNYMmvVciZIRmHiKOW
         AR/g==
X-Gm-Message-State: AC+VfDxFwQBp+fcLmV1LVCaF2MsPsIFqqVrtgHJ5MDEJBd0YA6dXq1P9
        0hwBbFAMaP5OZ8dVS9t778XHHw==
X-Google-Smtp-Source: ACHHUZ5mv2MO2EtoWMDVdFMmwyMdsVIazSj3Ntt0VpmSdM56xlcT74f7C5fr+MIKywX+lt8aPIbl3w==
X-Received: by 2002:a05:6214:5296:b0:5c1:fa35:fe6 with SMTP id kj22-20020a056214529600b005c1fa350fe6mr5510734qvb.24.1684411698376;
        Thu, 18 May 2023 05:08:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id jy17-20020a0562142b5100b0061b2a2f949bsm469563qvb.61.2023.05.18.05.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 05:08:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pzcQa-0055S6-P5;
        Thu, 18 May 2023 09:08:16 -0300
Date:   Thu, 18 May 2023 09:08:16 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sj@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        damon@lists.linux.dev, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 5/5] mm: ptep_deref() conversion
Message-ID: <ZGYVMMumjG1p84c8@ziepe.ca>
References: <20230518110727.2106156-1-ryan.roberts@arm.com>
 <20230518110727.2106156-6-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518110727.2106156-6-ryan.roberts@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 12:07:27PM +0100, Ryan Roberts wrote:

> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 3d4dd9420c30..5680542f744f 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -514,6 +514,7 @@ static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_struct *mm,
>  			    bool write_fault)
>  {
>  	pte_t *ptep;
> +	pte_t pte;
>  	spinlock_t *ptl;
>  	int ret;
>  
> @@ -536,10 +537,12 @@ static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_struct *mm,
>  			return ret;
>  	}
>  
> -	if (write_fault && !pte_write(*ptep))
> +	pte = ptep_deref(ptep);
> +
> +	if (write_fault && !pte_write(pte))
>  		ret = -EFAULT;
>  	else
> -		*pfn = pte_pfn(*ptep);
> +		*pfn = pte_pfn(pte);
>  
>  	pte_unmap_unlock(ptep, ptl);
>  	return ret;

This hunk looks Ok

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
