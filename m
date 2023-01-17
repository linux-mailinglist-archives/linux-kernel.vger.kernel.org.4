Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A4866D47B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235640AbjAQCkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235624AbjAQCjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:39:07 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F051120052
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:36:05 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H09iUX031115;
        Tue, 17 Jan 2023 02:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=nKYgxBDUWbuTfPdOcKllo3rtgEDu0zvYwzkAT5I7xWo=;
 b=dVBlbFsNrzqZpUO66psPS0ttaKe2PgylRbuRtFkitLfl7e8KtfumKBZM/uj92f9gyolX
 7ZHI8yMPLHRfsIGVs756t2MX7PVXP0kBuhURkJYdSMj5i2Rc2Qc0kailGIs+3cqtpALG
 wqs6JNb1RjD8qgcyjaoxIi6KVkogW+MeIoOepD1NwDuDV+BQccwaVO+xaoz6BI2+imsJ
 Zr5q5b4e/IDFk4Z1uP3zVhcol1FCt7Ips0McUgkjCGvaS0HigKdgBKcbBcOwE7dE8zTn
 qkTtOmcJStAPPpsFDZejrGChNR4pGSDj4tM/TsxCYquT+70uhToW9pNRZDFb5XAlD7d+ ew== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3mxt3pjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:35:04 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GMXP41028373;
        Tue, 17 Jan 2023 02:35:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4s2rfy4x-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:35:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+Ec4dXDYDwsJfubFWakJNVHl6HwS3DOyHFf+Y9ZHES1NJzIXcjUn8Qk352R2tSfhox7QcMKzOplmUeDbZxi/P/2kxNp+tHinJqB3OA908KilU8JFWKPILMdpaPlz++VuZlLtiAEmUST2zMbwsumg+eJpE/uEZlXwUTFG4yztom0hrryuSmwy7+nCR79Ihj23IuAwFg1bhI8KK9W2x69wx73YkdHYNYop3svMaOFq6KuWWM1e61HIrDsOWXBKGYvGHvQzrzVH2a4Q2U8z0dGYDFG7NoZkVr2/nD13H9Be8gLn/hxDdbKVeTxtkqsSgn1O3N++uFfqONRKzzmvnGBig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKYgxBDUWbuTfPdOcKllo3rtgEDu0zvYwzkAT5I7xWo=;
 b=bnqQAJPjs9hGyDq6Z3l6YwkojYNmYDeG8QoYC2FKhQoLFckV3XFcNUzBuNI6gWIdK+kvbTHmPbAsy2t+u3FSb0I28tt0evdno3oe5rIAn0kgc51qXbZe4OGF/PXIYGG6e1TAEWhpGlSVKRDFLUsrHP1DdZBViMS5y2ysELJMvAkf4Ub/p0BEQAFY/H7HrvSr4I1jeAFeGNH1U0ktoITopeuSIoLwge62yvjSN4tqg43VRtYaruxFoZmuVp5qgBhMvjBwN17FPKLHMZm030xpt6hTwxSFGdOiZ+E2A+h0di2Woy35rIYJiznuAzQX5h9Af5os/tKXaaoKVx9cX9Rflg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKYgxBDUWbuTfPdOcKllo3rtgEDu0zvYwzkAT5I7xWo=;
 b=NKcNlDgHVOrGjkE6WZ/kp+lWrEKZSn8KLh/SnfJb9E3VCQwAU3Yen31f+5rvdOT0TSslvnTWVHgna1TAVc6SWymUqdbavq4ycw6P2aCdAx9NHnSDUQYIvnZZdejuOnETh/GKChi9DBUaPsb6tRDt6YoCR2rGPfLUr45y6EVpJ/g=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4814.namprd10.prod.outlook.com (2603:10b6:a03:2d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 02:35:00 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:35:00 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 40/48] mm/mmap: Refactor locking out of __vma_adjust()
Thread-Topic: [PATCH v3 40/48] mm/mmap: Refactor locking out of __vma_adjust()
Thread-Index: AQHZKhw1KXF/6poDekGVArsTbox8bA==
Date:   Tue, 17 Jan 2023 02:34:22 +0000
Message-ID: <20230117023335.1690727-41-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4814:EE_
x-ms-office365-filtering-correlation-id: 3747c4c1-c849-47f7-c3a2-08daf8336e28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4xpX2ex/rGl/Zlp+phsFoumClsE9ppinR+3GYxLcaSU0xrIFAaECyDjCV9G1qpYtL8l1+Yw1LwRzCy5GJ442GN0oAp5Ks39ma5llolLVT7lCOdwisekNqbzwcFprfqmWNafJ58nXxNrtYPEi320k4U/SvySh4HA6fIKO1VY27X+b44HopjRbMR6nnyDHVNVzy/NeT6JfjbzlBBWecerUuTyDbg5eTgwFIMER3NpMUDccJe8bLM+YRDKqUdtiI0//vRkVR5xEOXxSJHYvGBXrO1HkYrCSxvvicUOwN6eTjLKGfNccS+HP0aRJOnDmMauyQs/75b+vGBhHbCtGW1wfQ/IN/Z78Y1928YwfIyzzNkbRi2z7G7yDWrlQJlI45OJfutDlvfayLOFPFktV7LOxzOPoljA7mw2RRzeDBvfCRsinF/eyPr93JdepgO73nf8DbuPp4MO66tNPxckgdq8fFfH3lRVIflFnZfvBaEpaAfmNd0g/xPsW4jZ6VSG1Ecz8jIR+xe7px/X8Mrgna4U1Cy2bQxo31j09N5UM8hoO5XeJIM1ObwRRLAb7riwlnUr6gr6nwWSJ5l8WC0r8B7kXnrgDLAmO/yPTnoxniRkxe1C8nRMAmKn36jSJUpXCD71X1RrA2cYOzCVsFNW99zZJsSjjXq0KlWFQlaYiM6HQmOvDX1v379g14VTH319q0hueO280Tq8UxC8cy5v0Maw2iw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199015)(6486002)(6512007)(478600001)(186003)(26005)(6666004)(107886003)(71200400001)(6506007)(91956017)(66556008)(66946007)(2616005)(76116006)(66476007)(122000001)(110136005)(316002)(64756008)(8676002)(4326008)(54906003)(66446008)(36756003)(83380400001)(8936002)(41300700001)(1076003)(44832011)(2906002)(38070700005)(38100700002)(5660300002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2HQXNVV49/3mY+FYZf0FPQv3IvOWuDF7js5SEhELLfvwOiAdbwdv/fL7Lk?=
 =?iso-8859-1?Q?/0YBnrkOLT8/a7EzuZowLl6QiAiPp1BukDX90SRwc2HCHw0tzSkujwMKaz?=
 =?iso-8859-1?Q?Lr2Yc7bl4osf02TiADGOFYpwg7i1DQe6I/YkzvV6iykjdvjv3Kp8X086Gp?=
 =?iso-8859-1?Q?wOCBWAlK0LghBnrKPjvWhvvv/b82FspwJqyvY/HJBIA8vQP22uN426pS0+?=
 =?iso-8859-1?Q?KYsV4N2665vB24fItp0A4UGJKQyBXQWkCvB+A8Eo/ek3jDoNq6IlFirlso?=
 =?iso-8859-1?Q?GSGOkSId91RKK+uZwIdnHrVGDOQ2x1nKGLDT3cNF+GVQUUwyw8xojR/DRn?=
 =?iso-8859-1?Q?4wKggoA/h1q6G4yKvLy4W96DU9zvmIxzot5QmVdPodtnUxI/1QAjohSG5O?=
 =?iso-8859-1?Q?qrH7Vuk3CV2uxO2kJ7ghTCOgIHv9nZyBSP/ipyjpnsmNoxocy87+4kJUM0?=
 =?iso-8859-1?Q?/TgSI3k0Sgcx+daFLu7Zcm/uu2wgAPuc5pJInLoL/xKZ47Euc3cTDpjTbS?=
 =?iso-8859-1?Q?VQyanfhEz17T/HQJrJgKyCfMw4h6E8xjYoVtAi+h9c09KrDSepI0ktq+X1?=
 =?iso-8859-1?Q?e6hymmpvdTXqbUIr9kVoJ8SoM3gBaCUiIyT4/A3ZCOfOF6w63cFR+V+x4r?=
 =?iso-8859-1?Q?F4J5huzIBw5jhIkvMVXFqgtkciQKCzxqhNp3z8c1xR/gZ+aWyZquAI+uZN?=
 =?iso-8859-1?Q?XVE/yMtwlS+e53Z0PI453jq0bZejtdJF59+Bd6Byz9CMI88HPWv9SSaZ6R?=
 =?iso-8859-1?Q?dCeCFxKdcQmoHbY+Ky32XtkxpZp2JsmmYnSNEGzEgsm9DGuLKr+ZU3ygtR?=
 =?iso-8859-1?Q?HeF5VWb8Wvncy/yMrdYGPdE5Zu1MnlmJFpt8Xjf8jcCUPuQ1XxxvFI2TNx?=
 =?iso-8859-1?Q?/BUdwSPSqgT1u2W/fy+91x+uXj9LzZmIJHUPehXpsahVjlnXrhhtMHLOD0?=
 =?iso-8859-1?Q?BCDpCjK4xYCLOYTI2fmedL/gj4+ljJnEMcXT074cz0M9w4qoFpGN0bbHYm?=
 =?iso-8859-1?Q?n5Cd/gG/rIzO/71IHAMF9yJ4J2QfMptN+QJeZwj49ezFgDRajKpD0in1me?=
 =?iso-8859-1?Q?jYz8nrcI+P2bh/qS7Hcn/ee/SgOFfPK21CGW4S3y/Q6AWIjGfoWVrPAD9p?=
 =?iso-8859-1?Q?cpSGC0xBZA+mMbnWw9iIgNANNacuFSwG0+ivk4LDjsjoEBYIs++52nvKRJ?=
 =?iso-8859-1?Q?RG5U8tAzvPNC2rTtH5l21vCnUvJx6yE8Bna7zHt8MZQI1mCAryvkBVovlw?=
 =?iso-8859-1?Q?CPDH52ORLtHLr0439ljvF1vgwF1paE6h+t2PlZdUQ+HXs1YH1IIV+vr+Py?=
 =?iso-8859-1?Q?5LCwRLz7CVL6vUkpsriZngY/lojqeP30baoGOVCm6VHu70s9KCoIEmlxOn?=
 =?iso-8859-1?Q?2F8rB/Ry+IbD2gzCtJeHkY+naio2lVdYMTgeB3+6oFAd2d7dU8aUgWvgkP?=
 =?iso-8859-1?Q?0SG2tN0+73rt8buxXsRzUGy+JrJr0xAT4HoNDKZLOwNQ8sRiel6ntsHhq5?=
 =?iso-8859-1?Q?HBOLUFGJGfPJGNK5b5HPjq4+hxz9Dc+RbtPBvFhOTfsjHdTcBGT1Y0CN6v?=
 =?iso-8859-1?Q?D9mXdpVDxia3u3A20O3jEZb0npFMYMlpQx/G8Pm51YlcHfOxD+8R7Co+VE?=
 =?iso-8859-1?Q?1Yd6kHjbmZzdEzf5la/P8QW7/HInvOhMUd3171NLXCurjdg6vFZB/SdQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EJt6s8OQtqs/40Zm/dKn9akNPtw8iam5PAjONinqYiFlvIWaDbd+0IdyTXT+6WW6UnA/OVciF0UMNQ3+iJNjKgP+/9d9eaM8C1iA8NYL67xVf+LDeIClL+SllVfB1Mp5heDA70UK5xjUg4yYUd3RynnKpdVxIPmNqBy6PKcm33bWk5c/msi94QpOmebhixcQoUuL2s9lWgqHTPeF23bYvWJxU4dx2pUBa4FHcbELmlJ6QcJLnrAXNZX1VQWl6CV0bQsU8Xeemug7nMLDU1j1jZWlDwuhFhBpqrOUBTDXYVyJ5Zd/9c0/iF2k098Ip3uTceqwmv5/wPPkP0sZ3s0GP5xVEK893IJu5qMIBNeQ5cmSq5+wPx53cgA0KSmb2cXue1Xe2HOPxlDcGlBsEZhJlSKhwqpTmozjdJ0XXrkajKWSgpezYpNJikoOiotyaDgaOXw7G+ALGT1LhGhlD0DOqXlllDpfes1qNQ2xd5nkfOVPdRzwYjll6LK5plNgfS84HP6IAigIyacA9GyO+VkF5VMVbwlZi1XDs0+LBMLIdq1WmWaXRAgmlrm7n/feodn80P/1H26vLvKwOjeIU9yF8NGVbe1p3RM2tWDidEP4SvWksFpSqSex0jvpjA5Ve45diCDplpLphYI/bgyJQbxitT9q94iUIRPMa4Wv5YpTBsiJ5Q1E+ZSf9lJxNyvva+I52Mff8tuLH2ZzWizT2CvpD+krS5U8GFmxjfciRI4o27cXh6lsto7Eh/rXz4X85BK4K47VcJYgpCUJ7P4np7aJy23sJBVPHBVbnBNrRAHozawTL8u9uC6SGqQWPLtghezsOaK1IHUHZh9utlk4o4NMpaqOE1kKhrInT8m32R5sVnIzazD9iPo/IVwP+0/12MlofQb0lLJJ2J/BBT/siLe6RA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3747c4c1-c849-47f7-c3a2-08daf8336e28
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:22.4214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: el5so73Bzkrxb195TAHNC/jl4kM7uwMPZeGasJrw/hkOot3mFP5uxFiJzDTPhAZGefloh0slP/9GuZdnZphN4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4814
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=989
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170017
X-Proofpoint-GUID: cPj1z6nPzfp97NNrCUAQSY-fpeCzDvnh
X-Proofpoint-ORIG-GUID: cPj1z6nPzfp97NNrCUAQSY-fpeCzDvnh
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

Move the locking into vma_prepare() and vma_complete() for use elsewhere

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/internal.h |  14 +++
 mm/mmap.c     | 231 +++++++++++++++++++++++++++++---------------------
 2 files changed, 150 insertions(+), 95 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 1c3eb70b7a7c..eccfc1ce1f49 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -913,4 +913,18 @@ static inline int vma_iter_store_gfp(struct vma_iterat=
or *vmi,
=20
 	return 0;
 }
+
+/*
+ * VMA lock generalization
+ */
+struct vma_prepare {
+	struct vm_area_struct *vma;
+	struct vm_area_struct *adj_next;
+	struct file *file;
+	struct address_space *mapping;
+	struct anon_vma *anon_vma;
+	struct vm_area_struct *insert;
+	struct vm_area_struct *remove;
+	struct vm_area_struct *remove2;
+};
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/mmap.c b/mm/mmap.c
index 90638fa48734..786d8181089f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -576,6 +576,127 @@ inline int vma_expand(struct vma_iterator *vmi, struc=
t vm_area_struct *vma,
 	return -ENOMEM;
 }
=20
+/*
+ * vma_prepare() - Helper function for handling locking VMAs prior to alte=
ring
+ * @vp: The initialized vma_prepare struct
+ */
+static inline void vma_prepare(struct vma_prepare *vp)
+{
+	if (vp->file) {
+		uprobe_munmap(vp->vma, vp->vma->vm_start, vp->vma->vm_end);
+
+		if (vp->adj_next)
+			uprobe_munmap(vp->adj_next, vp->adj_next->vm_start,
+				      vp->adj_next->vm_end);
+
+		i_mmap_lock_write(vp->mapping);
+		if (vp->insert && vp->insert->vm_file) {
+			/*
+			 * Put into interval tree now, so instantiated pages
+			 * are visible to arm/parisc __flush_dcache_page
+			 * throughout; but we cannot insert into address
+			 * space until vma start or end is updated.
+			 */
+			__vma_link_file(vp->insert,
+					vp->insert->vm_file->f_mapping);
+		}
+	}
+
+	if (vp->anon_vma) {
+		anon_vma_lock_write(vp->anon_vma);
+		anon_vma_interval_tree_pre_update_vma(vp->vma);
+		if (vp->adj_next)
+			anon_vma_interval_tree_pre_update_vma(vp->adj_next);
+	}
+
+	if (vp->file) {
+		flush_dcache_mmap_lock(vp->mapping);
+		vma_interval_tree_remove(vp->vma, &vp->mapping->i_mmap);
+		if (vp->adj_next)
+			vma_interval_tree_remove(vp->adj_next,
+						 &vp->mapping->i_mmap);
+	}
+
+}
+
+/*
+ * vma_complete- Helper function for handling the unlocking after altering=
 VMAs,
+ * or for inserting a VMA.
+ *
+ * @vp: The vma_prepare struct
+ * @vmi: The vma iterator
+ * @mm: The mm_struct
+ */
+static inline void vma_complete(struct vma_prepare *vp,
+				struct vma_iterator *vmi, struct mm_struct *mm)
+{
+	if (vp->file) {
+		if (vp->adj_next)
+			vma_interval_tree_insert(vp->adj_next,
+						 &vp->mapping->i_mmap);
+		vma_interval_tree_insert(vp->vma, &vp->mapping->i_mmap);
+		flush_dcache_mmap_unlock(vp->mapping);
+	}
+
+	if (vp->remove && vp->file) {
+		__remove_shared_vm_struct(vp->remove, vp->file, vp->mapping);
+		if (vp->remove2)
+			__remove_shared_vm_struct(vp->remove2, vp->file,
+						  vp->mapping);
+	} else if (vp->insert) {
+		/*
+		 * split_vma has split insert from vma, and needs
+		 * us to insert it before dropping the locks
+		 * (it may either follow vma or precede it).
+		 */
+		vma_iter_store(vmi, vp->insert);
+		mm->map_count++;
+	}
+
+	if (vp->anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vp->vma);
+		if (vp->adj_next)
+			anon_vma_interval_tree_post_update_vma(vp->adj_next);
+		anon_vma_unlock_write(vp->anon_vma);
+	}
+
+	if (vp->file) {
+		i_mmap_unlock_write(vp->mapping);
+		uprobe_mmap(vp->vma);
+
+		if (vp->adj_next)
+			uprobe_mmap(vp->adj_next);
+	}
+
+	if (vp->remove) {
+again:
+		if (vp->file) {
+			uprobe_munmap(vp->remove, vp->remove->vm_start,
+				      vp->remove->vm_end);
+			fput(vp->file);
+		}
+		if (vp->remove->anon_vma)
+			anon_vma_merge(vp->vma, vp->remove);
+		mm->map_count--;
+		mpol_put(vma_policy(vp->remove));
+		if (!vp->remove2)
+			WARN_ON_ONCE(vp->vma->vm_end < vp->remove->vm_end);
+		vm_area_free(vp->remove);
+
+		/*
+		 * In mprotect's case 6 (see comments on vma_merge),
+		 * we must remove next_next too.
+		 */
+		if (vp->remove2) {
+			vp->remove =3D vp->remove2;
+			vp->remove2 =3D NULL;
+			goto again;
+		}
+	}
+	if (vp->insert && vp->file)
+		uprobe_mmap(vp->insert);
+}
+
 /*
  * We cannot adjust vm_start, vm_end, vm_pgoff fields of a vma that
  * is already present in an i_mmap tree without adjusting the tree.
@@ -591,14 +712,13 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_=
area_struct *vma,
 	struct vm_area_struct *next_next =3D NULL;	/* uninit var warning */
 	struct vm_area_struct *next =3D find_vma(mm, vma->vm_end);
 	struct vm_area_struct *orig_vma =3D vma;
-	struct address_space *mapping =3D NULL;
-	struct rb_root_cached *root =3D NULL;
 	struct anon_vma *anon_vma =3D NULL;
 	struct file *file =3D vma->vm_file;
 	bool vma_changed =3D false;
 	long adjust_next =3D 0;
 	int remove_next =3D 0;
 	struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
+	struct vma_prepare vma_prep;
=20
 	if (next && !insert) {
 		if (end >=3D next->vm_end) {
@@ -694,39 +814,22 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_=
area_struct *vma,
 			   anon_vma !=3D next->anon_vma);
=20
 	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
-	if (file) {
-		mapping =3D file->f_mapping;
-		root =3D &mapping->i_mmap;
-		uprobe_munmap(vma, vma->vm_start, vma->vm_end);
-
-		if (adjust_next)
-			uprobe_munmap(next, next->vm_start, next->vm_end);
-
-		i_mmap_lock_write(mapping);
-		if (insert && insert->vm_file) {
-			/*
-			 * Put into interval tree now, so instantiated pages
-			 * are visible to arm/parisc __flush_dcache_page
-			 * throughout; but we cannot insert into address
-			 * space until vma start or end is updated.
-			 */
-			__vma_link_file(insert, insert->vm_file->f_mapping);
-		}
-	}
=20
-	if (anon_vma) {
-		anon_vma_lock_write(anon_vma);
-		anon_vma_interval_tree_pre_update_vma(vma);
-		if (adjust_next)
-			anon_vma_interval_tree_pre_update_vma(next);
+	memset(&vma_prep, 0, sizeof(vma_prep));
+	vma_prep.vma =3D vma;
+	vma_prep.anon_vma =3D anon_vma;
+	vma_prep.file =3D file;
+	if (adjust_next)
+		vma_prep.adj_next =3D next;
+	if (file)
+		vma_prep.mapping =3D file->f_mapping;
+	vma_prep.insert =3D insert;
+	if (remove_next) {
+		vma_prep.remove =3D next;
+		vma_prep.remove2 =3D next_next;
 	}
=20
-	if (file) {
-		flush_dcache_mmap_lock(mapping);
-		vma_interval_tree_remove(vma, root);
-		if (adjust_next)
-			vma_interval_tree_remove(next, root);
-	}
+	vma_prepare(&vma_prep);
=20
 	if (start !=3D vma->vm_start) {
 		if (vma->vm_start < start) {
@@ -764,69 +867,7 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_a=
rea_struct *vma,
 		vma_iter_store(vmi, next);
 	}
=20
-	if (file) {
-		if (adjust_next)
-			vma_interval_tree_insert(next, root);
-		vma_interval_tree_insert(vma, root);
-		flush_dcache_mmap_unlock(mapping);
-	}
-
-	if (remove_next && file) {
-		__remove_shared_vm_struct(next, file, mapping);
-		if (remove_next =3D=3D 2)
-			__remove_shared_vm_struct(next_next, file, mapping);
-	} else if (insert) {
-		/*
-		 * split_vma has split insert from vma, and needs
-		 * us to insert it before dropping the locks
-		 * (it may either follow vma or precede it).
-		 */
-		vma_iter_store(vmi, insert);
-		mm->map_count++;
-	}
-
-	if (anon_vma) {
-		anon_vma_interval_tree_post_update_vma(vma);
-		if (adjust_next)
-			anon_vma_interval_tree_post_update_vma(next);
-		anon_vma_unlock_write(anon_vma);
-	}
-
-	if (file) {
-		i_mmap_unlock_write(mapping);
-		uprobe_mmap(vma);
-
-		if (adjust_next)
-			uprobe_mmap(next);
-	}
-
-	if (remove_next) {
-again:
-		if (file) {
-			uprobe_munmap(next, next->vm_start, next->vm_end);
-			fput(file);
-		}
-		if (next->anon_vma)
-			anon_vma_merge(vma, next);
-		mm->map_count--;
-		mpol_put(vma_policy(next));
-		if (remove_next !=3D 2)
-			BUG_ON(vma->vm_end < next->vm_end);
-		vm_area_free(next);
-
-		/*
-		 * In mprotect's case 6 (see comments on vma_merge),
-		 * we must remove next_next too.
-		 */
-		if (remove_next =3D=3D 2) {
-			remove_next =3D 1;
-			next =3D next_next;
-			goto again;
-		}
-	}
-	if (insert && file)
-		uprobe_mmap(insert);
-
+	vma_complete(&vma_prep, vmi, mm);
 	vma_iter_free(vmi);
 	validate_mm(mm);
=20
--=20
2.35.1
