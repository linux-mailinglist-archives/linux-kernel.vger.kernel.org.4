Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFF866D450
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbjAQCe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbjAQCeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:34:20 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DB824107
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:34:20 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H09dDD006500;
        Tue, 17 Jan 2023 02:34:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=m6Tx7nAJZ+GxOyzn9iiDwdI6oGCO77RYAvxfmdcFqVE=;
 b=qlpjwcQ+vOLp33vC9eVpvrcbDZVSarjq2TQaV5Y7C121/YbSB5e4VizuNYUBKfgxHLWR
 nEjGOAAN0Op2UHEcPaWMvGrystRoCB/e8a0eWLD/zjPiYH3QzetgUgH+dGi8qMCvuryH
 YDQq/KX3rIlxPEmT/UnyiEBOA1j4sTsHRlo9GZzLzwLyBdou/8nbuIJ9eXZGNAnc00yk
 I8qAOyKbvzawELKZulWpiiQxa73Rs0vRAHupm8qfQViYkJKE75B2RPGb3x4PGuUSi6QH
 WY7OVouI3zPmWCbI1Uq98o1kjxc3jOf1on3t0wc6M/AkrqbEuUh6cDZIXCWbi3ZFsyqz vw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3kaabrj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:13 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GMM4rX028480;
        Tue, 17 Jan 2023 02:34:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4s2rfxkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTpJEoX5pi3OWVC1PVLAynYJg5FPYipu0/U1mStbHaSa4PBNW5Abaw4GBa6EyYx+sqRF4pjJODO2+X+mMC5dfUzB+tmYBExmPls51XL5L4HmvV2xAe6eh9sMqIi32YSOF9GFGi4cH5FquMCg1/kDPmh3oBpi2jJ2Q+wzDiZA2c//WO/zp/QFsbJdP0wwrqpAfXYjXsC/dTX+j0r9KHSsV3aQbfm8Q0SzlWz6cANS4AEO8xZ6tFpEbutMNmkHbYa/Wi51Os0tNp6U6yOOL9RCRkdIC8Ky6/WCXP0MmiAJ2oDM88ggwzlmCjoc7JsS+N+V2CEG6HP6SKJAVZ/28EkpRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6Tx7nAJZ+GxOyzn9iiDwdI6oGCO77RYAvxfmdcFqVE=;
 b=S4q8HkAJtk4z0qqI5LfVjHBzBkiEQo6vdhktCVdCoWRtEA2CYoIBkCU0juGQ9hPul3xq7YibNhN3fk7+jBys8DfTaHNfoemXyHqjOrm9Jr3Uq5IWWH5w9dyRtoo4p2lVgvaCox7SHC0mwG69YvFvaWwqBf93TjXV//zeXpIeIbJlM6PFZLzbVD9AdM2CZ1oAvmQnsLEHpsfjMvUr7vwQScapoL40JNRh4ooLq4PhpJ8sgIurPVSWRjk5ZwRLBO5x6+19B5602dCzkZrxbHYvYFoX/bsKb6tZANJOER2FOXn+WH5fccjlt9J0z8bRmmDyxFdcSNyuf/K+gZKpvAsxGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6Tx7nAJZ+GxOyzn9iiDwdI6oGCO77RYAvxfmdcFqVE=;
 b=VBOcVVoSDFj//aX/QLS/qyIliXeujUhegPDsg83n0kYW4SyEtWLpLnge6L2/O3vu9vO1pTKLkyW2zIaGPdpMUco5Lz10OjFnUBw42Hq1sEOaoFVom+f1dKAxZzqyIXQZeS6BrImm5jtaiWlzBwjHGwZIJUN/MwRRvNTDznDq52U=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5356.namprd10.prod.outlook.com (2603:10b6:610:c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 02:34:09 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:34:09 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 01/48] maple_tree: Add mas_init() function
Thread-Topic: [PATCH v3 01/48] maple_tree: Add mas_init() function
Thread-Index: AQHZKhwtjrQXc+DFkUOn7yC2moEjxw==
Date:   Tue, 17 Jan 2023 02:34:09 +0000
Message-ID: <20230117023335.1690727-2-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CH0PR10MB5356:EE_
x-ms-office365-filtering-correlation-id: c1e45b57-aae7-4f19-6ffe-08daf8335027
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LAkaLZaVJaCobn0tS0VibTmr+oc2Qv+NZh7dEizm0WHQtXiu3i5pUKRuMj+NxlHivrZ4CzEfu5izVIsr/SuXW4MYYOTMh8DTJD2vEl6p9p8JzJxaO480fNxS+22PErI2wm8p+BC/HvGR24jtBk8KBx9ExGQjCMKd8AXR4yyAg7GcM14R3Z7t4+gC3PHEHeli0/nRj0aVB2SEtLCwgdledzzNrznBIrkQgmVhOV4mzzivXCE2Ni0bLHmiBqbIC0XBT/AzPpPK3sc8VyBhT4XH5VF8dy8j/5oDqBNr7lH4lPk8JMXEp4/YP0JydNrAaKxnbhgGG4WDtAEtjQPkYYd5b8hPWF+mlj1HzASNXslVD+iMBCQQxFJfmUDvHRcCJgmCLTY2ufkQjwsHBY2l4Oc1YX6zVp0phbQIiJL6mLqs+NAluwAv5lCHKQipdg+5Q7e5IjhZKbv8tAZVDFfugHKejT/zZsvVvEfmNuBEcICL6jl+nOgZvP3tMHvo3uv8tOgwmHkqJlVJPiTQx2s8/eA0mYJyZinZJtIA6eTLncRFYemZLc0ak/kl35gH2ClcrMsqnYnGjTtjm1mqhlxTYLkOt7nA/3jxQaNAOCvNGno9y/sTuP996JCOPKzrEU7dQIeet9EW9Lrb6ljSGCkTcdO+xYp/pD4VQS4vje31PZYXbnoMOY+sqXgkprfykd1CSQ7wvJ/AdBXjO6zt+qXav8/a/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199015)(36756003)(38070700005)(5660300002)(8676002)(44832011)(8936002)(4326008)(76116006)(66946007)(64756008)(66556008)(66476007)(66446008)(2906002)(38100700002)(122000001)(478600001)(54906003)(71200400001)(316002)(107886003)(110136005)(6486002)(86362001)(1076003)(41300700001)(91956017)(2616005)(6512007)(186003)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XfA6GSNK669JWbttDxBzA0EZNFMBjdZ6PfP85MejDpPvrFC7KKAPB+4QBV?=
 =?iso-8859-1?Q?U0VmvTP45rVSOewuYSVQYWUqbYEOIEbQTxsbgMOA1vKN+8AJvNDW5Xrwn1?=
 =?iso-8859-1?Q?08H5VbmNM+tFktB7o9aBzKja8VqtzgWh2acHBqdVQxV7BHGyzZcUqs7JEg?=
 =?iso-8859-1?Q?+6AXfUNjny8RR3D5TvfVK0RULBwKGlbKOdb9DM3/gPi8DJp0yNOPnjEpls?=
 =?iso-8859-1?Q?POTT18v05AVAE/erD5olr4IjJGOPhMSo4fTFHbyP73pLOaNIIsHLMoYc3L?=
 =?iso-8859-1?Q?63QcFPoxO9wArgRa5LdzY1xZOw4LqLIX00owO8OQndM/Bsl+Z+E8hZrwxW?=
 =?iso-8859-1?Q?momae81qiSASd8HOJmyGmYSvxaPQuzJf4lzgnMqftdisL0x+CJSF8db0UR?=
 =?iso-8859-1?Q?9kqgaxxK7EcWpu3qlMZEg46M+srDjkvgb9uPqF4qBVKNUKmGnTIHdpKhIB?=
 =?iso-8859-1?Q?qDKyhnl5gfffOl38E4/PfCelHriWOYpZKoOqSNuSV3E42HJLscefBXtLLX?=
 =?iso-8859-1?Q?Ve8C/9bHzvNIL9XrUJ3r9la3mnzG6X/sn4irYWivVe5QFgpZLe+1oBxMH4?=
 =?iso-8859-1?Q?Qv4FhhC+5uJF4cBTrIclK5DC/FF/p1N/kN5cQZKrOD5Pov01aRR+qZeDvN?=
 =?iso-8859-1?Q?FbvPB+QEwGXToeZ76kIeASoMQRZVx4oWgEq5bvK2KXSyRXp3nC5KZ3PSId?=
 =?iso-8859-1?Q?Pe75o4vXz7rkXLVLrYh9tl+z1vQdLr4jJhUN9IO/90wKLuQFmY0e31dXaz?=
 =?iso-8859-1?Q?sPn46fgraAZqRXEZW14MAFYtVKquSg/OsBkJAUgNs+qbmGrfOoJorLKS3M?=
 =?iso-8859-1?Q?d8ih1ET69oG9oKVD1P4/KyipH3KW3KhynqYZjcQ/UN9RR3GQEPR9TMFmB0?=
 =?iso-8859-1?Q?z8ifEbCo3iMYckOe3Ruxy/ARhnVSJIusEE+nUKUOf0QBb7VQigbCf+OW7m?=
 =?iso-8859-1?Q?MVrzholxtTaVo5rLkNLi822JIIboDhSn3Zq5wgsAYKjSGPFdxhYOEcrmrp?=
 =?iso-8859-1?Q?mLQ5rR58QMbr+R90g9uRfSoT7tPX9iy8G3d9L+Wzy4g3fw4vRZ06rd0TJl?=
 =?iso-8859-1?Q?kensY83Lk4n2Mf3WMdPLaOLB53XavvpZ+nzoG1CBIRf4t9Oba89AHbLSs6?=
 =?iso-8859-1?Q?Pp+h9si9SERKhAQZQKkustv79zwYpxTmmSZsIeBcIQCEnNdKK7xAEZilBr?=
 =?iso-8859-1?Q?l2TkG5i06HJECkRQ/mVfMjWQxknFZmp24aEeVt7MlGDSqi7AyWYR9i5xa9?=
 =?iso-8859-1?Q?Vswim307xj4guL7T5wYc0hSDT7sRgMC1tYaZbnqU04+60pwLtzw0LXsD51?=
 =?iso-8859-1?Q?G9n9zN0ADb7eeFljIk4IiH2XsWaNR4b3+S5wemFB9jnmC+SqLMZzQfA8SS?=
 =?iso-8859-1?Q?17mCIEqWTS/1ddh4HkMyIRdEHj74FHhDO2HvhXhRgO1DEvPUVoRG+9HOB+?=
 =?iso-8859-1?Q?L7th39YX80flSIvd1Qr76MhKtMAdsSS0rt50+j45Y8vW9G6y7C/od2kB4k?=
 =?iso-8859-1?Q?SGlaeXVVOScNOC6Q6LUh4wbw+5HmrEr3OgoHHTfb5LBMlkrlPR+dVWOfbW?=
 =?iso-8859-1?Q?jLJOV9o2m18aX3xqD/pHifuwZ5QDE4/lkej69x++68zFxL4VROPMokMUNx?=
 =?iso-8859-1?Q?TJyr47CJqKV5rp6JUspPOE9JE7dVeHdeZapqQbeygUBikdFAitVJb7wQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BaT9wVVHZ0/HwgiC8df1K36foIqlucoWU7+mGSxupLhL1vxe3HfuwhG/mU3dqgDnGacNoybCiU8HXnuSmfs9hljYW1wGRGBW94QC6YfIkyPtOIoW3+L/fVN+nfH1dLPlOPL4/jtA3a/8YGJRxLmtyxqAiKzrsjEm+v0MSA88fINOcCxppPEk47JN2J6R3JEqppVHRNPpdybjdUyz13YV7K4Fat62BKUZO1wjgXdo3Q2rNigHN3D0G+ojoarDThjaTYHN47S7kSYkni92sBy8TUnlQZRtgCns4xafX3AL53mWwqRrdspLPVbPjsyXso1WzbarwSQ2EGxRZJmg4uJ/2HZH7QJbch5OrCAfbyVZk6GXYBZyFXLawfJsATb6hKJBhZRl4t8cphr/QOLwJRub69QdzAF8wVSo+hcTD7OhYJAcByZU7FobltOIy3BazJtHnpms+5j+af9yfDnXAq1OB5iZCmRNn6E/b+vZE48aIlciUHt3SRlncWCtfmmEPAvd4FscuJosINrDOVrIOvDU6O9hiUZ3adIClslY7GAXPwAgq0TFYWxAsHsaUPztdVVpwh066qoRL1Pxyzi0+esmzhSEm3rv5TJjy5+zTbo9pbmZVAl/Nyth6ZPmMUuSeFIv/ubd6DbPRUD2Jt9Bldti2NnLnNe7XwU43EmVySV4njFrmWyRxnTPk0zIQySPkdqSNk9v51K5X3TwX4OtH9cELnT1A25KQ0JMZNASZ4Z53/3ZCK6TqXKNJI0IJpb/eqwR05RO/PtdZRvcjafD5QC/0xczYG/ziswkaPOjTWnirDEE64kUCcKQvZXcifLJC9f9adbAmz/o33cWcHi9fqf7kB/a08VSCsoD84Ey9rJKioRpq2+5KnQvhKd6GAU6FP9/pAfsKwhoxAJjDuAxOOUu1Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e45b57-aae7-4f19-6ffe-08daf8335027
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:09.7660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h1pEQDcNRyDxgRxXUNcNxygcDut6CVvxnW7nfTczOKaZEQJJIQiCha/b1Wtldc5U6eu+32cqnHPbauzJ7gqWtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5356
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170017
X-Proofpoint-GUID: PRvm0HTR-0_gEvISzk3xOtDLtQnR4qUl
X-Proofpoint-ORIG-GUID: PRvm0HTR-0_gEvISzk3xOtDLtQnR4qUl
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

Add a function that will zero out the maple state struct and set some
basic defaults.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index e594db58a0f1..3f972602c978 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -433,6 +433,7 @@ struct ma_wr_state {
 		.min =3D 0,						\
 		.max =3D ULONG_MAX,					\
 		.alloc =3D NULL,						\
+		.mas_flags =3D 0,						\
 	}
=20
 #define MA_WR_STATE(name, ma_state, wr_entry)				\
@@ -471,6 +472,16 @@ void *mas_next(struct ma_state *mas, unsigned long max=
);
 int mas_empty_area(struct ma_state *mas, unsigned long min, unsigned long =
max,
 		   unsigned long size);
=20
+static inline void mas_init(struct ma_state *mas, struct maple_tree *tree,
+			    unsigned long addr)
+{
+	memset(mas, 0, sizeof(struct ma_state));
+	mas->tree =3D tree;
+	mas->index =3D mas->last =3D addr;
+	mas->max =3D ULONG_MAX;
+	mas->node =3D MAS_START;
+}
+
 /* Checks if a mas has not found anything */
 static inline bool mas_is_none(struct ma_state *mas)
 {
--=20
2.35.1
