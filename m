Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE6766D46E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbjAQCi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235533AbjAQCiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:38:07 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD9B2B089
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:35:17 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H09WlM006385;
        Tue, 17 Jan 2023 02:35:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=dENFccdTr/4pGctHaUhwN03694ws0UM7fWo/ke4rynM=;
 b=PtIVLNOUSPZrQGrbW4O6NmiqiUSO7L/35jIXl6r9Sbz5abKNFKnJoGFX4KsLyr94XSbx
 LZK0WszRGn9S1cS+3JhnHxKa7eTAmLLNuWt3QLz5UgVG5DPC8RpOzfGvQmoCh89c7l+X
 1R11a2zbx38admNWnuwE9jddbfzuIoEDtcHw8tx5V56owGxldQgi52udln1I0pSLGq6b
 J8BFJYG2qQqMIuHlwrTDxzWo3YSdk4b8uvAh/+x8vHJsODGBL58Bcgr4SpPxVlorQagR
 Wb8TSleBVUHgdQQm1UyASvgyGwRTGNZj3SYP/4o8VrgjSEt2ADPmyXHDfVwsKR8gNgOp 3g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3kaabrk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:35:00 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GNCpCS004918;
        Tue, 17 Jan 2023 02:34:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4qyy10ss-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4plGkalFmaEzUv1V1fN0PI7xgqKHBq7NYlePgvR1deFhunYPuz6ZQhnFDbYi9oQ7U88nwAuINbL2KN6oTEA1rXC+0p+4mnesMm/HtovuoVh+HDolojQN55ic/tCCnGYHSy0DbAoG8PhaSCGIo3a6drzHjGM4NJOr66z6/LooSE570we0ffs0brP18GB2vJgrQy9h/4Z0YkM0jZVFT7ANpm1Iz7yrq4mJ4lJGKU4vzLW51ohsijBdumV7WTWyPwQe4iGHDHZdrcFiokCsZSBlSmXz1LdxBaBXxQ2Zbfyvrlw5Z8wi6Ri4TlDQl3jIhdlNLMnGaZpj8ARpWHY7jLyXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dENFccdTr/4pGctHaUhwN03694ws0UM7fWo/ke4rynM=;
 b=I51vRzHrHznwG6x7jW+d/QHvw2mg5o6gZVO1XmI6G9qfDd8Rh1dboPhB0Z8pciM5cnFWEiQdfLDkpO3CiJd7zJ1k8+IbJXlvnfmOvGjphnLDH2uhQuJWdAsgA28+1kTdZtIBxmHvl0i7b8NBI7n0KTf2KbvCcnlrCM2cXqlRcTYR6PYdgVCTG6HM7Swxi+RYxiMgnp9tUsnUO0Rqko+tesf9ZMOnQ6xaxIfGA5I8TVenh4w17cT+7UmloJ80f4qEmMxZ36ZinwhFvZdGFNmMJAnRM2tXW3Xr29xePXcx7go0ueTkShsqW7b40UNcNztPMj8XgR2vhYyB+S+7wteOVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dENFccdTr/4pGctHaUhwN03694ws0UM7fWo/ke4rynM=;
 b=HfTNzNg9dtqIn1lJzPgyKz9OITXvY7SGkaNMF1dMwASru09slybQd1wyiQvBeSHK3bKZxyD8YgQQIPRDLKuuUvRgeazmZRy9stESBRsIHgJj8KH/C/sp/DMGG4dXZ8EYQHByFrhgfrEb3QT3DNmG3WA2FqqTCkPGXf8+4BRDjPg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO6PR10MB5538.namprd10.prod.outlook.com (2603:10b6:303:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.9; Tue, 17 Jan
 2023 02:34:56 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:34:56 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 34/48] mm: Remove unnecessary write to vma iterator in
 __vma_adjust()
Thread-Topic: [PATCH v3 34/48] mm: Remove unnecessary write to vma iterator in
 __vma_adjust()
Thread-Index: AQHZKhw08BMDZK9PB0Oo2g3DfLnFIA==
Date:   Tue, 17 Jan 2023 02:34:20 +0000
Message-ID: <20230117023335.1690727-35-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CO6PR10MB5538:EE_
x-ms-office365-filtering-correlation-id: 5124ce22-0e05-4092-ab9b-08daf8336bff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O2l7uyWuuy3rK44Z5sZzpbmfcI/NTfHGxdsoBMxQDZQ1zs+BKjdkepZyIFCLsy8uDCQEB560J26e5CPJuxNosf0fMm7bvUxUQWg1eluZXP3IFu3quP7go5HRkI76Wt6yTS8c5/1Njv3cFbssHHEckarcu0Zp+ggbBJL0yrLAheicQnHp2LQXM84X+dB/hdTibCjjyVacvdqZ2TH+92BSPrUY3dNKB2xKYgYfvxxMlX7xD83MGb28yFKpiDTfyU7P/aUto7r7X6LWCIolCzsQ7BdSYEGAyH2BPoJZU5cu8bIfbufTbMAht3UqH3StazSR6yXao8dgGFuKqNBotCCJcKHGV+6vd0f0qE5EMt5Q5Cf9KsBAGOkNm2beEXTwpl0kO6Ktdee1EQTgmRAYQM0yjqZqbtn8YeOwuS00EefL4+PVk55hbKlP8wiaoHaIYUNk58mjNdw+KFzYe/q1QKpFYHfK/X2NCax0S7Rg9qWENRUCsjBLdDh1VdpuR/qcY1+E4UAXkAWb+JQipZ4B+KdwyI13U1BkW2QO0Zx0C2IubdEsBkvQfhNdOIH+Di72dbEWbUN3MLF5g2KjM0kZQE9QjHzNl/Gxez+hGYrkOV9u1fnonLTyt3vy3UzP9hjJ3v8WH040wU/uw+BJB5SZ5Qo43yjNhoxALCrfIERn2cVFD7pLNTuLw8eS8xBZ9W2laY+YcgpqWFFqgqJdoz1jtADEFg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199015)(36756003)(91956017)(86362001)(8676002)(6512007)(64756008)(4326008)(186003)(76116006)(66946007)(66556008)(41300700001)(2616005)(66446008)(26005)(66476007)(316002)(71200400001)(478600001)(6666004)(38070700005)(6506007)(54906003)(110136005)(107886003)(4744005)(6486002)(44832011)(122000001)(38100700002)(2906002)(5660300002)(83380400001)(8936002)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ewdqjXZl0/A1n00WupCWS8dSn+/gtgVWiLm0auQwP8hjVqGrYlid6XsqXZ?=
 =?iso-8859-1?Q?iE/agHnDVtBvp7N6HKdxL1omAJ1jqHB4Lm1K2wRzchHlCPL+idAAi0rUvY?=
 =?iso-8859-1?Q?X+3QTIW7ZHHSAfv+awPuEf8436PaPbh//9/Yd1bsNbb5tp/rzEGdZf/7CC?=
 =?iso-8859-1?Q?RrA/9GF+sGsp7veGdfu/6dJ6DDgOj2je7L67Ol8tLDOEh54bS5t8+Ajo78?=
 =?iso-8859-1?Q?IKmPh47iwcqq8hjhxM229q1SgcvZgsNVeko0sU3dv6s5pmm0JFuOYe/7wS?=
 =?iso-8859-1?Q?7Si5WyJ01bsyP22sIKPz0V7xNQWflDvrGS4gxvyRDPXLu/2j3zgXQh4E2N?=
 =?iso-8859-1?Q?wRumQbgRhseI6uqylsyQsPpI/rauNqm9JvCf5JDoHgiaRG1Hj6TWnflEGe?=
 =?iso-8859-1?Q?ryxi6TZw6cfgc9GRbICUL3gvUTeH3pHIyMtYl71FrUPK7KN4Zar0DMOQGa?=
 =?iso-8859-1?Q?u80g64ApSkA5nIUwpUKc0B2jxMX8RmUwVsSZiBZdLXgSxdJjeMHuB5Uetf?=
 =?iso-8859-1?Q?qpE7OuJc0LoKnjEitiVkTU9q6dtokOlKMOWerMmcF0te2W1zqrPntXwduV?=
 =?iso-8859-1?Q?jNKskcSN2Uyc6/Ej5SFpHcz+OmKT/MMbpp8+I8kKQL7pfJ1U1QXQHt+Fry?=
 =?iso-8859-1?Q?kcm+aQs1ogaPSOjsrEb/Hj1/2P0Rd9Vdy+SaaSjI2JTCWQpVRJG/pq+N+s?=
 =?iso-8859-1?Q?VdtOhcrQRUcKxYarjrxVF8dnfjPmTRof7WRBPlmN3FEuzHCXyugNZVEiaP?=
 =?iso-8859-1?Q?wpAVNk5voahYMA2T3gaUi7hEImjVG4QRso74tbyOPRD7dnM2IgtrAlDwIe?=
 =?iso-8859-1?Q?NhzlsJSep8mXXY/Z8cT9iD6thhpFl3RY0/fge0vTZ7loXgDeluaN1KyT+d?=
 =?iso-8859-1?Q?Wez5g6wqfnQt4oWuqp7C12oDQQIHU+PM0v3AjB7fFFx2taK0NiVT9Jp57A?=
 =?iso-8859-1?Q?x8mc3EYodbyowi2b7NT6J/b3rcneXHh3sWFUlT/8pFRruOyYKg+RY1ueQL?=
 =?iso-8859-1?Q?eUnKiP2Nj0lKLWHC0d+rWlYiUFpSf+4WKHrSXWb+uL1/GkzoFTpL7JUZwc?=
 =?iso-8859-1?Q?NWi9tCvjCbEKbHO6vWYcaC4IJcZAeSSSwRh8EACjrdh1dfhmaXFETLQKe7?=
 =?iso-8859-1?Q?n0AlrARH9yNNKj9S2liBAeIkvp6UvzmJkTjJj3Bff+VswywNhzt9Au5X6/?=
 =?iso-8859-1?Q?43yhUfxb0u9K52KBvnEFjKLCuBrRsyEZxqEfaydzmpf1XZgy2zRTB01VP0?=
 =?iso-8859-1?Q?Y846GSSoZt1f/8ynr8DZlWzkWgIdIrFmiyQquACLqlLG7r+hshiQGvWeFj?=
 =?iso-8859-1?Q?irYj3WLj0EglTQkh/B2tNhfXDWC7PIGeCXDWAyMOt/kA9dC50qb5jgSXZ6?=
 =?iso-8859-1?Q?X2fHVdSOfpgSkp4VBj0pVp88QjXaflR3f3v/KVS21tIo3OnoE0sq7INeY6?=
 =?iso-8859-1?Q?7MxsZwdYx6XwkYsheI2YlzA5kXEKBawBs0WU14rtkzSXLVWRkdPWDaazp2?=
 =?iso-8859-1?Q?VfykxTqkpKvQNBcAwoJFzsSMmHjG+aCeEesnCcAEOsde5onOWKGjyLKamx?=
 =?iso-8859-1?Q?lzd6c4m0RVrLJDmWitm/M3Nyen0X6GMPqvI8ldO2g8DQ/7kDyHHKsBubfV?=
 =?iso-8859-1?Q?CNmIOpCl3CGr5Piu979M8qirYDMnxs1hVyas+z7tiNsneetEpfTzgCtw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: B9W4wkqkEBCSALoWmQIEoBErJkZyiSsKbEEFN0nHoCNvxAabiwBupgDJldm1hopRd9B3f1++t4gtWEBN/TtyO70djhXVP/SneUN1ThZ5Z0NJtyaQW2KODr9X9As7JM9KGnzikqgZhmfqtNkt8WZfmfHjEwfAv0GEQVLTjP4sQl68MN5Gpg+TwtoNAjeM0AwZasp3b9OV344uHGnufj2cIwGs9ll2UoceR3XMVQNjM4hhad/HPkPYxnRYDbHKDHp4GsMvQyVW7ClIHmBWSoHOXwsewzv6UMLsS+DcsZlTdgju7P2lMjdSJ8KqiZMZct5hmwLWbYJ4CIkRJwG+L3N0dh9x4e2vFQmzwlilQb9aJuYCogmSIrtGXkotZmryIVEzoEwGi3lhbJonwQO9K4iuLUYcX7mv2+oaHNIWso7YiC52Qe4dDvKeKeastOxugvsfw4pXGZy58uO+j0NT40UaxMpUEx41MTXlf58DdjsJRAt44Rv1DTQbICo9fHS3eZ1FGMyMmkPZmVT8KPQeaJxf5D0xN9C1A9/sBEnLy9lHi82EUqycrH5ri/1VMJZR2SSUyApG5m77DOkikMKy10QRSsoy+q++gf60FW/tBK/DirCzhHx1/gb80DOHeB8x2TtRXcTlFniqkRGGNtPnQ0sNJHK15QjQrQ3KNMZo6s8iVmO0/2RTQMc7Ufg9gQBUVZB5NF0XmOyp0eSF0mVisLNGchPKkeMmeHR7kxhe8UnsLM4VEDYb+Av40XBAmU2gxWhzRtptYzDpVLh16f25r0MlUjM+i/MtjX9p04i2IW1PQwOhvBLFYuPvXZr7ZgeFLGsxOiH/ptsaT3pVDjKIHvMhsaQ1POQl4o4nA/EmjJLWVP5XoH/9g8OtLRcF839BtjA3b1a96EftQmeg98IBbhPh5A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5124ce22-0e05-4092-ab9b-08daf8336bff
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:20.7184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GQRFW1lORXfofQMShJg5v9pRE7Qkx9eOZblARjVBtRipXJzzHYxp9kQ6+44MBmPHo7o8GybCZ2/V9Wyp7jlQZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5538
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170017
X-Proofpoint-GUID: IhIfajPzNMbh6dSIJF2d2LAko0TrXOvX
X-Proofpoint-ORIG-GUID: IhIfajPzNMbh6dSIJF2d2LAko0TrXOvX
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

If the vma start address is going to change due to an insert, then it is
safe to not write the vma to the tree.  The write of the insert vma will
alter the tree as necessary.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 4b4d7b611c3e..b37206f89e59 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -722,10 +722,12 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_=
area_struct *vma,
 	}
=20
 	if (start !=3D vma->vm_start) {
-		if ((vma->vm_start < start) &&
-		    (!insert || (insert->vm_end !=3D start))) {
-			vma_iter_clear(vmi, vma->vm_start, start);
-			VM_WARN_ON(insert && insert->vm_start > vma->vm_start);
+		if (vma->vm_start < start) {
+			if (!insert || (insert->vm_end !=3D start)) {
+				vma_iter_clear(vmi, vma->vm_start, start);
+				vma_iter_set(vmi, start);
+				VM_WARN_ON(insert && insert->vm_start > vma->vm_start);
+			}
 		} else {
 			vma_changed =3D true;
 		}
--=20
2.35.1
