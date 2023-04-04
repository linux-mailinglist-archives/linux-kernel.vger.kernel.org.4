Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF236D6B31
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbjDDSFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236183AbjDDSEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:04:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D723255AD
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 11:04:37 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334Dx1S8026157;
        Tue, 4 Apr 2023 18:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=Z39c7i32oLUZ4ubge8eBGitLtIahF77IQjSiLkcr4yY=;
 b=nBojjIkI5e3rTpVf2pOigLhsjo0ye0nuox2CBT2U/Mp3pUu6bc6nJrk0qwIdgbhYp4Ne
 uWr3RLYR9oAMtAeCaGeTlFFYTkkfBkcV0TBAY2QFK2d4Fg3VHrgrO70jU0vR2L/WOsnE
 vpo6KJMBfR1SahWaB9Dhql271I+45C0scsSVO+rkWrYzhMMKVDoNI2RENT3WFFdICsFw
 E0FsJTJw3Psjxinofcnzi7H1U1AsJlepAkFCcILewbdxporLMldDn4sK4j+Mi39ssZH4
 NeMLGqt7b8c5XeZBdANDOW5BRGPyO8DO5sKazQjZBS4uemPyJDWYmccIsWruUDFcjRpY QQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppbd3xj2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Apr 2023 18:04:12 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 334GUh8N027788;
        Tue, 4 Apr 2023 18:04:11 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptuq7tbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Apr 2023 18:04:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b12+mN5GQ6eZ9bVZZXqKtGhjkYEjnK1YlXWdjLVIJ1NHr3kiO9IIUG1bMb9YcIO7PSYRB+6yOOxWuGNpMeiCvL+c0PhZSqy+qkXqqb+qLpXuDj8pztcfljd7xQspKac+0aEYyJlofp+aqKJLAVnHJ3xf8MORPnJgieIpxi5ygd+WDbcvdg7OHDFVcvFxHeM0OXvKWaVfznLc6g3ApaQ0WPd2TuE0k2YF1pjBJLd1iDASr9S6MK7QjiZeqybVn8gTdd/apsOLVd/SuSZd7N8olixI+39Fe7NlPyp4DKl7Lt5qEwyzHnObq070KBBVGzDSd5cq5FqxYgA4IS40jeOLYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z39c7i32oLUZ4ubge8eBGitLtIahF77IQjSiLkcr4yY=;
 b=CwXsZNcGlcmClwHDXkcINPlzwTNT4C3WRc1IXqQr1fT0wgZhmf5UeNJgizwkC/L2ZqHzM7eZFgkacFfYOEf/rfgXLLoXEh5SVmPC1+0oUEsKjcnMGXi1dh+pDrfbaTTPktsFX3A/+6+MprlZWwLmZTvAruu0DGAtQSdrpJDLHlMrQK3hwpD6m9WjwXwGiIbcUkZS8aEEfrI9fktNDjp+TmatGKz0imT/iH8I8ri+lg3NHD9UXu3PWsgyRa6cstUCs8mxa8pGiQZ8iEC4dJZmTbTPvsRDi0Q6ipPNQ5ZKKA+UTE4SbEZXKWieqH7GxY+MQMrPcy/3Cdyh1hMAdNBjPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z39c7i32oLUZ4ubge8eBGitLtIahF77IQjSiLkcr4yY=;
 b=KmEvMF+nbl7UkUptPzc6ibThTDoXpDx/+E2ABiYcSWgDh1pqu4qy6aP1QKJ9Th3tlOMcaP6Sv41ixYMI/9hvWrw78KISrl59sn0uuY1N7tbIvU4vlLyq+VbBSXE60ctsZx/lgH/q5HeAEewAYWpmOnN1PxZUQ7BP3zG7CclYZpM=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MN0PR10MB5909.namprd10.prod.outlook.com (2603:10b6:208:3cf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 18:04:08 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e9ed:8782:64cb:cfc3]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e9ed:8782:64cb:cfc3%9]) with mapi id 15.20.6254.028; Tue, 4 Apr 2023
 18:04:08 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v21 5/7] x86/crash: add x86 crash hotplug support
Date:   Tue,  4 Apr 2023 14:03:24 -0400
Message-Id: <20230404180326.6890-6-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230404180326.6890-1-eric.devolder@oracle.com>
References: <20230404180326.6890-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DU2PR04CA0025.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::30) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|MN0PR10MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f1f1b92-efc6-4e75-b3da-08db3536fc68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gq2cyFsODIccuTYLlq8V5z1F8SIkjTTCNrM98Vu5CFIGPxVpErzunAIBZo2ipmpuesTXCNgyRIOJwjKYaLpsAX6T9OqqDkutRiBpUTDlPpz31hMPSPYTdijoIPqwRY3czs3mp2xDcal+0vWfTaouhMUT+AvjgVfWOoOzuptIiuak14g2bm/bGADPCEuPSzQP9O3TXJRpOtoWptZx6hY8GBU3JqT4u8MSmkzTCObUUIUIOIqOiUXzVLia9Ue7UNEehNx1IvRxHpql0WoTNaohHVZ5aMiFoX51DbdqWVNjrTsy14YbbjUnpAymyrn8b5UGjCVXfNPaZLLgQDQmenS5hIaToBsO5roNLUb1qvE83D69fdU6/GmhjsIRHCkixLG5lTPemmcNVydLUXfIewDDn4kanXDvZ8D9hryGu3McnlUbVMMMd23RMoRfzNaFZVoBabVAvIIxLx+n8fYYcRxYIm8a2Zghtib55CT28Vmbra2867NIXdWK4uKrotln+02tJ3tWzvJ6PH79IFi5xLsB8kkgz7g2i9YlAPyB0me0tYyXN9H/9scHjOQU93v7FA8C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199021)(83380400001)(4326008)(8676002)(66946007)(316002)(66556008)(66476007)(86362001)(2906002)(41300700001)(478600001)(36756003)(38100700002)(2616005)(8936002)(6486002)(5660300002)(6512007)(7416002)(186003)(107886003)(6666004)(26005)(6506007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9zhThoEzX50mrXAAYYPt1mMD0AYhzGTY0A15y2tgoNDOxPvFKgO/jBtLzqGB?=
 =?us-ascii?Q?7k5dbZPyw2STcXgmhB2dhAd2nOk3bUBcASuEesm3P+00HLOzIHfA8BBfmawS?=
 =?us-ascii?Q?j2orENq5MEtHRZDNWFmupMCkV2kHX9VOhXfe5P2GAn8vyCalSzeishOcmc3x?=
 =?us-ascii?Q?RdgASGd/1d0Y4k4LvryNnI4tLr6wmtl0h2weJLNNKzPX5xDqu6TmDCrmIEat?=
 =?us-ascii?Q?p/e7svgOUpZNFvHueZJzMCTp3GKunP3VHd0cRTWedL8cOlrvTj3J7RqraQ1g?=
 =?us-ascii?Q?cC8luJBCh4oJINOQvBulYTMIBack6QTky6kqc/eMwUhb3h1VkFqxSwbvWpMP?=
 =?us-ascii?Q?+oE9cXowiil7+qln5xHjyRDFZx6q3h64WCvXyKV8VCZC/mZPPDcKlMq6Q5n4?=
 =?us-ascii?Q?3ua/zda7cAuF7/KsTkM2RY8gnxTDrGuJAARxYqLAihL5IUMcCJOG7yb1c7vu?=
 =?us-ascii?Q?thkOjzSgz4H1YHTUeekzB5eUdl7ff2tQAfOQ+Ais5AuXr6/m8Dxkq6WZlPBs?=
 =?us-ascii?Q?ITdpRFzITrv5ofNTEk3veO3egu6n6mp6sEgF2B5Anxsu2Kru4PxQrcy7YECW?=
 =?us-ascii?Q?PiOYaci3jsRem8k12uQl9RG+TEndZKBvAo18oHCcsoUazSKHAgZt9yaAqPFh?=
 =?us-ascii?Q?wxvpbkQhhR0YHQnJGjgPB7+iZTQTjze3VJ5+59b++FOXc8aSib4jdoVCEzuR?=
 =?us-ascii?Q?cyw3MKoNyWFvkiGMAo9ATat7NRwzuRjUiNtIyamIIyDrt/nipEyN0iIUvAo6?=
 =?us-ascii?Q?0BlnpKEHn7MiK0j57KPi+EGDBghbZ1vtZHR+zZs31weluBWSNLFgGZDP1Ka+?=
 =?us-ascii?Q?hZ+1qriail7D8f7MMHkP1519c2fWIx1hoYdCIvY7TjDV3nJd11o0OkNAZO/w?=
 =?us-ascii?Q?VrrlzrofTG2aA3lkzMFrNMrKexbDmujC2W1oRJCBDIGcHV8LKCzSZowjmeQX?=
 =?us-ascii?Q?OLYvGO0wLGY50xDmlz29Z7zT/OnQvnuCVFC7yjwx6YvDqf5M0X3HIl8FLVwP?=
 =?us-ascii?Q?53ILg4jSTCkwqASa5ka9WewzQ9iNzvR4Pfd1lhcW+ffqEsA3/2YRvFoZkSrG?=
 =?us-ascii?Q?KXF+lkySEYMBqeFOHdMqCxcsF0u9i/VEVAJHli0lOv4PP8msmfCT1S8V6QD4?=
 =?us-ascii?Q?0Kk6saQhj6jtFBQPmYp61GlJeguWE6p4mdeXquOuw4MRLp+RKoCjODd3lIBN?=
 =?us-ascii?Q?3/bNMaIx0Xo8dvA8W8ZUM7qFvLmQWJpiJt12empZVanjfQriEV/8EGpJfGXS?=
 =?us-ascii?Q?JAeqUlfggNha4lGSOk7K9PM2N0zh27PJby2vvgGMwHW2BZVdEVs/6ti8iK90?=
 =?us-ascii?Q?ZYPbFYnx5xESVh+XAKZrVp2QK/oMZA29Gsv5GYWbO60zLf/9TedunY5TcTDN?=
 =?us-ascii?Q?JgMbJ6JmfczmZZiEpqghvxlEwLaKJpEklHc+j2LBWc8CEPYUrup9/VW0Ky5j?=
 =?us-ascii?Q?uFq/MT92Juqw1mLp6zoJMfxNTFSeqNIaV53UiSWkrKDSp+FY7hjAFkw2XeyA?=
 =?us-ascii?Q?Ell0oVaGs3wz1GTxE5il0BDzLHA7fUAPN7xWXOC3vt3+WKaiHJJBNAXVJdsD?=
 =?us-ascii?Q?HIJT2BFsjgpj75h8Hf5eLp6QfdY2QfCmErWsc5MP95IyxQCnLrEIcGYsjGdu?=
 =?us-ascii?Q?KQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?EAltGo9rf5jsH79afAy8gOp3GCJ0fOVyzusaq7BLXzSO/jGcSzthDuJIDGwk?=
 =?us-ascii?Q?Jt6S5IU8VmkNRCKlL0IOiV1+yJ0f6lRmo/8m1qyI4b+WsGPF8pEyblb0YqCN?=
 =?us-ascii?Q?6Vg+mvj+PS2Vi6nDeTPNXj9oe4CD47qe+fjCwZgDmyIpIUwEXZcIs5wsRRGn?=
 =?us-ascii?Q?U/typ6IUelsX4Age29/ol8Hu/k5yIRqa0YN9kwtKIggBz83Sw5xrjAVDvfHP?=
 =?us-ascii?Q?ekWRYrE3gjUAjwkl7ZMFCn3OmyClxa0tv14S2LpckkiWcxu/n8jsoGvS1T29?=
 =?us-ascii?Q?6AgF1mVhLlGNH9j/PYNd/DoeM1iSsbpOzcO/1CPV4IubzIU6F0C6AmJ1uPNH?=
 =?us-ascii?Q?/eB89kYSBM+N/5xOpUyUrIDblfge6sY7cnZ/SCZiygR2bwtFAzbfW2O6DmUY?=
 =?us-ascii?Q?/k8Woe9WfrV6CQqEOApKQ0NlZBKDVLUwx4hIxZ88J7qs+VS2Vdh91Y8p+d2g?=
 =?us-ascii?Q?zURrXwQ3ZiZRFUlpXfUPYdCsYHvZXZMkiT6kwTEokXeBJmc5h7ww+Obv4EAM?=
 =?us-ascii?Q?sSNQ75xiarqLhDF9KGxObyU0CIO+02gCZs1/S0O2I1/b604KxMernq8YvLwx?=
 =?us-ascii?Q?F+3R7yNWCGS3dZS6JOOUzE22/FHm9/NjVHp6wikjM2VFM50c2nnRebO6BcO0?=
 =?us-ascii?Q?8OcgRy0u0gVVwYVfFS83KpHCLGBMviIp+r/MM4OQQ749YRNhS4qmTVeDAlMt?=
 =?us-ascii?Q?QdbYWbJ9YCWehsqsjV5ikegCZ3ZLBISuws+uowFwbCDlXbdehr9Ko1lgZTvj?=
 =?us-ascii?Q?ol5tZStugiNr/l826yP59zGRq3KXmAZYX1ac81H8AC1JRPVNzU88u5Ma8LYJ?=
 =?us-ascii?Q?kOo+3ngg7ec78mZQj9URz88IL6CaF8y/my+JhwhI0XUfvvr+bBS70kTcc0DK?=
 =?us-ascii?Q?r2oAU4nKzv1DbQBooRZhUzSKYgPyTB//jQHWPz+2vmIV8HwvOED4qUhZ1s0I?=
 =?us-ascii?Q?ORMeStCFgge7W4VZkNNl/uE8jbFPTawMp9tWU+T/ER7inEBFodx8R/eZSsSB?=
 =?us-ascii?Q?wVrZvq8+F4mqfmd27t1H2+qBr+Y/RvX+cv9XAfRl/Iwg/CQXIh5/ySLdfNY4?=
 =?us-ascii?Q?zGy1QJVMuWGwc3wRasVw4dUEnMuqHFOgm+Vj6F8bAEAmVz8bZ+5PlSxUZO3a?=
 =?us-ascii?Q?CgasmM3ugzZkkG1Qj0pY7ytA1W2RpF0ni6eUpSP7228JX8Mp3Ob9yEc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f1f1b92-efc6-4e75-b3da-08db3536fc68
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 18:04:08.5714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gF4zbMo4VkX03I9b55motIjGwWGcVVgiUwYQfrMdRc1AiT+C9fmcb5M8a0wtsowsJxGB+18Wf3PPNw3izBfVvmn2HVqPOTm2SYv10gfOoMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5909
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_09,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304040165
X-Proofpoint-ORIG-GUID: zO5C3TGrhbp9RWu0k5n4UYtXb1oeXA4e
X-Proofpoint-GUID: zO5C3TGrhbp9RWu0k5n4UYtXb1oeXA4e
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CPU or memory is hot un/plugged, or off/onlined, the crash
elfcorehdr, which describes the CPUs and memory in the system,
must also be updated.

The segment containing the elfcorehdr is identified at run-time
in crash_core:crash_handle_hotplug_event(), which works for both
the kexec_load() and kexec_file_load() syscalls. A new elfcorehdr
is generated from the available CPUs and memory into a buffer,
and then installed over the top of the existing elfcorehdr.

In the patch 'kexec: exclude elfcorehdr from the segment digest'
the need to update purgatory due to the change in elfcorehdr was
eliminated.  As a result, no changes to purgatory or boot_params
(as the elfcorehdr= kernel command line parameter pointer
remains unchanged and correct) are needed, just elfcorehdr.

To accommodate a growing number of resources via hotplug, the
elfcorehdr segment must be sufficiently large enough to accommodate
changes, see the CRASH_MAX_MEMORY_RANGES description. This is used
only on the kexec_file_load() syscall; for kexec_load() userspace
will need to size the segment similarly.

To accommodate kexec_load() syscall in the absence of
kexec_file_load() syscall support, and with CONFIG_CRASH_HOTPLUG
enabled, it is necessary to move prepare_elf_headers() and
dependents outside of CONFIG_KEXEC_FILE.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/x86/Kconfig             |  13 ++++
 arch/x86/include/asm/kexec.h |  15 +++++
 arch/x86/kernel/crash.c      | 119 ++++++++++++++++++++++++++++++++---
 3 files changed, 140 insertions(+), 7 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a825bf031f49..316fdaa9a68e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2119,6 +2119,19 @@ config CRASH_DUMP
 	  (CONFIG_RELOCATABLE=y).
 	  For more details see Documentation/admin-guide/kdump/kdump.rst
 
+config CRASH_HOTPLUG
+	bool "Update the crash elfcorehdr on system configuration changes"
+	default y
+	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG)
+	help
+	  Enable direct update to the crash elfcorehdr (which contains
+	  the list of CPUs and memory regions to be dumped upon a crash)
+	  in response to hot plug/unplug or online/offline of CPUs or
+	  memory. This is a much more advanced approach than userspace
+	  attempting that.
+
+	  If unsure, say Y.
+
 config KEXEC_JUMP
 	bool "kexec jump"
 	depends on KEXEC && HIBERNATION
diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index a3760ca796aa..1bc852ce347d 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -212,6 +212,21 @@ typedef void crash_vmclear_fn(void);
 extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
 extern void kdump_nmi_shootdown_cpus(void);
 
+#ifdef CONFIG_CRASH_HOTPLUG
+void arch_crash_handle_hotplug_event(struct kimage *image);
+#define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
+
+#ifdef CONFIG_HOTPLUG_CPU
+static inline int crash_hotplug_cpu_support(void) { return 1; }
+#define crash_hotplug_cpu_support crash_hotplug_cpu_support
+#endif
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+static inline int crash_hotplug_memory_support(void) { return 1; }
+#define crash_hotplug_memory_support crash_hotplug_memory_support
+#endif
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_KEXEC_H */
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index cdd92ab43cda..0c9d496cf7ce 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -41,6 +41,21 @@
 #include <asm/crash.h>
 #include <asm/cmdline.h>
 
+/*
+ * For the kexec_file_load() syscall path, specify the maximum number of
+ * memory regions that the elfcorehdr buffer/segment can accommodate.
+ * These regions are obtained via walk_system_ram_res(); eg. the
+ * 'System RAM' entries in /proc/iomem.
+ * This value is combined with NR_CPUS_DEFAULT and multiplied by
+ * sizeof(Elf64_Phdr) to determine the final elfcorehdr memory buffer/
+ * segment size.
+ * The value 8192, for example, covers a (sparsely populated) 1TiB system
+ * consisting of 128MiB memblocks, while resulting in an elfcorehdr
+ * memory buffer/segment size under 1MiB. This represents a sane choice
+ * to accommodate both baremetal and virtual machine configurations.
+ */
+#define CRASH_MAX_MEMORY_RANGES 8192
+
 /* Used while preparing memory map entries for second kernel */
 struct crash_memmap_data {
 	struct boot_params *params;
@@ -158,8 +173,6 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 	crash_save_cpu(regs, safe_smp_processor_id());
 }
 
-#ifdef CONFIG_KEXEC_FILE
-
 static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
 {
 	unsigned int *nr_ranges = arg;
@@ -231,7 +244,7 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
 
 /* Prepare elf headers. Return addr and size */
 static int prepare_elf_headers(struct kimage *image, void **addr,
-					unsigned long *sz)
+					unsigned long *sz, unsigned long *nr_mem_ranges)
 {
 	struct crash_mem *cmem;
 	int ret;
@@ -249,6 +262,9 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 	if (ret)
 		goto out;
 
+	/* Return the computed number of memory ranges, for hotplug usage */
+	*nr_mem_ranges = cmem->nr_ranges;
+
 	/* By default prepare 64bit headers */
 	ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
 
@@ -257,6 +273,7 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 	return ret;
 }
 
+#ifdef CONFIG_KEXEC_FILE
 static int add_e820_entry(struct boot_params *params, struct e820_entry *entry)
 {
 	unsigned int nr_e820_entries;
@@ -371,18 +388,42 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 int crash_load_segments(struct kimage *image)
 {
 	int ret;
+	unsigned long pnum = 0;
 	struct kexec_buf kbuf = { .image = image, .buf_min = 0,
 				  .buf_max = ULONG_MAX, .top_down = false };
 
 	/* Prepare elf headers and add a segment */
-	ret = prepare_elf_headers(image, &kbuf.buffer, &kbuf.bufsz);
+	ret = prepare_elf_headers(image, &kbuf.buffer, &kbuf.bufsz, &pnum);
 	if (ret)
 		return ret;
 
-	image->elf_headers = kbuf.buffer;
-	image->elf_headers_sz = kbuf.bufsz;
+	image->elf_headers	= kbuf.buffer;
+	image->elf_headers_sz	= kbuf.bufsz;
+	kbuf.memsz		= kbuf.bufsz;
+
+#ifdef CONFIG_CRASH_HOTPLUG
+	/*
+	 * Ensure the elfcorehdr segment large enough for hotplug changes.
+	 * Account for VMCOREINFO and kernel_map and maximum CPUs.
+	 */
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		pnum = 2 + CONFIG_NR_CPUS_DEFAULT + CRASH_MAX_MEMORY_RANGES;
+	else
+		pnum += 2 + CONFIG_NR_CPUS_DEFAULT;
+
+	if (pnum < (unsigned long)PN_XNUM) {
+		kbuf.memsz = pnum * sizeof(Elf64_Phdr);
+		kbuf.memsz += sizeof(Elf64_Ehdr);
+
+		image->elfcorehdr_index = image->nr_segments;
+
+		/* Mark as usable to crash kernel, else crash kernel fails on boot */
+		image->elf_headers_sz = kbuf.memsz;
+	} else {
+		pr_err("number of Phdrs %lu exceeds max\n", pnum);
+	}
+#endif
 
-	kbuf.memsz = kbuf.bufsz;
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	ret = kexec_add_buffer(&kbuf);
@@ -395,3 +436,67 @@ int crash_load_segments(struct kimage *image)
 	return ret;
 }
 #endif /* CONFIG_KEXEC_FILE */
+
+#ifdef CONFIG_CRASH_HOTPLUG
+
+#undef pr_fmt
+#define pr_fmt(fmt) "crash hp: " fmt
+
+/**
+ * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
+ * @image: the active struct kimage
+ *
+ * The new elfcorehdr is prepared in a kernel buffer, and then it is
+ * written on top of the existing/old elfcorehdr.
+ */
+void arch_crash_handle_hotplug_event(struct kimage *image)
+{
+	void *elfbuf = NULL, *old_elfcorehdr;
+	unsigned long nr_mem_ranges;
+	unsigned long mem, memsz;
+	unsigned long elfsz = 0;
+
+	/*
+	 * Create the new elfcorehdr reflecting the changes to CPU and/or
+	 * memory resources.
+	 */
+	if (prepare_elf_headers(image, &elfbuf, &elfsz, &nr_mem_ranges)) {
+		pr_err("unable to prepare elfcore headers");
+		goto out;
+	}
+
+	/*
+	 * Obtain address and size of the elfcorehdr segment, and
+	 * check it against the new elfcorehdr buffer.
+	 */
+	mem = image->segment[image->elfcorehdr_index].mem;
+	memsz = image->segment[image->elfcorehdr_index].memsz;
+	if (elfsz > memsz) {
+		pr_err("update elfcorehdr elfsz %lu > memsz %lu",
+			elfsz, memsz);
+		goto out;
+	}
+
+	/*
+	 * Copy new elfcorehdr over the old elfcorehdr at destination.
+	 */
+	old_elfcorehdr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
+	if (!old_elfcorehdr) {
+		pr_err("updating elfcorehdr failed\n");
+		goto out;
+	}
+
+	/*
+	 * Temporarily invalidate the crash image while the
+	 * elfcorehdr is updated.
+	 */
+	xchg(&kexec_crash_image, NULL);
+	memcpy_flushcache(old_elfcorehdr, elfbuf, elfsz);
+	xchg(&kexec_crash_image, image);
+	kunmap_local(old_elfcorehdr);
+	pr_debug("updated elfcorehdr\n");
+
+out:
+	vfree(elfbuf);
+}
+#endif
-- 
2.31.1

