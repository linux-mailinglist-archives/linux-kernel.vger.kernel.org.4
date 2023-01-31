Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0B86822D2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 04:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjAaD1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 22:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjAaD07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 22:26:59 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393BD358A;
        Mon, 30 Jan 2023 19:26:58 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30V1QAFW031430;
        Tue, 31 Jan 2023 03:26:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=2IL8lKFb8MQDNcC65oW02wIG+dVT7/A+li+H98VgwAs=;
 b=m8D8Wa/sRKxoKj5vGbltnGilw0jVdpk06Nq8qZQXa1TsxgaMihwMygIjENBU2gBJrkQy
 dp5NCRhrBvInAle1uJ2VUORNqDXjO3keeZBoeG42eCQIreOVoQHTsSFhleO2qJg53Trp
 8IkY+1RhrlW39UB8JXEUgagvqu92rIgK9Zv6yFxfk81UN8gOGjE9RIBmW5yps0rsHrPn
 Lo0fFicTlMcWHrnzclIZrCJL/XPbA3BnuvqBC13gl2KWjhYkn24uqjdAEWAzqzSH4Egm
 liJsAHlB4FdXWANO8SYEVL7AvD5S1HYPU0FSua1Y2KEr0pal2Pdz97YI4y1BW+kbZltf Zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nery5jx20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 03:26:36 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30V2HIjr015473;
        Tue, 31 Jan 2023 03:26:36 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nery5jx1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 03:26:36 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30V0N3rt008390;
        Tue, 31 Jan 2023 03:26:35 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3ncvw2hf0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 03:26:35 +0000
Received: from b03ledav001.gho.boulder.ibm.com ([9.17.130.232])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30V3QXah12190386
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 03:26:34 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 367556E04E;
        Tue, 31 Jan 2023 03:28:40 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C39CB6E050;
        Tue, 31 Jan 2023 03:28:37 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.211.110.248])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 31 Jan 2023 03:28:37 +0000 (GMT)
Message-ID: <7eef4b0ce1904f30c02b9e89aa6732d32bb5593f.camel@linux.ibm.com>
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
Date:   Mon, 30 Jan 2023 22:25:59 -0500
In-Reply-To: <69a9000f-541e-c182-44c9-75337094de4a@huaweicloud.com>
References: <20230128094146.205858-1-zhongjinghua@huawei.com>
         <20230128094146.205858-3-zhongjinghua@huawei.com>
         <1b466057ed2e91b05388afbb5791639eb8abdd59.camel@linux.ibm.com>
         <c3e58056-942a-f829-ecf6-1342c65b6865@huaweicloud.com>
         <7c5c38f128910f89f20533b7fd51453a32ff4f5c.camel@linux.ibm.com>
         <19ad8dd7-482e-dad0-8465-f78f7f9c154d@huaweicloud.com>
         <5b1605cceba6e7de753bce8a78e1ce5c2d545546.camel@linux.ibm.com>
         <69a9000f-541e-c182-44c9-75337094de4a@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QkolrsabyiaVBugXbbmM52Igv1CvjQWN
X-Proofpoint-ORIG-GUID: lCQmvnXJtE18MuHWM14-KlUQgXN4oCvx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_19,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 malwarescore=0 adultscore=0 phishscore=0
 clxscore=1015 mlxlogscore=999 spamscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310026
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-01-31 at 09:43 +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2023/01/30 21:17, James Bottomley 写道:
> > On Mon, 2023-01-30 at 11:46 +0800, Yu Kuai wrote:
> > > Hi,
> > > 
> > > 在 2023/01/30 11:29, James Bottomley 写道:
> > > > On Mon, 2023-01-30 at 11:07 +0800, Yu Kuai wrote:
> > > > > Hi,
> > > > > 
> > > > > 在 2023/01/30 1:30, James Bottomley 写道:
> > > > > > On Sat, 2023-01-28 at 17:41 +0800, Zhong Jinghua wrote:
> > > > > > > This error will cause a warning:
> > > > > > > kobject_add_internal failed for block (error: -2 parent:
> > > > > > > 1:0:0:1). In the lower version (such as 5.10), there is
> > > > > > > no corresponding error handling, continuing to go down
> > > > > > > will trigger a kernel panic, so cc stable.
> > > > > > 
> > > > > > Is this is important point and what you're saying is that
> > > > > > this only panics on kernels before 5.10 or so because after
> > > > > > that it's correctly failed by block device error handling
> > > > > > so there's nothing to fix in later kernels?
> > > > > > 
> > > > > > In that case, isn't the correct fix to look at backporting
> > > > > > the block device error handling:
> > > > > 
> > > > > This is the last commit that support error handling, and
> > > > > there are many relied patches, and there are lots of refactor
> > > > > in block layer. It's not a good idea to backport error
> > > > > handling to lower version. Althrough error handling can
> > > > > prevent kernel crash in this case, I still think it make
> > > > > sense to make sure kobject is deleted in order, parent should
> > > > > not be deleted before child.
> > > > 
> > > > Well, look, you've created a very artificial situation where a
> > > > create closely followed by a delete of the underlying sdev
> > > > races with the create of the block gendisk devices of sd that
> > > > bind asynchronously to the created sdev.  The asynchronous
> > > > nature of the bind gives the elongated race window so the only
> > > > real fix is some sort of check that the sdev is still viable by
> > > > the time the bind occurs ... probably in sd_probe(), say a
> > > > scsi_device_get of sdp at the top which would ensure viability
> > > > of the sdev for the entire bind or fail the probe if the sdev
> > > > can't be got.
> > > 
> > > Sorry, I don't follow here. 😟
> > 
> > In the current kernel the race is mitigated because add_device
> > fails due to the parent being torn down.  That parent is the sdev-
> > >gendev so it seems we can detect this in the probe by looking at
> > the sdev->gendev state, which scsi_device_get() will do.
> > 
> > > I agree this is a very artificial situation, however I can't tell
> > > our tester not to test this way...
> > > 
> > > The problem is that kobject session is deleted and then
> > > sd_probe() tries to create a new kobject under
> > > hostx/sessionx/x:x:x:x/. I don't see how scsi_device_get() can
> > > prevent that, it only get a kobject reference and can prevent
> > > kobject to be released, however, kobject_del() can still be done.
> > 
> > So your contention is there's no way that we could make
> > scsi_device_get see the kernfs deactivation?  I would have thought
> > checking sdev->sdev_gendev.kobj.sd.active would give that ...
> > although the check would have to be via an API since
> > KN_DEACTIVATED_BIAS is internal.
> 
> I'm still not sure if such checking is enough.

It's the same check as causes the block device_add() to fail in
upstream which, so far I believe, you've failed to trigger an oops on.
The problem is this doesn't reproduce upstream and say you need
something simple to backport to stable kernels rather than trying to
backport the device_add() error handling.  The proposal doesn't
completely close the race windows but I think it narrows it to the
point where the add/remove race is almost impossible to trigger.

> session1/target1:0:0/1:0:0:0/block
> 
> 1) t1 is deleting target, and t1 already set 1:0:0:0 to SDEV_CANCEL,
> and 1:0:0:0 is not deleted yet.
> 2) t2 is deleting session1, 1:0:0:0 state is SDEV_CACEL, so 1:0:0:0
> is skipped, and session1 is deleted before 1:0:0:0, which will cause
> 1:0:0:0 to be not active.
> 3) t3 create block, it can happen because 1:0:0:0 is still not
> deleted, and later kobject_add() will found 1:0:0:0 is not active and
> hence faild.
> 
> The problem is that deleting parent kobject will cause child kobject
> not to be active, and in 3) device_lock is not hold for parents,
> hence just checking if this scsi_device is active is not enough, we
> have to make sure parents won't be deleted concurrently, for example,
> a litter adjustment for above procedures:
> 
> 1) ...(the same)
> 2) t3 create block, it check kobject state is still active
> 3) t2 delete session1 ...(the same), 1:0:0:0 is not active anymore.
> 4) t3 continue to create block undre 1:0:0:0, which will fail.
> 
> By the way, I think such problem exist because scsi_device state is
> SDEV_CANCEL doesn't mean that the device is deleted, simply skip such
> device while removing session is not right.
> 
> Do you found other problems if we make sure that kobject is deleted
> in order?

Given there's nothing to fix in upstream, coming up with elaborate
ordering constraints on kobjects isn't going to pass muster for
backporting to stable.

James

