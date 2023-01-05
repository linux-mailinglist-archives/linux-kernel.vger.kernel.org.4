Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6F665F432
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbjAETQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235322AbjAETQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:16:13 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C838FCE
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:16:11 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305IU1Y1029393;
        Thu, 5 Jan 2023 19:15:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=B/nkXQcR6JgrRvx02poR9ZZyLxT8+fxjXFELOkpJf40=;
 b=B5LzgGacvlx8Aev8N/DPm+qG1ke/5PiTDHkINkdoabqMqv/lfBb+KDLZQXbs0UOYK54J
 OZOHi4TO0NRiP03O9h7L7n4JyfyTofRy9FltqhuH7KnmSWGmGET96onigtkqpaF7okyK
 yfmh9gcileBCXhDJKP0lkX6EADIQ0qUNSX1ubHuuRljpBjSYZzlxZ43HdXTP72zlx3jR
 T7h7th3tZPVAA+rzjZc5GX4YCVnudCesSS3xVsce0ff+04Oe/xOQWEQ+8CajSzaD3s+I
 C2ZBiKTXFjdq/WFa1lBB2tcK4sFWiAWlG9iZ1HpfMkxmndvs5KYVo2e8NpszoreKhB17 0g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtc0asrkc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:15:57 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305I0WPK023380;
        Thu, 5 Jan 2023 19:15:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwept6kx6-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:15:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFD8Ewvko0ITvIQRWJggUgfZj2TwbkguPAtg5Rx7b5oKxDo55lOtg9LSXQ3OWzzqDcmo9rxt6ltTXQj8K1WbeolWNygqRNYkpPoXQ5ErQrkbpEUAfMsaguwzIF8XubufuD0WQrz6qkPfHbmrQNV++NKRQoSB5kvxDPP7OddWRJt8EU3RdInvyWCXtY1W1sDGwqqtEE1tFRz8yADcmF26WiMVjXYuyFqZ/IagoD+i0fh6YTl9uQCeo1CKOG6/5RRqMdyFJJTJgG+9f1hinZtscPCx+YiKGzlb9eHubZrp66hILd3edykSMjhN9+FaxGnSGksVAXW177ol3h+5jVTgTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/nkXQcR6JgrRvx02poR9ZZyLxT8+fxjXFELOkpJf40=;
 b=a9dhmJqzEkEkPVYR5GT7OoeA4GsPaizAax0OIh+E97pa0JRQDCtwdmMRJwdGbO8/CWuomuXpF4/pQphoS/zwEdSzTxKHtpIA8YOHWGkTMXGxCaYt8wvG6jcXXp6W8jMXxnTxWnrITwS3H+OVZmX7/hGCJri8c5bDni6+a/ZpN7AhIGor3N1VO6Enmds+llkA/Z4wW3u50BZMYHzuEnDtP1fKCoDpHGAZPB/iITKRhJiiJkYXXYLB+/jxss8kY2Kx2pgi+b90KcGi1hKeFa4seDt9LUKlpBgKa0hYyt91gswsrmGj0FUwURWWKN9HIKmWkAnnGdXxKNfe9vWaRczylg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/nkXQcR6JgrRvx02poR9ZZyLxT8+fxjXFELOkpJf40=;
 b=gDRe5CW011DJzvggQwJ7+Bd13/cdlhAjdzZkxEDD34zGupn6wst/7w5oHWKHAXhrNpqT3PrexITpFmx8kYwqvaShdyodhHK7NApQe8h+oxT6AjELrXwlNqhvRGywg4LG6o7lmx0nHoDNKd8MC2OAXBF0DMrIbtPDFdCkuT/+UDA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5231.namprd10.prod.outlook.com (2603:10b6:5:3b1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:15:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:15:55 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 08/44] mmap: Convert vma_link() vma iterator
Thread-Topic: [PATCH v2 08/44] mmap: Convert vma_link() vma iterator
Thread-Index: AQHZIToiKIPpHVcrxU6+W5JmfFjXIQ==
Date:   Thu, 5 Jan 2023 19:15:54 +0000
Message-ID: <20230105191517.3099082-9-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|DS7PR10MB5231:EE_
x-ms-office365-filtering-correlation-id: 69aaf960-df02-4a02-68ea-08daef514512
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G9eA3WtJbcA2ElWZ/iYEDrzYX2PoeKhao9kk/oyAS58jLaUisDb8wg+T7qgJzHYq7h0Xs9yRxknXE1YueP+NNZrr36BFI7vsXW+HCWaq60Q1bAQQOamqGWgeFduTuoXvd9EyiQBHY0L3v/EyL0QqR2o3B2yQ3ykdwBYBGmE9o3yxJUC6bQF5+qACKj/Euck0GRjtWtxQYHYdvUCLMQU+Sx6IbT4tnE1DFnNvjliYWTmvO60cwnusjT4u2TVKKfQpZfA0Tnc4uYG9Zab6K4Dkn8/n3PyQUAeCiCBCtgZ98cklInfuouXf7AcuRadszqcNbjxxB1ZGfQfkWEev9kWciuuqO2FcFVHosorEgTatCEoBuKZUINOomV55aKqdqEzMDjfggpk/R9zT3ssrY/Cs4XhyhzVyP/rn2vwzCriueEDzAxFAeaCAbtSFprXP1PgsLA/38spMK+qhft4fBzPYXiuAI1IZQyPNPCv8FXy/CoMmq2CDdZSIOG2UJSJ83eVhXnAUQk8l+xxnWB1Kn3HQCjfqzuUj8/bEm75LTWlt687AhPnE/n2dSH3SCqTFhmgL5fUsXO6unjfW1+BHzcU3zVhySl101vrKSKt4O4mp9j6tg/Rid5ZJofVpVC8weKrlITR47LAiurI+ga6evcibyAX2vLPsBUPd6EpIEBky3LmQRy/zmSPQaKpBNL9+TLl5uLpvXqcdSbMFxYIk5cgT2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199015)(110136005)(316002)(54906003)(6486002)(186003)(26005)(71200400001)(107886003)(91956017)(64756008)(66446008)(2616005)(6506007)(4326008)(66476007)(76116006)(478600001)(41300700001)(44832011)(4744005)(8936002)(83380400001)(5660300002)(66556008)(66946007)(6512007)(2906002)(8676002)(38100700002)(1076003)(122000001)(38070700005)(86362001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?++v221DaozvkfBWrDMeMeXgJVVWrWR2tqojAuph9UOx7NkSKjUCi8kLNh7?=
 =?iso-8859-1?Q?AzC3FaeTHH9One4tj4YCylvh50TBOzUf8KInOPt+CG7uaS7B/+6wJUWMvs?=
 =?iso-8859-1?Q?VT4h+ulUUqQLmyOklupi9J42CddKf5l5PffGrj+pywf87K4F64eBnTEYkO?=
 =?iso-8859-1?Q?q0aT+NUlGHgmRapUyeuOG2rHW13QNvTAWU7VGgokwzsxEPhwEW0nTQL9Es?=
 =?iso-8859-1?Q?HyNgWAhwxwd1x8R1IDc4vf3EsURIsCpvpvGql20ITg+7rQs/Ewl+RA0GoR?=
 =?iso-8859-1?Q?UupLppFZABkE2UXqZzI5y9N5kuYyO3cbk2jrs4aRrQ6vkkCS3l5+7iKDBy?=
 =?iso-8859-1?Q?O52LGfL5Z1R5KaaiOW/zahUoHz+AD2qrVo7zj13X3nht4C8uDjmYNasbWv?=
 =?iso-8859-1?Q?V0ABEyZz1buJuUXejzWeT8lIAA9LaFoUOVJ/WBNuMoYJICsd90rVS9VWke?=
 =?iso-8859-1?Q?ZwSt1KW+GJl6UARNTJRkadVzbgZMBR70Q5WzOteX3DNb35cgAlk3/YNZcU?=
 =?iso-8859-1?Q?8zMzPCPp/T75IykLzTFWKtuWvSw2s5tWrWkh0XoGYb+KQmVN5U3zc+MUla?=
 =?iso-8859-1?Q?u2AAFToeO7CHtqFi0a0hCFa3PI3Xa6CbSuF/LqsryNm0dqFDhzaIlTavHq?=
 =?iso-8859-1?Q?UrV0sRo+vUH+tvqdGVnXfcetavcslK7G2ONFofN9N8ZUkPTAHwY3FFk2uQ?=
 =?iso-8859-1?Q?JAxzopOSsxH8Oik2OX0AOoHA5eVf6a1iwEZ8ru0gSUR1gmFzEZF7moP6ps?=
 =?iso-8859-1?Q?YvHlm4gUzlU1RMuGuPvjcp5N0y/Xn+dn73/b3E4Uc/7vQ8M1rIKd9FRmbw?=
 =?iso-8859-1?Q?yAsrCdLqpFgGbRvKAvkOIT/03aSS65m5bLCK7hRYECPh1zmmWDVtTwaGeS?=
 =?iso-8859-1?Q?QTVsQXYZMPANP0Z8csmTdXOaxJ96S905UIjDIm6cQZodHZVUXV9fQgQEi7?=
 =?iso-8859-1?Q?n/jmX2O5ITe4fHobyXFoOuwoM31WR/vj3vb58WgF0aWqS/MOLaPPR8UaR1?=
 =?iso-8859-1?Q?0E9vWmFyEkiK2SkwQNSSA9+T9iBa7M9Ruj5kVZKGmBVc8QLcpwg1Dk8sZH?=
 =?iso-8859-1?Q?QV5gtRecYVtTOJdvOSEyeRefD65p0KSe4aKzhOszP+5KzvZzujYM2Ndelp?=
 =?iso-8859-1?Q?KDeG/SA7gNxy7BetFHItp8zmBJKn+7osLVTqUi8iS2LHumzFRlLiq3OJke?=
 =?iso-8859-1?Q?Bok96diZoKfAIxUGr7PYb02XnolhFzKfRz7jkBsh2ET89XyTW0l3LWt6ur?=
 =?iso-8859-1?Q?6ULFDIY22Hgkg8pWP/6A16iUGon1qDFAk0lL9gwpKGWwr2Acek5GLL9B/q?=
 =?iso-8859-1?Q?y+klanc5A7UFHy8yzF/EZArw/KDzW5/KVtNPvTMF3yK9YLS+9J0i3CzLpu?=
 =?iso-8859-1?Q?ypNr5kUmnZ4/f46cKVyJyHhEvUvQRVz1b5PnMi7f+iMAB/3HMhyP7rWN4L?=
 =?iso-8859-1?Q?3zr/CPBw7xJFJ71HemWZEIyWEW50UFWCB91XfK0DDS1t/KwqrXH3DCAPiy?=
 =?iso-8859-1?Q?N9YD90w7MXU71vrNutT24Y3mtwMfll6S7ZfouBtBNe0Xx6rPXqjqSMwDaB?=
 =?iso-8859-1?Q?c96/TWLCM8vtuBwhDkW020Jubxx5tE4sf7IELAx/snzClBKTatlkRZ7isP?=
 =?iso-8859-1?Q?FfXJnZ+hX4Jn9t03GqAHHA62snvvzFsKAkcQbWad9RBJl2F3g7at8aMg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FyDa+vA4p/8K922ZtlkOv1LadkQZnVqQ0CVdkjH74vMlm4aJZWhZeNtcYFDcki+D/8QSpZ4SpZIYQTNGrggOnQPNJxXhuYgeEkWUvwVkJU1uiRwjaFqtzk6S3TZ6uoyE+oKyY/NMlDrytNs/XzCVcCfeaxbj4rqyUkDzZ/Ea9r14/I9jIeN9HOBubxEfmFDiGB3IePxRjfRAsu63B0X7Ulzh3auKcK9yHPtr96jZWsYJZPa5SMfPUtSKENisG6PZ6WQPKga86Zum9Ce3veu2HgBWkrVs3U8vtZIQddRhqX9O8zQyzQ2oWTPh9e+T183nb/BiWHY/rfQzK2b42hC6xgzSh5rr94B/Ieiq3vOR1ubFB5jchpi1x8S7BWtQfpqkPhICS26VRSHEko8Ar2/VOKCpw4PaFmNLiLEvK/liNqZbmgai/JEU5lG0z2QfOCqyGJxKqwpNDJB2A4osmDYe5KaqQNEaYAULmUq0XgtbU1pBB++hzyepD0WPAXAHTyJaO9FmqWwwDKBCB7RD2pZtd05dNjVSrw13VQ2DaZAhOHlRaQDIw2xO8wEAcaS0z+/J8B+TMfEnzUyD4WvfPgVhYsKZ3sjwqWfGcP47rHr5JHaOwhdgpgvalIJjyLdHRLxvxawOO0c5C1fa621vQP4uaOJGuXEFGtpAS3/I+hmFsBGOsk4VOD1kE0PNzc71e/HoBf3hVBSfaNLfPlqB/25/Pg1k0xyeu9tBUX3RBWXqidQQTmTf/rtr4dsAIc2C9LiugqpK9I0yl8cny46d0f3H0ro+AD0f5jJYka0Cu850MG0Z+PP6hSOUep471ljHwz7ElZkZ2MuBSjsmCFW6p7CnqzC4qzB4+yCPzsJvrD6H9he20OJVehh1DK0XvPXmCW/23rGFa0wFipw2EopCRspSeg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69aaf960-df02-4a02-68ea-08daef514512
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:15:54.8445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z5xSk9MUDIr2eqbp3Snvw+2vbOfrLwK2E6yl1rh8NaPXrbX7pjldzw0ZGbgL8OqD1LsMRloGouE/8biMNMC4PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5231
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050152
X-Proofpoint-GUID: R6i41NmlELfhMMfXABZWvj5BPDvVm8cR
X-Proofpoint-ORIG-GUID: R6i41NmlELfhMMfXABZWvj5BPDvVm8cR
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

Avoid using the maple tree interface directly.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 4a6f42ab3560..00b839cc499e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -546,10 +546,10 @@ static inline void vma_mas_szero(struct ma_state *mas=
, unsigned long start,
=20
 static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	VMA_ITERATOR(vmi, mm, 0);
 	struct address_space *mapping =3D NULL;
=20
-	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+	if (vma_iter_prealloc(&vmi, vma))
 		return -ENOMEM;
=20
 	if (vma->vm_file) {
@@ -557,7 +557,7 @@ static int vma_link(struct mm_struct *mm, struct vm_are=
a_struct *vma)
 		i_mmap_lock_write(mapping);
 	}
=20
-	vma_mas_store(vma, &mas);
+	vma_iter_store(&vmi, vma);
=20
 	if (mapping) {
 		__vma_link_file(vma, mapping);
--=20
2.35.1
