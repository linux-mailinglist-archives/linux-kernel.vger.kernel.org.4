Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAEF646D77
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 11:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiLHKq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 05:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiLHKqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 05:46:17 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193C17F897;
        Thu,  8 Dec 2022 02:41:48 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NSW095RgPz6H6kN;
        Thu,  8 Dec 2022 18:40:57 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Dec
 2022 10:41:46 +0000
Date:   Thu, 8 Dec 2022 10:41:45 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/uapi: Add warning on CXL command enum
Message-ID: <20221208104145.000059a8@Huawei.com>
In-Reply-To: <4d75c340-0942-44cf-67db-ee52f58ee65e@intel.com>
References: <20221208000141.701642-1-ira.weiny@intel.com>
        <4d75c340-0942-44cf-67db-ee52f58ee65e@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Dec 2022 17:27:18 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 12/7/2022 5:01 PM, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > The CXL command enum is exported to user space and must maintain
> > backwards compatibility.
> > 
> > Add comment that new defines must be added to the end of the list.
> > 
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>  
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Good to have.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> > ---
> >   include/uapi/linux/cxl_mem.h | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> > index c71021a2a9ed..459a3f7f764b 100644
> > --- a/include/uapi/linux/cxl_mem.h
> > +++ b/include/uapi/linux/cxl_mem.h
> > @@ -19,6 +19,10 @@
> >   #define CXL_MEM_QUERY_COMMANDS _IOR(0xCE, 1, struct cxl_mem_query_commands)
> >   #define CXL_MEM_SEND_COMMAND _IOWR(0xCE, 2, struct cxl_send_command)
> >   
> > +/*
> > + * NOTE: New defines must be added to the end of the list to preserve
> > + * compatibility because this enum is exported to user space.
> > + */
> >   #define CXL_CMDS                                                          \
> >   	___C(INVALID, "Invalid Command"),                                 \
> >   	___C(IDENTIFY, "Identify Command"),                               \
> > 
> > base-commit: acb704099642bc822ef2aed223a0b8db1f7ea76e  

