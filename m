Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D2E65F442
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbjAETST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235353AbjAETQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:16:36 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F300F594
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:16:20 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305IT3O4020928;
        Thu, 5 Jan 2023 19:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=GDIZnvT3c4nLUKTNTDe4tm/qdLfWeMn6rJBcSK7ia88=;
 b=xhRdThz+SIf0yKtCS8UhDwhpxu3azY93ZFTp452RTOacoVgwtba/uJSb3U8Sn5BDhiPW
 qAXH58CpJD3wpGGOHPSgxYo4z79nJobjuOl38Al/v3xsmZ7ZOxdyDhZrpYOVgUyQQv97
 hJSoHdNUHnpaJ9zjPAspANt20UyltYkn/pPFTm4KA6bKjrrGQ45Qt2f4N8ilBATkLJu5
 GcIyh9l8ODjPfjxdx67OeTun4dn9ewI9VNTV52qhCfbtuB/eIbRytNks8HfxdhD+cna7
 ZrOZuKYE52KYUa6CBwOz9mYWtfxn+OocQ+zsTW7OeIuwdLoofIEpg5Mwb+bBNHZTT5bd 4Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbgqsn9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:14 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305I086G033684;
        Thu, 5 Jan 2023 19:16:13 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwxkf7tkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TADdO3DosElFvo+KQ+cLaexMSr5Gc4XCdnKkoHh7hcxa7NIK6GdGE/U09fttkEFS3ARjzwhpNg7IDrBRlz55UWUqVL6qNjttdRvRUuRLjeLQWk5BDcJ1JsQqhOY/YS0y0uO0aVg+Fr8LJoUSZympWM20GPXKja5MrbP5fdr6V75M3gjZ/Y7KRy6088m6KdGvuO8F/f7HCY/+jYVgILB+AFN9D9pyzHxF2hVVGK7yOJIwctbgochAArzSH++Plct0TMascqIKCB+ymTRBu8daiG4m5XwUoYsh3MheyZLeIqUttgO2VKdnizgZK7ySj26K0s+CMXAuQy4yTXK9lHpJ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDIZnvT3c4nLUKTNTDe4tm/qdLfWeMn6rJBcSK7ia88=;
 b=OJvV40XqsYb3q6x1jtu9NaB9N0idljX4j1ktBeeCgVEVwNxBzDhfqA5L3EaF34CpYeCWHnEnoX9raYL+1lHe5vdXb01Dgr7DNF84UwJBqw1wh930b7c8Cy1a9ON1geOAAtdh+tCavBxGAFDAAAwkZdyQnICqF+cbeyDT12xbvO7DbacXZJCpJUgK1oNtDH0AqKOGDDCnlIjblgkwrxxUmf37fXT9y9sEF/a0Tf8T/2IXmUQ3MAGbtF/9nHMKeKQ9FMCqznsGqgr//fEwIHUeGKi86umPsWPC7RurYeAWf1C3uPQ+Lv+gcmJEA4AAibcDKh5/NMLF/8KLBUw3coQCdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDIZnvT3c4nLUKTNTDe4tm/qdLfWeMn6rJBcSK7ia88=;
 b=iHntBl/6e5aVkukz7+gjW0veIcWg3m0PKEEPjnOK0Und8jdPfTwuaAYZPVzITz5wEuCSUYTraGHONBJEq5AapgLb+6ZDe7tCNyTmnO9REleTVuxX3DgfNi3N0gde0aLRrOiFCQNT7YDZGhZ7gojfbo4WWTz6hJYEa7j/ghh9YAU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6075.namprd10.prod.outlook.com (2603:10b6:208:3ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:16:07 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:16:07 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 29/44] madvise: Use split_vma() instead of __split_vma()
Thread-Topic: [PATCH v2 29/44] madvise: Use split_vma() instead of
 __split_vma()
Thread-Index: AQHZITomYB/L2halsEKSYLbGEKNNRg==
Date:   Thu, 5 Jan 2023 19:16:01 +0000
Message-ID: <20230105191517.3099082-30-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|IA1PR10MB6075:EE_
x-ms-office365-filtering-correlation-id: b3fcbd74-24d3-4522-489a-08daef514be8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +1N8l6XtMQFGdoLtz9RavTs5zARoMGaLFAPPf5L2ZtK2PE6/hpL7RBXu8VdEScb3fjJ4Vu0+f/BFdYCF0Wki6vBYPIBvxf/7bwFRn07XDM71EN5dvIH1LkHKiWkEmgMF3C5blPauzWcNVTb/q4y25w9d5yXnTY4tQ/mZZ+0FVZ4XEhT+gbc0fZ1f5Y0CXRQyBAD3hq+TkYwFSDRcCW+EABBRNdRdTILfTS4+XhsrdgQ6l9SREwHWA8+9V1MFksLMWH0d4bZJa8PgpIoYX5D4+gxL8h6+WuRJe/r87veLcT4rnelG8TNj5gq4WyhoAsyvKjySZlpHllT7X9d+npK/tUN90AgcHdOqNuu1YSobW4D+EYhYyrk+ygevumFGZQL71FQv45S0mSP3PiWDgc6GiCEeEpyvHSAR4zN2k5W/yJfAUKG1x9W2vju+Jyg9boCMWKv/w0YqKNtkyFP4KhsUklYY/FSzlVNgOhOXtRIw+erCoFsXumxLbAyJIjyoccbO0IYAB8x6jqcI3Ia+WGcqMgMloWB5BgDYqAz0SzWnmOwktNXH44+NP4Uxj6pSKDxxv2NEw2vtwxs8o9SuL2D4PEMyfZGkDApwVQ8uzGkLHyYW8dBQ8xqdMF0U6JUiM1KGhO1bRlHL29OlAI26aPHzpk3UG/xBS2qfdBTpgMDjBrl23Nr8j55Z6ALsRd+J0yrMZ3kRSdBsaYASmRy0scbxMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199015)(38070700005)(122000001)(91956017)(86362001)(38100700002)(8936002)(4744005)(2906002)(71200400001)(83380400001)(316002)(66946007)(41300700001)(5660300002)(44832011)(64756008)(1076003)(66446008)(6666004)(4326008)(6506007)(107886003)(186003)(2616005)(6512007)(66476007)(478600001)(8676002)(26005)(76116006)(66556008)(110136005)(6486002)(54906003)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dNKp7y7lc4yORc1MRzXAvsOJeXJeEjSWCtd2rnKLvJis+VxeuihnXalpB1?=
 =?iso-8859-1?Q?gYozpKixf25wjiOsoUoQRm/ZWRLV+KdGSkNbbhv1d9mR64G2XhnP1oQ+MH?=
 =?iso-8859-1?Q?F6Y6GW136Tr2rDyFv3us6jHYCs+GvjoiTJ4LobY16S37OJ4ILZL6oBCKjB?=
 =?iso-8859-1?Q?tPJzyBL6O3eITC9okfIpqjGyK9amcJS0zggOYhNJK6BYb1mP4Q366U2Eta?=
 =?iso-8859-1?Q?41y/cmWQ65Zqoc06wxEMTgiInShO94fi/wXTnxOvdu3kMuxI4c7GeuL+qb?=
 =?iso-8859-1?Q?wqaYjQuIya659lsDTZ7Jr27xfPFJ4LmMeBeNZRZZ8uADI3l1PSKsl5pMEp?=
 =?iso-8859-1?Q?A2KC52YhxVz2q0bniOtkvtyPL0g15FMFNargpoEQuVZ4O3MzQhHxjLDVeJ?=
 =?iso-8859-1?Q?tyKSuxuiR99kHLrdyq1XVX4VDN/G0ZmE+aRFXyZ4PFbKPq2rov5Pi7rlFE?=
 =?iso-8859-1?Q?BU6DLIGvbKLSZKbMEJOnqDIpJBlORqQDHfhhmNcHAWUgLrOVWFllEQQxYt?=
 =?iso-8859-1?Q?9jXrWRo3zfoSWeFzsV6XLGWPMiljl9npnb5qqaGf2W1RA+SJU1FJz+hhwT?=
 =?iso-8859-1?Q?ZRm54xo5ulH+tKPfpE8BRChO+e5U/ejNGmTEpWhCuvJyp07gqZw80tsPDI?=
 =?iso-8859-1?Q?IW+1ZgV8JT4CUmPaFdBdpe2gL/W71Gu0w7n3a75qusUiH8TBrEi3Ya9lxn?=
 =?iso-8859-1?Q?7HOElAc4b+f/dB+tDWE54XD3sQlBXvq77VeqxM1WoAwpRWXQmnTTuW+SYj?=
 =?iso-8859-1?Q?pyzy4uu6TMzOg/hR+AAxn+T6ciXbvCgcw2tGRncSuW7srDDuUO4uDaFZqh?=
 =?iso-8859-1?Q?TDfju/RtPnEWtFmoWu/BEV6qRi7eHfcyknNPnDSkyG5WImh8CyDDeJ9TdW?=
 =?iso-8859-1?Q?K/XKpwZx8X5vHwCBs4f5wK06sFBnqVXceLa/YS3rO261Diq9p9wYf9xXkw?=
 =?iso-8859-1?Q?NutJO6AWD4Y+2xqCgjLbh20zN8iJmFMUgx+taYsxKwLtX0yy35ZOvzQbS7?=
 =?iso-8859-1?Q?6ie894mPqdm47o5Zd++uLq3slAi011L1TJyy//JXQts6lcHoahuoF9otWH?=
 =?iso-8859-1?Q?DOsWewz3t1oltYLnyw4rwz8koDXegs5ljMx4Qj4bXbB8yqSpreWDZSx47+?=
 =?iso-8859-1?Q?F3saCvy6CdfbOVyOStIKX5a+QNklDmieWLeyg+16OWJZzOk8F45UpbCnUb?=
 =?iso-8859-1?Q?xbFqtnp5813idKTDzs0L4bdvfGEL4W+ifSXudg9Xm7gGedVbTx88jLiDUu?=
 =?iso-8859-1?Q?R2t15BUCsxvQEN+Up/7Nh9TEXvCwxTtowPiDSOeRgY0JrLmk5UtOwF3cJD?=
 =?iso-8859-1?Q?MjXlM1KWmwvA1/ltuNf+G7/sfsRT5wjWHNvmk3tXnq9b/61AkYBziqKEMW?=
 =?iso-8859-1?Q?t30nrG8rPcaR2QOGLUnyMiBZ28HTdTiNe3+tafvgyQn+aQUtQU8tpYDwLl?=
 =?iso-8859-1?Q?2x/6W9ZoSxp2+4f/Rm923N/TwxxXsW7JbtwJTOjuC9bsug44HzJfdTRjH0?=
 =?iso-8859-1?Q?UbD3RtS3LlPwZjaUqolzwuj0uDC++wBjC9UugHQWfYHkmoj/jW186BYa6i?=
 =?iso-8859-1?Q?cy2s9Y4dJiWq3wZR4T5eNGWgJaiucIZ6cz5LGvrEWcMQzB2xrCSTbMbXCS?=
 =?iso-8859-1?Q?e6owGhoSE06cXwaYox3B3PC818PhTx0P3h9ln0ImDc0bgu4zv+0DkSAg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Gh6swMN1h0d6/lTEo085SVZPaL0vgTQw/EucL5fF6vcvcgjd/m7Zy0RWe6T571fEn7Aocv9ynT2/rp3P4fNng4pxYI1dweHH88pjX+DXnd2Gn2fO7AJ1mlKxXunGmmUXYuIw1k2vPRBhkGk+MvqlDmAhumo4N3uVMAl5PvtSv61F/CecQH/QU2tcz8TDxd018Uo/wp3AoUZ8mYu5lOku5fA+drEByKBkpWEM820wSn3nTnx6QMVj1UTfrsPco9PnhXgoKdFqmN1t+ShuVWzknn8DUunYy4avJ3P0A/59DNAfmY2cxx8KCEQqmUMzYxl07Z7yHqgQQQIQn3Ngm6RBWuewyGktqSVvkXZkbn82bbS8fgzVKP5+FP3FFWs+Anwc4wBtS5T8+yy5+vwQRkYZe2rld9ZNmNpZBn7rdphQ+/WAb9yThm+VPZnYZDP3D553S3b4SnACxpBBmnNvVGszNkuAbizYBJr4yd4LJWiz4xsxzN9hDgTwrgAp+JmWfrM9fWrdxAH8jLHRvbGy9e6iPFaEPUcTfFwt/l+I/NRorxd4jvObJCmsMPnqcqUrxXFEdxtyLZE/rKVSHowkQpgWJRAz3gJz6M3KRD9oiGPW7gvrMlzGgLzwEyLf9otEpLnwAR5ZrG60R4Bj50N3PkkXEPgUicn4Zn8TZkQVLcI61vga9C5neHgCvQ/lRBYEwjlPTQFUyFfdRMI/cahUhMtPY4t0oKH7m32d/B7cZQIuKmPAsOjgT7FKAG10dlZuhP9vs7PFh+breB5klW2LzwVK9KgYgk5pE2g9haumjNE798IqBsnQMiQYKdbechbw2cE7gSxoxTPE5xThfJyFyO4JC0wNed3t9jIBxWq7QAAZVSPNNRECzbANGcp3BMzSNA/8G1fh39qYY8lB8VDsJD8tHA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3fcbd74-24d3-4522-489a-08daef514be8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:16:01.6722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hWh8GndPjLwjAYcTRR/okrtD7qejvnkYAxZJmCVymLjtwA6hau4mk8N+jld63AVc23VAjAjpBjhzPRamP0bd5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6075
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050152
X-Proofpoint-GUID: 9M_oPrxFxT5mKSB_E-RuuUwrJ9aNz8p5
X-Proofpoint-ORIG-GUID: 9M_oPrxFxT5mKSB_E-RuuUwrJ9aNz8p5
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

The split_vma() wrapper is specifically for this use case, so use it.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/madvise.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 4115516f58dd..86f9ad95f0fa 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -161,17 +161,13 @@ static int madvise_update_vma(struct vm_area_struct *=
vma,
 	*prev =3D vma;
=20
 	if (start !=3D vma->vm_start) {
-		if (unlikely(mm->map_count >=3D sysctl_max_map_count))
-			return -ENOMEM;
-		error =3D __split_vma(&vmi, vma, start, 1);
+		error =3D split_vma(&vmi, vma, start, 1);
 		if (error)
 			return error;
 	}
=20
 	if (end !=3D vma->vm_end) {
-		if (unlikely(mm->map_count >=3D sysctl_max_map_count))
-			return -ENOMEM;
-		error =3D __split_vma(&vmi, vma, end, 0);
+		error =3D split_vma(&vmi, vma, end, 0);
 		if (error)
 			return error;
 	}
--=20
2.35.1
