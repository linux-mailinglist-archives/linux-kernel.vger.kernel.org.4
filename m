Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF7A63C574
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236164AbiK2Qpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236045AbiK2Qom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:44:42 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9F55DB94
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:44:39 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGP2cU031397;
        Tue, 29 Nov 2022 16:44:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=0ERewij8MCkLYisOrcVP4c3U2WBiodItLscmFtT0JNo=;
 b=CA6qm2mud76GQoPMbo+puxeCerO6ouEMfpWsnjTYX7IsizPa9EJ3hS2iRT5Bpjz+N5JU
 u6yXPInkAGDyUhtGMXzyHXuEaSNBYUt8TP31xttv4Ns6uAyzjIJyIcasZo7l8ruYlx1n
 uVdBFNhnzObjNpchbjYHPDF4yIre/+Ced1w9shu0dJEsvbE2XWHPAMPtnobOa/6qzUh9
 XyuCradjQnbPV7n9PgKdLKmjc177RlGo9k9auf92iUn2ReHdjm8HpgR/O4AXshpIEDUE
 MwzC/JsE0WVejXQIVPw42MKZ3k6I79rluBWGssEk7xF4oDj3lpqujMeMRb4W8USF5kPn NQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m40y3xart-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:30 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATFQMIZ027905;
        Tue, 29 Nov 2022 16:44:28 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m3987f2a8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRIJQnnOkbpyg3rVmEPLSzA+cU7PBdmYIDEEejH4oeJuQ9ijN5hkIx1zhZEdRrw11e0XMmeFxluzugmdS5TzB6dtqujykqZ2rGzClnQMont/FhG740V3RUnVsGfEM7xmEHQ+ABflQGszB8HOjgMSGYZID6JMLFs018NtYbEw4beA+z+PCyyqEayLHWkVyvQS8MtSU6WaXOPuuOnEpcAta+THVBGOZ7b4k9O29Sx3QGzWmZ82kpEdJi6sSMQux6wOUWApVvice3r3bcsk/7+CjLrW0PKMtsQxB4RAkX37LXofmZKPa7HJ1HwFhKEeAdMoXI2ZSDkdctaltHL+IcTUjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ERewij8MCkLYisOrcVP4c3U2WBiodItLscmFtT0JNo=;
 b=FfD0gTLuVj/fQnqG6LOKf55S7sOO8h8PoMZEaXOEqXiK/Kpf5LQkcChIB1r1KOSo4u0ND2cxTsFXP+WCu9tiko1DMksCKmS2/Jlf5JTd/wZWWJBNWOHPgNvqMqi5jOx8fFVYvUCvIROc3FrxRVvonhIUpYqdKMVHlWlg7GIGgdpl115vCx472jL2elhQr9/XlQtR58IWJigdQwq/3ugqJSJ9+JNmotm+AqDppE/iMbf2Bic3mxNbzL5VLzUudP/niqA76tFJ+vEcZBh6MxU6FvCcc/C7vdSrhcoXh5aLMWain463EFFBU/OrIFIkJLwK+K7HSSWtswwRn+Aev4WBMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ERewij8MCkLYisOrcVP4c3U2WBiodItLscmFtT0JNo=;
 b=Y9wlVlHNq0639J3sY7QiIdDEPbv2JWyjTD855wCz4tS//HUoyMep9qZaGgTa9Z/wQ2R1B96NplInEVnHR6PWDj/RndDwWrjEfqbOx7dRh5dNlC2meMrw576nSsyBIauDV5UddALEWDvnbArNp3pO19ts6YjlcnNK/t9I88ETvjU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5321.namprd10.prod.outlook.com (2603:10b6:610:c9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 16:44:25 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:44:25 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 10/43] mmap: Change do_mas_munmap and do_mas_aligned_munmap()
 to use vma iterator
Thread-Topic: [PATCH 10/43] mmap: Change do_mas_munmap and
 do_mas_aligned_munmap() to use vma iterator
Thread-Index: AQHZBBHWApe0F7SRwkeNx9Ww7aOieg==
Date:   Tue, 29 Nov 2022 16:44:24 +0000
Message-ID: <20221129164352.3374638-11-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CH0PR10MB5321:EE_
x-ms-office365-filtering-correlation-id: ac972d83-5e08-4b55-f2d0-08dad228f9ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EMgDYpcvdaQbvS9OJ6GmnURwEFs2a2MCwrK2hyqqrKzRZThykyQMIOMQqQ69511KE+L2mD+ExSmKmKJ4DNjgpbMfPD4bdfQ7sWTvOLJzFaIVxrg7+T+qrwQb9h5bTEGcVvkoGs2aEtjqvXNKKyv/5hfOgu7K2uqD/kelU5/rWhS5xpg0jQAwUzmObuDjmzewuTSe2ehS/Rs9erN80KWbaWpVfbsbFwOvgAKKGKs+FtLoirQMANQI9B/5lvByeDju+sbAaiHm82UhZAHRLQQ/7T1Nj60WuugO/b8NGRGJE2S7C817Qr5YoOJ0Ux9cpfsAS826EL6lrXrYhGWrMWQML6yaUucx+469F0rUI9K5yw7rPfJyP5hW9G+Bdw1k17nQTRNqBM38q22n6XSWX745OWYOnUbonwX9IlHhdZ7C1VDVGbJxGuJRuaeGSKoO3sHTaoa7XYPB996RIphZpHgj+SfwF43JLSwjQlCTPRLCryUuFDN5KxoedpsC8zOCZcLab0pOm1HchErt87zAbmN9flp6C8xeSyOmdP2g9t3eR5hAyh4i55VjH6Z/QyRsOh4dE8w1upE8BBfm0sZ+nFl0hQQef5eNtSYaZUlEibY99d35cv54FOQDYP7dgat7e3IwbL9YIeN1BkmXaAncWyGElo/+TOYWvpfXeMjTSsCbP7nhdDtfMgfBEcrNp5dWbV0spCZMxsMM4sM2vRndeZaNNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199015)(83380400001)(66899015)(54906003)(71200400001)(6506007)(107886003)(110136005)(6486002)(86362001)(36756003)(38070700005)(6512007)(38100700002)(122000001)(2616005)(26005)(1076003)(186003)(8936002)(5660300002)(66446008)(478600001)(44832011)(8676002)(66946007)(66556008)(64756008)(76116006)(30864003)(66476007)(41300700001)(4326008)(2906002)(91956017)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ocOJZJc1dzsyttUBXg0N8T28XFSJn7i3Ujqw3ListcvUR5BZNybzDV1Z7g?=
 =?iso-8859-1?Q?FH03votvFkCDeTcrInV3hFdyUpuf7UWa1j+0iaSpKuQ/BYBpWt0hLGupkJ?=
 =?iso-8859-1?Q?whm6ZpTegdX6bxU6eVHOABUBpvl2nxF7WE/8ljZn7y8qvNzTFRwA4KYqTX?=
 =?iso-8859-1?Q?XccfMLnsyGLf2nOvK3tBGppLZ8K3B5nTM2508MT7v/DiC/iFe9hsJVw80u?=
 =?iso-8859-1?Q?VUkBIo0J8Kb1v1ZLpbKH8z4m7vw/kgHsLQJcHAUBxUcJYgch4xjOaiuCXp?=
 =?iso-8859-1?Q?eo+BbXt7YqYk3PKmMuza8NS/4h1zZRGJNgadjaJmeYuWBi7a8wg0Dm64Ie?=
 =?iso-8859-1?Q?2aYwSpZpq1I5zx7zLvpZxmr4odQtEoS2mSXvmwhFDS1O+eoJxkbC/4m4X5?=
 =?iso-8859-1?Q?aGTOIN7/hFwmsqkcuPugHL4a7HTaM0H/kCG4ZI/fM13xW/ukGJiGJrBxUX?=
 =?iso-8859-1?Q?F3yw0lew2xD+9hYtnKWOZ1lepe+VScz0TUG+Eo/dBEMOMSIbw3K5H1KRTA?=
 =?iso-8859-1?Q?tou9FaPfJXjLCrk8HusF0CtxmVsj6qoLh3uiDLU+Dk2YFaFY0l/M80VqYH?=
 =?iso-8859-1?Q?l21LVAcoYLiniwQ7SOTKrEEorhrOckWrqFelcN4UL5JJJfZCndSl2YqWQQ?=
 =?iso-8859-1?Q?lT0LAPXrqKjZ3anDAJWo/mGsGfhdb/frECFN3HdlczcfZbhhBB1Y3BTXu+?=
 =?iso-8859-1?Q?hLzWdHFQUGesCFX4UKlY0E9N8hXIBTmg9ifamhU+Wk+m88yL1lv2C8MBx1?=
 =?iso-8859-1?Q?+9hgKv5fK8tdH6dcWGYJtKpQ9k7XWdxMlxogz6Bmg147IxYekiAx0Rydxw?=
 =?iso-8859-1?Q?E5nXc2QD+4mVjrKf5aCYijFlNLpJ9GEBNznC4SmS9ox2i7z4ZNdJLu9g8x?=
 =?iso-8859-1?Q?xw/brGgwSFcR7Ob4j5Z2z0XaI3u2KsgOjx+EQXFav+aLeQotzEbVqfA6sG?=
 =?iso-8859-1?Q?HsVRFv/fdyQtGHa9gpLTjqpLdhrTiScOSsWGxFBdhQdtmvJC40hfIao6eY?=
 =?iso-8859-1?Q?LMl8Ap2r9S3YS7AijhHpsiF613MgdGD3qNfZy2De2+eXCtsg58jkNRZFDy?=
 =?iso-8859-1?Q?ZJUHIzECWRlOrgcIkPBgcfaYaVxcZ/5DkW1Y60Bf2GEsHWETYjk4J/f+68?=
 =?iso-8859-1?Q?INf/A1G4ejsfkZvcGexhdgdxIPSh0bSsVr7D+KPFysmoj170WcGnndRyI5?=
 =?iso-8859-1?Q?oW9xBuoi69ThCLPpT8pYa48/r2nYS094iGCuw73fjYFWJDzSSE7riFhB9R?=
 =?iso-8859-1?Q?KcIrDxFuhFBVDqLQ7qooWZHFn03mGMpLwyROTM/wKPIUxPYTPctajAOE/M?=
 =?iso-8859-1?Q?UIc9b0kHYaWmp9zS3Xig5coMAiOqdegkWb3UygtsxhKvj7P0rFUlAffgDX?=
 =?iso-8859-1?Q?Jqz62ObGfivVSxxxrkdHXEmnqBg7HqdyPtC8rzsH04bpUzK2KqQVKzj2JQ?=
 =?iso-8859-1?Q?Yv30evnUc4wiy5mY8bFNBEQaQZRyKVTWXY0NjdKuzweWrKd49U4hvx+BOR?=
 =?iso-8859-1?Q?5aY14jNux8rlCcz82/W4YlumYnNd8CUS47hbcZhSiZO2qITDws5ByyZEib?=
 =?iso-8859-1?Q?Pa26DoyZXjU7kX85of5PUb0/buarLXsMwdLQDUJR+S8s4x9OyhlLctGJuY?=
 =?iso-8859-1?Q?0l2CMSadew4T9PnNPd7W/OzDZBRyPSCktjKQatzvGPGvwuuY1V+Zg9lg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PhHmf6K6GeQexdqY0CzfQO/6aouMWCqXYP7P0tkk+Q+o5AVm/q2GDiw4CDaHMzi5D9L8bXxwhY660gZUWmqWJ9Czk4CoIEERgS/VZlbYFMJD50bu5Z3WFPiyYimM+ibRnZjdVeIcXwwJLj7hJpXnf42ut+dyeQyMlnJPjBoZsSYeQup2d0xRMZrewsJJPWcY7FugUUlKOSw/QwQSN7A8VtQZSzvfgsveOA1HhSz2uQVE9+tqXgsBZ/xBpJm7xfpxpqLZSo+gvJ2TaKFqcF4Nv3ZftFpWbkHul81dGGEjpC2VjShBndO8t1suEjP+RDpay8gIZf7DSrqfkDUf1jwJSvv6OVEhxn4OJTrGGkKov5hQ/54THhWCGqqdngGnzyJW0PUXQ4/uPEf6jHh+PuZQL/okb9KU9jaLzNNtE9Qat8mF/Rl2Ji0jeg7Oop8Z19VlzqhixxPG6mlRLEF/nklgAPdvGf6VJiw2ARBBGr2Wi0LiB7nJDA+4/FeiNSIeXrQJTK30DEggu86Iv6lmU1mE5P9/2VHw94z46wruk+96kX6WN8WmaNr4NHccYtiI71TpJktHL4iQUeqG9BV3XYkHRcDZL2hN4HI/1jTk/rBNcpXEtj6UG9MJhQGWH6K0EtOD+/78IvBSVTgTuJPik0nmBfW2t4FLnmm5CqQ2ea5pZt1+N95i6FX2PhT+j5R0JEXDkFyZtnTWwWtkDFaX6HosL/AciZknNlCOyNadMJVCmmuA/MFtntK8TOh0S0EBUqqnyy4izt+RJpxFMnqD6k6eSPD7ZniFaZ2BCOVJaZdPvQMe2W6Trlizo9M2t5PLGhctViucgKj7kCRQZ7PFpSdx3hvE7++wsycj0JgOZWX/tTZRGE0J80Pe225X6Muf1FE+cXXpZA5xlbf5S/7zOROsmQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac972d83-5e08-4b55-f2d0-08dad228f9ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:24.5667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SiA/vFBVfSsvumMxsmQkDx7OgOpUGULwTbqrrJmce/vgz1vcU8JSlOTEkZ9OZHOgIO+d4PJRPr9iLgsxRCEPIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5321
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290093
X-Proofpoint-GUID: VNj3kUAKQeoI1dwY4j8Qp_EMfr-UeXFF
X-Proofpoint-ORIG-GUID: VNj3kUAKQeoI1dwY4j8Qp_EMfr-UeXFF
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
 mm/mmap.c          | 75 +++++++++++++++++++++-------------------------
 mm/mremap.c        |  6 ++--
 3 files changed, 38 insertions(+), 45 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2d3a49ba2261..c347509c5f9b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2766,7 +2766,7 @@ extern unsigned long mmap_region(struct file *file, u=
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
index f601f7b7dce3..e2701bc92c1e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2361,7 +2361,7 @@ static inline int munmap_sidetree(struct vm_area_stru=
ct *vma,
 }
=20
 /*
- * do_mas_align_munmap() - munmap the aligned region from @start to @end.
+ * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
  * @mas: The maple_state, ideally set up to alter the correct tree locatio=
n.
  * @vma: The starting vm_area_struct
  * @mm: The mm_struct
@@ -2373,7 +2373,7 @@ static inline int munmap_sidetree(struct vm_area_stru=
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
@@ -2385,7 +2385,6 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 	mt_init_flags(&mt_detach, MT_FLAGS_LOCK_EXTERN);
 	mt_set_external_lock(&mt_detach, &mm->mmap_lock);
=20
-	mas->last =3D end - 1;
 	/*
 	 * If we need to split any vma, do it now to save pain later.
 	 *
@@ -2405,27 +2404,23 @@ do_mas_align_munmap(struct ma_state *mas, struct vm=
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
@@ -2434,8 +2429,8 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
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
@@ -2457,7 +2452,7 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 	}
=20
 	if (!next)
-		next =3D mas_next(mas, ULONG_MAX);
+		next =3D vma_next(vmi);
=20
 	if (unlikely(uf)) {
 		/*
@@ -2482,10 +2477,10 @@ do_mas_align_munmap(struct ma_state *mas, struct vm=
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
@@ -2495,8 +2490,8 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
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
@@ -2534,8 +2529,8 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
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
@@ -2549,7 +2544,7 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
  *
  * Returns: -EINVAL on failure, 1 on success and unlock, 0 otherwise.
  */
-int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
+int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 		  unsigned long start, size_t len, struct list_head *uf,
 		  bool downgrade)
 {
@@ -2567,11 +2562,11 @@ int do_mas_munmap(struct ma_state *mas, struct mm_s=
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
@@ -2583,9 +2578,9 @@ int do_mas_munmap(struct ma_state *mas, struct mm_str=
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
@@ -2601,7 +2596,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	unsigned long merge_start =3D addr, merge_end =3D end;
 	pgoff_t vm_pgoff;
 	int error;
-	MA_STATE(mas, &mm->mm_mt, addr, end - 1);
+	VMA_ITERATOR(vmi, mm, addr);
=20
 	/* Check against address space limit. */
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
@@ -2619,7 +2614,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	}
=20
 	/* Unmap any existing mapping in the area */
-	if (do_mas_munmap(&mas, mm, addr, len, uf, false))
+	if (do_vmi_munmap(&vmi, mm, addr, len, uf, false))
 		return -ENOMEM;
=20
 	/*
@@ -2632,8 +2627,8 @@ unsigned long mmap_region(struct file *file, unsigned=
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
@@ -2661,13 +2656,11 @@ unsigned long mmap_region(struct file *file, unsign=
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
@@ -2706,7 +2699,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 			error =3D -EINVAL;
 			goto close_and_free_vma;
 		}
-		mas_reset(&mas);
+		vma_iter_set(&vmi, addr);
=20
 		/*
 		 * If vm_flags changed after call_mmap(), we should try merge
@@ -2752,7 +2745,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 			goto free_vma;
 	}
=20
-	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
+	if (vma_iter_prealloc(&vmi, vma)) {
 		error =3D -ENOMEM;
 		if (file)
 			goto close_and_free_vma;
@@ -2765,7 +2758,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	if (vma->vm_file)
 		i_mmap_lock_write(vma->vm_file->f_mapping);
=20
-	vma_mas_store(vma, &mas);
+	vma_iter_store(&vmi, vma);
 	mm->map_count++;
 	if (vma->vm_file) {
 		if (vma->vm_flags & VM_SHARED)
@@ -2826,7 +2819,7 @@ unsigned long mmap_region(struct file *file, unsigned=
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
@@ -2843,12 +2836,12 @@ static int __vm_munmap(unsigned long start, size_t =
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
@@ -2980,7 +2973,7 @@ static int do_brk_munmap(struct vma_iterator *vmi, st=
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
@@ -3104,7 +3097,7 @@ int vm_brk_flags(unsigned long addr, unsigned long re=
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
index e465ffe279bb..841fcc70e017 100644
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
