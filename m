Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929CE66D472
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbjAQCjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235666AbjAQCia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:38:30 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFDA301BF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:35:47 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H09ZNS011743;
        Tue, 17 Jan 2023 02:35:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=E+9ifWADgkFlLD0yETbDnYCr7mlrp9fHkkCv1OWXPaM=;
 b=xz6yGpqCZW4jpx84BnfXfowxiSEHimApoEc0F82hPcKhxIQEgdkB7xtFzQRhymytdrAx
 Al8sdNiSf+6QGqfGwsnsjn1avih0dpL8HMWjzPwGUob8xv9kHCwGE0V2vo3HX70dk5Xo
 6a11/c0IMSTuXSEHDD3mO2EytupfRuyuwavm6z7mL3LMaFCMGQeZEN7+bkthNahlHg+q
 dU4x9f2dESBdyRcpIfgSZnRawPBAYtNJuMYNTfQLNbVmerMPRUUXofbnYcTGpKycRSW2
 6LsLY0JuoyOiEFlqBh0RiH2Hnk+qTM/1i7N3qhYN32cbjCQG1eRuxV4mE1Vg8YZz0la7 Bg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3k00urd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:35:00 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GNCpCT004918;
        Tue, 17 Jan 2023 02:34:59 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4qyy10ss-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnIB0ktIbh/uonlFGVhAdWsQckIPS9g2zk8oco1bTMwptKsLWwGJVIAjUDrIr9UBKAKHRdHHK45T/fKd0aKm990ML+VpADCcpLWUaxJtX+iJV6kV3iNaqJcdQjwFSp2jZt628zGvEABD2OuHtPs+ZHmyPVm5JglG542l4rJSSEx5XOWWpwqeWrxlxpXl2FwUurHLcGBAMLP6uFvijv6l5uTxzR+dL5coA+6wAyPvMoyr05ffJcuhiTOyR07mHV/zJFkhcxdriNUBl1mznJEcPnPjgnR4FzW8/zeALStCqzANxco5nPGvTnyk/kEeEy03xO8lgqZAX5po5a1SJJ2FkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+9ifWADgkFlLD0yETbDnYCr7mlrp9fHkkCv1OWXPaM=;
 b=DD95OJD3XeAPmOTaUUf/Pd0xib9BzrxTcN3XBUXKzuL35vcSbe2EV695ajubQ3sDKQ+3QC1Lu18Ar2bALDWtN/za/qiMrRVrkfOJ9tuSKTqRzEd5m1hgqdcQYnrUBwwSEWLSNT3ek0K9Ew+RG7HZ7f6qOltXoJ/fYhkSVrA423JrIjaJ5VFXazurNEOsnGi5W5LIyAnLSEPWE290CAFqxcyD7oTdPw/xAoLm1Rop/Y+HOvzXwkItbGbxus+A98OcxxJO37zSgMkfZnhk5dSo24WL67ZewZekx2/gcGFfgxF/Kv1LHx+cnYDMN1fGs3x2ywom1a4LsRKdsOC27vPoFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+9ifWADgkFlLD0yETbDnYCr7mlrp9fHkkCv1OWXPaM=;
 b=MzV/od2BbWxaSFdEAT5gjVKLYFCyRm3nvdd+9kOSzljZzU4YC8JxMYlhBGuV/8bhWxTZylA4dfTDgUWOiu0UxnC4af/YrHXxXnNLL/AnOPNRGH6W5XracOLjxy06vxnfp/9GVt71DlP5/4H1ZnVtGnDGjIMRBP6OQWq3ZEWZ2Ec=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO6PR10MB5538.namprd10.prod.outlook.com (2603:10b6:303:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.9; Tue, 17 Jan
 2023 02:34:57 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:34:57 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 35/48] mm: Pass vma iterator through to __vma_adjust()
Thread-Topic: [PATCH v3 35/48] mm: Pass vma iterator through to __vma_adjust()
Thread-Index: AQHZKhw0ZUT/xsZUUU27bhMB6v5Ehw==
Date:   Tue, 17 Jan 2023 02:34:20 +0000
Message-ID: <20230117023335.1690727-36-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CO6PR10MB5538:EE_
x-ms-office365-filtering-correlation-id: 3253e746-3773-408c-57d5-08daf8336c4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rrTKbo5gPZowe1V0q2vQ7nn04UBM9rbei4SwwyVgmRSyK0Md76CFk0XyCHqYRah7QaA26IQMLheY4C8RXh3yp5rcCBPxZI2tOiux+cpl9BqjoHt7RhKJPsOGw+IsqBD0TlIpsqMncrUXI7tqKzaJBDpLjxiTyl4YF6U8l/XOIk179vZpTikT2USD8fM8jpIQjiOszDtLsV9WaDp80WbtynD5z/3rVug8aLkAt1tzxtIK6kCSKHnyxBw/q5BmpzLddA1vlUF4oLoBl30tf/WMHx04g34NJ+hVyUcENwzM/QY8bY8L/rXldEzXeA9UbM9ULsblnurjoLewX/4R11lskL4hoeL6/Y8X+WWN/BAdVjwM4rS1oxz98UQGRLSCF9fSZB5Vbpi+do7JuD67SewRsUvEuKsAgJatXVbHiLSc1OZDCjeYDITkXlMReAUicx+7EamvL6j7LjAF7PCHhyy2h6FXfTgpjiA0nFzaWhwbf/nnAtloDQrfzHkFptMfZdK7mmAQqlyG1cAVZzbFf4n7PvHLxpSFAgamfZVJVxz7noo+4uvOHXIMfgLiW+Ycm2HGcIS5KL5yQOQokn1gyjc4lYY1CQPEuMUNUj+CR3cP84dxemJeXAyGcVq/COOydgfxq738PDXUhN18EHkQnrQ7DLMNEO7vtSpD01RmCQzOrLmdvE3ZQGwZ+PXFPpHjr4nrbagKGUAXOx0K9T2Hy5FuPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199015)(36756003)(91956017)(86362001)(8676002)(6512007)(64756008)(4326008)(186003)(76116006)(66946007)(66556008)(41300700001)(2616005)(66446008)(26005)(66476007)(316002)(71200400001)(478600001)(6666004)(38070700005)(6506007)(54906003)(110136005)(107886003)(6486002)(44832011)(122000001)(38100700002)(2906002)(5660300002)(83380400001)(8936002)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7Yq63kbOHmQWzlmA4GJyp6wkLFBx8IxOgsdAPwrM4kXaOhMQ++8w20m/SR?=
 =?iso-8859-1?Q?0SFHpaTncE/vULKIORha+MYr990E/8bM2hJ5TbFuDjK6dtFbvgJ2gcI7NJ?=
 =?iso-8859-1?Q?ZO91T7uvIVrofhqj1SVHK6/k99i42/uO8ViZGZeevGzWbptXJA3lKztkZf?=
 =?iso-8859-1?Q?ZuO8FnsdVNxJnvhDw2vzGU2rHC121ub9F2AkhiXhY/dC3NfkAzM+4XwNbW?=
 =?iso-8859-1?Q?Wv73JYyiv2kPzlPgHm77SbEAuGdDhTe+7NeNayBDndw1aHdWkXQF0zgEjU?=
 =?iso-8859-1?Q?DjEFm7kGCHdAwXG7wqfRKd0mJUi99kTWcvspbYiCLaFjIKRmac6i6OT+xv?=
 =?iso-8859-1?Q?8adtdp7PfzPrC+ZjwfGFb0Bjb1YZtrvQWAvPBU1lYYXvkdNgAK6ZbmUNF+?=
 =?iso-8859-1?Q?dxQlTDap2T49G3rsAyK9JhFj13g3kFlOk2WRWe/vlbMvHzj2tQJyFKMInJ?=
 =?iso-8859-1?Q?Mtw+oxPOyrDg9uYhI8UtCLWYzQMu1WNkBNsJWjgLru4Fu1fJ+UbQIEKCZg?=
 =?iso-8859-1?Q?FG8eJ7F3P8Si7+mus5U6xrvp8GM1zXDWPtK2FpNY6HXHenWsJnavkRjxsl?=
 =?iso-8859-1?Q?cu+PZF/uuO4cpDLmwi7Yu2e7ttvVIj8AePAwOk2ULx3Bh391EEvvVou/iR?=
 =?iso-8859-1?Q?5nZDUC/WGU7Sy+DnF/8QOo+ca3l58BKQdblVGVXd9FA175PqQ0Rlpqfiq2?=
 =?iso-8859-1?Q?2V9wWhNPleG3N7nINtghjYuc683iWq2UiEYjZeei9RixVwjQQzIzMMSTJi?=
 =?iso-8859-1?Q?u9uAads7HN5rTcOFFixZd2YgmnoGxKPMuTYYngZ9BMGlgrdlVWbf5rsPSb?=
 =?iso-8859-1?Q?9131zreHouw+wGnaehgBrOQTA8E6ZQFx6C7OvC4zuc1H0gzFqlTpMBMpeJ?=
 =?iso-8859-1?Q?oGWwqjsIJrf3cqh6m2puQU+h2Ptw+uGGr9k0rOnQbeigilMS+16rPP8XaY?=
 =?iso-8859-1?Q?I3C6ir2TvsEQtnHWwsHej7Q925Gat+p64yJ7x5Hhvq7fCrF++5xFYNiTuG?=
 =?iso-8859-1?Q?YxJ3xoUJc35B5jpbNuysXYqoFKEDZwkU8NOHNsx21vQGdXlxn3aV3tHJbR?=
 =?iso-8859-1?Q?HCJ2/CJR7T07hzw2ubWW0OWgHlvL+yaCuERfrRX25jy2t9FP3hwwt2/T40?=
 =?iso-8859-1?Q?QNmFLDTCgMlOJOk2aTZAmfsKFLhRrvOHS/zC49JC+4FYyThMf6LRGuJVFS?=
 =?iso-8859-1?Q?Fa4IHkE1XRRuGfFnV5jLELOg4zDYnz8HuvovXXdYEmW9ZAiCdiKHEWb8uA?=
 =?iso-8859-1?Q?4MGN4sy6zkLKviWYiEZ/EZJz4OPdCsdjjk35t6+p/aa3EOUr8k8gncnATl?=
 =?iso-8859-1?Q?8jIHSTtQ/MSDsth1eDAq5nj26m+OUU9ztw5knGQwdn8X999fzBWn4MdlMO?=
 =?iso-8859-1?Q?EA+hpGLBtMzbpGyn9sgbx5E5Q0eapFKhd+V5n3zXyXh91PoyYL7Z0RhsiZ?=
 =?iso-8859-1?Q?dwGG0inbnfMgF5WaT7uDKMdseKUNqbdbpac+vNhkaZxZ5L+pnfYi2lOFTX?=
 =?iso-8859-1?Q?OhjiZn2VrwJFaInlEjSpPFKSm63e96HykQzXpfYgHb340ywo5+VvL59IW1?=
 =?iso-8859-1?Q?Nib/pobZELkBNWipnyCBrhQwsqHt03Na4RCx9Zztqkg5i23/BFwMR3Np4/?=
 =?iso-8859-1?Q?TRFW1GF/7duOYMXVTI1+MLekaM9PXLn65AcvI2dlPJ5iH3hPbKd3ePyQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GXWbJejQiAlc+dd6HlPJV/7OkL3QScrJ0bAFX2Z4q0zKLh9lEvp1rvmALDXhE52i5mEshXL0xclwKipWX3ujSF6j930rKBdq9CNBo+Du2RSnFPJJ8NJwFb6KxHw8Ezvv2MgftrsglysM3UcO6uHIuV6h4Esk5oiRqlYIu0bjYdZOxQ9B+klxVKH165/mRQIBomXtc/rqTXd0LZxugQ4N+xW4jcLvGWAWDW9/TN+vXY7LtWU/r8l7KaIXlXCoOTRvyma8CwRoUug9SM2bf1+J+seAJowAz882egB453IikZ1bwUTyhdKY6lhQMdR9BCkULJKbUyJrB7vRuMY5CCCmXY1lduYan7CY4P+9IqZWGk6J6sKoTAd2hddy0qLzWP7KcZyo/vBGegymCd1VfdtZc2qv45EVJaizDb17jHGghIyt/TC3UBAtiYG8tJPu7/va9T0Q8fOWt25rwJKRvNg0P3i3uLzmJbLEfAyr/lA1SrPhOENG3FozMST/ESjFazDwDJ6j1/n0Kp1FcQu1AjtgQ0i7qdlyNEzxjKqcNEmizj6J6LdJO92TJiTrMM3CxclY0pgHdcOuHL+x25AR0/4Nubr6jnnnos0rvF5KpyxDWSLDtZmD+KZzYmjB8ZU5Zbex8Z6v/B9X7/Xe3k95cz8DLVglmcW/Xsb1bFbH2aMHLMQWPDh7tw4uHOnRj1cSA0tcZ8ruFLndCSWERpKzT1AKjMpVAFceCymYduf0j0hBLAJljzBEDgQJQ/RKDiVyW0MR+0KpGTymXeTJZDfWXRwv7z22Wi418bXj1pGmYmU4mUdKBeNNGfifMxQNBgDshSaNmWQeRKt9GHJ5utHYR8YyEy356p0zbGoUkI++Ep/0g4TBoTJwdF7CuxFTtk14BMFZBpheAbx9/RmS/DfvyWsccA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3253e746-3773-408c-57d5-08daf8336c4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:20.9840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3pGz3h4/OOB5pwijfJoTIBnsugDvu8aQs88T8uMcMNtb8fbAIMX6g5rJq5OK76w7quXmIoI0OMN8JO9tjvwe6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5538
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170017
X-Proofpoint-GUID: 7FTccgzqhtVdvaiAM8EVUKIvdErUjxZ5
X-Proofpoint-ORIG-GUID: 7FTccgzqhtVdvaiAM8EVUKIvdErUjxZ5
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
index b37206f89e59..a8908280671f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -528,6 +528,10 @@ inline int vma_expand(struct vma_iterator *vmi, struct=
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
@@ -2163,13 +2167,13 @@ static void unmap_region(struct mm_struct *mm, stru=
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
@@ -2205,14 +2209,17 @@ int __split_vma(struct vma_iterator *vmi, struct vm=
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
@@ -2307,8 +2314,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct =
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
@@ -2328,7 +2334,6 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct =
vm_area_struct *vma,
 			if (error)
 				goto end_split_failed;
=20
-			vma_iter_set(vmi, end);
 			split =3D vma_prev(vmi);
 			error =3D munmap_sidetree(split, &mas_detach);
 			if (error)
@@ -2572,6 +2577,7 @@ unsigned long mmap_region(struct file *file, unsigned=
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
