Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEA866D47C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbjAQCk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235651AbjAQCjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:39:17 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDAD303C6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:36:09 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H090kW000925;
        Tue, 17 Jan 2023 02:35:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=JE6JJsioIejGfUq6QEH/2FIiMabN2ardWqOGSX5DBiU=;
 b=WOYYo9M+QI/fsIThVDX0L9I94Wurf1smRc8rBRQwfoU391JNGux/YweA9S4swVVWd2Af
 dwYXHTRcr5BOdXd1GBOsHDWaNIJbz+nFBV/2VTN1ey3eN1N60s+aglvoxhvqGyQZI+Sr
 3Tudp0/Hfb1NfFmzmoTF22zNz3Q0z3sMKU79EUso6oiz6V8fRtkUAGyOycnxDZJGfhVZ
 QoTd8V1CR/f0jRDVFV2iXZ/ybm2Jr2KeZH4cjgRs0HN/xmk+pkYjYj/cwU1g0KJSW1Hf
 yzEYygkzl/6fdnRL4B73NH/KykUGv+NnpDT7YeOHJsq50Mb2IiCX+hXlgTwCUeJr5V+m zQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3medbqc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:35:00 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GNCpCV004918;
        Tue, 17 Jan 2023 02:35:00 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4qyy10ss-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/kEzS+PdlZlldDJuBQEgWOuXevcgcrWBWVxjQ3yKAwB5c9xziTkckVNE1O4Nm34HIf6kYs3Gw0dTEOElxp3V2EaDOynCf5vCi6nRYN/8lfVI2kIUZd0abkmA4a3CNzfXIa1rmRjXs4HAt3fhXSCX0gcH0bOtv830yaShUNvInKlZzLJcWlXrgqBuXnXkqbH/EDoHjCeBlr9RZVfYeILqyDHHsN7IIIheRVwE5Gw10VGXZYHq43UbsG22jStshRvftgMdz83ygHsWeIzCyXhc9+GJZkzjj9OJ5LwS3pzfu3VFi5Eol2yTXej6O8YYMDntSLt833kFYcDE0uXvY1QnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JE6JJsioIejGfUq6QEH/2FIiMabN2ardWqOGSX5DBiU=;
 b=isrcAIVGpMqJCz1SKmudD8R7f9Jp/L7zl8mnq4t0qAdO+ErTpA93U+UnjuZloA6A3JZWD7FBFGNqZ2oEZDhzYU7fuUIj3ABjXKeUQZ0m1rinpCnOQ2oHS9pRae/ahZWQzH89qJ58jKcoIhDl93xBZieZ386FLGMm9okLPo0Pg9jCK+XiEKUQ85LiM70m4noiAQYLthaEkmcy6q968zMktRlWK1O441uo2d3xs3lBujWUGZVX1ifd736D8bSdIkmScofnyJKRaS7qWjW15tmGzFxU45osF2tHPpFyxTawSIJiy3ZsULspztlpUj90sb/SPOAc085MQ0nnWxWDYUOwvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JE6JJsioIejGfUq6QEH/2FIiMabN2ardWqOGSX5DBiU=;
 b=UDfGoLB1D7L6U43pIxLtbK9Zt5SzXYVfhFL8p8Kcn6OWKqdgkwoEcosDEi8MiDOd6ajI2vJ8k99bv/5viAzVVfQwzdDjfXOYnNMWiYIXpH1LBQxmK5SF0GZjyS1WAsyfz3rW+9+WRviCvNC3r012Jl6k+V0Ip0JYtGWeXuGXSIs=
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
        Li Zetao <lizetao1@huawei.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 37/48] mmap: Clean up mmap_region() unrolling
Thread-Topic: [PATCH v3 37/48] mmap: Clean up mmap_region() unrolling
Thread-Index: AQHZKhw0q455l2QlfUe6spyRGlMLCQ==
Date:   Tue, 17 Jan 2023 02:34:21 +0000
Message-ID: <20230117023335.1690727-38-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CO6PR10MB5538:EE_
x-ms-office365-filtering-correlation-id: 8f17b27a-8181-4d84-8773-08daf8336d03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LutSPertEmldCmxJr2/Kx6zpyBff6LdG6Oje38f3R8bWTq1sQjONJzWOwQWm+mPXPBJM+VuOXMwSFOA9Tdsqt82j1/dp8KRUIcXaCY89T3ip3+ddBB6qTQohbvpeQ4AzteIxpjh2TXnPTpqFJs7bMvSPY1027hsHwiClofkQlQCB17W/SKH13F76lXrGTb0SA5Yi8ey7l3SDUxspjguC0qwAnRTil/2Zil+DnhkzOI+P9L3u3gFLzJSE6F2ghpW9MnxAsoVH8/hpxU0wF+MSHvKYNGqfcrxuGurLvYRuyNZulyr1yCBlxPyxS519XW7f2VpHomqaPGaS9045hZhryx/zFGiLIA1yZHuHdD5/l6xZiONg2SlcZpuGirA5CRPajVDNoWuCXAqpFNdWZFApizWFAWfdB45HaIx6CJX6VzMozhso34rZh4nbAmtf1nbbMDWr5HSjRhU/a864vbxrIzhaGYRzDHB+KRHyc1nqJrV7YZjrY4idT1fQKsiKjE1g5YXj9Ig3ZEStgzHy5JqDOVlxqqWdOONGtXZ3rMU3ilxIPJRJiugr08YR5FmRrbR+GUyo/GicBFWIr2MjgbQPdOrFJtSgZvRFwieFuCBfusV5OiiPSgB2Ue6WtjPKJP/h7EOpWg3COvw/1pBaR8qTKBNuffwC+tmSwTNU4qs/S8tUH4kq979dtnwneG14nSH6Sr5d31wKgSJ1UMY2GoCEKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199015)(36756003)(91956017)(86362001)(8676002)(6512007)(64756008)(4326008)(186003)(76116006)(66946007)(66556008)(41300700001)(2616005)(66446008)(26005)(66476007)(316002)(71200400001)(478600001)(6666004)(38070700005)(6506007)(54906003)(110136005)(107886003)(6486002)(44832011)(122000001)(38100700002)(2906002)(5660300002)(83380400001)(8936002)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XT4M8h7iOQ9Yjyga3hG3DsxvYjjKpQt5A53CQpktH+WYly2z8mb4B/Hnnr?=
 =?iso-8859-1?Q?gvA3bmOybv1DYdfn1G+UtqLKCrnVvpHRKkipRFExXXOU/8SF8i24XOpt9J?=
 =?iso-8859-1?Q?EKqOXjWYz63A4Yk8vk661EFRSVsGwLCVhBOv8kTw+uOaej25j+0Hy3m2IS?=
 =?iso-8859-1?Q?HRVoYueDGJyTzgVmJlEQePbn/lZD0gYIEFKqkFXnxxZHoeh1Qqc36w6SB7?=
 =?iso-8859-1?Q?eavsnEGEQnrtZR3lFiCMido3gBhuPJynbP0XE738HrqxG4XZVJCB+B7U0V?=
 =?iso-8859-1?Q?9glDMFsrKl3dm6XqrR373W65InjKYEEBrrqYZZ+shXTteEGlX2RP0dRpYH?=
 =?iso-8859-1?Q?8Uzk1DP52k6HkB/aWGlNC3m8ZPdYWgAfF/240cTZUnpoobDKvqi3ztdKOd?=
 =?iso-8859-1?Q?QX5HVMyAdBb/YGySKUDm/F0sW3wYszC3G+9OmeD20UO4iXk6QLe6qQ98y2?=
 =?iso-8859-1?Q?ECV5oxJiwxcWZiV9ikVayy2BvmZ8LtX1kPPQjrM9ehqNpxc+iaCRUSwruJ?=
 =?iso-8859-1?Q?uNi3970wRgOHsIGB1F6L4JmSg6ibseTMGlBmSZTKFfV+knYj3Hvdfft4tb?=
 =?iso-8859-1?Q?B2klZEgvGsyMrs4gU3qATQ9Y4KqA79CnCMD8rwfQgJMUaLt1SJjJli9Mra?=
 =?iso-8859-1?Q?GLczKca/ome3BJDEQUayhmOl1SB3CwMhDvRJv6SygEVUUeGEJ0bkakd8NU?=
 =?iso-8859-1?Q?p3VYDZ75Oz+omE9qfMIzOgNhdvcfccKZMN25iHUwt+EdtWdvGavnrhi7Nu?=
 =?iso-8859-1?Q?GZ4ukHUp6u+163XNfoUzQTUgUff0n1vAVnbC8R6hgo+8z0ZeIM17jpIJlz?=
 =?iso-8859-1?Q?zIK6Z/OK2V5aWyT3hamI14xxOtzENTXL2krSWtTjg+2a+7g0hlv+ioqqTk?=
 =?iso-8859-1?Q?MBSf0GwAViRCBXHr/5sAB/2yU/+Jqak2g+GAW7M2vHcmsmNB6Vo+90j1TZ?=
 =?iso-8859-1?Q?QBuYnDsivlAzFpCxYV4Kit7CsCzTJ3oCq+laE5BujfvyDKSHU6tEpZ/0SM?=
 =?iso-8859-1?Q?CVwk/J1Ts48TpEtk2H+LRM19vJCLzvfELcOx1ul6NEIQ/F+hvDUlmd7bwk?=
 =?iso-8859-1?Q?ba6AAZ+Z3qZPyAOlb4pRPUHf9IYCjyLsFJ9mvNPDmv/UWvIwcX8DHCSlXV?=
 =?iso-8859-1?Q?8bruphuGqBxa8ZalSEx0zZUF1kNs71MhHzG44EJAW7jdVwhsOnuM7pCpr+?=
 =?iso-8859-1?Q?99ad4BF5gRXLUXBOWO72TQjeFOp9ggrO+1dK8xgNyOiJG5UaE9aiGpILIg?=
 =?iso-8859-1?Q?pVGUParF0JJDjiHfcElc3rACDex4UWHF9fxUF66+/PBXV+dqUa+0FNKOyI?=
 =?iso-8859-1?Q?8j6fQ4BcaJKzc8c4SFpeHbF8bYiL+JU8qpO9BS1qx5tPi4x4hwStSR5dV5?=
 =?iso-8859-1?Q?dPXwkniIOUo1jfqMcn9zFsn2wOTyhfny5vGHglYm1UyqZffgiX75pAyZM5?=
 =?iso-8859-1?Q?nOcz4Ri0EYCGgjQ+23h56zqomHZZQK+pYDgPzBgkaFpk4QUksFcqyQEuF/?=
 =?iso-8859-1?Q?CCfFrh8/sFzAkW55/9xityEemJWYptwvc9hYmz2jA2IG37UDupRDmY312M?=
 =?iso-8859-1?Q?e0XysVpZyDQt9dUvCbWXA8Iqh/U8U/fDggpqgvwBqnSTX9Q7QXEIPJlYFm?=
 =?iso-8859-1?Q?MpNGz8dujc+PEJwkQXiMIL55vbB9Gxolr8HTup6HCXVPHN8sOzbGbgdg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QXbsOMK+rT0iaU25xvFwiRI50JLvEiggdBRH7IZQXGusxNQOFHizaWrxOOBppSTGVFVaJWkawAW+KsSG4ys2r06Zmdts5fS3aC9e/qyk8+XaW6GzAlWvqwELv3tg/7uoIZmdgnwHJsb2HIr1VWKFx1w07V0/TQi+snyjjz0fC9TCjKi5N1kjx5MMOdtF9OjPMSUTKJyhqNKtMyenkQuo0aqnCUFSYZ7s7GQGUcwzNTAbk95hycdta0QBs/vw964Bid57Yfe5fHgMGrHuXCYoXj1FD7dASWFKa73ScJqv6yj15oejFtugvAhMvNj4zeqTKM+FxHdqoHSr4vCj+WMUvEe/c1N5LhlYgDFjC4VWKPwqjKT2WgIHD598Sdf66+LEwWdgnWk1nC+fNbwzaVmKksJB29bSt3g6NtJAaSndc/5/xnUbaCm4qFAup9bwciv+ucj6lljzu/jw2RmeT62vuGOlRt+EOP1rtEFX5/GDssT90aDd7GcA1Obs+cW33PsHhFpsR/cYhuStY24BJsM05+77C0/P/JjIrCoOA8T2JMCIEt3DJ+7T5KLq6ulYl5Yak13l6tHnxMtsumteFS61v51EpC+xc8/X28FUZTkEP1+6gaqfHTEUyWGmMCLBkGOdhRA2Ax6bcwnBPiHL/ggA8WaN1hhEXDDjCI0UtB6suOSAt7hVeSMYEhDPnZQVOm+iuq8jXzs6l2/i21eKwXoIYy8DJllY07AERAZ7X96qnd7mQn9CqMAkCpwKTdcKnifjagS7GJJXlV1o9wdrGpuBdKKzblhy4BspiOVgnIk3anBOwC40xTAsKFTChiu4OHmOPINe93rmIG6Otf/WMG3IQspQQbDY2fqsxQB8p0nXUpe0ApCR0v4ajTwo6PCWSTGdsd5c7uwmGtodXcrEQ+wO6IeVv7AiRZcLm8WLWucMqMw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f17b27a-8181-4d84-8773-08daf8336d03
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:21.5933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n7U1f8uH7sOjQunGKk739sNUFe3b0nQa8dw/YeP9oKAUhvD6iiUx7O3SPq5Oi6Q723SvuUro9yD2yBl6XZx+9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5538
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=817
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170017
X-Proofpoint-ORIG-GUID: ifZvY2NmfJP81WlNv_RgYcexDVvvLJNF
X-Proofpoint-GUID: ifZvY2NmfJP81WlNv_RgYcexDVvvLJNF
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

Move logic of unrolling to the error path as apposed to duplicating it
within the function body.  This reduces the potential of missing an
update to one path when making changes.

Cc: Li Zetao <lizetao1@huawei.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 45 ++++++++++++++++++---------------------------
 1 file changed, 18 insertions(+), 27 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index cc53f638187b..01988db478e1 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2600,12 +2600,11 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 		 * Expansion is handled above, merging is handled below.
 		 * Drivers should not alter the address of the VMA.
 		 */
-		if (WARN_ON((addr !=3D vma->vm_start))) {
-			error =3D -EINVAL;
+		error =3D -EINVAL;
+		if (WARN_ON((addr !=3D vma->vm_start)))
 			goto close_and_free_vma;
-		}
-		vma_iter_set(&vmi, addr);
=20
+		vma_iter_set(&vmi, addr);
 		/*
 		 * If vm_flags changed after call_mmap(), we should try merge
 		 * vma again as we may succeed this time.
@@ -2642,25 +2641,13 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 	}
=20
 	/* Allow architectures to sanity-check the vm_flags */
-	if (!arch_validate_flags(vma->vm_flags)) {
-		error =3D -EINVAL;
-		if (file)
-			goto close_and_free_vma;
-		else if (vma->vm_file)
-			goto unmap_and_free_vma;
-		else
-			goto free_vma;
-	}
+	error =3D -EINVAL;
+	if (!arch_validate_flags(vma->vm_flags))
+		goto close_and_free_vma;
=20
-	if (vma_iter_prealloc(&vmi, vma)) {
-		error =3D -ENOMEM;
-		if (file)
-			goto close_and_free_vma;
-		else if (vma->vm_file)
-			goto unmap_and_free_vma;
-		else
-			goto free_vma;
-	}
+	error =3D -ENOMEM;
+	if (vma_iter_prealloc(&vmi, vma))
+		goto close_and_free_vma;
=20
 	if (vma->vm_file)
 		i_mmap_lock_write(vma->vm_file->f_mapping);
@@ -2719,14 +2706,18 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 	return addr;
=20
 close_and_free_vma:
-	if (vma->vm_ops && vma->vm_ops->close)
+	if (file && vma->vm_ops && vma->vm_ops->close)
 		vma->vm_ops->close(vma);
+
+	if (file || vma->vm_file) {
 unmap_and_free_vma:
-	fput(vma->vm_file);
-	vma->vm_file =3D NULL;
+		fput(vma->vm_file);
+		vma->vm_file =3D NULL;
=20
-	/* Undo any partial mapping done by a device driver. */
-	unmap_region(mm, &mm->mm_mt, vma, prev, next, vma->vm_start, vma->vm_end)=
;
+		/* Undo any partial mapping done by a device driver. */
+		unmap_region(mm, &mm->mm_mt, vma, prev, next, vma->vm_start,
+			     vma->vm_end);
+	}
 	if (file && (vm_flags & VM_SHARED))
 		mapping_unmap_writable(file->f_mapping);
 free_vma:
--=20
2.35.1
