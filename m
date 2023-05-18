Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFD67076C9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 02:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjERAKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 20:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjERAJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 20:09:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF503C0A
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 17:09:43 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HIGr1D002400;
        Thu, 18 May 2023 00:09:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=PhpC8EXi0zsBMVs/1eZD7yKIM3czs4j4W93q4eWpuhk=;
 b=z0YeYWKxd+fLtaOorV0FEN3rg+YbLC77azH9ygZ/i9ZcdEyiJZSFxaGvv2SRIX5Lu5kQ
 +lDcut2ye8gUkDzCvxZxUeE60LeIDImRNGnGhWqJLWzFrdWhhEfszvL3+WTOsMQBhVKv
 bsrX0TbY2gcfhE4HqDIKfX5yY4euAZRRlvK4z3Bw4e8wuj/pfd2VVw/5sYLbznuG/oC8
 KIIOPEnj2RpM6UCc4Z0ulTlFr3m/PMHEe9+UnOwt4XBDPFY/ZXLKVf2acLmNLeZ1EnQS
 CfEeFc/jga4eE9K1QpFxZdDL2fnywv0SGGgBT0ptcZ0ChYEyH5eYBmxKC/JjA1UakH1t 0w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxps1dr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 00:09:29 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34HLRZr4036369;
        Thu, 18 May 2023 00:09:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qmm033xjp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 00:09:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZqYrX4z2LWPVM1Tq/pzrOMwEB2pq5mqrWBlo62rKA4TEZaBXFp2H9X15rfgMNDJ6pBLZ8gNoV6C4J9A2GOPk7MywjpZK5KsxUxkoCQ82Z6pnvSZwHBuHB/8gRigJKMB4nfU4GlLfxN46rZqqe72Amzy6nrYdTY5vAEY5M3+q06XYo/+4KaOXF77jn8sShG9zmTSBnKHIVyH4XqFlWLu3rH+mSsmq4Iq4w9L2mYtz7qt23051yktTF9lrtG97d45WVoZC1VvU8UjpcJgMdwBGf90c5AP1g7B+8OHGOjct4gTTe4QEasyEF8q8p1iOElcC38kAeGTsXwiQLou+NvTzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhpC8EXi0zsBMVs/1eZD7yKIM3czs4j4W93q4eWpuhk=;
 b=C0L/uVnV5k11hAZyZezPkcJkVg9iVj8Grb/ME/EFwcG3mu4G2HOnbmF1L1Kl9SOrrpI7mXwd3oFOxsQ5zpJ6kYUEasVvUCODb5eTaC+6TgasJAd5av7AEEuZ3Zlrr05DaPXE7u0/Fs3KizAyFQ6VkUHjdph9SHPI7VSvxiwsA3BDqHKjGxEQRXZjedpvUBreIrmHWvmja0oWbiC9NciCDeUu8nK2j+jEvntXyNe9V/mFF1P8e/w0Sxq+QQ8iZoKfFoHv5+eFw5AAuq0udG93rYuUsYj1OEF/Hyov+RrV0RoJuN/ErXn2dAKw43CmDAbgy7h3NIQfez6tJy0g71WyoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhpC8EXi0zsBMVs/1eZD7yKIM3czs4j4W93q4eWpuhk=;
 b=vUgXidcXXTg3PKP5IudLG+cvzMkwnuv6Xf9EQghj1HKgC18jmxz9+ccOr+UdGry1y2Db32GuLgDigZpIRTdd8jXoJvHSHrzkaLjErAGOLUDkibQ/5mUZdxIxFOUhz7qxt6TTfYs9gFloEMScIPNcsbA9lfT7gDSyxpaIJ1ioVoI=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by BLAPR10MB5332.namprd10.prod.outlook.com (2603:10b6:208:30d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 00:09:26 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 00:09:26 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     oleg@redhat.com, linux@leemhuis.info, nicolas.dichtel@6wind.com,
        axboe@kernel.dk, ebiederm@xmission.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [RFC PATCH 2/8] vhost/vhost_task: Hook vhost layer into signal handler
Date:   Wed, 17 May 2023 19:09:14 -0500
Message-Id: <20230518000920.191583-3-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518000920.191583-1-michael.christie@oracle.com>
References: <20230518000920.191583-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0318.namprd03.prod.outlook.com
 (2603:10b6:8:2b::32) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|BLAPR10MB5332:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f2807d5-76ad-49b0-e093-08db57342470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 43K6/jzw5L2/10HthorPViZX01+zxG0U1yEKgxLHk49GcdVkA6/O4rMBqMpCfr2hFx62mNljEBp0FPkPejDxchB86zkYGVGsQ7UM3mmF4BLdDSZizgSpsncoBcsXHWz1qfbTj+E0um9JLEwLNIFpxkYL0T8sE+94Gimrn/iVwrWXRLLeH0ZWtx+lSh+XJp6bBJg7bbePl1zo+SH4Ujg1LcWrysvzjREwFA+EnqZH8nTj9/GqvLnwbL7BgBOnRlwT8IEOyVYQMYffXXa/4GTXDZsAoIyI/a8vbsSO4SDEgeTGT4F+g+LKf+vyn03kdefLAVExuZ208f4kC+fxXpfFVAUIc8iV6Ax04Xvo/Y13q2Wa31iI4VKXslavPt5JJdm8jq6lnH829OB7MdhviSjQQxEzz/9sZt+9kbbvchJvFWb3IvFcs+Sovf+VqIRcj7fNREQS/iopmpgSV81FqGEscQJzJCh6+6vDH5T/tTHL2pcHIsLGDfdJpzu0IsS6iqurHQfirqoDuo3Zw8lGBcS3idEzt1XFtcCt3LefONaHIfeap+oIqiVzH75NPFSx30rKjviPydlcikIR/s48y4LHUYgWzqYSv48VggfAAdrbdbs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199021)(4326008)(6666004)(6486002)(107886003)(478600001)(66946007)(66556008)(66476007)(316002)(41300700001)(5660300002)(186003)(1076003)(8676002)(8936002)(26005)(7416002)(6512007)(6506007)(36756003)(83380400001)(2616005)(2906002)(38100700002)(921005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uFJKxYqtRgttXqP+7wcHsOfRS2WEKCABdVA72hd/cX7qqBOxGAAwzYEV+arr?=
 =?us-ascii?Q?WY37CbFlHY/cNMcUi21ybwQXRUUQg2+nJq+3lUTitOblDo6z3TsPcc+COXKM?=
 =?us-ascii?Q?bbom1+nCNxnrKROyP+0T3fqbrYtneDLs8zVFH4u8QU13Oy8CT9G0GxbTa5js?=
 =?us-ascii?Q?/+reWSypByE1qdb8Fb7yhwxLYbkJJ1u4Bz++qL5g8ncraHsC1VDq13MJRL/B?=
 =?us-ascii?Q?xxMZ4yaAZBaMIyDjrIEkfpdp9ttK6giJkZGXmzFQdSNqpNyJl145Tl2PAHWt?=
 =?us-ascii?Q?KUe9R9k3rc1184BW1SCQtgyTGeRQiu5+tWW46HZ3tT/f17LorQy39eqi/0r4?=
 =?us-ascii?Q?IAgjtX7t39F3Ol7+38gXVzoYXxT6UOKfg4uhvwEs2BqG1s1kbYQtc+pvkQeu?=
 =?us-ascii?Q?jl0bceSZyBVWl7drlBmticC/s8D+ufolyPym6enZ/P7+4J2DyJVeyMeOVeXO?=
 =?us-ascii?Q?MxeDvFQ/FgzCchQGlEQiWq55MNwBzyU1nHq1UV6HTdbH+xqpn+zsIJ6bK/8M?=
 =?us-ascii?Q?uz3W4gOlo+vpw0bxB1khxa528/qYDgdAiZLL+zVqOsTWZkIq0U/6eAgGjhM1?=
 =?us-ascii?Q?hLqgWi4xAK1Lu1VBv0nKX42/LB1WeCvkboTc5lPFwIwKBs4YO7ar8otnQDYG?=
 =?us-ascii?Q?NbUSLQZcBQN0/cs9Laczd51L+U2yXfRc2co4jyb2VBm9dbzigIRCJ9PodeF1?=
 =?us-ascii?Q?n2CAiwwEOCD/h5pG0WUb7TDsoaWAvelJ7E4rC8gDgRj10cMu8JDx2anbExSE?=
 =?us-ascii?Q?mklJXr0/+0O3Ei6FP2fvSsQvPIET/dW6HlmBN4xs40yEy5Xh5Ftyn59LE9SX?=
 =?us-ascii?Q?IginS3Gm37qVhr3inFs8Tw/oOx4arvrw8qLx26Tk3bOLdINHKrYPdY2W8NBw?=
 =?us-ascii?Q?MLOyrucE2HTXsU4DExDBvzqBdsFoMThkkjL+7I0ssU4TyaJ+hdUqd4EUVJ+x?=
 =?us-ascii?Q?Zu08frSI2bO4agHeTFBV13GdJ3PYIYOK/UpmtV6o2cBS0ME0cIgKLkkTmcs/?=
 =?us-ascii?Q?84i/KcSnA/XC/fXS8U5BjFmM8rAvn0TRAu6gyPQxbFb1Cvc/om122PjHdD3N?=
 =?us-ascii?Q?jGKeFzKbyv6KXGqpWjlKQj/qdvcuUSYJlczr5f3PoeBH8+HnRsE0ziCHN+NV?=
 =?us-ascii?Q?E3jRqVBibTsqhdUdYS3gIVTTrA7TRGPsVXEGJkacyp1lrBB6uRQk43jc+eCr?=
 =?us-ascii?Q?hIJNRI/g0nsJuI/yI/SBdgoAEC063pwi76kTDAnQBMQbGMmBd0c53gnzOxGf?=
 =?us-ascii?Q?bptAxOU7QomZcmefOXUuu9iUCpP9yMjGgTb9sCBUaVcd0JZJ3mqaKPDXpePX?=
 =?us-ascii?Q?1Jzm5BZg5vAFgiwfVH5x9pJicU0drra6g+gxJmOC7zBqGHvH+nE5YDSRs4ce?=
 =?us-ascii?Q?dHHOfcRwMq9JCCDAHOQ1cEffY8K3m/XnmjaflLC8bFgeoMj7YnNRVaL6uiEF?=
 =?us-ascii?Q?0wHaw5lAD6/eLW4RySB4rwpXLm2+JQnKDRQW1qrrLh0dMPngJmMg9NVdTy8b?=
 =?us-ascii?Q?phy4J12uwmv2WuEH06tDiDLNt+VbvfPw/BXvINZQdg0SIPQuGQyGox6yHiX9?=
 =?us-ascii?Q?9Y0LZOBGk7KiyuglKRb+SsskHh+9zLxOgJoUUGAKfU8PNrtBUt+srtZa2BVl?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?4VuRxPWBY8Ig6KEgCjxcMg5cMmSnglj0wISyn3O4QT/DTDM/OcyIz43eU+cm?=
 =?us-ascii?Q?ZyruMoq9ZA1/+rpXew/nu17LDyGedY7/5hwHnQfJyAuGOK/BJ/EB2rJnas2q?=
 =?us-ascii?Q?97TpgBxXxtxRefiC+Ts6vdW2mKCjOxzr775DysLj9oT1//2WzYtPdCSiScJu?=
 =?us-ascii?Q?+1Y3nUi22x/Ukd/77E3n2zxRWwJYGwS3mzc3/jw9EBS/A24s36/5HwdtbSOI?=
 =?us-ascii?Q?hxUdcuqSN9LG3i7hifZw2/PtjStg2ILrr55nZ3HFKLlGR2yML4CqeLjA2Ezo?=
 =?us-ascii?Q?DeBmeujnNXIk3laSbTv+wW7YcI2QQqPBLunIiS9ybHJddSeH2d4HFWe+Wgeo?=
 =?us-ascii?Q?A+bFj1THWn177V4I9iQJ+Ajp8Ykx9CImeuLkFjdzDb7Fto4J0kdtxiqi1srv?=
 =?us-ascii?Q?i5RuMA56roVUGKendMJZHx/vXdpt4xrRdCWreD797eTRZ1+70NEKjDnwGjos?=
 =?us-ascii?Q?L2RAgmErkiwk8Q8KyEHAkBLkUREK/ngTIEd7YQfMlnf0SxYfvXW0HwbsenuV?=
 =?us-ascii?Q?/1iY/BUT65Fg5438ibopHF3vPEHhB+OQQSog4988e+hxDTQKB4NJYVX/5QXs?=
 =?us-ascii?Q?ci4BX9no3gYqaPsWdM3OD45A7IsmB8fjSdukhilIV7g3qI05fUmossGaCUHB?=
 =?us-ascii?Q?z2nahuFX/bkXmWzQwdiTBptQKGsm4d+blK2qSxzlJD5/iH8ZBY1/VUrhksHQ?=
 =?us-ascii?Q?FkgpzaecEL4jg3cW7Zr1hfCy0fkvWulUZQMK8hJo5ISoTMqC866yxdqpybaR?=
 =?us-ascii?Q?ny2vj2gxDoGKAw+tFZEo93uXsMq+Q+HyYTNAiJetbmBZI1If6lXMqvcPTDTE?=
 =?us-ascii?Q?YLUQmVA+B2kLp9FlChW4UYuYAyYrc7t0j50HsHSzqFdjJD+RMZAWySvXFdWj?=
 =?us-ascii?Q?j277lvpneEj9tvHp9V5obqUGxP2pn/ybFSuRvAhS7rO8X5CFSLrWe9dkHYse?=
 =?us-ascii?Q?gLpM9wWBPeKTelT7z5OgZyaK6XIWoD9P0xlMkNcXcO8aBXNSGhzFpXftWMRz?=
 =?us-ascii?Q?cDp52uNzyPbaMgMMjlfo4CV/hjqTKOmXyAmv9YgGjivrsdLPXlfraEps3HUl?=
 =?us-ascii?Q?Ek0hdaSl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f2807d5-76ad-49b0-e093-08db57342470
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 00:09:26.5598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GKjA9ObVm5Tpd/sOkbN1r91WmLAn/VaccraqRyiqWijebSvcifcY7hiD9wa7L+fP1guPf15x7tsZwrpK2A3NL1/yUh9KiZUBhRQFrYlXKRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5332
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_04,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170199
X-Proofpoint-GUID: oqWMYxPnLLVUUFIMtz5WYJnPj-dBmGxY
X-Proofpoint-ORIG-GUID: oqWMYxPnLLVUUFIMtz5WYJnPj-dBmGxY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch has vhost use get_signal to handle freezing and sort of
handle signals. By the latter I mean that when we get SIGKILL, our
parent will exit and call our file_operatons release function. That will
then stop new work from breing queued and wait for the vhost_task to
handle completions for running IO. We then exit when those are done.

The next patches will then have us work more like io_uring where
we handle the get_signal return value and key off that to cleanup.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c            | 10 +++++++++-
 include/linux/sched/vhost_task.h |  1 +
 kernel/vhost_task.c              | 20 ++++++++++++++++++++
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index a92af08e7864..1ba9e068b2ab 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -349,8 +349,16 @@ static int vhost_worker(void *data)
 		}
 
 		node = llist_del_all(&worker->work_list);
-		if (!node)
+		if (!node) {
 			schedule();
+			/*
+			 * When we get a SIGKILL our release function will
+			 * be called. That will stop new IOs from being queued
+			 * and check for outstanding cmd responses. It will then
+			 * call vhost_task_stop to exit us.
+			 */
+			vhost_task_get_signal();
+		}
 
 		node = llist_reverse_order(node);
 		/* make sure flag is seen after deletion */
diff --git a/include/linux/sched/vhost_task.h b/include/linux/sched/vhost_task.h
index 6123c10b99cf..54b68115eb3b 100644
--- a/include/linux/sched/vhost_task.h
+++ b/include/linux/sched/vhost_task.h
@@ -19,5 +19,6 @@ struct vhost_task *vhost_task_create(int (*fn)(void *), void *arg,
 void vhost_task_start(struct vhost_task *vtsk);
 void vhost_task_stop(struct vhost_task *vtsk);
 bool vhost_task_should_stop(struct vhost_task *vtsk);
+bool vhost_task_get_signal(void);
 
 #endif
diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index b7cbd66f889e..a661cfa32ba3 100644
--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -61,6 +61,26 @@ bool vhost_task_should_stop(struct vhost_task *vtsk)
 }
 EXPORT_SYMBOL_GPL(vhost_task_should_stop);
 
+/**
+ * vhost_task_get_signal - Check if there are pending signals
+ *
+ * Return true if we got SIGKILL.
+ */
+bool vhost_task_get_signal(void)
+{
+	struct ksignal ksig;
+	bool rc;
+
+	if (!signal_pending(current))
+		return false;
+
+	__set_current_state(TASK_RUNNING);
+	rc = get_signal(&ksig);
+	set_current_state(TASK_INTERRUPTIBLE);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(vhost_task_get_signal);
+
 /**
  * vhost_task_create - create a copy of a process to be used by the kernel
  * @fn: thread stack
-- 
2.25.1

