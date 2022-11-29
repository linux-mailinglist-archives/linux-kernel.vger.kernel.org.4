Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C256163C56C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236109AbiK2QpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236014AbiK2Qog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:44:36 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FE354B36
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:44:35 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGP27c031378;
        Tue, 29 Nov 2022 16:44:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=5drOmKiaYPt7BOKOWcqRepYh9tBqorodN++B+8Q9gj8=;
 b=n/cJO0mBHvDna9ubXqyld95BajAkzcX716HYBFtMfXBsPnDM3IVgU+P/opmRbyBVWU3L
 KNXK9VB6NjHytesS7PZ3zt1S3W2orecXaY/oOTDR6QPWn1PGJsGApTCquKCfn0LL7RHg
 kZc9qslDP4wptzpmPLeFo1RFK5yomsUmoW742rH0IP60aDYRsuEshZJlKi+HBcE5WaEI
 uyNnlAWersS8bshV27n2Z3RmE79YBFNfJ+Qb7LXrV6J4RGQKcMo5vWuZiRW/ZbvxBc1G
 /6QsvNHHZjJ5Egw8nBeds7t/jlJTW9FtDalAvb+HGLraBBxm5oxu/nhWbR277eDYu/7f Jw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m40y3xar6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATG7rBU030968;
        Tue, 29 Nov 2022 16:44:23 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m398771pv-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZeMDOP9OEOKEUXxPGwnQ6xRftquvcxneqgxzwUc6noYffCNKspm/c4EDND1UJWcBmgyUg3WvNmWyLk4Huwi7+P6zoh0kq6GNkq2gKzp1qF5+7oXQ83yynn6zCycVRAtbj7GybUD64LYoo6FJ8/6Ak7dpxwQUT9DEAV/WTjwXQBfWkH3nra9P/NsIu5zsXQK9fnM+75oLjNNsqh4DiBOuYc5vMI83R+gewYHaDDAx2MsplLhdesmak3pog2bBKEDVqpfT5DK560UbbIzDH86kh5E5bO9mgIha2P6PP6px0Vo24ZNLm5naNBwObI083F4GUVSEl2EpEdzgY4ptS9cSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5drOmKiaYPt7BOKOWcqRepYh9tBqorodN++B+8Q9gj8=;
 b=Xl7bkoNaTcRg/mkA7mSe0VBq1duVMeFGWYC5pCia8tdxgAErimmednc6Wfyzl1XuL7P+yBJncxDrjxN4Z04JyIoIwzQzpeddx90fkD6H5jalJYDMx88GoPrjRaTRJVK9lZcM8IJcMkQ2Hua/LreBULeB5pn0BDm6ISHHzQ2sbhGaY75n01YokqiCKPWS99rGKa/kK5AUhdc5E5eILiQsJ9knV3fEQxfA59OBc27o7goSiG+c7EsrJwIviTsG+zdBD0qq/a0/gKfthhvZNA1nDTCpmclTbXwP49yFxzNdX9LXTnr55SfKxo7aL0UjB7EIEa7rk8Uaff2Qz1AW/g79hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5drOmKiaYPt7BOKOWcqRepYh9tBqorodN++B+8Q9gj8=;
 b=w3nfOiALubOj8MKMgU5cv5Hqp8zTwbCnFSyfbt7eifaeQHpj4z46okdS9za6cweglV0pEyBJkBFuGzT2AUtkRSqrYAKhrbjS3/CKqGkZGt3xFFurjiwuvPc2o1ef8w6+xvQZVOMKS+0cXEd30dI06IsDlmJL+AC1TqdRpuQjBVA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5321.namprd10.prod.outlook.com (2603:10b6:610:c9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 16:44:20 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:44:20 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 02/43] maple_tree: Fix potential rcu issue
Thread-Topic: [PATCH 02/43] maple_tree: Fix potential rcu issue
Thread-Index: AQHZBBHUuoW3C1aCOE+ijZTnJhi4Tw==
Date:   Tue, 29 Nov 2022 16:44:20 +0000
Message-ID: <20221129164352.3374638-3-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CH0PR10MB5321:EE_
x-ms-office365-filtering-correlation-id: 67a1eba2-9be8-4187-349b-08dad228f6d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0zny7NNAfveeEjVu495V8JhFKOY6pqss9l5vBV9UDV6reeF+Zwd1hxdHJQrUwABLnbXeShDphXASxXfovm8CgH4rPt6nRYfnsLiguRedUl80FVUmILqNsy5vz0PHQppepjml1DNB/ytFdIidjtAC7pm9jBRIGyTqIHa+fVBfEWP55dzNWB/DzxcNBk0/rk6hnnACub6rvEL4nbh+u+wSXmM/YyQnR2F2PQc9/pn4b5ZXuQo0Lktb4U2jwRFdBxqikJJZfYD0LPMCs+jUkASB22hSx+ImRljRNtPA52fiRwnxkuDXer7Yt5KpTyG/F6n6lg2ihgRGMMk0PDo3KJuDoEgoS6VL9/gEtGFUmfMH5Bkjl1fiYf9pPWQEkWdMYUcwwOT+T8lLry6DK//CX+ZLA2jK9BnN0JbXNwtakQjAwWSbV9Bb0gxTsFCcyamkdIWovwaQlj96YRYJDIwatjNWXZntuEnr4iggT5gj0ta/U7g6DU9VkzxrvYCaoYVsowimTPgPAGV+odaWAmmpYX9jFmGXy53gWkpMeef4rNubIJLcv25S8o7QQqzZPaW1kqtkpaj3KNwFIOyaez38+nvRFDWeUoQFvlozittr1Upx58so4eL7ppb6yqGTO0GUWTBJkmtKy/AOvSUXfkh9gpeCLvfKq3TCkKC6zUyYvlCzIcONcVTQOB06Ikq/gb7netz1WIrVE4fq3130TOxenJUYeg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199015)(83380400001)(54906003)(71200400001)(6506007)(107886003)(110136005)(6486002)(86362001)(36756003)(38070700005)(6512007)(38100700002)(122000001)(2616005)(26005)(1076003)(186003)(8936002)(5660300002)(66446008)(478600001)(44832011)(8676002)(66946007)(66556008)(64756008)(76116006)(4744005)(66476007)(41300700001)(4326008)(2906002)(91956017)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KS/VtXNdSd9dtYQL9ZbXr64WC7KeRy2yyA0Kas2w+UhdpSi9+9BxdnZlno?=
 =?iso-8859-1?Q?gYqhuRL6+7LEh76ZKyQuYqciBuyK/ffUH4fKSWs1/aCkBfdSDc0DnF7DZ6?=
 =?iso-8859-1?Q?brY5PA9BCPDD7hc9jDANl5LH8s1awiemNw3HTY8gPtNeOV3uPtbH0cDqLb?=
 =?iso-8859-1?Q?vlUqZobMLY3q5thBZ5/gQ+oGfn9J7RFUlF99jv6Wlci5NaKwgLZIdLn9ic?=
 =?iso-8859-1?Q?PCuXJkoW6ERHUWcVaVU7eEfF6KKA8vacCf6Qy9Y/w6mQX2xdnVu40SNqe3?=
 =?iso-8859-1?Q?n8g9jz/n23mn7xO4c4NmsYSxBj0bovaUqXdrBAF7od4OU39cmhubQpMmdJ?=
 =?iso-8859-1?Q?GP0gbXLHVlXWHzKaeT7wmEzoWfJL0hjcMES4Q3E4CQ4LQEYfg8gj95GiTr?=
 =?iso-8859-1?Q?Vx7Wj++6CErixYVUDiOvel5gSYKFg5jZuY4du3cFUDlCnNBQefYZPB+XPw?=
 =?iso-8859-1?Q?Dw2LqtVrS9mCucgFOPzTB5Uy9nvUHyi5/6nzYy5SNSPD93es/jXrjAI5lV?=
 =?iso-8859-1?Q?hyR329n9yyvkodo6Rhk9L16HRBvAF/qSdUKzTzFARejTej/K0a+Dd13W0M?=
 =?iso-8859-1?Q?XRgdUim6xEtIsD23ivGHWgtV4hmptAlQmIdxRhl9578csm2guf0ZOozRmg?=
 =?iso-8859-1?Q?TPny1qK3RGo2+FEDgCCtQfWAcSdi4PHU4oWk6gLYLki7Xp/1kOozsTPxy9?=
 =?iso-8859-1?Q?LIA8PxWZAj7p9HvDa5+dF5McuAN8YVyJLgbDkQkUni1olAOdkzOpLh7IpM?=
 =?iso-8859-1?Q?JSvhgr1SjCoaSFiLGR1jczmQb9FOhcWRXCIaflTgM+8423nUBEIkEpYm7I?=
 =?iso-8859-1?Q?koWDurZa3bDvcdEPFzrfIppBDwBL70o51WpjuUFyJWUmpDaNvKwgOrP+uU?=
 =?iso-8859-1?Q?75hXSrFq0J65z/AYOKVZSsnZYol6NjXN0nVqcIzm69hFPd1YMZgHMUrLTL?=
 =?iso-8859-1?Q?XxxepNym8I0YujMoHiSg6wNJH5lEJuRIUPh1NsrTcw00lXBXuvPS4UdMU5?=
 =?iso-8859-1?Q?wzFuEc0qXqeMpoLk3HkoQEckZ4nOdFVvN9ETZsUb0sHX29zZedvMzic2pt?=
 =?iso-8859-1?Q?11u5oMpxiEdYcJ/oRxVufJclQdLYWp4qNTL42dv3ZpLSAcWa4a47NzqQQO?=
 =?iso-8859-1?Q?TYkL1v14S/ByUprfPnS6p82DU7pzuJZTs8QYhLlz8otRa1R9C7zuR4B7fG?=
 =?iso-8859-1?Q?slA8xnh9IrF0+hbl5fjltqoPjgNeedO+FmCHIFHqqLlt/IHoDSFHo+MEGC?=
 =?iso-8859-1?Q?SLndpZZCWpNpLIKz/b5emcDyeylzjfj9dAK2mUYAe4fRJHTjbcZFhpB7Ih?=
 =?iso-8859-1?Q?LKdaurEvdVK2Us1sPVbAdM7jhr1SWx/jbQV4pCQJCS3aOldApxMszgJDT5?=
 =?iso-8859-1?Q?ouPLvVnAL74kAlub91VzxFo/0j/lDfmYKdxOGraF4gKvuCdiWiKu4ONzka?=
 =?iso-8859-1?Q?zdgHhLFpfKdd3yOs7TG/aPdGwXVdrhLOs8cdWWZYkgrhCrf5Ly+KCHhPM1?=
 =?iso-8859-1?Q?RU6WwLMTvncqxZoIt3sfoUeCOPa//qv39ekjc8wiS7GGjcqCJFc753/t7U?=
 =?iso-8859-1?Q?CAnWpaJvMdq0F7J/TL0fj3j7nFcxTL4XbVCYv4IB8EMUO+knfG5e5+MeCM?=
 =?iso-8859-1?Q?n1gYe/g2MGDtASLJFXtEbQbb+SBF7JL1OPofwiLp/MsrG6C8k8MlQGxw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YYnwPO1GIOIq0wyc9QOzjkbEDVAPYS6uu20Wr3S2ct3IVa3yztUJmRwKQKBGWLu0zbIn5GMWqov1rNIWkfeTRz6jYVIzP20wAq/Oc0xPEQ6XyD26EwEFZYTL9gkJaFTW60p5gkQyEp+UaA5DhbaJiUqI2ezZMtv+srlVYmMosBzhlhxmnxPjB8GHaYZPuqzYmnix64rp+6+NrU0wxEvQ1nAb7l0/UQwoMt0oNzVFk0i9XuPRLmmjjczki5A4esDfJ8Sp+3yHwYvG4DDmaXt8SD3tgFAQQ48KXkZyKYG14RyZyFSumXkBvo0kuwnNeuYNr2I/xVRjNEroGJvhduLuOo+ehPCyQWlweF83CNAzz3wGbUSBgvxevskFeemGisyos+WYC+7wkbNoxqKtnm1U5iTny76Nwk2A5ZVjMzB3n7PGc5AiN2UrGcG9+idAP1vZAOtVYS7UM0krlUZJmY7XLgFrQTzY8MqH9aWPtznmIYCJrLR5JdtmY5MIRe+PXiccvR7uqwTstqacEEI4RWb7eKhyAdSuz2CFoTY14CyYWMONsz23jZfIWM99ShQP61PkYt15OQHevvqtZefE+rGoccDeP4gO8vrgW/W+7p2xz4A3COIgW/fa8LkvrK4xiqd/FWT6YpbuQPLwKg3cd5ReSy6F5i7LDicStRjrPUIqZc9woWsySvtWFOSuSDE0+/M4xTAOuGBIK6ODumikKAI2eCnl6beYHumG70/e+cM7GiMVnK847SFSKB67x5So6O8BEJtdMglzCgpQMfzjKKNp+fYLwKQbuiCxu4svYrCS2f8ZmmSE7dWM4UhPE4AFhZDqXkllUThWkfdRl38DetxnwGaocmc6XmACJowt2l0VNJ6CIk7smicoUQ1VgGXmcrq5ea7xrHK7Di1NFhsMjUJijw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67a1eba2-9be8-4187-349b-08dad228f6d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:20.5514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TL3+mvFXqT3idKfXD8OcsNkMa0Ai+1z9HqJG3paoSgdxOuZ7R9BgDyXmfuHGEztFPuJja+tMd0DVO7HDuYXT4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5321
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211290093
X-Proofpoint-GUID: XC9tTgpvHIhWAlw2Xb_T_A9oFmnQ0J7N
X-Proofpoint-ORIG-GUID: XC9tTgpvHIhWAlw2Xb_T_A9oFmnQ0J7N
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

Ensure the node isn't dead after reading the node end.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index df352f6ccc24..ff28bd6d4745 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4654,13 +4654,13 @@ static inline void *mas_next_nentry(struct ma_state=
 *mas,
 	pivots =3D ma_pivots(node, type);
 	slots =3D ma_slots(node, type);
 	mas->index =3D mas_safe_min(mas, pivots, mas->offset);
+	count =3D ma_data_end(node, type, pivots, mas->max);
 	if (ma_dead_node(node))
 		return NULL;
=20
 	if (mas->index > max)
 		return NULL;
=20
-	count =3D ma_data_end(node, type, pivots, mas->max);
 	if (mas->offset > count)
 		return NULL;
=20
--=20
2.35.1
