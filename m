Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348726B34A8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 04:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjCJDRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 22:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjCJDRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 22:17:33 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2445FEF25;
        Thu,  9 Mar 2023 19:17:28 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 329LwtYM021575;
        Fri, 10 Mar 2023 03:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=NTS2zXOM11VY7y4ktvyXhfGblo8wAyR/aWfJ8Y7NYrM=;
 b=clBTo7yx3bSS8kCT1ydbDtXgSRk54n6rTL7WL1jhHkU/b58bnkTxKSH03MhwMAKJyndl
 3lp/Ok74dldH77/iSlIW30yG1unEafIgqBUqX9/8xgjhjTj1Cf6hsx9zv2oMsKHkT5sn
 nIt3kbwgIfH/nFXBBsoLxvgDTDUikkIkNS/O1ZqU3uzer4DRtRRNhOl9bmdhhuv8351Q
 ThxGd5zwb7HK0QvSVwV/nf0v5roNb8vxaBguyNYTWSsuobrnUJwHbl8AjHsc2wzJJBvu
 SNz45ZdNHBamkdURl9U9zMnPHBT8cHJyr3dbGP8dyq2WPsA+JpttROz/PdxaiU/kwrra yQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p418146c6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 03:17:18 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32A30nQc021719;
        Fri, 10 Mar 2023 03:17:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p6frb6dpu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 03:17:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtgxISZZDEVS+QKLrh6L5voW2d3MXPkMwSxvJVuzxxt80A0DPjoatnPYu8Do5cq+aolB8sy5RWOtr8UPgap3G2ZIbr1k37hxgXgyO8GfGPicHcDB9ltYQUMl7DXRHvfkAdGG3r9bcKkH+8+KrWOujYn4NfegT+2LiW2miut2CILxSqslyS9xgrxMFfOXK/sRwCUdCynO0I0lFPjHfr9khPxD3uI7Tv+wyEKSbFMWjpFaap5P/3rqvY4oeRPmK6varlR08xVz767MLFSsVfnInrCtgJcn5xJTSXqSTpmdIFiF908GF61mL8iGXZILPdJFVb0f6hoYJKeXxV7jmiYZ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTS2zXOM11VY7y4ktvyXhfGblo8wAyR/aWfJ8Y7NYrM=;
 b=NShDkqLb6+qZulmtCZwhFJiTHz+3Ouuuoi5Y2b28m3tsyZKXXHSdWOpfQrXrcIL+mHhy7GCmNeJ1l74np+5iWid3n4FDK2nskLjTdnw0PB0ZOcTwfZoRSjewaFG2gYKKGSf5FZf5pMoGYcGMqXK8knMxhYxf61Cg9ET/nL+DnpIeOdO3muB35K5kbp9QUFNgjytcMw8yslbZ5sA3y5A99K1b2HkWOjibRqOBe0+Md7wv4hI2pgkGjWttrBCv7O3POUEwUdMmahub3Hotm2g4n4/z3CA9hJVf7soY/A7avNb2BKK/jOb1Q499P+w3dTwgjf+WWbx8r5DaR+xOQrYiVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTS2zXOM11VY7y4ktvyXhfGblo8wAyR/aWfJ8Y7NYrM=;
 b=Ve/jZMoMVhAR1SM9qXlPFPEJOyHlRaKd2Dva69dmPZqjRIvqPlF/5+phlAO0VKmD4pA63ZQdT7J9rwiNqV2TvtUf/N1REgzd9nnhBbnhJGlksL7LrXCdPfQpn1cqnY6C7yw/RW4OzhUSL5NGythaJTASj160RAycQAkCXCLyfks=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ1PR10MB5978.namprd10.prod.outlook.com (2603:10b6:a03:45f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 03:17:15 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2%8]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 03:17:15 +0000
To:     Lee Duncan <lduncan@suse.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Lee Duncan <leeman.duncan@gmail.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Wilck <mwilck@suse.com>, Hannes Reinecke <hare@suse.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH] scsi: core: Add BLIST_NO_ASK_VPD_SIZE for some VDASD
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1o7p170tc.fsf@ca-mkp.ca.oracle.com>
References: <20220928181350.9948-1-leeman.duncan@gmail.com>
        <88927435-ae58-c24b-e7b7-b675985de433@leemhuis.info>
        <86D685F2-D411-460B-A09B-6BE942372F0A@gmail.com>
        <yq1zg8pl1nq.fsf@ca-mkp.ca.oracle.com>
        <f8c5619f-1e1a-f759-6ab6-ea84bba3d635@suse.com>
        <yq1edq0jg2h.fsf@ca-mkp.ca.oracle.com>
        <a4ecf9eb-509a-84a6-8a9f-a3f5ea54ecac@suse.com>
Date:   Thu, 09 Mar 2023 22:17:06 -0500
In-Reply-To: <a4ecf9eb-509a-84a6-8a9f-a3f5ea54ecac@suse.com> (Lee Duncan's
        message of "Wed, 8 Mar 2023 10:41:51 -0800")
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::10) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SJ1PR10MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: a5b6a188-20ae-41e2-b27e-08db2115f2a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NH/QrwP5GlU4nPnuvjebXYyL+qZ4v+qMKJQJUw0ktVwXQ9ryslLJmf1fsAclPESDBnXDVBDgM8g111FfxVNM5yxd4/R4VyN1LF1/V5Bw1O8JhB5pQ4foeN4MeEmlJPZHd6gYNKs15QlKFmCH39gJ4PtVaop1Dg55bMck/Ctq5TsZY5YdWgpFk0solv5KCt6HL1KEzHN/WXe/r+Jd7uBfaIQlO2rP8Z45R3Uqqam3bZxkaP70u90kuQdprtYsYnWU8/3CoHI4Sub75QLvAXXS9DSL3YH9GTIuFUTV90NUWAJr1WoE2g10nxC7D+QZH4Gr3o3zb9HsOFzJTouUSMviuLYdT/qfDYyHDeQPNS5bmWWYZzZfzmvlQ/c4eLmN7dstcMXpmgPtVj07K7v/iOS6W+B5DvoeYHuTFeRFD+PpKVoyH4Hr+f3r6SJnSVaItfUtVag3boU0Rvl8bsLEWU6c1iZCyN8TlAscHqc5gFTl3WZv+iKTNudkDuXhzQg5xYUIISopn64JBd70QrXuVXe2CYP4FEuidbvQSc0jrG8DL0QT0FYQ4JTkWXCniMKezKe9+ZyQ+ERKhJhdsvK1fZ03rj1qFxe63j6Gds2Czrs9mjWtI4Z+UG4nnhOwJk6OZTJi6FuWIC+ylyhi+CvquK737Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199018)(38100700002)(54906003)(478600001)(316002)(6486002)(26005)(6666004)(36916002)(6506007)(6512007)(186003)(8936002)(5660300002)(4744005)(66476007)(66556008)(2906002)(41300700001)(86362001)(66946007)(8676002)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O796x2VhAJbmhUiT/zo3zjBwj+7Tsz+eYCZDt9K4zlwzSDJFRBlcB6fSfbZ+?=
 =?us-ascii?Q?8ESZQR0znSzHrQdqOML/boO3fwJM3K7Ki6BwEk8XhI31jiLROW+qTD8g/9Ms?=
 =?us-ascii?Q?Qkah9y1Vp/qSfaO8RcTQsEMBpe8WldMDNgPl20+TwAIKUB+nxTyNZ9KmS3J0?=
 =?us-ascii?Q?6+cwxeF62K4v/EKGToz0C0lsAcz8jixJLcUWcziUHsDiChJMHiw4t60bWCXk?=
 =?us-ascii?Q?aaOAwg9Z2jBoSDNqV5gK6UPblJlqyBCFdgZ5kbfeNsZNSO7eP8sbztTOT1rw?=
 =?us-ascii?Q?5gNWZht8tg0QSxXiVKYXVH7MUMb0M75SqDb12wXk4MLSvse+A7PyRhtvBJMn?=
 =?us-ascii?Q?SgGK7luZCPi2VlSJaW7BQGcZCORKjLwaVV0lnwUFSD5tDdk1ZfO1OYbsJTr1?=
 =?us-ascii?Q?Whfk6dmByONIFKkiKJWtuKrwwFyztDl8W8VMnBbpO48TQvIXSHhauXjHvZux?=
 =?us-ascii?Q?WUEroVWaRwj3oKbmFbVsHRw8ZUzN2I1r3bkzAxSn06fW+ZZwgM45MhkcR2Fj?=
 =?us-ascii?Q?8SKLjm1CDZkGUJH+Fb3xQNSi06oWNXRkr1gex1Vb7aVjRsju3Lks4q0IqU/z?=
 =?us-ascii?Q?mtLrLUq9oOsNXJ4dEnpKyLAUjct8XxbqUN/1QjR2ED+FFvNy8TXdmsXC5GUq?=
 =?us-ascii?Q?mJj8xkiJ59OMklu4tv4JLiDFtyAiG2azM0G3cGEcK8uzV2VE9okGDvKuUwc0?=
 =?us-ascii?Q?9Gsv3R6+8CQAH6zGpjTf76jIkQ6gvxj9QjKW8DwsiQmyCpNAw6pLbPTwq5Bf?=
 =?us-ascii?Q?jDPG9BK0fwC2jNDeIOxW8AoNNyJ0F2ZMWFlw0MkhMDuVqxXL8jHvYOyrF8FX?=
 =?us-ascii?Q?CnOFEQAoIee5Fq6fH1KxK2DgYwXskKZfQFK300ImRoB9Bq8xQInXuMtm16ai?=
 =?us-ascii?Q?LICAm64IUZ7O2+pmsf26/Fkwz+LrzGBDI96ApVk6xwmOEN5sTeWoR96+SVy/?=
 =?us-ascii?Q?MS8CwdNJsawEDIs239N6DptUQU9MIS5UhFXcAwMjNZHckAXSq+tBgg3BN1RE?=
 =?us-ascii?Q?NW0re45wE9EcvO39RU2swZgF2IE2iBRkpmBnjawLP/KIZE5uivxZ1cbXCCBG?=
 =?us-ascii?Q?NxlJMfWdVOhtL2XGawoaZTh82GcrWOjMG+nLT/24tLlvXIsCaWv60yeGBvts?=
 =?us-ascii?Q?SdpJcmoXPeTfB2xcv1beXGaWLVZLeVTFXY1ognSA8lBcLEjoJvVtr5PzYWxx?=
 =?us-ascii?Q?gtC9qfxrkLDviKLhQUS6kclusXOd5vAfdOCgW3IxQgenO3qGVz3VlROsE+zf?=
 =?us-ascii?Q?LOpAdgz7AS7k/AA4t18v7WNtRs4UA3HhqzBKSd4koN+91n1qc52GfKmvul3c?=
 =?us-ascii?Q?taMtzBtZwG4s6hqfj850XT+NcCzFF6vfCIaoTNQGTdE8yJUXdQ4Z9i2fanlG?=
 =?us-ascii?Q?CMQvqSaNwH92Xtc1IMz3fvobVqQhiRCI1uQgk017kPYMy28Eaz04gAGTadyQ?=
 =?us-ascii?Q?l6uBhhAWpgs/Bb43UgCYRYvMsSylzCOeSk32w5eJFoe18yILmLmyfPABwvnS?=
 =?us-ascii?Q?gZdIR6r8tw1RLOY2Zz3AOzooqE/WAfUzLYYnV2RPA3HXUvD8lEQvH6HDNIsq?=
 =?us-ascii?Q?X6/FVMSeaHvkEvXfVMGM++56wx8hQnE8S9ar23KfBmHB+ObOT1eXzgefLIgV?=
 =?us-ascii?Q?+Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?SG2H9zt94eShoSLTprwOjrXElKneMK4zh84lHdZoMVU6iSfC91ITclJ6rMSw?=
 =?us-ascii?Q?RFEtkMbpqnKi05mHHq9/hijFoheD3AJ8ugnyFveWuYlMUjyosq3EARqnH8Mi?=
 =?us-ascii?Q?K5bBaUBYYyeImnotAZa1sGvUFSBDc/9W9m6gUscZynfzci3b+cU04dg6U/XG?=
 =?us-ascii?Q?wKKh5UvWMD9NzGtSdJcQs84tCYA3CaKJ3SMF9pasqj3NUSHV5Z4SBVA0mvBG?=
 =?us-ascii?Q?9ore6AMQBVvPV9yCCtmsnSGbgcMONcizH/NfOoNRYzCuzFkeezN5RX9Bf7fP?=
 =?us-ascii?Q?W3SuThIWoxFtZ85GXMt3SdoLV2vCFlQeYregppeHu581Hc8EVG35p3tAOBy8?=
 =?us-ascii?Q?wCtc+OGbn9pq4a/SqpOgHZ3TTSjV3CDClnTir2aEJOEdGzcoWjQHKv7FHbij?=
 =?us-ascii?Q?Jqi6NqnOG/9JF3TqCcp9/zNI5kELbC4cm4aGDb4Ay4/ICcK9OvnL4imkmZDf?=
 =?us-ascii?Q?+b/spgtkb0SmFHVLzYFUsO3FKtE5QConLP8sAlORouQ41lbzl3Tv0GTOtsCI?=
 =?us-ascii?Q?RvkLevQdGWU2UqYvyXrjCR47uByOH2pJt3voipfMFRPmVvY6SX84BlDrHAkU?=
 =?us-ascii?Q?Ojn5TyTiCWC6Dwkk60G134OHwhAXlJnXFegcFE4COrkYQUQ6T+OcczDXMuct?=
 =?us-ascii?Q?S3yDegw8fOeCdxzXDZuSnFNiKv6n2reIkiax4IBtl+99z722CeXoMUudOjKr?=
 =?us-ascii?Q?CGDF8qeKrq6YiSNZI6pP2sbGaocqRbgE5eZwMHcccdKQ+zQorQ3eUi4pPJJW?=
 =?us-ascii?Q?g2cw3ki8V5cHZDw+ESMda96Kxhma2MWWgvSL6Lpv6lStmw37TODlfY4gx5iM?=
 =?us-ascii?Q?5Ckx275lq5rS8IdbUyifrapn3+9Jxul1PSjvMr7GSqUxVYruPwcTcC6kjdTY?=
 =?us-ascii?Q?WabcGWumSFKTfNmQLzVDg20PwCveEVzAvuGrJnzzaA3s+7OyENCFfxGClu3B?=
 =?us-ascii?Q?0XFCt+6gk9qH+D6Jpfj9Mw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b6a188-20ae-41e2-b27e-08db2115f2a4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 03:17:15.8059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tOHifdTruKdl7DUYClSXVc4fmXpUv3NU1btBW8HwuNyn9wB5lgp88OgvjiJmMztrS4CHuKCUUApWTc8u0OrGeXuquf7C0KMs1yZC6pF4tUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5978
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_14,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=891 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303100023
X-Proofpoint-ORIG-GUID: 5DlUnYmB5DWQAPm4mV9Bfa55G_do6U86
X-Proofpoint-GUID: 5DlUnYmB5DWQAPm4mV9Bfa55G_do6U86
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Lee,

>> In the scsi_get_vpd_buf() case we will allocate a 255 byte buffer
>> since that's what scsi_get_vpd_size() returns for a VDASD.  And in
>> the scsi_get_vpd_page() case, where a buffer already exists, we clamp
>> the INQUIRY size to the minimum of scsi_get_vpd_size() and the buffer
>> length provided by the caller.
>> 
>
> Please add my Reviewed-by tag then.

Applied to 6.3/scsi-fixes, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
