Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F4D63C57D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236219AbiK2QqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236096AbiK2QpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:45:03 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA636456C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:44:44 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGPpWO012335;
        Tue, 29 Nov 2022 16:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=4KYrszjLtjYGDVaIj/ev9/wJZ/P7KwJvYJzh70J2uRk=;
 b=0v4ydw57MAZXT4eIpHhzpKdtdytFQBGR6Y8trjR931xG3jzEnI+SqA/Xsa0MaORYIjR6
 CflGOUC7PZ3Rdc/NwNg74MyHGt87WH/UrkiAFtSja6FekPDKx72ilJQJhaSBAx8glLsE
 N9NZu2aIbZXCfyOs427KOquM3lSFZCH2M/E+pGx2g4KtGHuPgUP3fgyxdAEc0gwSsq5R
 sfTa+8U1WKiZZCi0tGl5GXPSouyYsls1ZfwIJ3LWdZ7/Io/v9yQGl7MO3EYAAdxC9AyY
 zcgflBeBbfWWZ8i4AQqBdt+bWYfR4TklZ7It+bpAwTjwOIHl7KoSp40xADZRgmmJvGvM Hg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m4aemdn8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:29 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATFhsPa027963;
        Tue, 29 Nov 2022 16:44:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m3987f2au-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFMCwxt2eoTQiPjPQ2bEX88FKDvEzBbyRRTpRO4tfp6uytdzl9BgfuELV3y5eAb5s63Yjb1Rm+7dtq/RFpU4pKhzxPOdIVnxjGzG40ElGNi8Sav1mjdYj9OOCRXOx7yzvEjRKtadqtYw9kEDufP0jDA9F4cIjMeS3LWK6rE8KUj/Jdi6lDGtJu7rN+EVwHidgVVuUCeTW048S+sKXOfp8fBraCRaUDjg3PNAXZCnQO5LBeChkZ40NIAo4XzD4wBMEOEtmgppG5k94y7EJFzIUes49B6laXgwiT3+toDKGngeNK5jakMMUaNRahV3/XkwbroXH+AMwqgwp0KU2L52Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KYrszjLtjYGDVaIj/ev9/wJZ/P7KwJvYJzh70J2uRk=;
 b=TwNGcoOUMle3Jce+kSBwiRmCN3jo/9usqw0UZSVqjYvjTgv0jo1J9FErhP8Gsja+WTlW53BoLQTu1aVmo9HdVvqpvo56NtzIKO8y2UyIJbdxb/7jRRCc4H9jt0fLcWH3lg3O3Y7HYQ/2iki973y/Dj0BvFeiZQWU/pYKkF5wX/ukDM5Q8NB/ZcRDeFrc3Q3++7Xr5ji1p23E2EL3AVNyO0RJU8HNeE7S+3TLZy3Nl6Hc/HtjgI4EfdKpW1LqensyIXQf76vasGPBKkEs0dMpgVoRI6a7WqW1+I1/U/OQvstJBkwX2AcBrvRZBbt4+KWMc2xjdIW1lYPUvcuJat3x2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KYrszjLtjYGDVaIj/ev9/wJZ/P7KwJvYJzh70J2uRk=;
 b=ar7mQGmGWGGnOe8GE7xPkrDysNDrM+BoAQUPkJWDHI2Anb4M11gBZywAftifhPZAobsGXeKyYqv7ea2dxbX8xF3LH0BYh1QWte2v0kBvkFnJSB9rvD3He0NA4WuJa4z41GNaCQ8M0xV3SdLQp3sdWnkdbdoPIytZ7diMfHiRy9Y=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5788.namprd10.prod.outlook.com (2603:10b6:a03:3df::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Tue, 29 Nov
 2022 16:44:26 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:44:26 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 12/43] mm: Add temporary vma iterator versions of vma_merge(),
 split_vma(), and __split_vma()
Thread-Topic: [PATCH 12/43] mm: Add temporary vma iterator versions of
 vma_merge(), split_vma(), and __split_vma()
Thread-Index: AQHZBBHXlbmXtJJ19E6sVmDSed5CUw==
Date:   Tue, 29 Nov 2022 16:44:25 +0000
Message-ID: <20221129164352.3374638-13-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SJ0PR10MB5788:EE_
x-ms-office365-filtering-correlation-id: 3541ee93-2d73-4ce6-2471-08dad228fa42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9i9SSudI0is5pQymK+2o0wIKBVrPROQo/t9AxNR4Iakq9S2vI8v0gMa//G4XPpY/PttlKkjtEOkYlyyQF2WRVNBN68eNYLFqGA6ZoSxiffOwmibrbtF0Avi1N92V3jUUFzFOPbudOhXBtJ+tyAOGU8YtejuRUK1IBvQzOUzDbUlcmhzPDtDj8z6qs57EyZAvsCe1ay+0kLKyzv8Deqr99LUbOzIqQKnARcZt5cmCsuYKvNIymu+3GXPv30ctghzBIwt/eZwpNA1EN2TDFKGh7pDgSIpm1w93g1nXJrE2T45vRYFiaA8xcmjbauRyOYNharQd3apDhJa9XWbmEA3pISFhIMIQA/EURTnZCNdGOfKWE9Dw1XfiN5s4iDjFK1+lRLOcXxrsHB0DtAyjMt43ixqweoSl4ETAd+Pzn2eIQ2khO+3kYoUizMODbkDOP8eO1Yj8U50E/W/g7/U5MFXEAz8kLfh4K+JpCsQ3bDyq+HQn41uSM1LKpsl+2Mw50HnmZ0mgJ/wV5cpl/nt4RMH2lmamgm3pg6Y9dEQDC9/1Kzjtk08gR+RMThpiC6Ra13H7pmutDpMH5NU/ZL0TVyorGy7rNC6jIinvdMIgqVJIRDquTUPKq8rbL8eg+bFzYEjxu9ydYB/T5zZfaH5cN1DO3T/7w5KPmE+XGVhCumHTUy16qxbHLB/YBFkgvFWLpDILEhihmzX9cPSu27x7EnETCw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199015)(2906002)(44832011)(41300700001)(76116006)(5660300002)(36756003)(54906003)(316002)(66446008)(110136005)(6486002)(91956017)(66946007)(71200400001)(4326008)(64756008)(8676002)(66556008)(8936002)(66476007)(6512007)(6506007)(26005)(2616005)(107886003)(186003)(1076003)(478600001)(38100700002)(83380400001)(38070700005)(122000001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SS6WM3k0nmV7wiQGTBGzTewdRjYOB5dT+lBZ33zp2Jkj6Jd7rzzeZqs5MR?=
 =?iso-8859-1?Q?CqqZJk559M0rOM6oojiNRqBskODsd2bd+v/uSow/Us0yYPPJF60RoUCkX4?=
 =?iso-8859-1?Q?IUvY07I1HnTS3bYDSPSoweJDnlCl/gJrg5UWjcUqMkj4Mxt45slDgyd/F/?=
 =?iso-8859-1?Q?TtKZVkl4KjlKR0Knju2bgEh6DpjTQqjSfg4H0EI5l36LJc+5VZxv3IAsoG?=
 =?iso-8859-1?Q?4/cVUreRV259cHSFpd4Nh6rT0CyfSZPnDQUuyHJkUn/91Ab4srG+HbHKKi?=
 =?iso-8859-1?Q?gK2RUoHCg86XmkSq05iwfh8HnybkdmsXFyf0BY172+J4RT3mNwB1Y6c3o+?=
 =?iso-8859-1?Q?DZD1lXGGskG3lkLiB3s15cJTkXzjOLmbpujqpVVdVsQfCmTTdd4vMjmGsF?=
 =?iso-8859-1?Q?EwSzjviRJaxyowpStrP3w//9ExJ++8d4OzU2wjBDcbDKBBwilg5gfiaJ+9?=
 =?iso-8859-1?Q?ezRcjfA9xHSPBPrMEmBxLLj74XcoN4MoyVTB8GUEpCxmuKbBqbnS4uKxFr?=
 =?iso-8859-1?Q?pD4tW8y769WnBuYDE0C6umvLP2xK8sfrSEFJwLS3FaJ8hZ+NSOI+KfTcei?=
 =?iso-8859-1?Q?Dl2MUXpYpWUkMGNtlJKcl0xSYTOGlo8OP8wnudOxSMs6edXYEP7ZJHW/85?=
 =?iso-8859-1?Q?1iZARm94EIRSdU0PKqIFAeEqhvKgHk7eKqPkHP6qWm0mgccfqp0cqlrJhI?=
 =?iso-8859-1?Q?6jqUi0gypnRlxDfw5wF1ptX0Q82oMvkTp3abDsB/Dln7KN8KjFvzfNiY9B?=
 =?iso-8859-1?Q?4QEZbaKhRKA1lYegSuZaTpAnps4tte++7T3EXuSDBPV9RgWtXHqkI5bVoS?=
 =?iso-8859-1?Q?ANjhzam1YYLYk3K1nZSqrg0VuHV7xMTqt+9lH35XjG7VT4x2b1bhkqPzYM?=
 =?iso-8859-1?Q?Ssu1CTf7B0M8C0fhGURHhIysOxI2PTT/5BshVxcJQFRG3pdhW2DKWMM1aU?=
 =?iso-8859-1?Q?tNMPsTC8rtj4cVCtdP4yapVtNe32andNjBZrUZXanEbfx/pI7MEDff8h3g?=
 =?iso-8859-1?Q?hE3IIP0Z3kx3IVaW2bkBHPT5gyOUSLZgx1KVLHxbYJ71sZzTBSvwWF94Wt?=
 =?iso-8859-1?Q?i5zJC2ywIpD8ZQl0QLZf36SEzNOH12fyPirGBsRIYdF8KMQDdJmcHi7qyb?=
 =?iso-8859-1?Q?PnvP5/dA2tviXr/Api6QrOhoIn6mjeRVC1NQRXZzpFgICSeEBi+jDiog1w?=
 =?iso-8859-1?Q?qX/UkrFMTu+m2PhMy9ullcOckP0YkY695Pvk/pPkvvJobyVi793FmMEj3p?=
 =?iso-8859-1?Q?0fSKrrok9XZOJKGD/yKfM80vzIPCMjpl+DjDR5IfLU9ZkzsQAschrDvqB2?=
 =?iso-8859-1?Q?DxsbXyDUNQanws+SxHN2QB+GWE+p+lPsuEhk3L7u0tBPpdTnXTEqcNGADp?=
 =?iso-8859-1?Q?sI9jyPwBjqJoGecEeRMZPmwkCKNkfn9la77AKG+8bz3jkuvz4IzuUFzJAF?=
 =?iso-8859-1?Q?FQWqsu6AP3o55Hw+zqhr0cE/JcEkQwzVdzH14WT57nb8iV0ZtEEvi3dArV?=
 =?iso-8859-1?Q?ULhWJo33Unjgz91eKAy3K2trjs5W/3OqLMmi9Tu53TNuAxR7GebJK+frOB?=
 =?iso-8859-1?Q?do4hRW1H3zrBlETgvkjjjhvlE1UAJnS+xtvvK0ieN0tbt9zb/4Qc0VGv4r?=
 =?iso-8859-1?Q?VHTt/fRljgh4gTU9r3MqAMzpMDol7xrmz0rDDol8CruB4WZd+qoBI2tA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: C1aLVgFRkGult9xXeJdeRijiQcFp0tj0vZSlrbhp7yFRtmHfwpe3Jl8BYmW7pDCT+6VGdjliVFP4CjbjGdjJGqqOI33u7Ix6kYZAUG0z/DluYpH7eS+nzGmGbtdmEKwTrGJlEHw3vFcXVMuaI5mszM7swpUf9PfqflFvjxp/bHmBOrU5CPtsJKgUtXFN1F5nks8qEFtQgjYzdwQCsTkeUR4sgXXnKGuNjnUbyrfTb8/9fYuLcm9WvVLZ/7U5G05QHEfq3vYyeGLLfNQYZhx0JRDri/cW4pOPrHn4OdrTzTYvxediZOUSLU6dL9/22Nj3KwnCrbL0ha4aTFLTngWMrFRzwJVUR4tBzJ76Xv4nLhpko+YWG81JTlGQOIUbjBR7wmt4DwmqEfaEpfsm8aukSzPTb8Gjls5yD51O7F/xzyAJvQyQacuADnMWg6gTy1CKjDroT/uML1VkUQqF2Tek7d2/Tfp46PiTOdxM0XtQiJna8o8J5Fmvy3WKWSxJWDkILEnKgx487U6oGUgftM0ozHq9vHKrlXkrDSpWtZeVi9A809WCBAM4/Td2qi5vlipeC/nkDYa0Axm1tPUxgxPfLHPeDm+wZLgBAXgkkOrPveIkm/Ceee0UqWGuOJBJ6kKN7VuAzoG+clqBczRqAmCdElnUL7evIi8/Dq8aX+oNK8DigbgpMzEzKPk6kPpQDuNwmfDM43vRqFMUnXOfYv9/AlRHtp+T5tUTKA4I3nBut0fR710xA2gKoCjyjGgBNeBq6T5MX8+yAi5FAS6aMbqYj9RtU6pI6TnowbtD7Uvb9ch5sR1V1IpIVmPNndJP914hUh8e+C19AWrUY39MfYvE/WqU1Ftuj8v3JjskhxtyXhh+7IU+N8e/sLFv17oVng6TaizNC+xjteSFcmWc7e7rvg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3541ee93-2d73-4ce6-2471-08dad228fa42
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:25.3167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 75vRUM8rmkQcN5JcPSihe6ofV9YJL2Gp9H+mcDt7haWwJCZrKO2G00JyiHevnIq2IFSriHSlsVIhPjtGSHRNRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5788
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290093
X-Proofpoint-ORIG-GUID: owIuw2BqaySaaUwO1CeCbZoHTq2FIfX1
X-Proofpoint-GUID: owIuw2BqaySaaUwO1CeCbZoHTq2FIfX1
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

These wrappers are short-lived in this patch set so that each user can
be converted on its own.  In the end, these functions are renamed in one
commit.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/mm.h | 11 +++++++++--
 mm/mmap.c          | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c347509c5f9b..b9a6599f98b9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2704,11 +2704,18 @@ extern struct vm_area_struct *vma_merge(struct mm_s=
truct *,
 	struct vm_area_struct *prev, unsigned long addr, unsigned long end,
 	unsigned long vm_flags, struct anon_vma *, struct file *, pgoff_t,
 	struct mempolicy *, struct vm_userfaultfd_ctx, struct anon_vma_name *);
+extern struct vm_area_struct *vmi_vma_merge(struct vma_iterator *vmi,
+	struct mm_struct *, struct vm_area_struct *prev, unsigned long addr,
+	unsigned long end, unsigned long vm_flags, struct anon_vma *,
+	struct file *, pgoff_t, struct mempolicy *, struct vm_userfaultfd_ctx,
+	struct anon_vma_name *);
 extern struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *);
-extern int __split_vma(struct mm_struct *, struct vm_area_struct *,
-	unsigned long addr, int new_below);
+extern int vmi__split_vma(struct vma_iterator *vmi, struct mm_struct *,
+	struct vm_area_struct *, unsigned long addr, int new_below);
 extern int split_vma(struct mm_struct *, struct vm_area_struct *,
 	unsigned long addr, int new_below);
+extern int vmi_split_vma(struct vma_iterator *vmi, struct mm_struct *,
+		struct vm_area_struct *, unsigned long addr, int new_below);
 extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
 extern void unlink_file_vma(struct vm_area_struct *);
 extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
diff --git a/mm/mmap.c b/mm/mmap.c
index fb9dd634b1ba..4102cb0c2793 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1148,6 +1148,25 @@ struct vm_area_struct *vma_merge(struct mm_struct *m=
m,
 	return res;
 }
=20
+struct vm_area_struct *vmi_vma_merge(struct vma_iterator *vmi,
+			struct mm_struct *mm,
+			struct vm_area_struct *prev, unsigned long addr,
+			unsigned long end, unsigned long vm_flags,
+			struct anon_vma *anon_vma, struct file *file,
+			pgoff_t pgoff, struct mempolicy *policy,
+			struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
+			struct anon_vma_name *anon_name)
+{
+	struct vm_area_struct *tmp;
+
+	tmp =3D vma_merge(mm, prev, addr, end, vm_flags, anon_vma, file, pgoff,
+			policy, vm_userfaultfd_ctx, anon_name);
+	if (tmp)
+		vma_iter_set(vmi, end);
+
+	return tmp;
+}
+
 /*
  * Rough compatibility check to quickly see if it's even worth looking
  * at sharing an anon_vma.
@@ -2332,6 +2351,18 @@ int __split_vma(struct mm_struct *mm, struct vm_area=
_struct *vma,
 	validate_mm_mt(mm);
 	return err;
 }
+int vmi__split_vma(struct vma_iterator *vmi, struct mm_struct *mm,
+		   struct vm_area_struct *vma, unsigned long addr, int new_below)
+{
+	int ret;
+	unsigned long end =3D vma->vm_end;
+
+	ret =3D __split_vma(mm, vma, addr, new_below);
+	if (!ret)
+		vma_iter_set(vmi, end);
+
+	return ret;
+}
=20
 /*
  * Split a vma into two pieces at address 'addr', a new vma is allocated
@@ -2346,6 +2377,19 @@ int split_vma(struct mm_struct *mm, struct vm_area_s=
truct *vma,
 	return __split_vma(mm, vma, addr, new_below);
 }
=20
+int vmi_split_vma(struct vma_iterator *vmi, struct mm_struct *mm,
+		  struct vm_area_struct *vma, unsigned long addr, int new_below)
+{
+	int ret;
+	unsigned long end =3D vma->vm_end;
+
+	ret =3D split_vma(mm, vma, addr, new_below);
+	if (!ret)
+		vma_iter_set(vmi, end);
+
+	return ret;
+}
+
 static inline int munmap_sidetree(struct vm_area_struct *vma,
 				   struct ma_state *mas_detach)
 {
--=20
2.35.1
