Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3ADE642E02
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbiLEQ4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbiLEQzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:55:35 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE3B21824
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 08:53:37 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5FatJg017554;
        Mon, 5 Dec 2022 16:53:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=4Zgm9Mo98iaPcsLKDlu02wgaNfKXYSAn/Ux0GIUUwAg=;
 b=aBmQGLr6tPVOzslSw6/BnAlep+CxuxfFHr/I1X9rbdtBOGn1Itp94WOA6OFKL/6lyIDx
 xk8AhNEr5YHn8sKHvBI53mR51pVwjTRC7rxDyrqVr65GwIjJrteDK4uhO6xIzjqXo6wU
 gzqlU0JkJ3UaJeyBMJIET9Ji/58NI1ZyrMlWAHblBU0ygHvAqYWi+ugN6dj/ARM3QrlM
 qGqHKCUfBq9bMokJ4inRT0ZL2d+PeETk9AY5YfYsVU2xayvmrxvKaayfSSNSp1aNHxSY
 BUD5lSaW+FBRyLzTuArzGqZ+aL3xC23Hw+xa0xH5zdPE0G/eKl3o3KOF0zW70Olfl21t hw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7ycf4j7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 16:53:22 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B5GQuXv018746;
        Mon, 5 Dec 2022 16:53:21 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m8u9y6cgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 16:53:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dx3kBAO9rHqlVklBNtKUy+9AFBrUm63NLr438tJj2xLRdpYLd2JZ3SpVPUiwWMtsRGrWfPzBBwAu57EmI0FnvghUiXrc49FJ407WZVOmfzO4c+PFKzKm4DWTZ7vc507rNsKcR6vxJsjb85bdTAChH4gYy5NM/XOxAALtpyylv4ZIJW4n0+61gcJXGYEWahUcql9kUUApWlJCHyGD81QXXqiCa+9hrNIXFYgrP0IoVVYd/T8WridKWFgEDofIAmxdd159aKGzdCUr1+J3BgTxw+YsR+mlItHyKtvJdGtAiuoMa2wot8v05JrBlVIAcQslXmcnVYcwIwkbhHMBXULsnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Zgm9Mo98iaPcsLKDlu02wgaNfKXYSAn/Ux0GIUUwAg=;
 b=hlJLycFtJfQWD8bl7KoG48hoCyz/wDWdM3iZNWKksADU6Rmx3OAtkjU73FAR8yY8Oe4Ij+E4yTPwyeKEmjNcBDSNkfqE/sUyjDDmOoYWV4LdfxuqztmtU85/9lL9wg2mPNO0obBwyqyxNRAf+jKl0ye+O9kUTl6duSEqGszXDzVpoXs2fwB+UEnaLd1pQLR/NOWLv9eriiNJ805m07GhC0u4mnFanXeZfS4/tyYoLZyuVqxHOS9y4QHrYKxOD/PXVkKfo58yPrNoBO8WKW+CcGvK1nVYkBog78/h2DT4tXD6KRUZXDIPRau0QkF7O1hkUE4fD88LVkQn6nRUY8Fp6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Zgm9Mo98iaPcsLKDlu02wgaNfKXYSAn/Ux0GIUUwAg=;
 b=JHwByRk6kLwiUuPX1yWsUTXGB3xvoUjHnqg3eIpGPYznVCH2kilhu3IDh70fnm71BNltAwHigm71kknaeCHCJpAE3ggRDqufPmgk0BfwCuqOnxtSfF4//IHzRPViuOd7ktFFFFknfJOo5d2i4QylqjDo3GgNuTUPzvlFXNJmpo8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 16:53:19 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5880.013; Mon, 5 Dec 2022
 16:53:19 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Yu Zhao <yuzhao@google.com>, Jason Donenfeld <Jason@zx2c4.com>,
        Matthew Wilcox <willy@infradead.org>,
        SeongJae Park <sj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Liam Howlett <liam.howlett@oracle.com>,
        Jann Horn <jannh@google.com>
Subject: [PATCH] mmap: Fix do_brk_flags() modifying obviously incorrect VMAs
Thread-Topic: [PATCH] mmap: Fix do_brk_flags() modifying obviously incorrect
 VMAs
Thread-Index: AQHZCMoToe2yhFWKEkKYie+ZWh2pHA==
Date:   Mon, 5 Dec 2022 16:53:18 +0000
Message-ID: <20221205165311.1799457-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|BLAPR10MB5009:EE_
x-ms-office365-filtering-correlation-id: af2966b9-6b75-4607-6689-08dad6e1361e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ucOf62bx+D+emm0v5a0H8zsD/inufFIS0efWjif9GByzWVPRJDhLwnlOUswNd2U+RPYnnLeHHuuGeUs873HQCJVZENPCFeXWQQhHmamdcyRWRkYCvACRZHudj36XVIXjoge8Lj+aoGR1noZQ9dk2IMsv8g+Z/e9Vu04v7CK7ER/hgiTxs/M6rtUEG4gv9IZQSJlMqBS0Dfhnb508P+vnC/4Rr1DnQ+YGJFZCFc4dqSHbsOyaZAYDxnEMjWao0i8s/8a4PlS9rONeYV5KOzx4U8ZbRtp0f/XqtVKwD1qt6ETDTQOmSNPN75cRGkv3n04UeCrSeK0T3DoiRb5mUT3e/qDmwVFzBahB7LiaerezLEPxwYtk5B6VTlnK99v6MvMtDPGyGchsUFFbJs53LjuFisJErSpGv5fe5L+704LB4G0mGT0Z8lt0dm7b/tjECcYnT5VK6Y7yZnzvE+VvQasZNSHjnwcuNjzFOhd7xQiYPIruo//iSd0Pk1KKw8zlnO0AusKz7nSsJFijVQh2OshbqDhziO1/qO6QqplmnpAfif4TzaJk+8b1HOdQV1bRGW4G/5kPNz8mubrDa2Tjh2RtULYNistdxNCRvdeN1WEQthn80yVEMKP2+rgHlCkr1AtjO9Fqt9823iqW/axRuqTEK67E8AMZEyVi60znZWpFAk/AaGcsJpBzwjWi/E229Vn7EH+HIz9pTOLAeR6G+8itrg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199015)(86362001)(6506007)(478600001)(71200400001)(6486002)(38070700005)(36756003)(83380400001)(2616005)(186003)(1076003)(122000001)(38100700002)(6512007)(44832011)(4326008)(41300700001)(5660300002)(26005)(8676002)(91956017)(66946007)(76116006)(66476007)(66556008)(64756008)(2906002)(8936002)(66446008)(54906003)(316002)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uaXDLEy69P/rm0BZIUX6N+Mr1NmLqThxlYG4avz08GK6r3A3Yh4ceW7RPM?=
 =?iso-8859-1?Q?jPy+98VFMMxuDR/4EKDLe2zFGXFlFyXuCK/gDaMnZRgbcdK3mR9EWxQ2EE?=
 =?iso-8859-1?Q?w6kYfnprikhw+jBeRn/+qkgdcpWdL2DdyPcVuv+k/ti7tmco12qvwgwxSQ?=
 =?iso-8859-1?Q?1SQ/XLEv1pxkS7dfo7PONoPWXtVcoMrjzKKZE1jWFoyAnTuNKTxbfRfnCE?=
 =?iso-8859-1?Q?dCBXk7l+LAs3F1bKKnwqjfXS88AEayev5FO3XxZLwPNfvkKBTESrhdH7wN?=
 =?iso-8859-1?Q?NLN/ael8/vIbIcl9SqzPp3AeGhvf1GHAZYqxR/bnVs5OAl/TcWXDhbBHgq?=
 =?iso-8859-1?Q?CpvKLzlDVeJ/JcR8f/N2ZVeNA5pTOfkOF7aFfyYL18Medms8ITKXKTJX9B?=
 =?iso-8859-1?Q?YjFkFxYWTf1b7ugPFYXUQP4XwSPcl9BomQTCp+VZoyMESZEp495xXbQUqH?=
 =?iso-8859-1?Q?LWpD0znbing/HptSUIYrwOyhS+gXd4lAmc3LQccxfH+Gii6XEPMVgyTVn2?=
 =?iso-8859-1?Q?TC7ITZiWKjiFECv7VFmbo105kIZ9WGFObt38oDaZyIciiNaXk+G1zQ+ORL?=
 =?iso-8859-1?Q?SLQWeYV1+PgdDN3ZYv+O86oczD2SeiPf5e0KWEXd5d7RVW+NXDDgtSXuNv?=
 =?iso-8859-1?Q?cokWG4PU2X/g1pXRIGEq1pGRIJOJ6D2lVZs1VVj/EaMRkbzysw9EUARAGM?=
 =?iso-8859-1?Q?1fcYWFr5q4eeNUye1gnmAQiPG32PQP7ahaDrLiKvKaPxIQzWYAHrMm7dG4?=
 =?iso-8859-1?Q?u4bNh+Zzud6WLlWWVUzJt39uQXyYO3mciV06gsrd7oFVY4MbfYSROhvTvI?=
 =?iso-8859-1?Q?q0un34tgujOSbvPreyvlWoWrnTx5ZR2PLMrjO+xK+x5s95EVRrkagK2qeP?=
 =?iso-8859-1?Q?o++ZpSkVtu4GILRpkVZRr/z58ODdCTcYhhCG3d1qZzsdOMN4Mv1w7uV9/C?=
 =?iso-8859-1?Q?+5450i62l2/P92Wky0AKWiFFZsf/uKTzJH/r3x8a+C20YlE/+znVIVA7Rl?=
 =?iso-8859-1?Q?6hqZPDWIVlOG6xwYCYSvOiY7NFI1GGN/+Ig7GivjJ0FyYvMwMOA9YdumX9?=
 =?iso-8859-1?Q?DCNVNMPAEmmrOohEtphycr8Gn84NbKnhLL2ZD9pyTD1jvRg0HtSsshCJl3?=
 =?iso-8859-1?Q?hqInsdXwzJrSNPtDXZVMOLUSiGmoO5hL4Uy2zTAr4MKYIfIYIr4/xjk2Ym?=
 =?iso-8859-1?Q?GEhbR5SITxY/aRDKIIluqExEywHGjgXYrVQkY5fjJZ9kFroXeOJ+/4Iw9i?=
 =?iso-8859-1?Q?egoMNuO7xdlcnDs6jDVSpKYDwntJDWh4lWuDjqZAusuaqBffUTJL74wAoA?=
 =?iso-8859-1?Q?/UkRY3xZOuQ2dSiEbjoX5z/poo7OBgQcbfEM3HpjM4/CFukfwQuwzu29yO?=
 =?iso-8859-1?Q?jz4Pt0ACsailLEyXeb/6xyE90OMof6KVKAmzIhe7CS8cJXep6/pbyVpWty?=
 =?iso-8859-1?Q?xHzb3DAwWIuDU4mmAKSU6SR4vRwo5pGvxt0Fp0tfxdfLyAetbX1iRs6792?=
 =?iso-8859-1?Q?BuOlKQSdCL2UUYWERtjiBR8zBXJbT5/Ysy31zMZr8hBVKb7XLv6DfCTBIY?=
 =?iso-8859-1?Q?aM10ghPpvBQ4ry2QMtiYHszyYPwNSMkmjeaD42rZc9eQsJUc5YzOo/IHiW?=
 =?iso-8859-1?Q?alOo3LiUrjTV42BzrOd9HMugZDyPwgvGmKw1ovur2P3xqUUEGUBRwDYg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?O41EAuCGyZ869N1n0FCqPX0kFqKkawlXYjbDfcvDAWna+lTAVH5EBCRC/M?=
 =?iso-8859-1?Q?+UsPBHz/5yFXiSQhhpWIdnYusJ6S0Y+z4QEnckb5niTGk43yNOAWj4vLmS?=
 =?iso-8859-1?Q?ORYiGRda9loWTYYebKTSbwAWZWwGTz+Dhojfbr2jg7VFS/9Wg+IpHGTtrT?=
 =?iso-8859-1?Q?hVOEmR17mEh7vmg4esbiDOIEk8JdHkm+qPdX098SNUfB7Fco1tZ2jBwH20?=
 =?iso-8859-1?Q?pGCip7uBl6h6BSi++EaH0SrDHdh2caR823JM+zxeJZGdUAGqqttXQzDnXu?=
 =?iso-8859-1?Q?BtiX9iDj1olbh3jmW+NOXE2/cDn5koUw1bUMNnaku5Daxd/d8E7dJ6JYs4?=
 =?iso-8859-1?Q?I02wEPx1OKNBLUvGuU85/u9tNtYoA0E5+Adei7RnjcEgWk7u6CmWU/KlMh?=
 =?iso-8859-1?Q?FK0aG+ZkRau5aOU/lDiSgxKMV+wZ0EQwZLvi8YJtVY5JIAUse0sVOZGp3t?=
 =?iso-8859-1?Q?bWDqvPWSrbHP/JaijYn/LzwotqyqqYHHLXI/578yVW3cN8RV7FVUN97AOX?=
 =?iso-8859-1?Q?PIHsz2CJT8PkxEB7uwyJfHymW4zAXKbx0YrRcF3WMZxx9ZJJNGoABQhYRs?=
 =?iso-8859-1?Q?Iy/zVZGYwxkW7ddyHwhu6q2tPi76ydwNN2X0dcmhBkF4itN8uckM6I1gq/?=
 =?iso-8859-1?Q?NErpF88b5CKXv+eym9+/wGLdfVYOcdEBxd/fsdc8ysWGUzUfg410Gz/6UG?=
 =?iso-8859-1?Q?/HfNkeTVyhlX61tSLATtD6nchIofhGLcS8ggUeOzwCMxCxWw9YKbscE+aZ?=
 =?iso-8859-1?Q?nWKdCArpyVt6o1EfVWS55OCWDVFaOzsFsqxj7NE5Yv9HG/MKUkRLKcZ4h+?=
 =?iso-8859-1?Q?98FC+B/W03YgtV+A4pifYVjs4okFqZpLSBYMuDmWDCwEnKfT5dJkSoQlmW?=
 =?iso-8859-1?Q?2OHCjxWRTjbycvpV18Do+AlZRgYUjsTotNzHu0Pi14dWaY7Ut+UxagLLsi?=
 =?iso-8859-1?Q?9XNW9cdCCREkSBnLaOE2Rcv+jETzi6VTPQ//kO62cPhrNdhKqZ5vxUfLf4?=
 =?iso-8859-1?Q?TFniBe1oqp5pXFdl+oDoqhDRFSiTlHJ6tlsj7TU81tNSs8CDGONIDusTUX?=
 =?iso-8859-1?Q?/A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af2966b9-6b75-4607-6689-08dad6e1361e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2022 16:53:18.9825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BWDYSZVoWjAcGf8/7DJeeHxGR0sH+GxhiD1wX7iIbN0wl2u8exqcpswpfzo7yq41DUhIa+OQV9SODR7QrFeA6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5009
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=895 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212050141
X-Proofpoint-ORIG-GUID: roGRcPqQ_3B80jf6mbltQXOIMpQNsWho
X-Proofpoint-GUID: roGRcPqQ_3B80jf6mbltQXOIMpQNsWho
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add more sanity checks to the VMA that do_brk_flags() will expand.
Ensure the VMA matches basic merge requirements within the function
before calling can_vma_merge_after().

Drop the duplicate checks from vm_brk_flags() since they will be
enforced later.

Fixes: 2e7ce7d354f2 ("mm/mmap: change do_brk_flags() to expand existing VMA=
 and add do_brk_munmap()")
Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index a5eb2f175da0..41a2c42593e8 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2946,9 +2946,9 @@ static int do_brk_flags(struct ma_state *mas, struct =
vm_area_struct *vma,
 	 * Expand the existing vma if possible; Note that singular lists do not
 	 * occur after forking, so the expand will only happen on new VMAs.
 	 */
-	if (vma &&
-	    (!vma->anon_vma || list_is_singular(&vma->anon_vma_chain)) &&
-	    ((vma->vm_flags & ~VM_SOFTDIRTY) =3D=3D flags)) {
+	if (vma && vma->vm_end =3D=3D addr && !vma_policy(vma) && vma->anon_vma &=
&
+	    can_vma_merge_after(vma, flags, NULL, NULL,
+				addr >> PAGE_SHIFT, NULL_VM_UFFD_CTX, NULL)) {
 		mas_set_range(mas, vma->vm_start, addr + len - 1);
 		if (mas_preallocate(mas, vma, GFP_KERNEL))
 			return -ENOMEM;
@@ -3035,11 +3035,6 @@ int vm_brk_flags(unsigned long addr, unsigned long r=
equest, unsigned long flags)
 		goto munmap_failed;
=20
 	vma =3D mas_prev(&mas, 0);
-	if (!vma || vma->vm_end !=3D addr || vma_policy(vma) ||
-	    !can_vma_merge_after(vma, flags, NULL, NULL,
-				 addr >> PAGE_SHIFT, NULL_VM_UFFD_CTX, NULL))
-		vma =3D NULL;
-
 	ret =3D do_brk_flags(&mas, vma, addr, len, flags);
 	populate =3D ((mm->def_flags & VM_LOCKED) !=3D 0);
 	mmap_write_unlock(mm);
--=20
2.35.1
