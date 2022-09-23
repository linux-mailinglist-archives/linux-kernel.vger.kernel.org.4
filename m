Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120585E77D6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 12:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiIWKBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 06:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiIWKAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 06:00:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCF4125185
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 03:00:54 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28N9BPLJ031581;
        Fri, 23 Sep 2022 10:00:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=5TQ8Qa6Ze1kbDSFA1TbTwDVC2dgt5lvPxnmJ5spCj/Q=;
 b=gQKZ3azefKDH6nifuj5Yg7I1pfVjxr+2kL/GHdTbAEnynmBNHkCruvM8h4m/smXNAxtv
 ltI/8oLXDKrQEypGq0q/e08y4RAY3kvhtiyy04sGc6jcVHH8M32iCluCqBaLsIyVICs8
 iujCzs0g8wnrq0m/eIEyVmvAcmPG4CIBxXl630gmfOjaX3Dl6GQzNUINyNJ9zsMjsspf
 LuXsQ+sgcf6I0Ddlvjj7/5D74/elNFLw1h0kveqRFowO9UBsjilBtVB9YAg2r29rAnzI
 Hves1tgdMxuWbHGVJY0aC1X9gTr6XoBIrKNjaZcL3teZPHjExU0Ud2TQfo8ogJh+gy93 sg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn68rr1ve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Sep 2022 10:00:28 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28NA0EPp031277;
        Fri, 23 Sep 2022 10:00:26 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39pkwca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Sep 2022 10:00:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRTkEwVtnbBIMM1iFTU+lFN4WbNEHVJU7RRBpp/EnQPWjZUP600Nxz5B5z4KLRBUFnnJGWJ+FCzWVfXOrT1w90aoA0xBu58S/lOZCdzAmrY7OZsHRRgsYhi5upHh9Y2FOJnQ+0pjZUw04QbdnRzHhaRCnohV+Wf7Mwo4E7joiXEHvxDuKXEmHC3d+Cm9/mBuQdVcFacq1ZKDT842qwXeYPCs5dLajHZ9P3cGCdvFqke6UUhpUJ1RwjDKI7LVIPUNFVo2DwsccqJVNHjTsdQXwhT9vt7OCiC2QnPbUH2rgsmMKdk1+hbRtPN88datA2AzZjrOQ4huDJa+M5LRbvZHVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TQ8Qa6Ze1kbDSFA1TbTwDVC2dgt5lvPxnmJ5spCj/Q=;
 b=JI6O+XmGPcjOezA0HfUXfFVM6Vj+fyeAOFkMARWsYRuyWF2oOiz3UhLX9aqMkhlA2Yb4RH73MvA4/74ZrsSYCoBHJc90u03VNka9d1kKMOzhTXDeXubuGoSGCAdHbN67WfSRv7B2/q98AkUr5ALLeQQy68ooH/aXDYW7CrRZYjyJ1fKmDMcMIrJSvPGPUg0ROQ0J2Z83KkV6MxJke8pckNurIuTrQaumAj1ROh/V1Ss/Y/NVQS1UwTp85/7Wj2yhYytZBLGY2Q8frEk/Fv+IiENocsScC1hytUen9Dyoksq4Xvx8rW6caivVdroCbITSoAgj+16wmNlIMMLX499amw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TQ8Qa6Ze1kbDSFA1TbTwDVC2dgt5lvPxnmJ5spCj/Q=;
 b=0L8x4sYHhWcm23fcYas08CiLmg42HVqGDddJKdWGSDK6Ett/B+1T9uPynMq90E2hWoyQIj2mzC2nL9NhNZtdsq3uSF32Y4YRtFY5rJ5/x1Pp/7qOTrRnX32xd07YESJWsnG9+aOBNCuu6oRoiL9IQLxvZDGkDPBoiHPSp0LoGwY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB4187.namprd10.prod.outlook.com
 (2603:10b6:5:210::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 10:00:24 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5654.019; Fri, 23 Sep 2022
 10:00:22 +0000
Date:   Fri, 23 Sep 2022 12:59:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Joe Perches <joe@perches.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Shigeru Yoshida <syoshida@redhat.com>,
        syzbot <syzbot+1631f09646bc214d2e76@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, ntfs3@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs/ntfs3: fix negative shift size in
 true_sectors_per_clst()
Message-ID: <Yy2DniTKbL0hxWeO@kadam>
References: <000000000000f8b5ef05dd25b963@google.com>
 <4b37f037-3b10-b4e4-0644-73441c8fa0af@I-love.SAKURA.ne.jp>
 <e0173c17-3837-a619-4bcc-7a0ba4843cc4@infradead.org>
 <34b60d0ed48e4384e82a29020702ee2471092fb1.camel@perches.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34b60d0ed48e4384e82a29020702ee2471092fb1.camel@perches.com>
X-ClientProxiedBy: JN2P275CA0015.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::27)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|DM6PR10MB4187:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f1560f3-5445-4d6a-a73d-08da9d4a6cea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f9UnvgIec+GBNqhforOwQ/ik00byVLE+KIiMBWC5XOYTqxdmpG7znnIlpL17dZ2m3FfkHPvFcooLXDyRIRmdcREP/KHoEUlfP+dPnuPNEl25LUstaSNBU8m+2wymbvHD1IDILphf/t177SRGdvvtApityIOGcuCqWhlDht699WYy8Njk3pbGow5tt/6tPd55tBcc96huSogy/jMwQTeaD4fK5bUPpL/x8EG1E3a5/giGQwORjfc9ZJ33qwChUoeMi2BnCA8OcWDfdXDiCbqtWzxr4VX06cscBOaO/rCHvbEYDtZkUA7zaYLDV6snlcX29jBR3Sa5PYs24ORt0wvFDwU6A9sss8TqLMeKpATpIa467oqu2JCxYG2Byy0xDbWi2YQec4cG+2qFi4U4xYMMjD++tPrvwmwNdvWAOI1V0pmJjm6JmjFuYwkWOPeY5bIuyLVCucdBtDybpgms0/nJ/04UsnK2vE8j1o0yT+PWE0B5+fu4ctAHabNO0japt06B3xdYsyH0eetSL+6prguca2flzZdZq5ubiqjXqEaBPZincdvAVOejxgw7a1GIsOwJG/kwnAwNtqdwIxxtZJOP2PHVg/iYULa4MqtuKej83T1NBWof1OtQfAjRzVGWZ7CedgCYON7I/M0X6bzalBWn5ZfL2eiXHV3Np6x6sqvyngsIKmj+HRQpCtQ+oGF98PxMbesW/6abjuubuPlcqpSryQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199015)(38100700002)(4744005)(44832011)(478600001)(6486002)(86362001)(4326008)(66476007)(66556008)(66946007)(186003)(2906002)(6916009)(26005)(54906003)(9686003)(6512007)(6666004)(6506007)(5660300002)(8936002)(8676002)(7416002)(316002)(41300700001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mNEsl6wL6J527f3DhJ7Wy83eELc5wucYh416lhLB9ucZAdFPbqf+lm/Ebhkf?=
 =?us-ascii?Q?V7yX5/faSxJd2HjDvjQ6aeKB1DsqPpIBGJJ/999SCRU/bwjbpb52ppCb8xyy?=
 =?us-ascii?Q?i6s6jnkoT+W7anxhHOdyfMtvXqa4qdekpX/x/gf79BnJdZ5zIUNghh++5OxM?=
 =?us-ascii?Q?A0o/jGyA1PVjOb2wcfNcreqL9XM2rZXiPqIwjqyCV2uptD2xVStAnAXAZ5FX?=
 =?us-ascii?Q?1vDziffZTykVpkqEUWmXUrpVnkNVlf/GN5+1sLzcYegpl3AAltd5LjrgFDdq?=
 =?us-ascii?Q?ZDfaL47c6b3to6Y5VPJ61nFM+12SW6i1MVtfuEwQ9Ur2YLoMBf6PAuNZIg/i?=
 =?us-ascii?Q?Qha58kU7u8ykvg8cDJyPNGarY/gAFz4L9sVXFQmN/yrAyZE0qW4jiMqhkZGl?=
 =?us-ascii?Q?TPHfqEmG1Q4mjUENJ2LBStJvRXJPF+Rkt2hj94hsE8ex3gVwOl9AVko3Fygq?=
 =?us-ascii?Q?RuM6FCHd7rRAuLfdFD+8X9VOuMye/W7ZOFZwsiNTqTlsQ1MtmqTaFJUNWUm6?=
 =?us-ascii?Q?MUBefkfH+PR/1/X1Q75zyxgskflQaJV6co8uo6T+svh53IAIdyFor1hJWCTD?=
 =?us-ascii?Q?0DhoIy7Uki6hDoepRuAsCcdLQUBMtKuzqJTA3bih5Aw++8hy7YqZQ/zFIkzM?=
 =?us-ascii?Q?dq6/+ImPaA1S39jBj8O83BFrhVs2sKp+v4PDgDt8NPGU39/EBhR0nnuMfE0h?=
 =?us-ascii?Q?Ptb0OVmi4Alr8p/ByrDEfdfabTLEnY9WEzzOdAlQ0hScRnXD5NVsZZoe6zGK?=
 =?us-ascii?Q?UjZWxLPJh6ueC6mHXThrmFIqA5P2t86o4DcsvIJIpT/OJQccK3a7khoINnwI?=
 =?us-ascii?Q?Dx7X01HhbS4MXmUlrZGm+FZmCeckVC6KiVjdf72qPMMy5Nb5pEycB8pMtz75?=
 =?us-ascii?Q?dYGMpETcZXd/+WW4KEguPNoxvfE6v7qupJfg3QeClF22r6aXAQJVDQxA0Sr/?=
 =?us-ascii?Q?bcfHlfa2v5Gmy6+D/lBJ9V8XAHLdiiRraDT0hduMtOT7ME7kAT1G4RTvHCAw?=
 =?us-ascii?Q?wHTTE/jnraqRoGpcxVrZd5akpzfWgQVpx8SkMUa6/VlugioaB/pCETPu5yq6?=
 =?us-ascii?Q?gj5v5cMsxK0HTQr7sXWfgrx3JqAJ1OOSrH82fWXLdE36TjZoOYNLwEPOk6XM?=
 =?us-ascii?Q?9FawUUbb0Jq4t7MQ1bdFHKRny2fyxEuz16P0jcy41jx1NrxaqraYCxOXQe3E?=
 =?us-ascii?Q?UPEOzfshajAj11gnGS8EDmBdjvYJA0oY8ClpbVwtvpxa8jQFc+1h/6oYvhGa?=
 =?us-ascii?Q?UeLdQX3szG52wAIRCoz0BxgLnuOzqB9h0ZMG8BOkN4ugJIxUqJVsTyhgRXdL?=
 =?us-ascii?Q?SYPWiyoD+Si/oQ7cuNxxWFtTkT53YvCRdEi4lzfsAVCP5t7xdVNOeO14j7j/?=
 =?us-ascii?Q?Kcf8uNtkBDlnB6ynSZgqX7l15xT8m7BQhQ8YoDqrXx/GN91GjyNwdgRgCu+c?=
 =?us-ascii?Q?J/artSLZ0YlRNkmlkOJVxVRK0IBHY3Na6H5wxpRzXdwRz0m6GpbCINuVnNe8?=
 =?us-ascii?Q?xD+jKorLOgD/CQ7LrjlVHSdj2IJ8w8PAeJomazHc2vSqN/BFl56K/qcL9NVb?=
 =?us-ascii?Q?xM7bHrvt2xO0TWhVhpV3nJ7NFLkdhOO7V7nPZH/Vrke0ZN1rrpQm1onfMTrG?=
 =?us-ascii?Q?lw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f1560f3-5445-4d6a-a73d-08da9d4a6cea
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 10:00:22.4303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ze8p8LE4RIrW7hqZtTnSDoQv7jxhggDvj+6KlmB3pHXbdg7pwamQiW6Hx5f/U5JuIENhP3k0cHIRdSUFtXr0z+JgoYJ+K8Edp8i/ld7Qs28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4187
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_02,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=609 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209230065
X-Proofpoint-GUID: x1EbsaaCAG3ncoRMTqBmmhl6fktA6eRU
X-Proofpoint-ORIG-GUID: x1EbsaaCAG3ncoRMTqBmmhl6fktA6eRU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 05:47:51PM -0700, Joe Perches wrote:
> On Thu, 2022-09-22 at 17:38 -0700, Randy Dunlap wrote:
> > it appears that the NTFS3 maintainer is MIA again. :(
> 
> (I've no affiliation with the NTFS3 maintainer or paragon)
> 
> Perhaps the expectation of prioritized immediate turnaround is unrealistic.
> 
> It's free.  Be patient.

It's not just Randy.  There are a bunch of fixes which are waiting to be
merged...

I sometimes look at syzkaller patches but it's like with ntfs3 why even
bother because the maintainer is gone?  It's not going in anyway.

regards,
dan carpenter

