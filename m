Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2E76BDF99
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 04:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjCQD1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 23:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjCQD1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 23:27:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758073B673;
        Thu, 16 Mar 2023 20:27:50 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32GKYgE2001890;
        Fri, 17 Mar 2023 03:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=kTn4CNsXC8YqohM6x6E7ib7ffZXMtjG4hi+GE5JzIg0=;
 b=Z5XBz53E1IkGh7fedvuu2x16PEwDPEshwDoU1XaJOXQosmi/Zfwuy3g3afXjyvKLhKc0
 wzaGHRDs8tPjdrS5rGwRAcwgt2mQJCl2jLLWPI//nIoqnSx+3QvwS2G6ix6UVd9ME69J
 yEf74zb4ISaZ74HDRXU+56xJLPZfMP5n/fntT1NlOiiV72gm59s2eZ2WB174h2bZuSnk
 DHrCMPV5DBWMhsmCe2tntWTDmA46z8D8XecEdS2Lg93F7qd5P3ipt/2OnONdPV4m591d
 r3CVvPZaEwGtmq9NowQ2pcMZkfFhvK6S+1pkgVAiFzpBEvPe9cvDcNiNIup2uoQEbAPU CA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs2ajx48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 03:27:46 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32H2UjHh020563;
        Fri, 17 Mar 2023 03:27:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pbq4774vw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 03:27:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMAGEQoATEbuqkFvLUn7ekOHTkwx2Y40yROo6tjOg1mQBGG+8q0+MsQ3WnVevT8AtFFn0dG/jK885eLVN845P1fmYOzZmBvQwAJfnL8MCw9dIsEw7P9QnsNylWWwljEuVFBMzbymd6ddt8U9/O4JVch8WSgIS6xjYvaQuwWhf+FrnL7jM+HTtU8G75Gvf1YZY1kKxbZe+pMpVUEXEK3TmS4GJN/utIa8VHX3d9PQ4oO+B7Fo/Y7QfrLVnBAXN/Jy9wFwGi7NI4CpzoPr2m/TnvQgVC1ZtXAnMcHxdCA9BZmzx8k9tnWGJURNd8T08cqi4vVbUh3Qx2SQujGZwaHR2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTn4CNsXC8YqohM6x6E7ib7ffZXMtjG4hi+GE5JzIg0=;
 b=eG1cqP4mtRzlCMelGx6ykbkODSfkwSvA9CQj8vjUZB6uxtAP1/2YH/oY3qjcpxibrKUEMoRE++tkaj8gbPAmAnEVVp/Z8QRN1OUrdnySxMcpPxtvOTmCP2wkVMe9YEKrOhJnsmmtrC7pLJzZpiL86sW+kod4PCJ97oGX1o6wwtKIoq+UvvJ+AjCgREGVRzHd8H2MQWzlKrxwnqxvGXh8WBvWM3F638nUNKEI0oeu4A7X1sMmMrap+MuKS9MMR1dG9/pH+KGZPmvUpdZ2XGQX1PnzK26MqPF+jS7ZdVbAEYFWmYXZSzudgnsLx1wKMkOR5Lyt735Lp4WYwH8UwGx+Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTn4CNsXC8YqohM6x6E7ib7ffZXMtjG4hi+GE5JzIg0=;
 b=WA3ocz9iJ/z2tPWz8HNddj+ZtRxD/W7B5ba7VgN3R7z+pqtXFRCx9yP8t0d0IahxcKNS7QbYRwbxfWg1EVdtcbt2W+IZaEf/C4zB0lY8Bqt33uqmeYjoKSN//yI3NAJepvjwCuocaMnw5BZCeeeENew8Y0TniV/hqaUvMOPE3MA=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH3PR10MB7396.namprd10.prod.outlook.com (2603:10b6:610:144::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Fri, 17 Mar
 2023 03:27:43 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2%8]) with mapi id 15.20.6178.031; Fri, 17 Mar 2023
 03:27:42 +0000
To:     John Garry <john.g.garry@oracle.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, bvanassche@acm.org,
        linux-kernel@vger.kernel.org, dgilbert@interlog.com
Subject: Re: [PATCH RESEND v2 00/11] scsi_debug: Some minor improvements
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1h6ukxdk5.fsf@ca-mkp.ca.oracle.com>
References: <20230313093114.1498305-1-john.g.garry@oracle.com>
Date:   Thu, 16 Mar 2023 23:27:40 -0400
In-Reply-To: <20230313093114.1498305-1-john.g.garry@oracle.com> (John Garry's
        message of "Mon, 13 Mar 2023 09:31:03 +0000")
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0155.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::10) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH3PR10MB7396:EE_
X-MS-Office365-Filtering-Correlation-Id: ef3452f5-ea2a-4fad-980c-08db2697918e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rbHObItU5ZSjBvDs4IhBNFttT2iNXSbwn7pKg66Xp5DyfwIZcToKv9FcB0Hhz9phUMBPto12G57HCB0Pw5tbI7qfuRwMiErzUbGd2vfTcuE6bvO5TlDI6DcNj1UFPtZYUbwdXElpRTiWMknoFubNqTglkdyhm0lfcY3IyBz6cXld2eEVXnnEaUl8LctljxO/hr02BOl/ZAhU1H/Dqd43PMxhngpACgbEcKoPZSjrUKcEXi+uwKcsQIdNa3zBwFqUqnqowUDNZgXHwf270rZ36DqLqagSYVy7hKVvRTU9R+fJhDA0+b/SAQ+D8HL3w8lPNy7q8BwElXy6aResnARk4fYbn+cQ//KTZHyfHcLp6hyqTjI15hgtTkQyurZ7KUOXR/ndlE6zG4WRsPWZnjP5TktomNK4YHR+bZkyWY86RsoftNM70togXn8hWvqinxJQPnQ+emPv+nM4cLZ2qVZX0c/UFswws1bhNs5tSRBCDTajaBWGUOhlHriohSoVyyJj2bDDjiALcy6IiecmOxnWJTbE7xUiTSNS+RZukMQlVzfJxKHCzQ3vOlqwM71jfBekxhR0I0UzrBC/GUsKliNFXazcZQEMoX1koIr6ezTbaeufHsW2MfUpR72lnpT6YOhnq32pu1p+ZnsCw3ZHPaWdxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199018)(38100700002)(5660300002)(558084003)(186003)(8676002)(66946007)(36916002)(66476007)(66556008)(41300700001)(2906002)(6512007)(6862004)(6506007)(26005)(6636002)(6486002)(4326008)(8936002)(86362001)(316002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BoFF0wWVQRofhKYgHH9+Ucm3xIG6SNKmCGCIlerni6Wn/Zsm2RwrNcmSg3At?=
 =?us-ascii?Q?p1LZDZ79ppZeVHhWIinUx2yh+tfNxN1ObH7xxDq6AvhjJKXYR1fzWjLM1p5C?=
 =?us-ascii?Q?FDyUw4Uv7l50dxk9s5VZSqYWukI/sT4fdskyrmJY9TdfRv8ScQC604EBrxuj?=
 =?us-ascii?Q?Zt4BtYMPwVBn5kb15Co0/dXC+pTozNX60aXGXgECujAzKoZHeXg9dKcl6Lm/?=
 =?us-ascii?Q?OY150YaL4qRfDg1aU5Ccst6TtWdMkjMcn2mD8eYyB7msbiGfw136oyveA2Am?=
 =?us-ascii?Q?QxKdrap6CzD+4E195t932211zdyhVcCEE7NBDCdyczfi+7CpZ0Snk/8gtAV2?=
 =?us-ascii?Q?vsFNgBrheb8Zuv5vGNWYUMebG7vA1EVznT/BFwB6sDYX4wLLXMBBHeXaQfpI?=
 =?us-ascii?Q?ZJR9m/6pCayjoFNDSZjvuupV5fMKMa/i5ex9C7Ij7fmLB0RQPU0PjS/+L6L8?=
 =?us-ascii?Q?8P27UVe88nnXtQ4suz1B+sveQFM2HbdgGCiBVGFDrWmBO2mu5KaA4zhdq6QS?=
 =?us-ascii?Q?rvQ2xCZfENIZ+MSJzK3W1BhjoXi2TI8fnTGzmHL3QZVWDHov/2FmpPCH2lFR?=
 =?us-ascii?Q?zqhCiFUPvFV1EDpSawx1ytD2cyJgT/b8QOMMPYowb1Fkctt4mjy/W0XV0hgO?=
 =?us-ascii?Q?zhDF2UEZZF6OPnSGs0CU1reoWERlLAiIyI2O04mtA0QEoTwtQVNXAIy6On11?=
 =?us-ascii?Q?E/zTkcwVzwQaVGvX9Jtj8HT+9/1q2Y2CYg5CN08sCqgQ2CBELLiD4P8y4Wy3?=
 =?us-ascii?Q?qk0mkLHive/cCK1ew7NKJByQ2n3R9ZplQDt24JGBMgd2J3eVdmUCi8fZua/5?=
 =?us-ascii?Q?wbukLmyRXCC7GXCZRe/cePawycHJU8SujWRfFZzZL+fcWgIrw/LimmFwDnVJ?=
 =?us-ascii?Q?kHnX8N0rzwjqQ6uPEgpigcKi3GUxXeY+MPeNh1228OoGaZbqdu162uoxHnbT?=
 =?us-ascii?Q?Y95VuOochvzKdBGszzocERswbfTIiooEaOY27qnzG/GDNZeE2OHwFPXmXZCt?=
 =?us-ascii?Q?I2w419qSwDcHqPK6SN4n0Qdz2eZzrP+GCX1UzVbPdkQPw+LqADjJuJWKW2Jw?=
 =?us-ascii?Q?rc/F5jEHiHe6uAykWvLkZAEAHoxSeNKnLZtN0E9oEna/n10Hbeoxu1NxSy4B?=
 =?us-ascii?Q?rd5HMMVzmUTgm6cuTe7MHn7rvGGOBIvq/fxqjdjT6bLbITBEszEmJ0oLHQRI?=
 =?us-ascii?Q?vlJgilSWS9pgz5GKFMLiV12V6gF7O1ctLJ03UNH+6EWjTEKDGDlA3TymJ/8V?=
 =?us-ascii?Q?7rz8DSu+WfxqmeRrnpUfcBvRCsE/0dQHkL5Lm1nEqXkoYLxxhfJCK6sDGGXN?=
 =?us-ascii?Q?vWsD070k6aIse0SnkqBwZ6R0NvEZmAVtEjIP/2nF30bJWkJ8uPowG129IYtE?=
 =?us-ascii?Q?0zKGn5jClCZCIqYJr1Fg7McY2NNkqEsYlZxXBT1yzk2HPkLeLTEXY3jIPN5H?=
 =?us-ascii?Q?zTqTczJ2y85mMlKZWBK3bifNdLtONByATAnDW3ciUCCObCIwIZO04OKJvcVX?=
 =?us-ascii?Q?QrUb1mE0Q1HDA5KrrnaquwM8kOAjmLRAX4XJDLfih8n2iSVx+LSysQFeM0KD?=
 =?us-ascii?Q?ZB/IpcbJxOKqyZhOyMdiDEMv5fLlO/IER8eBqa/tQJhrxodZGtLnCjnPtrG2?=
 =?us-ascii?Q?jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OBMwHEZwPChCxLm4bj7clzcdLpSU23kAQ3Pi71G1rHKTdRD+LbYUl4fvZ7dI8xo/IbqKEMUR9wbtlc+Q6J30WiW8iqYvDcld9Z5WP8mTCDwdfs5pf1mf0ElrsM5z5H6xeMkoHTy+BD4hjljSS10peHDSqIDWMULfWBDa3kJ6Q8ktKbM5HGpK2amcBo8LKCe6AmwEkjIEUtujgcEbs2ODFiH9HIlA2ZZEni7gFLrLDDOuYJKtFY0W+0tvdqiZ5Twnmr4Gjf6uZITEUjal8ce4PoWXQkXev0mYoIW4GkP1ysROsG8tIaYSKJ3MoJYColj61tUpZX6uWpXm1iFKAQbz43cz3qltXZ9qT6Yud3MuBse4oyy3McJ73amBCSFvr38P9aOQMYwr3t3jJvc/UuHymUmTuTHnBHE/LRVlbraEa9iWEebTCHaPuj+Wad1MHhOWwSR3MKxoTd8aPFniCX96EepBOhHHJDMo1joWHfKgv1MDQBXQFhrF9qY2scbV7+/SBLlAPy17RpJCK+vdBEC4sTiAesV+B69cgw892axLbfe0c5qkUMhNej8dhAhZKPByDpNUBm4R8356beOlGi5OBkS/iMFxHcajli8WGBUte+dROJyCIwhNmVkGplJqOWqY3mw//NwOPsm7KdNwfeXFSDDtdiK4G3OZiLrdaCrN4b89+PlWYctBcVxomXO2MJlSWQ3vHksYgCSXqY3zrMvWjAln9LzDua6RgfhTvrsQUGkB9bBzxKY12ZcNznfqXocSLzBhzdqYhHXBQ01Ux+UoeupAWV29XZBHoE93UCHvC8RcMfcsvIQZXdDUeHUWj0c45xCr2bN3Bd8RMo5Hm5N7+cc5XAqIJgdHmSi2TkkkTTY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3452f5-ea2a-4fad-980c-08db2697918e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 03:27:42.8556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JgiEilg/ZOxF5v/lwrLvqNxYvwJmaAdWGzxUJwz0kUhHYtSoe0sgiSQ2J5bOtbio+q+YkJunCjFyXmEcL7VkbEKy55JiIwGD0YSTDrhrXnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7396
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_16,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=797 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303170018
X-Proofpoint-GUID: kOuw9_WopIxaVKtza3lbYu4cj4weo4Th
X-Proofpoint-ORIG-GUID: kOuw9_WopIxaVKtza3lbYu4cj4weo4Th
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

> This series contains a bunch of minor improvements to the driver. I
> have another bunch waiting with more major changes.

Applied to 6.4/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
