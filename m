Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D7C60D29C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 19:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiJYRhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 13:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbiJYRhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 13:37:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E1D179395
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 10:37:35 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PGTtM2002909;
        Tue, 25 Oct 2022 17:37:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=Ivzr8bMYW9XhxKrnBfg/VW42mo0PVt6KIaKHMgFx5g0=;
 b=oXSyWv8eOYC7eYYTx7MTi1lrLAw0G86b+yMMhlJY2Xs4kzrd/hKZp1xJ/o5iUu+bg9m4
 Pkm21TdzwY2riVuyXshNE/NttoPX6DEhH0bdpGgivD2OgjAtKANo4T2eGo+3uoSpdi70
 FITvO7XYyy6sreCJlN2Fo0lsB1DKi2xIWqhb/y9FpGSkREwLNV7h/Qc36IeV8baTZrQA
 9mqblqwFK+1imFRal5caDE1ccLn3d650skww4XifSg8B+77YKvpVThpxzb6gMah7jI3R
 OAvi+s6jZOWN0pSd7J/czbkqpiCe3zeqqr2kJXj7lrbpYIPfeVdMKqsJN75DdQDBlru5 hg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc6xe3kh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 17:37:29 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29PH7rT1032109;
        Tue, 25 Oct 2022 17:37:28 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6yb57ms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 17:37:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBEZ5f9tv8ieAElD6sRMXBj5fO/ctwpjoZQjEyaQlTDHAXtFVl3N8k2K5vzKwlKvQ8xx/Wjn3HErO9GNdJilqIgO6aVKq0IjMKb78xR8PwaJhIjLd9nfM5vDb4+/cvxx6KINv7UVg9+2edaRVrvq85NAF64hOS5xt4SJCKeefM35hGEuADGKm5+FcQ8kKT7430mgmF7CtwtpTa9NcAFk1oXiJY9e9BMbG8s2dwIZpSWG0zp2/aMcQsB+umdbVX2TcVgIlUMeiISjUw11hhxkB4xtuX0//DtNsxCgpxIBJbut3evaObYsSo6p+6gDqO3TEqTMllttLg/lT46EXcnFCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ivzr8bMYW9XhxKrnBfg/VW42mo0PVt6KIaKHMgFx5g0=;
 b=Ffzo/w06uUn1/qTUEeulc4udkgsDg9Ti1sbsIUykqAlXB+PtcM+iCuWsB4EZR9aEZ+3jsPcqYe6GFL2m2qX4dpS01vtqbRyLMdiXaogo2Jb5MIHjQtXQZv0FpUr9I3KKz/vRhAbK7gbmwhqummH0ug1z9ZCL2iwAeDEaylWXtpRUpTV9bZnBEeDQKQ581TG5EMAkwMkEVFWnFmbnGWvnvivgVINJXZuMGGERCP/MU4y1XLnO76gBh0Xl8mIPm+gFZtP4lqKwv7OI/+w01d3vN0IZ/lmJrTt21uSRgQW5/AAZCdkllyQIlYm30hyz7MCoJq7TlxnsVXGr6udsBn3snQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ivzr8bMYW9XhxKrnBfg/VW42mo0PVt6KIaKHMgFx5g0=;
 b=iJNTK0117d5KeWubPm46N5hcff//GjrJLgxlQWRd0+oG7GQyuScsLom+VVwP6MRvd0pA/VUxYt60VfW981MTmhRXvYTNc2MKVe6OtKRCjXsTq1ogF5WnfdxLmJp4KbS/WJqrMfVUM1IYbjOX6z9aTfwU4E6QOebIXIvv644IA44=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB4287.namprd10.prod.outlook.com (2603:10b6:208:1da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 25 Oct
 2022 17:37:24 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1%3]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 17:37:24 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH] maple_tree: Update copyright dates for test code
Thread-Topic: [PATCH] maple_tree: Update copyright dates for test code
Thread-Index: AQHY6JhxlS23wAlQEUOvY7yAFvPvaw==
Date:   Tue, 25 Oct 2022 17:37:23 +0000
Message-ID: <20221025173709.2718725-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|MN2PR10MB4287:EE_
x-ms-office365-filtering-correlation-id: 77b9c36c-ce2f-4bc0-c60c-08dab6af93a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 727V9zlb+HsqweQS2J1zSlBkmWaGK+GByVIxekg4hP1GaLQmKyHAhxOK79ZFTQcrdj1pXjhtojwhlzXCJmi8TSa5ojAgCdsobK4L8tW+fE6QTvNUDxhdJdScrUbNdCHh82AKZ/o+CdKEu7U8/K+syFml/QqUSICejvOaXMtck+eEUm/bDO/seHFRCEv3ZW+ZJLXjHu1LQG7g8IIsfoHY6BnAGVYrpejbe0hbA6OB5EyEh0EI3X8GL3/ilRvuWkmExADiJQBCs163SlJUdwnvXC1CPZmDYml6CtYXpjOw9YHeq1bqfEc+60BToJ0yg+z+e+tyBM8DgyFM4JQDtNu0I8D0aoZqB3j6riE/kDEJQ+vdy7Y1Bjc1fe7UrjROFZTmtX+ehk8jg2pJOCMdrpmNWRjMxSdbRdeqS8j3ZdjCfmt7pMSSzVqGLO5az3HvhY8Q1GHvFwYCL8SLqPKGpFvokC8qPiHluuB4FA3csXI/Lis3JRMaUFnFwJgn8FVgfBJ50viN3Z4X5knjxgX7a7OZfjYtJE1dUawmeGkD7uXxDg+4NqQLBEMMMChX7xwouhSXOB7NdIcbMB8trl9SYUSYRJ/nACU4/Hv4h7YtMw3VlEIBf8qszIcjLQ5kxf2qeW6WeiGUQDtKWwUvLhmrrERI2rp6x5gSEbuONPIYKI9+OmMYjfXihQQqiZ/LtSoRIwuFSKlsb56eIbVsLB7hsCUTYkNq1Yi/QavmN5esWEhTQUrM+l3XeOBuSggatt3V8s/tHuGUFKLgboYSUMwxkU4Idw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199015)(478600001)(38070700005)(38100700002)(6486002)(122000001)(71200400001)(316002)(8936002)(107886003)(110136005)(91956017)(6512007)(41300700001)(83380400001)(86362001)(2616005)(1076003)(2906002)(26005)(36756003)(76116006)(66946007)(186003)(64756008)(66446008)(66476007)(66556008)(8676002)(6506007)(4744005)(4326008)(5660300002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KDzhiejwtJHxdjma0f4l9M8u7h5no7YI9d5pDeotYhszwaLqe09oPfCW/S?=
 =?iso-8859-1?Q?Qt583/a/UZfP+ZGI0kor1UDybcteyu5xh8xbo1eVO04lh5Clm91aEDqAeV?=
 =?iso-8859-1?Q?NIxCkC/oxLzFMWWdW1G6+EZzqAj2u+JVj0KK04+h4SwLP1aUh47wkRl79S?=
 =?iso-8859-1?Q?4XsS3+sGQiGC0tTVa8PxC9z/cfYMwtBQtA7Qi88EczkIn9ULVUB+du0pZT?=
 =?iso-8859-1?Q?EgyBes2ru8Eur2I+hQDnVgnkOZim03pGZwuMtM9s5FDkH1ATuI92YMX3Mx?=
 =?iso-8859-1?Q?GZQqhioRE+2a55C0/y1OHzGQMO0+gRSvy+3ets+UuZ7XRYDqN+dCXgDywd?=
 =?iso-8859-1?Q?WUj6kHLklcL97bQLPKSoDcmAevMX4bVeFrCIlORFVrVqmN4owOOEuPmdRh?=
 =?iso-8859-1?Q?GZ4TuJ6z5ejQYpN2P5NnfLA6wV/118VYDRRbuUDuCV4sjgmkFwpCXdx1he?=
 =?iso-8859-1?Q?iOubeONDQJ0nPzn7R+I7/zcio69hy+NhMcQGALV1V/sNoZnpv8O2Ol5IMc?=
 =?iso-8859-1?Q?FbFqx0DVxcdR/hHLI0yBScvkhKfebGXvFtTOYM1DRuwPXrJljm9KXeGMOn?=
 =?iso-8859-1?Q?I3BUEGtu6zB7FuINem2dDi1SI1/IupEalYneYBpnt258PJmv5S9DGBC4Dc?=
 =?iso-8859-1?Q?U28pDGGyI3nLAavnjkHauUjdyjIaLxQCJ6hRMyjXnqfVNs3X8JHXgKoSCg?=
 =?iso-8859-1?Q?TiK2RxEUSnX8EBWlmNjTnGoky8TdUMWWmC7Pl6ioer2qVEBO3pGWYyS7Ow?=
 =?iso-8859-1?Q?DO2q2vSK0K6u26wVPr4A0ocWGrCTtPBhPzDkWmHQByb8KYkSEp+5kUUBWS?=
 =?iso-8859-1?Q?w7K4YEKGkSsJ0F+/dj0dyBje7heAyU/OnWQGSxzngTj+U0KH4O9S9ARQCl?=
 =?iso-8859-1?Q?JGpIyfGJGZ6FO5Iyx9o84ik6PL5D12yaNldL+rL3M7d5i4sd8tXAjCi2Wr?=
 =?iso-8859-1?Q?BqsEEn19zMGxvH2EU+jL92GisZLLBIf/OQELg5jP/jbWvNZULtiSyrvJ0V?=
 =?iso-8859-1?Q?R4u9twAt/dFyADyZ5OvqRgEPxCIo5Cyg5Jh7p/+zNhhQLwB1zHp7skIhfj?=
 =?iso-8859-1?Q?JMsW6b6YImzGF895u3TNaDK0V1wpmtGlcjd8ldO58ntPxqztb2Hhy7buZQ?=
 =?iso-8859-1?Q?8IljSVdlbFka8sGMEUc7f9wNtypH9iU3URzjloVuaAHZMIPcei2rNO6k/n?=
 =?iso-8859-1?Q?spGoplT3p9mB01fPIo8HizbP601pUFQy8hfh8f1HgvN9Y+FbgC2KWasJBp?=
 =?iso-8859-1?Q?KR3m0QBE64+QyD/kt6f66zwUCUfdg9dZ07a0OuXvZf0PKoQbyUcZMtxiVc?=
 =?iso-8859-1?Q?NA5WPVjR2uyvxbjpQ4zSF3zR90j4aQNda7wkSkwQMC9rRnu8b/sdoX5Dbi?=
 =?iso-8859-1?Q?GS6rY2zh1FDretai88dXTDQmNRB7Fv78CaxQ/+5vBnRuNag0pFHbcp2rdx?=
 =?iso-8859-1?Q?FPjQPud1pPz/4Y90XksueHFg4+JGyIvfI51KFXrWoUPXlLjsLb2+D4gGXC?=
 =?iso-8859-1?Q?r9346wLIOo9w2d/aLPU1TQQrPNtR7rFW3BcvqToB4IADY3ii/MNBi8RR9e?=
 =?iso-8859-1?Q?+g3/kerUGfIywTQmyEnujt5k25EqNZUrghhWGC5mwvNkTaD7gvdro4pWJP?=
 =?iso-8859-1?Q?oIFMfVu75d6T/c+aqGiQRht912N4yUpK7voek3gHto9OSZ5T2vLHWQWA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b9c36c-ce2f-4bc0-c60c-08dab6af93a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 17:37:23.8197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HnVbytT9s+Dr9EpCf5ijhz31qX7S/OSickrOHSBHAGJJGF9GLrMnTqoYSnWeWh16qMmVUFb8KFVMMUXlkRYtnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4287
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_11,2022-10-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210250099
X-Proofpoint-GUID: AnlnOBI0Xo6A8rLDCJ0AmTVL9dnf0W9U
X-Proofpoint-ORIG-GUID: AnlnOBI0Xo6A8rLDCJ0AmTVL9dnf0W9U
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the span to the year of the development.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 tools/testing/radix-tree/maple.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/ma=
ple.c
index 35082671928a..3620c9e5f7c5 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * maple_tree.c: Userspace shim for maple tree test-suite
- * Copyright (c) 2018 Liam R. Howlett <Liam.Howlett@Oracle.com>
+ * maple_tree.c: Userspace testing for maple tree test-suite
+ * Copyright (c) 2018-2022 Oracle Corporation
+ * Author: Liam R. Howlett <Liam.Howlett@Oracle.com>
  */
=20
 #define CONFIG_DEBUG_MAPLE_TREE
--=20
2.35.1
