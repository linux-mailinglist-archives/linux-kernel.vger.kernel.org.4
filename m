Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370B865F438
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235512AbjAETRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235489AbjAETQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:16:25 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E9DDF2A
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:16:16 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305IT2sm020908;
        Thu, 5 Jan 2023 19:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Cmac1MFdopFe4FQG1oWkYqzoTR0Iob3h5RL8j18i6lM=;
 b=jutXYSaP6PvZ/HkUXAwljBUJIqeX9n4w/SvNp+8xTMhn9frfyae6Wi38U3eQp90a1UxG
 m4+BsTDoRpiqMfBgb4fzYiXJouoWVcBDVBH6aopMQv8unrVW/HG21Tl3ZPyrfVKg76LC
 36iDY3+N9y98EE3GKJNXtUy6882Bt5dlki2aBRrypmzO63H22asA9ywvwBA/tn6CIVkD
 AkuP24CmW4PUd+8yiaR68M1FHikW+F6PWziKAUOHEz86gqE3xtGPaccjy33pq1hzkX73
 pWda1nO39u+hzSbMAExchtIdgC6PDjPbbvXT6Um+IjcodRK+v5+O2sRmvdnxjcAZ3U8M uw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbgqsn8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:02 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305Hvlpk023372;
        Thu, 5 Jan 2023 19:16:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwept6m1t-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTalMCHFYr20nWXdnPqO2vITToeLrN9lGApdQAysmaBrb9+CVlY1nRAy0+5x3QDb1AiEAX6L/KrAWScpOe5lN8GauHgLyj5tEhKRdTH1zelFVLI7DNfoNrYFNBGs9pLAkdmRI49Q/6RPv94+BM7tO5gMsLn25zOmiWBIsdfBMYg9Efjtvn3fHUE2gW+516EGZfYXwHv7heelBALRQIfavwDoIw5u6RtsdoV8YWjAS3WgYtWxlytU2ItrdCnFe4se8ghOmjM7u3HoauxllJbVlTcuCMTRkfU9TOloyUflPYw1zAJPkaKGm1wcwTiZDPp4r8ic4otBe1QzHs7SsrICHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cmac1MFdopFe4FQG1oWkYqzoTR0Iob3h5RL8j18i6lM=;
 b=ekzVI4JBtrNJrsMm0X+eKkIqLnISfLhrRW8n/gYDxhSlrrYmvBl60t+9Rv2rus2FeTJ11rru5wMDOmJJuDMDsaI0iylckHh3FPNYKLIsCQlNZtgCom3P5avLsaJpOeZInJq9oe5pduspdhNRf8DYrm4gS0FLtitckb06lTLS6gyWWkJWQptSj9mA4BWbiX8mM87wUwX7KNBwe2K3rIxj7srkykjHJirtxr7w8uy6en3PyKEB2rdVnaVbOrAywtuWk/UcjK/VXGCKMLkv7BNnrm+ZIbfgAMQX4SnBQtWgPRDHvQWAw/SPV5DHsRQ1k7I2m0F4djKfAIkS/4mavXgg7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cmac1MFdopFe4FQG1oWkYqzoTR0Iob3h5RL8j18i6lM=;
 b=rIjLiQnC8jUDmYBZ/znwttC1HMkdezUQrgzCL9BCqedghF+wxXgXEkLpJ7Qoloe7HP/fx34NokVHNgrGeiFjWK4+EL0OCkbX2jkuPB+3/hhE6NhNzyVipNJcIYSg5SkI8scyCYySvL6neR/kGKi/tw0oKcpxxKSQCyurzJ6pqZY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6075.namprd10.prod.outlook.com (2603:10b6:208:3ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:15:59 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:15:59 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 13/44] ipc/shm: Use the vma iterator for munmap calls
Thread-Topic: [PATCH v2 13/44] ipc/shm: Use the vma iterator for munmap calls
Thread-Index: AQHZIToiC89D65XtEE6Fggv5pYerrQ==
Date:   Thu, 5 Jan 2023 19:15:56 +0000
Message-ID: <20230105191517.3099082-14-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|IA1PR10MB6075:EE_
x-ms-office365-filtering-correlation-id: 9ca5c958-4b99-420f-aa10-08daef514723
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ii132lh8cV0n2blA4A+j59eepoyEPiSy9kj6R/uTEy4JgAsZukjfC8rK4mNwFERWjmbRGZKwopXXVDZe+318SCe8C/pV6mj0TqYrEWMP45YpPm4kwNULDpT6YBk0T9Cc57c0gOajlDA/Do+6FgiC0/pAjQvIP3Z1/05UMwiD2LYwjNcflt1Sq2/1bkH+wpyZ2+4LSXm7a9Qh0Rjsg5x44+Eyfyp4XqapslllvYrOyJJtnS9bEuFZgrGnbt6RpDA/qWH0VKV7HddCYiOU4fmLKbaA0vdLBh+3X9ckMaN9DCEtBoIzqytJ+uKpVUt3GIKoetO1eF5eZ5Z16i0sYsOdpil0Fe1r8hQoJYg1Lmgr1z+G4DSHPlLLAYhI2BhVxa5Smi7U4qWUQPfRd67TsCgc3rC8VfB0264RvrvUL4d/ESoim4KqbjNKmf9Qez9cAJhPHKf9tpA185huNeo+ySxWXaYCoQ6QhEuYiEV8J0fgweeMC0C+IuWKfHdCjOar825nRUsIWwsM6/EhGAsO2OMUsUHvwV//6Cxu92ROp6HtbApEVk30ni+jALCxTDGddufDPedXaQn7hl27Vjw6umDBPVC6Saq1xF3t7N3FE/PeWoLYqqlUlMrlKmVf0PSTIxLnRjy1/vCw+8+0FrdrerRW8+kFjHmlDtbHPIvwarpGyAZAELZIAvLWW568lzqKn9t5qEuHwW3zs//r0QD2yB8FYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199015)(38070700005)(122000001)(91956017)(86362001)(38100700002)(8936002)(2906002)(71200400001)(83380400001)(316002)(66946007)(41300700001)(5660300002)(44832011)(64756008)(1076003)(66446008)(6666004)(4326008)(6506007)(107886003)(186003)(2616005)(6512007)(66476007)(478600001)(8676002)(26005)(76116006)(66556008)(110136005)(6486002)(54906003)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/vXXz5daDckz7wAmzg1cYqWMtd/nDp+sXoyrRbXCss5Cbd7dxLS+UZEqF3?=
 =?iso-8859-1?Q?ndV5Ei09Z6nT22Sb98sh+fmexKdQNe8JKeVlcKYfNaUuEaJtYlN0CuJYPH?=
 =?iso-8859-1?Q?WNqADIbOHPH0NLTbOKPRzH/HAZ9sJ2iCnC0VP261jhowRBfTi+GHdRQF/9?=
 =?iso-8859-1?Q?l5kc1HzYYrCL5gLnkePEMLpNHAwkmZIhFQoxYiuxNmqMp22xNcAtOe/0DG?=
 =?iso-8859-1?Q?LAunjYVZ3KQKEQCSjuCmdpbZHYliiC/9NfkV0r8uIbJmSr+YqiY1S3vvp4?=
 =?iso-8859-1?Q?WHZrnbpo75YLZP1mnhSm+hr3P2iLTIy68a58tF6/DuXtHKo8visrSqY8YH?=
 =?iso-8859-1?Q?EX/ktTph0K5FRLlj6MsVuwgvE8/OlXiJr5sCP3BA7ER7GOcSQmJL+5P97/?=
 =?iso-8859-1?Q?vff6i+WELiC9ObJei+YuC3KswfgSQiNXCyegX9AU41m66j7BB8+HBP1e3n?=
 =?iso-8859-1?Q?sN4h9lezYn3QO7mxA1Q/5iNw0HYjat+0/GfYmU4yJwaGzKUkZkNVUNgOKE?=
 =?iso-8859-1?Q?UiFf5+MV4k9dJJVaOQx33mqR/qx4VQGJt3ajWwETm0MC8rXBgw/JtrjQ46?=
 =?iso-8859-1?Q?Hl9/764mWNIYs9GuIN3oykZr1Mo+urmpEw3vZlmG4n+uz45PsbHqPnNlvb?=
 =?iso-8859-1?Q?lPrWHOBc9A1W3QWn1eRcEJr/CWPzESFNfmD7f87DXeXf4vfqxX5HA32onS?=
 =?iso-8859-1?Q?IufZwGWp4qgfc7rydR1Id88pEYFwB57oOTMJyeh4O9/XUXpc66AYKImj4e?=
 =?iso-8859-1?Q?Vjpho1nEeaz2KdSzmRe95AgE5qXQMMkkO8DC6ggp27U6u/bL/vazNiKYW/?=
 =?iso-8859-1?Q?5TTzAN6cnXGXYd06qYBD6bZrwzu36SmfLH3/B3XfFBIYWUPDJEfYe2jrlK?=
 =?iso-8859-1?Q?DS4DA5z4tbMZSbrvc+eldHn3yMh8bZwg57f+eJEYyM0HrNeY5LNbyNdqkB?=
 =?iso-8859-1?Q?Z1PBGP1wtRRqRdwnlq+wVISpSBHmZsj6QLX++apxzWr1aW0UuX883/akPz?=
 =?iso-8859-1?Q?LIBimfBf4RxCLTU7LZb6eDWeT0M+C09HxPaKeIbNMdiuWBdZ9eu5gy3x2a?=
 =?iso-8859-1?Q?DdNsipJDqv15G1c9XtgFH8jM996O3kwxb00sWz8EzhBCAJ2L+cWQykadU8?=
 =?iso-8859-1?Q?AewzNhIn+RODVw9szq19ZkpRIUHG9P0kEqyx17RlXzIjNUB8EohPskhdfV?=
 =?iso-8859-1?Q?jxDAAbq0sUNjK+IQYZ8rx/QsIrT/JglGSlSYvO+qf9TyF3QnSGsgqfeXK1?=
 =?iso-8859-1?Q?dvKYDraZIdy4w8Ri90k8pvhQJbQmD0LFegdDqKVQgyPsQ7I5DItaRMAVe4?=
 =?iso-8859-1?Q?i3T2uUj+7Yp1i1Bh9x1GvQt3raAJ7+wkCNy4/i/sP4f+/tiyvCfI0/tShD?=
 =?iso-8859-1?Q?EO38EdLujYW3ftEX/Cg8tVz+ieCuS7YYPhMC7cHoVgSoYMitGfPDul2Qhl?=
 =?iso-8859-1?Q?v0xac+NS4L5A/pBg6gUl8Do1tNS1iHMN5XYqM9J2bVwtpNt5m6J5o3Vxjh?=
 =?iso-8859-1?Q?uPPC6vedA9qDbBSoRHFSHImoh3ls9kP3SMWOIiIiFxdsZbgTtENVo7J7fP?=
 =?iso-8859-1?Q?zbKXeztw2qdFuUhtXJggxxBHvake7o3SncqaAsWa5IK7ZWwxJGc6z1gKyF?=
 =?iso-8859-1?Q?z1Vf43egtE3sALQqM+Ji2rAzIOMKIdutdY5zlFL3DRiuKWFSi8NZf7Jg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3kZ+5gScm+6LdqISl8hQr1jU5msQgKSJ5akY9muPvpbNIi+V+gUAgiRmnBYYx2mUUyJ0DEtkZisfjCh1HlvYGTpBkECsRYcHPAE8y7yHWpFv3q56MQL9iSzUj6icHTPdvKBdYf3oTaPFRlsbGJ1h8/sLmZHBTDX/qF7mbDOf6IQrxl74JlF9DcmtTeJgxbH0LBQk09YUHbH4Ypf7PCEEr2eqlPPby1TpR8tJsXODrm18yzoQGxtgdL4VARdQ6NU5lCDPkhPIdTn+DYH3BXl/Izckl/AMjcWTK6gMrhrlAeF4TRJG4H5cT0/jWl9FwP2zjyUbZWItxnnqSGGKI6O4Ic8xyvCna5p1nhiReSx663hCzHjbsbn/MPjeV7PsAQobN156+1Dd6+4Un5W6d+UHfol+1FzWTuSegDGX81NzIyoYPx2wAVebCrNmw2uzHR87AQFcU1Hwc/1Dg47TkyCHgvYqF+PT8nD4d+CZ4eiEnyljPhclaGY9XQD5AHjNoyGWxsWu8OfngwPqTqyKcxYsBLXiZ5MiPdMl/PrHGS2CrUOFmmSfFGWYMsWAg+fAhpMD+5lPEFa5FHkH240VCml4711Nf7uNgzmBwofv9SnBEyXlCkBJgs347jwydafGps+U/VD9Utp4+oNXyVRyDA/unVOidghGITUjAxjeW7vWyCgFaUgk3VtXZnxmPI3nVvdfGGUBa83EFWTE8mwk0yy6DkOGMSZ5v4iZDUu6vTgZWF4FMz3WvJOAFDZrzbpBtUriGGyF/LU15GhP5GSAC+Mr6R4aWmQdzvCChYfJqjykDCEv4mI/qRpFr+ca520VryLlYBZs3p85zK7Ae7pBG9BkXoOrQyUiwDpAra9EBKhgxaLSKSNSAk1iZr99E5GTajPEUzp3tqAA+JAfS/R3eIP3uA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca5c958-4b99-420f-aa10-08daef514723
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:15:56.3288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o6GlqtbU5Y1MY1Chg2B9wTG5wnupslSsSPpUu6dywm6Epw2iEBV+T0YgA7jbrLFCx1cCkjTWFf07KUOJZMmZ/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6075
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050152
X-Proofpoint-GUID: xUoHY5Pjh4Ejuxl70ssiUGgNwBIjm4n2
X-Proofpoint-ORIG-GUID: xUoHY5Pjh4Ejuxl70ssiUGgNwBIjm4n2
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
index bd2fcc4d454e..1c6a6b319a49 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1786,8 +1786,8 @@ long ksys_shmdt(char __user *shmaddr)
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
@@ -1810,10 +1810,9 @@ long ksys_shmdt(char __user *shmaddr)
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
