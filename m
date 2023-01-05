Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0093865F42B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbjAETQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234806AbjAETQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:16:06 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687E2201
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:16:04 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305IUMWw002739;
        Thu, 5 Jan 2023 19:15:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=m6Tx7nAJZ+GxOyzn9iiDwdI6oGCO77RYAvxfmdcFqVE=;
 b=qk25lVnBrpk7KtPT0BQFxlZ0PhuJT7oHxJHUnKSQ8rSq1PyO1XZGk8kowukxqkGKOf/Z
 WGWVTbdWfOXYbzTDOHDqyiI/PJRRas8k5EhO8S/iqYRHyb8GCzjIMay5Fov0COqN4Z87
 DY544lPwPStzqmVUusrclFHiP8vo1M6acH6FGXTfhsYdrnJpQNOmW47zEVO2XXDV9p6c
 2ni6fx/20HNBQz1TDlT6/Kz7QFhvj+ckui4jYciwv16fPvVITUW6X5jS/GgpRaPRTxSz
 GQs97sWQKIAqlR6aRmcMpuCtQqjLlCkzx9hQ00ThtiOmD7hEyY8BLJMA8Dt9nelILaq+ iQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbp11pyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:15:55 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305I0WPD023380;
        Thu, 5 Jan 2023 19:15:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwept6kx6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:15:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0rrDUzaWZ6aJ9Qa5WQHztjSUuwDyVK56emfy84r/mp3vdz31p4GJ66tAp5xIzOjf5pqf1GIPH9nFd5pd9zPYifMBeKFFoTq93MluDWmu8GaV+9x+dhHZyOajhsSa0QYXFVOxouUSQAOsn/ceCEqjQ0M+NjYSKcCFD5WDQE6jc0vvhRTTie1ci+k167yTMODHa8W+NFKe+SYI7CRuoy+hLnHV348HatRQpNVYPcqsDEG88J2q9HvyCBcgUpp7v6b6pbKtfJ2/yJN+r76gDAro+srT/2Yxei5BQflCh/M2CkBzoNdXeMXNn8OFlNiDRDF/gctFekeqQddl1BkcbF09w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6Tx7nAJZ+GxOyzn9iiDwdI6oGCO77RYAvxfmdcFqVE=;
 b=obWLal72JHifAlZiBQZHxVUufT+4d0+ThsvUBV4NwDwKQpaQNbqYrcITcI5ZUjx91r7Jc9z0Nclx6zcdoNMHCtfYXgNhf6QzzeOOP77ACkx6pUFLgY2XqWfJkzHnQ1NzXzSOa6qdgNz7kKM/h0rO06oe0QQHf5y12ZJSn7JjC1amWxI+IVXQBzp6e0OcRueg+CGEUxupxFUll5zqpF8wvE8QyKxd28z+sr5knoBWDJIQ+d9/+JSRlgj5vf1i/3PSFR3H6+FbUutY/HRdNpcCBvMruABeROT0d7EoaKvC8maT38V0r5aOY/3CRaiCZEMCDfNLr9Iy4S6mcwqClwve5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6Tx7nAJZ+GxOyzn9iiDwdI6oGCO77RYAvxfmdcFqVE=;
 b=HnVamv8OLeohzXWEeIWZNLcbejgVfYN4dK7/CX9yL8GiLds38RGYZJmzOI+srGvupnE5k8EbsqtBMtgwPijvFL9aPMJFEtjIl4XLOtp0C/qfwdZdScivS0y/xS4cKXWNU+Qu9aEtgf0hE9wLVZMelzevXXrTtOltJ5DJnPOy1A4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5231.namprd10.prod.outlook.com (2603:10b6:5:3b1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:15:52 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:15:52 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 01/44] maple_tree: Add mas_init() function
Thread-Topic: [PATCH v2 01/44] maple_tree: Add mas_init() function
Thread-Index: AQHZITogFbBOR2K//0mHKkwW8mLvIw==
Date:   Thu, 5 Jan 2023 19:15:52 +0000
Message-ID: <20230105191517.3099082-2-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|DS7PR10MB5231:EE_
x-ms-office365-filtering-correlation-id: 8476a4e6-9d3a-477d-fb3c-08daef514356
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HvxcrhJq6iNrZQZw+DVAd1pN1QxlXJk+KR7z/FgbLsMWw5c6wYMAeEygQymzYM9N+Pdy1VCtxVyh5BDwjGDU0Orem6ZqdPKuEBKMIBRYhHXRCXoYcAh/4yTxkoGjBfKUeVTkH/2CmefC6hrKdjdHbesSOjXFlTPeU5npQyujnt+9ToeeBrD+xArrCEEac4cKZLVqhA6RBlogl+Una302HVqQyyTli2NfTXAOsds69xU4Lfboa5XAhbZrgPh6s/A/Poz5cP0VImk65jxQbkVwzcga24ysURLw/z/baLNj3PvLm6Z6Hm3knP50z4Rbgp/FUlHskLzjSLp554PCfgKC9Zek1MHTOZfBQvj/l44HOkuF1j04Erj9OSNwU4RjLWd21+Nl5hJQZWf8ML7sfExm8VMro5CwgtIVfThBlv6hQ/kiyTDCrxALfu5bD5CqnJFzDrXhMO9XUmKm0Hj/jvrwdkSPTPquVc3Ch6W+rxeG3sJm43HTlr9av+46p1NZESyRkwFD4wPU+O2+OqHCmhNm1wimFzTAA8TjHgWXs9u2gE4oxYp+igls4nA9K25M4lF3dYr0b4++js/hk0G5pqlNhdbVngGtFvq5gCNUabVoWIwe2rDDEvcTImr02zBYi1MAnquC6M8/NkpZdPypo0z5dRTWqV9z1sNtT62z66fdMfp69JOF8KsfYALdvLvaj6noQI0WeNsTPKxmxQ8gAOzN6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199015)(110136005)(316002)(54906003)(6486002)(186003)(26005)(71200400001)(107886003)(91956017)(64756008)(66446008)(2616005)(6506007)(4326008)(66476007)(76116006)(478600001)(41300700001)(44832011)(8936002)(5660300002)(66556008)(66946007)(6512007)(2906002)(8676002)(38100700002)(1076003)(122000001)(38070700005)(86362001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kqPjjaoCjD42JKdGkXNgarEBRqJ8cZaAxDhgBfENr1+/5fuoG0TAog8rUr?=
 =?iso-8859-1?Q?4//T6lu3DMua7mr2tiJAunEW82J3a1R9In+OJ4V6CPnrPyDoqMxHc9aXU1?=
 =?iso-8859-1?Q?2vFIO96rIxkyzLxI3+9bCZxAp7M0qr+LWH3jjEMfOyFGvl+86n5WMhjXPa?=
 =?iso-8859-1?Q?QxcDpvY7k9FcJciQRuGUIHCXezdbxL/akpu1F1DVO7TN2vtRi4VHDfrH++?=
 =?iso-8859-1?Q?8q1wLiuuP6UJp785s+hw196xgWU7DSbvTSvDvFYqkS0vCIpzZHdAGgidV/?=
 =?iso-8859-1?Q?WqYKUi7F8UrqrYV83l/vVyAJGlM5TRYP4Y60/Y90dP6t4hTrofYqJFOMQI?=
 =?iso-8859-1?Q?jG+9zc8szUICXUz7UQ/N3fQmX+kb+m6GJXz1MN0Q3JqNHJMzQrbt4YL26A?=
 =?iso-8859-1?Q?94CvqU6VUQ/UnmH8TR1KyQChfZPbasaC39UAkO82QXv/rBBqlhxIaidZ/c?=
 =?iso-8859-1?Q?MSejX9jPik3ycCdUlpG0/lUMYgnAsiLQi64h5dLBELjC2nsX5cuziZZ+me?=
 =?iso-8859-1?Q?qryRhoGUK+IP98idSlan8woexaphtouCBpU2gocG/Rqc3HZQPm+u4vVTOK?=
 =?iso-8859-1?Q?tUDINewd0J8kqfikSPPA2zDpGEsBgj6iuuWmSx7egeCI/VUgm7brhnT7pN?=
 =?iso-8859-1?Q?aTDN544TQIQ+jKRuo1bJBPRhvAK42s+zNPJyLdAeXp1vGpj79QJCpTqyg+?=
 =?iso-8859-1?Q?0mtZA/DL/ptqjC2chUuTVp1N4/Iqx7VP97pNFF76PXG5ysp/Jcpv83XkTq?=
 =?iso-8859-1?Q?RsLJGTZCJkcGl0Wi+p9tfes/Nv+RM/YOc8I7Tq/jp39jXxwBFbpm9XNRYv?=
 =?iso-8859-1?Q?/iGr9pKskoeTBApsjIUd121NWzk6vYa/KLfrq/B4H6OYUf5I4+t4kvXsmG?=
 =?iso-8859-1?Q?g51yDm+RiINS6tKXOmeLMcSF/6zK4cpB6ZDOb0HPsiAfpuke9gUF50xAMM?=
 =?iso-8859-1?Q?zrNR5yJi4uK/Yok2JEGXUZ1QG00QnX2PomXgVse1dgQyD4OT/cDdRz0Eqo?=
 =?iso-8859-1?Q?SXsDwg63KRAyak5/52OGLhaStyQmSUPs81lwhGsQYjQ6+QfhoE5tj9dSj0?=
 =?iso-8859-1?Q?+Ra6Vk6Nn671wqUuzxe7dXRJn2Q7WJ/Kp83wOr2ibsdMtQD+RUxLZtl9nz?=
 =?iso-8859-1?Q?NrdN3h2tGZyJcPoGuJV1YmE/dWtU+2v4zEIHa5navwanhYpIV+lC/NU2wL?=
 =?iso-8859-1?Q?MINQv8/uqtsdmp03I+TrU9iL3NwIHS0OLfTtxXFSJbHV3ws2GHGkUaA/WG?=
 =?iso-8859-1?Q?srh5rb86avF/pCuP4tfirwrgPrb6jdQMM81JUAPo/RQ8ko8/yERGIlZb/c?=
 =?iso-8859-1?Q?Gn+vV3dJjxobmOeydi9TrFvwUAbxyRDl6JE85w1LJeAKjKvvs1gYX7Kerr?=
 =?iso-8859-1?Q?rNK1f7plTXsm6HAwUQxMJAcXWECtRiIlDBe+CP34cX/DxTbV3DCi8uk/uG?=
 =?iso-8859-1?Q?l2LPuvV0csde9b0IP0XTOUVPwcnFc3xpHZ5P1sS/xJjXdl1jjty/wq8bbC?=
 =?iso-8859-1?Q?kLLhIaj76p12lNt8l7zOcv55r8iCXT2O3A9fp710dFagMTwS9FD6DlSfob?=
 =?iso-8859-1?Q?MUXwpi4Di2rICPwpuhtBhHN8O83RB2WO59gOwI4iZuC01dZqqKq+E9/j/o?=
 =?iso-8859-1?Q?jiGcERTOItAGYCI+3h5DUcrzGJoh4nTL+WCwMH8wqbAD05ZaXudFTHuA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ym8UOJy4DYJcWHZalnILqsnwuiuaBu08I+lVNZlqgkPT3r1itjFnzcYz3pw8wjQFpyxU9YZVe0K5fDcnGmIx8DTXctvBUQUhztnD8ZOyDyKp0o0omqH+29Xr6qqGfAR5EtizW01C1Q8qbKZRPIvqkwjoi7zltaAMSoeCzi5/ZO1X1kKtksDpzu6UbPYBZm4fMZ56feqDbM4vgoOxmt1+/DM5dExGUgAGfPLmlIh+6OdWTxYvrTm8xQADT2ujr7FUhGQT934nn0N1t0WGWFQOw8viIGvoMH5wq1qBzUAZeVN/cyu+S9vzo3LkJ2UDhogb9yBZlaX/2+rM44qTz2st5Nk62s1bL+eH5BHHOXf4fio9a+Jf7Bbn9c1Jz1B5K9MqMGnzqMBpGMPcYRvds18NuH6DKiL5cSSGBMFOoPKmsrb+i689DICJDdIE20b1mM9dDrOeqV60iWhyzbS3QUwiMkEOfaC3EknpgWEJkbeVyw4lDS8+EUIPtwG5sN9UySd20W30Nc8XFjzYgvO1991/3i6iIMEMNuPyxAd1OFIthzx41quKY9DfenXzXkwthXVt4j/RaFfT09UQsBzo1EKji3Z+L2G8aoj1KSIwPza1fgQX+fid6m4cQFJVoCGlIOblaBb8zZ4f5PaUlqCOVRdbs2c+mMGbRFiLtIzwrp8FoEbiaiWtjPr62FsjIFgtqMys4ZDsDXrj9Dpn41NVNg8+fGRmTLBd2r7MsN98aSfspPWA5EkrFL4xl0iR64gqyhjdT9x44qPibpYRqZV1BseHH0/cMenvrhyza2YAU8vxFu6BXkul86COvC8zb0RfaaMWHJNyJc9QhUN6R+224r6Scn/xD8qLvq+4KoXRVeUIMd8haxoBrvnPPnq5qn5n2c/ro5fcnEaDC4EbvsO/aKypNw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8476a4e6-9d3a-477d-fb3c-08daef514356
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:15:52.7041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ThMcNq4DnJWzxq1XN5OJVfy6NWLjGidI1QyUuB4mNgboqM/R6SblPzg6zADbaGkWf6mBzNYAh9QuHi6kfY/3iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5231
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=972 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050152
X-Proofpoint-GUID: yWgYLg3jHV8dMKNRW73R75Ln3Au33cjX
X-Proofpoint-ORIG-GUID: yWgYLg3jHV8dMKNRW73R75Ln3Au33cjX
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
