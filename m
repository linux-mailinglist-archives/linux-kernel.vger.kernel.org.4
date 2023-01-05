Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E595C65F42E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbjAETQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbjAETQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:16:10 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0975F201
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:16:08 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305ITxBI029125;
        Thu, 5 Jan 2023 19:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=+gMycOgVy+MU0JxghxAAWSj026eW9Ud1l3dkHuAq2pg=;
 b=VU+69ky8KWFYjQgg6onyg8OpEzbQpFYTuQdCIEHnAx5kp/Bww61bkzvPCrozkdYEFEYC
 N4b5wXJiSkxivkzoT2NH+cUtZV6W/XurrhCPvGYQ/v6ON5h3dzN0y0q7Pj+yqnHpGlhZ
 Q5KU2Sy+ElFrFTOyTX64KKMRw9oMWGqgHf5jKxcFBz0mXHg20kiim7lvssHUdZtkk1yV
 9G1LMRMooic9bn0W/SYqpefzBrKQUPAoAOkhMoH2RaH8ncB6nnw1HZ/0IUWh7kzm+z8o
 P3Ff03uNTM5lDzT2IVy8ZXR1dNA4SfTmZ4RkciVKTh3aMf48AOO0xXCGoBqSDYeTisnZ 2Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtc0asrka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:15:56 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305I0WPG023380;
        Thu, 5 Jan 2023 19:15:55 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwept6kx6-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:15:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGuLbn5Qse39dG0xm2hWZW4hCp7+lFK5TDSqrR5VjWhDhERH8SRw8y70ZcpSiqWsZSgyzZizu0vmrPupP0QC6OtK0xhg5PKJRNH7v+NTWEqeMEmMxuxbqo9LwG0apvoUjcX2KcjH4p4VrBIBJnJ2HonQIzI4uTFsVsBUWZs+XVkyNqgsegYPc5oPBzkVtx0bmh6t+H5kLoBYtHznSI46yARLgSDCYT82/lBnkPq0+3uUr2MYZr4at3ho6wdcM3k1NkiF1xRhWeoPbOPQVeBw8Vbm0CyquGjqrotBlrh5pYYDqcSLg/CTxdvihT2pGFYsyxdFEVh36eMwUV0eUaU8Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+gMycOgVy+MU0JxghxAAWSj026eW9Ud1l3dkHuAq2pg=;
 b=HT+dmM7cx9sQdCe7NLBSVCgm4Qi5Oa/an8x/nw/9iDXSJREKwgswxXh0/xjzHcTyx0DSgPIK31D7W+40pfmlBV7WjhqWvd7o1uPm8lR7U3shcafU4M5fpSDC3SweV2+QWe9JZBNz8cJYZ/m69GrLmQbjrga+m7lco24mSJM4f81Rl1wLAaYwuwzXO+KAwvUDWU71CVPW82FBAaLLgclEYMrkRHYiRV7A6Q0jrnvqfuWbVjKEHSsCfRnV/BpEVS2T/GwtVqHFPzQ6kNcuWXZd/nZLzF7m/bohOX5AAK/niCZr+OgVTes/RGoWzP9enFmr5gClcIcBRRerjMzfGmToQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+gMycOgVy+MU0JxghxAAWSj026eW9Ud1l3dkHuAq2pg=;
 b=tFHs/MFMC7gisZsfxa/t5I+dJETJNTR1OarfYvsvZyMqQH9aZKjqXFZ9KlsyoqCzwSZa0WFzuI1+DPxrc06VPsCSnElHGLsD1DxiyRlCu7uhBJpG6G7MPcTZemn0pOzVqGW/3i7DBoUkSODb6gudqFlxb/czodE3HtUlXZPqumM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5231.namprd10.prod.outlook.com (2603:10b6:5:3b1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:15:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:15:54 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 04/44] test_maple_tree: Test modifications while iterating
Thread-Topic: [PATCH v2 04/44] test_maple_tree: Test modifications while
 iterating
Thread-Index: AQHZITohkjAAnFanJkmz4QQyg+BdUQ==
Date:   Thu, 5 Jan 2023 19:15:53 +0000
Message-ID: <20230105191517.3099082-5-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|DS7PR10MB5231:EE_
x-ms-office365-filtering-correlation-id: f8c555ea-3bba-49e6-78ab-08daef51441a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: loERLTCblH7SgALDwRWYZnfYq/OU4jnIAOjDVdGFBmBbiJPDBrRV2mB+KQ0/m0OGU/UvPkmjnZnsqD9pVXC8S7wBz6jVpUOD4SsejdDc2JjjPOEYVJI46C0d5jKyeD8QuHYc5hBc0PXAZgQ/Guf61NX8j0Xmc06GhkHn3674ZPh95JVQaQN9m+cYEThigzz4hxRqAuy/GOTiBADixR8Uuy52T+vorDf9DTa2HIeGXh0Gp1SID7JMmH7Bsx/Wz8cN5qSJ+vUq6FRgogcVmqR+x11OSSGhKcCLVXohrJzHsm3fE+A4xvKx+TZ/ABEco5sJaogANVhS/5/Vuc7/ToUmclOzeA9OdGfeTLjqh3VRt+s1ye5wFH8uOQi7MA29isf0SbQGVQQJHmyybiA3RwMB8fVkcn4y2xt5U8kvYbhl8MXes8PdlOVFJVy5gFbLkz0Ny+86stsy4ChcyAjYJT4nBG7ADt9JvHu7HJMbFuvTzUvGmrZ/8AMXgsDvGNaCGN7QH4m86Z3ZzGz8VDHPdh8x3LOi0Shq928R0xJDSDtnYY5CBSFwrR0Ym0kh/0wuy44edvz9QDyj2YftCmXATrjYfDLN8f6x+k85+q+kRr2x4zV+hRU5xZsr4s/fn3luWxBFpYHfvU3S0gRy7E7wbUw4CzfB5i8m3mBasUTwXHSkWQy7dP50Z15Un8E4i0iHOwva417hT2u7VJl2/kNnlzOiAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199015)(110136005)(316002)(54906003)(6486002)(186003)(26005)(71200400001)(107886003)(91956017)(64756008)(66446008)(2616005)(6506007)(4326008)(66476007)(76116006)(478600001)(41300700001)(44832011)(8936002)(83380400001)(5660300002)(66556008)(66946007)(6512007)(2906002)(8676002)(38100700002)(1076003)(122000001)(38070700005)(86362001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+KWnPrDtye25M7+l4F6Qm/8pgrtNIM3inwiX5zBsbqkUUreuj69r+xOVq1?=
 =?iso-8859-1?Q?0zPGuRI5gNuSXsFdofVjThxsDucjbEdrzky66NPEfBj/H/cFOmb9OVCF4D?=
 =?iso-8859-1?Q?x9/GrqzbqHfV1NuBOQJkV4ABCSeSwKlbRlXSJjoJN4MptyBmkAKjeuNwIR?=
 =?iso-8859-1?Q?Zx5sTM5hxqvqmOlF9rm+QP2Tx1TI4yCGjoCS53iut0wlzKWeJ1iXYUDwMW?=
 =?iso-8859-1?Q?N6ZJO0kmaou7xYVMDt5ZvZB9A9uhpbtaKYeT6kKEhGyKXeL1qaVOxtUcxi?=
 =?iso-8859-1?Q?VBiqEDlm84hkAwsdbolKOGDeeWnXS5GnO5/IY2zRlah0ZKb3EiRDe8Ktyr?=
 =?iso-8859-1?Q?mqwEiKPL0vnGTuKCvERbTHSBOuHH3+b5k31JIlDg4EjKf+pa4eu7aNRCA/?=
 =?iso-8859-1?Q?U34VrA3B1Css3prl7iZc7EY/bURiqBrMke3t+hiKPtMuK9VHgchQ5iaBVB?=
 =?iso-8859-1?Q?dCSYkKNOwK1wCOVXO5h/XN9VrfvQReL5E1RruYvsZR3nvrh8PFbszm8314?=
 =?iso-8859-1?Q?XwPu1U38qgUh7l6Pcwdsxh5NFnUqyA8FIvsLcY5VOEbjzxer1xVDyLvAHv?=
 =?iso-8859-1?Q?vRc1yUfsyjDIIJG2raSphWbrEuWJn0BrumUgBFThdzX1wyvHxdnUDU3GzQ?=
 =?iso-8859-1?Q?tran36Ls1Bv8fjqx8NNB3IR+fhRlI3kamriXoQjvpJBxW0ylJ1E3AG/o/A?=
 =?iso-8859-1?Q?cKLjBfHcqhRteoXQf64Yadjo1qACJb2h3LL5sO3zP309Tok8WB5x4SvLhr?=
 =?iso-8859-1?Q?IEo39GQaGmjEZkpLucQJcErpCp2Sx5mCan3a/JYcWpERTCRv1IVJEcntuX?=
 =?iso-8859-1?Q?PyzZwfQraiPoDgWiNZ1llOlPGUukKxZLJs1YA8Al/qQ0B4APgLniaCaOLU?=
 =?iso-8859-1?Q?DJIJqL1Fn9unUr4Pm6YcMynEQMJSuxGJTWubh7I3JWjscZEzWcG67oVCkk?=
 =?iso-8859-1?Q?TFg3/WGS4pQL8IJl15TLGKGOTEs4dXKRzT6QKyBfRKGWyiVmQlswpDHI9l?=
 =?iso-8859-1?Q?AT88anRKoRZN8FwH98nukxqZPmpLT3UIYkEIHjKALPEV5owwdOHxhRob5x?=
 =?iso-8859-1?Q?ZrAc8YMHlkzyBSDhw3YvPKrKQaDcPkbeYKvvPwW5fHagwumE+DG0L24onl?=
 =?iso-8859-1?Q?rDkyRhpzAsAAf8Rd0iMqjvRuWJMQlsBV1QDvrHSp0fzjF5s3mkg6LulnYj?=
 =?iso-8859-1?Q?Sxi1LcW8e1lKZkrxpcBdMhqJw6k/oXZtaiVXgCZo+I6XteQ5x7L8zVapH5?=
 =?iso-8859-1?Q?n/Z9UX5Gx5M2s7EGPFZrxZJzyrWH9pPdJfLlMsfBOxFHzfwqZL1et5XaYj?=
 =?iso-8859-1?Q?On1NGro7P9ylkegO++MO1VA4CTyezDCDCzwU9wh11Uko4RiLn26k2qmlez?=
 =?iso-8859-1?Q?Ofpg8jN04Cn6/DstTrINRruBTw9hYiwOtNw2o+WepBjF9humKK+oC47E6i?=
 =?iso-8859-1?Q?mKPkghTCjjHNLZIeDkws6Cx1SRVZe9jYwZbXwdAklmySt28SrYrYATWwRe?=
 =?iso-8859-1?Q?WV/Tw4Kvv2GxhANT79yLHWJVErN9Hl77G+RXMKxbkfchPRpBaJGYE9fMwm?=
 =?iso-8859-1?Q?BCbQ/7m0HoPwmeYataYPD1SoaISzPo/4cJL2urxY+uK+cupB3lDmumgud+?=
 =?iso-8859-1?Q?WWK/4c8uX0b9SQXdYW9rh+ZEfe5c2oHSoV1an52ZDWWJVVCVXmV9EXjg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /xuCfdt1TjWK6a9fM4NrZc0mE0e5cjetV+ZtS+p5ggfQY0vjeGF4TzYnpk9DcNrmXACykJjfrk4dwiE/9Rdix3Tzqz1hSYD/dwV/CHtAVEZqr4l+xetogOhmJF38s2G7KfnCgzlB2g8LxOUr8jyH+/dvDx7SEUXaLuVyHFKoc4DC9T6ppcj8aCZyAnalwfpq1Lj5dDONwacXUTPZjUbEBBUYC+XvCmSRk5BxytxxKW78DK72TLS+atiQllOVc8vDFi/7o9kcw2S/KTVjXLdaVy0Nk5odnwDRw59GNWnvID80ZPbrfNHvFQjj14oNAkebBLg6DZezdHS2/6+2JPNkq5POQXxtp6V/a/okDLJHQG4Ta8ln1Ezv0NGUHiTuBMMFX9pXQSS8yIp1bsc0C5jSjvKVVLq8O5NXrVwfsav2CM+k5ylVCnz2S8DuRPoUQh6l0H5vZrqDuxcNt6M6f2Ilm/aToe0fQFgkvwKZPghKtagobMzCa9F14kQlkU58v+cjaFgaFEet5GnS7+Or7bOOv3iBmdHyidusf0Fe69+vNzGWLbEWBULv88iyuqM9uY1qRikskoSvfQ52Q8pwYXyEiAG8ZCRo3AT+Qi2PHChqgyAOLe+nq6Wh9FbQihKQM7yCQGgMp95Z1zsZ+NKmAZ0yAHg3FiaDU6GPtwnte29xEgalLtTDqxh4o97Q0fjhldUa1fndBHpOwX2cA9YoQFafaltDyHY1eBXyd8rHqJzlv2gZw6M5L1LJW03ep+1YC6jmF97Clbz6qUhUf4DYi+CvlfeapQuyTGlP6T9fXZy+iXr6cQYEqRtsQmmfjfi6h+6rBJmaG9R/4hEK9eEBJQX+C5CKDqB2uHb/Sb5Z2rlNCpLEXxKt9zSDKqU+y0b4MNzg9xZLrJQh/sgBVZ2Y0omiKg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c555ea-3bba-49e6-78ab-08daef51441a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:15:53.5478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /aZ0Rg5VzwOhe/A0TwZgDu4p04G1+k1Wammd6jvvEEf6AnHRh+QVBaQPEIkWJPcGihbQNCjUItbkOxQdEorQfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5231
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050152
X-Proofpoint-GUID: g-qc-8ueBvVL-ZVKzae3xK2QAHR-ltfV
X-Proofpoint-ORIG-GUID: g-qc-8ueBvVL-ZVKzae3xK2QAHR-ltfV
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

Add a testcase to ensure the iterator detects bad states on modifications
and does what the user expects

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/test_maple_tree.c | 72 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 497fc93ccf9e..e9fe4f3486e8 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -1709,6 +1709,74 @@ static noinline void check_forking(struct maple_tree=
 *mt)
 	mtree_destroy(&newmt);
 }
=20
+static noinline void check_iteration(struct maple_tree *mt)
+{
+	int i, nr_entries =3D 125;
+	void *val;
+	MA_STATE(mas, mt, 0, 0);
+
+	for (i =3D 0; i <=3D nr_entries; i++)
+		mtree_store_range(mt, i * 10, i * 10 + 9,
+				  xa_mk_value(i), GFP_KERNEL);
+
+	mt_set_non_kernel(99999);
+
+	i =3D 0;
+	mas_lock(&mas);
+	mas_for_each(&mas, val, 925) {
+		MT_BUG_ON(mt, mas.index !=3D i * 10);
+		MT_BUG_ON(mt, mas.last !=3D i * 10 + 9);
+		/* Overwrite end of entry 92 */
+		if (i =3D=3D 92) {
+			mas.index =3D 925;
+			mas.last =3D 929;
+			mas_store(&mas, val);
+		}
+		i++;
+	}
+	/* Ensure mas_find() gets the next value */
+	val =3D mas_find(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, val !=3D xa_mk_value(i));
+
+	mas_set(&mas, 0);
+	i =3D 0;
+	mas_for_each(&mas, val, 785) {
+		MT_BUG_ON(mt, mas.index !=3D i * 10);
+		MT_BUG_ON(mt, mas.last !=3D i * 10 + 9);
+		/* Overwrite start of entry 78 */
+		if (i =3D=3D 78) {
+			mas.index =3D 780;
+			mas.last =3D 785;
+			mas_store(&mas, val);
+		} else {
+			i++;
+		}
+	}
+	val =3D mas_find(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, val !=3D xa_mk_value(i));
+
+	mas_set(&mas, 0);
+	i =3D 0;
+	mas_for_each(&mas, val, 765) {
+		MT_BUG_ON(mt, mas.index !=3D i * 10);
+		MT_BUG_ON(mt, mas.last !=3D i * 10 + 9);
+		/* Overwrite end of entry 76 and advance to the end */
+		if (i =3D=3D 76) {
+			mas.index =3D 760;
+			mas.last =3D 765;
+			mas_store(&mas, val);
+			mas_next(&mas, ULONG_MAX);
+		}
+		i++;
+	}
+	/* Make sure the next find returns the one after 765, 766-769 */
+	val =3D mas_find(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, val !=3D xa_mk_value(76));
+	mas_unlock(&mas);
+	mas_destroy(&mas);
+	mt_set_non_kernel(0);
+}
+
 static noinline void check_mas_store_gfp(struct maple_tree *mt)
 {
=20
@@ -2574,6 +2642,10 @@ static int maple_tree_seed(void)
 	goto skip;
 #endif
=20
+	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
+	check_iteration(&tree);
+	mtree_destroy(&tree);
+
 	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
 	check_forking(&tree);
 	mtree_destroy(&tree);
--=20
2.35.1
