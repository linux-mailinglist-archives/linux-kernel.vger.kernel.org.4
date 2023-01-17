Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB86366D475
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbjAQCjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235682AbjAQCif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:38:35 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0453A3029A
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:35:52 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H092hS023146;
        Tue, 17 Jan 2023 02:35:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=eF2d5CpfMy96yG1ZQEneYyf5Hkh1kJRWdzsjf4BmQ7o=;
 b=YHZ080cIU6Tdx3TyJIDX2UtWU57Gy5hXoCsFOkUDqsyNMJ4Zf0lx5LXobZqFXxK6RY1h
 WWTINpkE9/wpbfPxPVwMGnlQ/K8fTfPGfeg0AZki3m8eERutxRIn94m6elQ6bLOLEdDS
 FS7trQWjL7hLOqQf6yURBi4idwQapGKz07rglgEZVIWX0tXIp2drJafX1lwNvh09TDoH
 fvcCDJ/u1O8HMR/GhDa6v+Yr/8RDTUeUK/4xZA3QMYBEvUD1KT1wG/JOveTFAgoQN5gJ
 t/z+E8ajyq4OWgAqMXmyD5Om99b4/iSoYSwNiC5WWI+iNiIA7ms8rslKDySFNQmIXOwN nQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3jtukq2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:35:02 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GMXP40028373;
        Tue, 17 Jan 2023 02:35:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4s2rfy4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:35:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFd4fwgVF13cyw65JOB6rqbvsRfCz92bSEEJg2pS2dmDh6PnTXoYwA1skN8zopFNycGlLRcfl54sjZZ8bCxoWcdrt6knMUDB9T1Pz6PpxJA0+o3vGIpNXPsSHwOdMlHv8PDHfalRnAeayeI/Zc074cdPZrNw1A4FTo/vXIfnGWLkmwuZ/c+fDAoKXZdhry8NQ5oEx6BamH5ycX26WwGloswQE+66Ebi69PrD+JtbbRm709wJr7+RUb7FAbN/cyF7Jv6EQzT+J2kMtT07bLcFTbkbw7QFTr9oaRj4zK0mpw5nLm/preOl0hSSTQBTmWVDxlpcorP9S7nGkQ5ijaDusw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eF2d5CpfMy96yG1ZQEneYyf5Hkh1kJRWdzsjf4BmQ7o=;
 b=OnAl0s6Jyu+vYQpe6CQzzB99iYxeEMEERu2AvXdifbU7Io63UaA/iC9QS0X1klQesSD0P/XtIcUbiflbpSeoL75C0UmmuZsPREbhu086HfD3RdCFEq/jClVOrv19hJ9THdkDQooCY5EOziKEN4dD1O4bH2Z2jrqxc2ZQeUv8+rhfwP4j15pm5S+8LJSNFxRVBjqUH+ZK9FRxAXie7jPUHsw6XGy6THUdXjHiX9HFB5lnxsCmJtceDiVixRdTlMj6TQRIP8j4MsfRxHg2d2hKCb2l90Po+4/7xEOIZN07/Fd2ogX/FnVZRZ6HvQzUT3MBWdyzSIUAv6p7OfBdMgnvuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eF2d5CpfMy96yG1ZQEneYyf5Hkh1kJRWdzsjf4BmQ7o=;
 b=SymA4Eg8pxKVf5sn5G0g9nSJgX6eaQpEBbVVhDVBfru8tFu8mAYVaHpuTjXZyWQGZCfrtsrFqNErBRPfV+GMRa3j/keSxAwHHfsVQJYJbfpjU2RJcXs9SsablUVYb/tPGBIIka27lkIZIqlWmEaIwJFHcY9vEpg293cNhSsHTMs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4814.namprd10.prod.outlook.com (2603:10b6:a03:2d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 02:34:59 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:34:59 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 39/48] mm/mmap: move anon_vma setting in __vma_adjust()
Thread-Topic: [PATCH v3 39/48] mm/mmap: move anon_vma setting in
 __vma_adjust()
Thread-Index: AQHZKhw1UVetSQCxhEaEgbid8eLidQ==
Date:   Tue, 17 Jan 2023 02:34:22 +0000
Message-ID: <20230117023335.1690727-40-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4814:EE_
x-ms-office365-filtering-correlation-id: 85850537-0d3a-402d-dfe9-08daf8336da0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cEHNTSN61mYhhjVnTscQ435ijyyTlTMaOYiCJgHZ0zrCcS9ViFrDJgmgL8BZGU/8jkv1xNrO0MYNkuSAJYQ3Yd6DzSsMIfKzA2KhX01HYCUdhvP3I+jJXRCLehk9YldvXQ30VdWdDqQAhw8/GhKph/Z7BoEpW4gdk+U86OlxA8aHi8J5NDi0VVF1S3064aN1VsKRRGzexLjHkR2KTOFxg0bIjHE8TnRjYkf2BK8Ukx5Ec60Fh0YRXlwHyGN+49VaMU4dzeAWYNJ3eeZ3Ric7JJZ5Niq5yH+Y+O3pRACN1TpuOzQ5UuY1Z2wjm0I/TVxnrXeLtrKDdWMjEGhKvB977efDkJlkfOm6qL6mZtCTe/UZenwsP1bBAaLA9+xSN96Ve6hoYXD2PSSxLRgIUiiKrJn3fQWNu1afz6MTTT6rwLcSLyWsMQ2Z/4XUofrm3eJIkWknBcXAoK6uP6Ho9uZ8JuS0edTv/G0v6JF/q/Op6SHduBE5m1has8hfd6P5mGezPKWXcNzQQWoD4DH2VTOZBVMXM8H/BsdD29ssextqgqAMgzzQ9pdSUy+J1+HL5WYCM0OHaM0Mg1J4+YTXfzOlo8PtIdCH5XQou4EI+xsW4FT2hg/y2RagUk/VVBNOhuS41SeblJCXBDDCHdf5EwEX8SDXabByXbWxIWHJB0/uIYic5O1nJgm27zbEdEWekHP+6hLHgu0J9uE4c+ILSyEv+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199015)(6486002)(6512007)(478600001)(186003)(26005)(6666004)(107886003)(71200400001)(6506007)(91956017)(66556008)(66946007)(2616005)(76116006)(66476007)(122000001)(110136005)(316002)(64756008)(8676002)(4326008)(54906003)(66446008)(36756003)(83380400001)(8936002)(41300700001)(1076003)(44832011)(2906002)(38070700005)(38100700002)(5660300002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?eNE94611SfCPvQjDya4tk7HYHXNIE4JpdABhldhSjowQGJHvyScyB6FlkN?=
 =?iso-8859-1?Q?Y4QyFQnZHf5JDN1VuaQOk0jIXNIgVgJZUBsZPSNwTade43Uw79sVhimcUb?=
 =?iso-8859-1?Q?Y8kC6eMlMq59Dkymis1BnyaxjXbrTElZnkvK9fvOPOXbxXZ5S0qvdMwSNe?=
 =?iso-8859-1?Q?mKT0YufDEhjsrK2BgplibN2xM3jFFcjuJdFThIC5pT822ItjKJ9ZaB+lrA?=
 =?iso-8859-1?Q?FiaY5WykKE/nCS3/E7e21ApqXn7e0VdABkxYbUlumFCpfY3o/z741t5ojM?=
 =?iso-8859-1?Q?6N1qCQamGMZIAgLn1rPS7APzniKKQocDsnhuniXnAsncD6naa0U2y0L8G2?=
 =?iso-8859-1?Q?vL2FqWDqDawLBMMGUGta/+VrPLUjDumyM1H+Y1QX9oRuHRJzPp//P2kpjc?=
 =?iso-8859-1?Q?Hc+XQRvrdQT3qRBRXukkfEdtlY6ez2sIHvtLal0MkUbWPhgXKtt65LW9LP?=
 =?iso-8859-1?Q?pBkqfysq5aAuD5wrmgeiHu0sjyG9VOcAXVLNbK7Z13psNOPzzkwnG6ct43?=
 =?iso-8859-1?Q?gI89cVO8YP5HXPxRZrJssCQ1kWe922l2V8ipTXLgE1bAh9uNl0AEve8MBb?=
 =?iso-8859-1?Q?HGDHjSkyxplKSsAsPNHx5DW/b1Cb2FrLEZq9cHkMdZtVT9SrxNtJueDrbX?=
 =?iso-8859-1?Q?nhcU00/6t6y6FxkgP1aC3IWCYIsTEd1SBmUHcOS5KfCEKkb3Bivnvbt54z?=
 =?iso-8859-1?Q?vNpN17x6uj3vvxIUCFKjiewSys0TJQhRi/GjrMQQVQu6flcGybtvvgFF0e?=
 =?iso-8859-1?Q?Y4SwN73f0Yutmuu1N/Ud7SRlpGK6Qq0e/Q8vmSq6/GGNSvx/FHpLWOSf2o?=
 =?iso-8859-1?Q?ZpwU4SE1SfL7sWkbCVM2VPQCz8Fz9qg+4343inZ7kYqYT0MnoXWkfiPrmA?=
 =?iso-8859-1?Q?9Ju9qyAQkYH0j20lkj5zialiOw1vOiD5pKnK+A5pFW2H295/kbXLYdw9fi?=
 =?iso-8859-1?Q?3c0FQu86a5pL8EON4W4nz+dkt0wn2+QBQU6QfVNEp5xtUPCBBlYoTPRHKu?=
 =?iso-8859-1?Q?pMHWaJFitmgmfhwD0SzzuabvGhCNJ82weNB8KKdqLBz1FAde6b/AFdEl4O?=
 =?iso-8859-1?Q?6VoH/orNcfNaIZwQ1d5rzGnxPmcE5vL6p0dmZRA9wkbkPN5lFY61jmEajj?=
 =?iso-8859-1?Q?jAJewcHgxgyPwl3d3Nj4YHBq5GCm08ma5LUYrzM2Cj/bdC/c2UE3ama80Y?=
 =?iso-8859-1?Q?SzWVocTG2IafSipSpQ8yg9a60ivLErxCdjyEyZ/GreJ+hTX62hlhx1NSYy?=
 =?iso-8859-1?Q?zrXWoymI+5u9ciAJ8xHP/MKYwy0fZu/3lGNZ2l9oS1BwEs42dIIcYgKo4I?=
 =?iso-8859-1?Q?mkDgWxFUkRuiNAl6Moj0q0zucfN/vpE40BCsY7yhusR5yJzhibTgd8xboR?=
 =?iso-8859-1?Q?KpdASH8FvtN5DMTGYl+wwkArLcpcRUpiaffZlB2CbgbJbYrn/0yfzliGWK?=
 =?iso-8859-1?Q?fdW9lrdrLlahXQ1wueKbXNxvGRPtnrOIiMjSLRBAK+ynbuItrjAHS3ndPU?=
 =?iso-8859-1?Q?hPPnqgrDRBrloqV7rwNZJTI0wMSpmMSkGTj9tIdZ3Dp33ndDxHna6z6eBI?=
 =?iso-8859-1?Q?k+01qqGK+gqWszmUusTdu68g6CaYhdEprb5U7oj1Exyf4RwJKj1lMGlZ0U?=
 =?iso-8859-1?Q?gMegzsNlfPaXGBQE0hMbMMxBwG1mgWshNsXMIgur3CSHTPq2ha/JuNnw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VdpXkpl5v5mHy8uW83Ysj5MVsJclH+P8mFo7cca2Dj8QjzCaAbD8GJdUYN+rWeW8YHv/7buxUv3ebqil3P4ADULown+rHZPmOaR/0qUJJP1JzmgyKWQZlfFk72cEOmTKq8ER6TDCjfa38+d6Z7K7qaV1Xdv5by0htKVNJpRTiE0M6F6myR8j3NNUtIHkt5Ju8ElGs9LNQKbZmCMlRn6onmJKoys7qA9QZBSufET/CBedXiQux2rsPp4lU5d6jmPTNpG7wU0lMNFoTybVH2pctmVVMtfTO13iNCQnOBVYOdwlf7hPZa86hhJcDwKO01suHEyhANQ9Qo8JvDFA61hY6BS7VZ/3AxMg71Fp0f1YEHEOb5XArgVYBrJeQc5Gpsh7lf0t1dPZbBwfCT8GD4RD9Gilwf6D0QYu6DKliUbha5KgSpJOd8+//eRC5wTbhLQIE5kF08Z7JnOptoPGEh/8eWf/cN9nACGc2vIuwCuqos8Wt5b/iMRbOT/fYl+scdHeYxvCDqR8j04TkzpLCwtDxffAeRlZpePyjV+DSOhoAoJBF07rwBO7cJ1vQ8a12RVZ9h1FE830NuUqi0u9R/55muRSghEJn5oX0809F6oWdIMNLVCu9uyLkOYX+rjoGYWUz34ShODfx5usFPT0ftf8N9b/ZVfznlXES7+X+OVkmoEfgCTqA42v/CP5d660WZ6aG1iz2NR6UOGVpSOZidMAd8TySkdZUqSjZ+RTN1mcgSLtJqkib27uYxNGMqvQTfcTlwGvmPCwcOsm4MNfUwki130o1S9c72lO7bd3PJsWHuaTmPkj7RzWTH0TS5u9oqm6+nhZKRyuKMOwJ0QoYxrt5F++dLMX5rD4jUACUWfdpG/dwjAdMEMDYScbWrMem2IzJm76Ext+0Se8lbHxX0vPMA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85850537-0d3a-402d-dfe9-08daf8336da0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:22.1558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3wkQ6gzAl9lCcEVVKnkphL1IATAdNvCXEviFNp10Zpb5cncjJk4rXkve3uE9Hpr/J8pCxl0lTSEmdOBoFB22Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4814
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170017
X-Proofpoint-GUID: M2-LJdTPPydlkPmkcCaiSQyHNluwXEIz
X-Proofpoint-ORIG-GUID: M2-LJdTPPydlkPmkcCaiSQyHNluwXEIz
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

Move the anon_vma setting & warn_no up the function.  This is done to
clear up the locking later.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 434020155f8a..90638fa48734 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -685,6 +685,14 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_a=
rea_struct *vma,
 	if (vma_iter_prealloc(vmi, vma))
 		return -ENOMEM;
=20
+	anon_vma =3D vma->anon_vma;
+	if (!anon_vma && adjust_next)
+		anon_vma =3D next->anon_vma;
+
+	if (anon_vma)
+		VM_WARN_ON(adjust_next && next->anon_vma &&
+			   anon_vma !=3D next->anon_vma);
+
 	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
 	if (file) {
 		mapping =3D file->f_mapping;
@@ -706,12 +714,7 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_a=
rea_struct *vma,
 		}
 	}
=20
-	anon_vma =3D vma->anon_vma;
-	if (!anon_vma && adjust_next)
-		anon_vma =3D next->anon_vma;
 	if (anon_vma) {
-		VM_WARN_ON(adjust_next && next->anon_vma &&
-			   anon_vma !=3D next->anon_vma);
 		anon_vma_lock_write(anon_vma);
 		anon_vma_interval_tree_pre_update_vma(vma);
 		if (adjust_next)
--=20
2.35.1
