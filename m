Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B48763C575
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbiK2Qpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236054AbiK2Qom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:44:42 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48FF61775
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:44:40 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGP3uu031406;
        Tue, 29 Nov 2022 16:44:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=um0K/4aaOxbF/SqNaTj48KVzfpV6UppqtVeLVAtEHos=;
 b=J0nsP2n+SYOD86ihthP4l5RRAsFslPj5vX+4xnxUzcSxNV/G++n/y7z32VkJPc2IAsVc
 n5Ruz7Rb8fhY7DBnFYn3rvBAfnnmvy5dXUTb1fSOuQ44JlwOvVc8rktY/gprWg4g0djY
 OTiU+eo6OHuxvN+Zjy2RCslziWdfqKSE8lgECj21H9MAjA1OGKJG0YFUVAsm4uDWMCs1
 8O7rRBKAYIc/WHMW+xQwOcIZ0ia5GcVihC/PGAPfqFpqg4nTRaqD/jt6cgEnzQ2haIeY
 SibTBFp6wxOimD3ZHm2sKyLE0MLg4BSwpci16BTiKW+1o8E771Wh49C7WfvVtYK34uL6 Aw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m40y3xase-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATFhsPn027963;
        Tue, 29 Nov 2022 16:44:33 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m3987f2au-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpB3QMcWQY93lrEZu628YMS4LwufrLnqJeo8S/PjlFCF1olco7gQ6PCCQQCjbzFpbIxjyMisIrR5bEO6vnZcU0Xy+ffIAO5Z1vPyRDs6vlpOVErqfmg9TNDmfIRfnw+QdyZqWDZ8GS13QMoNgRmBq/ZQsL9DRkHRhHeHMvwOL4KRdDTYS6vDtlNdN7RVxl/ZDQvpNox/a3Rk2PGsW1zDLA+oP7h7CQIrwdXKF5UrkTgCVPvkOtY0OvmcuDsqWlqZTHPpzx+bNoWflHVTyVrpy1g9+2Z9+NKcNwrEgZX8ZiiM/68MmrBytcVWs4h08drh/52BsiiMQjFrhOkvX4CIyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=um0K/4aaOxbF/SqNaTj48KVzfpV6UppqtVeLVAtEHos=;
 b=JIde+0EmiSiAYKWrNGfc1r+2SEMJi8lB0RKUhHJnorcoWj5YH33+yumnc69wn2TagTVrOxoTywZYwp5FC5zNB40BhG8Hw4ug9dv07s8r5SuRFYRYAhea16NFT/Xt2RW6oAmaYSf8ZxHVlOm71O2OXdxDVQI0lNhiZCHJjZsXWrZaDOB/DVoJybJNN1AByovB8JkbYHvl0uqiCy6spN6OWHev4hftj7Ev5VIJGh7tZGwjixnLZOTbFSwICEj/YxNjaAq/eASE08Px3xnyBOSkJ7taH4GmwZNZ67VWyLBqkLlt20io7M+COonz6tR0zCEIPFYFrP+8emg1RNkTLVPZfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=um0K/4aaOxbF/SqNaTj48KVzfpV6UppqtVeLVAtEHos=;
 b=lnLxcaLxA8bbvyfG8Lj34+qlVAg4Rs9XQUktLPeFgweaTdu77YsZ65yUw5WnTmjGHP3jWyh6MxsH1K9jInddeXYhWJso3XvgQWihuWHMrj9gANVAkK+OLaq9LV2yfCw+hhluPuLcCW8UWhmwb+7h3l3oqzcYI1QqFplgpg6qrVU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5788.namprd10.prod.outlook.com (2603:10b6:a03:3df::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Tue, 29 Nov
 2022 16:44:31 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:44:31 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 21/43] madvise: Use vmi iterator for __split_vma() and
 vma_merge()
Thread-Topic: [PATCH 21/43] madvise: Use vmi iterator for __split_vma() and
 vma_merge()
Thread-Index: AQHZBBHZSYPQ4LsJL06xeWf0o94ubw==
Date:   Tue, 29 Nov 2022 16:44:29 +0000
Message-ID: <20221129164352.3374638-22-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SJ0PR10MB5788:EE_
x-ms-office365-filtering-correlation-id: 9b68fcc5-1363-45ce-308c-08dad228fd25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4UqCoxoAmAN4xudM/aEjnYP4iZD6qsOfK+EblQWNj/NnxFdC9qMNSRMaiTlI7okqxLnOErs/Y7p1LwOJCAx4iETpnlCeHt+OlukDQ3SQdfB5706MqFMWg9zUJrgHDP6o3nW+UzMzVXAMgyQK+mHznGrCSPy3uOWl/Y6KqmC6jofz4+o+FeLzkf2OUTKmnitdvRJKmaylbjvE53YElFm92lxArsTKnMyuqXuyjy/CA/BaniBgEEDnHYUlOV/SeVmUpcQ3nLmsd1OaX2WJNBLhqnCwSjtgTvYG2Pl+FUTqR0yTvoqDZ7TPisZ3Q1216PpVxGXs39Q9V1352eH3RsUZpcooR89WWSr5pgyCPatMdKrdNf88kuAfH2NHVekq2XZJlOmC3p42uWo4Ei9OyiqKe34i3kXMBE5eswOtOJbm0Tss/+Ayk4SxEQ8k4gToNR0jf518wOMm/0bWtG034xJ4HiwLQbSC62bP3bGRiN2k/mCvFdSOkRW0n0EDYmvHjCccXHjs/QLfQ89kKkmOUvsC9ZDVps05RybNaQNYiNDXkp5PHrG3y5tafPx5MnP1pMFpUkJ2XLe0b+jZzZ6gzlhixZJpTwCyvc3xOUl2W17ca291vfswa0Ycrikirms/xSICv9DrJ14hL05EdmPeZe6x73Kf8sd9o5ahwpH4Zol0LdT3B6RKlpjBMZFwR6dsK04Qa3R5o2KkQhRKiqsjHq8vAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199015)(2906002)(44832011)(41300700001)(76116006)(5660300002)(36756003)(54906003)(316002)(66446008)(110136005)(6486002)(91956017)(66946007)(71200400001)(4326008)(64756008)(8676002)(66556008)(8936002)(66476007)(6512007)(6506007)(26005)(2616005)(107886003)(186003)(1076003)(478600001)(38100700002)(83380400001)(38070700005)(122000001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uMdMSwamWspRIP9VDzhkuaUqj2c12FYNGf4GywUBBDXnLOww6uXqZ8vQhg?=
 =?iso-8859-1?Q?YxAqBaT5AFUHt4DO0VlH3+V30hB418EoaWmZPitHLjAW+/ztDgWcVwk1h6?=
 =?iso-8859-1?Q?7GY5lbEYHnOMDvll2XaI4u9AhTbg1xF0Zyx5f5bk+CWNEtkhiC26PxhTuR?=
 =?iso-8859-1?Q?u8oJ6jc2BUUJ1nSA4n6nV/ZSBYbHejSy5erZ9U/PEqYbluHSKKo992GNbI?=
 =?iso-8859-1?Q?HLiuz9ECQLetby5Tl+KCLRBXr/QTqH/awqWP31zHpIjUo1nlQ72vae0dE/?=
 =?iso-8859-1?Q?fTrYrYvlbRWhDAfdr/yGXynddorhCFdhPWfUeRTCK2iVhI8CEsnrBL2JMg?=
 =?iso-8859-1?Q?ewICJmV4W+3HPpc9TFzq5BkXyUCOjMwxIVFtPrDg4ALRaNoATDN4bfXZCg?=
 =?iso-8859-1?Q?nJXHjjgmK/y5H5L0ADL//Q28xR0Ghql2PoGt/hnxFbSNEA7FNn8fHnOYsI?=
 =?iso-8859-1?Q?OfHOF0AbzXbhALaAMazd+HBMPgL6xCxZOTzdy6V8ionqqLSFKd7+8D5Xwk?=
 =?iso-8859-1?Q?r+BUsskjsSEAsO8+epNJ9YkHU64+gwnI6fyZLWvQJKe0eidHPBNyCgFusv?=
 =?iso-8859-1?Q?0U+B7eyk1+TmFXMSZQ3EJEl7UsL2684CJLg1KcL+U82Cm1bYAVwddIYeST?=
 =?iso-8859-1?Q?U80VUPf6tCOch9PPUS2eLmR3GKAAGaPH5wSqL1w4rKkQa+v3pUjANoy2aH?=
 =?iso-8859-1?Q?yBwikWjtn92xRD08PEzwlKbqDHMpUG1jNGk2GedHYpKm3Mu5Tc4rLbFwcN?=
 =?iso-8859-1?Q?dBIDM2dGexBRX+7F2ztAa2ek9IwHTnSAp1viLZk+VT7lGRc5fQz70m3uO9?=
 =?iso-8859-1?Q?PZRfjUSVJRYcSxwyjYoZASuXNFiIJf3qwn0FyJT2DZB1NsuuZNnjNDKNuF?=
 =?iso-8859-1?Q?fwpcfHj24WGGBp9lVBowopZ9RyL1JlRNsB5z+NPTNx3TIc+U2LgskSgwYf?=
 =?iso-8859-1?Q?MJz0MUYdye8Hc1V3P9MRc1Vv4Vc24RznEdiUKAlwobMIYnFTCx/36d2rKD?=
 =?iso-8859-1?Q?Gr1f8I0u4i9OKpr35N8Lh128qxGIG6Xkba+XpTbNzO6PM8oyz5zhtkN27V?=
 =?iso-8859-1?Q?RXq5Pu4c7zBLZh2gWSFSfkALpceEHevYQIYKv+HVSYLztGn9YTrvIZtNJp?=
 =?iso-8859-1?Q?JOFzfmTnFFBkSYRIZOtXVIUOfqHlpIHFwTCKCWgOCtAI4be+LBumzQKs79?=
 =?iso-8859-1?Q?S+iDjSqX7LT3CxoF+PgRo7vPfhpM7wEccL9UeTyQDOuR3d0cRJf3phrrDA?=
 =?iso-8859-1?Q?PSOhAL+KLxWtE9dQ6hMSsJHWMxLM0pqrwkZ07hL+PtfZBb0QaShhPw4Awl?=
 =?iso-8859-1?Q?sY801Ma8LEmiVVQ9jCv8pRnhJEAiJisqgvczSw436S2DtRUKKol8ZcRX4M?=
 =?iso-8859-1?Q?UpLsB4XGftuu02dTDP1NOfwrpjxUshH7mZViGXO2gbMeqXrDjEHrx7ANRp?=
 =?iso-8859-1?Q?0UTPpQvm5saJ0SjJqsM1VWN8Ez3hbKuMq3tv1rgtpCvhbinYZhBSepB14K?=
 =?iso-8859-1?Q?YbHIj1jgF+FVAUgrI24VtV0sxB132QbTdBtjJhuoTOWjy3ggpdXJLUT53g?=
 =?iso-8859-1?Q?0I5xFssmghdBR/4PcUEdEc+kfZCUWwqP0SlNn2AkQp4GM90CoY9lLgdWIU?=
 =?iso-8859-1?Q?KoLsSNN0qf7muUCVA34b+DFhleneNj2AFCqc8IJa5RADjev+7T2kxAeQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rVcFXItgIFMhpugIOq2Ci6Di/dE2fNEDysGAOq7+BWo2Ck4inHXSupKs+tFbdd46AqL3s0khiPO3KZ8vairYkCACQUCvsHqOxBgau+5qmsCouxeKLUR9TkpYMAtRwQ+NaaTLDfDINOLOU7QH2KUY3knN3cVStYLnZiI9SRFAa996CJp3W+/2RDFOwOZwWrqA2lucxOqjp9WD3qvq2QhShZb0Mr9OgEtxooIb/RcpPf3mD6KhbzAgER911UiXkHX0qeIfIZpKlOYXVxnsCH6XspzXo8XYYfH1Bc0lEAEfoj7IK4pcWWXEtA/ewyV+80u6jX/rtohWPd7bMiI/+w1cHkNXmxRV/WOVlBMh71NG/kRQR1419lgFX0sdRE3Z4WtzMewnihsDjO8UROkmgYLdVKpGVgD6KIhqQkB+s/cwPAFOwfRbHJTZwrjRdb0Q1CenHbWrfai5YLQ0gA5MqpJ3xpaCu0GHk543nDX6EtIffp2NRQTKtREz9AhFnprzUBahRPSaLtv+FtY+/Bwht9+U7ERWaoAftKThOQWxY2k5kX4XokD6pl6wLbXJPWCPy9aZ8dveFK9ORSWHBDAXtktfO5uqbA3dGz+LYtF9hS2a4H8tRnemIq2aTKsia7e5sjzVmpSN2X15E/30TiybEuE/cGXXJfdOTZjsROlg7IQV0tmpD53mT9Xb68+Zz9PEQYrk0NewCJZrDkpjgHn2NcHi49cDX1fl+SHuemBuhsi8Hf5NsY+wr09kuRJWdSKv8rq+JhwpjSBIbLmuOlHSVL2PjMU6b/b1p8ezryVobDywuZZfxG2J05pPwZ5UKIrtbBq2A+VZXUQck+zFiSr1Goa6YDVBJulZjpgTkv0f1DZotwWbaHBBcb5sPEd5kWYGOBwqsfZNMMSP/aybUXykqnA62A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b68fcc5-1363-45ce-308c-08dad228fd25
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:29.7851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dJNyjahXswfDRrYEfXOFmdEbxrbmK9QCWindq5RoOfSTCtQ9QZgVvtUIy8zQJSbcfxPmpOcyvtyy4UAG1bRUWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5788
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290093
X-Proofpoint-GUID: D2zpaJRvJGQw5IsUoZJ-Zpfs7zF-poF_
X-Proofpoint-ORIG-GUID: D2zpaJRvJGQw5IsUoZJ-Zpfs7zF-poF_
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
 mm/madvise.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index c7105ec6d08c..2beced2d5eee 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -145,6 +145,7 @@ static int madvise_update_vma(struct vm_area_struct *vm=
a,
 	struct mm_struct *mm =3D vma->vm_mm;
 	int error;
 	pgoff_t pgoff;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	if (new_flags =3D=3D vma->vm_flags && anon_vma_name_eq(anon_vma_name(vma)=
, anon_name)) {
 		*prev =3D vma;
@@ -152,8 +153,8 @@ static int madvise_update_vma(struct vm_area_struct *vm=
a,
 	}
=20
 	pgoff =3D vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-	*prev =3D vma_merge(mm, *prev, start, end, new_flags, vma->anon_vma,
-			  vma->vm_file, pgoff, vma_policy(vma),
+	*prev =3D vmi_vma_merge(&vmi, mm, *prev, start, end, new_flags,
+			  vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			  vma->vm_userfaultfd_ctx, anon_name);
 	if (*prev) {
 		vma =3D *prev;
@@ -165,7 +166,7 @@ static int madvise_update_vma(struct vm_area_struct *vm=
a,
 	if (start !=3D vma->vm_start) {
 		if (unlikely(mm->map_count >=3D sysctl_max_map_count))
 			return -ENOMEM;
-		error =3D __split_vma(mm, vma, start, 1);
+		error =3D vmi__split_vma(&vmi, mm, vma, start, 1);
 		if (error)
 			return error;
 	}
@@ -173,7 +174,7 @@ static int madvise_update_vma(struct vm_area_struct *vm=
a,
 	if (end !=3D vma->vm_end) {
 		if (unlikely(mm->map_count >=3D sysctl_max_map_count))
 			return -ENOMEM;
-		error =3D __split_vma(mm, vma, end, 0);
+		error =3D vmi__split_vma(&vmi, mm, vma, end, 0);
 		if (error)
 			return error;
 	}
--=20
2.35.1
