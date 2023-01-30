Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA051680EA9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236236AbjA3NS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235039AbjA3NSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:18:54 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4C12C644;
        Mon, 30 Jan 2023 05:18:53 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UCKkVs032475;
        Mon, 30 Jan 2023 13:18:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=cvvCmcY9LD2kg+MA/sYGCvACkhmQtgHLHbw/5You7j4=;
 b=ml2tWnIY9iDVVilnSmQMQ+cke+yYfYcqQYKyEzVsWZ21xfSkhpH0Txsd6Vj1SWzH9Q+7
 35TQARTR5VqaTTdYgSFP5hqHh50hQqX5Vj3lH9/b7IEH6wdOnec7uBgMUgAb7ZKidDjH
 JbSOxIGWjxmB+GUqtoIjMjVpY/UeOTtmDU5CAi8LJMKhX8wGIhReSK/qOG+dap/tX4VN
 8sbIb+L5rL6xK762LGmomgNPIbSLnUd62Orza+YGYUS7Lt8at9fPk2wqScN+mg6UodGx
 ZapMquydnonSMYmrH2dijkLpUhM7xeB2VE2PUoNv8laL1xXGKBxIHQrOkRngJ4w13RuH Yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nedtp9afs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 13:18:25 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30UDFktx029625;
        Mon, 30 Jan 2023 13:18:24 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nedtp9af9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 13:18:24 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30UC1dJO012329;
        Mon, 30 Jan 2023 13:18:23 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3ncvvdatt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 13:18:23 +0000
Received: from b03ledav001.gho.boulder.ibm.com ([9.17.130.232])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30UDIMws12386854
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 13:18:22 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 085396E050;
        Mon, 30 Jan 2023 13:20:28 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 324D36E052;
        Mon, 30 Jan 2023 13:20:26 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.211.110.248])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 30 Jan 2023 13:20:25 +0000 (GMT)
Message-ID: <5b1605cceba6e7de753bce8a78e1ce5c2d545546.camel@linux.ibm.com>
Subject: Re: [PATCH-next v2 2/2] scsi: fix iscsi rescan fails to create
 block device
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Yu Kuai <yukuai1@huaweicloud.com>,
        Zhong Jinghua <zhongjinghua@huawei.com>,
        gregkh@linuxfoundation.org, martin.petersen@oracle.com,
        hare@suse.de, bvanassche@acm.org, emilne@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Date:   Mon, 30 Jan 2023 08:17:49 -0500
In-Reply-To: <19ad8dd7-482e-dad0-8465-f78f7f9c154d@huaweicloud.com>
References: <20230128094146.205858-1-zhongjinghua@huawei.com>
         <20230128094146.205858-3-zhongjinghua@huawei.com>
         <1b466057ed2e91b05388afbb5791639eb8abdd59.camel@linux.ibm.com>
         <c3e58056-942a-f829-ecf6-1342c65b6865@huaweicloud.com>
         <7c5c38f128910f89f20533b7fd51453a32ff4f5c.camel@linux.ibm.com>
         <19ad8dd7-482e-dad0-8465-f78f7f9c154d@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QIWc-IpX-swEH17Rja38JCGHWqiJzfbp
X-Proofpoint-ORIG-GUID: OTgMdjE7zxFGRqop9RIBlpsdAWGZdte-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_12,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300126
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-01-30 at 11:46 +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2023/01/30 11:29, James Bottomley 写道:
> > On Mon, 2023-01-30 at 11:07 +0800, Yu Kuai wrote:
> > > Hi,
> > > 
> > > 在 2023/01/30 1:30, James Bottomley 写道:
> > > > On Sat, 2023-01-28 at 17:41 +0800, Zhong Jinghua wrote:
> > > > > This error will cause a warning:
> > > > > kobject_add_internal failed for block (error: -2 parent:
> > > > > 1:0:0:1). In the lower version (such as 5.10), there is no
> > > > > corresponding error handling, continuing to go down will
> > > > > trigger a kernel panic, so cc stable.
> > > > 
> > > > Is this is important point and what you're saying is that this
> > > > only panics on kernels before 5.10 or so because after that
> > > > it's correctly failed by block device error handling so there's
> > > > nothing to fix in later kernels?
> > > > 
> > > > In that case, isn't the correct fix to look at backporting the
> > > > block device error handling:
> > > 
> > > This is the last commit that support error handling, and there
> > > are many relied patches, and there are lots of refactor in block
> > > layer. It's not a good idea to backport error handling to lower
> > > version. 
> > > Althrough error handling can prevent kernel crash in this case, I
> > > still think it make sense to make sure kobject is deleted in
> > > order, parent should not be deleted before child.
> > 
> > Well, look, you've created a very artificial situation where a
> > create closely followed by a delete of the underlying sdev races
> > with the create of the block gendisk devices of sd that bind
> > asynchronously to the created sdev.  The asynchronous nature of the
> > bind gives the elongated race window so the only real fix is some
> > sort of check that the sdev is still viable by the time the bind
> > occurs ... probably in sd_probe(), say a scsi_device_get of sdp at
> > the top which would ensure viability of the sdev for the entire
> > bind or fail the probe if the sdev can't be got.
> 
> Sorry, I don't follow here. 😟

In the current kernel the race is mitigated because add_device fails
due to the parent being torn down.  That parent is the sdev->gendev so
it seems we can detect this in the probe by looking at the sdev->gendev
state, which scsi_device_get() will do.

> I agree this is a very artificial situation, however I can't tell our
> tester not to test this way...
> 
> The problem is that kobject session is deleted and then sd_probe()
> tries to create a new kobject under hostx/sessionx/x:x:x:x/. I don't
> see how scsi_device_get() can prevent that, it only get a kobject
> reference and can prevent kobject to be released, however,
> kobject_del() can still be done.

So your contention is there's no way that we could make scsi_device_get
see the kernfs deactivation?  I would have thought checking sdev-
>sdev_gendev.kobj.sd.active would give that ... although the check
would have to be via an API since KN_DEACTIVATED_BIAS is internal.

James

> In this patch, we make sure remove session and sd_probe() won't
> concurrent, remove session will wait for all child kobject to be
> deleted, what do you think?
> 
> Thanks,
> Kuai
> 

