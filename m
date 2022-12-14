Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDFE64C286
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 04:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237194AbiLNDKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 22:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235771AbiLNDKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 22:10:04 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115432736;
        Tue, 13 Dec 2022 19:10:03 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDLNttF021148;
        Wed, 14 Dec 2022 03:09:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=J5PPTx1jc2IdGRFFrZcUmA+Q+aHZDGZ/MmscseSTbl0=;
 b=2q8JASH/vYxeiu48kP5BgYxhcLJdkwJaleN19/1sgnAP3cBBs7RGKAy5F08F6c3ENHvW
 HKHtiNwbYm5i9qkshcgIHAzWJHgtvNDVK4voF+mY5coqFRrICjFIJyEnKk+GUE/YwU+3
 IgEdkKoGZ7Za6zNmXvl5x/mj2aDD6b1sDtL/rICWwGfX+UL+a/D4jDP+6vRXxzdZ9ZA9
 pNymfsfrQLxP4sPxlRVIlnhR4scuIO1cCbtbac763w4FGmBOK8NQosz+Pts1CfYfMzYg
 Qs32CwX1x3d0yEn3o5/dAcqWB20w/UMlZFDwJ0sFkPfdShDsKeZs87D7E2Nr7jc9NoqB ww== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyeu8va7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 03:09:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BE35KEE011712;
        Wed, 14 Dec 2022 03:09:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3meyep12f9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 03:09:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImCAfA8VBfNyYOcD+nJ14WcHTO8PAy0XnPGKyympou8RCmEgOkKmJr9dhRwPegrLrltaPo9YUDChHix9j6SKcRbW9eQc/syDZtPk99eUzgUoueOAS8dA8n35ZTXyiuW/CgwDYjFyZ0lUKiPI3Im9brw8nzqXDoL7mysymJxp8vCOKh6moUw7WsxyzKOjORFShdSXnxauB+gJhZmnQ2vNY/MODzKd/AzUNEgANSdocLGRi7g7QIca5HgNDrpDM5iAIa4E6sCPyxDTMUT9R3SIlz6UvYOqDapiui7yTFeYMxjadg6MOsE43ksGPGSxadfVBcCHsAvoP3pu9a0+hdfs1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5PPTx1jc2IdGRFFrZcUmA+Q+aHZDGZ/MmscseSTbl0=;
 b=c46o4qk5YwPD6OFM2X3xRQlIbsyiTYfb/yx3HWrRyAKoTnoXZWvUnWd5hgbKFK3AfG1T058ttYI6S2pYCrWaGA74rT47CCnA2rBheqHUwT83Q5GFj1hz28iziDPo2rYQcv0tA2oEmxflGdId/nFzw5tnax8W/4LoLJtar9zWe0GdVGiFIS0HqfL8iDYjA0mng+rKwcw+t1ab0vhSKpk3Kx6uNEGOZkJvaa8fCoz1REmotkwBNp8C0fDoQT85VAfl1coQDZ2iLAMaBppMjGXt+7v/Xg+w00kApcn7lS7OE8Uzs3kdvNuAEYgMeuiKYFEDNrEzcokZUALxUSaYjlSLtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5PPTx1jc2IdGRFFrZcUmA+Q+aHZDGZ/MmscseSTbl0=;
 b=MbkyeKIue/thQK2lLoZvkIhKGPb2yuqWgbqDhx2hJBEUPDKaIXnUmpaWt0V7ABN9ri1bruwPGlio5FFv+HMK9Un0wCIatOp1cdF2dmgjO+PSY+E6foX0xx7KuOH29Sm6khazJX+J8inpvROVpu7t9V0ygF9dMOH5qZZuQAn4w+Y=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by IA1PR10MB6829.namprd10.prod.outlook.com (2603:10b6:208:427::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 03:09:53 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::25bc:7f6f:954:ca22]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::25bc:7f6f:954:ca22%2]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 03:09:53 +0000
To:     John Garry <john.g.garry@oracle.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        dgilbert@interlog.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: scsi_debug: Delete unreachable code in
 inquiry_vpd_b0()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1a63qel53.fsf@ca-mkp.ca.oracle.com>
References: <20221213142122.1011886-1-john.g.garry@oracle.com>
Date:   Tue, 13 Dec 2022 22:09:51 -0500
In-Reply-To: <20221213142122.1011886-1-john.g.garry@oracle.com> (John Garry's
        message of "Tue, 13 Dec 2022 14:21:22 +0000")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR07CA0060.namprd07.prod.outlook.com
 (2603:10b6:5:74::37) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|IA1PR10MB6829:EE_
X-MS-Office365-Filtering-Correlation-Id: ca9760b1-182c-4461-56d9-08dadd80aba9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s199A+40OATmhGHkfSH1l+LDrDF10FtPrVTyq/lkXN53AvMobR+ap2kpEYJtyP8V9TbL8Gct5H8hGGpjVxXJuKDITl/l3aeGqhYm2ZoAJAghhyhJplmYCrWp0/Hq7+OSD1yk3PtvYzt6DJ6mLegChq+uN/mfpV7afWUEo3wnJkulQZkIml61OP085eppHSQuhJnFHXFtU/ZVhj02EeESbQ3mWEMR7ylwviv3mzzV2X25D45Aj+h1ZBvTuhqHdgzBNrjgyqOH66obTh5IzYeEWR4jX+yVBeYJtR/xj/Mt0JqhA+Pha2MqZZkds3vAcs8Vgge/mvuMAS39+CoyyqpoP4gvxi1cSntBrj2S9Hh7eNZD+tpPUnTn2t37rixwribyrs8Cs01//PRBzZQUYvu7pIY7lF5ygMfFd2cSJAW5DD8Yce6hKgVmn2gr0K0ijhlE/GPrFHNrs5zlNPSXSObCszrutTTYMjgafc5m5rE5tsxG+UtrftVKnZ9J6+Xgnk6uw95Hck1rC7OzIJH5QqmPSgUVZs/I1G9uUJZ8659QEBW3snAoFES4a4IULG4+/OcOt1h0bX5v6InxYo/OLegbVA6JGMszryNA+Eva6ZYIjSl7/Ht4LAplHhmZveFQDY2J454MO13Pz74rn5de070T8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199015)(38100700002)(6486002)(316002)(36916002)(86362001)(478600001)(6636002)(558084003)(8936002)(6862004)(2906002)(41300700001)(66476007)(66556008)(5660300002)(66946007)(4326008)(83380400001)(8676002)(6506007)(6512007)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wn9rEP+KLXaCs7dFZqVg1r3XT5TBogg3Zqwd0v4/5ObuTsr4NuGF3kUNB1qL?=
 =?us-ascii?Q?qGHGvRgdRf8Vrec4OemV74AV7g+B3kRUoXgLVv/t9Rkh3sBIMi/y8xmDsnio?=
 =?us-ascii?Q?hEM1wlIN9d8CL/AGd4dmTE+8UGqwXTyWZ61HnUd1DXh8SNaN0NlTAHiAn8kD?=
 =?us-ascii?Q?R0MNxGrkzd5TZG3GKG51xNUesuN3EbDYk3/sKiWm1F3UYJiPRWIrF/3iAdPM?=
 =?us-ascii?Q?MvbNrxI5YO7VpiYc2F+MvTXisx/RMZrzq55DbijKYVkvUfbcEWt2kTnRGtLU?=
 =?us-ascii?Q?nnfpIfQwiNu2GTi6LnspZPNB03QI+zHi1mx06Pp0AUxuS/WS8HzVFHwrOaQk?=
 =?us-ascii?Q?W7FrDX047SDlSYv2YuRINDxxdeFOUu+EnREbdkSMdbQHrriUcQ7FQScw4i/J?=
 =?us-ascii?Q?il4WKN4omQazDraiDu2gRCpu9EmA9zXMs9jP7ypT3uSLfIF0DVH44O69HHws?=
 =?us-ascii?Q?0cwaTsCHZV8yyn3fFpmgM2VMJxTg7zuxQFrhhNjbVjdtQG8/gd2bj2x3f0Zk?=
 =?us-ascii?Q?MdzgVW4qFFHOREzjYgIdHBIDfk+LYG0dMFY445bHq6fME7qXB/+fV5EZ598x?=
 =?us-ascii?Q?0YzhSLWCWrTiiA9gWD7rCMFEMkxisfppq6fQbxbELys9csD6hdS6hHRxWoSk?=
 =?us-ascii?Q?ZMtfBUUM6X7+3143P2X4plj+Se23Ge/c3H8UMf1Pou8zFz49WDnl3gN94E9a?=
 =?us-ascii?Q?p5Q96TdXt37dJByK5FeqU3vqnR6KXC+LAtBfT60Z7hy4czymznACz1+v7TgN?=
 =?us-ascii?Q?8UUsYcbhQJvtF56aAlY+nNaBr06lFt6JtZedH1UL1Jtkj3DcqHClcab1evqi?=
 =?us-ascii?Q?Fb6BbuqbpRhv10StaiHg2Ki490WyYxg62rFk21j59ELsyLKGxfX4QRLrLw+q?=
 =?us-ascii?Q?qu3n6+MrlyoXUYhwj2MYubushU4lOkFDMNJ/nub1nEN0WqQViMgKQTEvTo+S?=
 =?us-ascii?Q?YnjnkDwVYY26wTC/hHOt1SuKOl+8PuxcNQv/v1ASenMp0HHsp70H76Jvhp3x?=
 =?us-ascii?Q?qyO6cFtev4ufrD+SxnmheM2untUUU65721Blcu3+ZB0V/z5PLoXt1n5XF3DY?=
 =?us-ascii?Q?tCBQi/tkyk0io2n9ewmPUwjxw39wGK33dxd0+PIfVQiWL96kMKCpJuZRyyd0?=
 =?us-ascii?Q?C2nZrhthuCTyyG3zkyfRaDjsxoj2bjPf5h+lLTHOvr5wxcT9sZAZGEeDT69N?=
 =?us-ascii?Q?fvViEhIGaqVPRVM7I2ZxafQ2tPVmnYEiKJnSi+OrwkuMwekPdME1wDvbNr42?=
 =?us-ascii?Q?LvInZryrKBYGuGO3uVE94OB+ke5j0n8APTvKBhyYhEwTh5XgV4RZ2E2qK7fe?=
 =?us-ascii?Q?gJkXjOS70hKH9oJkofXbLW8boapk14nxbwqjjJt1r1nts9/QUPvD9MAvzbgc?=
 =?us-ascii?Q?cgSXobbCexm15kdUyqAl0wdgwLcmiUZRN2eA6bbMutfBeGWPrCsYBvTNa/8E?=
 =?us-ascii?Q?op6wu/WpL3TseULFPtV491dfombaeI1ZVx/xmsrD3y38e0JBKa/3+dVplK/Y?=
 =?us-ascii?Q?LEL5rZQzXwgxyUf9btGY9X/CIoCPita1t9Ws0q1Lb9EeCVFqxdtXp1YLtyOZ?=
 =?us-ascii?Q?AwtRZqn1TVC6T7vhEWJGo7HSaLUVw2K+M+/7QIQiyLBqpPGHHY4Kpc9UJYC8?=
 =?us-ascii?Q?kQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca9760b1-182c-4461-56d9-08dadd80aba9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 03:09:53.3618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fb+ZEpOevZlGqV0qTBA1+YE/IIryYvJ40Jm9YS9JXHZy7oByTO6X/HHsm4seM/R4zADuJO/yQkA6yuvQsCQ8glm+P9kPgKKVrECKYkbDsH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6829
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_10,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212140023
X-Proofpoint-ORIG-GUID: 4j24_JJsgCwpD7S6JVHypadprD1fwL5w
X-Proofpoint-GUID: 4j24_JJsgCwpD7S6JVHypadprD1fwL5w
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> The 2nd return statement in inquiry_vpd_b0() is unreachable, so delete it.

Applied to 6.2/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
