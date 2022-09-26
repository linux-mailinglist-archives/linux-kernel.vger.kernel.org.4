Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196885EA9B8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbiIZPJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235867AbiIZPIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:08:46 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519F61176;
        Mon, 26 Sep 2022 06:41:42 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QCD2Yl003782;
        Mon, 26 Sep 2022 13:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=QTf0c91xIH+BOTabS4mh2abHbhOlWiSw/XJtSH6mw1k=;
 b=iQcHze6sV/i5WW617dIicZLT0xwe0cc9CKWnvD8W+S5o2G7SWX6gwMee0USfuw+bgou3
 oXyvSizK2EfIr2+N2gQaOcz5rTfnWKJ1Bd+qWbf2NrYtHDyJHPyD0kVAIZcFwpbsicMR
 Xexj5GtSnuLR8jgA6Ponm4mkKcb7cgCX2TjKmcmFRUpBEWLameWTRH8S4MBJS2oaC1M1
 sFwoO6nWpM+oUD8rUS8FtbhrbWzFve9FbKduxJkQk57/UyCBgV8UvaVVvTCmfEBEkW8G
 eCEUquUmd/BUpxKSi4co5e/PhbydD/YWMl1bofJDcDoYeuMTo1Cm6ZpwoSAOXitl3pbd zg== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jubvxjmdu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 13:41:31 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28QDa9pL016702;
        Mon, 26 Sep 2022 13:41:29 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 3jss5hsvgt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 13:41:29 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28QDfrPb42926558
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Sep 2022 13:41:53 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 291974C04A;
        Mon, 26 Sep 2022 13:41:26 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 651244C044;
        Mon, 26 Sep 2022 13:41:25 +0000 (GMT)
Received: from sig-9-145-86-133.uk.ibm.com (unknown [9.145.86.133])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 26 Sep 2022 13:41:25 +0000 (GMT)
Message-ID: <68397430eab0fee46d8c61b8a8d6c2ecd27447d4.camel@linux.ibm.com>
Subject: Re: [PATCH v2 2/3] s390/pci: remove unused bus_next field from
 struct zpci_dev
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Pierre Morel <pmorel@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, linux-kernel@vger.kernel.org
Date:   Mon, 26 Sep 2022 15:41:24 +0200
In-Reply-To: <8ba5cee2-5e5c-6b73-3ac7-56e78e432698@linux.ibm.com>
References: <20220922095239.2115309-1-schnelle@linux.ibm.com>
         <20220922095239.2115309-3-schnelle@linux.ibm.com>
         <e0754578-1735-5811-0533-19ef0c6be2b0@linux.ibm.com>
         <8ba5cee2-5e5c-6b73-3ac7-56e78e432698@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oQecqKzWqFYL0ZRBx3ayVt9mMDVqtd9G
X-Proofpoint-GUID: oQecqKzWqFYL0ZRBx3ayVt9mMDVqtd9G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_08,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=918 mlxscore=0
 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 malwarescore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209260086
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-09-26 at 11:23 +0200, Pierre Morel wrote:
> 
> On 9/26/22 11:17, Pierre Morel wrote:
> > 
> > On 9/22/22 11:52, Niklas Schnelle wrote:
> > > This field was added in commit 44510d6fa0c0 ("s390/pci: Handling
> > > multifunctions") but is an unused remnant of an earlier version where
> > > the devices on the virtual bus were connected in a linked list instead
> > > of a fixed 256 entry array of pointers.
> > > 
> > > It is also not used for the list of busses as that is threaded through
> > > struct zpci_bus not through struct zpci_dev.
> > > 
> > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > 
> > Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> > 
> > 
> 
> Also couldn't it be detached of the series and posted on its own?

As this is entirely s390 specific this can go via the s390 tree without
re-posting. Since we're still figuring the rest of the series out it
might even make it upstream before that and then we can more easily
refer to it as a pre-requisite.

> 
> > > ---
> > >   arch/s390/include/asm/pci.h | 1 -
> > >   1 file changed, 1 deletion(-)
> > > 
> > > diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> > > index 7b4cdadbc023..108e732d7b14 100644
> > > --- a/arch/s390/include/asm/pci.h
> > > +++ b/arch/s390/include/asm/pci.h
> > > @@ -117,7 +117,6 @@ struct zpci_bus {
> > >   struct zpci_dev {
> > >       struct zpci_bus *zbus;
> > >       struct list_head entry;        /* list of all zpci_devices, 
> > > needed for hotplug, etc. */
> > > -    struct list_head bus_next;
> > >       struct kref kref;
> > >       struct hotplug_slot hotplug_slot;


