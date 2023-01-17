Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E6266D45A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbjAQCfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235377AbjAQCea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:34:30 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3B425E04
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:34:26 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H09dDE006500;
        Tue, 17 Jan 2023 02:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=lZynW8502CaSJqcgmy6oY5pj+v9wZFB3NSlvIr5uaZk=;
 b=KA1Us3C/yMBsnBanq2k0QF9USnRiehIHQkxDLK7LtqXCSVmDCValGWBqn1XK+O0g7qYL
 bAVswRmpNHozMDa8gnuPfa0S+qS7l+f/ML5f6z0wTtu6AW6dFZH77U+DqQdaL4GeVHhE
 YkT4RpDm/YKJxokbyeWAG/5qDSwnPtGSLApvE9eBFOsOYkfJXucP/dMt676T0ICDJMf9
 eMLXne7eXRqdcfOX/1wSwH+NDa9nQYum+vFT+hGCmqACl1AdgBl464OFUKoJ8nPoV7Px
 iToKTzaIOSqJpdOonWzng56Y6kd3/RNq426leCYw2VjPgXXktFTrmYVHgH4u4nF5ePh0 Tw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3kaabrj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:18 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GMM4rh028480;
        Tue, 17 Jan 2023 02:34:17 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4s2rfxkx-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJ9k8xQXs3defcGxRogJyTGfO2nL/PRFUd+CQP/f3Pzsp5k3lpc8bNxfN7z/FOUIyW/jv4oc5lzmr9ha5+Cz7vgMTA2CyxAH93JiiEWArMNplyUXia3xeDv506hQP5hcj/THOyErE7rs0aAq5mkiy6DoZgNLdsDe5STdFAlicd56N6ob5OiRnpU+K2y9CLmV9P7FUXq2HHct01aepu2cv9rHabWKEQ1pqbXkW370BDvOoC5CwpH0FfIqTTiuGmudrzdkXhZS1/+ca5xDzapkLIA99SRdEhfSu+fsaElD4uYaufEV60IMVKb2GsWr18sk+wrdwl1q/VAlL6JkROUbnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZynW8502CaSJqcgmy6oY5pj+v9wZFB3NSlvIr5uaZk=;
 b=Zq9EPpq67/t8r24soXyraNUNl4LUL2TAI/B0GTZ2VGw2spqU99KXVO3g2pPSMk7zM+ZR+0q4teP7XWUNH2P9/swuyz1ht1VFpEjDtZ2p+kkJ7lBynKpupkbaoi+yLaj+h6i5O2DiLgE1pdpWjQvtDQK4/1zMiV1fjEXL3grkKVJVt6VKmP4pClNnbV4j6W6IGeuLlWrVLs/jAKhFg+wMs1UTBP9aAB/EXDOg9teJ/Zq4CPcvcKofTdH1wWHCaU/mL+YwJhcdZ64v7CTrGY/ktTgYH2sT6hBiDXuub/cMtoXw6OLlJKz71+7mAR1OOnGHEWij9bLW0wvfGxc4O8MHOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZynW8502CaSJqcgmy6oY5pj+v9wZFB3NSlvIr5uaZk=;
 b=FuKvQ3of7DgOB35T5mqiovJgxr5DGQxpipceCX6aZBA5MwtCRDuJrxAyeHzwcWvDQoYRdhsXpc9xUh7jqR/pbO9AF7p4aAgJPD+VlffNFRy5MWxzu4eznHJySZv0fOCGSswhXQ2YClGsBj14ND7YW1gx71TKa0+xbn32wdSvwks=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5356.namprd10.prod.outlook.com (2603:10b6:610:c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 02:34:14 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:34:14 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 11/48] mm/mmap: Remove preallocation from
 do_mas_align_munmap()
Thread-Topic: [PATCH v3 11/48] mm/mmap: Remove preallocation from
 do_mas_align_munmap()
Thread-Index: AQHZKhwvQyq3wbkS0U6IuYR6K+N7/g==
Date:   Tue, 17 Jan 2023 02:34:13 +0000
Message-ID: <20230117023335.1690727-12-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CH0PR10MB5356:EE_
x-ms-office365-filtering-correlation-id: 911da601-7415-44a9-a50e-08daf83352f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DXHcRl2aDHcLZUJQ+hDskACyuvjXO/vDQ0BaOLQ1Nd1Oz8bYovJr8b0SvsxpycWBnpk6mod4bh69o+QfkQ41zon/rae35VE44ubSc4GGZagpbmQB4P/qKVQtBxuZA5nDtq1gICh402Wcy35Brk/S+rNfBUej4/pJEgEevlYv1C9syZoQSehOaIeDQI1cAos/zk8hxab56a7qdSgq44j7l+wODkO9SzUNWMjcLZ+yoLpa16O1y/f5JCNCWJsO+1MHtQTy6zYTPFFAy68rF5jMmupTDMGixg5BGQxZUXAPcvZrGDE4OSLq8gSdxyExMRkXjXL+RI2XNWenFDSYrPWa/BgSPaDJ2asrs39clPw0h9eeWLNvAafA4FbAFFBft07uAgavSwti00/lXhy9Va5KSGD5UbBFBSWcgrxGruKJsoXzw5AQj/mrSSNHnmcnDNjRvxR/HT9xZWvuAmzpYU6hVsRyaZVKRuPVlBSrVylGVhzETQi8nTOHSGv2hhRUPEtphjeDRBwgAO/rXnZzX+5Zuea3eW53WYImLXlbUxCYUhd2/N4zR3TXk22yUcpwuRvkZXMjXDt8nnZZtIyl4joAvuSm/1GOQxfqMsi4dMkWXpcvTt171p6Fz1KVFpyt/i0cTLJ89JnPtT6qUKGAg3pPxFrLMXdU/u0YYVhrA94KQiB4ZHbHwqcZu1b8Ay0g5ZDxpB4BfOZGC/DBqVIzrtpElQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199015)(36756003)(38070700005)(5660300002)(8676002)(44832011)(8936002)(4326008)(76116006)(66946007)(64756008)(66556008)(66476007)(66446008)(2906002)(83380400001)(38100700002)(122000001)(478600001)(54906003)(71200400001)(316002)(107886003)(110136005)(6486002)(86362001)(1076003)(41300700001)(91956017)(2616005)(6512007)(186003)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cKC4rTI3293yfkkFLciOyCgsIQf6/1yLEwKMiPqy73Ae0ELXkFfoIxNs3j?=
 =?iso-8859-1?Q?XqNcu913E/TPMO/BCHHzOL4CDoJpimBu2j3YuJrWWN1lYdWjd3976O2/qo?=
 =?iso-8859-1?Q?cDO0o4dEmYc9QqrfMgD/seiVXSZkUa4mseMukdx0vln1TkYhvrqK+IWKj6?=
 =?iso-8859-1?Q?hLNrRQcVyL2VDMICibyeOwwrqJNSeIOP2py0y0LfQ0gE5oHmvycDDQaujM?=
 =?iso-8859-1?Q?GVaVeCGcwHezefnVAFBtkDPSDVGel1GGV0VY7UbnJ0E2Qogy6n3NHICGKi?=
 =?iso-8859-1?Q?dBst7INSdqqWuxC8rgy0YSwimA5AJyETVNAjf/YxrqLAGZc5VOge/k9Med?=
 =?iso-8859-1?Q?7QMr74rrPmTWbyVkIokfAkVM5pOTi3mkEzcQJyjFZpNbDJo0AKdHPw0WWC?=
 =?iso-8859-1?Q?8NxU6YlcPZcfdH2DpVgQ0LqV3pwQUnJM1l/VtlFPcjvbwslgeqT/aZ8pON?=
 =?iso-8859-1?Q?/4BRdsOKyNm1ZaAoH4t9F1BrvX8E6efdel7GJefQ6YTuv+E1WkEhYy6UgL?=
 =?iso-8859-1?Q?TmQU5PufwOKid3lxVOEl/9EomCXCBWpYIUDV1wU/UGemVUiM02m6WQE3yJ?=
 =?iso-8859-1?Q?dCk8P559MvwuDQ977QArP9UGYZtqynmmPpu2kXKljvc4XJXME9hVy7bCOv?=
 =?iso-8859-1?Q?RdsouEad58ETIUId9Z5+nGh4aLwemNuCJNpH9dslPnU3O0XUeV+Jeh+y0j?=
 =?iso-8859-1?Q?sQROYDWM6199p8TX6AymJ+sZDcsqA9QtDst5r0QUsEFEwlBLTvKNIbpYWP?=
 =?iso-8859-1?Q?cuMyVKw+v7yG3K/mrrXtOAVR2UJdwE44+b1bC7M30cn7wY6g3ukcoJVB0r?=
 =?iso-8859-1?Q?G5mwROG6jP+8ZM2byWG8opIye1QhK1hGz5SUkJ/om59/hHGJACDYS4lyKF?=
 =?iso-8859-1?Q?Sh4nNWhrxE3VO5y1AYpM6hosbyFXK+wqd1TQbDqvBPlqUqqSXy7JGjwInw?=
 =?iso-8859-1?Q?juQIeiGvXbV421uCjAvZpouHDAs6oEC/8y4Dm+py26lzlEEn+c/TA8HoPp?=
 =?iso-8859-1?Q?SOXnRGnxb+hFQrk3orCSNZ+Z0p+QX1A4ZjdaKcq8IkySQi8w8bTZysZFYx?=
 =?iso-8859-1?Q?aT0ceea1nyWpNuuR4C+QnkD789ohzUZjfsdsS3tT6O7y3Ryp8YmwI354RZ?=
 =?iso-8859-1?Q?qD0i4oASpyqa8eJy6APZUJ2lzJsAe1Jn/lnVXM66YPj0GfdGjfjKt/AKct?=
 =?iso-8859-1?Q?xzWv/MRtBR6I5OeKfIFwwgo0lRl6YheqlgL/aGJohMjZoJr4RfQbNFXqPp?=
 =?iso-8859-1?Q?IcZKDnLzOi6ROtGztLOl9hh/SY/Xh+XEo12wgLT4FCpBZS8QMj4Q2VYp+M?=
 =?iso-8859-1?Q?sa1i48lJS0xdchQKhTfz/iDVLb0MCqtqjlPeY7rwRinvAT0+6wYgKeCotR?=
 =?iso-8859-1?Q?Xu+AFCofTReBFBMJEYkM0lHI1SFFceN6q+TSFJRllR0RU0+3b8cDvgsK8o?=
 =?iso-8859-1?Q?YbjKTFXo3M/14AlOuA9ILSRkApMgT8RimFdVlx99mzaSXpQ+wlpY/kGIDo?=
 =?iso-8859-1?Q?eTh4IkS49IKl9xRgxHK78BCmHqry/JvkwK7v8gkcW9J0wHEqVo0hT0PGXg?=
 =?iso-8859-1?Q?NbBOM+h/VixcDS6iIGUzE0vcFasN6ebGxEadpxLlM6cJ+eGXLFMdpqquqm?=
 =?iso-8859-1?Q?9v8hewK3NlNNj07F50KmsdN3xWS93i+YRDY9TvM/0EQ5Cy5tHXY2jMzg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vFIvWclclpIwJW+fnT9LW6poem/5NdVSsTTrv7G0ElEetw5uxaqrOX9pxuFlrG5bFG/cBAFypSuX7DKqDdx7/Vhsjc3xxbTrTwXePjh3/DNnYsK9ThJDgdlPP8zQstn1QZhi2cYWPCVgt9bcuW0uMdFXFPJmJ6be+sxldY7diKfu4FsQujT9wXW6MTtAfZ5H+BJhW/Xyn7RBvjxKuLRfN3UDtXkfGbjh30XdkP4gmlpQhTXh84d6sjM2jWW7OTV7IRzNCaGJRtROgxhhspXgzPPsZE+Ntj1sUaJ52dTr9F7s5exJ+m3B1uVXh9x1/pAPUGPRwKZMv24hBlxgqfWhPNEeeyAzagSl0QPBIGuIVllRfY5vef+0/CN1UoiHnghBaLEg4w3HHsbbK7+TXzVgKGLTO/VSWuQHwKsRuQTU1Q9SpnNP0zFLbuXSLWfFbAb0quMW7eVB2Nv6Op/rnMRLXelSS2HyH9oBr5uN3bVme2TwspL8zy6xJEqCBacK56QbXeLjU723jQGko1ZRiJRQ2wlVABeuM9/ZQCR3Y1CH8SnTuvJ71dQ7i1+IuGyfYSjdbzXQqpvIvuHs2yylXBunjvV9oueKzqJt1dnX3lsmvxyzrxMmW7Xin3t1xnOwOwkKresD0OwOssJ0LNh73Gwx+z6AAseC1IJgZYn3NzKxqEJPoRM4qDW7X5e8hlSxDgX0ubiUZX5C2dexVvpCazR9XMX/yFK2tik6LRTMcCeNG6m9Zu4GMtDyrI4a7I3GXv2UxIFpE1RfqWgGoSqKEruxvyqo5hKQ4CAgMwRtgAh8G14tIJlibg7xaksOjQqNQ33aArFUjkEKi47VEP075Uo/as4ptKPI0WGeVBmlqXAdw4IQ31AaaVbEAM/+IP9y7yxt/HEy5YND0vmqnfhiY+gNAQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 911da601-7415-44a9-a50e-08daf83352f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:13.4220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ILCXKiRCLHsizabR+FYlgJ8a3YTzrqAc0FSCGWv59Ni9AbJ+hkdwrsoHgUR+VF916n6yeC+UoxvR6vEsUefGSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5356
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170017
X-Proofpoint-GUID: lyIDvuCfxfRWyG8HBy6eh24WtqMTI2Oi
X-Proofpoint-ORIG-GUID: lyIDvuCfxfRWyG8HBy6eh24WtqMTI2Oi
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

In preparation of passing the vma state through split, the
pre-allocation that occurs before the split has to be moved to after.
Since the preallocation would then live right next to the store, just
call store instead of preallocating.  This effectively restores the
potential error path of splitting and not munmap'ing which pre-dates the
maple tree.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index fc279b6784c9..1d18e8e219ff 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2325,9 +2325,6 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 	mt_init_flags(&mt_detach, MT_FLAGS_LOCK_EXTERN);
 	mt_set_external_lock(&mt_detach, &mm->mmap_lock);
=20
-	if (mas_preallocate(mas, vma, GFP_KERNEL))
-		return -ENOMEM;
-
 	mas->last =3D end - 1;
 	/*
 	 * If we need to split any vma, do it now to save pain later.
@@ -2418,8 +2415,6 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 			goto userfaultfd_error;
 	}
=20
-	/* Point of no return */
-	mas_set_range(mas, start, end - 1);
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
 	{
@@ -2427,6 +2422,7 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 		struct vm_area_struct *vma_mas, *vma_test;
 		int test_count =3D 0;
=20
+		mas_set_range(mas, start, end - 1);
 		rcu_read_lock();
 		vma_test =3D mas_find(&test, end - 1);
 		mas_for_each(mas, vma_mas, end - 1) {
@@ -2436,10 +2432,13 @@ do_mas_align_munmap(struct ma_state *mas, struct vm=
_area_struct *vma,
 		}
 		rcu_read_unlock();
 		BUG_ON(count !=3D test_count);
-		mas_set_range(mas, start, end - 1);
 	}
 #endif
-	mas_store_prealloc(mas, NULL);
+	/* Point of no return */
+	mas_set_range(mas, start, end - 1);
+	if (mas_store_gfp(mas, NULL, GFP_KERNEL))
+		return -ENOMEM;
+
 	mm->map_count -=3D count;
 	/*
 	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
@@ -2471,7 +2470,6 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 	__mt_destroy(&mt_detach);
 start_split_failed:
 map_count_exceeded:
-	mas_destroy(mas);
 	return error;
 }
=20
--=20
2.35.1
