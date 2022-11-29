Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC36B63C598
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236372AbiK2Qs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236235AbiK2QrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:47:22 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE746C73D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:45:22 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGNtDq022642;
        Tue, 29 Nov 2022 16:45:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=bibIZw68jKM6/uSNMDgXMSuiC65j2yL2vL8bwK3qLaA=;
 b=mitwURNqfD3H6fZoQqVUYL++dihePF16FpYmgeYuFRD/TSiVe/16i/Tu8zcCy6SuExCy
 dl+akCMdG4DaCcvHqdkjjbotqrI/2C5gIvqY7aDH2PfcnabbajerHThX36/NMCMPnNyx
 c6k6geCB1gkKSqpTU7Zy1oav7sI+44dffNA7uNWdeiT2WVsZ47Sw/8ndScyB+4h3YkHR
 rluwB6DAAcWd8rVfY3DixvHmfpfvOw8sNnoY8ubam886MBvOXEWdbI4ZGhJ9Gh296wwP
 79mVmpZ/pjIC4hbvvS6o1d8onxpuwGJF4tFIRaLiLB+m26wji3fSExwczwbKd7mHTMx0 Ug== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m397ffc72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:45:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATFgHOU011450;
        Tue, 29 Nov 2022 16:45:16 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m398drgfk-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:45:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqAyUsjlX8bJeOMhsX1yVpnO7U2SaFyH0ndHGr4IaaOKHzzfMxXFZ+umrKFXHLJyP1EE+7VP/heEH+FD/TqTZRET5j5JFxzCyCxWidp9vpDXLr7x31KFsLLIkCRmOXjChKfa/t441aLUVCkGdZWrF1e0uOhZJisPz/m4R/uZKN/ux8rX5cB3/qL8OsbcUeft1NR3lfjIgtOM3FWxsIbe9kkI9cOK/j/OSFk4cYKtvGlFXwiWg1EKTJkU5uuwmjv0UTZE0Jk/DW5pe6FF0ppRl68Q8vkZwy+PnOP15i/20+AqjHEiXGU211uForSu4WE5IXa7Bi6pNUB/n2yIJmX5ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bibIZw68jKM6/uSNMDgXMSuiC65j2yL2vL8bwK3qLaA=;
 b=S5B3AJ7M81uRsCmh0MxmrIxKXIeIhx4rkB4PhbHrLqqsEik5HK0cCYSnqQagA+xOOGiylLi0AjUiw0ptdp3Bm/K+xpDW56xuAs8anvQ6ZSi6rDT0eDvbppbM7pdVSA3ZJ6Togaklb+ysYpWpFAmso57gopCanxFQ1eJ5q8E7+gHJWAyTosZJEhOXGghzdqTLpAGeNXBrfd6n0OlJ7UXhGXH+GmfGGcJZny6PE2d3dMRtebIONR9kmWO5OSMG+0sL/mW96itzeaSybbsjUpy7tIEdVQCjPREsUq1XDzDngvzYrp042lxvdY2NbObKx8eGREQsudn04r2gVoH0N0Kb0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bibIZw68jKM6/uSNMDgXMSuiC65j2yL2vL8bwK3qLaA=;
 b=u9DXT5d3h1efm4BHmBUmAfitBSkp2k+GZ3cFZBuwKZ3esroaoNXwLNXYK9YlSeW2KbkhmcVkfswNvSGKyPK1cOYC8IJXR0B8l4th7ZH+a+YSCXQzHx2rQ/oilJ+kV7649BZrPsc2d7jNr+mnOKuJHjPfQKAm9xnoUFXcuVMACUs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY5PR10MB5937.namprd10.prod.outlook.com (2603:10b6:930:2e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.18; Tue, 29 Nov
 2022 16:45:11 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:45:11 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 40/43] mm/mmap: Introduce dup_vma_anon() helper
Thread-Topic: [PATCH 40/43] mm/mmap: Introduce dup_vma_anon() helper
Thread-Index: AQHZBBHeo+xNPyC1gUmxR1c2o4ECWQ==
Date:   Tue, 29 Nov 2022 16:44:37 +0000
Message-ID: <20221129164352.3374638-41-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CY5PR10MB5937:EE_
x-ms-office365-filtering-correlation-id: c819ed59-c4b3-4876-d3db-08dad2291505
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V+dhywVXrp6p1aZHb9yJwqnDjsmBhumLXkkF4hHRhrBlh56sqs6pp1spYanz/vcC0cb/adZOl57tHdwVDAKXctn3sM5kM8Rc3t9TvL6FSvQddHRfs9lLah89C+v81HCZToWZj0u+CvyYSjCSkM9ddXXysaczx6asgD5O82Vpqx8ACseL4BL5BBst/uNF+Xi4R5vr4RvvTZRxNRqMUqs98MIQlVZWIOGphN16roWuw3PODGv4rcYBMTz+s0ux5pmBNgdPrJFQ6sLm4gUwrrLEpb8iuHF8W1tMOb712oTgSjGZIc9Q5VMH5UhlAurvz2ik9PSYBzNi8dIvMD0EOdqxD7TRW0kKYGvOtGmXoW+8hDHi7qxkEjt4ZFU3cJNnHCey6pSQdCLcie4RKtfzSVmj5uzIQEz5qEDY++svVPbGw6NtYk/yYlouWkW99WPp4fy6smsZh68n5nyvfmp59gzvjxtJ39eqXXOd0uxpgLgrFTQ4vlGb4SSWoROLdO0BsHi4HY1iUBnAAgVsMe3LpnPoAMEP60KjZiVJvu8d0YyVR+TTnXQffSDY6DNo/WAFcHt5o6F7p1UPCLo9WUrtKoVCK2sCGcJkRB/Hfe9dZNvr2SUJm5WNqx5qMpoxQRH1Y7ekbpt3eSWDqCAOzi0X1Lt0kNBWnaYaZSBTHuWCCf9mMKQu/wCxwBR03yRxCxCbIzvp4D5oKZC14fByf/VKVaS95g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(396003)(366004)(136003)(451199015)(8676002)(66446008)(66946007)(86362001)(66556008)(66476007)(4326008)(64756008)(91956017)(2906002)(76116006)(110136005)(54906003)(41300700001)(38100700002)(122000001)(6512007)(83380400001)(186003)(8936002)(1076003)(36756003)(2616005)(316002)(5660300002)(107886003)(26005)(44832011)(6666004)(6486002)(71200400001)(478600001)(6506007)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hdnSDxQ3isBWOLl41VSkLiiRIOUVNjoos4tvvHXigv0a9QbgqIVp124UTH?=
 =?iso-8859-1?Q?Pu6/MCLyGPBqo1+tn63ym0AqJKXWyKkoswTDLCmgq8UXoswXxImTOBogAh?=
 =?iso-8859-1?Q?e8Q7TsPTzl0j6rZpyBCvfnOMGbFgOQLgPL8sVBSpiUD2fBpIO8oaUzGPgM?=
 =?iso-8859-1?Q?4aoVuuWSjqMOiSwS3G1rUWGH9WW+uTtFdPm6tbuN9bjznQ6KPxPFX0EMq+?=
 =?iso-8859-1?Q?gGJiuU6p6AfQT2AidyMsYBdg/mmmDyKCwstQhgmueOYLNxDK7SPKLI7rer?=
 =?iso-8859-1?Q?aULezOjd2xL5mnuR8MyqSz6XgSGo0kW+o1z7tAlPswkP8vF5OvKvOlne8/?=
 =?iso-8859-1?Q?jiASwFUKaHZ2632oaZvBRR3Pq3KG4a00u3FJ2Duc/Lw4m6Ak+MmhSHZrYv?=
 =?iso-8859-1?Q?LJ37DGacW0267auavygW5LLk6XRz8hDrX+Wk3G79vVVDVaJPibxE1Xyx4i?=
 =?iso-8859-1?Q?taa3iR7pNt0klz4EZn7IJgNU5dMswJynMsYAjr2oGLaa1cGbr7QTnEojAH?=
 =?iso-8859-1?Q?IF8u4TsBfhBy43ALQ3PzDCg+UfIK+1cLATXPuvaVc/G9n9AcXakblhfA0y?=
 =?iso-8859-1?Q?6hqe9bv8Y4kfCAGTNLOhzzW4J3NIjnn/fIm9T/LOYpMJLYq7+9lhhrDEPl?=
 =?iso-8859-1?Q?05MzoHGZ4ntra10gRHRmwndd/QEq5CSAkpzI5N/ymF9OX74aBEHQBAkIZf?=
 =?iso-8859-1?Q?j1V4die8QptPXkbN7OuCveYY6nr/9wHoyHE1QvtKWD/v1aHXMSS35bTiB5?=
 =?iso-8859-1?Q?FOqYJmAWQ8gFpdcwvr12hhWjJCH2+ZAUpp4QFqziPf6eppZRj/UnLszY8g?=
 =?iso-8859-1?Q?nmj3GPZLfgaW0MSJkbJnz0n/83jw/s4mEB+oM1RGuHT9bPhX1z4jO0QU0o?=
 =?iso-8859-1?Q?1fCHZ24a34W5BoUAsNBu9ae3yn+l0A2/SBNTjh1Cxkb6pBGHRh0ljIpDCJ?=
 =?iso-8859-1?Q?j2QmQQTn+enM+HiawaDYN0P/sNxX6t15bpx0kmN30bUIXtsBV0FrYwGzmC?=
 =?iso-8859-1?Q?PsexSazVsEEghLzPKkRbyT3++XrJcrR+0F+qLlXwq5Ej5xJkEIJvT5gMrH?=
 =?iso-8859-1?Q?KZJ33m+adRHnXMzRjePPwKT6vCn0aD7Z/nNdBNb/L0/N53G8VyNd62dMLP?=
 =?iso-8859-1?Q?0FQrcQmG6abhebJqqtYWCW2aSHG5fjJhF+pG03LBEjYK5Bl7duWdLcjEfr?=
 =?iso-8859-1?Q?2oHpfGwnWXQt3MPVqq3JV8tU8oeo6kw7VyBC26ccWSDB42FVg5FfRe/S7A?=
 =?iso-8859-1?Q?zO9UVlwyFyuhM+DOCs8YJW5AFUDrpRd5LC8/HSI6clNMShLmN89cIspf0w?=
 =?iso-8859-1?Q?gsW3hgyaz0R2wpkU8XW2bk9F6fkjctX9k0oA+Q3gwEGek2wLYPbYJ+5thR?=
 =?iso-8859-1?Q?9C/spuA/fEUOnNqX7Tq4g7t4kR/QHXxm/SnmqiXoY4Of6ZcnqoD4JVB4yS?=
 =?iso-8859-1?Q?fXbae4AsmovSKA2/BZl+5GKKAmeTOfO0vB12jUlREhVe+14c2VfKULQy+g?=
 =?iso-8859-1?Q?+LZHFwBhRm5D+tjwwa+4hPfys3TQx0WGeIEKhK82dhu10YS8Dp+4IfdAro?=
 =?iso-8859-1?Q?JKfreEzisqjWGcH/uXjrHojYpcuspiiqL/cdycNrE1tNcEClV9/cpeIfWu?=
 =?iso-8859-1?Q?i/q7GHsDW9w1xk/QvGdGUiUUpQ5XEt1x4OhX8waEHtToy4h+qNM8tqWw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 456lEmjrR4A3NuJvXTchDBzo1NFVFVc6DJbZjYv2ZFMkxCB2IjkXp/oY6wkzeAz6wTxpEXTLnEfIKxrXUyfTt0a4EwfebauoidqUYMJg57enA6ULGQg1E0Re/pxu3dYkA2EkGc09KkgsxgxDrzfdnCkLmS8ckI/Szs7LCcDXgSCAcmJ7vz6FAucDGhMGYuu7huo8BTrSn9b5vsxUK2hLduapElzJq7pKzALguWL7pAOkmgHFZSXc5khprN4j2QfhjCbecp30DdPdkgza4aFds9yoTv7KT1UV7VfNuKVEFkKRNLRkCTlCEXtpPLYYEs5BAhatKtpNXY11m6KKrE8rTDVsRlHbsFz1dpXQ9Wx+yXXgYkSQrYjOuE3ZSKmKwA6WIqt09Fr0zFGhR1DV+US9xbsyeX9Tu2CzuxhUV5LLsb64+EDf7A1XbX3tdW0IS7t2PqqfPXxz59RZuMidWD71GcEmxG7wgMpGNf/bgEAR3me7kmUaFNE4PwdJIaUpfOuDHxyfvmKZljBE4wtDvsYluJtH7vRV3F6CJXmbs/cW25PCIFco6uB97UPcQRjshW0diHGeQAMdCUYhb5PbDeC9bj62uMAqVPmrxC5fCvw8csanCrZO3EvavMcBA9ObuVW1SqPYWLDsRvKSxxPwze8JvBQv2VIB88AuM2I6dfmdfIwowCt/L8caiJjDN5ns86Fo/o7Z5apDifPNr+K1ZBimvxoVRS0rfsSqsqBlb5eaXhGDGiNzAClr5uDrMi3bhapj+2ETCzJvy6fQQJCQ0w3YZiZnIxdMLD0Zx1oo7mV4HWp98EQ5tPHqpiAGsVGfa0dzr0zzd8APHnnoRJOJKpF5nlA85v+0V56sImeCXF9bemQ7CfWsE/pBQyrN2pGK450ehptBKjzaWbtE5U0DWWfvAw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c819ed59-c4b3-4876-d3db-08dad2291505
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:37.1752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eFRm/xgTBzQo6t2Mc1Q1eDTV8b0j/gRE5TbNYHCVNaLMiz4r9zrfurbIW+yaOz+mRpB23ZQCXR/PDUzIOMQ4Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5937
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211290093
X-Proofpoint-ORIG-GUID: ooy_Be-8Z6HOcvNnCbqO1_88IpW67NR7
X-Proofpoint-GUID: ooy_Be-8Z6HOcvNnCbqO1_88IpW67NR7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Create a helper for duplicating the anon vma when adjusting the vma.
This simplifies the logic of __vma_adjust().

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 74 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 40 insertions(+), 34 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 519cdff9d135..2b41e7882639 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -677,6 +677,29 @@ static inline void vma_complete(struct vma_prepare *vp=
,
 		uprobe_mmap(vp->insert);
 }
=20
+/*
+ * dup_anon_vma() - Helper function to duplicate anon_vma
+ * @dst: The destination VMA
+ * @src: The source VMA
+ *
+ * Returns: 0 on success.
+ */
+static inline int dup_anon_vma(struct vm_area_struct *dst,
+			       struct vm_area_struct *src)
+{
+	/*
+	 * Easily overlooked: when mprotect shifts the boundary, make sure the
+	 * expanding vma has anon_vma set if the shrinking vma had, to cover any
+	 * anon pages imported.
+	 */
+	if (src->anon_vma && !dst->anon_vma) {
+		dst->anon_vma =3D src->anon_vma;
+		return anon_vma_clone(dst, src);
+	}
+
+	return 0;
+}
+
 /*
  * vma_expand - Expand an existing VMA
  *
@@ -702,15 +725,12 @@ int vma_expand(struct vma_iterator *vmi, struct vm_ar=
ea_struct *vma,
 	struct vma_prepare vp;
=20
 	if (next && (vma !=3D next) && (end =3D=3D next->vm_end)) {
-		remove_next =3D true;
-		if (next->anon_vma && !vma->anon_vma) {
-			int error;
+		int ret;
=20
-			vma->anon_vma =3D next->anon_vma;
-			error =3D anon_vma_clone(vma, next);
-			if (error)
-				return error;
-		}
+		remove_next =3D true;
+		ret =3D dup_anon_vma(vma, next);
+		if (ret)
+			return ret;
 	}
=20
 	init_multi_vma_prep(&vp, vma, NULL, remove_next ? next : NULL, NULL);
@@ -799,10 +819,11 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_=
area_struct *vma,
 	struct file *file =3D vma->vm_file;
 	bool vma_changed =3D false;
 	long adjust_next =3D 0;
-	struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
 	struct vma_prepare vma_prep;
=20
 	if (next) {
+		int error =3D 0;
+
 		if (end >=3D next->vm_end) {
 			/*
 			 * vma expands, overlapping all the next, and
@@ -837,15 +858,14 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_=
area_struct *vma,
 					   end !=3D remove2->vm_end);
 			}
=20
-			exporter =3D next;
-			importer =3D vma;
-
 			/*
 			 * If next doesn't have anon_vma, import from vma after
 			 * next, if the vma overlaps with it.
 			 */
-			if (remove2 !=3D NULL && !next->anon_vma)
-				exporter =3D remove2;
+			if (remove !=3D NULL && !next->anon_vma)
+				error =3D dup_anon_vma(vma, remove2);
+			else
+				error =3D dup_anon_vma(vma, remove);
=20
 		} else if (end > next->vm_start) {
 			/*
@@ -853,9 +873,8 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_ar=
ea_struct *vma,
 			 * mprotect case 5 shifting the boundary up.
 			 */
 			adjust_next =3D (end - next->vm_start);
-			exporter =3D next;
-			importer =3D vma;
-			VM_WARN_ON(expand !=3D importer);
+			VM_WARN_ON(expand !=3D vma);
+			error =3D dup_anon_vma(vma, next);
 		} else if (end < vma->vm_end) {
 			/*
 			 * vma shrinks, and !insert tells it's not
@@ -863,24 +882,11 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_=
area_struct *vma,
 			 * mprotect case 4 shifting the boundary down.
 			 */
 			adjust_next =3D -(vma->vm_end - end);
-			exporter =3D vma;
-			importer =3D next;
-			VM_WARN_ON(expand !=3D importer);
-		}
-
-		/*
-		 * Easily overlooked: when mprotect shifts the boundary,
-		 * make sure the expanding vma has anon_vma set if the
-		 * shrinking vma had, to cover any anon pages imported.
-		 */
-		if (exporter && exporter->anon_vma && !importer->anon_vma) {
-			int error;
-
-			importer->anon_vma =3D exporter->anon_vma;
-			error =3D anon_vma_clone(importer, exporter);
-			if (error)
-				return error;
+			VM_WARN_ON(expand !=3D next);
+			error =3D dup_anon_vma(next, vma);
 		}
+		if (error)
+			return error;
 	}
=20
 	if (vma_iter_prealloc(vmi, vma))
--=20
2.35.1
