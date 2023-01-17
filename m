Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B6066D45C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbjAQCfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbjAQCew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:34:52 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244932A148
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:34:27 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H09eKU006596;
        Tue, 17 Jan 2023 02:34:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=tVIi81lx+WGbxrahe2pvo1w9apb1eQh8SkwhMec/4Kg=;
 b=AlxSC2Jyi4x09FUySiLq5bOQqgifq/tFtuc2uoFf12hydk+2/x+ETR8k7SS+WTV50hh0
 xxBjE4PXGatf3TcdI1h8BCq1bxcEX0WphXIqOXMyNdf676GsYXwEAwQ0E7wM6L/H3Olk
 GDi7thWY923U+xWOuIUTMAySuaGneicIACiJqMKtLAH2cONlhIH1CB4AGdmN2jv28PBR
 gYV0owGDlV3KxdQp8zkfVYiXCCSySucF87Zmd3yVpyzc/uMvG/kmT8xVLV8brISX52k4
 BshhwtA/PhIDNcFQBn9IeWrZiGqnp/A5EOjrqSk7JsdQl6UENtUVkgNcUEDad2oU/rYX mw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3kaabrja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:19 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GNXAUQ020577;
        Tue, 17 Jan 2023 02:34:18 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n4rq37hat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDPotj9XlpY5jvnR2TTIoUgOLyLf3kRvt4W59V+Ayc4XE71tnf1ldsAHRHIT5zIN2eOjNQGfrti2NbSJ6qJZvXZ7P9vopxGBuYrTOHnO80MnlrK7FcAfT9Ju+xTyKznI4CXBlolzwQt9oXlPYLcU4Asb9pHXgCmBNDVTFSsrVwpJfWFb2BZ02kNfc0ty9QLopCpfmMQWSGnl3LuRWjhsJhVlN75jWfuX5UEIaa4rnkHdrWSv2HeZE7orEY+0wKUysp+ObCSmKydrOrSC34nR9y6aBAXxARG36DyUWc0DSkidqYttcIm0hjHG1ZqaNS3YZ6kPuvnyO1ExlPe/QUwHWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVIi81lx+WGbxrahe2pvo1w9apb1eQh8SkwhMec/4Kg=;
 b=mLXgBPjYzIIki947AlyFbbxs/xpW2+ZPUBkE4JXqJsvfGTmfCVX6VN8tLmDK+KFYt5/Ud4cdiHEuNF1rITRVcaYdJhUjQqRK9wfZNxgMko4GcIjr4xfBgb4svuXF2xGi1nEjztK8Uui2z3iHkOUXlBF5W/Gx8n9poJqUIF38F5v6O9Z+6kOEEn8ep6jlXURspwSIP5rXRNxH6tgHb+PNjTYCqRVN9BxWibMEJml/BWtb7p1L5a+OkDazov9pUBQMO0x6yecGyfej5UYdRsmKsGkeYc/blNK/ny40maQ/6Fd8CIjUS1Slbd/g63wVTBDmdeZdHHW0Jzgq/mLpJadbMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVIi81lx+WGbxrahe2pvo1w9apb1eQh8SkwhMec/4Kg=;
 b=IMm8/m9c7P1vM1EVkexqko1iK8Gw/hRZEkZuD/HRLbKclABtj8MQO0LafoVxvcKpDHISo6sbxbFQo3hprnhp7mqmnJVpKXx+jZt8sgzu1VTBC0l2ep5TaNc9orgQ0cJY7LBEmjyx1rtPUBaldSvwq5JlLbXOASktdUW1s4O2kiE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5356.namprd10.prod.outlook.com (2603:10b6:610:c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 02:34:15 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:34:15 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 13/48] mmap: Convert vma_expand() to use vma iterator
Thread-Topic: [PATCH v3 13/48] mmap: Convert vma_expand() to use vma iterator
Thread-Index: AQHZKhwwKw6d4BE1jkicqMiUM6RJzw==
Date:   Tue, 17 Jan 2023 02:34:14 +0000
Message-ID: <20230117023335.1690727-14-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CH0PR10MB5356:EE_
x-ms-office365-filtering-correlation-id: 26245deb-91fa-48ee-afb0-08daf8335381
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LRHwlFH/pNQFLlw/jmJ4Hix9KH4AtKquYXKj5RUaASRNbAwR1nOaQ5OP1PRSIg3x74xK9x9CqGAvh9//ltrMVjFLojImeXFOjqqHOjuqMHrKlFGZCcwEQAlzOBQZ/m0dkrBa889jVEm6CNqjkOiEJzbds4X0+GF9T93ocS4ZZAHE8jh7PdR8wo2MTbYPECx4gOZLOinO7OJS3/YTeiuqo/bM3dk8J76sMkOPsHySargn0sVPxUzc2cv//pX2wBBaR/zmLkZ5ZnkADSxlRUpOwnMt73HBXoy3nBoe6QQNjmLWE3WDKSNo9WshE6IoKewBBI6ILi4U28LEJeLcexFx3B8KdbTatVGVEaHORniNlz0R27+H2GudOjPVpGsRER/CfVIXIeawT1pphEWj54f7oWeIgAfqXcRWuOt2Qapv9eWp1PhMZ+8GZKtDn6JNLz1VFXfnnCH2RGB1nubsnpRX/LZHjZfaEJakhY3fm/g6vmXIw9pMFiY3+epLmVRI/+2cNvw2g0qwGJek512RoBE7qK+apI6cGGhKxYvhulVPmmSxqFLL5phxzBXltsio3LVfSle87xgceYyz+7+xMc3uPsC6aUwooOUS0ED20hW22305nIFOl7WOe6ZkQyK/Wv2XKSbwkgIwkvL36JmP8TPNXQ2gJNBpp72jyl+XNANhQ4Ug9kTRyspCzuC5IV2JASD/eYLEB92hSqDeggtQuqXAew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199015)(36756003)(38070700005)(5660300002)(8676002)(44832011)(8936002)(4326008)(76116006)(66946007)(64756008)(66556008)(66476007)(66446008)(2906002)(83380400001)(38100700002)(122000001)(478600001)(54906003)(71200400001)(316002)(107886003)(110136005)(6486002)(86362001)(1076003)(41300700001)(91956017)(2616005)(6512007)(186003)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Z/8Goab9AsZIQxahqVOnQ3Caw2I21wen1Vx184DLLLm8tXgEFN4dLPD5+7?=
 =?iso-8859-1?Q?vpMbmZTeBzHRiDdRcEYcEeGFpklYgK2Gs2MB5JMRCfwvDfeweZX+qd7s5Z?=
 =?iso-8859-1?Q?2hlKvYi2DF1cIgS26AvCpC+ETiq9WxNvJ6T0EPrCFRWWkact16FrEJOHBV?=
 =?iso-8859-1?Q?MkTnJJqI0lQsVZs5yE6BnaHjUf5qEj9huu5rwKhqB4wgRrncuc7Bey9g4x?=
 =?iso-8859-1?Q?iyIthNRjkMcayfku2wTxddroLNvrcDe57Yj7IlnKhetK9QbxsMHcipU5WB?=
 =?iso-8859-1?Q?wOXmmWrfcwsq4kEivX5iFxvm814/NfLi9OEHFqMpqjbhUiQ+X0LUmn5EyM?=
 =?iso-8859-1?Q?mnJ+5aupEB53WUuON1jxGkqe2iyhkwVzaCl4dkOpZR0zkNg59i18r0sy9E?=
 =?iso-8859-1?Q?kc6foBdGqaLgGJkWpkPPMS1TCSZuOcF3DJ+mLQj3qxaC5G8wCVgOhxMkwY?=
 =?iso-8859-1?Q?1n+iAsf1/cMdqP/pM1mQGKD8hO7ho1NlmEYTIcXNxDZ7t4B+m19fB6V1Dz?=
 =?iso-8859-1?Q?5Yiwo7djzf2QM2F3RGiTN25SEgIFR92mExflG/bAa374RcrgFxId4sShFS?=
 =?iso-8859-1?Q?9HlYn7HlhE/sQ+HmvcdubI6iHV5EXWzv09wiLZR9R1XACynHonE1quaqZd?=
 =?iso-8859-1?Q?klZt+6SZ9BdXibu03DoxqPQEYxPoBr1gedTTXmE9mMG1bHlhaPtP7HPEmY?=
 =?iso-8859-1?Q?I3RU3xKAI6tJgrDA6Snn9r1RmP/zzUm6FOvLEUTFpB8a/ExCPtRGkGXUnT?=
 =?iso-8859-1?Q?9camJL/8rHEhkg9sGeeT9RH9/7xgzlNpkCkW0kE4gI8V8v0OwLoKeJuS6T?=
 =?iso-8859-1?Q?hhQcVwYFRPTxYMqO0Px3dHKLJPvqYs7OkfCLub1TsC517cXVVONNUQElZY?=
 =?iso-8859-1?Q?DjTi4SrWUYw5yuxhWwdOxOpvjBhtZwj9y++PoYYNVF5J8LAhA1iMXxbrbO?=
 =?iso-8859-1?Q?z8ju6dQXR3AbvuKjO0Card4oBA71eZIFhpMxjjQQXOnCeU0+0bW1b1vedl?=
 =?iso-8859-1?Q?3NRkm2RpjIMTmp04YsD1Owb/mUamGjXLyUMt+cqw9DvewU1jMEjwSef+Jq?=
 =?iso-8859-1?Q?bP2dwgJ8L6MR4suM/R7I6AvoLyZhg+E5S79EuAWCDk57THjRHUArRq28HF?=
 =?iso-8859-1?Q?nZ39TbW2Cz/pjUBT14mMYvRNMd7XZuTk6zWUDJacR5xY9v/Kj7S+y1mFoW?=
 =?iso-8859-1?Q?GdvA7xxyBZOIOmtjQ4btU+o0Wts9x9SuPV+l/H20k/CWfXwltRdmHA1PoC?=
 =?iso-8859-1?Q?1CdGGJ4iIzw97qPQQ01brRHnD5pURXOq2O9VCeWdtfBwwl24gSv9MsmQU0?=
 =?iso-8859-1?Q?6Y99aTf36hZNY08ZXmOsgRIhLHyg+Mof//W15ej1p5cgleWqRUeEWEoc4c?=
 =?iso-8859-1?Q?uIEW/c+Y6tN2EBhd+aU/ecwfZ/bq+iiZsTUkxlZzKZVqFNkV5sQJUU/lLv?=
 =?iso-8859-1?Q?JgNJGNvsNBUUc5lSdZd8U2CA+FIPMJUjllLB1Sy8duAPybQKN3JlfhJHiY?=
 =?iso-8859-1?Q?aWzhHMENpbHJF7SZtHPvSZ9IkmS2xxhUmYuup8Z3LpCYCRDv0O6uU34JsW?=
 =?iso-8859-1?Q?+OPN0kPqv8cJhe+JG4Ez2Y+tWDDUt1gy47etFnVZ4z31ApQXh5C+gqQ+kE?=
 =?iso-8859-1?Q?LS/eJYM4SvwLyB1J8ErvV8HOGbfRFDmLPgP9zSmoaJ1PnBdh/EE4bDSA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2CbPCIj3miy2uu4mk3Y5v/shfmrRxjqRD+j5SEaN4rDij260Zyd/xd0TBitiQcLoyQJ0hj3kA/8X5AkAq55/fent/zunTjzz2lQlv68P9jdkddwdX9DgowKlAlzHa7e5NH5f2pPTye0ze0okW03AdLXO/zwASS5Sr1I+MAZcxaRbkZ3XSjfpJs1JYnX9h/E2fao5lkSvzOlLkmQhDeU7WvlBF8XEqI3q9JbF2+PUhU15Hwh0HAYiLYjvfe4/EoKdzeggjlzoLlX6OzjwTOAw09C2u6mdpDPHtXKhDb29+WNLm0Ur5J6Tk2muiSb8/JoDIbQAyUo9Wvnu1r5YlYFF2QoLmRMRsenmbLf1ZY40BMogmUtfLKDZbEfJI0q1qqn1G6lykTJAHETUKcIk1NlzYlvcg5tR68W6WHC0kHA7HLxP7nNOJWPXNa3AMFFE6uAlA+C/lY1ZUEGIcCdsnHl9cZl6Gbcu/cPQXkLWQ2iPEtJpkjWDP/L1tWqTm95fa7tucJTx8GBN2Gs5tdaYQVdjI22cE06WWbUBOHGRYEs15OcSMiINiHgdT+KYdwJiUCuCFMYWKmaL0rto8v/Z2QctqQ7/SUqjYOk4c0q1Z6f/3kzpI3twaVIVF8qbOe9Bh4UBeGzLRKXKZyeHMhwxtJAAI/I4E24ClxXkQZi+Eh6ZIJ3DMIPkzMgs/20/oafRwxr/7I/HuiyF6+HXQ5x2mTENoEU3ZenscecovubILj4/uSrA8NDKr0Fb4aeCp6Gld3irKvJMqjdkUXkmaMGuwTbywSCAHGUmWp6l3QHinjSZsRS3ROGbsTJR8+c1Qcdc/vgBlCaqYZ+gYHyfsGSzG/ATyTAhsDeTPhic8EE+ssRtxqycVczNFV2TF/Cl9Lh00fg7dGcNKN2FE410wTaO1hE0jw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26245deb-91fa-48ee-afb0-08daf8335381
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:14.3282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZXggObqOW2WzO+4Iz5JxkHCEh4UOySDsM0w0WZLU60zAtaLpiCOGR9qdbym3szdWp0J9oHoj7Tj2eYO/VHBxUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5356
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170017
X-Proofpoint-GUID: uoo32O3_Gbb0gbPpn2AuIwo7HWOcE107
X-Proofpoint-ORIG-GUID: uoo32O3_Gbb0gbPpn2AuIwo7HWOcE107
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

Use the vma iterator instead of the maple state for type safety and for
consistency through the mm code.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 364b1abd8ddf..02083b2cacfa 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -527,7 +527,7 @@ static int vma_link(struct mm_struct *mm, struct vm_are=
a_struct *vma)
  *
  * Returns: 0 on success
  */
-inline int vma_expand(struct ma_state *mas, struct vm_area_struct *vma,
+inline int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma=
,
 		      unsigned long start, unsigned long end, pgoff_t pgoff,
 		      struct vm_area_struct *next)
 {
@@ -556,7 +556,7 @@ inline int vma_expand(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 	/* Only handles expanding */
 	VM_BUG_ON(vma->vm_start < start || vma->vm_end > end);
=20
-	if (mas_preallocate(mas, vma, GFP_KERNEL))
+	if (vma_iter_prealloc(vmi, vma))
 		goto nomem;
=20
 	vma_adjust_trans_huge(vma, start, end, 0);
@@ -581,8 +581,7 @@ inline int vma_expand(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 	vma->vm_start =3D start;
 	vma->vm_end =3D end;
 	vma->vm_pgoff =3D pgoff;
-	/* Note: mas must be pointing to the expanding VMA */
-	vma_mas_store(vma, mas);
+	vma_iter_store(vmi, vma);
=20
 	if (file) {
 		vma_interval_tree_insert(vma, root);
@@ -2596,7 +2595,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
=20
 	/* Actually expand, if possible */
 	if (vma &&
-	    !vma_expand(&vmi.mas, vma, merge_start, merge_end, vm_pgoff, next)) {
+	    !vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next)) {
 		khugepaged_enter_vma(vma, vm_flags);
 		goto expanded;
 	}
--=20
2.35.1
