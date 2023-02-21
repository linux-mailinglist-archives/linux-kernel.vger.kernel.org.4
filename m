Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6CC69E053
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 13:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjBUM06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 07:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbjBUM0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:26:54 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD595BDEF;
        Tue, 21 Feb 2023 04:26:49 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LCEhFf013371;
        Tue, 21 Feb 2023 12:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Tl8ltNllwmweCBkGblYVCMrZAvyznJpNTU2qL4aBmT4=;
 b=TTDVTYV54+3MIrGpV//2mELt1lS6QSsy+gp4vWWY2lBr3IO/KkTjOS7hZWK16lmS6KiL
 U3bvET2Q98k/F+pLeCszQDOodPI+S5s6CFITfiTeP0RO0AQN0SwpNLSW4xOcP86q5O1r
 Q1969QZ7kRM1d4dz3niyeL+jEa9ZST2W+udi99al50VmtzG5RhNBsBBPaNq0zARQ1lpK
 AULBTM0Auz9pQEDMPAp2WHt5AyPcFXuAQtSMmolf2ng/3GC3DuAZ0oLAsaQH7RjkN2CV
 EmPKcxAcH2q4z0zwMBoPXrCPc00C/CW0jXDBuE2mkhLBc2CdSJXOo1izl50dWoic5ZpF 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nvu5wcccm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 12:26:18 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31LCPwRg025430;
        Tue, 21 Feb 2023 12:26:18 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nvu5wccbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 12:26:17 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31L8astS016604;
        Tue, 21 Feb 2023 12:26:15 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3ntpa6c02s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 12:26:15 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31LCQBDS47055110
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 12:26:12 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A96642004B;
        Tue, 21 Feb 2023 12:26:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F24220040;
        Tue, 21 Feb 2023 12:26:11 +0000 (GMT)
Received: from [9.155.211.163] (unknown [9.155.211.163])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 21 Feb 2023 12:26:11 +0000 (GMT)
Message-ID: <a0502208452b40b17572d18891ffee94e42484fa.camel@linux.ibm.com>
Subject: Re: [PATCH v4 09/16] s390: mm: Convert to GENERIC_IOREMAP
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, christophe.leroy@csgroup.eu,
        hch@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, David.Laight@aculab.com,
        shorne@gmail.com, arnd@arndb.de,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Date:   Tue, 21 Feb 2023 13:26:11 +0100
In-Reply-To: <Y/SvqcWQ+5sgozX/@MiWiFi-R3L-srv>
References: <20230216123419.461016-1-bhe@redhat.com>
         <20230216123419.461016-10-bhe@redhat.com>
         <9bb1154b07dc21e5d3dda8cc5238c5385f32c2e0.camel@linux.ibm.com>
         <Y/SvqcWQ+5sgozX/@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SOXG6skOkwFB8g88paWSPkxsrJ4aaB0j
X-Proofpoint-GUID: anVqOhVUFqtdXbF9gpYtcldReCPgqDs9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_07,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=913 adultscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302210101
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-02-21 at 19:48 +0800, Baoquan He wrote:
> On 02/16/23 at 05:21pm, Niklas Schnelle wrote:
> > On Thu, 2023-02-16 at 20:34 +0800, Baoquan He wrote:
> > > By taking GENERIC_IOREMAP method, the generic generic_ioremap_prot(),
> > > generic_iounmap(), and their generic wrapper ioremap_prot(), ioremap(=
)
> > > and iounmap() are all visible and available to arch. Arch needs to
> > > provide wrapper functions to override the generic versions if there's
> > > arch specific handling in its ioremap_prot(), ioremap() or iounmap().
> > > This change will simplify implementation by removing duplicated codes
> > > with generic_ioremap_prot() and generic_iounmap(), and has the equiva=
lent
> > > functioality as before.
> > >=20
> > > Here, add wrapper functions ioremap_prot() and iounmap() for s390's
> > > special operation when ioremap() and iounmap().
> > >=20
> > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > > Cc: Niklas Schnelle <schnelle@linux.ibm.com>
> > > Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> > > Cc: Heiko Carstens <hca@linux.ibm.com>
> > > Cc: Vasily Gorbik <gor@linux.ibm.com>
> > > Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> > > Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> > > Cc: Sven Schnelle <svens@linux.ibm.com>
> > > Cc: linux-s390@vger.kernel.org
> > > ---
> > >  arch/s390/Kconfig          |  1 +
> > >  arch/s390/include/asm/io.h | 21 ++++++++------
> > >  arch/s390/pci/pci.c        | 57 +++++++-----------------------------=
--
> > >  3 files changed, 23 insertions(+), 56 deletions(-)
> >=20
> > Thanks for the patch. This is a very clear improvement for us! I tested
> > this series with s390 systems with and without the PCI memory-I/O (MIO)
> > support and everything works as expected.
> >=20
> > One thing I did stumble upon but which is independent from this patch
> > is that I think memremap(=E2=80=A6, MEMREMAP_WB) on system RAM outside =
the
> > direct map is broken for us. At least on systems without PCI memory-I/O
> > support. I think with this series it would be much easier to fix
> > though. Basically I think we would have to define arch_memremap_wb() to
> > generic_ioremap_prot(=E2=80=A6, PAGE_KERNEL) and then have iounmap() ch=
eck
> > is_ioremap_addr() to see if it is an actual mapping or an address
> > cookie. But again this is independent of this patch which doesn't
> > change the behavior in this area.
>=20
> OK, I can check this after this patchset done.

Oh this wasn't meant as adding a task for you just a FYI. I'm already
experimenting with this and plan to possibly send a patch that fixes
the case of remapping system RAM once your series has landed. The thing
is that memremap() is quite tricky for us whichever way you look at
it.=C2=A0

We don't have real MMIO on s390x and thus using memremap() for PCI MMIO
spaces doesn't really work as the void* returned can still only be
accessed using ioread()/iowrite() because only our special PCI access
instructions work on the pseudo-MMIO addresses (with PCI MIO)
respectively the address cookies. Obviously void* and memremap() really
isn't the right tool if you need to use ioread()/iowrite() to access it
and can't treat it as memory though.

Thanks,
Niklas
