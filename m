Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E81E700D49
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 18:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237279AbjELQrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 12:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjELQrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 12:47:22 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7E635B8;
        Fri, 12 May 2023 09:47:21 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QHvhl6Mpjz6J6xk;
        Sat, 13 May 2023 00:43:19 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 12 May
 2023 17:47:18 +0100
Date:   Fri, 12 May 2023 17:47:17 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Dave Jiang <dave.jiang@intel.com>, <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] base/node / acpi: Change 'node_hmem_attrs' to
 'access_coordinates'
Message-ID: <20230512174717.00006046@Huawei.com>
In-Reply-To: <645e6215ee0de_1e6f2945e@dwillia2-xfh.jf.intel.com.notmuch>
References: <168332248685.2190392.1983307884583782116.stgit@djiang5-mobl3>
        <20230510171445.00004cea@Huawei.com>
        <645e6215ee0de_1e6f2945e@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 May 2023 08:58:14 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Fri, 05 May 2023 14:34:46 -0700
> > Dave Jiang <dave.jiang@intel.com> wrote:
> >   
> > > Dan Williams suggested changing the struct 'node_hmem_attrs' to
> > > 'access_coordinates' [1]. The struct is a container of r/w-latency and
> > > r/w-bandwidth numbers. Moving forward, this container will also be used by
> > > CXL to store the performance characteristics of each link hop in
> > > the PCIE/CXL topology. So, where node_hmem_attrs is just the access
> > > parameters of a memory-node, access_coordinates applies more broadly
> > > to hardware topology characteristics.  
> > 
> > Not that it hugely matters, but why the term "coordinates"?
> > Looks like Dan used that term, but I've not come across it being applied
> > in this circumstances and it isn't a case of being immediately obvious
> > to me what it means.
> > 
> > If it is just another vague entry in kernel word soup then I don't really
> > mind the term, but nice to give some reasoning in patch description.  
> 
> The inspiration here was past discussions that have been had about
> potential API changes for userspace contending with multiple memory
> types. The observation was that seemed like an exercise in having the
> application identify "where" it falls on a spectrum of bandwidth and
> latency needs.
> 
> So it's a tuple of read/write-latency and read/write-bandwidth.
> "Coordinates" is not a perfect fit. Sometimes it is just conveying
> values in isolation not a "location" relative to other performance
> points, but in the end this data is used to identify the performance
> operation point of a given memory-node.

Works for me. Can we add that to the patch description for the historians?

Having read a load more of the code using it, it now feels natural to me.

Thanks,

Jonathan

