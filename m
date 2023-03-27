Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9826CA8A9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbjC0PKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbjC0PJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:09:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761C62D75;
        Mon, 27 Mar 2023 08:09:56 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32RE4gQk035101;
        Mon, 27 Mar 2023 15:09:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Haa1ahbXKuDgXKJ5hUlsNd69zw0QjFs2ThODvK2MJ0U=;
 b=rDDdmHtaFsQa+PYBV9mPVZcFCdNqGv26EWsON9BJSkZOCLJGXOmYRptN7xHT8pmcNZso
 9sgbxYIYemTtPnvNqmBXjfIGyL/2GVwnAJGZm57QmIexAISSVynwLekwCfVGX1k3PbBR
 OCWM9zD2Hrj7XJ7AGoI9GA1HmQ0yWvF79lShwMHH5Yirx1trhM91bML3B07AlivDrVu8
 jjzqWmCCHcTMrHBLl6s3ZYSEe2+VUXWbRHLElZViWLDY4rOM7PHVaNJ1LPs2ecTj9HBl
 9Ja9VrD6wuTmJu+PeOknG7JnBfvn6AlyZ3wGtlo/C9CIxxn71U5WM7bIQCEw3LU1iG1i LA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pjb1ammh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 15:09:48 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32R5QOjt020475;
        Mon, 27 Mar 2023 15:09:45 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3phrk6jhe2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 15:09:45 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32RF9gaX27001324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 15:09:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C1CA2004E;
        Mon, 27 Mar 2023 15:09:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92A2720043;
        Mon, 27 Mar 2023 15:09:41 +0000 (GMT)
Received: from localhost (unknown [9.171.67.53])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 27 Mar 2023 15:09:41 +0000 (GMT)
Date:   Mon, 27 Mar 2023 17:09:40 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Greg KH <greg@kroah.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the driver-core tree
Message-ID: <your-ad-here.call-01679929780-ext-1002@work.hours>
References: <20230327154655.58dd627d@canb.auug.org.au>
 <ZCFG1hUpsoB9acpi@kroah.com>
 <20230327192215.060fd858@canb.auug.org.au>
 <ZCFepL_u27Dxq9jd@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZCFepL_u27Dxq9jd@kroah.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9bgS2QcxqLxnrSRQ9Vtj71-yFNwmrS90
X-Proofpoint-GUID: 9bgS2QcxqLxnrSRQ9Vtj71-yFNwmrS90
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 mlxscore=0 adultscore=0 clxscore=1011 malwarescore=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxlogscore=687 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303270119
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 11:15:16AM +0200, Greg KH wrote:
> On Mon, Mar 27, 2023 at 07:22:15PM +1100, Stephen Rothwell wrote:
> > Hi All,
> > 
> > On Mon, 27 Mar 2023 09:33:42 +0200 Greg KH <greg@kroah.com> wrote:
> > >
> > > Patch is correct, thank you.
> > 
> > Thanks for checking.
> > 
> > > s390 developers, if you have a persistent tag/branch, I can suck this
> > > into the driver core tree and apply this fixup there so that you don't
> > > have to deal with any merge issues for 6.4-rc1 if you want.  Or I can
> > > provide one for you if you need/want that instead.  Or we can just leave
> > > it alone and deal with it during the 6.4-rc1 merge window, your choice.
> > 
> > Or (it being pretty trivial) you could both just let Linus know when
> > you send your merge requests ...
> 
> True, that works for me!

Sounds good for s390 as well, thank you!
