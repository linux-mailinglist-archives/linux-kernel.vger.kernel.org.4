Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D425E8633
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 01:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbiIWXHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 19:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbiIWXHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 19:07:12 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23140146614
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 16:07:07 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id l1so854264qvu.11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 16:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=EIl/nh29zH96tBjnO04+Za75Ipkt6sGk6uA16GsQuRo=;
        b=N+P38VAwzWrwNueTpnqYlcaO4Wwnh/yvGq5CrXQr+MEOIhsLJzkhHRaRGlZLxg+iey
         DYr2P/LNZNK9n8+I1zZMzIFj51vuzJpoC/m6kBz0D1tYPDZ6pEQe8GzyI442cqFVxiHs
         wgixALrJy9vDVOcBb3BWDjBnsAdri1GFyNtMW7PTfPV/gW7darPtzbWpjT5+YijAFkh2
         sYZcC248zBfiR8rnutPUSujZoc23CLex/qcIRD66Y3nxp7dTNL45L/IGXi6TOqDyE6yp
         clE87f/yyT0iJMg+J2x0ANJoOmOZGBzm4thw9YJeTmp1I8o7NCi4TQmNWzW+JQtcekVG
         cktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=EIl/nh29zH96tBjnO04+Za75Ipkt6sGk6uA16GsQuRo=;
        b=q4C8aVmBrOvTlLbvKdwa56jEqW+UGFFfc0PIHHR5x9R/4ogGpu7Hu+su/XS84LM5Hb
         qJUyFz8MX5QcJS0q/33lgLa47yLPlKlM34FKu1GFpAgR1kqHvGv5i5FM1kstD7T8zIdl
         aKGywq0uTZWHUi60CvLp7y2HZkd2yUKPE4ZhPvBMUjypco0WMLRRwF8mC126fnuFZj6V
         eLxL/cg6seHXMf5ZaMjN07UsQ1iZpZjpDcidqXJLn/MG9pRSUmptwUYRGW6A55+ZQVMi
         EpeWka4aXjZfKGmTirBqlINKLlvCp5SU72V8rKNuhaYolwzzSLDlK18IhMQVpPN0u5yW
         AABQ==
X-Gm-Message-State: ACrzQf0IyZmlZ2HLSJqigw8mBSoS/HPerz8E5h5gGPKfmJyaTAMCr7kR
        RakvFOf1iZ074WeBhZTSMIlchg==
X-Google-Smtp-Source: AMsMyM4x5J2YZQ9LKsbzLk51XuSjAC/sL+Lbezcs8blw3lr1IQ0ZrvcYT8N/ZbZG9tkfXdkD76Kbrw==
X-Received: by 2002:a05:6214:2467:b0:4a2:e191:46b7 with SMTP id im7-20020a056214246700b004a2e19146b7mr9012870qvb.112.1663974426313;
        Fri, 23 Sep 2022 16:07:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id b13-20020a05622a020d00b0035a6f14b3cesm6656906qtx.27.2022.09.23.16.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 16:07:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1obrlA-0035kF-QP;
        Fri, 23 Sep 2022 20:07:04 -0300
Date:   Fri, 23 Sep 2022 20:07:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v10 1/8] mm: introduce FOLL_PCI_P2PDMA to gate getting
 PCI P2PDMA pages
Message-ID: <Yy48GPMdQS/pzNSa@ziepe.ca>
References: <20220922163926.7077-1-logang@deltatee.com>
 <20220922163926.7077-2-logang@deltatee.com>
 <Yy33LUqvDLSOqoKa@ziepe.ca>
 <64f8da81-7803-4db4-73da-a158295cbc9c@deltatee.com>
 <Yy4Ot5MoOhsgYLTQ@ziepe.ca>
 <2327d393-af5c-3f4c-b9b9-6852b9d72f90@deltatee.com>
 <Yy46KbD/PvhaHA6X@ziepe.ca>
 <3840c1c6-3a5c-2286-e577-949f0d4ea7a6@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3840c1c6-3a5c-2286-e577-949f0d4ea7a6@deltatee.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 05:01:26PM -0600, Logan Gunthorpe wrote:
> 
> 
> 
> On 2022-09-23 16:58, Jason Gunthorpe wrote:
> > On Fri, Sep 23, 2022 at 02:11:03PM -0600, Logan Gunthorpe wrote:
> >>
> >>
> >> On 2022-09-23 13:53, Jason Gunthorpe wrote:
> >>> On Fri, Sep 23, 2022 at 01:08:31PM -0600, Logan Gunthorpe wrote:
> >>> I'm encouraging Dan to work on better infrastructure in pgmap core
> >>> because every pgmap implementation has this issue currently.
> >>>
> >>> For that reason it is probably not so relavent to this series.
> >>>
> >>> Perhaps just clarify in the commit message that the FOLL_LONGTERM
> >>> restriction is to copy DAX until the pgmap page refcounts are fixed.
> >>
> >> Ok, I'll add that note.
> >>
> >> Per the fix for the try_grab_page(), to me it doesn't fit well in 
> >> try_grab_page() without doing a bunch of cleanup to change the
> >> error handling, and the same would have to be added to try_grab_folio().
> >> So I think it's better to leave it where it was, but move it below the 
> >> respective grab calls. Does the incremental patch below look correct?
> > 
> > Oh? I was thinking of just a very simple thing:
> 
> Really would like it to return -EREMOTEIO instead of -ENOMEM as that's the
> error used for bad P2PDMA page everywhere.

I'd rather not see GUP made more fragile just for that..

> Plus the concern that some of the callsites of try_grab_page() might not have
> a get or a pin and thus it's not safe which was the whole point of the change
> anyway.

try_grab_page() calls folio_ref_inc(), that is only legal if it knows
the page is already a valid pointer under the PTLs, so it is safe to
check the pgmap as well.

Jason
