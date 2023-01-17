Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DEC66D46F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbjAQCip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235633AbjAQCiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:38:12 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F872F7A1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:35:22 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H090qb000934;
        Tue, 17 Jan 2023 02:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=F1TlSBVQGd3codLiAiqu8FCJX8OJbRk1LSJn5Nu9CgI=;
 b=XpX4jMGbSZdPj9G4FHi5ixxbUYKjyH2ShySdXA8jggmbLl1s7+t705BvejeczhDjIZMC
 GD7lQEvmbvkcMC6NGYeLJYAVj7qiqd9l+3Qv8IZWMHqzt4Wc2tx2EFfG6B5PEzai+/h+
 JJ+8NU/CBeq/4kXPr5dVqvrbUj8x1L7jHZGs4swTAnqTn5ZV7MlYtIwY5sX+DDlj6GWk
 XlGlCJPBPoaQeX1yi8p4A2QL9AZIjjdKd/NI0/z3g6Y/ydYs2lT8AX9Ri+CPo+NVLa9s
 /O4qt414a9u9aCiUlnfWXcY1Aay45rQOe+QVDMTK8ABMaxMh6doB7gQfwoRr4VDI6E4e Hg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3medbqc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:58 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GNCpCP004918;
        Tue, 17 Jan 2023 02:34:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4qyy10ss-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vt6OCUTuhzgxCKL8KNLGukoJ6mMS0wL4Pe8wBtIkRzlQZKPMELvnjEhNKPJpfooZrEuGZyDNz2EH+c58pUxgis1ihlLMV85x4dEwBYTb3tP0VvGs2sygDp9VFkhiK2pc21wGNTyzWYAhvAJDVhSJZ00iPO5X+CpUBc+9yaDf606MOmdzIQ2AaXyUOE5gKtpJ7vhlliWr9oRiFZypwXKGs4Xy6wgFmAIwcfzxPJuO5uGuZ6asiM+2EDWFyF45kFkWDNaQXbNhlF7zStmOCCRO6fJD5sMyfb2uRqE3LYYoTaPaWTjznhlqBJKdLmQ9jkufb6d/RCD/WRPjPz1KkkCSzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1TlSBVQGd3codLiAiqu8FCJX8OJbRk1LSJn5Nu9CgI=;
 b=jEJEU6mC0Kw0aw5rQpmD9pHF/pqq47dLpJMmjUVXN8Aq8bNuPSGOpnaMrvUf2Fvq2nNmrMPCF7FQ0ZBnnirKU/sB3V7R1Z4RBcYzCokldvlfu3XqpZNJGSzqUJwuDB0cnh8yJbsjwoe6ubLnfI4BaLP3E0i3zao8ytS/87maYvwXa+oAmyDFKYO6NqtuVD3Ha9ZVY/X8X1Mg3nqm6l47iIRPICAQOZ0kVG0R/+6kedznrkSg6kmB0AuobgJlh2L3CN2h3Ga7XG8jLEwyBfF4hXsznUH7DeMffx916L4a2QzEHpscrUfkwYApoHhp/1FVz3yA6Zo7oupTaFf/mqz2Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1TlSBVQGd3codLiAiqu8FCJX8OJbRk1LSJn5Nu9CgI=;
 b=vSdUpZbEH4GrxmNbXNlqwI3PJadYQrJHDlf2slYYlvIsvrPXGQvnhzgcx0vnSwOERyVK6nGChQR3mznDm1hvIM6auSDYFtcdHX9MTCbPd4AtZ5AKuq3UIlvb+7zWjlXs79A6eXOsOirJJd0recW95MHShjVjpQYOXDJjDV6ELWk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO6PR10MB5538.namprd10.prod.outlook.com (2603:10b6:303:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.9; Tue, 17 Jan
 2023 02:34:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:34:55 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 31/48] mmap: Convert __vma_adjust() to use vma iterator
Thread-Topic: [PATCH v3 31/48] mmap: Convert __vma_adjust() to use vma
 iterator
Thread-Index: AQHZKhwzM6l15t2EREOY7m3kATPiFw==
Date:   Tue, 17 Jan 2023 02:34:19 +0000
Message-ID: <20230117023335.1690727-32-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CO6PR10MB5538:EE_
x-ms-office365-filtering-correlation-id: a3cdffab-c52c-4fbc-301c-08daf8336b1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T5NYnAi2ZdLfyA6rL6tNMJQbE80k1CjZh2lLOIFz0B1GxtWrkc9A+g77angr95FuGYoYmlGWiqFux4ukEPQ2PHncqLzSxf6xhfo66N0o29SDUbRmRblswAohTIAEYV4qhEpwphixCelKh8c+ZaLostMlrz/uxM/uKuEFrpzXD4u7QNsgq1HqyNYzmfJzRL/FQW5MzIaxqB7bEM3roqHKb1mAKckkvggibC3VaXSsnPewZTpxfi2XTACRcip0c1CsGlUWsz+SsxilFAR4q3gTHob15dKDrxiUuVyem9cCV+3d2eYVqrjzuYDHLadoNbt+zLqvbtL/d0RVgYfI5WZYSEp5tKbyMwqY85DL3z15d9yV3VhuUYuLv1zlKn/yvUEsmsw3v1k/xi2GmkAHfjxfKGIJztflKFss8uoHM4X5RFI1kGayUg42NfooKJagCpsJwAeYZr4Lcq4XsiUy+mIALog7OHSxeITDjPmZ7ZmuNJlM42i+F4OWgcE1xbEb80EE1GR1z4yBEIEYuBeemxzYb/5J8ZkfPuwTDHFQCqOFi5Zm83MOzftwCOYB7wcjzlpCd236qiBUFwxbYWOaTHspRfhdLoKvgL1kZXoe0XQKDRJ/oGY0YC9btq1A2d5dhaXyC/Zfp/98KFXB/s/4LD+rjl2y9HhQ0h/2F07mCvF6XnUDZELtbs88NfnfxHEIk1DNV9SJlpI6cHyToDTCJAbVqg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199015)(36756003)(91956017)(86362001)(8676002)(6512007)(64756008)(4326008)(186003)(76116006)(66946007)(66556008)(41300700001)(2616005)(66446008)(26005)(66476007)(316002)(71200400001)(478600001)(6666004)(38070700005)(6506007)(54906003)(110136005)(107886003)(6486002)(44832011)(122000001)(38100700002)(2906002)(5660300002)(83380400001)(8936002)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BCKGeG7KtcaRDD5CqYAYVew3pqwTrUbLJD6uN76mTbixrWQXoWI7WPxqJP?=
 =?iso-8859-1?Q?5465Sy0souPaWY78tJmCq6gVCwLL90ThSgthIHjQDEm4u532HNM66Qr4AE?=
 =?iso-8859-1?Q?qYpmhWS28GdufP/ouNU0G3CyKhyLI4uj7IvRoAZtk1zX0h6VPJf72oSvM/?=
 =?iso-8859-1?Q?1ZxQPs82F8sd3i6nfoM+PBKrZlpQhoQLnLE8RMJ2mieb4kQ5F7V7sIbHs5?=
 =?iso-8859-1?Q?8n7ziNinlAiK00zW4fPII3ORpkR1yALJFbM4uzHEf7QEo7wrtycl5j6FT5?=
 =?iso-8859-1?Q?KWKZT4d25laU7hwEn9JW+g38/jQuJInLjrkIE9PGE45q1Gs6d+tKuGciqG?=
 =?iso-8859-1?Q?QNFqL+z4MZUZaN7XZA6/YgRSuqDWvu+A053W/lh5HXuyLNhle3AvuloHui?=
 =?iso-8859-1?Q?Noo7h0brt+udM8iXi/DttQfM+4JFz1s+e+c+ca3aJSZHHfzslwTNPuDsR/?=
 =?iso-8859-1?Q?X8Dy5q8cmW3XLYwvvyxt3STEEoCkosoTVSG77ooYB5h+Cm8+OHkTA/JU8p?=
 =?iso-8859-1?Q?YfaxpdRM4cweZD+f+Yf3abb5woanYkYuU81HQpwEtnxPqaaQoSwx2BrCzR?=
 =?iso-8859-1?Q?532yMz5T5O1l7PxlkFYPU98b/w1DpQlvK88cR9WmDc/v8coUbjMMDpqFzK?=
 =?iso-8859-1?Q?g9cqE7gr2Q2+qvUG7v7/QAudGEtmkEerTFmZOwikOTsqNbPaFEGlhwBRqu?=
 =?iso-8859-1?Q?Vy+5qZnrd5IbFcZke5uGhA3l/e+CG6AwOQQHwvsJOffS0maNhRej52azB6?=
 =?iso-8859-1?Q?plaGGhBnb1zzvobNpAFL60yjkikbBkMWSbm0GVSYlWBLjg41JJ5mLJJOgP?=
 =?iso-8859-1?Q?wkTA+iMKvtGaYp1Vrmb0QJI2bHD7bKGRs0OCTB6QXsOb2TGsKkl9m4hI+g?=
 =?iso-8859-1?Q?EAX1O0Lh4t1tM41xpUoFDOXVYAa33tUZ5HurIlifgy6xd7jYUjcYlWLEVk?=
 =?iso-8859-1?Q?Wr2/w+Ei38W+4jS6Y1PICR3g/RmCwGzj0zeXrAhLUEKsJ1kBsT+xqXF5FJ?=
 =?iso-8859-1?Q?nGJ7WO+skuDEfMT1ZFRnCDlnOguxpHa0z94HHN+aRuLhpPfTqLMwv/VkXQ?=
 =?iso-8859-1?Q?yIdB/hYzPGqu+uUocEhdu2AHJajw+MMVpG6fizH+qb5Z+IEU54fe+dYdPQ?=
 =?iso-8859-1?Q?T7mySpE6PTPfuqHzHCURJC1lhAKyJW4xJ+nJ4oAwZPwGl1qTUT4PAcMeCw?=
 =?iso-8859-1?Q?PcG5vqrU73OkfRSwODmQcBZ4l3iJ1+U4rhkpyOv05lVdz65i8K+xZnX6BB?=
 =?iso-8859-1?Q?nOSEq2tTY90CWQC9WXG0OUd1Dw+rb4Qcz6TKP1DdlFse3vmes/aPgn/WXh?=
 =?iso-8859-1?Q?8sYV2Y8tS4ClB4da93rka2g3b2Ev/zeuuK5+/u3KaZRdEgdj88FpFV/2rB?=
 =?iso-8859-1?Q?EwSAks4ZE1lzkl4/Q/4rykoXB2V69O3Wc0wDoudZ1yQaJc5xynVFm5Rw/z?=
 =?iso-8859-1?Q?oZ9NdFw0cmxlt2gUQZ+t8MIs+B3Rbmu9yt2aQ1uHI7/lb4BaWKvs5Tu2Tz?=
 =?iso-8859-1?Q?nZUuaGJrjTTGIeMXpOVz+mYU49HNpzvr6p495Pf22LgUW3b2DncHldb+Z8?=
 =?iso-8859-1?Q?iiO9njrxvcEmma03wlmV05tEcIZqqMRJAt5cJiqucPOVzhnq3g/j7CY00j?=
 =?iso-8859-1?Q?KNTxU9LMJpMsr6C84lMsRenGrRh461I0U0l3P3fIBOB+II+YnMUKcG4g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eFlWLFtc2yA2rjdaXxg2BGvJDfsxMYk1JnsL/0TGsmTRd/iEW1nwYf62PFqmk0XnAr3BN3kGtfTjUktRxji8HF58JgoltOr117U6jtD+Z4pojnz/FIzJDawYLSQ+e+qQfLL6WxbMaCco39tJ/Zx8dWIDu+OYLNrYWLtaCFBUwcu3ZYhu/li+S5GgxFrhwfQ7z/wdmsaVxsd3yXHgGeGZLMIBUurDkQ8i9rdLm80Bts0fjnNOj1GOTITpnwl88g/N9n+UeyDkynjmywhSJ77Rj1xfWsqNrrDKcpzbebNfwXII9qEdZqDzs80oBVts5yk2o/751GFM+HeQa2Scxj+ldyzkkxN/D/LdC5l2vRWgKnRfwX4/Nt8jSIKP9M2YGqV7Ux3Fzj6VA+V11GHxKP5mYcghRw8MjA53A9vo8XS4aOPBSI1rZ9OHJ8pqnaYC+o7336vlouMe+tQhYkJ7nXEMnuT/EfogOM1pf6ZP+vSYUxfb7bbuV4/RPICZySZ5uRuLTqEe50dCtDDT8YLQOiMSpBMngDvQX3eyo9sQT1s0H1Xh6SVnUDbXNqjOpMoBfOCKwQ3h3PgKJ8CGKH2Rvd0aR+SihHW3iNT16jJacwrxTWVs3DIt0RbWX1SeqLNV/Awh6SgcCwd1EUQulXJKLlprMy/2n7JFy0o2yXVthD6t/Rgo8aqJvbq0zqcVFbopkhuos/b0icHW6QKTTu4J2+fEC66CZfUIfxUyob+NjmAr/3z3FZavGNs5tgadf90XKuUEpXNnIhVHl/3VnYNkhtzFNGZyVr8Bvwb6ya7Yr8S4vgnmAv6LnwZe8W+fnmJ3dm0fSyJ0k6ZH6pHHc+UwKD4soBB+AttExRLUKnU7cuBXS02bKjuw55KtQPV2fhIYPnmzfPdbhafDAmYaxgDBBcEXnA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3cdffab-c52c-4fbc-301c-08daf8336b1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:19.9059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lug0ci3xKjpzugDI6z86WK4PM6JHKfvquU3CFQlHDoVtsyJEBwjV9tio2b7IQeO8RS59ICVAG1T6ORmD/5OT3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5538
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170017
X-Proofpoint-ORIG-GUID: YzxHzfu8ivX5CzzUl5TuasLMgbqmhl9v
X-Proofpoint-GUID: YzxHzfu8ivX5CzzUl5TuasLMgbqmhl9v
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

Use the vma iterator internally for __vma_adjust().  Avoid using the
maple tree interface directly for type safety.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/mm.h |  3 --
 mm/mmap.c          | 75 ++++++++--------------------------------------
 2 files changed, 13 insertions(+), 65 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 71474615b4ab..28973a3941a4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2847,9 +2847,6 @@ extern struct vm_area_struct *copy_vma(struct vm_area=
_struct **,
 	bool *need_rmap_locks);
 extern void exit_mmap(struct mm_struct *);
=20
-void vma_mas_store(struct vm_area_struct *vma, struct ma_state *mas);
-void vma_mas_remove(struct vm_area_struct *vma, struct ma_state *mas);
-
 static inline int check_data_rlimit(unsigned long rlim,
 				    unsigned long new,
 				    unsigned long start,
diff --git a/mm/mmap.c b/mm/mmap.c
index 61d04930e897..b8e8d5edb5ed 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -435,56 +435,6 @@ static void __vma_link_file(struct vm_area_struct *vma=
,
 	flush_dcache_mmap_unlock(mapping);
 }
=20
-/*
- * vma_mas_store() - Store a VMA in the maple tree.
- * @vma: The vm_area_struct
- * @mas: The maple state
- *
- * Efficient way to store a VMA in the maple tree when the @mas has alread=
y
- * walked to the correct location.
- *
- * Note: the end address is inclusive in the maple tree.
- */
-void vma_mas_store(struct vm_area_struct *vma, struct ma_state *mas)
-{
-	trace_vma_store(mas->tree, vma);
-	mas_set_range(mas, vma->vm_start, vma->vm_end - 1);
-	mas_store_prealloc(mas, vma);
-}
-
-/*
- * vma_mas_remove() - Remove a VMA from the maple tree.
- * @vma: The vm_area_struct
- * @mas: The maple state
- *
- * Efficient way to remove a VMA from the maple tree when the @mas has alr=
eady
- * been established and points to the correct location.
- * Note: the end address is inclusive in the maple tree.
- */
-void vma_mas_remove(struct vm_area_struct *vma, struct ma_state *mas)
-{
-	trace_vma_mas_szero(mas->tree, vma->vm_start, vma->vm_end - 1);
-	mas->index =3D vma->vm_start;
-	mas->last =3D vma->vm_end - 1;
-	mas_store_prealloc(mas, NULL);
-}
-
-/*
- * vma_mas_szero() - Set a given range to zero.  Used when modifying a
- * vm_area_struct start or end.
- *
- * @mas: The maple tree ma_state
- * @start: The start address to zero
- * @end: The end address to zero.
- */
-static inline void vma_mas_szero(struct ma_state *mas, unsigned long start=
,
-				unsigned long end)
-{
-	trace_vma_mas_szero(mas->tree, start, end - 1);
-	mas_set_range(mas, start, end - 1);
-	mas_store_prealloc(mas, NULL);
-}
-
 static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
 {
 	VMA_ITERATOR(vmi, mm, 0);
@@ -644,7 +594,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	bool vma_changed =3D false;
 	long adjust_next =3D 0;
 	int remove_next =3D 0;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
=20
 	if (next && !insert) {
@@ -729,7 +679,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 		}
 	}
=20
-	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+	if (vma_iter_prealloc(&vmi, vma))
 		return -ENOMEM;
=20
 	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
@@ -775,7 +725,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	if (start !=3D vma->vm_start) {
 		if ((vma->vm_start < start) &&
 		    (!insert || (insert->vm_end !=3D start))) {
-			vma_mas_szero(&mas, vma->vm_start, start);
+			vma_iter_clear(&vmi, vma->vm_start, start);
 			VM_WARN_ON(insert && insert->vm_start > vma->vm_start);
 		} else {
 			vma_changed =3D true;
@@ -785,8 +735,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	if (end !=3D vma->vm_end) {
 		if (vma->vm_end > end) {
 			if (!insert || (insert->vm_start !=3D end)) {
-				vma_mas_szero(&mas, end, vma->vm_end);
-				mas_reset(&mas);
+				vma_iter_clear(&vmi, end, vma->vm_end);
+				vma_iter_set(&vmi, vma->vm_end);
 				VM_WARN_ON(insert &&
 					   insert->vm_end < vma->vm_end);
 			}
@@ -797,13 +747,13 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 	}
=20
 	if (vma_changed)
-		vma_mas_store(vma, &mas);
+		vma_iter_store(&vmi, vma);
=20
 	vma->vm_pgoff =3D pgoff;
 	if (adjust_next) {
 		next->vm_start +=3D adjust_next;
 		next->vm_pgoff +=3D adjust_next >> PAGE_SHIFT;
-		vma_mas_store(next, &mas);
+		vma_iter_store(&vmi, next);
 	}
=20
 	if (file) {
@@ -823,8 +773,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 		 * us to insert it before dropping the locks
 		 * (it may either follow vma or precede it).
 		 */
-		mas_reset(&mas);
-		vma_mas_store(insert, &mas);
+		vma_iter_store(&vmi, insert);
 		mm->map_count++;
 	}
=20
@@ -870,7 +819,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	if (insert && file)
 		uprobe_mmap(insert);
=20
-	mas_destroy(&mas);
+	vma_iter_free(&vmi);
 	validate_mm(mm);
=20
 	return 0;
@@ -1998,7 +1947,8 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 				anon_vma_interval_tree_pre_update_vma(vma);
 				vma->vm_end =3D address;
 				/* Overwrite old entry in mtree. */
-				vma_mas_store(vma, &mas);
+				mas_set_range(&mas, vma->vm_start, address - 1);
+				mas_store_prealloc(&mas, vma);
 				anon_vma_interval_tree_post_update_vma(vma);
 				spin_unlock(&mm->page_table_lock);
=20
@@ -2080,7 +2030,8 @@ int expand_downwards(struct vm_area_struct *vma, unsi=
gned long address)
 				vma->vm_start =3D address;
 				vma->vm_pgoff -=3D grow;
 				/* Overwrite old entry in mtree. */
-				vma_mas_store(vma, &mas);
+				mas_set_range(&mas, address, vma->vm_end - 1);
+				mas_store_prealloc(&mas, vma);
 				anon_vma_interval_tree_post_update_vma(vma);
 				spin_unlock(&mm->page_table_lock);
=20
--=20
2.35.1
