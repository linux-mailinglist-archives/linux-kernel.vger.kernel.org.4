Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040A2603338
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 21:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiJRTRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 15:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJRTRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 15:17:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF2A580B9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 12:17:41 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29IIECTR020281;
        Tue, 18 Oct 2022 19:17:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=CmmvWBe9k0n2pBK+G+gQCTNMWPH0bfV4/6aLkJHOaBI=;
 b=M3by023Z6BFjHX5svTy5yapY+n2dq8idnOE7K3aRDUX6y1JyJsBIts+ahtqSF7HFdJGa
 x0Ooix1RsGpu3xhJ+FHNR85c5tKvKsam7fIBtHr5WCtZo/OjVySYLpGjgKZx1RG7rRq/
 xuwemH/WqsRxlh45ruQX71g0VPL0xOHzz53mS8qGSiX4pLrcaYktKWF5E3XZ1wq37bj+
 ibvZAnbIZKEXEq+KRIK6EjzW5mKEMANxDxvsrtTL7OaEXhekyiJVLIzFss6n2j+45EH1
 ofMCQE1qjZnCW1W3+jgOkTmsU+9vx4hkluaNsAgiWZR9Qju/sOSEc4YOG+mhv3l9hSsE Mg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9aww3eng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 19:17:16 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29IHK7Ca029254;
        Tue, 18 Oct 2022 19:17:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hr063ch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 19:17:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8gUvo7puOlUdqi26Q+pfTqcVK2K4RYPIFqPrBp2aBq1JuvGUFAPhOsnUb9VnSF3+efg2nQ7u7PaA8F9aYlrm4qRjYXG/pyhANiHEclCgfPKitLrF7JfLY0Jb4Rbwjf7pujblOOlHpPZFXpXQ08Nj9ZIPgexB73cFkCXs5LnzG0Cgt0Zzwjh3/Ofc1emgw+0K+0z9yOiBSQzR26fQPmHzhMH3DokA3faVSvfEVz/Tt3Ddd6LceOIxXTxt2Ih/3xErv5EugrBhBnIDBNewoOuzl38mEjrnNmw1IoT+ZJvzJmsQG/VMbD5jKsy/8ZLim/8dyf9P/lgLwRZBkX/hstsNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmmvWBe9k0n2pBK+G+gQCTNMWPH0bfV4/6aLkJHOaBI=;
 b=QVEKxarvoCk10YKMwaNvTeMQJjjNS77voc8qvxk7aCkx+bdtQNSauD8qac7CI6OqULsqz0frTMv3tDdkXV3KxVYMN5x1e+tJsVgpHpFTl6Uk7nr3yj+K1wLvVAJNfiHlupsbpcAXDH0rmYRj830aYXSM5rd00YpAlwxex6v6rZE9x3NXLCQjuMcSSDFRz/D1QaoUKJaJ2j2eJ8khP19GK6Zc/47olDhKCJ6Rbr2WNxHLjhndttZ91xp5h2b/h+1qOTngcM8JexkwvSdjJPHXS+sc12mvIsqb0gXvSD80uZYnK3PD5MHJuuXasGjvEN/jbLG25dV99fq+ScrUe+yopQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmmvWBe9k0n2pBK+G+gQCTNMWPH0bfV4/6aLkJHOaBI=;
 b=vfp0q4HxMwO7tK+bJqG12rAjWZZQEZ/cxOZC5ZNtRetQiTPSEXYzxmG+N9MlRBefwGxEPUT4XSv/PvmfeiycbUsYs9K2aTLKVzIrJKtSx6/YSpJeSJKWvCoKm1yknhVr5wruQkQ0gXrv/iB8b1PKdm8Bjwxmid2yrrlKqHjHkUs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB5299.namprd10.prod.outlook.com (2603:10b6:208:322::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Tue, 18 Oct
 2022 19:17:13 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1%3]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 19:17:13 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liu Zixian <liuzixian4@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] mm/mmap: Fix MAP_FIXED address return on VMA merge
Thread-Topic: [PATCH] mm/mmap: Fix MAP_FIXED address return on VMA merge
Thread-Index: AQHY4yY6wKFTDfH980mQOidqey86dw==
Date:   Tue, 18 Oct 2022 19:17:12 +0000
Message-ID: <20221018191613.4133459-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|BLAPR10MB5299:EE_
x-ms-office365-filtering-correlation-id: 6669c603-1626-49b2-f4d8-08dab13d5c90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TGnjHdjBXQ1DBR68SOR5xDNcMPyDfIZHJK/qd+h86mbE7O2wm75oAg5L+CADtJbfSFUpCnyBEFU3jgakWjHfA2aKixLem8Qbf+8urGzcO/4SnDn2enerrGcShTCCjdL11ht6D9J3gEF0zdNGDyaaiA7bxRjluBidlU47qeaJchvmXJ4tPM5Ztma5oY4m9ST8XCnxnkqi5P06/MsKMnCnt5Kn3aZbULUVb9I4uCZJeKmykWbVQ4Nqje8vQjY9aMlzUy7OxPgNBdLPLbU1PmEltyB3tdhZVhgGIRxfnkdystBW5VWpt3ppdILOUf4N2b6mgvDemUvwaM1pfUmNQn9ipLprSRfJdgmYoaAQRA7P8cP7KWJyMU865MMNTvLJ8/+2RaGdUe8qtKD+DWSc4U1rJbLdE4fAXK9WMeNHJeyCCzwf4ScQKH10AKNc7AGSmFu9j1bwuBhlvxOwypXADHeWPjo4+eZR7OUhTqGdWpc5EcaWQozXx0WIhJQiXNfIAiCu5+Uh2YM19IGvJtm4THQDGKd3tDKBtv9VgfK6NGq1elX0mKoZlmGTs2K53+D7tEvkMCSNMSIv4+vovE2QEv4FkBjA9F3uX0Rj92E+M2h0+GPsO0SZ7ueNhpF0TcH0+qG9NshfBLf3OEc78TmWsln8lDGX4bljm8DeDWTbCzIRCElly7S7ZC4qPMG/oG2+UlMQMfvkSIdWafEMowCuSuTJZGnM3s5yCm055KJAHOYvK/3ZaOp6NdB8EjK50gCxKABqRIuNrYn8uaU2NmtSdj6pbl1wTR0FrxiONobl4rPyyZq3brEGm3J4gWmhzNldiG1QQ7V5xOYxRLBskBpNuCI2FQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(396003)(366004)(136003)(346002)(451199015)(44832011)(2906002)(4326008)(8676002)(66446008)(64756008)(66476007)(38100700002)(8936002)(5660300002)(41300700001)(66556008)(86362001)(36756003)(6512007)(38070700005)(26005)(6506007)(122000001)(110136005)(2616005)(1076003)(186003)(6486002)(966005)(54906003)(71200400001)(478600001)(91956017)(66946007)(76116006)(316002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fozs4ZgWbdddzifqIrH5fGS8J6SzmlaiCYDcDwI7JdzFjbS1LwG1jBsLOh?=
 =?iso-8859-1?Q?Cf1OZS8gGBiQR1hiiEv7nr9IoTRCbLg7eMgBNxAA7UpA1qMK3KMsPvaq9R?=
 =?iso-8859-1?Q?6ikluWPlPobVKQy9DTwubh1K/pT8geScJKUgc4tKouyySycD1cx7Thd0lf?=
 =?iso-8859-1?Q?iAgOZk6d/jzyLaZjFgGzUx0zsy5/bNYQwFTgN9EmBGN2g3f5c9HT3x9JV4?=
 =?iso-8859-1?Q?eK9SEyfRg7ixk/rzfyDMoouRJrfLrIkVCgfYt6hyESjO/ye9yNJP1jUoYi?=
 =?iso-8859-1?Q?DHSj8f4tVueq4EytN0w6Tztde830e3tfVaVQGwYACJHWnyoovEP1/YTaY3?=
 =?iso-8859-1?Q?UBhdAYkaN4PoQ0DUT9vfttxqhmhTTK5D/i5Q5/ABiHvczxwAnvwhj+dlq5?=
 =?iso-8859-1?Q?ycCK0shoIjoWv3lQMl+KY/3BFh0ak6wVna9BM2pjos0qc0cTj6KKbozrjH?=
 =?iso-8859-1?Q?UkIUsyUmFyrbMMHWNOUxAtYBrno6/ktdjPyYct42AuIy1Ow3UQ0Uzy+BkY?=
 =?iso-8859-1?Q?NqCYyprOkoim5uI68S6rotMO73g74gKAmDD1BOdkBtPeZWqWo2PZyyHKXZ?=
 =?iso-8859-1?Q?jxBSEKm/UMXF+8xOlrJkYSza4Fn5hS4uVs67fTfO/ATrI/j4JhMnDUZWeC?=
 =?iso-8859-1?Q?TgxWHHguAK404US/94JGgYZdvy7pHL+LQXIOStNlI9+3LzKDFZ0oEvM0x6?=
 =?iso-8859-1?Q?PFLKK9iSOy46oAlbGaQb1s/bWS2KKErUi/OWHzr8pZHsevBfP4DqpSmV2B?=
 =?iso-8859-1?Q?uY7HhGqqRm3nUrTPihm1B7v6EZ0a67kSb2BYaXwRgM+9arsl6xk2i/ezZB?=
 =?iso-8859-1?Q?BZi3Lu8pEekWACihh13UiV8YofgsLCKZDAA6jwYvE9ZRXA349I9dttl690?=
 =?iso-8859-1?Q?a4vQnv7fv0A5FJnZQGGOSsN4r03e82BNAU8kStNasXvVTm/wEjh2+nbGbW?=
 =?iso-8859-1?Q?RJxPyn6FKo4LAySbyLs4P17UBn1BAXrIax4Q4yp9SUsWttBwLGEYqPnEqV?=
 =?iso-8859-1?Q?ka0UGCb49hwmtpOR0uDMAe6CNk4KYAS3All2O2wlbJG21aYc/8/JVBrWIU?=
 =?iso-8859-1?Q?C8vSok28Z9Z8NGgKv46y82pkc0njQoGDNOnMIT0wZzBm1EFel9x47XUYoX?=
 =?iso-8859-1?Q?Mks6R3/VEPIZ2oenE2BKk5LwpbW6HK7E2ELVi7tgnbFnh0eCcNnRR5PKHl?=
 =?iso-8859-1?Q?IY7d+cx1FMuSZ+NULh1UhnsvTC1OCf7DNMPvUQuyi4yuJtFbx7Y0YUfDSm?=
 =?iso-8859-1?Q?rPqArKDbCKUt0OQ48w8uG+e5vjtG1LTIKZ3fTovhU4qhcUosOVrCfw13Q6?=
 =?iso-8859-1?Q?WwB4RFUirgmrmLZfadsAl7x48SBwEIydNej5VsMzbkObCTF7kBLtI6Z82i?=
 =?iso-8859-1?Q?dS1BMrw7t62d9L2zPRq6FviCjXQaApjCccrI9umPoag9d8CAUrnj/vFK0z?=
 =?iso-8859-1?Q?Gn3NSL8+eKrTIyUXzzCZ/fuTxmZbXvqKL+Uq0DJpdM06NjgP9whj9/nsnu?=
 =?iso-8859-1?Q?60a6SxKIzuwem1go/Yu8ApqZD4EexUrfpKEhTwhj9+Id25NnqBFfR7bckL?=
 =?iso-8859-1?Q?psKOUJIGPirUm1tTl+/yU/Q/YuXdjRAQev35ic5ZxL0Zq+lpQDgYfUAZRl?=
 =?iso-8859-1?Q?5PNcXRdnSg/tX3HUOXzVbA3wkWmgrbGj57cBVIa9RKhgXVi86LmcAYbw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6669c603-1626-49b2-f4d8-08dab13d5c90
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 19:17:13.0002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5E5d9wcS5A3H6jd7n+FdMtL6MFUw9zB0Iw/egsYeCTnr7d+pdhFx+aZgHbxCryAF0/BMYieOhoXpgy8EtCNpAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5299
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_07,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210180109
X-Proofpoint-GUID: OZg67XYjaN6ocAOKlp6KNpurDxOQIp_T
X-Proofpoint-ORIG-GUID: OZg67XYjaN6ocAOKlp6KNpurDxOQIp_T
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mmap should return the start address of newly mapped area when
successful.  On a successful merge of a VMA, the return address was
changed and thus was violating that expectation from userspace.

This is a restoration of functionality provided by 309d08d9b3a3
(mm/mmap.c: fix mmap return value when vma is merged after call_mmap()).
For completeness of fixing MAP_FIXED, implement the comments from the
previous discussion to never update the address and fail if the address
changes.  Leaving the error as a WARN_ON() to avoid crashing the kernel.

Cc: Liu Zixian <liuzixian4@huawei.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Matthew Wilcox <willy@infradead.org>
Link: https://lore.kernel.org/all/Y06yk66SKxlrwwfb@lakrids/
Link: https://lore.kernel.org/all/20201203085350.22624-1-liuzixian4@huawei.=
com/
Fixes: 4dd1b84140c1 (mm/mmap: use advanced maple tree API for mmap_region()=
)
Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 42cd2c260898..22010e13f1a1 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2625,14 +2625,14 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 		if (error)
 			goto unmap_and_free_vma;
=20
-		/* Can addr have changed??
-		 *
-		 * Answer: Yes, several device drivers can do it in their
-		 *         f_op->mmap method. -DaveM
+		/*
+		 * Expansion is handled above, merging is handled below.
+		 * Drivers should not alter the address of the VMA.
 		 */
-		WARN_ON_ONCE(addr !=3D vma->vm_start);
-
-		addr =3D vma->vm_start;
+		if (WARN_ON((addr !=3D vma->vm_start))) {
+			error =3D -EINVAL;
+			goto close_and_free_vma;
+		}
 		mas_reset(&mas);
=20
 		/*
@@ -2654,7 +2654,6 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 				vm_area_free(vma);
 				vma =3D merge;
 				/* Update vm_flags to pick up the change. */
-				addr =3D vma->vm_start;
 				vm_flags =3D vma->vm_flags;
 				goto unmap_writable;
 			}
--=20
2.35.1
