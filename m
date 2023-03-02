Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F12E6A8B48
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 22:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjCBVTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 16:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCBVTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 16:19:41 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091D057D39;
        Thu,  2 Mar 2023 13:19:35 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322K4DvK000641;
        Thu, 2 Mar 2023 21:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=40wA+FlFLr6ElM+W+qIHS/HRTtxmamDt21e9O30ct2Q=;
 b=pnroXtFubucJvDAY1Ns7zCXGz+og5Cj6UuttJR04kJKTniXPb0PGCnuTo6oLSZxr7SsQ
 y7VHh7QWaDPie5jQUryvtktL/VxGdBqB/MXFgJUayY7i2d+w7ib0RJhpWL7zOiGflt6Y
 U5+dpG7w5pX0N464S4N9DXRVEuYqSof/FDHndVVw4gXXpWQp+A434u6fPorPdZDhaYPV
 jeqypwZZdqhya1Tr2G56quwXAkmDJ3yCcmFIjhSFXk13GIsccnarWuhEKV4RGjthcJl0
 PriZ2LZ+6yR89Lk+YOOgkYwI+kiZqYOMCK1e459poCWSxetjwGyxREy4xfqU8hUTBnES 9Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb72msw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 21:19:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 322KeQhP002332;
        Thu, 2 Mar 2023 21:19:23 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sacft6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 21:19:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdEQ7FCuVJtUL6MJ9OFIMT9OpvDjMg5nBiYcy435z8ZzQQ1/cc1UIYbxMbuwliwCq7nAfQobjk2v/phqlTdsPbCefFiYiTLCuY0zAuHDsGuzaNh7mGfirbvDo/p3D9JRO4f1mr53CyTOapEIDBCpX+dMSCY/J+ruqHLtbbO+7w/bDkhGyuloUni3kbABFkG5JRWnjC0XWHWqc5TWD22VVeOvi3SHxku9G5yVtDwZf84Z6/qXSblbDvu+b/b3xNaM6RqcFgqYwOoNOy2OZoA4Zzn8eX8BiUejKR+2oU9juVQ0etJVAnqPjvnkSq+gXiCI40fhvwB30PEpFjXQu3a4pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40wA+FlFLr6ElM+W+qIHS/HRTtxmamDt21e9O30ct2Q=;
 b=SZowJv7sOC1sDKZKGqOeUWd1DflyIgrjzXgi0e7N7J2STcBAGLTVf3r/RQh13vpGR+N3anoIuwyUEzVzf1+c72ZXJSlPg15hN3AU03Gyo01QWrEvkZKQxg3crujoiQTv/EqttnRbHelCq3kUD5N26BuXPoMMAFgMW80haUFeNIQi9PZXAm33EZCdjjHZZKL3xYDEBV1Y2iONJHwAtqWywRjGTQV1RdcHUtDszjRSUXbKCCq9pWss+lwPi7ZfaA+cXprVVuGyWUCyfWO65ddR8zhsHctOy/ezLo2j13+ryaTKJGXwF7NXnHgi1g/qp7kOkiC6fJKQg35PXSMIIo3nZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40wA+FlFLr6ElM+W+qIHS/HRTtxmamDt21e9O30ct2Q=;
 b=pY+rA4UNXy2iTGmT9pvRF2AvueM7qGhOGgqgDOv0udOvybs2LaAOsiWCa1TpQw4c2HwK+8kHYZyUJ/yIvGOLOpt4OG/XQAPFJFKNs5i6MgR4jCvEvAh24T42CMN5TyoXAQ5MAvb2yj6ctPuBkEpl/MI41f8cxFusUNPRayJvdF4=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SA1PR10MB6414.namprd10.prod.outlook.com (2603:10b6:806:259::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.16; Thu, 2 Mar
 2023 21:19:21 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.017; Thu, 2 Mar 2023
 21:19:21 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
Subject: [PATCH 15/17] xen: remove MODULE_LICENSE in non-modules
Date:   Thu,  2 Mar 2023 21:17:57 +0000
Message-Id: <20230302211759.30135-16-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230302211759.30135-1-nick.alcock@oracle.com>
References: <20230302211759.30135-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP123CA0010.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::22) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SA1PR10MB6414:EE_
X-MS-Office365-Filtering-Correlation-Id: 80bb5ca1-bf64-48c8-b377-08db1b63ca5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b+dRwAQQle0x+ERfMj3cQYI00zj7ks5lrOKCl/dOQ+xxvt9e7nPhAYO1p2S84IDvdUyir8WwlpACa2NWRupkAbZAygTX+tfiyJ+8jjGlKIERvvd5VZxjmxAtIuBlG19TLSg/pqNMc+/NR1qbg9iuN1S+c11a3OGyGtv1qKlTtzgaAC3zBmu9Yopab2rvXDMisuHdEuWoleQpyaYtXKus8ot4PWeQDtpsGrwekUQF82u4Uj0amHwO87SmPapIbi/QW5Ze9vxv6/pe9p0juGQObBHh9OKIyy4kmSlwBQniOoSidiSWXjYPebf1RWEupBuVYM0n/ILU4t+vU5BJ0MDeVZifRkmX03DxR/M+iS+DM97FL/r5ZoH+C8WKCgp+mdBd2olAFtbGt8dik4toEbICE05kabvJo88b+xZEt4HF1J6ScEGlieELXzaG217JTx0v+xD5KnxXbwNNP1z+6yxJAarwQ7EvOiOw2hOc6PBA84IfYlSUQgcyBO5QhSU5wc+nXqACHSHEm7JmGBg5yTFEJPp1XSinM62zU5lS2Fwdx7bKj2CYfsijXgShqUOXXXQwqFFJKK0K6mHONpQWhkMjdUwIWG0jIQU0rfOUEgvnke6eoOK12FDVXVsr7Nr5LodkBNgQNV1ID1gvDOl8LNQMjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199018)(44832011)(5660300002)(41300700001)(38100700002)(8676002)(83380400001)(4326008)(6916009)(8936002)(66476007)(66556008)(66946007)(36756003)(2616005)(2906002)(86362001)(6486002)(478600001)(316002)(186003)(1076003)(54906003)(6666004)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QFZqh3t/ONDF/i7x1Cf9BdABkscdSQJSwldhT1KR8mmwypmqn9fSldsFIvcC?=
 =?us-ascii?Q?yjZ9H4jfa3a85abA5HJyIt5v43VQNAaVhAawcqbQRGmU+L2nytedH2cYPKEN?=
 =?us-ascii?Q?Lhdtpjqq0shpxLWYJl2QPrEf1gciJjLQVQUBKgU/ZBZD66A83lHEB6EomhOB?=
 =?us-ascii?Q?KUOk+1wvuMt2Mxt/v9/pbk226XkaTFG1qb2OZLy/6FwNOC/MFH4NcUpdwzxe?=
 =?us-ascii?Q?Ozj7oLveFMdXj9CkWR25e/M+neQTPl2nzy0vjGkf7WvDd2Cm6HXjKgbA5oUh?=
 =?us-ascii?Q?ahI/mQOFZoB685FPZ3TyqW5sn5NICGGPvbsAEAJQW6iWCbYFzQlNMZLMGF4a?=
 =?us-ascii?Q?s06QtOXY9yvTKckY7h+jhfmwT+h/p77OHZ76dJZEDfGUT1MgLQORQkCl0Bou?=
 =?us-ascii?Q?9vl4/anHJjXURDIaakGMhSi1FTrvobsvrA/pEHF6quUlwRANXKnQLvVWCF5W?=
 =?us-ascii?Q?U6fqSfQUl4n75un1T3FUrCsidRhsmrtEjgStm057AvexV98CZYTFlEIo96gX?=
 =?us-ascii?Q?zPQ/LUp19FmxBrtvLCZjGjTy/bxQ/jyV11q7FgJsXBJcMsWWDj7seivWIisI?=
 =?us-ascii?Q?eqPDBwmCAHU6N6tHL2+yldmrwTrUynHFU/7jP5s7sGgKYLkeVb/pUBT8p6At?=
 =?us-ascii?Q?jiUaTO4Bz1SxlgBPZoN8IPTQJPWso3t0Y8cUOUSN39gOb3t/Sr8XHM6UyoIA?=
 =?us-ascii?Q?yIBfTZVGn7M3DXo8W5ydeqkweaAsmjRY0FXWa6joC4+pWM5JE8I/iDXEabhc?=
 =?us-ascii?Q?i1e+/HovjM6NdhBKNMNxCeT7BZMohY4uLX1myUeeEJYnZ82HRMSDPn0EtZqM?=
 =?us-ascii?Q?PPd8Ebtz5rOckneNuSTxSmhnoy5Bo6/UZsEbY2HX3TV5M5fB2x8OK/mo8nqa?=
 =?us-ascii?Q?MLe9HSDf7RuzIvcImsWzlegNCUeUigvSKknMvNEwbJpYLhsXGU96dZJ30khH?=
 =?us-ascii?Q?Fy/8hvxCjULZFp4/IyApd8idgRqP581kxjj26Uk9QWR3aA4qT5hxPAMoeWuH?=
 =?us-ascii?Q?fauGp85NT7736PHjbL59ZUi1w1w4rtNMWwL7DCSaQL5ez4l4SLJPYHRVWDkV?=
 =?us-ascii?Q?byYVbLh+AkJmWnl213HJJejgHpLbW19W/hDo56BMtu5lNIW7vh1leTOCaAtI?=
 =?us-ascii?Q?1fTmKDl78fvUWDNUAiZXnOQ9cv1L5VG5erUR+gKfRP0gqj7ctVCInPKXTj4R?=
 =?us-ascii?Q?qFce6OuFV2GTbh+BEqvF6UhoHuTRS7SB/t6Gxj2x7gf7LRGUsPR21S2TDZWc?=
 =?us-ascii?Q?+nEQ08YF3Wd1hbJ3kIpOSDOO7jGdzHsKvpudDVPCbeFVWzGLuSHsaCgNT/x1?=
 =?us-ascii?Q?iD51yqozxTNK0bpc9+I/JkONGXj8ugPbWI1ZjvDfQjFSkTIjUV/zo1PRoRUp?=
 =?us-ascii?Q?y6ePFB9A9dzBTydNzzouM6DBKNo+cIbBpUWqrQyY6aaJp4IpICCavPAF4ZY9?=
 =?us-ascii?Q?8h3bkxs58ZVu1Japd6lb0fJlHDQUGVs9XVgG/EcRzOtuuuHg/j3kDjIl1zix?=
 =?us-ascii?Q?6NdUdMIeB+M+XAHHzbWD8cTif2rRfYJD83wxm+tC5zfEoAo/zL4nvWuQMk4C?=
 =?us-ascii?Q?6MX7ifidfI5fx88PDgodVdbidqnFxfs5Uki2yYk7nWvBS75SJlb+UZ8TAeb7?=
 =?us-ascii?Q?82wPomlk7AEaWmitGfW+td0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ipi0aBksB4QRmQg/AmrNLWuexXctrBhSY4YnylGyrTAPxA/uE0jZqWGqQIzoFiZWKTZZbkTD/xrLoVjmo9ME8VfAoucre8oeDdHTUjZK9CT0NS/6QqS2iSFDyn9psSvLJXvAcRFqSvdtXoW9kKd9ia+aq7C2K/nuBBioJiSXiYqwGOvq3RGkzHbqSDJF/ph/GIHnZmYAW/g1aKNVpVkNa+6hpUG+pyPkIkW+FCU6t3+cFlEMDPaLKbybQL1sJYsmF0hjXP6mS9ksw7ij3hcTXTrV3e5kg3RDXdF3aRTtw7PavfE/x8d+6YOWKtqOweIEvrdc7b4IX3zGpijTb3Rd12G2erB+h1XsRn88phrLJC8GJbGJZMNdZbD24Xbhfq4/L22Pe3F/skul0jUEIQgDJGMX3zw/Z1w6BifKIlGpgC571a71fPAGE6BSTm+yVTLKfBXaNHFJrOKvvSbwiaJ/fSINi6frPlXz5arWp90jHM015T7IXXTrPR9sBTxbQGzuKgygzAg7vkSTR9A7T0VpoOKYjjsPHVXNgQCSJI8/PkbCVtk6Fif/UE++4SMcyl1+MLhvImSqz8Gtm+X49PDWo8Bkyf15Et/T0sWax43r87wC0fjr0mHiuzHM7JoIj72cRq5qSw15YZ+HZRtUcGf98OS1veVcLZf8q6pIEQGdQ1G7c6INznePQe3mFUcnhL8dBFPToxt0UIicHzKGGDignERUUKRk5Tq6CDF7CwCxKVPv2PnIB5fFTVqGhUYIA+r8HDLsPfN4t5E/h6mMnZmLNQEUKSG2PjjN0y45M+JSS4bnZKbIfTx88/e8VdIGdp2zh3xd/jNZIaiUWDemRttRF8Y4iIT6zI14Hf/UrDIZO/aXDXkZIU0HDDvyMRtjUueOs6a7yPFzyxxsKfxazihSjQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80bb5ca1-bf64-48c8-b377-08db1b63ca5d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 21:19:21.5001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nkvEJrHseohJp6lgmyieoxv9SubfGd8t9gNfM8wRF9njxCgtXpYd9tEBKmrRq9dASGAM9tGN7KTEQqXUIlp+xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6414
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_15,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303020183
X-Proofpoint-ORIG-GUID: Tx2KuvEIbvjYb5saulm6qo8_uIlvmB7M
X-Proofpoint-GUID: Tx2KuvEIbvjYb5saulm6qo8_uIlvmB7M
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: xen-devel@lists.xenproject.org
---
 drivers/xen/grant-dma-ops.c       | 1 -
 drivers/xen/xenbus/xenbus_probe.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
index 9784a77fa3c99..ca0249fc4d18f 100644
--- a/drivers/xen/grant-dma-ops.c
+++ b/drivers/xen/grant-dma-ops.c
@@ -413,4 +413,3 @@ bool xen_virtio_restricted_mem_acc(struct virtio_device *dev)
 
 MODULE_DESCRIPTION("Xen grant DMA-mapping layer");
 MODULE_AUTHOR("Juergen Gross <jgross@suse.com>");
-MODULE_LICENSE("GPL");
diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index 58b732dcbfb83..86c04f239e873 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -1066,4 +1066,3 @@ static int __init xenbus_init(void)
 
 postcore_initcall(xenbus_init);
 
-MODULE_LICENSE("GPL");
-- 
2.39.1.268.g9de2f9a303

