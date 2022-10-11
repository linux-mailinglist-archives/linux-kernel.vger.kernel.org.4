Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20945FBC35
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 22:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiJKUhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 16:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJKUhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 16:37:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4F9FD31
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 13:37:06 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29BKTOEa023964;
        Tue, 11 Oct 2022 20:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=4TMaNIfxX1pd/+G2fn/WOEO+isve4g3s8ru5Nsntz9o=;
 b=0RlFLJO66RgCUSFH6Cv09pPgiYFtgg4FQ80gGMsVtsKgzj7WO7oOWU0DT9Yg2Jk+5Com
 4QyHbRZQLoFlDDqH8qStvaFsNFMd+jS2AANttXNQtIzJF2snoTKTqmtJC62B8rm2ipHA
 M2LFd9WK/r3uvS5V0Y1RgSAGcFGEf5pmSe7+c1x3torE78seRpQLDFNBJS0LoyOOTe71
 TOQykI/5ekTYZK5X6Pg660VZSj2/6yI4NDtU27HvqzOOnuWhKBa8TCBZc0nv0ql82uM3
 f98UkoqMS02nTzXiWTjswVnpybDwwzEIcEFbbQ3hLDKuYtdlkfL47tm7y8Ub7cV7cAbL TA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k3139yx12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Oct 2022 20:36:54 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29BJGarW039899;
        Tue, 11 Oct 2022 20:36:52 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k2ynasqm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Oct 2022 20:36:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTsM1p4G4yEmE4cszxS+W8cs6ekFUe1WJhqJuT6cHNpsePwz5/d/2Pn6iG6X+A+FgsQkLAgc+1TCd6gOethNFDSL9tKVLq7zFUpD5nxhbRCViQV+nuuSIO9UBclG3xKUCzctnc9rV5HA/2Km+fM20UysHItsWZjqtDinCljftfVVwj82l+5Mb11g8YBu2FdOLHAq7mv1wLzRQOJ/bl7bV8FZcotVBEor2+Yckbv8sqRjBey8fyunZ743SU3v6TRwMRHEwd4vc1PZ9kYEqJdQn1D8dVKZTLLhejxIOQq6dRAr9MJBhyglBuE/EpvwJOeyogAfTDTkqJKIsqQnjkwPRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TMaNIfxX1pd/+G2fn/WOEO+isve4g3s8ru5Nsntz9o=;
 b=nivxq+kpwu5hZaZ/8qGx3f6CwnYy0gjTNV6/hVeD97kRIwRBemlmX3CXUCUTG2rSfA1nmJoEGJHKMR027vp39UfU3pOBjyar4KoCneQLPutRyxZLuaJw09n3kagTz0C8FMLLfW/4qno/pGRuhnIJpS2puEs2OGVFjRgfCMV9Lx8Cx1PZnJFuV/ufwI79OQXPm95vkIYpDM3dwCUnyc0+ziM7wCecF6O4qVkAeNxlIpkOZhG+qCpVKoAm5zLZZRzIucgEq6I6+0fDE3xw1nlxK5B7J+8oPAuzlyGu/plwyq0ppU5QsRYDFB1d+xa+mNcf1NDCeK6KymaQ+6GycnhHcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TMaNIfxX1pd/+G2fn/WOEO+isve4g3s8ru5Nsntz9o=;
 b=cz8lRTawqBpn7EJxAN9xaF34NDAhRBqlyHSXgaGF9c5LkR3/e/grbjx4LuKr6/oentu4blw8ZIERsRaZ6bYzenOcKF1PxsqwvACFZQ5yK4YHfJHiPOAsm1SijvMUSyLLxTBplDAhZwjXJRPxsppgCZvBq8jtTBfMmYE2Ye9pvi4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6362.namprd10.prod.outlook.com (2603:10b6:806:26e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Tue, 11 Oct
 2022 20:36:51 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::2d77:5bd1:1bba:df5e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::2d77:5bd1:1bba:df5e%2]) with mapi id 15.20.5709.021; Tue, 11 Oct 2022
 20:36:51 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH] mmap: Fix copy_vma() failure path
Thread-Topic: [PATCH] mmap: Fix copy_vma() failure path
Thread-Index: AQHY3bExhHJ/55XILkGdW3b1/ZlSkQ==
Date:   Tue, 11 Oct 2022 20:36:51 +0000
Message-ID: <20221011203621.1446507-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SN7PR10MB6362:EE_
x-ms-office365-filtering-correlation-id: eb76ca09-ef9d-4b4f-5e16-08daabc853c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DPM0Tf4Fp9iXtwdLoE8GPoL5qI77zABAZycu/HhqGs0AvpNyVeiddfjc45m9ajfRTg/xJIf/jivqmaODluGbeOHF3MYOphLj/8Z/gwc/AWrGOiGTN6jaDU43maPYQrJD005znyuV9/voUQkTBvDVZQVhZKmKSsbONqYrv95NoZlSOoXV+96ml72AwGiESLOvpf5PCtCxSi94jTGlXdadPeO1QdAr3Vsb0nFcz8BE0V/cvLorNTQlIO7wMi1hiv9f83aMmz2GnwqIc0ioElLvbtA0hVLATsy5+yozqLy5pEf5yBeyWASJ9DlqB42dJpHMWCPvhO7858WQgYTFBj+0tKKDuQbgQS3zcP/xFPxIm47gD8Y6YvZvHhkBjXB9kTXu09cOOrKiJ0RBPXWWB9vj9E4mXgwW0jDaGnHPoAb2pwUY7FtRz1GH67Vx2N+LOhHpt01kawstNdIz1CvUus9p0ie2/1Mmyhmj16EYHKbL30sMEj993gJ2TwtnCgpS9wIGG8HApxk4UZL0G1Cod2v8BxyfIU21//jZeOSz9w26vkZRsZQDgM7wM0kcHwtt/ArZ0eW1upYgVnvfU09gLI8UApsDv643QRGh8kp4RE1BO9C+gum0BftbxeJjcxH87WcvnOGYzP0xI02jN/r4Esw8oSQM+kL6lcUpL/gmVVJv4YPbSHuWzFVnuvsgfGNC4sfxmaf/hKQEsrA73Sg+RmqDHFNLOvqETVnrvdvtoufZpQRwB6sebG350e94CDAcS6fD5UzW+MdV382ungcUC0jMhA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199015)(2906002)(1076003)(6486002)(5660300002)(107886003)(6506007)(38100700002)(122000001)(6512007)(41300700001)(71200400001)(36756003)(86362001)(38070700005)(2616005)(478600001)(186003)(44832011)(8936002)(83380400001)(26005)(316002)(91956017)(4744005)(66946007)(66556008)(64756008)(76116006)(54906003)(110136005)(8676002)(66476007)(4326008)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EHkp6wJtfsT4nMBrnt42t6vQa9PIwNffS6bfZzBT5GWYtMqP4fo+n5CDuN?=
 =?iso-8859-1?Q?AJkRdk4oFnDfdR/KezGXSX9rkx9KGs+/SkLqherhtL8yIHmfYNA0gvHnRm?=
 =?iso-8859-1?Q?I/wUM86L8YxLT4URvGc7CskFcqSN0SjHP8QibvAbyQfbM+idJACapwli3X?=
 =?iso-8859-1?Q?V6yGy+AJqBeBMiyFMznVv0UtvrsF//4ty73NuDMtjNMvt2Kblp5+JKgvce?=
 =?iso-8859-1?Q?lQ/AtAARSSJi6q4A0mUQ0PBZ8SYr2UJUr7/1aPSYJ71sfO5Mks/kJ6PBxK?=
 =?iso-8859-1?Q?aqeEV2tV5QIOxPiT/voeru3aL5DkbEezyIDKUwXmEoBiPRhbvfS3c8y4u1?=
 =?iso-8859-1?Q?VhvbAYK7t9WeOfZzz5y8Js2fV58jKgpoCtT6Id/sn8oOY/oBy/uQAa58x7?=
 =?iso-8859-1?Q?lInlBprKMXo4YtIC08m8eK9vqJZnISeh+vW7rsxdOu0LDgN/kxmX4WUyFU?=
 =?iso-8859-1?Q?o8nnoFVg9ANpMSKTVwAEai8+Xd0siNIDtUu2VDF/owAVrGWfexZddzi2UC?=
 =?iso-8859-1?Q?4ioPGfor6QCQpAY3clqMt42aGY0eCChcTaVIVe1GpSONoSa19aqTI3yJY6?=
 =?iso-8859-1?Q?9yA5lmPKt+AsPWGbHeD08Z9az907/hCA+LLseCACwzofz8wnGDjPDByIkB?=
 =?iso-8859-1?Q?004ca9/5UfuFXjZz/dRmrR2jdKNC3TL27fAlJAjkpO5H97Ci/cFDk8IeVv?=
 =?iso-8859-1?Q?gKLMWxN6pJfXxDiIKLiB9rr1HbNqGH+utXoQvDcXekv7E4vHHvGhkBA8IC?=
 =?iso-8859-1?Q?ashyNpF8LjXGqy6tua1I7pgbhaHjWEZNQgFihJX8UbA0rWulELFb0vIqyB?=
 =?iso-8859-1?Q?vW2FFLHZZ6QGK2NOTnb8SWAsvMq40pMyKmnitI9dIftuwTtBQRFVGzHNQe?=
 =?iso-8859-1?Q?AgAVTEIbGiYGpTrbUmdnTlMsrjiCst3yyoonNxwbe6/ByInTsS07igneFB?=
 =?iso-8859-1?Q?UZbK9UNgZPkMYjmsc6r6MDBjM4lJgTosDT9WnAee6S01Nl8aodO6AJwn/A?=
 =?iso-8859-1?Q?47RDtDZoM93HmebEciMLJzP0OGc0z1KcZuX/1x/BXE7JkSNFC4ZVSk4xiX?=
 =?iso-8859-1?Q?XOEFcB3UtSvtIq48Ke+I4ELn90qB2JfxBlgr9Y08r2Dd1oeZMJ5Al9bHER?=
 =?iso-8859-1?Q?q4IrG6OKA8llyHxWuOYCfIAwZE/5z8Y+XTreNrYyPyF2tZVCy9k+kqwGgE?=
 =?iso-8859-1?Q?iQz/Skq2wK9xVU3vNzbAmogwncJ2eACFzsZ/lxoN8M10/O/tv3hGmbUtxZ?=
 =?iso-8859-1?Q?KdMKNYebE5XnEEFBj34QbXLh6JcCcfrqXkQ/4SI2tvEUPs5QWi9iZ6ECPY?=
 =?iso-8859-1?Q?A7YrmdG5UNtSgoSoUZcxazgfmm/27BTcNZobg1Bt7nAi3kC8O+DB1BNU9c?=
 =?iso-8859-1?Q?trkFjmo2jqfvKbqcEhYlQnkQ0tn2NLB1DFvoiN+LnQk20PpKhvy/1Fr83o?=
 =?iso-8859-1?Q?2bQ96kia8GhDagZpx0kUj65+kWhB2DJ63uSgQjw1XZ2XIju9+9DzzBbMDY?=
 =?iso-8859-1?Q?/7Bj+sI8Mi/G3CddaqP1okd8JcNng9V3aAvxKwWmGJh2V1BiDc69YKrsxv?=
 =?iso-8859-1?Q?YSR5iWOt9yIPb2z/lH6/5OCNZd452SUf4YgN2CwNYY+xw2xmWiO9jcLGQY?=
 =?iso-8859-1?Q?pOCQYhwCsb9FORrCSRD1WJnV3LVKymU57ftF5HNpMe6Ft2VXnBb5saNw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb76ca09-ef9d-4b4f-5e16-08daabc853c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 20:36:51.3236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /hIchb/9I41DOdgLVylo/XjHVcHFPrLZXLU2lebibBAeBFYzgrpQ7k+KY4p3tQ84p1+FceyOfWuwJe4D3ItlLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6362
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-11_08,2022-10-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210110120
X-Proofpoint-GUID: PltP9QI4U2rSVRh9_Ys5-Cd2jSfRoIkh
X-Proofpoint-ORIG-GUID: PltP9QI4U2rSVRh9_Ys5-Cd2jSfRoIkh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The anon vma was not unlinked and the file was not closed in the failure
path when the machine runs out of memory during the maple tree
modification.  This caused a memory leak of the anon vma chain and vma
since neither would be freed.

Reported-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Fixes: 524e00b36e8c (mm: remove rb tree.)
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 74c0e3784500..5855f26639f9 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3234,6 +3234,11 @@ struct vm_area_struct *copy_vma(struct vm_area_struc=
t **vmap,
 out_vma_link:
 	if (new_vma->vm_ops && new_vma->vm_ops->close)
 		new_vma->vm_ops->close(new_vma);
+
+	if (new_vma->vm_file)
+		fput(new_vma->vm_file);
+
+	unlink_anon_vmas(new_vma);
 out_free_mempol:
 	mpol_put(vma_policy(new_vma));
 out_free_vma:
--=20
2.35.1
