Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B268160AE33
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 16:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbiJXOwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 10:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbiJXOwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 10:52:05 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3045C4E612;
        Mon, 24 Oct 2022 06:30:11 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29OCERSb023714;
        Mon, 24 Oct 2022 12:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : content-transfer-encoding : mime-version; s=pp1;
 bh=oXDo6OOAGRuOx2/tHyuwWdEtQtQZtp/beyJbpXTtQo4=;
 b=koxkd2YZZzRZMplg4caN1FtHR1Q0XA5I+p8f2rdYg9ihhsA14PzT4ltccH92+cxpqlsx
 5SqzFOEtiN+XMmSJK7MLubY02QztDq2WVmEzGKfrdyLcWtV1Wj3xC0Vl3p1l9a/VBKk9
 5tZ25nCzmJjk5ZOBC7Sq1Ji5f5VaQn68hxk0T4uJGj3PFUIkk1uL1zkJ1pmgpxmUTvaL
 rvOt7RAsrsT0fWolYucTyXwMEZe9qLbStdP6jYNiA66qHNiZutRAiXdgq42/jgEFunz8
 BOvxZODTyLVyT47aizWlW+J1fQxz5bSZZEXvN7agYONaoiaoYrD7V2/OqhBXUeiSGjwp aA== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kdthg12fh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Oct 2022 12:51:30 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29OCZbsn008186;
        Mon, 24 Oct 2022 12:51:30 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma04dal.us.ibm.com with ESMTP id 3kc859pu97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Oct 2022 12:51:29 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29OCpUoi8651402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 12:51:30 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 434BA7805E;
        Mon, 24 Oct 2022 13:34:16 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72A6E7805C;
        Mon, 24 Oct 2022 13:34:14 +0000 (GMT)
Received: from [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b] (unknown [9.163.14.162])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 24 Oct 2022 13:34:14 +0000 (GMT)
Message-ID: <2fd505a07bd26d76f1166761fa50905414edb7ef.camel@linux.ibm.com>
Subject: Re: Report in downstream Debian: mpt3sas broken with xen dom0 with
 update to 5.10.149 in 5.10.y.
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Salvatore Bonaccorso <carnil@debian.org>,
        sathya.prakash@broadcom.com, suganath-prabu.subramani@broadcom.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        adi@kriegisch.at
Date:   Mon, 24 Oct 2022 08:51:25 -0400
In-Reply-To: <CAK=zhgr=MYn=-mrz3gKUFoXG_+EQ796bHEWSdK88o1Aqamby7g@mail.gmail.com>
References: <Y1JkuKTjVYrOWbvm@eldamar.lan>
         <85ad4508-b979-c792-e92b-01bc16260dec@acm.org>
         <CAK=zhgr=MYn=-mrz3gKUFoXG_+EQ796bHEWSdK88o1Aqamby7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rf1s4aY2JsG8kj3ndnjkEqcdP00oZW8p
X-Proofpoint-ORIG-GUID: rf1s4aY2JsG8kj3ndnjkEqcdP00oZW8p
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_03,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 bulkscore=0 clxscore=1011 spamscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210240077
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-10-24 at 17:26 +0530, Sreekanth Reddy wrote:
> On Sun, Oct 23, 2022 at 6:57 AM Bart Van Assche <bvanassche@acm.org>
> wrote:
> > On 10/21/22 02:22, Salvatore Bonaccorso wrote:
> > > We got the following report in Debian after an update from
> > > 5.10.140 to
> > > the current 5.10.149. Full quoting below (from
> > > https://bugs.debian.org/1022126). Does this ring some bell about
> > > known
> > > regressions?
> > 
> > Only three mpt3sas changes are new in v5.10.149 compared to
> > v5.10.140:
> > $ git log --format=oneline v5.10.140..v5.10.149
> > 2b9aba0c5d58e141e32bb1bb4c7cd91d19f075b8 scsi: mpt3sas: Fix return
> > value check of dma_get_required_mask()
> > e7fafef9830c4a01e60f76e3860a9bef0262378d scsi: mpt3sas: Force PCIe
> > scatterlist allocations to be within same 4 GB region
> > ea10a652ad2ae2cf3eced6f632a5c98f26727057 scsi: mpt3sas: Fix use-
> > after-free warning
> > 
> > Sreekanth and Suganath, can you help with bisecting this issue? For
> > the
> > full report, see also 
> > https://lore.kernel.org/linux-scsi/Y1JkuKTjVYrOWbvm@eldamar.lan/.
> 
> This issue is getting observed after having the below patch changes,
> 2b9aba0c5d58e141e32bb1bb4c7cd91d19f075b8 scsi: mpt3sas: Fix return
> value check of dma_get_required_mask()
> 
> What is happening is that on Xen hypervisor, this
> dma_get_required_mask() API always returns a 32 bit DMA mask. I.e. It
> says that the minimum DMA mask required to access the host memory is
> 32 bit and hence mpt3sas driver is setting the DMA mask to 32bit.

This sounds entirely correct because the VM is booted with (from the
original debian bug report):

dom0_mem=4096M,max:4096M dom0_max_vcpus=4 dom0_vcpus_pin
  ucode=scan xpti=dom0=false,domu=true gnttab_max_frames=128

So it has no memory above 4GB and thus 32 bit addressing is the minimum
required.  If you boot a machine with >4GB and Xen still returns a 32
bit mask here, then we have a Xen problem.

>  So, on a 64 bit machine, if the driver set's the DMA mask to 32 bit
> then SWIOTLB's bounce buffer comes into picture during IOs. Since
> these bounce buffers are limited in size and hence we observe the IO
> hang if the large IOs are issued.

Why is the SWIOTLB active if all the physical memory in the VM is
within the range of the DMA mask?  If this is really happening, it
sounds like a SWIOTLB bug.

> I am not sure whether this API's return value is correct or not in
> the Xen environment. If it is correct then I have to modify the
> driver to not use this API and directly set the DMA mask to 64 bit if
> the system is a 64bit machine.

The original design of the API is to describe exactly the minimum
direct DMA requirements.  There are a large number of cards with
multiple DMA register formats, the most common being to use either a
compact 32 bit or an expanded 64 bit register to describe a page
location.  The former gives 39 bits of addressing and the latter 64. 
If the DMA mask is 39 bits or below as described by this API, then the
card can use the compact address form.

James


