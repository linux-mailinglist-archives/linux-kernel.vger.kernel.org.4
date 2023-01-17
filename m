Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA45566D473
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235660AbjAQCjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235674AbjAQCid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:38:33 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD25630293
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:35:52 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H093bL001971;
        Tue, 17 Jan 2023 02:35:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=3JAK9iYw7tH2glMJ5AJNpC1IiMEfCgLbB/+CHB2Dxdo=;
 b=mAlD+agP4KWM7AAaiDX6Z0E50lSwQRiwsIAVzb/u+maBSDmnN10bk86Yg36KhKUI+OR0
 V/9k/me7AtByPy4vi/cJ7AN3QOl0hQmzfPEuViyc7DAyxYhhcaKgWp9sPYj3vIR9rdPg
 b0vVwHx88Bl2Q76QhuW1eKmzUSrzVfWbDFPTd/BH2Ud5Ual58kU4q2LNV667fO2E01K+
 7YcpX1aQWr7pAHHtCG65zF88xrZsh4JgKuXdnMWBLBRvPjdL6DVr00dXVuh6QMmIxnAk
 1zl2fbr7zKcczRMGXHbyJ4KxtFHnRII9aKVcgOwUH7ibkBLKjNv8SBgV7wDsdxgTwqjO HQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3k6c3prd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:35:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GMXP47028373;
        Tue, 17 Jan 2023 02:35:05 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4s2rfy4x-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:35:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kz1uUHmCmCRXmYF0iGMeIe0jrUTTBrHd5UYYyLZZoeBrRkhX5pKjYUth9q2okknW2R/azrpX9Qbzffyb744NypJH88jWXTBu3SJPq11YDrphDvSVpoqz3mzxpwXTmtneAsx2j1Rk6wECLKdw29s9SUE/Gc4GGG7RyImQnuBsTCA/oB+UA80uTAIA7GrAJjYa6e77BP+wTk7McAXcaSx9u2TdjXG0KbiUmVNYfOqosUtoRcBANUIa4HrfCra4EHnatNVf07x1BZ10/6ii2Ot+Rhxo5Tkfe7mLldlIOo4tZ6T6OkUzQWQ8/iJjCQKn+/WWFXOZYyoQfCuYn+OIbMH93g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JAK9iYw7tH2glMJ5AJNpC1IiMEfCgLbB/+CHB2Dxdo=;
 b=UI47m7ywREWG5nOYTyWxETtkGrNzfGUUFnDMn48cozuzd080o+/gW4ebOZdTyRExXl2TY1Bw4IXDg+ttx0yVswnIGS7DO24CS7lJOPaPASUBvC1wnrvGGsGftzYDMbi9cPIYAyWEoyvTmspXEBpemvnKW/o0E+3nXa9VMqasUDr1SFEYxEY0vmGqyAqDX/CLNT8t/3Ja15SA1ZDAFL/TFzzXWf8u5YmqVBV/MpOodouAyEwMixmjabeUojig+FFiLDmiPhenuSdszYljoX5ouOEixvH5y9srOIBSCcWB05csKbMIZ6t1i7WyL4P632Wa4prb1IE5QlDRu+Z03enLBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JAK9iYw7tH2glMJ5AJNpC1IiMEfCgLbB/+CHB2Dxdo=;
 b=Ksmw9Gptqw1TTBGUDByEur0fOhjByDsAkilpkXgJ2IGuZmesOyccKOCAPMoWbDF1T1pgIjPilG0ViQOfPGeCR2amcXJZuHXnL4zvv8Egt6kL4iDcvRS05ZQ0oSHXJIe01Tps4t0DvEX+jFt0cP1cL2jORRPDMVeNQC7e3gE/+Qw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4814.namprd10.prod.outlook.com (2603:10b6:a03:2d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 02:35:02 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:35:02 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 46/48] mm/mmap: Convert do_brk_flags() to use vma_prepare()
 and vma_complete()
Thread-Topic: [PATCH v3 46/48] mm/mmap: Convert do_brk_flags() to use
 vma_prepare() and vma_complete()
Thread-Index: AQHZKhw2c1pZfxkPkEap+/qyNBLbGg==
Date:   Tue, 17 Jan 2023 02:34:24 +0000
Message-ID: <20230117023335.1690727-47-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4814:EE_
x-ms-office365-filtering-correlation-id: f54d722d-e6ff-4dc8-9790-08daf8336fa8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JkKM3okB0HaRL/5KFTF8Vrh5qELIGcKDqmsJKEstWnUPBoNdist+S0LvmtwRq03c3kw7X9y9THyKjg2WBeI0qv+82NPGjULy7SDUQuHZdg8qFqDG48hy4dWS+nRA/vbzyf8CaD5C1PaVHggx8Mr7H/H7rKaRVAqYKp1mYH7/TEkgN1etIRtpNSOic05ntwLGdOLkENWxDgB8Rm40H6akENFK0KZwb8g3+Yldj/uc/FsXrH0uD1+26urkWmW1OYSfZGfKPltlsp+RlUmdxWFHWD9d2ztaqeWUMxilga1O3ikWEIWa1vfpkLuHAFVzRzsyT84k8iFJt3Xc8zbLqjde9K/eHA+Eqaj35xVoFSUDWcc0dIpIRk4fx9lsQG6mUMQUFR9YWnwT8H88Cw0f3oBOjZ90mcwtN+E3fjaEXa1xGtffkNvzDp8heUvnSfGq3j0mrlzoW+tZNGeYYtj5GCI49K5eGnprJZbsthbmvUE54kvG/9mN3bVMMV1mqg/UImJyh3dS6bLJqCX0jT9HXmI4qkdxdfIR+k1SE++qyg1iOLtEPspN5k5c1tb9axNSGnjZtU2nJxr3AlH/KQ+2Ztb52elHiM3+LE39c2tXh506wmpDsztZx4PipWp16JUGWbeyx9W77jGU2hZDl2eObPdhcUBbdRdApKP6ARYFjdCq3AK2u7Dpc0HoYUVEL2zuC3buDWj8bFCynXw1X2FygfX0kQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199015)(6486002)(6512007)(478600001)(186003)(26005)(6666004)(107886003)(71200400001)(6506007)(91956017)(66556008)(66946007)(2616005)(76116006)(66476007)(122000001)(110136005)(316002)(64756008)(8676002)(4326008)(54906003)(66446008)(36756003)(83380400001)(8936002)(41300700001)(1076003)(44832011)(2906002)(38070700005)(38100700002)(5660300002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KsY/9jPgTeSaZExBCbXC/bqz9QpVi04P/dWpnkRDRECH8HK0n5NiL7t7Rf?=
 =?iso-8859-1?Q?yWg+ed1M40dK47GGXcHo/MbOf8VFesa6ATAjKIgkOrz+9YOlfOKniWmGkG?=
 =?iso-8859-1?Q?ELyzS9fz62TgIEM2ii54d/vyButgZRmHlPIXlUlhZ1DZsEkCHZdUDn/IgT?=
 =?iso-8859-1?Q?aMf8sGlpSFlNKlaMEyYDD79Aas4ITAzaqNLmtZjtq5c1u7GrOJsLNKrPuU?=
 =?iso-8859-1?Q?q8KANtaPxiG3utmleV5otSHMDaiYBclIXo/wm//lTHc2sPTZsAE6OIj+7n?=
 =?iso-8859-1?Q?u5ulf5ofbQ1/8PjcSb/hPAhGvYBNEv0IrUmnmFLDrgswYtvKtOs6KA7e1H?=
 =?iso-8859-1?Q?AheIWGEDCYyCbSY+SJ4LL29pRM4sGqt1+IpiJ1nFUTrjQ9CiH2ShpAw+CW?=
 =?iso-8859-1?Q?CrCXeDnTcea4CsowwFLJWArLit0icuihnk4MdT/AeGDtcddKOc7NO+vy8D?=
 =?iso-8859-1?Q?G+Z5TvOx7rD1bmnr93q+9v4PLxdZ5yBhud4B5X6NU6yU6zzBgj4LRIL6Pg?=
 =?iso-8859-1?Q?rHtNJyfHKa5dWzGuZDiD97flNX1mE/UOQlAAvxkW5XOGOZwaWonsOqs9Cn?=
 =?iso-8859-1?Q?cSnollte4TDHtsYOzigEGHhaQQ337mTzmvSKnTUDzhmV2LudMDIu5pzX+Z?=
 =?iso-8859-1?Q?muSi9UPEae+mzFcW6wrfiLO9XIgsvf2nfZ3yvBz1BZ+0Wk+zC2u6cZJPZK?=
 =?iso-8859-1?Q?e4KeTaFLNUopSSbAmUtjQqBpglYaq0usejON0V/4Ypcmb24s6IV3Bf5U0S?=
 =?iso-8859-1?Q?WxYllvGhU+VWX1lHAHBR58d7AV02BYeB8Pba7DSEJgIvE2oJ7GZAm/xb9K?=
 =?iso-8859-1?Q?fbL0+WEBcMDPD54/ahND0/QrUv+QT0WYlj33prMNgqDN8nBi5L7GwKi+Uc?=
 =?iso-8859-1?Q?Y071TzkrSa9Xr9GcF9oxkz0ZpI4/TBzSyKo/ihodrs2sOKaZS7TibOIjXN?=
 =?iso-8859-1?Q?TD1W3opVidQmTTnS/pdF6OtbkyTQ4C61AqnugXz6g/9IiwhrFQqDvZCh4t?=
 =?iso-8859-1?Q?T6ML2BvjryW2iDYyGdTT2C/Tu76KVk7yiBxLTVD1wIvlm6JCtZwMfmYqQ8?=
 =?iso-8859-1?Q?qWvsTElW7GY/eL758mA37Vma8paloL8lPs7XjAkD0QfJIFIlNG+ljxnCf5?=
 =?iso-8859-1?Q?c4R7Bhw3+7Zp5W+zLllLH5epLXG/6CXwtkCxBX5jXa8sjppijpnTZz30xT?=
 =?iso-8859-1?Q?P4rFk2l1fQtRIAkJzZ3Cv7t+QZiHgDwB9Sa5hDUrR7D8/yUFFWKDJkMw32?=
 =?iso-8859-1?Q?DwuRkuSQ39EV2Bjlbyi3r5R0VfdhWLyqxj6IkFx0KCNRFqa8xY5aAn4W+F?=
 =?iso-8859-1?Q?lPdaMN+rpslCasTx0RH4fBWC+MJDOUWQEifS3aJ4/zKlzKomAWW2UfFFfO?=
 =?iso-8859-1?Q?u1MID/4s8f+PY8K/4Y+a6495sd+K455VQYQB3Mpa8dzZjwWTrtsB7ET0kp?=
 =?iso-8859-1?Q?m1Q7w5VTDZ2YkpSWsjEjZ/6lXTTChNMtD6zNWqXoQf4+635gX3OraHo776?=
 =?iso-8859-1?Q?XjymffkdUGklrllNbknvUnQ1pcy0UzA50c5+ZzuDOUep7CSJj18YZTioKA?=
 =?iso-8859-1?Q?4uLnLe2IIF5fIutxgOCZnW+CaLuwOMSeXWldV3BISFb0Onvu6b1sVUsD1U?=
 =?iso-8859-1?Q?BFDjcT8pXQOY/WJ8cks7BNg2pUdIMwEEN5yeyymmA0sjQMFuGPivUMQg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sUJWThCIhqG0hEBSmqnwStnbdz1xL+W6o7w3TaCMc2IKLAWZWV+YsrQl1zw53xy7SpFBE08U2ZEO8sbnLRFT5ReRkmQt88mipPFWiR+KchrQ/KmVD0zU8ZRiSqWyPfVDOIciHJgF5Cdm2zjWEJhWVJWHOX4OssWSdQd/7ZsLGbeMWS/VQMQbmgmWg+hqk4xz8Hb66iQ+9dOK97nYzoGLdqnlmTb8ceFQZXlHAyPrl6IOomb0fUzhNaaxiA+H826TtAshQavzqyB2aqH7LTTv5y4XwaN5OownrrP300PeyJJG4cpv+amoS7TD/TJhcM7u1+smKkXl79q6vlVTmqRzecDBXFIxo+UsqlPn2QLGXsH7CQx90lzZHMMVr9MVTDAQsEgDON/0X54/WrvcxWiQhjZfOM22JjXKnXQS7qTqRxLqNMWPhgt5UL3rnWMpERdmv0S+wCProgCsuH2UUhovVen+JtUXRqMqtxFn03zXwqxN6YA/QzNRBYt7NPeHTUxEDd7zXkcV+8/hRZsJqvet/5wMlNZnItstwHonioVANyhzivNGwe05f4HUig2AKCIcaoUzJRlSzGiQn3F82Tq3cHxw3EVUduMiaQzljFdnKYX0/O/YF3AIKHHkZfbo0XjG3VoFP9g7QpoRMoHVvsPX27gHGLxuazFHOwjZalHW4wjWA9PMcjhH1qxPI9y5is/5ijC2MOQBk7pyhzRQgCRcOt9W94EhTNgn6KWuZvwxbi/F6oopT/344m6pWUr6vMLnsxYxPL22/nkggQNKcK1U96bVAYXaAIoSmhyKqDYluM0tqM2myhVJgLT9TAIL3wseGlLUpcx2RJLxqMjb6iL5kts4akfdXHpijaNelKtOSwP5+Z0jxtdkSt1qvWKH3avafoiA8wOD+eGtHFoKM/12VQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f54d722d-e6ff-4dc8-9790-08daf8336fa8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:24.0931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0hYvJewqQ3yZBK7kkrkuGHz0RlRuExVD6HJc+j16p8lmAYZnYYlNlDo9oa2UBiMeIwnqHy/fm7pHoICAQ8WiPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4814
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=980
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170017
X-Proofpoint-GUID: B7sa1WdqTPlysbb50NXntx1b0n8YSVYg
X-Proofpoint-ORIG-GUID: B7sa1WdqTPlysbb50NXntx1b0n8YSVYg
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

Use the abstracted vma locking for do_brk_flags()

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index a533e39a669c..4728b6d1db23 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2924,6 +2924,7 @@ static int do_brk_flags(struct vma_iterator *vmi, str=
uct vm_area_struct *vma,
 		unsigned long addr, unsigned long len, unsigned long flags)
 {
 	struct mm_struct *mm =3D current->mm;
+	struct vma_prepare vp;
=20
 	validate_mm_mt(mm);
 	/*
@@ -2951,18 +2952,13 @@ static int do_brk_flags(struct vma_iterator *vmi, s=
truct vm_area_struct *vma,
 			goto unacct_fail;
=20
 		vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
-		if (vma->anon_vma) {
-			anon_vma_lock_write(vma->anon_vma);
-			anon_vma_interval_tree_pre_update_vma(vma);
-		}
+		init_vma_prep(&vp, vma);
+		vma_prepare(&vp);
 		vma->vm_end =3D addr + len;
 		vma->vm_flags |=3D VM_SOFTDIRTY;
 		vma_iter_store(vmi, vma);
=20
-		if (vma->anon_vma) {
-			anon_vma_interval_tree_post_update_vma(vma);
-			anon_vma_unlock_write(vma->anon_vma);
-		}
+		vma_complete(&vp, vmi, mm);
 		khugepaged_enter_vma(vma, flags);
 		goto out;
 	}
--=20
2.35.1
