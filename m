Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDBE65F446
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbjAETSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235370AbjAETQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:16:36 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35A7F592
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:16:19 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305ISls5001328;
        Thu, 5 Jan 2023 19:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Zr4FwLzE/b/njzhC63eZIFLKmXoBo0cX3/2jU2egB8I=;
 b=cUPdy8N1sRcd6gNNgSwYdyYYICHYFehOMPgoZqD90eryY4DP8ylPtGVKpSPzJDcZ0UHw
 m57uCdVx+2ql6PSb9Fp2brX7uIOXWNh4vkss6AH0tlJfQwI8TidFbhSo5jzJEbXPCG7k
 JcKugOGg/xlVzLyaa8zkYnIRc6mJmPzNJK5/3OiIort0wFloxbP1jEiYNlh7F6aUZ8Fh
 m05wEwbOaQHTMPCeidNNd7K3X+NVsK6LsfELgruG1UgMgADWSX8jyp6Vz6F6CYeFqX5b
 ZuHB4sZFxPO8hBX0zeY7HsYPJRbGl/FsayHQAAGUzHUwKVld0fuaU+i4aiCkyZoYB+Bd Gw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtd4c9qvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:08 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305HgaKU033879;
        Thu, 5 Jan 2023 19:16:07 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mwdtsj1fk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhXuVSzSxFJjI0NsW5ofPk1s3dOVK95P1FdRvGW4u9fTAJ7CRJcIsfOYBcpKx53kQnSC3pwv8qu4VZy4cCJH/eISRb6NL0ns8/+h+vnWAYGPbDmNyNm2nHZGjf2NVUEabK6+WOBfVO/ENv8zQ+nmWYdnJuJbZEyvww2hGieUT4o/LaEMHDzFLLuFPK19chQyDN1Cq9Et5PtaKRKc1wwAzNd4hcYmb6MAswAVTUXV1ZsrZkGUVVPqsmHiqljLsuhwUbLaWc8YmpralPaU4YHoH01S+eX81d3ANV6T7X9flgEEOcJ9pM+rkySd6ZSHOVVP7jOeJRdjfUCX6tuvLU9uBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zr4FwLzE/b/njzhC63eZIFLKmXoBo0cX3/2jU2egB8I=;
 b=UgrnDo2bO67N0Aa1rkrN9RUGEy+0yWZJxn954bgjRxUFLTkG9dazKOua8XgvBLYJ44uKMnoQnjhClQnOb6N+FLsagMExvVEydd8+pEqrGeZRcm0cC5SVB+jWTKQEp1rLDjBDH/C/tgxnHRyECds/4X0YMKBTj7Xqhlr/gD4kxPJMrHt3E2MfVww39Ce64hJuo9jIiQwj05oCfZ4pKaAO4I+21WU0sF7Ib+mrHA/lV0P7/bECny6tBTpeV7KF45k7+3FAIFgius+MToqoWMBJCk/OXehNCiEFyllSLIYiTIbVeuxGKrLnv98SE17FCf6tPgxg92MaQtmhktNDddkgnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zr4FwLzE/b/njzhC63eZIFLKmXoBo0cX3/2jU2egB8I=;
 b=FbBJvz2ImfBnqpMUYWrybVWYPUsHAFL27cCtrdbKNBk/Ol0E4x3NDlxnKpP3H9G4vcnFt9oCZZMvpqBsz9bBhtp2y/VX61/kAN7+66LNPXWqdu3VCsLNdWjdm+cpKMkXVkhkMCtrf0q0D6p20a37CsDmaEO2+nN9jcZ/4g7RA1U=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6075.namprd10.prod.outlook.com (2603:10b6:208:3ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:16:04 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:16:04 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 23/44] mmap: Use vmi version of vma_merge()
Thread-Topic: [PATCH v2 23/44] mmap: Use vmi version of vma_merge()
Thread-Index: AQHZITok3mxn2Z7QHUSRt6A3HkOq/Q==
Date:   Thu, 5 Jan 2023 19:15:59 +0000
Message-ID: <20230105191517.3099082-24-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|IA1PR10MB6075:EE_
x-ms-office365-filtering-correlation-id: 4f431749-87aa-460a-1831-08daef514a09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rT8d2PYjAc7nQMmGwJ0u/yyUlqUaXth72o40y1+Ix1IWMi9jWc47ReDY+SiRxCBAR9YrfLMIB36RZSv9jisxI3F3HxmasWQS+4dvikwh0fu+9wMfOwmREE8k6Zg38vspbfYJr/Mc0eGAjBcJvFIyY4juJZlPAORb9CJNN89gQZmfPDZUF/EZBpdfH6fXjySzdziovQjskgtV/vYDkY5o7LvYBa1XKQRjZPrpoJtI4Q7I+thphyj3jppKeBiwoD25laPFUcJnbTzxFNXT3NQSoijvm21AgjS2uNq3aCk3OA0vWJ6RsMsqF+Z90SbmY9xqknDXDd7/womC1kYNSWV6pnFXD2jfgZFH64x8HHPEvyRKUOMyU8rN/kau+k1yUiAbFA4LQ4YT5AvQUaWZ7p7JzmR6R2A2kaAmZKx5wyQiv3vK+EJD0Cazy87Duqkm2t46kv2p1sUgRI+UexueA5hY+/iWOmLv9zu3E9WRRAPgvfRVd8DKJk8LfInci2j/qiCmCJjxHiYWNywDK8wR5pEpgOzYvtyNivfX26mnRrTCqxPBxPT/5utHNSajJhanixM+YLGJQtf4nNnK/oTNRA1UuDI4WRDP50b+d9VIIf3Mh3GIaiRhJOfO+tJqtlo2LA31dlwjFhq/PVBRCeBaSpaAPS9wsXuHpbNUdQ5QQ/8l8rYtgFf8njHv3MWUlwUAqhdA8BvqT+n3Z6yMl8qivvIrZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199015)(38070700005)(122000001)(91956017)(86362001)(38100700002)(8936002)(2906002)(71200400001)(83380400001)(316002)(66946007)(41300700001)(5660300002)(44832011)(64756008)(1076003)(66446008)(6666004)(4326008)(6506007)(107886003)(186003)(2616005)(6512007)(66476007)(478600001)(8676002)(26005)(76116006)(66556008)(110136005)(6486002)(54906003)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZyA/1qLa6DCQArXpDRypN8/f3oNcwTROAkFi7PkPhMz7mDXnlQ4O/KPRbf?=
 =?iso-8859-1?Q?ulP3b/4/31y6F9l/tA4/9R2k24ZUrsyc3RqUNE374Ih2SvFLYAW1y7ST9O?=
 =?iso-8859-1?Q?1pgOXkp6U3LPJYKj3CZFVH34jMdKd2eV4WzjZ6WbCMB4gjzdzZIOIMAgWL?=
 =?iso-8859-1?Q?wA/Bhf68jIKpzJJGDvq7XYftmI+q1NzM4yxKer1JQJ8XHTUPjAfdbNVAwR?=
 =?iso-8859-1?Q?vJMtFwy5xEtZnPfxRl+iPrnapAPitfbMmxMhMGxARJ7kYYlM9uDUTW9jVc?=
 =?iso-8859-1?Q?XY0YCg8g6qduilKVbfozCAdd3JowOgdz8f6zWdKgKK/aK0LVyxaMFunrQh?=
 =?iso-8859-1?Q?fCZRlWxkDl3s0HcL9maDuAYWCwtYrtRFfyG69M5p/efFtvlAYBeTkGlrkJ?=
 =?iso-8859-1?Q?f6cADNeXz3e4r2IqZKfwlX1Rj/V/+OR6vx8QZPCqE4gDa9l5hHtabqfThJ?=
 =?iso-8859-1?Q?aAvcwMN2rNhNBbt0x68EDkZqneDU+99foy+cn6fhM+rfn8rE27EuQuloAc?=
 =?iso-8859-1?Q?R/rUHTDcmk0f25EDQdzcdBubQzKokJLWpHp+Pb+mUCgSLgBQIqiZmIz/4f?=
 =?iso-8859-1?Q?hDpJsvMTrCmrdNf0WAEomm8uhbcKUfLBPQrFdPcDVi0nvYMGVztlSWCw+M?=
 =?iso-8859-1?Q?PGBj2ZzIhrxXQvLsatNKaX0a7C7qUmzJ+mpx3Ei8EQgDGAVNxQUeJU5pW2?=
 =?iso-8859-1?Q?nMEUO8ldInng5HzMga7YvM5+xwelX1SLlV1T10ZpgUVx50rTzSmgyK2ywm?=
 =?iso-8859-1?Q?d7mUlXzSo6pazhoFzxTSkfOwx639FVK2+ilR0HPG5eaqcQ2AAauWTiaOQP?=
 =?iso-8859-1?Q?KvM+PQAw115xoqk+D4HUeQ6r1oUkCissK1qajNcX9X0vFqoJpZs7ryo3YU?=
 =?iso-8859-1?Q?7xjlKjn39Wpccth6c9J7CWKx9hDwr6IILkdKIisN1PxDjK3auSTzp4o3VJ?=
 =?iso-8859-1?Q?+RwW4KKiGmK3cFGsJrT0vXNFI4JsbRNmNSLO8kpGg+SLQxE90OTy7mIodR?=
 =?iso-8859-1?Q?sw67s1ywo+9AIOtkanMGW1rIn3N/AF4R822Dni7P0rb/idXrRHvxdJJdkP?=
 =?iso-8859-1?Q?4g2juMI1eM8VoC3+a10LnSlKgS7DnYbZRclqW71MSppGZoRJt1L0yXprGu?=
 =?iso-8859-1?Q?BbYBOf14PO4jvbeMVZSiqOlQ2RwtEI30yc5qXdcHv3YdHfgH57tynDu178?=
 =?iso-8859-1?Q?zVaob4QwGnP1Ey+tFNG5vE9idj3/nn9JFcsqTMcNY7MlfnnkmdrXAqMl3W?=
 =?iso-8859-1?Q?AMOEPZ8OTzsv7kxsh51EajIrZ1f5L+D0RqQ6lgYq1SiUS0MMliOBLGbgRy?=
 =?iso-8859-1?Q?JyQ+FEzePsjLIm3kbEhHKveuu0ycj55UrX5VI0daTMG3ChVSqZjJmoLhnI?=
 =?iso-8859-1?Q?Zm81+qCzseE5EmOjbKWWVekbwbA1x+hNeegLdTOq1C/wG45zmx6iIHGetO?=
 =?iso-8859-1?Q?xVJgyTTByUclrwF/IF11BFtxvjJQ26eSZR+aqSu4OhUL7I0GHfClKYU7xW?=
 =?iso-8859-1?Q?p7/NAfJWVTEWOSJCeU3MoEoKmOepsiajURmN/LHnV4F2KLRwhGHRMS6ta8?=
 =?iso-8859-1?Q?+SgupVqVWXqiNV3s21oidJorx9jh0mxRKkuk+pEabjYE481rdxrdix/0Fi?=
 =?iso-8859-1?Q?H5ltt6EF1paUMFDGxHRKZERfNd2/9+dJq8zOkMR1lYE/4Y4WuM+FuvgA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gADY0+U/JfP0KHlXbGYWY4gCLY7L/0GtXJ2M3qQR0Ffmxty077CG3S4UsKkucK2ldXumzA12/+/dS543vJ33A0qGC+l5pkY8fkNpJqJfW/2wCVoNlN/JmhzgO2IkWrVQPirL7TUlrXAhJvOxTWl6VRelFkbiTcoi+SCY4iO4iFhq5qT315hsOR/bE25KEA/ULXe1BJyk7VmFbHm5DzMzq6r1nZ0REyhWW8yLxnBpXSebNJvDoxfhR9vrADjEHY/QVcqIlCafoEFEaUADdb3fxbYGRMoEjKq06fMhpUbG7mo9+G+CsaMTpm+5s4R4e8o2yjhsjBYbqNSMTIKObfqo9uDyczwnl28DgOZreJucZFtMjcTH9kSQCjAL5fRbjk9LWwktHwk6DyXvYuqu2N3Q9gxopkStBGhTkEvsqFkLgEgjk0wrBzwh9jrgJ9XOlpnHbecsfBaKlANAurJXjmVf6es8FfAlOGmEcdbTFSGGGMtORVlgRKF+VJB/F3zg1I/bGdOPVVdKMq/9QEbcSW1G2FWu1MxNuuF0+f12M8TKGSPOFMQq3Ay3ly38qRmG19i6Ebr0hqcd2gAJEKK8RUIdBLWggn9gGbYBQcmHLb6fx94qme8wCx1b38iVw5dUDxEqmU6hDMx4IG+A/NJsXpMevsLbB6HK+46gbPSAZLOsFFVSmwcyC+6upCIbm26F2poKEFV8Wmnxw4eFtJSB8nsgDxY4+df/7cssZTC9erwoDzHY19o5PU43UeDJzAd1/4Y1SZbHE1zsEbLvbHlM1Cr//vTYljHvwkSbLVGUAeK33spgFcbOcc6XucRPzyrwmcaLBVJldavuu948hnAm0N2pXP3ERj05FX+xDjpz3hsAGzMMnaiZ/X17kI3eaLtra/Pjp48TJgZ++vrkiNfw0wXihg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f431749-87aa-460a-1831-08daef514a09
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:15:59.2661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VxluFXGCff52SBg6Y0oA+diM+9UynTMR2SYP4o82IDT2eBJ7xQZcLd9cdj+5rcNB7c9Q7PzeFyhHi0eemqb3+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6075
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=994 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301050152
X-Proofpoint-GUID: oYzx-9wJdQ-c9EJ-9bu70zptPwzFX547
X-Proofpoint-ORIG-GUID: oYzx-9wJdQ-c9EJ-9bu70zptPwzFX547
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

Use the vma iterator so that the iterator can be invalidated or updated
to avoid each caller doing so.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 80f12fcf158c..579d586e4e6a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2748,8 +2748,9 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 		 * vma again as we may succeed this time.
 		 */
 		if (unlikely(vm_flags !=3D vma->vm_flags && prev)) {
-			merge =3D vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags=
,
-				NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
+			merge =3D vmi_vma_merge(&vmi, mm, prev, vma->vm_start,
+				vma->vm_end, vma->vm_flags, NULL, vma->vm_file,
+				vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
 			if (merge) {
 				/*
 				 * ->mmap() can change vma->vm_file and fput
@@ -3280,6 +3281,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 	struct mm_struct *mm =3D vma->vm_mm;
 	struct vm_area_struct *new_vma, *prev;
 	bool faulted_in_anon_vma =3D true;
+	VMA_ITERATOR(vmi, mm, addr);
=20
 	validate_mm_mt(mm);
 	/*
@@ -3295,7 +3297,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 	if (new_vma && new_vma->vm_start < addr + len)
 		return NULL;	/* should never get here */
=20
-	new_vma =3D vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
+	new_vma =3D vmi_vma_merge(&vmi, mm, prev, addr, addr + len, vma->vm_flags=
,
 			    vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			    vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 	if (new_vma) {
--=20
2.35.1
