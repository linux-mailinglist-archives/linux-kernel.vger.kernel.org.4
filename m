Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D36366D476
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbjAQCji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbjAQCii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:38:38 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F9D301B3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:35:54 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H093AD000988;
        Tue, 17 Jan 2023 02:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=0tQvpuyTH21QXGvmbLCqLSFaZOw1kys4+zk7z2PMCIY=;
 b=igtLD6zvibfXQCDN6jqUIpq4cNnTcRxWRGGiHc02u+JTwriJBfDvskRxqjnpnw/cUehE
 3wjO1hAQgMygUKBvNhN7y5YtcOQjwA96Xk+bph4K2paH9Mr+f64VYpGxvavyn0TFdpcb
 Kn9wNo1d8lWn33H2QKshHF5cndtP34emwx8yF89SVX33sbLComAlm0dfmKVWOh+zgu2l
 h8UvH7todRjdwQTZFOn3IcFfFUffH9E3ILYnCEWuBOdgE4gfug8SCiMzy9LisNDXlGc3
 lLRw9A4Rn4Kin0QYa7LxD27P6GH6FfjJ/IUN5p8bwH/0MWnEC90Vq7Hnw9UrTlSOtlbe /g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3medbqc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:35:03 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GMXP42028373;
        Tue, 17 Jan 2023 02:35:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4s2rfy4x-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:35:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KafmYvEvXixPAZewwpYcZcGcHBvRzxle1za+oU0o0pu7prvfneujqohCkH2KHShsa/mTV/xaPVRC4lALQj3Qgoy0snPFz9LFL4hB/eWfz0Jn3BAf9YGDaFgHLqXzrl2TtNdnd5KoKZnbyev3yFbJq4eN2NuUToLvdMygoErPuvRakG0X5rhhd7SnZf+ENQxttGUvgVCkKdHd5q/r2w9Vm2yuCQt2PF8vDHKcIHMCfM/1zIN+HF0zxARHpaiGix5Bwf3NXW2wZ+oaM5Wo0Su+jJiugnJ4oj3ZTnCA8RoFCTEjoXrZmCbD4EJt+2OK7oLUvnfy2e70kWcFeIFjmMSl8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tQvpuyTH21QXGvmbLCqLSFaZOw1kys4+zk7z2PMCIY=;
 b=oBq8reT8SbLjBu5OnEtS/e5TThyBYfkD3kfRppG+JlpcjIirGVqYmbwiN9vMlQvnuq+H1nOqsKXM0bt4cibfaGnvUH/AdogWG3Arzab7ZTNvgvP1QneJxc59uV1E+DrQQglwZcBeQRB33eZaiDADPDgdUY2B5o4scxY2D0M899RCrRyZ6wL6oIrIRbkRlOrR7WMs7c+Ll1d/wqOn1DWxMdJX/X2H1LNnI0MSQ7DMX82cFeTdkl1Ha3QzQkPKn3DWH0dP6AwxvQhLODRXZmyTiZ62hXAWfNUkpnMhnt0fmyf6Cvdoue4A6DmyhsTCgEbtPdm1lUfGel4nkwjoaE8UzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tQvpuyTH21QXGvmbLCqLSFaZOw1kys4+zk7z2PMCIY=;
 b=TF2YlMrLvzztda/7d+OaGFCu19AOTUVPeTj4fVu5eywc+24WxBO/IQQWuFQYbwjIZF7BwMcmPCYNhFZyfutTm8MVOTvhOSjXTvtlSNlSex9lo+Z3EinKyJj2YSb3lSO+K9lxqi9Gn/w+qntjyvfwfMFPgvAMNTcsuBSj9h1ItM4=
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
Subject: [PATCH v3 41/48] mm/mmap: Use vma_prepare() and vma_complete() in
 vma_expand()
Thread-Topic: [PATCH v3 41/48] mm/mmap: Use vma_prepare() and vma_complete()
 in vma_expand()
Thread-Index: AQHZKhw1leVGNgt58kegh4h50t0Isg==
Date:   Tue, 17 Jan 2023 02:34:22 +0000
Message-ID: <20230117023335.1690727-42-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4814:EE_
x-ms-office365-filtering-correlation-id: b108acff-4b52-4f85-0d86-08daf8336e75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AhCUJB30n/6zj3p1NTdMHsa+a3eBsT3D6kdsN0wbbkEFOS7IjngERztcF/dsAQKjk/Ex3Sh0tFq/UtO/cMiAIGc6FrXCB1XtJeV0421zjw8H56354zv4V6O66qlzcOCg2rGj7RPbBbOFqOltC+h1ztbUrexM0HLA1a9vFQH7T1DntMNF7Vxg8IHwKRBx+zhP/AwyjRfuWnyNR6i+z2ftDfsw2KfY90lYF8ZMkv8QJilfun99BEZkyg3wIZ+pjV32FrHK2fbTKfafDE7Ao7N/ajPxrRbn6ifosUXNP4ngd8owxO2Yk9V8KT6AcbtzcFxQzMn7n6QXdfy0M16j45/qEwARvH//rjVa5tigGg2wxfEJnXXDXE3rhMQT/kUfbVjNdnNsGx/kxtuq0Fqp0v0TLO6uH/ID8xj5Fv5ZQDn3fu3dZMekrFjtWmNJnCM8BBKYT6gCcYKCs7vxKaoDV/EpubIw4nPeGxludZPY/qa0qz49ZxU29GEply/i6YBxPQf8ttQT+pm+gJsmAc9WHbOPhTx784niOUl6i8BF6xwzjasw5qFaAW546rlYYKEZ/AoY8K0yUCc4wjA9/pBfzI1AfC9W7ya/6gV2PjWPRE7sNgydGWdSFZdgEMRJShR5O6gmkZufPMevNX4gJgO8GJ7RI1GeCWFxzcQ3xM+wB+93i1NtNgOHCBagR8g+DfpSbB+b01Xs2U1KgYir27CzIX/YwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199015)(6486002)(6512007)(478600001)(186003)(26005)(6666004)(107886003)(71200400001)(6506007)(91956017)(66556008)(66946007)(2616005)(76116006)(66476007)(122000001)(110136005)(316002)(64756008)(8676002)(4326008)(54906003)(66446008)(36756003)(83380400001)(8936002)(41300700001)(1076003)(44832011)(2906002)(38070700005)(38100700002)(5660300002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6Xcy84j2ihjHZKW4aFXoK8ArXK7YuKRSfwoEU+kGwnv8LcrXLmlxfSEgcb?=
 =?iso-8859-1?Q?zO9t4hQ5+e98wwTPcDaQZl/T19Bfa0O/F9WMn/eHK2TwF0l/Wa2WmzHiZs?=
 =?iso-8859-1?Q?61wd4iXyM384oqoSozsNDclJBOaVCbuaYBktogil43H9BASi4VvL5oKrWp?=
 =?iso-8859-1?Q?ixaEvREEzCiS0y/znHtU2IzAAiBZ53Og3yZSVvnqLJiSUhf/dshFTuGdpk?=
 =?iso-8859-1?Q?mRnnVrRyrlDBSdrWdSZ5lJG4VwZM6VT9H2mKgb3chBI2+uiZjsiYWes6UU?=
 =?iso-8859-1?Q?Dr6BYXrvHEGRNwkNKULhb4QaCexUH7UphGLxpwT8PN+ewqU15ltI0zgDB0?=
 =?iso-8859-1?Q?tlt1RT7Qik2Te6S0DVVfMsXR1krN/VqH4Pzh8hQHnWXJ+wWuMTf6TY+7nH?=
 =?iso-8859-1?Q?Pf2ooiogFK+ESyf42ibf91TXf0O7ryzR1xcRE4/cR03+MM5W3KOIR5Gaf9?=
 =?iso-8859-1?Q?F/xwrt6zpm9/yp5BuHdUWx6SDMcLpyMe1oYGGufhsybz1Au4AZIPEJZb/O?=
 =?iso-8859-1?Q?LIr+S/6DsYfMpEeu3O70igKY7F9HiIME3PrFSBJ51hax0fREgh4WNQB4XT?=
 =?iso-8859-1?Q?qrILa7dbNJUyw9FT9eGzh6MX23RHF6bT5UDnwMRMFfhJbXC7rrYQrRp/GU?=
 =?iso-8859-1?Q?o5S3PFqI420OaV7/HJ4mWHtFn6t81eDEWwKJhmg5dC0wUaMGqxoSNg26iG?=
 =?iso-8859-1?Q?D2RVWdPXhd1lbYEv7kRqcVq3mh0Onfi2zZkv31wl5zGfWjVHwfkTknzupN?=
 =?iso-8859-1?Q?NvVYWXgtqILZCPvBN+VnFtnJgL3SLbwLyNYFekXG/cmjz3BbwKZ6kBl46a?=
 =?iso-8859-1?Q?Tdrr2UqnnM+oKmjg6irNggSqDR61+yI/O9fAeZ+V8+kjxWF4CAidZ6PFyn?=
 =?iso-8859-1?Q?+K3tDzCr0WYnPjBEsLIej5klq8ACP/VvpHMhf5HeaIyGhdu2pydvm/YTvr?=
 =?iso-8859-1?Q?vwPwlAthyS6rVrC91pxZcTIfZxNqGtDqiEIKK6+GqXSV0jko/K+M98w/Fp?=
 =?iso-8859-1?Q?jicpo3lvb9OFvn/V72uaWGQ4Zu25sSyWg/vsaZFz0LckOS2bfMyib49fZ9?=
 =?iso-8859-1?Q?lx4tf9khnMUxNyf5jw58xGd0w22RQjJ+/LNF6R2sZMdy38EtxFJIratGDB?=
 =?iso-8859-1?Q?NDJ6bAhg8gGtzAqqDcTe7en6EimhoXaY0CSJb5bQGiG7e62ZysyaY1xTby?=
 =?iso-8859-1?Q?9QDbRM6bKr3v1PD6XoNxxaQKEDWjq37Lc5h3P2jxB1I3aYYFza5qBUw4A/?=
 =?iso-8859-1?Q?el3bspntQ8MtCKecJ94w7N2XxTPyGogwJaFlZT+bmLoc+kpNXbrYg3kzov?=
 =?iso-8859-1?Q?1tsu3VNBz921m+QG2U0IJFcWd4j+kvonlTgamCacdNrA7svOlpcWDtnuER?=
 =?iso-8859-1?Q?08BpyBHgc/KBAedxdeIiIZHDWuehvBMAgz1DUk8D595QRTPpN6xPmzDd4D?=
 =?iso-8859-1?Q?UR8IzSLutPRk+zFEcXrcXPKxnk+7R7o9Z4Q/aAsO3CqVM6iIU8byIRv93f?=
 =?iso-8859-1?Q?xW4xEQ33U2hUD4DXnglO+ArvG1/tQZqyzWuXQ68fW7ZR5CU5GOvKlFGsfL?=
 =?iso-8859-1?Q?rCtcYSz9HnjMC7g8zHYsK08KO/giS9sqtcmd+wFBPXduU+ZLdDgVi5/dQe?=
 =?iso-8859-1?Q?GDnP3Psmds1hVMJq4uFKxbVC3r573ONmLVOYNnWV6oD2vf/ha2NzDxjA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2jZ1B0tNWi+1ORpkIwl7ow2I7ZTBGaPeDjgI13mAnoS/8TzMH6gGr1CSXsxW1WBit/LYs40F7ESh05sELOXMwYMgrKRI17c+LQ/2kTcUGhsAHjP+dppGSa1EQ6Uxz7ByEQ6TdeQt4NvjWmdzuBX9tnjlnh/YMTKcxVNAOESHf9e4+lJMdLOoKhyv0+V0qxlR8Y7Wc7GbbJ6jjkDAuZLI38JyzVsFyHf6FImw1Gmd1B1aUsk8vOwcDCfuynQzBuvqSZXRAJWgw8Xxf7HWQFplZ6nl4wJuQ7ECrhwX6YK2lZ56qk+kuDDJSh2PXqazywhm0xSMcC6HhhvSfzwd2fHCaot1wRXFYSbGu/O3wSBP+rsU28469PpFlP0ZKzPOeX4htfwoTjsGKwluoHt68fvAB4gQHZ04Mm5FpLH9lUUYWK+HzhhcRj1qBS0G7FoDyhlO/fcQR5rsShzlAwuw5xKpY7rOC2urAX1/Obn7bFQg1z+0FBpkS7yDXme+7jQwG3bjUD4drd3qTBVH5iXAzVg7RYqhIv8yqsx2XjGw2uH9mu8cXAJHpEGGy9yLrDX3pztTVIrcw3emGthjWia7Pl9g8lb40rmQvgJfPLy8s7seqdEGtRoo1qFmaIJAbRbuwdo2xGQ2iDhhEyzV+g7xfWtOhwsCyI5BDblAJqfRtpJCVBPauxnifo7YTsxl9nb663nIia/oMeG2Di5nOgWRSNYxM2KJ/MejCJSgjYj59d4FDjmk5VlQGsyBG1AZDPidehH17GjMoT/Ge3md7hjqEUa0h3zutc2rIwPXFXZFPBFlm1FuHME+/cncltOV0fwPwJYU1mjfYBlowHWJu7YjCg/RkAQJVhtvco8pd/22pRhidKfp/+aSTm4cFp3BdiFqgWb/IPMgK4Or8KRDwk5zDgHy0w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b108acff-4b52-4f85-0d86-08daf8336e75
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:22.6870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YjNDXfIdGguLf91yG8609C02AKoGK0+CcmrF4+1d4NRWE5ikc+crWz+Qzw4oQCpE0HPHhDxkeyMI3ZqjRwgCVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4814
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170017
X-Proofpoint-ORIG-GUID: hg7DFdvAYaKc5mSZ7IR7POgwYknNuKV4
X-Proofpoint-GUID: hg7DFdvAYaKc5mSZ7IR7POgwYknNuKV4
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

Use the new locking functions for vma_expand().  This reduces code
duplication.

At the same time change VM_BUG_ON() to VM_WARN_ON()

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 189 +++++++++++++++++++++---------------------------------
 1 file changed, 73 insertions(+), 116 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 786d8181089f..2ea7bf439f4f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -460,122 +460,6 @@ static int vma_link(struct mm_struct *mm, struct vm_a=
rea_struct *vma)
 	return 0;
 }
=20
-/*
- * vma_expand - Expand an existing VMA
- *
- * @mas: The maple state
- * @vma: The vma to expand
- * @start: The start of the vma
- * @end: The exclusive end of the vma
- * @pgoff: The page offset of vma
- * @next: The current of next vma.
- *
- * Expand @vma to @start and @end.  Can expand off the start and end.  Wil=
l
- * expand over @next if it's different from @vma and @end =3D=3D @next->vm=
_end.
- * Checking if the @vma can expand and merge with @next needs to be handle=
d by
- * the caller.
- *
- * Returns: 0 on success
- */
-inline int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma=
,
-		      unsigned long start, unsigned long end, pgoff_t pgoff,
-		      struct vm_area_struct *next)
-{
-	struct mm_struct *mm =3D vma->vm_mm;
-	struct address_space *mapping =3D NULL;
-	struct rb_root_cached *root =3D NULL;
-	struct anon_vma *anon_vma =3D vma->anon_vma;
-	struct file *file =3D vma->vm_file;
-	bool remove_next =3D false;
-
-	if (next && (vma !=3D next) && (end =3D=3D next->vm_end)) {
-		remove_next =3D true;
-		if (next->anon_vma && !vma->anon_vma) {
-			int error;
-
-			anon_vma =3D next->anon_vma;
-			vma->anon_vma =3D anon_vma;
-			error =3D anon_vma_clone(vma, next);
-			if (error)
-				return error;
-		}
-	}
-
-	/* Not merging but overwriting any part of next is not handled. */
-	VM_BUG_ON(next && !remove_next && next !=3D vma && end > next->vm_start);
-	/* Only handles expanding */
-	VM_BUG_ON(vma->vm_start < start || vma->vm_end > end);
-
-	if (vma_iter_prealloc(vmi, vma))
-		goto nomem;
-
-	vma_adjust_trans_huge(vma, start, end, 0);
-
-	if (file) {
-		mapping =3D file->f_mapping;
-		root =3D &mapping->i_mmap;
-		uprobe_munmap(vma, vma->vm_start, vma->vm_end);
-		i_mmap_lock_write(mapping);
-	}
-
-	if (anon_vma) {
-		anon_vma_lock_write(anon_vma);
-		anon_vma_interval_tree_pre_update_vma(vma);
-	}
-
-	if (file) {
-		flush_dcache_mmap_lock(mapping);
-		vma_interval_tree_remove(vma, root);
-	}
-
-	/* VMA iterator points to previous, so set to start if necessary */
-	if (vma_iter_addr(vmi) !=3D start)
-		vma_iter_set(vmi, start);
-
-	vma->vm_start =3D start;
-	vma->vm_end =3D end;
-	vma->vm_pgoff =3D pgoff;
-	vma_iter_store(vmi, vma);
-
-	if (file) {
-		vma_interval_tree_insert(vma, root);
-		flush_dcache_mmap_unlock(mapping);
-	}
-
-	/* Expanding over the next vma */
-	if (remove_next && file) {
-		__remove_shared_vm_struct(next, file, mapping);
-	}
-
-	if (anon_vma) {
-		anon_vma_interval_tree_post_update_vma(vma);
-		anon_vma_unlock_write(anon_vma);
-	}
-
-	if (file) {
-		i_mmap_unlock_write(mapping);
-		uprobe_mmap(vma);
-	}
-
-	if (remove_next) {
-		if (file) {
-			uprobe_munmap(next, next->vm_start, next->vm_end);
-			fput(file);
-		}
-		if (next->anon_vma)
-			anon_vma_merge(vma, next);
-		mm->map_count--;
-		mpol_put(vma_policy(next));
-		vm_area_free(next);
-	}
-
-	validate_mm(mm);
-	return 0;
-
-nomem:
-	return -ENOMEM;
-}
-
 /*
  * vma_prepare() - Helper function for handling locking VMAs prior to alte=
ring
  * @vp: The initialized vma_prepare struct
@@ -697,6 +581,79 @@ static inline void vma_complete(struct vma_prepare *vp=
,
 		uprobe_mmap(vp->insert);
 }
=20
+/*
+ * vma_expand - Expand an existing VMA
+ *
+ * @vmi: The vma iterator
+ * @vma: The vma to expand
+ * @start: The start of the vma
+ * @end: The exclusive end of the vma
+ * @pgoff: The page offset of vma
+ * @next: The current of next vma.
+ *
+ * Expand @vma to @start and @end.  Can expand off the start and end.  Wil=
l
+ * expand over @next if it's different from @vma and @end =3D=3D @next->vm=
_end.
+ * Checking if the @vma can expand and merge with @next needs to be handle=
d by
+ * the caller.
+ *
+ * Returns: 0 on success
+ */
+inline int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma=
,
+		      unsigned long start, unsigned long end, pgoff_t pgoff,
+		      struct vm_area_struct *next)
+
+{
+	struct vma_prepare vp;
+
+	memset(&vp, 0, sizeof(vp));
+	vp.vma =3D vma;
+	vp.anon_vma =3D vma->anon_vma;
+	if (next && (vma !=3D next) && (end =3D=3D next->vm_end)) {
+		vp.remove =3D next;
+		if (next->anon_vma && !vma->anon_vma) {
+			int error;
+
+			vp.anon_vma =3D next->anon_vma;
+			vma->anon_vma =3D next->anon_vma;
+			error =3D anon_vma_clone(vma, next);
+			if (error)
+				return error;
+		}
+	}
+
+	/* Not merging but overwriting any part of next is not handled. */
+	VM_WARN_ON(next && !vp.remove &&
+		  next !=3D vma && end > next->vm_start);
+	/* Only handles expanding */
+	VM_WARN_ON(vma->vm_start < start || vma->vm_end > end);
+
+	if (vma_iter_prealloc(vmi, vma))
+		goto nomem;
+
+	vma_adjust_trans_huge(vma, start, end, 0);
+
+	vp.file =3D vma->vm_file;
+	if (vp.file)
+		vp.mapping =3D vp.file->f_mapping;
+
+	/* VMA iterator points to previous, so set to start if necessary */
+	if (vma_iter_addr(vmi) !=3D start)
+		vma_iter_set(vmi, start);
+
+	vma_prepare(&vp);
+	vma->vm_start =3D start;
+	vma->vm_end =3D end;
+	vma->vm_pgoff =3D pgoff;
+	/* Note: mas must be pointing to the expanding VMA */
+	vma_iter_store(vmi, vma);
+
+	vma_complete(&vp, vmi, vma->vm_mm);
+	validate_mm(vma->vm_mm);
+	return 0;
+
+nomem:
+	return -ENOMEM;
+}
 /*
  * We cannot adjust vm_start, vm_end, vm_pgoff fields of a vma that
  * is already present in an i_mmap tree without adjusting the tree.
--=20
2.35.1
