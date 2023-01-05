Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D1465F43F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbjAETSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235494AbjAETQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:16:25 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B06EEE28
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:16:17 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305IUHtf030078;
        Thu, 5 Jan 2023 19:15:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=RFpRUc5Oex1lM3Q+9B7MFquPWyR86idsNW2D3KmMUJs=;
 b=VQx5jsf9tD2Rrzu95kZ4XE1ETQiBjXxHwAhzCtO1jxMBbeEzAv/5rpZswOpX/CGO/QuW
 KKrKvnKNt6eDTjJ9ITiw/3sifi5WeTZRGXJJ5q9zrBhu/BRpXS+pjyTjJqZ0oALEsIoj
 iwost2xZK0AiPWWkYNWLZQc874ZFsvaocGY/1Um7oll87PxoufGWJKv75nPSOYiEQ4vk
 OHTOIVLLXgZIcsF205tCxPVMFgktrjdFF0W4uuyWUjBfxiP8QTM5KOHxptsEvKl7hNhY
 4gpfvkMAFIItx/td7Z878b9YPF3Ksvl/4/lxZrgXUanTHtScPlgP8JX+RpupfSiZxZjL YA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtcya9k98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:15:57 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305I0WPJ023380;
        Thu, 5 Jan 2023 19:15:56 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwept6kx6-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:15:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRv3h4k5wmHYcXyZyijP4ahQ4hzS9NeK5rPQlowu1LzNHPvBjcRFaA1afMrPDdgLf4lj18ah4HdC2QY+XLFSUi0M6nP306FHAAiJBznnUnGsNQLdubQvlK54o10/ViHcLyDNanawyHm+IESLf3jGsQLer9OLSq4cePj0dK4UzdFUlPtAImThNRg8/tlNUARct0g52VXDjgAhbftYN16JGXEdsjHhcQquVSf38N2KjW53yTi6ZO7OoL2+V9sngnwa4GIPTaKLwuEJDN8toGwa4nVyo/xZJA/2TIsUrd2mmYs43E9HLF0Jl4ATehp+7F63neDKMiO6xsTOYnbWs+u7fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFpRUc5Oex1lM3Q+9B7MFquPWyR86idsNW2D3KmMUJs=;
 b=MB6pKE2unKl311mcMcrK3qo7f0QIYUi0pcJDX6ZNIhTGnX5Q50NQDK1V0oTSLmDhYYIYEd6Ik5Jv5+sYhOhq3QOWXUU6QUAK2kM5NLAq+ImMtI4z1C1dhT8rYv52zXhWwfg8zQ4Am8Gfo8ESxLBebaMcqyCc/gW94xIhf85pINmOtkrSFRqYHydcaa9l+c2uqsz4oGZ7cnr9fOFzobPgUQzN38jbdDKicFX2BBD5l+VYMFbf9FYio4x73wC7WkAvZtEr7rdfBBE8Z4SjXmZWPw+mSWVFa3zE87sFfPym3gSqvOBdZLIjU74UaU7cLdoK+yWl7OHSrX/Wexb+gjJiTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFpRUc5Oex1lM3Q+9B7MFquPWyR86idsNW2D3KmMUJs=;
 b=hP1Mo3sFp8JXxZoaBg/wPb90vHQsW7/XinF47XNmJY0iz4q+9yeEKMGXhYKlcr8pyEOOHjT6Plp25+Zx97SF1QJxKyieXWvr5/2yvejbcU+S65XMZl8rn974lCMk3MD/CxEXPACYSffZbEkHx76zJRDU9LdZJwBmc8jnqqzcRLg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5231.namprd10.prod.outlook.com (2603:10b6:5:3b1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:15:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:15:55 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 07/44] kernel/fork: Convert forking to using the vmi
 iterator
Thread-Topic: [PATCH v2 07/44] kernel/fork: Convert forking to using the vmi
 iterator
Thread-Index: AQHZITohHU+Q4KbdIEubWHMBaUK7+g==
Date:   Thu, 5 Jan 2023 19:15:54 +0000
Message-ID: <20230105191517.3099082-8-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|DS7PR10MB5231:EE_
x-ms-office365-filtering-correlation-id: eeafaa10-b497-4ba3-cf26-08daef5144d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e4B5OmhiBNvOJof8iAPhmnJF7Imyo8R6K0Y+WF4u7v7pnO2TDu4R3poziMJJtCWFQ6XaL6NnTZEtNH5Zm3WC02RMDbo7mMJV09aVEgzA9WSAVe/eBvcG3/nCd3HQj1pS7Khz0MKugaYFkkeOLqSbyiYCAgk7QYmlHPSTN5A6+/pQ412AvxXj83b+iqZCkpbEbZLdkTuZGDXOt+a27yyj9NDnmUzL/6QtYzpSkUvPNYWoFNww8ldw7o/9z0XLua6K9Qps/o/uPiJ+BWIeTxzd3WyraTgMjH25gNl/qx35oofaDEp7Q8YPfQvKZpDrbVUyLz7SwjWoyVuB/+O7COO66svYvkOyGSS/fRS6tfmu7nVxUtd1Npps4qktDn/fGMlTiRKFLuNuYxlAPMDE9xN59pbpM/Ydp+IqaBaoNoAdVq8XPElYZPxH9aAuCY0eDkZ1OQxdGVs9StgbPwyVPy1OZFUm1kCckGz1iEAv1uFv3t8d1d75JgS7ofomB8T7Q3wh/SjROxHBppY225oo6psuSncOsIvPIwsVB67mrlG54QUL50hF6MGqLD5PqN94EFoJIPghOQAD3MzL2ohjFmq/bu4BajZBSDQ/pL1sJV/5AYG6bM7tpcMcEo8kjvd67hSfuNXtP6BCMewcQQJJL+O3YQu01wehydrMMnXz4gDbAbCMljqq+vy06nR/OifanlK5w9/Ub7JcOR6+TcknV6aJ3g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199015)(110136005)(316002)(54906003)(6486002)(186003)(26005)(71200400001)(107886003)(91956017)(64756008)(66446008)(2616005)(6506007)(4326008)(66476007)(76116006)(478600001)(41300700001)(44832011)(8936002)(83380400001)(5660300002)(66556008)(66946007)(6512007)(2906002)(8676002)(38100700002)(1076003)(122000001)(38070700005)(86362001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2HFtpwcXzAsh7znEHWsuN7fI6M+nuyAFD+xq/2SYA5GZA1m0G6eUfZQH1w?=
 =?iso-8859-1?Q?COvvsuy6dmEahAFDdv/+b72RFyCi/XH3mN4n3mS7DKi3WMW6yBKbTKFVFr?=
 =?iso-8859-1?Q?Gyci/u5Q7aJOUtmCov37iy+EgaoqLEAHnCru+/lYRMo9+2S2L4Cc+bvkrA?=
 =?iso-8859-1?Q?1M2Rw3LielpxtMOuiVQrqu9RN/WtX7XQV2WtPnsv9rHeWu6SFRXmKrpP9g?=
 =?iso-8859-1?Q?mgbGoMRA4D72vhYmezikeRNxRPtQnSHbgcbOGfhM+YmGl+MuiqQXt/gY2K?=
 =?iso-8859-1?Q?1Lb548Xk55FcNSJuKUE7QNzg2l8vvQypo9A2IRzD5IFwpL88LA6uXQNQWk?=
 =?iso-8859-1?Q?zjKkC6cERCO3b4P1iCoI1XFmEKXW7+xFO2H3yi9JSxFEef4kmscjW++Pqn?=
 =?iso-8859-1?Q?yzfgpS0FTwG+p7qLgjLxtALFVNHBZvquZgVDyFD4OG1eIX9HH4XgXz0kM0?=
 =?iso-8859-1?Q?MTm1SywSomob8TLwJ2TQk/fS0B7d3YnC+MQUeVo174yL7clwWyFO5utuo5?=
 =?iso-8859-1?Q?DqieMyfACFj5Ncd4oV++16m9BgFfZz2W6Wq628ZQR5o3VaGkotipVZom9V?=
 =?iso-8859-1?Q?71k9lu2LfEmpMKuCkCyN3YhTsbF0+hkr7vA+fSVEqQAgEONar+GLvJQWXI?=
 =?iso-8859-1?Q?gthmWPTXVb/JcCKFGvJsfm//JxH8A+69XrEYmC6W8tuTpjlwfW6bABVTI0?=
 =?iso-8859-1?Q?juQHTW3C7wAbMuu9sq9LV7uEigBT7Z4xg4rjQKw5Tmqrr3Whf+vdgC3t/2?=
 =?iso-8859-1?Q?K+f66K/PxUpgpjlX23YJf1OXRz8k/9jbr/cS+u5OFLP8Aw+KTjMs0h6j3C?=
 =?iso-8859-1?Q?KQxYv0aS0SSKiu8dsvsPlq8ENYVd95xHvOhO5st6J3gvYe+YRFitrJw+xD?=
 =?iso-8859-1?Q?ewMQm8Zx9ILV+yspYHB0S9FLeEOd8SfCorHqZ28YAbsf2LLwj61O5EFbda?=
 =?iso-8859-1?Q?z7IM7Yw1Tf5qJKUtN2lwdv32O5fdRXOQXdQjbUbKWu6BrpVPhgLjAb5J7y?=
 =?iso-8859-1?Q?+AOPCyLvPVkvnvz0ZQtJBhm6vtjpxZdL7mI8K3gCtDcUFeBtIl/4n9DJym?=
 =?iso-8859-1?Q?X3z46e90861jjQ09frmgRT9JUcgZxsuIOlkGRojXMczBJRMeokuCWH1Lq5?=
 =?iso-8859-1?Q?s3YxHL6TBxvAlwPqoUOF+KAmikSTogSx+dCOowAtl0sq22WWtqyUdxqNQn?=
 =?iso-8859-1?Q?iO2yNsm7dTKi4abD2vYiyuGKWY0u2BglcOpXS6UyjsuBs5M5bhYRkeFPwc?=
 =?iso-8859-1?Q?M3H3z2k2fpOt23s1EbJMzyfOTCnZdCjxI6Ol1Cwv/sToQkkABwBz03kBpg?=
 =?iso-8859-1?Q?rg41Ca+FSucRYODH2//sxC3OmgCMKUWnKw/7SqNDsxqDU5J0G2UqI0DGQ7?=
 =?iso-8859-1?Q?KwtSFcFpqIwG1hZnCGA4PU3N0UILKncMC2xWWVB23U5H6hc7UIxFAoXnJt?=
 =?iso-8859-1?Q?NiZJnIsWk1qgnLHIB8Jp2IJrHeR8MyNJ4ZBcQiiQCB/LmmM+8FxWtKi3q8?=
 =?iso-8859-1?Q?VK8ryLPkqhtJs1wvjk2JW6ChHG6PhO6xYbYbG3Sk0AIQqvfzmKaehbmpk7?=
 =?iso-8859-1?Q?vzZrdYTPRt/sNPbpVxaTyG25nbEWuKAns9Fj0A/jmfWq2/hjpA4jzW/166?=
 =?iso-8859-1?Q?EckUzBDN2D4YhZtQ7x9FVpifk6QQ4LgrNwbXyP18gnbyCqIPuVg/xYzg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Q7DjI+ivd7RrLuAx6BillCpL/6kltF1L56hbgP142pbK/PlR8NorHEW+bdb9qxWkJxrW0cpYNxRZp0NEjgjhET8piOPEYpjRxVbxY7p4VO1upNl73U3L8V+EuW5kCvZ8SRFKTaf/aJMCZbTXxJBZqncylJeM95pw9eK9rfWCBouW6p38viTzwXBwTZYVyaQWa4ecegmnhr9Gr4HGtcIYaA6qqsuRDoBqW1dyZP8Jap6Wm8I9ax1M2/yrNbYn6YOQYXE0eTVF3blehVdrgzOh2GjEDEEo7ogbRDd7aOjC6i8Jepiuk+DrMSS3ixqJGfxJgDehPfrq3ni1lfH63Z8S5ShWS0skM+QeY4HtKLBQadC5fKA/KYDMLL/zc9rz6xqXpVj5y86A0tPyv3mxwYT90zVyF/rJesvfjTA3JdwuxNsrkpBy8zFiE/beYJPMJQWEpm3NhY3+0lqKhimaHIhPM7OSRkx0OjZ2p7RnsB0z7gPPr2cBUy8+MKMH3uZhO5xtGoquz3laWgf8z0wox53TYY0e1EY/CtD+RHrNhl/m9f5tTDarwm/rT0T6xeeE12lqP7zPQL/6MSVkjfrPcbwmcFSuct9EJMh4Y0K8c65m6Mm2qLTTqoesjmq5sXYafOnAIJWtQTXbHBWCGOpjPtw4wui2iSMIaeI3/PR0eFF4pscM1WuSlPC9ceRd5ClOBOVJ1cT3RynmAF7JF8hce6JtO0hoS7WcFabuG+OpzhkMshXR3aM7Q0dUsY9pabZxfG45ABLUftPhP2GI1WEqOfcv08QAA/Ff6JH5YccJtL5jIwEDo/SI1r/wavbXwkj9FF1uo+3HfGHHcfoZBJohQL7iAW/8TPR8X9FRKUd8zNs+oZxMfbeBuzHNf9duXM8aMqFXF1Gx2fEJahO1WRZp2LYYMA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeafaa10-b497-4ba3-cf26-08daef5144d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:15:54.5946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1YEgWlmn7BePdiQA2yy0gI69QhmXHfUfCNdRoQVb7QMuRpE5nx0a+9n7BIM6ULyBMYGdcKRty8AOgs4tMClMyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5231
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050152
X-Proofpoint-ORIG-GUID: Kqxk4QL0H9sDxqon_DdEVcLOo0RHGTg0
X-Proofpoint-GUID: Kqxk4QL0H9sDxqon_DdEVcLOo0RHGTg0
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

Avoid using the maple tree interface directly.  This gains type safety.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 kernel/fork.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 9f7fe3541897..441dcec60aae 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -585,8 +585,8 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 	int retval;
 	unsigned long charge =3D 0;
 	LIST_HEAD(uf);
-	MA_STATE(old_mas, &oldmm->mm_mt, 0, 0);
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	VMA_ITERATOR(old_vmi, oldmm, 0);
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	uprobe_start_dup_mmap();
 	if (mmap_write_lock_killable(oldmm)) {
@@ -613,11 +613,11 @@ static __latent_entropy int dup_mmap(struct mm_struct=
 *mm,
 		goto out;
 	khugepaged_fork(mm, oldmm);
=20
-	retval =3D mas_expected_entries(&mas, oldmm->map_count);
+	retval =3D vma_iter_bulk_alloc(&vmi, oldmm->map_count);
 	if (retval)
 		goto out;
=20
-	mas_for_each(&old_mas, mpnt, ULONG_MAX) {
+	for_each_vma(old_vmi, mpnt) {
 		struct file *file;
=20
 		if (mpnt->vm_flags & VM_DONTCOPY) {
@@ -683,11 +683,8 @@ static __latent_entropy int dup_mmap(struct mm_struct =
*mm,
 			hugetlb_dup_vma_private(tmp);
=20
 		/* Link the vma into the MT */
-		mas.index =3D tmp->vm_start;
-		mas.last =3D tmp->vm_end - 1;
-		mas_store(&mas, tmp);
-		if (mas_is_err(&mas))
-			goto fail_nomem_mas_store;
+		if (vma_iter_bulk_store(&vmi, tmp))
+			goto fail_nomem_vmi_store;
=20
 		mm->map_count++;
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
@@ -702,7 +699,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 	/* a new mm has just been created */
 	retval =3D arch_dup_mmap(oldmm, mm);
 loop_out:
-	mas_destroy(&mas);
+	vma_iter_free(&vmi);
 out:
 	mmap_write_unlock(mm);
 	flush_tlb_mm(oldmm);
@@ -712,7 +709,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 	uprobe_end_dup_mmap();
 	return retval;
=20
-fail_nomem_mas_store:
+fail_nomem_vmi_store:
 	unlink_anon_vmas(tmp);
 fail_nomem_anon_vma_fork:
 	mpol_put(vma_policy(tmp));
--=20
2.35.1
