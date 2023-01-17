Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B38266D47D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbjAQCks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbjAQCj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:39:56 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9478D303F6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:36:13 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H09ZsE005646;
        Tue, 17 Jan 2023 02:35:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=pJ/7ZC+ntmfdKF++qbytFnfm14yjKCOCTjz8I9jpD0k=;
 b=pnatHnwak/ocu9rJ8w3MILxfpTH/Io/KHrgzIds0JmnAi12m/O3l7BKqH7Ml3CB15Bhq
 PGQ2bvb1VatYAJrbqLxnQq5nwCRq0LbHwwMQvOsU1dQWcdGRiAXwvg7c0fqTZnUF4Ifr
 kW66lDUE0X9Kih09QRv70GQuUChMOAkDeDcA2iF64oJ63MDDitg706ASNsrnu6zmWPBS
 pHDNwt8kVu4gtIQkezWbt6CZzk7l0THNUqb9+vxNFN94XJreD5otZk0r/zo04yduN6Hh
 r6k4dd0ZYTesIPg2P4Mk882FhRvT+Bk/i3gT6WBSE3dKyOXUarXwI/pna0Dg4cVc75tp lw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n40mdb5ew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:35:06 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GNCpCW004918;
        Tue, 17 Jan 2023 02:35:00 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4qyy10ss-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:35:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrqArGU//fnl/6OH6OPwctsJYNbeYHHi57X2JPp3GoaozKgYtY4q3fVwdH1b/4X6pJPZFBOuWlSN7MwdmfNAvZJ8JT32DibkOtZIOBk9YaeTmG/bOnyBMP+H3sYoH0n8Ns6IMzNXxw3+OYUQsOdVRFC26q7kCCLSbbj2dTosY66btYcbAdX3rqF6LfvOH5G/g91MLB9GmzyLjSvBH7Hiowf6i5xL5vu9G7geRwiBG1xbZEnXdTeafLyWo39xX59hvpQJicG3VhVDLrk95KkcXzD7xCloiIcSdM/I/spsK3XkUQio3FTC9Ggm1aEajrlu5ZzdssYV/GSgiA1lnEvUrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJ/7ZC+ntmfdKF++qbytFnfm14yjKCOCTjz8I9jpD0k=;
 b=bDgageNsmCJtpl69Mc+Qmn00sW8E6phnttop+kE0tGBVZeB2vjLKz7x2XcQgRBQePNRc2dX9jHUAfuh/2qn6tzexg2xseQlFo9177mvna4FcXSK4Z0jGhy2eiCZoY6mx6gV5GKcTLirERMr9Qmdt8mmrSXwVt6pQpi4V15sBYeBX//E30CQ62c2ro98QTkeyxCgmtzlD0ok9OBz09SfJZyQ2KKK2jp37EH8pO15gevo09hMtKJUfo15PMQnoCoKZ+kTeRpaXgLYvySudJiLIN2SHN+ou2toyJMLwxf3A9jtOrGNuxnSpoZt2ncPuSLwi2UJo2vyjpbf59AdQL0wWEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJ/7ZC+ntmfdKF++qbytFnfm14yjKCOCTjz8I9jpD0k=;
 b=ZCzTNAIz1ebl8jiLP1hdEbiCaUwHkRJKcNAMov4JnZTJ7fn9aDHUnjiO0jGkTwB6Jwku1H1zN9EHbaDbQKeTwMre1mv1FlIW85b0k8fALyssPZElXDAlR5JIIiRYrhRYkd+u2b7NCCqOjWN6/JZVhLFdaC2tnH/2R5y0C0AJs4A=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO6PR10MB5538.namprd10.prod.outlook.com (2603:10b6:303:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.9; Tue, 17 Jan
 2023 02:34:58 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:34:58 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 38/48] mm: Change munmap splitting order and move_vma()
Thread-Topic: [PATCH v3 38/48] mm: Change munmap splitting order and
 move_vma()
Thread-Index: AQHZKhw010/t6IOVzkK9qaSgGgYYIQ==
Date:   Tue, 17 Jan 2023 02:34:21 +0000
Message-ID: <20230117023335.1690727-39-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CO6PR10MB5538:EE_
x-ms-office365-filtering-correlation-id: f70e9818-ceec-4ec4-33ad-08daf8336d52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pi+42udgjwGAWVGKCESdDqvCZj4R0zxZJzu3nvhE+iCEsN4V0vohB+UAJqAk1WwyaCxPUmUEprGId6AE8uxkUIVCf0zBAOUnZKUMAtemZDHZ9U5BRG8Hok4EsXKKQDE0THHy68yFzTvRxsz7/5FoAQJHWLVnXDJo609HkPbFYX0aIUBlQaUDJitKrbT9q9g8QczfbTzI7DEBFLQMvAVqavRN1GXzGh3xpuGRPa+I/9CMH/k3WCxTwLXbP434WO+LoqNowrod5JTrbsfUvGwotLlmB/W4Ion6/9rYem2PA2MW/X8r4VW+7LWFpfzTHVW6a4tI0Yhz/dn0f4IT+COAmVPOfCBAgZq+zeEVAQE23X5A8mdG7vng2HNhxxaVzWRU9pcQiQZOpTKLcFtyijQBfdneorbr2wBtMix7bW6+J5ATEuixLEnCJnZibdRMl7jNuLIQc7ZxfvSx5KWNx8ktbcqwxgAxRFHr4jXRdkIQKT662aHXKltE/T7BCNTzJ2UfiWTvb0ISwPhiERITys3RO8hIl0fNYVwpgj621NTPVzF1WehMqzLR+eMkJ7AmS57XaDDV0Zn61hb0NeTxChp6udkU40/L072MjWAUKpzuGBMCX7pepam9ci1nDbbWkxWxl5zPu/x7t7iLQMxkUb1i5gsImZuXRHDq2wyJp5r5Q6jvnudgLjDEC4oX9ToLJLQY4XgY6d+RchIKT+4pXhaLWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199015)(36756003)(91956017)(86362001)(8676002)(6512007)(64756008)(4326008)(186003)(76116006)(66946007)(66556008)(41300700001)(2616005)(66446008)(26005)(66476007)(316002)(71200400001)(478600001)(6666004)(38070700005)(6506007)(54906003)(110136005)(107886003)(6486002)(44832011)(122000001)(38100700002)(2906002)(5660300002)(83380400001)(8936002)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Vd1gBlzoFWI+Z44eQeT4qqGJN7x5Il3A60HRCH01bjK2sdzGcCmYFsuZpw?=
 =?iso-8859-1?Q?GYvfRGlgRUE/jD6+xMgDazrFJVquO67bDFR1T5acVUtV/DB9NxpGEPWJ+6?=
 =?iso-8859-1?Q?TlJfAGp4xHT9nMehW2GbLb39SkL/s9L6iq5gdklbTSLu8caTUfnJMdfno1?=
 =?iso-8859-1?Q?ECk55qvTZyA74qKrGEvpidC8Bwwqrc3CDXw1AUzuJcsj6k8p/8zlHjucIH?=
 =?iso-8859-1?Q?GxtLwcNSYxht4xnjw3awjf/Uuz1f1cQHktGLZIA4qMd0kP276QFMSaEGsq?=
 =?iso-8859-1?Q?3ap35vrpDl68+L9fFd9PkfVAz5dV6vDs7ijq9Z54kn2pPtyfRP3CssId0v?=
 =?iso-8859-1?Q?x9lJIR0Mkx7oogCvKGfbpCO9KUo86+4tiXNwWjpoBUCdjUpSccepBTUdCP?=
 =?iso-8859-1?Q?HsfayKthomoN4tGyzR9aNwNlbw8n2M9QI7IdAFhX4KWp5uVEjlqUwEmgdN?=
 =?iso-8859-1?Q?KTi+WePB9TMZkmH+xUY6WVWeM9IdiDpEB605yXBiCf7BtOT4YFNyeX2uCi?=
 =?iso-8859-1?Q?XEo9MHkNR1Kt5bUhhg84NhnX9D22cru6oa4355uF68vpvGfAbVSDP1rwRt?=
 =?iso-8859-1?Q?wMrZuBBjFP2Iew2n/dx9o+cI/Vtb1TvFlAz9cPiF47A0p2DF/IVkbHP/cc?=
 =?iso-8859-1?Q?gFUkvpcLglWRBhZgTEw6Xws2uiPOnOL4S7J3WaZ5KJEnDlfPr2POQDP24Z?=
 =?iso-8859-1?Q?6s6DxokW3q5yduF6/6CH7gOeB1Py9YSGk2qmdsRIDzCcq3JeN7193LK22r?=
 =?iso-8859-1?Q?KevPWTA4PUm069mMP6Rw2IfaT1QLeg+11pzKZSLijyXVyVMKzRDIdk3Lob?=
 =?iso-8859-1?Q?qbE2kpx3s5y8qbzpB1vUHrdshYZ1yEQP3OA5dj9EypuH2Eu0mkCtHqydDc?=
 =?iso-8859-1?Q?Tw3rZyabA9fV3TrmqIT1mXfTU73kxmusmWvH2bJCSjalppoz+gFxcl1nAv?=
 =?iso-8859-1?Q?zLHPa21nYrXbc2chvaRMWWlldaRmTmRGmnDQU9HW6peWfsDzuYHQpsGwE4?=
 =?iso-8859-1?Q?Qje8bLI6fU/zKYhLUY5pYSWA0+I8IvTZe90JrzsXMEy9DMz+JMsEJ8BauG?=
 =?iso-8859-1?Q?i0OIIiOePeKsgq9XWmPqizIuc8+gvNvr7HukKKVZryBDk9lUFl9gvOZA+P?=
 =?iso-8859-1?Q?k3bViRQfDVMBY9p3zTLyIbSnMitvdZppjwTt8ABThIhxGzwz/yhvJfSxwy?=
 =?iso-8859-1?Q?NlyJxZ91EEc86VX+lRLyL0J1FJ6Xz84yrh4RyS//JBXV3zoMqRCTgU0F64?=
 =?iso-8859-1?Q?KvfbIiXNnzoc2ixD3zm5sUgmbZXorTp3vj4zJu1hWONwNiVWzl5kGK5cIs?=
 =?iso-8859-1?Q?w9mVuRzQoyi/wgC0hrAmTba3pMrg7IWuPpyikhdK00z1pI9qwU9am8SWAX?=
 =?iso-8859-1?Q?bgw3uJ0YDM0Al0HOWoq58MURnxQchBfeqTWQJJ36WJ/oCkqx0e0ho/FXel?=
 =?iso-8859-1?Q?799i3umTMQcaq5cOz96ktBh/t6leDDe8wP5ycongD4L9zBWscufY5YEkDy?=
 =?iso-8859-1?Q?0z8OfAyfbPLTQVKfpIWFNd1X21FCLjcy9kmJfXEPAQc1lzUHadr6n39/l7?=
 =?iso-8859-1?Q?GBJ7HrCRjKFEXn74TG6kZ8grDFYmXzaLUF9lJOYxIC1U3BxRf18Zt3pFcP?=
 =?iso-8859-1?Q?hnQyCOHPAdsSjRc1fOcGYjJT/ivXxZTbZ7QxcEautg3UcsauhNrupCyQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4ANJ+TXjsGFyIqST4q7wUqTlso5HWcDW+lBslELnGjmygLQAp+FfkHiSmxYAZJgolB7WpCz+++Z+p2PisoC9tZEfp0y1M4lZFBAIg4dudazWiGyA8/rxdzfSRAnRDGZ3UZjotFefWMEdBq/s9bNOQBiTypzhoMXponqL5Jh83GgtM4J2s/5KRQI4dZhoVTB6YPcFNLz6jITLAvDVS5vb5ST4cU7r/IMqGbraALhMl+AKJoMXm9e1T8A4Efzg7tKuAqPM8dSWwV8PT2mIhhM/6YBaqqSonX7x7cuaiKT2ZdVuTXQtpVa1CI2r0r3KNRzKai8XvMYR0TI6bp5EelisvIXdsCDf3vUnv3krtLAQExHgkaos4V3MhB1KEhyU+w5Q4tc2OOHrdQ0pctdHoWrcrzSTrAV3Jqh95sIHhPNW+8Z8iCx6vruKINRTEEH13POUKtgGIVQkSmEY5O0LRQyBOqA9Z/03gXEwh7AP0WxxJVAFfYO4gMctmgFdPEzkK/K9EiETQR2X5NsJszwNgVisI4xDhqY2kKpAPMLdeupxtDX2smqwuBiwLJMc7/u4QUnZpP8wn7E+Ete2J/93WHu9fBVVa/dfY27Dy6V21huAKQCZraoGbnd7hMMSDtJQPuxJTdOiwQsSSEAK9fPOif0mI02k+/FIDTxeYihqUtZ44SiuYNVjjoMsZQMGoehKxqhpjQOBU1nFqWGTf8NCVKXrlrNhGXIsrbBDTUluvcbcTIfe60li1tha0TfsCFNjIfHR8oUsyc4indtboHRlx/Zbmbg36nPccL6N9caYrsoEBKyz6BfNt5XZPpR6mcOw7FEPCqocG6CnZE/AvskOX4kmzsLshnmbQQnZ2H1nqO7GqVNO92EqHjy2mLb6gUz1oZJ2zkwuQP0BysxTEIa4WOrXrA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f70e9818-ceec-4ec4-33ad-08daf8336d52
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:21.8589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LXgVqPXP3K2TKSljjUJV1I1hecFqkXi9XblDz2gFlEEFv5Ks3MIETG3xiDq2mCneMGU5NxWi8WkELBBNlCNztw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5538
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170017
X-Proofpoint-ORIG-GUID: 8sBs_7mJaU3KoUu7LHY8UI3VelJ1mHmQ
X-Proofpoint-GUID: 8sBs_7mJaU3KoUu7LHY8UI3VelJ1mHmQ
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
index 01988db478e1..434020155f8a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2328,21 +2328,9 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct=
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
@@ -2355,9 +2343,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct =
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
index 00845aec5441..98f27d466265 100644
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
