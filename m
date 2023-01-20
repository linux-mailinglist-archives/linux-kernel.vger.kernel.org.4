Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F0A675C03
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjATRuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjATRuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:50:32 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D7E88746
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:50:28 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id t2so2899007vkk.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5pTLkkWdxz2TuSidslY63LQA+pUSk+xfh9K8bmwLCbw=;
        b=OtaNHK/aRm4AsgU7KyBwK2LgLEszXKKsEpgKGpD7iDgrAG3HJJhAqnYBmd0Rs6DnLR
         Yfl1aolgDZgmSFtytcBJngDHkoT9UdqxdC+MVZ8laJG3e6c7bd/wGD7NFdXgFZPHxxYw
         AMvBiHT+bHMmVRCzKBgQw7RB4w/3V31ni2plxVkNaSm/bnsOLIstA0K+Fzh1hMovO8wh
         FuAOX0gHEDPZFVCvYyIBxRg2UzrtlUWCCRNlkFp7g2PlTBUUgN8IcNpiGDZwym8Fb2Mg
         0Rhw15OBpzzoPzzBkv0Srq091z174d8XOS/sCU6qIX0lAb/uLkSnh9ytTY4u0wFmX6bH
         UNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pTLkkWdxz2TuSidslY63LQA+pUSk+xfh9K8bmwLCbw=;
        b=pVcfPEy7YZBoccTPmWk0uZeiqIUrHKZX1NzKwrJqTLGdc+SEmVomZQWeEBYMwVZWd4
         r7NsEQsPy1k9VvlOwzZg2xswxo9S92qF1cPzei8WLXcZmiLChwSg2SVlrn9UvprW8ZL9
         hyyIEjAP9hgeS3p2LagLYTIW0p/D8BiGiOjxmPFb/tQv245MJIl4tz3oOhvLkI4Qxqp9
         sYJZ/yHNNbIeHJyDN31S5LwJQzGG/eegCqPrt7NTsbQ9yB3Xcy9vjHs73lO8lvJmeOVu
         8q+S6bA09jkOkXBeH/5RrjuSKCTgZvVj8aHDEYlptEv/D/Vl6eyilTwcasKD7Tl7G9Uj
         Ip7w==
X-Gm-Message-State: AFqh2kr9x1pixJMSMR7QeRjd+b6AGtFadhRtcsU8oHPi7QYj6o5yBpI7
        /dGIV/rhPyE9Mz0Bu1O88F+NVw==
X-Google-Smtp-Source: AMrXdXsK2UV8ggdawPljqg1YdQGkuBmiReYfSrTK4e2ygR2LCcXuQjc3MenxIkbktc09gC17u/LzUg==
X-Received: by 2002:a05:6122:11a8:b0:3da:7734:2e9 with SMTP id y8-20020a05612211a800b003da773402e9mr9890123vkn.16.1674237027193;
        Fri, 20 Jan 2023 09:50:27 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-167-59-176.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.59.176])
        by smtp.gmail.com with ESMTPSA id r8-20020a05620a298800b006bb29d932e1sm26816788qkp.105.2023.01.20.09.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 09:50:26 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pIvWz-00ElKv-VS;
        Fri, 20 Jan 2023 13:50:25 -0400
Date:   Fri, 20 Jan 2023 13:50:25 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Kalra, Ashish" <ashish.kalra@amd.com>
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        joro@8bytes.org, robin.murphy@arm.com, thomas.lendacky@amd.com,
        vasant.hegde@amd.com, jon.grimm@amd.com
Subject: Re: [PATCH 1/4] iommu/amd: Introduce Protection-domain flag VFIO
Message-ID: <Y8rUYTjVhksAu+i9@ziepe.ca>
References: <20230110143137.54517-1-suravee.suthikulpanit@amd.com>
 <20230110143137.54517-2-suravee.suthikulpanit@amd.com>
 <Y8F53dzdebKLTlOy@ziepe.ca>
 <90762dee-1559-58ac-220d-a13635d5032e@amd.com>
 <Y8mBczFH/Hw6xot0@ziepe.ca>
 <c3fbec52-1281-eb1c-40f8-588438146c14@amd.com>
 <Y8q9ocj2IZB2r6Np@ziepe.ca>
 <1ba09b11-8a07-24dd-a99f-eeacb2f5c96c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ba09b11-8a07-24dd-a99f-eeacb2f5c96c@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 11:01:21AM -0600, Kalra, Ashish wrote:

> We basically get the RMP #PF from the IOMMU because there is a page size
> mismatch between the RMP table and the IOMMU page table. The RMP table's
> large page entry has been smashed to 4K PTEs to handle page state change to
> shared on 4K mappings, so this change has to be synced up with the IOMMU
> page table, otherwise there is now a page size mismatch between RMP table
> and IOMMU page table which causes the RMP #PF.

I understand that, you haven't answered my question:

Why is the IOMMU being programmed with pages it cannot access in the
first place?

Don't do that is the obvious solution there, and preserves huge page
IO performance.

Jason
