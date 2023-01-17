Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAEE66D463
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbjAQCgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235447AbjAQCfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:35:12 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9711E2B29A
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:34:31 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H09ZsC005646;
        Tue, 17 Jan 2023 02:34:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=HFAiDGbuUC0QZjsFVDmOOB2qN1wSJCrnynqkWnd9Rk4=;
 b=IO4g6mmaEe4907LDEmE/u0EkWMfK6gIUZseyk9Rvud3nzMSBNroVQjy6eqWPyANCj/Rx
 MmLcx7VEaL1Z427NkVsdWoZPpGFD+G2NCs/KEsicYcaayK19JWoqlQYwoa71EoiDJJZX
 L4HYXXXez61uMIck2qCa5a10oOmuJh8SJ6oDOYua1gPM+f0D8LysgsbhRhGc6L03kZFK
 21RrI4G/zLxLvkT+DbtM1gnzpzOUIeV/AHfwuTNw7ZuCCx1nH72YbXcuFIa8ZQVNjuoK
 c2tkA8lW4YJVeVcLmVwOdaikqHg8pmdxVDFv+P9fP3ljK/pWFrIcyr8s/KjCjZXrYEwS xw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n40mdb5e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:21 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GNXAUU020577;
        Tue, 17 Jan 2023 02:34:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n4rq37hat-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grnsz7MjRY+vflkGiArlhqOE8Nl1MSGFoa/6S8c0wedCzhnr5NuP2dG7w7hAvGRUyprn7P8IJjFS0Ha9wNzlNGjDyLMkg6WQPhxWPT27rAAFhRS+bAODZ1+xjEziBIDw2TySGWGHiB6K3U8L8ZJ/Q9Lf2p92Vm27xRuUF7YhPqMkAt2EdGhHPIiyKdasEV6IrG0iNXgJUA8HDxoIKsqKr43aHpRHGbTRHu0VCtFozBSdxghNEMdGabnpGLmCANQAjCS+uuB+IMar4x8TXQgctMBfWXYlWVznUSI9n19VeUpGbA1UuB9Ri10s7nn46QVM2+mz40CWgKIJhVI1T0WCcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFAiDGbuUC0QZjsFVDmOOB2qN1wSJCrnynqkWnd9Rk4=;
 b=bBT5sXmoWHWJdPejlUbIfVdmO3V76pKH0MIAEkMQnT9CkqxaVL+MRXhsE+C82SEgqQNIP6WKTUquaiiuKitM8uENtc2TkJOyT+72VdrezEHuCG3jXQJeLKHkqG86UQqHYIQyiho58d45zuwwFWQOfKXcN1XyTWRtNr5zUnvrznXs74W4CTq4mIfBWDjBeB8o3A8us2qMSHwImJxeMJsXKb/dcY0RTk6KW/RL8JB5hbh0Ekq1dYyFZCICZQ4VI+XSlM76ucO0zPusgPeqxqBBHDXXWOgg9L2K6asoKVPw6huO94yHP/+mAf0rZnydz5FlXN+/fJuGxXcZwgyqvTN1Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFAiDGbuUC0QZjsFVDmOOB2qN1wSJCrnynqkWnd9Rk4=;
 b=EB6KDJYQiIoDxQ+pPYWEXrA3D+xhfrUZY0hpuxiE7HkoYopzA5vWGMl8uRtMhbKNvPhSm037+gtQ+xM38eR0CY7KNBri0v6FlhaNKQaPHKwXpbQveTtnJdd7lLszbzaf/+Lla6ou9gAzjMeBAK57VxfHAgf6JjpYfWXqRcRGtso=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5356.namprd10.prod.outlook.com (2603:10b6:610:c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 02:34:17 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:34:17 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 17/48] mm: Change mprotect_fixup to vma iterator
Thread-Topic: [PATCH v3 17/48] mm: Change mprotect_fixup to vma iterator
Thread-Index: AQHZKhwxHa6qBb7KIkO37o2hfrZlJA==
Date:   Tue, 17 Jan 2023 02:34:15 +0000
Message-ID: <20230117023335.1690727-18-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CH0PR10MB5356:EE_
x-ms-office365-filtering-correlation-id: d3de65e2-a99b-49e5-b26a-08daf833548c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i2cAPmXByx9kl74O3HG8cvTx2I3AmOfNEYaTsWl67E9y54RuqxG2bLOTGpoRDH1F3PSvO9JPjP80d4BLsiCKsSP8bFk94CanwYbUnEuN4VguBzZwIDTnM5/lPqKMCBboICTA9YVmxGWPzcyCCtOUVDFl8pyRNkK2X3JKDpIPsX8rOe7NJxn/JrHxZJZHf4i+3RU6XJCSI8ktj7XYSKJGEmT4Z57jxvK5BGAsFgIwwfTIorrBYpgh/Zz+ZlWmIHSORwYjRjab15HoG+sVNbzk67+ZiCPhopqYGScWzQJCmoy4TiaaWSXbWnk+2QR0vRW1gMIu29PRBDfSIBiauFuFHtWaL+O/mzEzAvV81wCYsWCBET9+JgHvmRzu79IvxjU7mJnXyox3Fz9TEJ/H3OtACzk7AJO4HZBEQhepZjkUW2gJcyisQsbPamzuidRsUyVmnTK2DUwj4fL+F2xS0FPNW0BTA1cB6Mf+YU0pWMPBUGg1OnMay6xN52TCbWRdsqRUL9uanaPgWuXB95xBNCdEhD47NLWYVA2cvz2KuizAAVlGvAFQaceodwYBsE7EkvtZH82RckBY7NNqMj/z6j+PSIfkB9tC4vR7TrBJa3wJ9dZcez9YO/O8lqgh01GuGYGbgkREFt2m695t/sbGWvc0kEf0iZO9WrKMK3slZuuXThGkJTFVFtKcuJCyL6U3yIA58xBhDei0SMa97akR0ixAFQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199015)(36756003)(38070700005)(5660300002)(8676002)(44832011)(8936002)(4326008)(76116006)(66946007)(64756008)(66556008)(66476007)(66446008)(2906002)(83380400001)(38100700002)(122000001)(478600001)(54906003)(71200400001)(316002)(107886003)(110136005)(6486002)(86362001)(1076003)(41300700001)(91956017)(2616005)(6512007)(186003)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jBun8mM75vMoIZkgeFfOletFdETGEebGTSBiN0HDOlhomgYULsPbVJPku0?=
 =?iso-8859-1?Q?NIF2CgjVdTP1seIusVbVzzMSFjerjf1PTV8yBLtvBTxlgg0WW4B4ye36GT?=
 =?iso-8859-1?Q?WAqb1G4mnhI1k17a1UA5+RTz3WSEsHTOqc7Ge8l3js6Gg/g63CN+eWa3hS?=
 =?iso-8859-1?Q?/HNdiarZkhmq0dDva2nRTJRckvF4qAy6CP1gAyhd6HWTCNQq9Ow775j4B4?=
 =?iso-8859-1?Q?J71w6PFQFFQWB1Zyo/VTVxnqSmOA7Byb5kuvG9orc2T0PZ5na3SXT9hOVu?=
 =?iso-8859-1?Q?tNjURZYm3oOdMiX8tMhHHzdlGLlYMzwUy9Wk6hXKxmfy/SIWQCY/5FLSlk?=
 =?iso-8859-1?Q?804rs2XkLHLScNZlWEl2EHEA7z+/z555WnQyudPgGQ78deClHtL2JYSdkj?=
 =?iso-8859-1?Q?6NO0AJYv5jCBx8de3YgEzp/mFsXppA/GS8QIpDBmI0j6TsA+JDUcLIWCBp?=
 =?iso-8859-1?Q?Ew5glenHHuART515bsngjExBMGhWUiLDytDtH6teStdHqT038ebki/r3oX?=
 =?iso-8859-1?Q?/gqz3d+Ebd/X/rvmrny0wgBjypb2o0lmfFpad0rSe2saN2kUV5E4S1TFWI?=
 =?iso-8859-1?Q?3PN+J83oun+wnOEJXtqkfZLOQq68UuwE125Xb42gzusGs7xP1bboVM1LWa?=
 =?iso-8859-1?Q?7hPrlGAKVR7Ox1qqE37+exNSB3XzBE65hn9G+5rqVnpbE/NT2jA4rc8PlT?=
 =?iso-8859-1?Q?y0HUT4auaMTCpQB4mpNWwvA779FwvTQx5PgOcInmlGD2UyCj/KLThqr35B?=
 =?iso-8859-1?Q?E/5m8bGLNYYgmYxDPS2taFhVh7f63FOU4He5voZRi/jHZyfPPj3dtsn1P8?=
 =?iso-8859-1?Q?zR6wZqnGqdOKB5svERk/vJpHN+qHuLv8xypttgYFQFY27yuYc7GcH+zge+?=
 =?iso-8859-1?Q?Nj8CyWD3pQOH2uT/nwMBQepgi6GnP3bZG6e7NHzAjZqCTIeGSUWIFmGEs6?=
 =?iso-8859-1?Q?G8cOt8iIY62cjHnUuqsB2fef3v0A1txP3yir+z5T2ihQlaO4FvnIo8MCR4?=
 =?iso-8859-1?Q?h1zGyZ0Zs/dYW5KbYkyvsHCOZC4TClhMTQNchS87bfy7zn9xe7Wiqzq0pY?=
 =?iso-8859-1?Q?1GjXVCl3GmfEddxCTllHkElwsR13L1N8c9908vES3/ObzDVV97Sjdha6Pi?=
 =?iso-8859-1?Q?EGzdnFAv7TH8kJm5F5r5P9mj60wsNXgp2l5Ybt0z2CQKqUCk2/V2gOa2i2?=
 =?iso-8859-1?Q?MKZr39+iz0UtOi0dIN1bT0Et1uWQEESCd8FIqM9LuFMI76NDI+TdV8S44r?=
 =?iso-8859-1?Q?hocYGBdyk10qvwmyeTX5hTQObXrU24WrS7mez5bmiWyJ0qx3bUsB1RDZH9?=
 =?iso-8859-1?Q?R5rqhIS0oXnu+TAl6QBmbIpvHeNouUmqpOndCn5XORR4hvo9WuNwJQzDc2?=
 =?iso-8859-1?Q?F5tZGNbEByT+VLzdQ4LkF5DeHGcOJ4zHIZIsQ8ORSylMrCxeY48wQiAkG8?=
 =?iso-8859-1?Q?w8UV7/pA3vM6oSSFVlzPfB9YmhBnod3CEukyX1I6U0VWFoBX64356pY2uH?=
 =?iso-8859-1?Q?Cp2anU4Xn9MRR/DcEQ2N1UeCKXWdvPXSMAdNkSImL5pTENN7nciA21YRHh?=
 =?iso-8859-1?Q?TqMQW91a/tIrOWoc6SoCLCoFc6c3HZMRodVMXJ0/XD8mhMDQbiPTeBwNg6?=
 =?iso-8859-1?Q?JpUOD9FpfTaz1YfIpYw7YI8DwnvnnhGcR6Fr1c8DRPlpzxVt5brEqMig?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qJ0KQBQgAhfyzdpP9kHk7AS6etirwdSRaLchbxL8ScI334zIjc6bFffdQTpvpEINhGLGwBiOlBgreGbzUCwu3BLpzXgeU4IRGxNvBrloeMYz82OcrRqShRdtKXM9jQHqcqT1oK4QN2HW/T4ty8mSOaiZlXbVe7bbTK/bESOJ9nt1xPILTZgVf/COQwZ5GyjWByd99rubPjodjK6xn0WVf5N+g2LhipUvH/mkzavHE5hYsHDlIvNhkUV0y0pKAlhf1djlSlvccmlhD7p7EjDfssqrm12h0oVeTzIlP72MbYzFvCBV6ZUjZjY25p3wSxsmR1Q/qUFE4wdwuCkNTuwm2fJ1RD+G6sPZy3QQ8GlBjnrIxpFngSbviuHvXDSBm0KvdeAlJ9+wb43W1fnwYELAGxlEH7bMZgCCVudcl8pcoJj5qPNM1GN6tVy8EeczKbabZgWTvWrMAq1EZZ0nuIKbXbocCox3tZUTtQMfoy8xaAPVtXGNb/O7Ei8n+I1lbWMff1+OLbo+DALVkWCtAE/AsTugaJ39rmxmNXKENalqSSZsh0IjR8P3mn7ydjQN/5dgbhVjUdyaLDDrhQbUFqxnCcq5Shn5po80yfp02aoMe02VVnzI8dWVl+ftkUe61kyDZ4dnPPqVNNpcOYY0qRz2pK4ZAcqKWxHpCDI0GFPgXnszDXDhqtlniG3+t8LhoRJ3EPJ9VODcRe3D25usesHqguOhYx6H+ITP7QOo3JTcw46drFs8E+FPiGvuUCAvzmEm1fmMa43h2HKTNGTswq5BX4IOpKFdrOLLxYsJTP6RNj2bV7qeDzN+l+KPUWFWkNUd8RMwUCpfvSqxEMoD+3QpZAPCbjuJjcJcKz/PQt69uWrAtmR/ssNXNWC/z/4OpVBBYVyPmfDtog5QhOPJJk4kRg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3de65e2-a99b-49e5-b26a-08daf833548c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:15.5937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tgEyb1L2g1pVaOXx6kB76/4CKHC6Us3/kyNT4YcXCxTCDwxR4SOir0qZbYbk8HgFkg3WP1PCZU7trKJ4K5pz6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5356
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170017
X-Proofpoint-ORIG-GUID: MW2wNPeAAHbfp2XOoc4TpSBJWu_leESN
X-Proofpoint-GUID: MW2wNPeAAHbfp2XOoc4TpSBJWu_leESN
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
 fs/exec.c          |  5 ++++-
 include/linux/mm.h |  6 +++---
 mm/mprotect.c      | 47 ++++++++++++++++++++++------------------------
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index ab913243a367..b98647eeae9f 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -758,6 +758,7 @@ int setup_arg_pages(struct linux_binprm *bprm,
 	unsigned long stack_expand;
 	unsigned long rlim_stack;
 	struct mmu_gather tlb;
+	struct vma_iterator vmi;
=20
 #ifdef CONFIG_STACK_GROWSUP
 	/* Limit stack size */
@@ -812,8 +813,10 @@ int setup_arg_pages(struct linux_binprm *bprm,
 	vm_flags |=3D mm->def_flags;
 	vm_flags |=3D VM_STACK_INCOMPLETE_SETUP;
=20
+	vma_iter_init(&vmi, mm, vma->vm_start);
+
 	tlb_gather_mmu(&tlb, mm);
-	ret =3D mprotect_fixup(&tlb, vma, &prev, vma->vm_start, vma->vm_end,
+	ret =3D mprotect_fixup(&vmi, &tlb, vma, &prev, vma->vm_start, vma->vm_end=
,
 			vm_flags);
 	tlb_finish_mmu(&tlb);
=20
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 14e3698fcbe7..bed33b5f285f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2188,9 +2188,9 @@ extern unsigned long change_protection(struct mmu_gat=
her *tlb,
 			      struct vm_area_struct *vma, unsigned long start,
 			      unsigned long end, pgprot_t newprot,
 			      unsigned long cp_flags);
-extern int mprotect_fixup(struct mmu_gather *tlb, struct vm_area_struct *v=
ma,
-			  struct vm_area_struct **pprev, unsigned long start,
-			  unsigned long end, unsigned long newflags);
+extern int mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb=
,
+	  struct vm_area_struct *vma, struct vm_area_struct **pprev,
+	  unsigned long start, unsigned long end, unsigned long newflags);
=20
 /*
  * doesn't attempt to fault and will return short.
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 908df12caa26..7e6cb2165000 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -548,9 +548,9 @@ static const struct mm_walk_ops prot_none_walk_ops =3D =
{
 };
=20
 int
-mprotect_fixup(struct mmu_gather *tlb, struct vm_area_struct *vma,
-	       struct vm_area_struct **pprev, unsigned long start,
-	       unsigned long end, unsigned long newflags)
+mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
+	       struct vm_area_struct *vma, struct vm_area_struct **pprev,
+	       unsigned long start, unsigned long end, unsigned long newflags)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
 	unsigned long oldflags =3D vma->vm_flags;
@@ -605,7 +605,7 @@ mprotect_fixup(struct mmu_gather *tlb, struct vm_area_s=
truct *vma,
 	 * First try to merge with previous and/or next vma.
 	 */
 	pgoff =3D vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-	*pprev =3D vma_merge(mm, *pprev, start, end, newflags,
+	*pprev =3D vmi_vma_merge(vmi, mm, *pprev, start, end, newflags,
 			   vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			   vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 	if (*pprev) {
@@ -617,13 +617,13 @@ mprotect_fixup(struct mmu_gather *tlb, struct vm_area=
_struct *vma,
 	*pprev =3D vma;
=20
 	if (start !=3D vma->vm_start) {
-		error =3D split_vma(mm, vma, start, 1);
+		error =3D vmi_split_vma(vmi, mm, vma, start, 1);
 		if (error)
 			goto fail;
 	}
=20
 	if (end !=3D vma->vm_end) {
-		error =3D split_vma(mm, vma, end, 0);
+		error =3D vmi_split_vma(vmi, mm, vma, end, 0);
 		if (error)
 			goto fail;
 	}
@@ -672,7 +672,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	const bool rier =3D (current->personality & READ_IMPLIES_EXEC) &&
 				(prot & PROT_READ);
 	struct mmu_gather tlb;
-	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
+	struct vma_iterator vmi;
=20
 	start =3D untagged_addr(start);
=20
@@ -704,8 +704,8 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	if ((pkey !=3D -1) && !mm_pkey_is_allocated(current->mm, pkey))
 		goto out;
=20
-	mas_set(&mas, start);
-	vma =3D mas_find(&mas, ULONG_MAX);
+	vma_iter_init(&vmi, current->mm, start);
+	vma =3D vma_find(&vmi, end);
 	error =3D -ENOMEM;
 	if (!vma)
 		goto out;
@@ -728,18 +728,22 @@ static int do_mprotect_pkey(unsigned long start, size=
_t len,
 		}
 	}
=20
+	prev =3D vma_prev(&vmi);
 	if (start > vma->vm_start)
 		prev =3D vma;
-	else
-		prev =3D mas_prev(&mas, 0);
=20
 	tlb_gather_mmu(&tlb, current->mm);
-	for (nstart =3D start ; ; ) {
+	nstart =3D start;
+	tmp =3D vma->vm_start;
+	for_each_vma_range(vmi, vma, end) {
 		unsigned long mask_off_old_flags;
 		unsigned long newflags;
 		int new_vma_pkey;
=20
-		/* Here we know that vma->vm_start <=3D nstart < vma->vm_end. */
+		if (vma->vm_start !=3D tmp) {
+			error =3D -ENOMEM;
+			break;
+		}
=20
 		/* Does the application expect PROT_READ to imply PROT_EXEC */
 		if (rier && (vma->vm_flags & VM_MAYEXEC))
@@ -782,25 +786,18 @@ static int do_mprotect_pkey(unsigned long start, size=
_t len,
 				break;
 		}
=20
-		error =3D mprotect_fixup(&tlb, vma, &prev, nstart, tmp, newflags);
+		error =3D mprotect_fixup(&vmi, &tlb, vma, &prev, nstart, tmp, newflags);
 		if (error)
 			break;
=20
 		nstart =3D tmp;
-
-		if (nstart < prev->vm_end)
-			nstart =3D prev->vm_end;
-		if (nstart >=3D end)
-			break;
-
-		vma =3D find_vma(current->mm, prev->vm_end);
-		if (!vma || vma->vm_start !=3D nstart) {
-			error =3D -ENOMEM;
-			break;
-		}
 		prot =3D reqprot;
 	}
 	tlb_finish_mmu(&tlb);
+
+	if (vma_iter_end(&vmi) < end)
+		error =3D -ENOMEM;
+
 out:
 	mmap_write_unlock(current->mm);
 	return error;
--=20
2.35.1
