Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550E4618570
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiKCQ6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiKCQ6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:58:34 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484481143;
        Thu,  3 Nov 2022 09:58:33 -0700 (PDT)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4N38zW1JkDz67lBv;
        Fri,  4 Nov 2022 00:56:23 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 17:58:29 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 3 Nov
 2022 16:58:28 +0000
Date:   Thu, 3 Nov 2022 16:58:27 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "Jonathan Zhang (Infra)" <jonzhang@meta.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Robert Richter" <rrichter@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        "Terry Bowman" <terry.bowman@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 0/2] efi/cper, cxl: Decode CXL Protocol Errors CPER
Message-ID: <20221103165827.00000b39@Huawei.com>
In-Reply-To: <635c3f9e39742_6be12941a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221007211714.71129-1-Smita.KoralahalliChannabasappa@amd.com>
        <63531a9dd51b9_4da32946c@dwillia2-xfh.jf.intel.com.notmuch>
        <151c093f-1e92-1c8e-957b-8781e488626a@amd.com>
        <63587b16dbb3_14192944c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
        <69a14ac2-510e-fd8f-0854-60805a150663@amd.com>
        <D9381C12-A585-4089-873B-3707C17823D3@fb.com>
        <635c3f9e39742_6be12941a@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
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

On Fri, 28 Oct 2022 13:46:22 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Zhang (Infra) wrote:
> > 
> >   
> > > On Oct 26, 2022, at 12:31 PM, Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:
> > > 
> > > On 10/25/2022 5:11 PM, Dan Williams wrote:  
> > >> Smita Koralahalli wrote:  
> > >>> Hi Dan,
> > >>> 
> > >>> On 10/21/2022 3:18 PM, Dan Williams wrote:  
> > >>>> Hi Smita,
> > >>>> 
> > >>>> Smita Koralahalli wrote:  
> > >>>>> This series adds decoding for the CXL Protocol Errors Common Platform
> > >>>>> Error Record.  
> > >>>> Be sure to copy Ard Biesheuvel <ardb@kernel.org>, added, on
> > >>>> drivers/firmware/efi/ patches.
> > >>>> 
> > >>>> Along those lines, drivers/cxl/ developers have an idea of what is
> > >>>> contained in the new CXL protocol error records and why Linux might want
> > >>>> to decode them, others from outside drivers/cxl/ might not. It always
> > >>>> helps to have a small summary of the benefit to end users of the
> > >>>> motivation to apply a patch set.  
> > >>> Sure, will include in my v2.
> > >>>   
> > >>>>> Smita Koralahalli (2):
> > >>>>>    efi/cper, cxl: Decode CXL Protocol Error Section
> > >>>>>    efi/cper, cxl: Decode CXL Error Log
> > >>>>> 
> > >>>>>   drivers/firmware/efi/Makefile   |   2 +-
> > >>>>>   drivers/firmware/efi/cper.c     |   9 +++
> > >>>>>   drivers/firmware/efi/cper_cxl.c | 108 ++++++++++++++++++++++++++++++++
> > >>>>>   drivers/firmware/efi/cper_cxl.h |  58 +++++++++++++++++
> > >>>>>   include/linux/cxl_err.h         |  21 +++++++
> > >>>>>   5 files changed, 197 insertions(+), 1 deletion(-)  
> > >>>> I notice no updates for the trace events in ghes_do_proc(), is that next
> > >>>> in your queue? That's ok to be a follow-on after v2.  
> > >>> Sorry, if I haven't understood this right. Are you implying about the
> > >>> "handling"
> > >>> of cxl memory errors in ghes_do_proc() or is it just copying of CPER
> > >>> entries to
> > >>> tracepoints?  
> > >> Right now ghes_do_proc() will let the CXL CPER records fall through to
> > >> log_non_standard_event(). Are you planning to add trace event decode
> > >> there for CPER_SEC_CXL_PROT_ERR records?  
> > > 
> > > Thanks! Yeah its a good idea to add. I did not think about this before.
> > > I will send this as a separate patchset after v2.
> > > 
> > > I think with this cxl cper trace event support and Ira's patchset which traces
> > > specific event record types via Get Event Record, we can start the userspace
> > > handling probably in rasdaemon?  
> > Yes, I think this makes sense. rasdaemon could aggregate data and provide user
> > with full picture:
> > * Memory errors from both processor attached memory and CXL memory.
> > * CXL protocol errors.
> > * CXL device errors.
> > Such errors may be handled either firmware first or OS first.  
> 
> I have no concerns about rasdaemon subscribing to CXL RAS events, but
> the nice thing about trace-events is that any number of subscribers can
> attach to the event stream. So I expect cxl-cli to have a monitor of
> these CXL specific events and that does not preclude rasdaemon from
> also incorporating CXL events into its event list.

FYI, we posted some poison list RAS daemon patches a while back. 
https://lore.kernel.org/all/20220622122021.1986-1-shiju.jose@huawei.com/

Absolutely agree we'll want all the rest of these once kernel patches are in
(and hence we know the tracepoints definitions are stable)

If anyone is working on the RASdaemon side of things, shout on the list as
I'd rather not see duplication of effort.

Jonathan

