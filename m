Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8735465F44D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbjAETVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbjAETUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:20:08 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5956D512
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:17:39 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305ISvEe017189;
        Thu, 5 Jan 2023 19:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=2moO4fYkQsgktnVqqUCvFnFabSTzK46jDsoi7qj27Dw=;
 b=Y9XGCBBP7wkncrZ4P7KfCvvsmsLUC8xw77MpulQGsIq1Om/9I3PZRQd//lLHMxJRIZgm
 aO4Grn7ey7OgwmmQLmUWi+r4vMvqTOmHmnrVc3qCzdOfwj+qeSmvcvVkXDDCIpX68p0u
 SBpXsR50p+HQqAd8OIKhVUM3/tKUf6vvP5Hx7IfLkOfC+QhnvXyZpfcLLrSZWs4/2Nhm
 oJE2mNNWvsrhUWR0Hon98Mc4vpbmKpcy+tiK8rCeQkvPLjkGFUv4RGdGcHNfmZpu5vm9
 ZmOFcmb2ACz4lMDI59l32wXUbjoZlyozGqZBwii5x6KFiGAyxKW17InHrXp8jthtiLa0 yg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbv31nvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305I1EPh033688;
        Thu, 5 Jan 2023 19:16:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwxkf7u5p-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjjHrM+LcLiClL0j/knoyr/RIInUsNXJ+7Olk1XR+zCYHVNF6nbtpPQth6yDodKXOSGkGdJgQLN+O6ijgHWuE8GXx0wIKnQW0wTNK1OLK9egHmhMSIauvkJLdSxX5X2/1DciYwIa8Rz7K58pxmToDDEKuUIwiiSVPvHenuxVGSV+PDWqQw8vY7abMR/ek4wgY9xYuSRRM2i+R1Vb29LOZ/HH1xckmhd8cjdSUXOyiKux7h5xHayCsHIfOr4S5v/yRqStIHh0EqWseLxrXcce9m7L2B6od/WMILB5KUpnQei7m/6QlPPm/tgdzOJOMZxjbpXk8ULzhwpxH4w9/1YS1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2moO4fYkQsgktnVqqUCvFnFabSTzK46jDsoi7qj27Dw=;
 b=hvgcayT8O41c1/ds0q5qYe9HxKpx1ukpnlzls7/l62OWWGbuJW9W7utrC4AyUULKuPNTnkz2EJpRfGtXvKMMWz9PGQu06Ia8uI9yZBykorfVJO2ZJ3Q89DzDxlmZp+9gpp/sKFK/UroDuenWgayNVF8g1NhbtcaN9oihkduUe5FZ0G/8FDMooQMKkG3jY2DmMMlKs1SJGbiGo0aKjgVr5jHtp3vTdGManwPcVb8irc9yGpSx506/fIs7F5WHDCk1xR/Z5wWEsTQX95wi1ug9BvqxIQPomA5ZEPIEMTRptv9YW+tGq8CtVA82d8FX/YMW8wvjSU+If7ON8hjtXKv+PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2moO4fYkQsgktnVqqUCvFnFabSTzK46jDsoi7qj27Dw=;
 b=f7YRrRJogqvg3X+pba5BLYtfC+QWFq5aABVZhvn/iUfBpeRVvLX5mGjWBSJLhsFd/JKvwSItnkFYSwsJmAUFSfu9l1oT11X+mKa0KgCQnL1Teay7oLODoVmUFwUdLBilzEXhgRZ8IMdimsLreae+6SpQYG5A2yoj+eT57mucn/c=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4791.namprd10.prod.outlook.com (2603:10b6:510:3a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:16:38 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:16:38 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 31/44] mm: Pass vma iterator through to __vma_adjust()
Thread-Topic: [PATCH v2 31/44] mm: Pass vma iterator through to __vma_adjust()
Thread-Index: AQHZITomw+hyFh4UYkChdkBUsa/OOg==
Date:   Thu, 5 Jan 2023 19:16:02 +0000
Message-ID: <20230105191517.3099082-32-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|PH0PR10MB4791:EE_
x-ms-office365-filtering-correlation-id: 8cf57c49-f84f-4ec6-a6ba-08daef515e58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2kCCzYqxu9FyjfTIxpbCrimdzGB4uKMNkVMeQequEreOEeq+5VCq52iioC4dvgiCV0OnwLd3oP0qssa15y5XOz6hmcImo6Uxr0AOeSG0F+hkXl+/DIFYJ7rG0fip9BURBPl4kB392a/INQHOv/zpfpUB46WZa9T1/GF0dWkx8tivlhTS3bjt7/hXBSu/ylPLGbUJI5P+AcBd5+85corlYWvq9v8/gibV7iDmASbYi/M/sMioG5XlT5PX5b7ucJ+QZ8zictNmWUxO/6nknZbCfS7dcxhALWFXvpp8syILHVvytYulbeopvSDsNxTbXxyWeGkAeZOj9L+o0O39OrOe2Y05MJGKMUA5cm38oO/NKxeQa71KDXVCQxXRGuCaLg+q212lSYiz13Dw2HWGKKv96RBJWThIuDo0rK9sGv6/DsYeWLTXD9BCWh/xQKSFIjcIHST+EZzT/t8Zw+5KHOF1DuZIBcfmqw5OjMIkq/knq64U9iL3JqEkyqEklpbAMl6/dWQU74x7JJ4kVBCcr0/YHwsaoaktMb3pRFlIEw/xtqWuN51ITB/yE1oxXGU+8iUx/tV+cJ3UIU8IbeGwtbDFHuzHSDiRJzpJ4CRBuE9Oo3PH66g9Vj1zpLOFECdZUiamnK4V78TONrTRqNhU1OPFK1iL/CVWiNVIEkYN90Oz5IZj5wkIlaOME9LcGLPbAQ+SBAPmtDf0vFqfelczLCNLxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199015)(83380400001)(8936002)(5660300002)(38070700005)(44832011)(38100700002)(36756003)(122000001)(478600001)(107886003)(6666004)(6486002)(2906002)(54906003)(110136005)(6512007)(186003)(26005)(71200400001)(66476007)(64756008)(8676002)(4326008)(66946007)(66556008)(6506007)(91956017)(76116006)(2616005)(41300700001)(66446008)(316002)(86362001)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?InBa/RSvzkcZKEcSCm42WB4+hf/D2aYZamjjHFmL6glVhmfK08Ibo+DDQx?=
 =?iso-8859-1?Q?1MfltfwfiSp90L9VJ4KynHq7p4ZMghnzU09gtDdoZdSraWTfVsq/Jz5M8p?=
 =?iso-8859-1?Q?BT0er38qCp6Eyya5FMdmJS2UYnKbdLnFja+3gAzy6Wu/1NahKaUv8AuZ8z?=
 =?iso-8859-1?Q?vxFLbCadmUedFcp3uGELdvBkPedBgg3w8f7QnSLpfcZccKSMxnw50VWlpL?=
 =?iso-8859-1?Q?1OYrc/+6gNbUsOh2OFZknY7LFsy2sl+Pxt4K1Tt2UJaBpG6shOmdoFnqSA?=
 =?iso-8859-1?Q?zbdtCcYoibA15e4KAcHz6DDAAfQR5kkb8kWcklDH/6iyBWo2z/GLFP5gX0?=
 =?iso-8859-1?Q?C7g1gYVSZmmqfK6fa1fnJFwOi5ycpvQE4L5ovkTPvfQheDJnGC4Bzh32lb?=
 =?iso-8859-1?Q?HH9GSoD8X/Mo2nxXqe/E4u9IJffOBrR1wSDDB62raa37pkrDNMSg2Eh+Gq?=
 =?iso-8859-1?Q?oLokHm9Dk5SDeR53R6Ws7rJVWc4ZnNU5raymXnK41gNtqf4MCe3Pyu2skK?=
 =?iso-8859-1?Q?Xh18bJLBbSmgVUlqej52x3o/10t/aA69r4UwnOtEZmlYACGXxdCyer1xTN?=
 =?iso-8859-1?Q?knlczi1cX+f3PJ3vu0y9rSJbNd+SJDwVRDoeIWWQ0PUnr7hzVjQ5DhE29i?=
 =?iso-8859-1?Q?2VGkEFC6d/5M25mDct1mOFhAdNFa/IrA9/b7/bVUgQenyO3ZgTsepGTELX?=
 =?iso-8859-1?Q?QWiMKt8j0CfwBUx7A4+qeVECtGqlkBseJiNNuKAZHfRjJupZmX9EboM7M+?=
 =?iso-8859-1?Q?udjMdYbVRw/8f8/4tUDcVE1sIw9YCEMkSj+AkK4zIlqEliNa1USmVXHTtu?=
 =?iso-8859-1?Q?/EH+YpjPTxHhUKvELMRKAMotzambyeTeKr5+ifG831g4B2dvQDqVb4S998?=
 =?iso-8859-1?Q?swEFU0gt1woaGqSeIBmlUOeGTJA6l5tuZbJsv22HF5FAyt8wtBJaWTT4JC?=
 =?iso-8859-1?Q?BjSVWqK5UtdJsleGmAxKpcSmUIn7D/DUV57E2MlnGEKKIHiEBjwTFC9EqJ?=
 =?iso-8859-1?Q?bZ8OfDIOubJLfEhEstOEI53oPCTTJFzmDMlwlhq0VL9mBDsfMHEcwmXZtf?=
 =?iso-8859-1?Q?BLmZI5Lex3zRDt2hCBC3r1WktiAsN4a19SW0VBtQ96zGiuk6uKIpunltGB?=
 =?iso-8859-1?Q?+Q5p8LUwy/AVuX9CtvVGdJRy2s/b0/TWMJVDiWSOgeMJSph52Y+gx4dE8a?=
 =?iso-8859-1?Q?F/tQVaFLrg3fp4q+lYb9BbkHGmAOoxIdW3bHABDiUsCb3cIq5udgW1La6w?=
 =?iso-8859-1?Q?8PIEvTWrAaWmJMDHKVwkHNJtnszSLk3TVnw6FX1eLoqSSaPxmEujgrjVje?=
 =?iso-8859-1?Q?qfRTSaLN21WJ2LfVbqiabcFVD/GOmk0+shXFqf7T/o7fFYXfKNBUv8xS7E?=
 =?iso-8859-1?Q?/IduNAb3Sow0QMrgmwjP0whBk2+y0Luhd34QVavuA87pY7SOBffqhjAmVJ?=
 =?iso-8859-1?Q?cWMLvRZquxb/l2C2IFHZbae2algCN6eEca4YxjeharTA4drGK59TtFnUSa?=
 =?iso-8859-1?Q?9S6TRo091xj7ch9l2MwhFeIYis1oTUjDJ4Ctx0+qZw0giOh5yH62Ymz1ss?=
 =?iso-8859-1?Q?92rOY4HiKLJ9YK7vjNR5PZMTUOtwvlNcB+3+KKTEMir8K9OqhlabzBA2r2?=
 =?iso-8859-1?Q?7/Em239gXDtI5bwbqXRjX7lsbgw9zIo6QOg8hquGMV++MfwpfsTldYOw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xJ2Zzt1GUXdEwFWslhAvzu8EEAxylbiLliPTsi4xo4McO9MKK9DjHxo5o+osG22sCLVL1g+V5fS8EOT3Q2yzN2S3dlEQkmjAbUu3wcFKV2y3bwQpOZdY4yS5O9nXK3spq1uOFPzkz9zMFHBFgB601vroyRtaxpOHHoUbLuUqNNAaDlQXU8cubk2hdwB7URBZ2pKZpF86crBh5q8ldSNbPK5/pKyxS7dYr+HNUXgvSScswaF+tdZNRsqfXeS2XgAQi+SktYEtBxIlDvkdB0oMGkk2UBh46ZTHF6Qnr6ghJv1t7XJ7rlrLLelmjWOJ7Kpv7+LE2XeAkBTUkbWQtNUnA6M3jZjwv2Bxc/4axHeeI40uAmABvn1GS+E9DeaB16ah0M/hND4rDScQqFVYBgjH7glmjOR3IcDtJ+EO0soKBNsGd2sVZVlWQ941iIqoifPNh8dNgjgni4nfrnfjpm3Qk4l3IPalpOjDJauczmhJt8jI5WPCys1CQ7GWSRxt68WbDnYogKJ4mcNsvR9Ws8HTVLHSdRm+1XxrwRrYT+j/7G9bSaPmPPXnU+s7KiF2U7AraGQJ7suKNQwdyni6Fkhrw8/MMwfk+Pa1y80OWRlfyQdg/NEmRSQnZ0OrWCQS0gmdcD/Ba5fNDyHWuD/ISlHUnejChw0Fru1ZfqZk9JJtOZP+FWZoK+Gsc0gAqf22rH5vvLpaEaEkVlHSKNqUZrNPOlbd4ISFujxNAY8CXoKH+cLXYBFV1oCPc8lWomloPg74cUIu2w5U3r7eKzsYFRvz9zKTomviZx5NDx0mqNl2Qr4ycB4daetaIUn0oDbWaJGgcFQ2TbGeljfniMwt+gJsFbFx0vOA8TilrMrrLkrVQmus4zQctXilcEYBbF05fNFvR+6fyC4G0v+Sl5LZY8emPQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf57c49-f84f-4ec6-a6ba-08daef515e58
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:16:02.1565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uvKVauPTGfZtTfdxgzPiSSZpEweCb+a98htBO62x8rLePRy2ksppNZ321mdNw8N+9b1eJTxYoo7/UvM7TolIYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4791
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=982 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050152
X-Proofpoint-GUID: CwtJVHjGccQ23aksTSGNbw1ur9eDkKKd
X-Proofpoint-ORIG-GUID: CwtJVHjGccQ23aksTSGNbw1ur9eDkKKd
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

Pass the iterator through to be used in __vma_adjust().  The state of
the iterator needs to be correct for the operation that will occur so
make the adjustments.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 174cbf25251f..c10ab873b8e4 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -587,6 +587,10 @@ inline int vma_expand(struct vma_iterator *vmi, struct=
 vm_area_struct *vma,
 		vma_interval_tree_remove(vma, root);
 	}
=20
+	/* VMA iterator points to previous, so set to start if necessary */
+	if (vma_iter_addr(vmi) !=3D start)
+		vma_iter_set(vmi, start);
+
 	vma->vm_start =3D start;
 	vma->vm_end =3D end;
 	vma->vm_pgoff =3D pgoff;
@@ -2222,13 +2226,13 @@ static void unmap_region(struct mm_struct *mm, stru=
ct maple_tree *mt,
 /*
  * __split_vma() bypasses sysctl_max_map_count checking.  We use this wher=
e it
  * has already been checked or doesn't make sense to fail.
+ * VMA Iterator will point to the end VMA.
  */
 int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		unsigned long addr, int new_below)
 {
 	struct vm_area_struct *new;
 	int err;
-	unsigned long end =3D vma->vm_end;
=20
 	validate_mm_mt(vma->vm_mm);
=20
@@ -2264,14 +2268,17 @@ int __split_vma(struct vma_iterator *vmi, struct vm=
_area_struct *vma,
 		new->vm_ops->open(new);
=20
 	if (new_below)
-		err =3D vma_adjust(vma, addr, vma->vm_end, vma->vm_pgoff +
-			((addr - new->vm_start) >> PAGE_SHIFT), new);
+		err =3D __vma_adjust(vmi, vma, addr, vma->vm_end,
+		   vma->vm_pgoff + ((addr - new->vm_start) >> PAGE_SHIFT),
+		   new, NULL);
 	else
-		err =3D vma_adjust(vma, vma->vm_start, addr, vma->vm_pgoff, new);
+		err =3D __vma_adjust(vmi, vma, vma->vm_start, addr, vma->vm_pgoff,
+				 new, NULL);
=20
 	/* Success. */
 	if (!err) {
-		vma_iter_set(vmi, end);
+		if (new_below)
+			vma_next(vmi);
 		return 0;
 	}
=20
@@ -2366,8 +2373,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct =
vm_area_struct *vma,
 		if (error)
 			goto start_split_failed;
=20
-		vma_iter_set(vmi, start);
-		vma =3D vma_find(vmi, end);
+		vma =3D vma_iter_load(vmi);
 	}
=20
 	prev =3D vma_prev(vmi);
@@ -2387,7 +2393,6 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct =
vm_area_struct *vma,
 			if (error)
 				goto end_split_failed;
=20
-			vma_iter_set(vmi, end);
 			split =3D vma_prev(vmi);
 			error =3D munmap_sidetree(split, &mas_detach);
 			if (error)
@@ -2631,6 +2636,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 		goto unacct_error;
 	}
=20
+	vma_iter_set(&vmi, addr);
 	vma->vm_start =3D addr;
 	vma->vm_end =3D end;
 	vma->vm_flags =3D vm_flags;
--=20
2.35.1
