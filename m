Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAD866D8F0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 09:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236219AbjAQI72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 03:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236382AbjAQI7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:59:03 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D413717CDE;
        Tue, 17 Jan 2023 00:57:45 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H708MD030316;
        Tue, 17 Jan 2023 08:57:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=5Ngmtp4YGXY+UVW/xuD6vNYTPLp1RqdeFxbJq2YJX0Q=;
 b=SU+V6jPQPQRXEpUT7hiyw6u74SZyWXh8WWMUe/4Ea+YRXBUs+NCayqB1L28YWUBq41yU
 /iezTPtXzRbTbXCa5ulgRzM3jwegA34Ht+CFLSA2piaqlSDeLDd7I8u7TJODyFOKLxXz
 HwCK/bwS18vEj1K9p4aQFfLHJMG9O6jqScZUTQtR9tjtnMww2+QOefjbq8KNUX25Ht+y
 5V0YxipdZd+bF7+4aPvfo+VaNrQhaMHJuxuOh8Gn1KrwldMHh+RJP0N76ZnZid0OxCEm
 mw0xgsd3X9WI1ftdAtLXjBIFmr6HZw0MoWglF6GFyIBZ7DH8NFYENCZFiuiDwxvYnQuH oQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n5pwbtbf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 08:57:30 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30H8VSsx023792;
        Tue, 17 Jan 2023 08:57:28 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3n3m16kjjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 08:57:28 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30H8vOZd40436058
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 08:57:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA00320040;
        Tue, 17 Jan 2023 08:57:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99D9A2004D;
        Tue, 17 Jan 2023 08:57:24 +0000 (GMT)
Received: from osiris (unknown [9.152.212.250])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 17 Jan 2023 08:57:24 +0000 (GMT)
Date:   Tue, 17 Jan 2023 09:57:23 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: Build regressions/improvements in v6.2-rc4
Message-ID: <Y8Zi89nN+ONOEki7@osiris>
References: <CAHk-=wgcOEWvT-WjmRf-zCCXyFJaVVFH=26BPQ+N1OFTTnN=RA@mail.gmail.com>
 <20230116122924.116745-1-geert@linux-m68k.org>
 <46ba7912-3df6-dff9-792-49f4eaadefec@linux-m68k.org>
 <Y8V94PKtaWO3yRS4@osiris>
 <20230116184127.GA1721129@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116184127.GA1721129@roeck-us.net>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gPRFidB2a5P05ZwQonyUUP6B62NBqaM7
X-Proofpoint-ORIG-GUID: gPRFidB2a5P05ZwQonyUUP6B62NBqaM7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_03,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=555
 clxscore=1011 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170066
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 10:41:27AM -0800, Guenter Roeck wrote:
> On Mon, Jan 16, 2023 at 05:40:00PM +0100, Heiko Carstens wrote:
> > On Mon, Jan 16, 2023 at 01:36:34PM +0100, Geert Uytterhoeven wrote:
> > > On Mon, 16 Jan 2023, Geert Uytterhoeven wrote:
> > > > JFYI, when comparing v6.2-rc4[1] to v6.2-rc3-8-g1fe4fd6f5cad346e[3], the summaries are:
> > > >  - build errors: +1/-5
> > > 
> > >   + /kisskb/src/include/linux/fortify-string.h: error: '__builtin_memcpy' reading 128 bytes from a region of size 0 [-Werror=stringop-overread]:  => 57:33
> > > 
> > > s390x-gcc11/s390-allmodconfig
> > > 
> > > /kisskb/src/arch/s390/kernel/setup.c: In function 'setup_lowcore_dat_on':
> > > /kisskb/src/include/linux/fortify-string.h:57:33: error: '__builtin_memcpy' reading 128 bytes from a region of size 0 [-Werror=stringop-overread]
> > >    57 | #define __underlying_memcpy     __builtin_memcpy
> > >       |                                 ^
> > > /kisskb/src/include/linux/fortify-string.h:578:9: note: in expansion of macro '__underlying_memcpy'
> > >   578 |         __underlying_##op(p, q, __fortify_size);                        \
> > >       |         ^~~~~~~~~~~~~
> > > /kisskb/src/include/linux/fortify-string.h:623:26: note: in expansion of macro '__fortify_memcpy_chk'
> > >   623 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
> > >       |                          ^~~~~~~~~~~~~~~~~~~~
> > > /kisskb/src/arch/s390/kernel/setup.c:526:9: note: in expansion of macro 'memcpy'
> > >   526 |         memcpy(abs_lc->cregs_save_area, S390_lowcore.cregs_save_area,
> > >       |         ^~~~~~
> > > 
> > > Looks like this was "'__builtin_memcpy' offset [0, 127] is out of the bounds
> > > [0, 0]" before.
> > 
> > Thanks for reporting. Of course this doesn't happen with gcc-12, and
> > this code will be rewritten with the next merge window anyway.
> > But to workaround this with gcc-11, we could go with the below:
> > 
> 
> This is because of
> 
> #define S390_lowcore (*((struct lowcore *) 0))
> 
> and is fixed with something like
> 
> #define S390_lowcore (*((struct lowcore *) absolute_pointer(0)))
> 
> See commit f6b5f1a56987 ("compiler.h: Introduce absolute_pointer macro").

Yes, I'm aware of that. However absolute_pointer() is not an option for
S390_lowcore. See also commit f0be87c42cbd ("gcc-12: disable
'-Warray-bounds' universally for now") and the referenced s390 commit.

> The problem is only seen with gcc 11.2. I don't see it with 11.3 or 12.2.

FWIW, the compile warning is seen with gcc 11.1 and 11.2, but not with any
other compiler. Given that this isn't the first report, I'm tempted to
workaround this now.
