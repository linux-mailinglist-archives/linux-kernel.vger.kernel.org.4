Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E13B63C58C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236303AbiK2Qry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236317AbiK2QrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:47:08 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25B55FB99
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:45:16 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGOgx9005680;
        Tue, 29 Nov 2022 16:45:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=0EzQlHTr4IVoG9FN3tDYFD5FcrsBLTtgf060eSOj39A=;
 b=STMKwKtuRH257NBD78u2yhCjTs9/lVTJ5ntVCxaSbdhJVOPh4osoWp0lmT7LTWej737X
 2FdgTR2sQvTdX9fqGAT6htb23YDZ48+4bhqPv2N2oGCxGd7N9yOhOuNjNdISpaHwC/Lj
 Co7hjH7S7CFbC/b8EM7ntf9hhcAJKpEZWkT84eVbLBQnV1WInIQx8Lm/JX0JlMOaookH
 dypfPK8V3Cxwy2619fiQDqqQqyN0p4YJ2rbmOXAdbg6YeW+huUYGT4mMnWpIWUR+8VKo
 8GYfNjyFL6JqSPXdzQFkd/RaohIYsXYi6NbSpBIfV0MWvC2Q9Sd9upQGySPjFsr1LjG9 gw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m39k2qfcp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:45:11 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATFkaU1026698;
        Tue, 29 Nov 2022 16:45:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m3c1vkkp0-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:45:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5pqdQjsbCF7KV6tXuTM82FH63Oqfrf3l6p4c/HHSEeLnEFbz9MY9GGKdunSePRcqWTAUseW3KgA7iNRYZW3Nh+m4eZQbamU2Nd8wXmmclp+FCEeKwx37BikFIGde37lM285Rr36A36rdUAdNbSzc3MfWwbSFjirS76MLu67C/DsnWl/bz0hzTmmJ/tmdQ8ANT/fAzc3NZsBGIuc5UJ7H+MICs5aq1rffEfBPKGkSruiEFJKsVeKMV//tG6pTNyX3rCC4pcY1G3SZbCp8LCspifeRtquLHmDDONdaGlYMw3iyr9i6izNxB8tTJ9Vr6x7w54l837wQrvVdE68e8UQmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0EzQlHTr4IVoG9FN3tDYFD5FcrsBLTtgf060eSOj39A=;
 b=Er9ReCfsyYeDhO6wpOgNCCDgqJdgTpG9XVgR1fjgmaKpLca2nEDpzxIYeF1OgHqNqVeTe83ZJkmUGneUOneqMCirSQLBN/uJwl9i9EKqDF6s0PIt3ajk6AfFnQ6NBCFBsRToKogQpq4qLjyvKKwv6kceC8ml7cpYLj33FxHaMMJjNHqSJQyZ75yx5KqkJQNUUD/2dOmih9p7RPPhQDScwXiroYVgaua6ZjfA6q+58eGm//zO5gXDUiqLNurofi41LzN8ja8XC9MVi23j4ckB9mKweaIEAKkvuG3mlOg+BEUwDY6Su7xCb+BAZfnsLHjSaipowZbhSE3dhR1PxYzllA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EzQlHTr4IVoG9FN3tDYFD5FcrsBLTtgf060eSOj39A=;
 b=f3kLLOUWtK0tY9WfKHCCu9kquplUI8+7hS0the2hYaDWUJR5NyCKBMDoYe9Tyc57iRrbc0PVvRqBuoG9abRSv7Ik+57eI6NWWiwKaLajqXynAT6oq2377sPZxIPJ1EE6dMbZvPGxDq6x2jVYv7aw99NvpLi+90Db7S/DZ+wjPKk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4792.namprd10.prod.outlook.com (2603:10b6:510:3d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 16:45:08 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:45:08 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 33/43] mm: Change munmap splitting order and move_vma()
Thread-Topic: [PATCH 33/43] mm: Change munmap splitting order and move_vma()
Thread-Index: AQHZBBHcNhY9kx7Ry0WMjLLG086Hbw==
Date:   Tue, 29 Nov 2022 16:44:34 +0000
Message-ID: <20221129164352.3374638-34-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|PH0PR10MB4792:EE_
x-ms-office365-filtering-correlation-id: 83479740-3aef-4673-6632-08dad229134a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HVWO03LlJUbpkqzs48cBh78qtqxsXjkbjdSiI00jds/QJsV6FQBFnTfW2MDQcSS2daWlnypsgXBydN7jw6NXDpN3NRECV1H+5iXe55dY8xTcOfRKAPPlmRqu4lpDNZjnxNS29bWHzK9FpWfKU7naeucseqEvQdCnApd/tiUGDkTg4gvnFUC6ov9fnPAUB7rf5HwPICf1BGXE+wC3r8BM3Icc07SIbFc57p2EUoWUCRwJwtK/BTNXoW5oAVHD1S3ymKL/0cUkFCpnY/dIPGkxdLMMwPwop6CnI55kPA9dElx1gSoN032a/QeFPRch9JyKOlULrc1lKXNr8dxBUh0zAhC4C4n4L+JzHDewm/b4sECaggjfAxQ/v55ow7gg2xRuS7TnniY47ytXtbOcXHC20lqhAhy6i9Zu+RCvN2Ymja7vEjDa36RU62+VhAL2l1E1NMbphRVD4S9QUlRAaaofPud6tt936RDU6rIgeeGj6HakiskT/24CoUC7GD7tdABdgw41rHzZ75edHhVt7LI9tIoks3qdqC/up+8G23J0oq7ihltHcrVfh5Rwtq3syk2tgmij4PEF3Rwgswt1iZcl/6HpQO3s3FXmBEoIfS5cjnq2yyOV79y4Cscb8DXMHgXDMkQX/AvyRWmIjgQnX6tvUn1OSSQYUaAGmqZojb54vdj/bQhLATajB1mMmh0sHhUYP6adPRh0vs79oyHsEo5feA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199015)(38070700005)(2906002)(36756003)(86362001)(6666004)(6486002)(71200400001)(107886003)(478600001)(44832011)(41300700001)(316002)(76116006)(66556008)(66946007)(91956017)(5660300002)(66476007)(26005)(110136005)(66446008)(4326008)(54906003)(8936002)(8676002)(64756008)(6506007)(6512007)(186003)(122000001)(2616005)(38100700002)(1076003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?d7R/pU62y1cc2PkoPDkyO3OEphiDNV+TGf7c3w8LvC3UMbyiQdyj5hAxWu?=
 =?iso-8859-1?Q?iEvsnicbILFrlYgqsNUq3QGz6d7e4Q2JhrbR1DIlyiyS1tICkMBzs6nUkD?=
 =?iso-8859-1?Q?w7dLUh5Dd7aMRg0TV8teDiV+KI3/FEYdOxLMZMIHd+sNxggtKVPBsgTmmE?=
 =?iso-8859-1?Q?guw7DFGUlcq44NKqCYCYddboHVWBO87fne/teuk9OwasnAbxVJh/VOapzq?=
 =?iso-8859-1?Q?C9boXKLeAukIsnzgKuvjHKP/2jHlibzegQUgILZ/h7VJlAzooj6ci3t/Gl?=
 =?iso-8859-1?Q?AxygM8rfQT5cKdybSuv3fuwzd25vzXHr5AvtGwfOemAUnQNH+SmSd0HdsJ?=
 =?iso-8859-1?Q?lhWmcjWOQ6VSu+cBesp45BFMbLiIueDLyWdqkRg+VqfL/AfziBxwH4RMhY?=
 =?iso-8859-1?Q?N7vZbn0yofiP1b2w2SQ4L5R6oaVqB8fa9hUJQrK+jh+1TavwqPHH1zMwAQ?=
 =?iso-8859-1?Q?H6LhP+5ukX24G9pz21rkX8sT8wTusDZnFVqeuonRT05++mdoM1Rydq755G?=
 =?iso-8859-1?Q?vJGhNbWmt+uISKbYZNiMUqVWt29/NAHjwT2S1fVddOxyDcIpEiKpZsfWZ4?=
 =?iso-8859-1?Q?a3x4Mehak8CbuO5iMRbHY3SNfYxHsrf/2H5ZLyAxCU/D7jw8BIjo1G+vTz?=
 =?iso-8859-1?Q?XAcYyqPRb766fkfKbm2WgBrlGZvQWShQ8Cyo2njpRIEDGO+RcgK1nIbD1Q?=
 =?iso-8859-1?Q?lhC781wxS0rq5zJQwBRQzSiJd2m3qb+906/WeGI91SuZ4oC7mfa/rNisab?=
 =?iso-8859-1?Q?bmabU077FEzaF/PbVDiZS/FnnjMWSHo2oIXIwi3P2r0HFi7sI33qady99L?=
 =?iso-8859-1?Q?MutPejAqawHU+oylM8tRyCQG9kiItqmcNP6cbGVRxMEmt8swOju1D/lcy0?=
 =?iso-8859-1?Q?RkxcqyRa+CTVUQW58/RSETFsYtRo4bkSRJJc4RPE9nu9CHil3tRX1AHTLV?=
 =?iso-8859-1?Q?6dc3kWGhFVuHMC3NWgtXbsvHA1MUQK+DHKt0SrSSTfpMKRoQz8HL58rHzm?=
 =?iso-8859-1?Q?pkMepl4T/aUC0DkRmAM/hgONL01UmyCRbkQjsLfsbfk1fvUbodS4krsWtS?=
 =?iso-8859-1?Q?weudIJPHF5IIugBtNTOULDgEPhbIonidMpLkCNICo8/DBlgG8q+f8txFsB?=
 =?iso-8859-1?Q?/GDHiXudC3w0HbqwWmd/YRbUDDPYjWlpxD2X3mgZIcXsfZCltIzHwf48eH?=
 =?iso-8859-1?Q?ItemVwkcohhwut1X+hbcYOGZnmD+bW1M9kApvh1r0lfE6yebXbWJ0pO3Vw?=
 =?iso-8859-1?Q?KAcFEiPCWellsbiVflxE/MDCKFsKPZlRM1jAkP0NAXwF9x4J13flEI+F1l?=
 =?iso-8859-1?Q?ZUDKDvJz50dwUa1aqiiBN9PZ4HtsO3VzAx5bN7gH3osdr8PbqlRgIvjMvD?=
 =?iso-8859-1?Q?T/8LYQroEdpsDEdMH2HmrQ8sSwblpRUJrYWhcUzZ4cXbOvTAm9v6yIncBi?=
 =?iso-8859-1?Q?x2ZwnDoQl8aYTGbewqJSjfbDZMU9UBshInaAErLLwYqUQz5BLS6oCFzK3q?=
 =?iso-8859-1?Q?8HtbxMduuvhFl4zAKY/keSnPQTxfMvy1hnF2Y6BWylmQhj3U0JPnb01Rua?=
 =?iso-8859-1?Q?ELnsBArLnt1BWWw4KF9iLPFvmAiwhEQvq7rqqoSkbKp/prBcOsGRdwhki3?=
 =?iso-8859-1?Q?zWE/pqvBeN7xNbpBfSpQ5DfaRJW7p5L/MmTmAICnEngEYeF0z7shJZmw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CgpK486Dy3tDEr03oHgot1TW2GUfT+/4ec72Ik1dYTjHS5Zh4hw5MbdQehtrDi2j1WvNKdtJEV6uQdQNwBb2+zvV5kCujjVvTjKc59QtOLMu9etzx3+IB88jOGVwU10dwvTw5Gwhz9Mn6Oy9b6gjUzKyVD99+/d7CsDPema1CGfLHeiOEBQ1p8ds4aG6exDT0Lk9ap8XcevVQhiJe65BCA7vIXBWoRLm7nhcKkOFpS+3dj2j3V0y1AibcK26vbvGp9pZOMExF2t8wOYKqqXX1H9gc/yzx/uCx5/60HClCVhpear3DZ4XR5vtwkpy6VE2zGEJdWpgFhDNvplrqOiufnNH1HdOjfuqNIAAFNVq4Sxa3mC8Ll7CA1EUb3au2UsvWIpEyl4vOEqg9jUNsV8bgHQDn5TUlAJ5wz/TTRKaodZpf8AujcwmhDYmaN/HZa85KQWyw0k5/n23GGA/FZlFlr3DPr0w+Ij7waZkEZdn5+idxd6pka8cCip1wzqYA/kq7NuJRALwP30epDWx5FffGpwgXeawO9RB4LPXljI5SAvpsmtbJQfXizfsjtt73uJQ3wq52VyHud77ZnhrCuqQbTrmPeVhsW4BvhCV5YVPlAqqUYGomDfGL8h6nklHm8QcVBlOvofc0OEV2EsrTI5SAG/TnIrGpF3HfRNqPSV/OUkVsfmsso4QljVCyTtUS5H08jeEQoVtfVgskSNNKlKFuPfUH8ud2UOpotZZjHC/xM+E2B45+H4hRDszZ/la4Xj3jc9x9SQINs3m2iJ58iBCxoTbnAt7BxZE48ZkZ068uZPB+CFI3lrsDK/Zkg7NUqD8UcirUK9bVhMSkFMRcIK/Dh0UR/JxTm7u34TN4QtMnnAILIRViIGFrN1J9KemLGWcFIV4V82XC0zJ6jAh+QmD9Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83479740-3aef-4673-6632-08dad229134a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:34.8785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AqD5syVGoyKXgfGufGTCEOq9x1RP9M9r7dSXkHegKbslfRXvnAFBuHbBjl5tv0d7euWAd8QskQSXfsyPtfXDFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4792
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290093
X-Proofpoint-GUID: pBGL-FocDHj82SLMwfFUzZYszK3FKNDH
X-Proofpoint-ORIG-GUID: pBGL-FocDHj82SLMwfFUzZYszK3FKNDH
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

Splitting can be more efficient when the order is not of concern.
Change do_vmi_align_munmap() to reduce walking of the tree during split
operations.

move_vma() must also be altered to remove the dependency of keeping the
original VMA as the active part of the split.  Transition to using vma
iterator to look up the prev and/or next vma after munmap.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c   | 18 ++----------------
 mm/mremap.c | 27 ++++++++++++++++-----------
 2 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index af611f805776..e0e70b9bc391 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2388,21 +2388,9 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct=
 vm_area_struct *vma,
 	for_each_vma_range(*vmi, next, end) {
 		/* Does it split the end? */
 		if (next->vm_end > end) {
-			struct vm_area_struct *split;
-
-			error =3D __split_vma(vmi, next, end, 1);
+			error =3D __split_vma(vmi, next, end, 0);
 			if (error)
 				goto end_split_failed;
-
-			split =3D vma_prev(vmi);
-			error =3D munmap_sidetree(split, &mas_detach);
-			if (error)
-				goto munmap_sidetree_failed;
-
-			count++;
-			if (vma =3D=3D next)
-				vma =3D split;
-			break;
 		}
 		error =3D munmap_sidetree(next, &mas_detach);
 		if (error)
@@ -2415,9 +2403,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct =
vm_area_struct *vma,
 #endif
 	}
=20
-	if (!next)
-		next =3D vma_next(vmi);
-
+	next =3D vma_next(vmi);
 	if (unlikely(uf)) {
 		/*
 		 * If userfaultfd_unmap_prep returns an error the vmas
diff --git a/mm/mremap.c b/mm/mremap.c
index cbafea7fe895..00b39f0121bc 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -580,11 +580,12 @@ static unsigned long move_vma(struct vm_area_struct *=
vma,
 	unsigned long vm_flags =3D vma->vm_flags;
 	unsigned long new_pgoff;
 	unsigned long moved_len;
-	unsigned long excess =3D 0;
+	unsigned long account_start =3D 0;
+	unsigned long account_end =3D 0;
 	unsigned long hiwater_vm;
-	int split =3D 0;
 	int err =3D 0;
 	bool need_rmap_locks;
+	VMA_ITERATOR(vmi, mm, old_addr);
=20
 	/*
 	 * We'd prefer to avoid failure later on in do_munmap:
@@ -662,10 +663,10 @@ static unsigned long move_vma(struct vm_area_struct *=
vma,
 	/* Conceal VM_ACCOUNT so old reservation is not undone */
 	if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP)) {
 		vma->vm_flags &=3D ~VM_ACCOUNT;
-		excess =3D vma->vm_end - vma->vm_start - old_len;
-		if (old_addr > vma->vm_start &&
-		    old_addr + old_len < vma->vm_end)
-			split =3D 1;
+		if (vma->vm_start < old_addr)
+			account_start =3D vma->vm_start;
+		if (vma->vm_end > old_addr + old_len)
+			account_end =3D vma->vm_end;
 	}
=20
 	/*
@@ -700,11 +701,11 @@ static unsigned long move_vma(struct vm_area_struct *=
vma,
 		return new_addr;
 	}
=20
-	if (do_munmap(mm, old_addr, old_len, uf_unmap) < 0) {
+	if (do_vmi_munmap(&vmi, mm, old_addr, old_len, uf_unmap, false) < 0) {
 		/* OOM: unable to split vma, just get accounts right */
 		if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP))
 			vm_acct_memory(old_len >> PAGE_SHIFT);
-		excess =3D 0;
+		account_start =3D account_end =3D 0;
 	}
=20
 	if (vm_flags & VM_LOCKED) {
@@ -715,10 +716,14 @@ static unsigned long move_vma(struct vm_area_struct *=
vma,
 	mm->hiwater_vm =3D hiwater_vm;
=20
 	/* Restore VM_ACCOUNT if one or two pieces of vma left */
-	if (excess) {
+	if (account_start) {
+		vma =3D vma_prev(&vmi);
+		vma->vm_flags |=3D VM_ACCOUNT;
+	}
+
+	if (account_end) {
+		vma =3D vma_next(&vmi);
 		vma->vm_flags |=3D VM_ACCOUNT;
-		if (split)
-			find_vma(mm, vma->vm_end)->vm_flags |=3D VM_ACCOUNT;
 	}
=20
 	return new_addr;
--=20
2.35.1
