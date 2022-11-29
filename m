Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93E363C57A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236204AbiK2QqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236075AbiK2Qov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:44:51 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9DC391FA
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:44:42 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGPita017353;
        Tue, 29 Nov 2022 16:44:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=cLs1VNDaoPWQ/GhtH9G+nOGR/B2yLNx8FYL80Ieaoh8=;
 b=sbv4EzvmFZHNIHt+VHYCQd2BMOdQ2aXarD95EI5VXtsJx5dzbp4o5LxdJak4ow9pN16v
 S69t1mOQTmhVwXbA0MLrp5Ny93+WI6kLOFlWf/iVz/dv9UtmbQfZTyyLWiIXFBek6Cy5
 FL9fDiizrk0Dq81v2tpLmDjdwYajHOQFzqDCQxdqmOPFVaILubeJf81uFhIdx4OWSLjz
 c0s6dtRxsJv6ozpvS1jc6+7akTK2om4/kaPmZqowdkUSLGgN1F76gsAx7ZJWgeFsuknu
 40f0yv43wpwIi68XH+4DgK2WjbkHRWweRALRPsrb+MZ+8zQEVMzDuRhY3RYGJVPE46pv wA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m3xht6hn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATFhsPl027963;
        Tue, 29 Nov 2022 16:44:33 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m3987f2au-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtIfTITP3ckwsP26mZhxH+KXp60Y+DEpWl1Uz3E//gHBnfVuUFFdonHgJbuT/SSxwPovw6WTPsHjG3MZTwo8nuM8OhJaLG7H0EGToAfWwzOyfwV7s1vt+Krz4DCU8f1+QzOkBwEEPlkdmj5HEUVTPZSj3g+5rBEQPImCj2XYVPQcIpr8wtkWhGQl5uKOGNTNUjNejHV2fyiOfEmPOsboMXbunHjm714qDYRM8ST5CtmQqPu9CTMTRxr5WJtDZfo/N6ZgoIemhoyZqAK87+UH9WqN85Qxcq6PU9zFDdg1icyn92P56AuUvChNEVPB5A8hmek8gHZFV0aXcPIva89B5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLs1VNDaoPWQ/GhtH9G+nOGR/B2yLNx8FYL80Ieaoh8=;
 b=Ec2w7HOpzzL6GlwKuBClifAXjEe3lD0qiP0sIztAx/Exz0HJ4CS9bN1qj1DwZ5MoItJ6hfBPbcuYhRZoeGL8nmsf5BxWO6pQwz+C6V7OptyNt7V7v1Tfcygl/j4zErBpQsZzjufI6NIoqD0qlFyh8QkR4wdrPVhOIuI5tApkOATF132Xf7tHRJl0bhwmst9gl703vGW/xCiLN3HQmyrTc1T0Q8hk/RmOPHs1oI2WEkrAGBWKl21na+S6sxFytLqk4zQ5TXL5Mk7PC1AKd16s8A6/cjmdQbdjlMtnzIPMdfcn40R1Fmk6zgCs/TX6zz5DE5hpnZ7rqF2tA/BG2mIDyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLs1VNDaoPWQ/GhtH9G+nOGR/B2yLNx8FYL80Ieaoh8=;
 b=JexFFvk3gCW8d5E971kT7c4M4HP1v4G5WSh5r/202tpQ1Dhqp1KtgX39pShCqjR6uXQ1WBgRQxQnXx9yx7/HgrhpCBNSaDvQtQOl7b3hBewzrz8zAmLdi7765RxYvUD5HdBIAK4IibLtfX5YNL914lKCwvbUHUxxlkCQO+3XxyM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5788.namprd10.prod.outlook.com (2603:10b6:a03:3df::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Tue, 29 Nov
 2022 16:44:30 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:44:30 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 19/43] task_mmu: Convert to vma iterator
Thread-Topic: [PATCH 19/43] task_mmu: Convert to vma iterator
Thread-Index: AQHZBBHZM8nz3i4/xkm06pBVRDx9JA==
Date:   Tue, 29 Nov 2022 16:44:28 +0000
Message-ID: <20221129164352.3374638-20-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SJ0PR10MB5788:EE_
x-ms-office365-filtering-correlation-id: 53cf5ac2-fd47-49e5-d808-08dad228fc87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZxZJ38mQEMVq7KW/cJIlZopYsceNJN1wXpD02Y/Pk77yZFUump8lYN9mCVOP/B8teIcCRFRclLYil25kZG/Fxg6wEvK/OuE5xn6t+TtnHeS6VWuZpRH87kyWLL3ZJx92TMk1KGU4NqN/K+mWsyV2zoi3zjSvgc+udqDHGu4kAX+bEkltilzzFVzypzx0m9kN25SovzdyuE3mZmZKIS8DHOjSyoe7Z5AVhsXFlXZraSFxq2u0JSeREjrKm3ZovYe3b+rq/xrDUbP6tWFtnZJiQRrQ0gommp7jVHKLVwEkG5Boeo5fsxcjzERCoeHVGAIv0OaiPG9K0J7i2WM/o4OVvAnIgRHzMK+UMVjE4lJ+EwStteNVd11hNhpEeVhbSgnk5k3nTPwPKW0M2c4K1Mz18w19X4wXa7SLSTPpBGmhmMMgzEomW2V2kfEmbSfcSSA0oR49aJg2kNGDL6PHbPTOeYC4jUNEYWAZP/DkcoD1TbE46rR9apOx4TGi3pDLEAGW0YJtP4dp75DAQwLmgr5cIpapiCZsH25BW73iTFLVMV3YJCf6PLm6Lx+O1wdscW/uvUoi5Nrz8/vb8aFd1uoiIEdTD9DxikCpe+Oj8j5Hp+tMpz5p8HEqJTEmsx4SGtoXVevvOvFz2GG/zOUl+XhXdL/4nG2lt0uml5h4uMrrECWnvJFvNcCRPkxFHbRk+jAgReY8sHGL6r7Q2FJaaiAong==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199015)(2906002)(44832011)(41300700001)(76116006)(5660300002)(36756003)(54906003)(316002)(66446008)(110136005)(6486002)(91956017)(66946007)(71200400001)(4326008)(64756008)(8676002)(66556008)(8936002)(66476007)(6512007)(6506007)(26005)(2616005)(107886003)(186003)(1076003)(478600001)(38100700002)(83380400001)(38070700005)(122000001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?X+lvYfF8tD3kZYHRM2ns96n8wc5vnUyyDWXU5PNQRcxTpz0K3V1JGdvZwV?=
 =?iso-8859-1?Q?eBAfksOmnAX0x2AEp+xF4V3JXO6WJc5f6raqUPRKyt+zlso0eDrkDwdpoz?=
 =?iso-8859-1?Q?49zk/QouASPEa0MVJXTILP/Byql0WJ6nZcbUl7Z6vs9UM3NHoEojHXQNOy?=
 =?iso-8859-1?Q?SAyBuCtamt+Z4CQYW0o0SqRnt8J/xI/H8X9lNIDtZXhdmcI17FTaHU0JUq?=
 =?iso-8859-1?Q?iW5mpJ7xpsMJDrWRpxqAO2nwbaz+ki3HwaNjXZYZ4s/wGp8Jpd9XR/VVIG?=
 =?iso-8859-1?Q?CYcCdgUtzy2fj4rn0zwvl7IXnzHRUzW35p0ztRIxfiCOSki4dX4nbwfqxO?=
 =?iso-8859-1?Q?mTYTWEyEMbxe+mjGMFHcjG9QYoteX7XhBomPafXODcurMq9XBLufp9dBRe?=
 =?iso-8859-1?Q?CkRumqZ+hHE+SOjqUqV9LmojEw/Z64WkD5wrSGcSPb0Ell1pfWDCwfx5wX?=
 =?iso-8859-1?Q?9k8TMQKNTQ/ZWjWbKqv57Y4+roo8euaJINhBTG0+8w0SKpotbIDwQhLfTR?=
 =?iso-8859-1?Q?LetzoRe4/plrf3EXtWGbkBr++mlVRs1qBmHx2gjUAB5jHZQH4UwEAbm+J7?=
 =?iso-8859-1?Q?BwfNJaOPDdRfgWFQagQm1qUMuCrcSDtGXxxW4JQViFxBciGRTNJWVR9Eyq?=
 =?iso-8859-1?Q?vSK0sBwYV8r1QV2vLG6H1kaatD8s9eB6TSa6bnAswYmNby9wjoWHkAaogc?=
 =?iso-8859-1?Q?voRStvvaARtvnVKjqPvj252uqHTsunGSjjYr/DXK09XVvOz6fdvmAXyzSy?=
 =?iso-8859-1?Q?k1kj9MuBZPGk4/FSLDOt97ELuPz8lQUYr+E9lIvpT+RUr1jOQPM9O4Z1TL?=
 =?iso-8859-1?Q?GCAHp6YBOgf52ZXhm7l7fd16B5SzKt8CFSYfUA0pFMRiX6rTQPwZUwkgCs?=
 =?iso-8859-1?Q?IAFbKZ1Iq+ZlQEGyippqzEdKDJXIAFpsVFr8i02p00lESGAhw6jvIVnc7u?=
 =?iso-8859-1?Q?3g5Hu3ir/RWjSB1IjIkWNe4Ry3EkA6ERhyQqJ8WUDVWnVsE2hFdDC2YqAY?=
 =?iso-8859-1?Q?p/70XX6HPW3VpsyPuPl2iFERpWNk2tpIIwIbs3BaF7fmzhuGdbOYP6jp/G?=
 =?iso-8859-1?Q?XuOgJQJj0oyfazJ4hsnEjzwOINMIhq1BkG8K8OossYrlLSMGeEaATHwKWE?=
 =?iso-8859-1?Q?IYSuWuzHHj/BOKnk8RSAvZPug8ob+77Gc7B2j4QmQQYR65ZVLqXdrXMFQK?=
 =?iso-8859-1?Q?qHIzsCD5RXZne3/3qLy3O5nY7GDMHFHG4aApoxqLJj9/tMs6AmZ1/la0nX?=
 =?iso-8859-1?Q?q837e1oi239MMv88F8TNuNZ9QDHZbJaBIAWpdgBPilD5PAnU0sLoEFtAI7?=
 =?iso-8859-1?Q?c+wX/N417bHzERDUPZT7uUtnxDblRIR53Z7Xx2ivKF5FAok8cCIIsODI0n?=
 =?iso-8859-1?Q?LXxcnYGVfPDVNAwaWvKSouS3ZQ9vPmPaCKT79iXP4ta+wmUz1udKgTrGgi?=
 =?iso-8859-1?Q?kIddtQgwE7IbcwOADjRMqT8VOQUEbvd4QSaixZH85CpufYREwgxpmHEWLp?=
 =?iso-8859-1?Q?lRPQRt6tGlakSlZ4Q8zZ6xIaRP4FXv+SaQEefV2cejGCR8imFTIQtyljLg?=
 =?iso-8859-1?Q?9y1RbqXy6fsywiuCS54s/ZKVn5iBO3p+V6xiSm0KOyEVt2GR4cJGZb3o2N?=
 =?iso-8859-1?Q?5GcVuEKjj9oaI0EErFeWYiAyJ0g6vZ4f6pFhQI5BVL6pHZbpiHLGJd7w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KBJVBtVD1vTmqO7auxmihpy+KiP0SZymOv96btyBY/GoITfHYPhfheYcr7MQ0pyp5oohAg/quPPMg+o7c90wxtRJFSqVa2GWJW+MJLbKO2DeMJ1EEgws1LSwxtsqdXnauZ+lwIGkSMjGxzoRtFsLDqv6UH8Af3b3GxWs3qjaN53zsZuS15of/ix/7HU6vSlWgPuerqo9xer4kx/fotw2RxpevXyEg77yEWxbxv+m8t7b/wPTCpmAOFCj9YN0XIhiKgeu4/uz0jPi85PZrJTfiPg80D8sJFpF3et+rvbI8a3UMS9hYpHqTxLlkEHqhfmCVXaNodU72XUJCP5wiQ5ewXMHz7UcKinSAbDWocCHMLF66imDm7iMe/aptXlZAlthtqAdxoyI1Z9Bov9c8gJKkCNOidLCSswTZoSfZPKJuUXBhQwTQOnwA8oUNC3hT9svYfUKtnQXYBdFHj8+l40VZVbT/0KSfI6qb4jwKy/xWg7/Z9f+0j09Rfmm/KpIR8jpcnPk0rVGrMYTH7mzl+QNJh9nydfvaoB0xQuvaaYYMlbA/w3R/ITtAnGVxraafjL2AGLcGR1F2EkiDWVKxOM0re9mnGyXnBuqK3spIRSWGCp+KLBZQY+nXPQw4lsOtX66pNMAKBq5SVKIwKj1XvzBOc+vOMDAwRDDLB6MX5P9DIaJmjWP7rSERPKK1RXOkeNFLllKnNrB/ROJtjMckVrj8L78yRCATI01Tha3CQ/RislKx0NkHoNNhcGJPnR8nNhYpjgMl+mHs7VQuNvNSJHM304TqhUx6mbS6FzHdRLjreUHok8gLA8feVZcNisC9bsyO2byqFThjyN8H/8zxI/X+KRFjwnB8RP8Do/e/s/VyEGrUQHtCEMn7N6FQLsWyawAB9dR81KCxgbo2YVDSfrLAg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53cf5ac2-fd47-49e5-d808-08dad228fc87
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:28.8633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: emR0zjespX73xJZalf7A8XAE2cylVSiz/kl7DJvpNWcPj71JZ1POiruP3jEFXkbRXNboAbqQWsZVfVcBbxFRWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5788
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290093
X-Proofpoint-GUID: ztbK3Wv2XE-kgSXBPWxf1EKkwIm3ROj9
X-Proofpoint-ORIG-GUID: ztbK3Wv2XE-kgSXBPWxf1EKkwIm3ROj9
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
 fs/proc/task_mmu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 8a74cdcc9af0..1b0bb36c51b4 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -884,7 +884,7 @@ static int show_smaps_rollup(struct seq_file *m, void *=
v)
 	struct vm_area_struct *vma;
 	unsigned long vma_start =3D 0, last_vma_end =3D 0;
 	int ret =3D 0;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	priv->task =3D get_proc_task(priv->inode);
 	if (!priv->task)
@@ -902,7 +902,7 @@ static int show_smaps_rollup(struct seq_file *m, void *=
v)
 		goto out_put_mm;
=20
 	hold_task_mempolicy(priv);
-	vma =3D mas_find(&mas, ULONG_MAX);
+	vma =3D vma_next(&vmi);
=20
 	if (unlikely(!vma))
 		goto empty_set;
@@ -917,7 +917,7 @@ static int show_smaps_rollup(struct seq_file *m, void *=
v)
 		 * access it for write request.
 		 */
 		if (mmap_lock_is_contended(mm)) {
-			mas_pause(&mas);
+			vma_iter_set(&vmi, vma->vm_end);
 			mmap_read_unlock(mm);
 			ret =3D mmap_read_lock_killable(mm);
 			if (ret) {
@@ -961,7 +961,7 @@ static int show_smaps_rollup(struct seq_file *m, void *=
v)
 			 *    contains last_vma_end.
 			 *    Iterate VMA' from last_vma_end.
 			 */
-			vma =3D mas_find(&mas, ULONG_MAX);
+			vma =3D vma_next(&vmi);
 			/* Case 3 above */
 			if (!vma)
 				break;
@@ -975,7 +975,7 @@ static int show_smaps_rollup(struct seq_file *m, void *=
v)
 				smap_gather_stats(vma, &mss, last_vma_end);
 		}
 		/* Case 2 above */
-	} while ((vma =3D mas_find(&mas, ULONG_MAX)) !=3D NULL);
+	} for_each_vma(vmi, vma);
=20
 empty_set:
 	show_vma_header_prefix(m, vma_start, last_vma_end, 0, 0, 0, 0);
@@ -1271,7 +1271,7 @@ static ssize_t clear_refs_write(struct file *file, co=
nst char __user *buf,
 		return -ESRCH;
 	mm =3D get_task_mm(task);
 	if (mm) {
-		MA_STATE(mas, &mm->mm_mt, 0, 0);
+		VMA_ITERATOR(vmi, mm, 0);
 		struct mmu_notifier_range range;
 		struct clear_refs_private cp =3D {
 			.type =3D type,
@@ -1291,7 +1291,7 @@ static ssize_t clear_refs_write(struct file *file, co=
nst char __user *buf,
 		}
=20
 		if (type =3D=3D CLEAR_REFS_SOFT_DIRTY) {
-			mas_for_each(&mas, vma, ULONG_MAX) {
+			for_each_vma(vmi, vma) {
 				if (!(vma->vm_flags & VM_SOFTDIRTY))
 					continue;
 				vma->vm_flags &=3D ~VM_SOFTDIRTY;
--=20
2.35.1
