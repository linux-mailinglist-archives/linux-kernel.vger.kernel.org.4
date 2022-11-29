Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3132F63C571
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236076AbiK2Qp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbiK2Qol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:44:41 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D850E5FB83
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:44:36 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGPi3V017345;
        Tue, 29 Nov 2022 16:44:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Ufnemc5E8l7su13CiARu4CuypqBYWD/DnCBOjfPQad0=;
 b=pWDX0u0G37VVN0JAoEcpb6q99moeUBzKU9bypuK7vlfRRWTp8X1ekyIgQeFAo2hInO/b
 iT0GeZpzEF2HWRk5qsqoxqYtozgwlAEuDE5seHlsPChrfLoPtSKSWUMH87TXRnnI664f
 njOE/J280GViOGuLIBxmV32GAtGr1xSEBL2Kql6/gYGffjgnzyoBJX16ymlV8wPzKkFK
 4JesEp0WV5ICzrgxri8HD3JTdACRcmmJ/o6vVhqSro7ePYgrDITA0UR2pGvfxeHqi26N
 QjGF/HnMIfYUbiQvkIhFLq42xc1hbl8Wdkxc8FWOlQ6K5ejNVPT4qBIoSdR+x7UdjYzb aQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m3xht6hmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:30 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATFhsPd027963;
        Tue, 29 Nov 2022 16:44:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m3987f2au-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nULxEEnSGeMNS40XL+NEMXEK6RtRW25mv8UconbZ1tSh0YYD71vgu+Yi2WbKmQ0GAATCo2Ms/KpsYrKvfrRwavWJpdv4twCXNWOxnisGBY7Ba31v78T/aegsg649HMizD8BZjaDPelFQ4OQ5fBUP2w6h3t6YywR61TUpppHeYvUMFBZkmO9HU+ymDG495B9/aYcX4DRgS3UhCFB3xF9fXBxkfQziSHADNnHtpVkHgl+ZH9Q4Ji5I27YblWb5ydfBfJf4JzRH1hpTLS7cXplIomS6Dq3bCdmZi95q9TVn2GfE1DWdwwhqOHygOVyx1HS3wqbY5NFu/QuKcm8NgXESxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ufnemc5E8l7su13CiARu4CuypqBYWD/DnCBOjfPQad0=;
 b=lCXjg4jBDanCLibEZu5I55AwIM7Dy8txKxZW3N/JFpw6ab1R0aTqg3N3THQUyFRQUlbPHerJU81mwzmcCWJX350a/uOhfoFddeAC0CoJIuuh/dYO1cAYAgXqVk+qILnyzsqmHDYREEVd40eJatPDA3D88AYYnF5ogrg+xfIoo9fe17G3caFMuOpFVgfwbTatKerqTpZxdOjsF9cBO8hR3brpB/vKPDMRwnavyYBU/sWBvikGnHweRlzLVyCL0ZflaZv+22607SKrwyNcJnqu13JBV0003Xxmt5sFpl+JgOTsXq8A1oY+8+3O8Cubc7pE8ooTYdvZBG9FQvGxJ55ICA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ufnemc5E8l7su13CiARu4CuypqBYWD/DnCBOjfPQad0=;
 b=xhuZ3HEiJnFlXTSUStNktkK/Hp1V46Jpf1oXHTNxH70Bmuv3cSRXjbD4ZNtK5w9a3BgnpAWDVQd2Sx2koLHCFWy5lb1W+J50IMguVf470m8EA7kw7ClV9BTJ77eGP3ZS74/tjmAYkkb2TcpwGfLXzbmJNgws76RmNVJA/L2ALYc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5788.namprd10.prod.outlook.com (2603:10b6:a03:3df::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Tue, 29 Nov
 2022 16:44:27 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:44:27 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 13/43] ipc/shm: Use the vma iterator for munmap calls
Thread-Topic: [PATCH 13/43] ipc/shm: Use the vma iterator for munmap calls
Thread-Index: AQHZBBHXQ2dH3de69kOOD2y6QD9gPw==
Date:   Tue, 29 Nov 2022 16:44:25 +0000
Message-ID: <20221129164352.3374638-14-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SJ0PR10MB5788:EE_
x-ms-office365-filtering-correlation-id: 5967641a-894e-4cc2-80d7-08dad228faa1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tot/ScNto2RuoVR0KwYAhqU1E05AqwYPitBsG8OrbeY3dxQ+/1uIHaamdveHAOsr5fQynIEACCo+DZ96T5HpKL34fi+YRFQ2otb2JcofWxAelPFrhucPipAlkpTGk4luzeJKh3V14vFGRPRuXMVJAUTwl0XG/fVyNKpcA8RhsxSs4Qd9xFfnb/Xnt9qkgVDPe0j9OgbOSUFSuPgeIbAln0OAAB3xuEI9OUgHWvlx2DxYRKYUQXkVQrr+GUcrCS43Rw8s72zaM7rNPvRGVTqHwXA19e1cd3AXfmLRpQxIevR7YkEF2u4H9pTgdfvpzI6KqfutS9e4J85EeFhsJQkm8Pdb81G6hhxqqc5F67LCf3nDAiSbCBhU3cDksGAh5UPDyBc8+FvPE08LShUzBIyCe62FzddEPl9fE2heMsWaHmCK8MA/he+rZJznP3jEWa0JEYcTGOFKb1hkXdW37idQ6nEkKrOUkDYqL+oGbOYw0CmXjuwLm73Yt1Xw5JRj/o3l5VURFzVPhYoC4ZjPzkPxlpQXV+PehEFFIvBCjVycSdYznuJaHdwvNNcYRN/da07mhM4B+DjqFttpeiaxn5MPepH9ZDD8TXOrpdSvwe2YLBvHbi1vwEFue3mS6H3USlL/rbbNjtF8ge/oQZ9ZO1g5W3c8wiyyNGeHbX52jbjNurpxf0K3lJERayxJBImlsnHfWbqP5l/OLlUxs2+e8/IxYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199015)(2906002)(44832011)(41300700001)(76116006)(5660300002)(36756003)(54906003)(316002)(66446008)(110136005)(6486002)(91956017)(66946007)(71200400001)(4326008)(64756008)(8676002)(66556008)(8936002)(66476007)(6512007)(6506007)(26005)(2616005)(107886003)(186003)(1076003)(478600001)(38100700002)(83380400001)(38070700005)(122000001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZFWJvYYL4G5RhTO+KvydPzvvIx+xipRRo5gp3N2fYPXaQSSHaN3827WNSL?=
 =?iso-8859-1?Q?K8CNw6BYAZxIFEiTM2R7CaBgSWa+UIpVyzsTr85ooocazrn1N6m58qcSbi?=
 =?iso-8859-1?Q?qJ3JysdcNXYsZ1GmniP6BgAm6N2tnfw5VzaLEk478i0hxYCmaPo6yxsHpn?=
 =?iso-8859-1?Q?IS2YtLhwV5BCTmkxwhhNiYTpqpqGTi8gjeHuaMfiXCyJF0isN77tq9pf3x?=
 =?iso-8859-1?Q?MEinfJ9reSfyx07v6GutJpb2Xj7zTAsGuuvsIwOP1Hf6XgUYdQe1f3AaE9?=
 =?iso-8859-1?Q?L4OewFGwkzd+lGGjvv4wWTcbwxOixL02fgYm0LUVmHokACWgkrxtPkAKcO?=
 =?iso-8859-1?Q?FQ/EGswC+hJTuMIfTXWhCGwxFh09HLiPHedE7mgF2UfvS+4L3Xp/8Bdcx0?=
 =?iso-8859-1?Q?FLdkJ2bWTp2W5SkPdk6F7zSfvMb25bHSEqnjUkmR1WThehRzxDcKWk8KMf?=
 =?iso-8859-1?Q?k8MzTCOaKwJ99Z7xf0T6UlqnOEh6Ug/WRfb0xthnMYUyZYGPT5WrDz4D9f?=
 =?iso-8859-1?Q?fL8uEKa0RVIhj3kZOJ13zAepHPVkrko2J/cPTBQ0hCsQPxfnsRN10rVucN?=
 =?iso-8859-1?Q?fFFkC8k0jqweyN/5YnAVGfEojrvcGg+w3zccgcxyR/5z4fh2h/9IdUU0PR?=
 =?iso-8859-1?Q?B3gxNNFMdPGKXZh/7GyVHFjsmAsfnD5pU5YdGbKntxoUfnH8+IYpNrhvkn?=
 =?iso-8859-1?Q?VUBf2Xy0pYf5UI9nmvoDrCD2QzvejQdQU2foYrpOgVwUZhcU50d3ouDNrh?=
 =?iso-8859-1?Q?xL2N9rSYEWgMWIIXV11ynYrISdZr/2I0k8F3zmeqh2BT8PUSlrQfYIqvTi?=
 =?iso-8859-1?Q?J+k3Phard4nRb0i94J6QuEY/zjEToEo/LNI1B399AGNhler6ldpOf7/o46?=
 =?iso-8859-1?Q?oXmD0lfUoSUkYOM9hnjYWqAn11owk8UADVpNQ1fKAslAWEQFuvdYLog6AD?=
 =?iso-8859-1?Q?EGm74wV0CETGKiFT6TCHoxPndpKVW+KnnQDS2qFC135GMGXWuCZ+jyZ/Qm?=
 =?iso-8859-1?Q?6VypM99RW1IZRWCg3itX4J8rNRF7iHI8UBK0YDDdQM4xNGKR2mzbUwrQ0M?=
 =?iso-8859-1?Q?h8sIqx/Y7UUybrozD0szA8auyLsuEHiK0sy84kvGHRTZzdV2TrlN64em4G?=
 =?iso-8859-1?Q?eVgCyv/LR4MLUhHGaQGS/zXhfByhv5XR3cnpo1QYUATObmYQTzTov/M8Ge?=
 =?iso-8859-1?Q?dsCbAfES5ZX5jt3BjKaMmrDQA/5MdtcR7MF74Cy8cRCulb6N68T2HsAbM8?=
 =?iso-8859-1?Q?ynLHBDueRH5x8OaDP6aryYEJv3SeGqME940h8XFcQRqFBV+/HAGDPyP14V?=
 =?iso-8859-1?Q?tP0M/o3kqxXEDZTAchRPjkes467luhKtfj/ofm5we88odZGPwc1vxJswHs?=
 =?iso-8859-1?Q?FMbfkX4TOk2SzsbxOKLmsTYhMOAbmSj2tSiijFaynz7Uq4QaRQVzL15+Q4?=
 =?iso-8859-1?Q?2KUbnckoS2H8rXTcg9LZsyc9ab3Ytnmsdx+9OLf+NSIfQEDf9JQDo8iXMj?=
 =?iso-8859-1?Q?ZlA0o1qTcGpzasD8Wh5j7FyKQHKlm61gVpw28LvDfMpz/G4kuvOH+rP+dh?=
 =?iso-8859-1?Q?4P69AhCvr5J4SQs0gPIKR731NYsTAxubAyveUazaH4B1jhOBAdakMaqqjB?=
 =?iso-8859-1?Q?fFn0c+wM/BfGOUMVrz/9Awc90DOVcEKX00cGlEnpYkkf50j5+bM4zxJA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iRdC+b17qSHaNRViSWpk03u1eB2Xa32CEYGHLSG+IDCI+lgV7DUl3EiNxHRZrPdph31N8h2kkbU3a3NP6sQtgPsdSHzJ3oYzq8c47ST1dJ09jWH9Sv06x9C1BASRXntocmDbhWfeIrfZ5CVW8hJ8+jPgaLAgZ3PZsA2KUCMt95lbqQK0m84lEmnYo9st5/M4wi3yySLbDG7QyjcamZf2U3kzDXc6x274PvVZQzPb/c5CXa9X/42rzFeXWdMHeEfsZoGv1sf/c+ZUSKMtIGfWxGntfzS2r8eGcYp+NFO+G1pHhaEm6IWDmW5cYE0Dccg4VNUWBcO0CdqcsFjoI+uDPXWzd4mGHktt8IfuIhtt5LA8qKYmGfZ+skRgUqs850JcTuagx0o/lna6+b62tWVPsCB+kn6Dw8/KFPvzCvIckRE8VN5OaRcBKYzvzRV0xle7JqFX9ZDeczkOzxmtVYGfMh+JbKsGaEPWePM+wlUwYp5hPBqkkll9p+h5qcfLW+ooBq3Qch1sLrEAnKGfFIfEYuX+TNINNVdJvNuPGGygrhTKere72dCvJrPp5m+idz8P1qS4qC7S3ZF8U3Ft+Q3KPKPozfow9BmmKyK9kqD1kgF0nhPzrcbKvOycr3SRF9c2r1K8q3HCavd1JUo3sLICU5+fr5xzLf7q0Cec0IK3TBykCUD7boFGUCelBkrHyNqfBfF0E17wb9hGuSp0k57JTHEH/ozAvimYB9FLk8NkM9cfblX6g/m4aaixGk5Rs9PxqsyKkEEpXbFGz+/IcrD6FSAmyT9onKVFQXLo57eyqF+VHe3DZZzFybJfitFV0lFi7CsvMV9PoeeBqh08gQBWi1iamsukcCOEfK091whPvFR9ygkOWIRYlJ/G1jVA/ANevwPJrzj56k+AF9NNem/azw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5967641a-894e-4cc2-80d7-08dad228faa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:25.9260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nvE+VmwZnqupaEdbCCvIKLK1U2IJmplM3SB/sgotp7Ro7afLwgYrV8UbNZZE17FsoFd5qUJSMxiHcXM+cDzrtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5788
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290093
X-Proofpoint-GUID: EeGPAVROID8zDfWFbmAM5eutt2hLEJ14
X-Proofpoint-ORIG-GUID: EeGPAVROID8zDfWFbmAM5eutt2hLEJ14
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

Pass through the vma iterator to do_vmi_munmap() to handle the iterator
state internally

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 ipc/shm.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index 7d86f058fb86..b866a5ea2e78 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1770,8 +1770,8 @@ long ksys_shmdt(char __user *shmaddr)
 			 */
 			file =3D vma->vm_file;
 			size =3D i_size_read(file_inode(vma->vm_file));
-			do_munmap(mm, vma->vm_start, vma->vm_end - vma->vm_start, NULL);
-			mas_pause(&vmi.mas);
+			do_vmi_munmap(&vmi, mm, vma->vm_start,
+			      vma->vm_end - vma->vm_start, NULL, false);
 			/*
 			 * We discovered the size of the shm segment, so
 			 * break out of here and fall through to the next
@@ -1794,10 +1794,9 @@ long ksys_shmdt(char __user *shmaddr)
 		/* finding a matching vma now does not alter retval */
 		if ((vma->vm_ops =3D=3D &shm_vm_ops) &&
 		    ((vma->vm_start - addr)/PAGE_SIZE =3D=3D vma->vm_pgoff) &&
-		    (vma->vm_file =3D=3D file)) {
-			do_munmap(mm, vma->vm_start, vma->vm_end - vma->vm_start, NULL);
-			mas_pause(&vmi.mas);
-		}
+		    (vma->vm_file =3D=3D file))
+			do_vmi_munmap(&vmi, mm, vma->vm_start,
+			      vma->vm_end - vma->vm_start, NULL, false);
=20
 		vma =3D vma_next(&vmi);
 	}
--=20
2.35.1
