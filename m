Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4FB65F433
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbjAETQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234806AbjAETQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:16:15 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F81D2E0
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:16:13 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305ITc6K025555;
        Thu, 5 Jan 2023 19:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=FcupecLEwSLM7aTT/VbMXN4UiLJUyoURHuCIxtP5yW4=;
 b=qivSy8ooQPD2cNSfWlmmC8YTqkIFogZSmaJnx9avGaYiUcxfXd/QRDRJGFUbP7kdgDtt
 d66/epnbnQ3PuNXuxPY6Eatk/5GVH6KyM310Pimf1CTZJlVIqBTwc3i0OssjL2TI1AQi
 hiGSEo4YStjNJ6h9gUCx2BcTDMNKP9+31YviSA7/TbTUhFUC+INrCHa1gSRREeF10hL6
 jTWeJ3/hW2OTU8Ni8k+NpWIbzKjlSTKuyz0bzcDadT+6vPlS28fAsxfgTrDzzcJmBsqn
 ORoB+n1CchhDoJZiYaDGxHabax1bKImmyxZVusRt9OyV21eOHLUF4OQvqFPrQm6ZQ3Pn yw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtdmtsku8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:00 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305Hvlpg023372;
        Thu, 5 Jan 2023 19:16:00 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwept6m1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lf3daRhX+2HR9cq8xAm3bLNHw2rOTNDzMusejsHsl9JecXmcg8oP6Ado+wpEdI/BaZ+D61Q/aonfm0Eow/4by9x5GrsUI0zABar41bHs4DxY9NpngPX7qMFITFwiAVpo8EZjPVT7yqu2AVscrIui2iAO90Ob6s14fTCHvNnSODAUmdf8lcm+ZD4s+QmNH8RKA25m/fcLVV2hHxnrvNjbJw9BzdsYG42EGA9QkY7c6IFPrTL4aWA5cHkzzDRKSsS0P+KJMI8bpTYhWzKUDCYJAqJ2KH5SiUqGyVvFi/Ewzc241HBwJoPwnTUXWEbT4bTVJhNq6+8IUnJLAaUdVEXagw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcupecLEwSLM7aTT/VbMXN4UiLJUyoURHuCIxtP5yW4=;
 b=E8BMsJqpo8KJopy1npjd7ZFVAaW0Vl/rxAxdfhkKQZOSHJbMbKxJps/rMWCj6DAOMh7vFCNPHf9k6JUSdQxc6v9YXbC5fZiIEfSyeal943Pw6sogTRdt4Dz6DFbNBvinymteJaUQqceTlNFWUBKhE3tO4UN6q+TXq6THYj0xJ/fzMoj7dBfzD1Kcf/abCo10I0TidZg4lYMB9Zr/58RuQnY3cWe62v0Dv63RhN0bN0bp3Hh/a7/pHr2up24+d5DJR4Ca52EB6RKG6GOB2oSv9Yu/33jWKmi04pknnanuNNeYQ+iw/PxvOLULFOEns6W0pHuSduxiHffzagcl/abQ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcupecLEwSLM7aTT/VbMXN4UiLJUyoURHuCIxtP5yW4=;
 b=CvrxNAWx7LIZd+f9wX1u2k1BKt6+rKhWMNOuukh9DjcHUmBvDFFSfaFpg4l5FhcdWtqpvIA/ziOmBc3e6vC9NPDPLj13d7IF4sJAST135kEEvGjbgOy1n3E+q7sXhLAJWgM2CTIrBAHMTWMemAw9lll4HSpqnpQzMXYTMPi8hGY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6075.namprd10.prod.outlook.com (2603:10b6:208:3ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:15:57 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:15:56 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 10/44] mmap: Change do_mas_munmap and
 do_mas_aligned_munmap() to use vma iterator
Thread-Topic: [PATCH v2 10/44] mmap: Change do_mas_munmap and
 do_mas_aligned_munmap() to use vma iterator
Thread-Index: AQHZIToisBO9Z9ubPkeL2T+WGrJSTQ==
Date:   Thu, 5 Jan 2023 19:15:55 +0000
Message-ID: <20230105191517.3099082-11-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|IA1PR10MB6075:EE_
x-ms-office365-filtering-correlation-id: 8d1f0bae-1bd1-473c-25ab-08daef514593
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E0Tre6+b0Mv/zQ7jYPDan0XEJt76iiXXcLyKDa4q9B9R2bdGnRAqIWIakspK6Ug+cN8u/ammhK2GT2vZCH/vHSVZ2u2vaC5huW54/dFMVNQ48aQUzw42UK7HOOlrsPaNA2t8uTcD1356IeLQ15rNG2UNqwBpgZrx4fMYydqCYv5oJinEilQu4/dSjsG9aRn66tWvbJAro2ZPtlSCxZVqlTSyX/ZAH9+AmBjSWeI4XU58UUnSpuR2hylSCsO5H+fDw4ht09fW+QGdlL4WUSX0taBT4MXbApvpdNkkkrZ5rJWCh/+oVxonTC3ddjeGN+3rv9EZwA7CyvZzRaioPVfKKycayKZ5Q9V6JrXtlF7KxDT4ObSkD0IQ3fE9ZeOZq8fCiJ4bMVSs7/YC3cW226jYTfK0RIKaYKIrTqrOPXFZkcvSPxvSlpRLN9KVbunmoB7o4lsij0oBe5rOvlktyHFwNlr8xp3WcYnPpr/rCnJnrdOSRictfYzsT/K/gos/BpeyWfONR9UQn0GyZeb+visD4/76dCXIg9AHjQB67GmK1bBGI8gMh9bqeCufA1KqwD6LKsAhvleyBzkH9Blh8K1i4qV+H5qgE9OcOXCCxwfqqbA/76PESMUCz+Tt/FxKEKWbHe6lbDPmx6B/1nKF/egbhoIijOsQsUf8jm7Rov9BHfbjIYPMEteN3BJoLKQQwKyVz0XhidJtt7zfPR3cj0nn3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199015)(38070700005)(122000001)(91956017)(86362001)(38100700002)(8936002)(2906002)(71200400001)(83380400001)(316002)(66946007)(41300700001)(5660300002)(44832011)(30864003)(64756008)(1076003)(66446008)(4326008)(6506007)(107886003)(186003)(2616005)(6512007)(66476007)(478600001)(8676002)(26005)(76116006)(66556008)(110136005)(6486002)(66899015)(54906003)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WoAkZAkBF/IRg3y988YE6sKE8PRbliq/ejHG7WPQLChFM/JmTGeXYWUfiq?=
 =?iso-8859-1?Q?OuUVwan2LM2I8nhqqaAfzXqh/N1G6+LAdFXa9keOYneMJyORGvU7YuMIB8?=
 =?iso-8859-1?Q?M69nzYBFlxXr90fmdklAkzTkEmPHn2PeeJBkd8wR9RFgI/D/0aPaXe2HrR?=
 =?iso-8859-1?Q?npnOTrdaGRfCXccxWuvFwccZnvHCSIGcgzwMOXpPpta2MLL95kePd/9ajg?=
 =?iso-8859-1?Q?LEUZmgpWkxHL8dgCH1JGsd7p5KoTnELk7EruxUc8PEggmXpqst/ndeQMhG?=
 =?iso-8859-1?Q?gh+OytjeE+EkALue3+iMoudKW9VJjgTjvHXTq9z88Cfg85O4pAI3vp29mI?=
 =?iso-8859-1?Q?yARbs+yYZjYAC+uF+rROPqfMNEqUIgBNlwSqOCBuCR+/kq77nwbeDclcSZ?=
 =?iso-8859-1?Q?EGvpS4XAlXyc2uM4atrDgRVlVplkbCgDc9y7YcfdB7c4jOdXYzY/pIdWjs?=
 =?iso-8859-1?Q?l+k6KMUopm7xwEsNywOYJTrh3Coas7i6pwTpxgr2ADjMNj/IvW57rwLBD+?=
 =?iso-8859-1?Q?OII/GnGS5l4S21lGUrFfsKuLCOn+Z1Qc8CMObvWfZxAeeMuWSgNCDCDAUW?=
 =?iso-8859-1?Q?OBodriYtUUb02E5K8ld2GcuXQQVSqdiF1Wt7n0SucsHhz9WLaetfdWVUPi?=
 =?iso-8859-1?Q?PwKfRHcCrL3OMP5LzjQO2/4GizLQL2PlvJQw3/pR9f+KTivaLtf6jpXLGi?=
 =?iso-8859-1?Q?klKeutlEC3oSCBzrZy/B19aZUCiiwolW5INSxXmB4PcqJRQ8vwwHtvRigb?=
 =?iso-8859-1?Q?FW/exvEQY02PKQT9klWNFaFBnMb4jFhSZu+0563McJ2+Of7F8H8WqbruQt?=
 =?iso-8859-1?Q?NwSsP7anEqeIMammMyhz0lRU1Zca/Srp3Hy6+FfFVX6k9lFdf5eDTgZ0MG?=
 =?iso-8859-1?Q?alsTFa2LnCVBGKaOPtjl3nby9iKADawZxMx2cF94f4r+FFjyvOV6wJk042?=
 =?iso-8859-1?Q?WBh4/3zp6ZLXwmX5e64dkm+fro3sCHLUbqzf7NQG9L5FXYkfk4hrZwMbGD?=
 =?iso-8859-1?Q?utFAqtyC91cZi9wbjMAzNllZkxnX40DUarb8+Vidf2pIG26RONiovBhCZ4?=
 =?iso-8859-1?Q?nVVpbbLCi5rHvNkPfrL4xNuEiHM5C+1n69c/VNe+nktlm3DE9ANNOXy8n6?=
 =?iso-8859-1?Q?go1Lq771cR8Z1tLvwQQC+En/5/z2NXn0AqsKODIcl98NRA8cc02QK6+Ngi?=
 =?iso-8859-1?Q?S5hPe8i8cCUlEMCK3AginT5WTaDxn9PSPkwgaSB3MnmIUctCbDRHAWuish?=
 =?iso-8859-1?Q?jsz0EvqIVC8Dr/8fAk9urI1okFrDhU4SIQQHX61NNBybRcRteqGIcq/b8A?=
 =?iso-8859-1?Q?V3VSjHOa1UngK9eMoo3jR218lce/p2rjGVwHQQxf/thYBvEQ04AOxHrLuq?=
 =?iso-8859-1?Q?rEtQOtIHnx6ncXrdqhpZsgWIe/EcrR1hv4Z6CLrMAcvar3+0hj5Pn8rj92?=
 =?iso-8859-1?Q?zBA+xepSWSpV2Gd8p0i4TS1GuubbAO1YpKi5Dc/7D9hAobuC9yIaX9OGmt?=
 =?iso-8859-1?Q?Z+UFHtvKJaxk1O1aXE+kOwgDqyjkSF0N2F2juHquC+GSOLEhssahYVF6zb?=
 =?iso-8859-1?Q?o5SpyMUsJiizW2ly7ONuxWDqL2mITyG7Bdw4JGwDv3TzIDloxTommZ4+vT?=
 =?iso-8859-1?Q?l8CV5FxlOPo0FqqDqqdO9g/L9OSWobKDWkLu1Ine85ZJVfrrdLoaMDZQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MgJGf6/+TxN7K7xtcwnYexrJ3AShkIR/vemgkgok5VeKtcmXL+wjYhoQYoo5au3ZVA4VmvdPjNosZwgla4TMK9kq8qOWWg+wWYFKLyVRmp84aIDPL/PoUHtGes6D5HrT08XM2M9b58Op2P3xFEQeK1wLQsXrBJHZvzCJO+7NrcrzVhCkrKecUi2+wo6Erm3cQMceL23oGZwh72JqBhcWER8fKx6yciTn4slE32HlduJgiCL7DWBk9iset28ZO9kNEronfQA693W+07LxD8UKMhQNLE4RtxArjvKzwhngjfr/eMzZLEILWtYr1CtNsR+9N22xSY/Cqy40Gc2r2QIkKi0/JSUL8AUUZ18ik9p+/nk7z5ix1myfR5sQZlKEIVHe07LWkwdxmv9B9uLeomTcs06Dqn2hioKhewM5jw+rgJ0WFFkVoNhZcrFiHVU6rWNEaNBb7NbZchKmzanwvooo+yrRbNplQZZ4rFUfcBg8GxJ1VH/C5HbmfSLhlUqmL6UFOLxQli6ElbsgEtfB/QPR6NP4wnPjSMxTWuYWlQJIjGe2ftDfuREnvYun1aR1qrjNAmIyScIvVUVne4jPTkL2khi9ndT5uJ6ipVJcqXb1hRNSlE/GgS9lU4KL5vRPEilHTbRcFjeBL6IqsNRpo8pu0QgSvbnudAFIdGFEbmOvxx7TOn4OAR7mcp+zK6mf7JDy5GrKxiIdtXpEQ2n8jK1FKa6dP2RYiauP7n9yliGCur/e7wmQlVrTVsaNZ3mFUkhhHZZKeXJ1bNMCUo4FeqdOo39sFZO8PTJ0vmPU/E0+Nczsk0KlKV5GydvKD+cBD4iEE63MYqJ47Yd1PJB4/nn610mQ3/xPWqNyHX+N/eYZUH2ScShRK1TIry2/8zdPfDVnQzMZlybGYYu/g6tOsogZKA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1f0bae-1bd1-473c-25ab-08daef514593
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:15:55.4695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AUcB0kfawKtuLB5HTGm9ZredU+KoIJCsrWuSCubYBC843GjEHhhTYFvLyUE9611Kh95yy1czm0wgwC8uVLNTwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6075
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050152
X-Proofpoint-GUID: hQam4KnA6P8PvNEpnv-D4b7Bjxpc-wzh
X-Proofpoint-ORIG-GUID: hQam4KnA6P8PvNEpnv-D4b7Bjxpc-wzh
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

Start passing the vma iterator through the mm code.  This will allow for
reuse of the state and cleaner invalidation if necessary.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/mm.h |  2 +-
 mm/mmap.c          | 77 +++++++++++++++++++++-------------------------
 mm/mremap.c        |  6 ++--
 3 files changed, 39 insertions(+), 46 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f4b964f96db1..126f94b6f434 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2896,7 +2896,7 @@ extern unsigned long mmap_region(struct file *file, u=
nsigned long addr,
 extern unsigned long do_mmap(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot, unsigned long flags,
 	unsigned long pgoff, unsigned long *populate, struct list_head *uf);
-extern int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
+extern int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 			 unsigned long start, size_t len, struct list_head *uf,
 			 bool downgrade);
 extern int do_munmap(struct mm_struct *, unsigned long, size_t,
diff --git a/mm/mmap.c b/mm/mmap.c
index 238b10ca9f9d..41767c585120 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2360,8 +2360,8 @@ static inline int munmap_sidetree(struct vm_area_stru=
ct *vma,
 }
=20
 /*
- * do_mas_align_munmap() - munmap the aligned region from @start to @end.
- * @mas: The maple_state, ideally set up to alter the correct tree locatio=
n.
+ * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
+ * @vmi: The vma iterator
  * @vma: The starting vm_area_struct
  * @mm: The mm_struct
  * @start: The aligned start address to munmap.
@@ -2372,7 +2372,7 @@ static inline int munmap_sidetree(struct vm_area_stru=
ct *vma,
  * If @downgrade is true, check return code for potential release of the l=
ock.
  */
 static int
-do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
 		    unsigned long end, struct list_head *uf, bool downgrade)
 {
@@ -2384,7 +2384,6 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 	mt_init_flags(&mt_detach, MT_FLAGS_LOCK_EXTERN);
 	mt_set_external_lock(&mt_detach, &mm->mmap_lock);
=20
-	mas->last =3D end - 1;
 	/*
 	 * If we need to split any vma, do it now to save pain later.
 	 *
@@ -2404,27 +2403,23 @@ do_mas_align_munmap(struct ma_state *mas, struct vm=
_area_struct *vma,
 		if (end < vma->vm_end && mm->map_count >=3D sysctl_max_map_count)
 			goto map_count_exceeded;
=20
-		/*
-		 * mas_pause() is not needed since mas->index needs to be set
-		 * differently than vma->vm_end anyways.
-		 */
 		error =3D __split_vma(mm, vma, start, 0);
 		if (error)
 			goto start_split_failed;
=20
-		mas_set(mas, start);
-		vma =3D mas_walk(mas);
+		vma_iter_set(vmi, start);
+		vma =3D vma_find(vmi, end);
 	}
=20
-	prev =3D mas_prev(mas, 0);
+	prev =3D vma_prev(vmi);
 	if (unlikely((!prev)))
-		mas_set(mas, start);
+		vma_iter_set(vmi, start);
=20
 	/*
 	 * Detach a range of VMAs from the mm. Using next as a temp variable as
 	 * it is always overwritten.
 	 */
-	mas_for_each(mas, next, end - 1) {
+	for_each_vma_range(*vmi, next, end) {
 		/* Does it split the end? */
 		if (next->vm_end > end) {
 			struct vm_area_struct *split;
@@ -2433,8 +2428,8 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 			if (error)
 				goto end_split_failed;
=20
-			mas_set(mas, end);
-			split =3D mas_prev(mas, 0);
+			vma_iter_set(vmi, end);
+			split =3D vma_prev(vmi);
 			error =3D munmap_sidetree(split, &mas_detach);
 			if (error)
 				goto munmap_sidetree_failed;
@@ -2456,7 +2451,7 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 	}
=20
 	if (!next)
-		next =3D mas_next(mas, ULONG_MAX);
+		next =3D vma_next(vmi);
=20
 	if (unlikely(uf)) {
 		/*
@@ -2481,10 +2476,10 @@ do_mas_align_munmap(struct ma_state *mas, struct vm=
_area_struct *vma,
 		struct vm_area_struct *vma_mas, *vma_test;
 		int test_count =3D 0;
=20
-		mas_set_range(mas, start, end - 1);
+		vma_iter_set(vmi, start);
 		rcu_read_lock();
 		vma_test =3D mas_find(&test, end - 1);
-		mas_for_each(mas, vma_mas, end - 1) {
+		for_each_vma_range(*vmi, vma_mas, end) {
 			BUG_ON(vma_mas !=3D vma_test);
 			test_count++;
 			vma_test =3D mas_next(&test, end - 1);
@@ -2494,8 +2489,8 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 	}
 #endif
 	/* Point of no return */
-	mas_set_range(mas, start, end - 1);
-	if (mas_store_gfp(mas, NULL, GFP_KERNEL))
+	vma_iter_set(vmi, start);
+	if (vma_iter_clear_gfp(vmi, start, end, GFP_KERNEL))
 		return -ENOMEM;
=20
 	mm->map_count -=3D count;
@@ -2533,8 +2528,8 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 }
=20
 /*
- * do_mas_munmap() - munmap a given range.
- * @mas: The maple state
+ * do_vmi_munmap() - munmap a given range.
+ * @vmi: The vma iterator
  * @mm: The mm_struct
  * @start: The start address to munmap
  * @len: The length of the range to munmap
@@ -2548,7 +2543,7 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
  *
  * Returns: -EINVAL on failure, 1 on success and unlock, 0 otherwise.
  */
-int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
+int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 		  unsigned long start, size_t len, struct list_head *uf,
 		  bool downgrade)
 {
@@ -2566,11 +2561,11 @@ int do_mas_munmap(struct ma_state *mas, struct mm_s=
truct *mm,
 	arch_unmap(mm, start, end);
=20
 	/* Find the first overlapping VMA */
-	vma =3D mas_find(mas, end - 1);
+	vma =3D vma_find(vmi, end);
 	if (!vma)
 		return 0;
=20
-	return do_mas_align_munmap(mas, vma, mm, start, end, uf, downgrade);
+	return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, downgrade);
 }
=20
 /* do_munmap() - Wrapper function for non-maple tree aware do_munmap() cal=
ls.
@@ -2582,9 +2577,9 @@ int do_mas_munmap(struct ma_state *mas, struct mm_str=
uct *mm,
 int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	      struct list_head *uf)
 {
-	MA_STATE(mas, &mm->mm_mt, start, start);
+	VMA_ITERATOR(vmi, mm, start);
=20
-	return do_mas_munmap(&mas, mm, start, len, uf, false);
+	return do_vmi_munmap(&vmi, mm, start, len, uf, false);
 }
=20
 unsigned long mmap_region(struct file *file, unsigned long addr,
@@ -2600,7 +2595,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	unsigned long merge_start =3D addr, merge_end =3D end;
 	pgoff_t vm_pgoff;
 	int error;
-	MA_STATE(mas, &mm->mm_mt, addr, end - 1);
+	VMA_ITERATOR(vmi, mm, addr);
=20
 	/* Check against address space limit. */
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
@@ -2618,7 +2613,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	}
=20
 	/* Unmap any existing mapping in the area */
-	if (do_mas_munmap(&mas, mm, addr, len, uf, false))
+	if (do_vmi_munmap(&vmi, mm, addr, len, uf, false))
 		return -ENOMEM;
=20
 	/*
@@ -2631,8 +2626,8 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 		vm_flags |=3D VM_ACCOUNT;
 	}
=20
-	next =3D mas_next(&mas, ULONG_MAX);
-	prev =3D mas_prev(&mas, 0);
+	next =3D vma_next(&vmi);
+	prev =3D vma_prev(&vmi);
 	if (vm_flags & VM_SPECIAL)
 		goto cannot_expand;
=20
@@ -2660,13 +2655,11 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
=20
 	/* Actually expand, if possible */
 	if (vma &&
-	    !vma_expand(&mas, vma, merge_start, merge_end, vm_pgoff, next)) {
+	    !vma_expand(&vmi.mas, vma, merge_start, merge_end, vm_pgoff, next)) {
 		khugepaged_enter_vma(vma, vm_flags);
 		goto expanded;
 	}
=20
-	mas.index =3D addr;
-	mas.last =3D end - 1;
 cannot_expand:
 	/*
 	 * Determine the object being mapped and call the appropriate
@@ -2705,7 +2698,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 			error =3D -EINVAL;
 			goto close_and_free_vma;
 		}
-		mas_reset(&mas);
+		vma_iter_set(&vmi, addr);
=20
 		/*
 		 * If vm_flags changed after call_mmap(), we should try merge
@@ -2751,7 +2744,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 			goto free_vma;
 	}
=20
-	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
+	if (vma_iter_prealloc(&vmi, vma)) {
 		error =3D -ENOMEM;
 		if (file)
 			goto close_and_free_vma;
@@ -2764,7 +2757,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	if (vma->vm_file)
 		i_mmap_lock_write(vma->vm_file->f_mapping);
=20
-	vma_mas_store(vma, &mas);
+	vma_iter_store(&vmi, vma);
 	mm->map_count++;
 	if (vma->vm_file) {
 		if (vma->vm_flags & VM_SHARED)
@@ -2825,7 +2818,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	vma->vm_file =3D NULL;
=20
 	/* Undo any partial mapping done by a device driver. */
-	unmap_region(mm, mas.tree, vma, prev, next, vma->vm_start, vma->vm_end);
+	unmap_region(mm, &mm->mm_mt, vma, prev, next, vma->vm_start, vma->vm_end)=
;
 	if (file && (vm_flags & VM_SHARED))
 		mapping_unmap_writable(file->f_mapping);
 free_vma:
@@ -2842,12 +2835,12 @@ static int __vm_munmap(unsigned long start, size_t =
len, bool downgrade)
 	int ret;
 	struct mm_struct *mm =3D current->mm;
 	LIST_HEAD(uf);
-	MA_STATE(mas, &mm->mm_mt, start, start);
+	VMA_ITERATOR(vmi, mm, start);
=20
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
=20
-	ret =3D do_mas_munmap(&mas, mm, start, len, &uf, downgrade);
+	ret =3D do_vmi_munmap(&vmi, mm, start, len, &uf, downgrade);
 	/*
 	 * Returning 1 indicates mmap_lock is downgraded.
 	 * But 1 is not legal return value of vm_munmap() and munmap(), reset
@@ -2979,7 +2972,7 @@ static int do_brk_munmap(struct vma_iterator *vmi, st=
ruct vm_area_struct *vma,
 	int ret;
=20
 	arch_unmap(mm, newbrk, oldbrk);
-	ret =3D do_mas_align_munmap(&vmi->mas, vma, mm, newbrk, oldbrk, uf, true)=
;
+	ret =3D do_vmi_align_munmap(vmi, vma, mm, newbrk, oldbrk, uf, true);
 	validate_mm_mt(mm);
 	return ret;
 }
@@ -3103,7 +3096,7 @@ int vm_brk_flags(unsigned long addr, unsigned long re=
quest, unsigned long flags)
 	if (ret)
 		goto limits_failed;
=20
-	ret =3D do_mas_munmap(&vmi.mas, mm, addr, len, &uf, 0);
+	ret =3D do_vmi_munmap(&vmi, mm, addr, len, &uf, 0);
 	if (ret)
 		goto munmap_failed;
=20
diff --git a/mm/mremap.c b/mm/mremap.c
index fe587c5d6591..94d2590f0871 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -978,14 +978,14 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned=
 long, old_len,
 	/*
 	 * Always allow a shrinking remap: that just unmaps
 	 * the unnecessary pages..
-	 * do_mas_munmap does all the needed commit accounting, and
+	 * do_vmi_munmap does all the needed commit accounting, and
 	 * downgrades mmap_lock to read if so directed.
 	 */
 	if (old_len >=3D new_len) {
 		int retval;
-		MA_STATE(mas, &mm->mm_mt, addr + new_len, addr + new_len);
+		VMA_ITERATOR(vmi, mm, addr + new_len);
=20
-		retval =3D do_mas_munmap(&mas, mm, addr + new_len,
+		retval =3D do_vmi_munmap(&vmi, mm, addr + new_len,
 				       old_len - new_len, &uf_unmap, true);
 		/* Returning 1 indicates mmap_lock is downgraded to read. */
 		if (retval =3D=3D 1) {
--=20
2.35.1
