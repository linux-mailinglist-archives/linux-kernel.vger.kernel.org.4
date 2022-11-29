Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D8063C590
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236347AbiK2QsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236323AbiK2QrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:47:08 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A91D6C71C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:45:18 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGOgxA005680;
        Tue, 29 Nov 2022 16:45:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=D7AHktccuhtvwQg420kJai5Cpf4bMzSkAcFe7bPajYM=;
 b=Xjj+NfV16kYdx6Ho5KsfEj5aRJMbm9HMlrmEqHXMg511c2ckfXzlHtumJsTQa5LIUx1d
 iFuTE/TEzvOLDea8RcXhPYh7dCL9OfwYLVlZO7YVsQXVRkXoEZufBmTFmTYRG+rTG2rt
 C3yqtrhkdKQ9WZOslZxQ4yZY5nnpi+vxas5QV/xIS2JZGmbseB/w8ibUzBuIW1vtzzM5
 SlA65zMur28tEjqY2DyTOTNkzR1rECVnUE3mAW4UTdaCb1d25qlJfsjPsY/QldKL3RQM
 /Vk3+f5ErhKMKm9dczQlVSMiLmKx1R6QfFhTSbKVahRxPK1gmzBC6fo+kadrzowhZVWP FQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m39k2qfct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:45:12 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATFkaU5026698;
        Tue, 29 Nov 2022 16:45:12 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m3c1vkkp0-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:45:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Booidj0CTtoAkZSfaZkqAjbAiBTpAVfuwTHujB/N06ZU5PO7n7RXvk9r/tzWNZFjuS6v6fgoIOh3lF0NqrqRzugZeOp6pj9vKzobklzFuGfMxkeyOrBv7w1lMyeIdoRrNzyhIsnTmC/Izg3tKQamXny1AgeMbk4ZGIh0Rzwa8B0Pydm/HrkWiJVOyzNE/ct/XCu6a5b7mJOinQ89D0ijfBCwuEOQ5twMpGVjw5sQm41TS9cWIE5gP6Y3IloMdvVYyM2gZOfBZAYSiTNaL2JECl73ZQbwGhNEJIs4lSQo9jjmlaE/yGWm3s+iT5W5QEK82G/y2Ne27zHF7dWnIu/w8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7AHktccuhtvwQg420kJai5Cpf4bMzSkAcFe7bPajYM=;
 b=cF0XJAHk5NStOUN5fcCqpbJ9kuDPzR/Kc9MpZJVYY2oukrvu7dcDri47p/b23lB86teq0fBqtugUFaA6aULKA4fuH1OuEyYpDlNDdhs5bjAUV0ZZTGNkb/dTKa+v5pGdvX9Y/jCee/oBKoI9WLcDQv3psP1+Pqy+vwHW4Jr+JYubDvJAFZQIG7s5jukCT2SmaQ1aroTivZp76JKXVkxQU0Vp3jPnYIwLty0lL5jFhsbUw0B0nNsZuCtigfc1D0qDEr37utRnr/k8hTnAb9+rUlLb7g5C/Rn+ozhLnt0ARPg+vopv0S63AbH+N/hXtvvCRQbvryoUGipUC/akgKkg7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7AHktccuhtvwQg420kJai5Cpf4bMzSkAcFe7bPajYM=;
 b=wqlHsjRVpqIWu+vhrBRlrcpqDWPPfAeb1DClxPhcEohc05DtU/eJyNyUy/XW+r2xQHXie23MSTe+fMTSK+S2T1axr4g6mapjXAdMOaKuselsnu3YXQ20q2aAl2QDyFAyXthyDqhcAbThyuskjKBhjNdprL5DQqg8efi3FzbiLx0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4792.namprd10.prod.outlook.com (2603:10b6:510:3d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 16:45:09 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:45:09 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 36/43] mm/mmap: Use vma_prepare() and vma_complete() in
 vma_expand()
Thread-Topic: [PATCH 36/43] mm/mmap: Use vma_prepare() and vma_complete() in
 vma_expand()
Thread-Index: AQHZBBHdAbYbG5CjqEiHO5lqEGIrpg==
Date:   Tue, 29 Nov 2022 16:44:35 +0000
Message-ID: <20221129164352.3374638-37-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|PH0PR10MB4792:EE_
x-ms-office365-filtering-correlation-id: e54be76b-688f-4b03-95bf-08dad22913ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xEEYWcVQ50h5AwwwvTKFAIU7t1FXIl1+assAZdxLL8zMLGYSQ0r+K/BG+Hnbgu0lRqIBLgv9A1OnO4oQGc8iZjp/tZ8e++xSEqPaTYy0N7V40DuRJb9IUs3yKtMVTWB7VuL+j8Q4hTp6H2tAtcOvSF9/lu+GUK2qu+AJ5BefM5NAffnAUWX8S7HtSkljj2oQWUjbTC4nyJSCmO+ktrJLZSsKHdSfdRtN3gecSNU63uf9YnszqnLXMFOPPmV1v2zsqzNqGwlAzbYv7qQ1CmVQXeDoyosVljeBlKBPkXRoLP3wWOiac0Y62d3kJP6wgN99xCR7Lak3uqZd3WJhRazQ12SYvJVuwTCZ7+OE7uEHIMUQtmb5AwRv8lDB38x00f8Nz2VxyfJG7AZ3P1mSsSbYKbamxkrj5gYAzV8aEbfzvxenv3yJ7vxe/wzgrcDYG1b8N5UPdm/a4BpBdaoLVsgE1YRUe6lMd8BZoU095YP/9pY8cI+R1uTecnRcMGp6KoG1EBL/8vGd+Jevs8iDMK85V1/DNt2ls72oSGxpy811fOJNmO/XCZA3GBuEzgBCwP+KHUf9SHg11lZWPrZ4BlNN/09OWYNJm1cWRgpN7h2Zm62rZjRP3SxoruSd8ugDozKTs1xYBaC9F1xV3xoW21xzwXeMQ1PE76nDy94ritvhdyfcNx4QfUC+bjs4Lxq0ykvQwGy51EdMpC1WRriMLo2Zkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199015)(38070700005)(2906002)(36756003)(86362001)(6666004)(6486002)(71200400001)(107886003)(478600001)(44832011)(41300700001)(316002)(76116006)(66556008)(66946007)(91956017)(5660300002)(66476007)(26005)(110136005)(66446008)(4326008)(54906003)(8936002)(8676002)(64756008)(6506007)(6512007)(186003)(122000001)(2616005)(38100700002)(1076003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vLcR6gPegKI66JmW64S/YTpZLNcZ93gvEt3MuTsEQ5nqvjJhiEvB5UqHjQ?=
 =?iso-8859-1?Q?waCHGZ1yDGqHdAoXZ5KJAbTknNSgB4WFuJTmU0eDSWMkTYMvFdkfQdFvs6?=
 =?iso-8859-1?Q?w1y4cykk1F+RqJd46Ee2Z3CPaa3m6qjOqpmzyVxXsZLIeeuaonOktnyE1w?=
 =?iso-8859-1?Q?nmYa3cBK83f2ETRS6gcVDfldr/DQmERgmJuMb1l1P5Y0Z/PqT3Ol/MkmFw?=
 =?iso-8859-1?Q?anc96Gj7kT4N0C4ChNKEgIcUiRMN+0g6ynDQNzZ/YoZlrnx1/qspBFk4Ha?=
 =?iso-8859-1?Q?K9LAc2dLT0KETpok98/xdmNHOTj8R2l87BUQL5+Y5pIkoVKX6E7m/VDTgl?=
 =?iso-8859-1?Q?4+p+zwBX9iL7UjJ1Bfb/mZBZjTUkdrlXB1iNHkqrPt19tLFZHVOiTmzmaR?=
 =?iso-8859-1?Q?+KFuipnUGLPum3BZdW3/SrIr6QuotRWlBQdI9NoZc1sX6VtsdQGQ7iR5Zq?=
 =?iso-8859-1?Q?tSAUOqWB6Yaq94THUwaEWgNjgrJGBpn3V6Yw/ZQ1HHjFKuZuLgqVznA+jR?=
 =?iso-8859-1?Q?GJEutl0Jlm62OLdDN9ampshwVH7mKSJiHu/ZgJvkfEZ50o5MkDUta0zhbH?=
 =?iso-8859-1?Q?vMeWtWD9u7bslMlYSMRnowsHvOppd9pBYthJsqBYDOoTRw6kK5BsT/Ndwh?=
 =?iso-8859-1?Q?DTW0PO78QgMPHQaL1o7B3ioWi2pae+I7O5RQ9uDQjzRPmVI5R+ZlAoTXT4?=
 =?iso-8859-1?Q?073kiBO1JARHrBhFqMlLJKCBa2dXUmAuDgzwfidGyBB7nBvCmTcgqwgp8Y?=
 =?iso-8859-1?Q?W4oOhxDKyy8hJ2pJnm6axGobn4ZzFIob0IQJ9F17Im2xixDqVJEEOeOkDS?=
 =?iso-8859-1?Q?VmFrJVDlokF8noQDf67DJjhkkcsT6a4vUkNACit8i62zbmxDQxeDCS++qk?=
 =?iso-8859-1?Q?Dnuj4BFvthCPnDi4oj0O84jw0rYXqz3h8JOp3qh0W9ZjLLdR4SUA4rxMxO?=
 =?iso-8859-1?Q?1lvAHDlkt1rIE37hGNKj5zySMlpIWzSSpGJPHQ7z6ef2lWcXglUzbT/0Rd?=
 =?iso-8859-1?Q?bGgS5te+Be0RRYqomOqTfQCxWeI7TLzx7x9l8XvMgQGdL8+baWVmX94YvO?=
 =?iso-8859-1?Q?k8Wxb84teBZyGtErocIGuQN5G//EPPGN8PfXaLdg+ivMTo1zvTAd3olxte?=
 =?iso-8859-1?Q?iMHvvDGcP+4V4ToSUmi/TGhv3Ts8WNeJ4PWV9du5joy6hfKfgYCxcczXUs?=
 =?iso-8859-1?Q?lqyhyQLzOBOPEazQZKHIToBS/taU44UyNqNU7c5zhiPbdeeI9CamytJQ03?=
 =?iso-8859-1?Q?QmjDSe1ady3BziZ7W6E8eiIYNfvf/qZF8vitHYOnJDdU0eubxJa5z5ZAfX?=
 =?iso-8859-1?Q?FPcsd5szYtQm6GtKcN2lMVj0pPY+QN5Rs+UuebUN75bkT+/9DsLr9ZVhef?=
 =?iso-8859-1?Q?N5VeUbXZ+xOoTzJidaVfbrUbVW95WgfGFWadwbGwa93xfSh6VTCV/sy7fi?=
 =?iso-8859-1?Q?YzUVIWYNZlWC2jnHmuyjfJ46moNtxubRqbOtnpvrTwHcWsgIB16FJIN6WS?=
 =?iso-8859-1?Q?WqRYNTD0MoTzR6bUF/OK0v3XkEHOCCj7YVq4HiEw5+xn+k/Frmi5WWaaYC?=
 =?iso-8859-1?Q?AhLJHtWTxuSlKfUNGHge81EnQb+3kI03GUgpp3h0Lz8ryI2LL4pq2DieDY?=
 =?iso-8859-1?Q?PuVUVSrJ06zybTVU5VoKaZojp28kBYA17rkfCYSRSZGP4FLrQPgW8ljw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rtZ2XogGioKfHeKgOLKe6iZ8+T8G5Wkm7lt6zr+10iIesWFI5BRevFhS8KaRoMXbAawAHPRdgBkGwAlkhIpqAwByfXKFxhMxENfjQoGcPuN0ZHQQpw+4BMVfsWCtBlGGzcyCTUaAi/hr7CVSo5KPTLOmyogiE1wPVJ52R7wtfGwMlc8NNHxrPKARVFFXlqSJLMsEefQx7Gf68SAUt5XY3SObHQZ1FOVnks4sUSKhKPzgQV4eE537Uaq2fE0Rrhf2aAok4teRKXFXtSnqINoTwpyjmzLFPzJfNI7fvxU7YGCzQVCjTD3FgideGHqDG+EmH9Z52O/vPCHF3xu12WRx1mhRr0Gde9TPYuKpQZ5lAGkQJOVSZ6zJvJsSaUE0+RvnxNNZHu7l2fKBtHzIopAYvaKvUFAweVvvRlnR9mpn7wO6if2dIvLEA6hTwPC4AWSALlqHWq08aU7dDvagdyO5YkbL5NktYGYDdRugpyTm8dDiHqUNOn7XCi63N2E9XKsIVNCo30ox5mT88neQj3uPaNCjRP9PWys/r3Su/wnqefW4cUWY/McGYb3WqOPXcwXqlqSqlJAZyqjodopPC71y1TbDIfJv9JKno2NnA2qAelhSr0qakWMrOXEw2BDG5ze8TDjthtFkCPi3/2n7DOKC+BurPxal5cx5v5YrbkA925kIBUpTvYHSxx4FqbX5QXkLS1BBwhspKywULHR8z9vjtjeax4uv5yWVT+EE5zHG4YPpaQpiHBMUcBlv7ylJ8Pg/riMOaoZUfhiaIIWsbj0avpmuVLQY2r1oUmr93wsjD+KP/UXMsWmLZdCiiSrnWejj4r+7alYG8rCnKlihhEtH0Abash02YUXfcR7r6ZLqjZxg3pxDBKXIffV4XkwJfA+mcVpStQajeVLF2ktZ8bTfBg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e54be76b-688f-4b03-95bf-08dad22913ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:35.8472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UpvfAeYsEjOBpG/Z0iScVhN9NRtYz66JQS/J0scdyN+Ykdg0vvRWkd+gFn13YYKxoe7tjzA2P8x6AfcWE5ezhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4792
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 adultscore=0 mlxlogscore=974 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290093
X-Proofpoint-GUID: bD2cRgwrY-Edg-Gts5sw88HA1K_oQdZ-
X-Proofpoint-ORIG-GUID: bD2cRgwrY-Edg-Gts5sw88HA1K_oQdZ-
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
index c990a151e45c..39555335f145 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -517,122 +517,6 @@ static int vma_link(struct mm_struct *mm, struct vm_a=
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
@@ -754,6 +638,79 @@ static inline void vma_complete(struct vma_prepare *vp=
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
