Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45BE66D468
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbjAQCgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235483AbjAQCf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:35:26 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D8A2B63B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:34:33 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H0924N023158;
        Tue, 17 Jan 2023 02:34:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=3MlOLDcSfCp2iYntEXed53C/eSTXs8myN4WtsKmfa44=;
 b=gUBZVJEBjl69IWg3xtlBOxl2fDCQDFoXkuI4CPH9AP93gX8PwOHnVQWehX//2ZTKOHXQ
 K4YAEU4NgNaFiPspe4zVsg6UXHTeWaCRuRSMFPcUtmZtgDLaBS8FrWFjP/Ap5MCX1PWO
 NFDkDGF8KRPjM4WMEfCANElyPRbVbG6cJ1o7TUqJ0OedBg3geRuXKpmU+Mzyzq1064Q/
 2kYmmDrUhYtqjWDDA6G5xzPlANB9bUqu2a0GzfkG1ZuUMRuWppFYHQbzCn/3f0+bE5Af
 RceX9xegdim00nzKN3z+0ohTzmzCc6zY99sdVbLC7w0jrAlYzuUpkfUkBcJQjJvP7Ubb OQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3jtukq28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:26 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30H1b4BU028327;
        Tue, 17 Jan 2023 02:34:25 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4s2rfxqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBgHc0E+ebiHgmV9JJRJAN061r4RdBOgXhBU/Ut098zqEBxFAm9ofAYL37PZI7YBSsbz2fhXDXAplJz/9UafxP6siWrrUTtE9bUFij6Lji0AYq1sp2dRcwzW0+GUsb04ZE3DaVZH4ZDB3PeCamrVCQJmOT4i0sEC8IRMUbGNSVhcERPXVXBRFs/cP7XvCGsdKoisuPJmk1e3fHoU+/vJw4zIgct24+Z/C/2DRbvEHEx194UIA9FtLM9gU+qOJ/LzyizJ5Rq4g7Ak25Y7gfMlDtpKOgn9s5SNHxW/1gELaDAFsSskyIw0qEh+BqNSZQR7NtwQWM0VOjo5Jl6y7iWloA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MlOLDcSfCp2iYntEXed53C/eSTXs8myN4WtsKmfa44=;
 b=ByJZ40GE4BvVqYiN9hD9uKIshyMuGT+MayKfZF8SjbzHmjUdwXExW/fY6zal0NbRDEaNrzVDWbOieeEVP+VS793GlRmr+8YieREZgvh1bmkq60vWEI4O693xROKHq7h9UEMdk2Nx/e3YzmnWJ87OxHmj8PiddmRk2KupjNNqG5ZNmQaaWfJ7QqyZHWe2UGvD3L/nOR4qq+MfvhBlRQEOXuY9oO5y6ZPZZv9YD6KAtfqul8L5EfA2/BBo1/i7nAKHQ5vGXScTj4CzUGRtp9WWo010FCZ1QMnLqC0co5LbhlIehSDiR2YvdrsgTgpU4GjeW/AuiHVt0CAuk+DeukkGsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MlOLDcSfCp2iYntEXed53C/eSTXs8myN4WtsKmfa44=;
 b=DFtr9Lu37yfwqYRagIcnPFOe70XHT0ALkO39WhL1zR9JtxTp9bGyEk0rx4NhkxgaRKMOdn4oYoJb+igRQ/pajCGM2DsgXxgN7jdVysvuY787ThlTwznlS/1DWvltkR8g4cJCo+vMvgBYv2PRI6kbvQiPux/REj4+kQH9WHvvvEA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO6PR10MB5538.namprd10.prod.outlook.com (2603:10b6:303:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.9; Tue, 17 Jan
 2023 02:34:22 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:34:22 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 27/48] nommu: Convert nommu to using the vma iterator
Thread-Topic: [PATCH v3 27/48] nommu: Convert nommu to using the vma iterator
Thread-Index: AQHZKhwyglsvcvpZOUGGhHQ35TLxkA==
Date:   Tue, 17 Jan 2023 02:34:18 +0000
Message-ID: <20230117023335.1690727-28-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CO6PR10MB5538:EE_
x-ms-office365-filtering-correlation-id: 9aabef1a-0148-454e-b6b7-08daf83357eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K+ClmxsyUupqwQ4XRuyTeGzcsrBGDKWv52qkCRsoOQ4lm7yrwVXGSAroZnqL230jTKdr27MqEwyG5A066FM3qYiLZfSBTyMaclxFU50gKgjv3ADqveG7a4sjtyCT78HlkylL6/mJRvRFdwHT4qSXsB/NVQhRiexUZyMzuvq1TKxKyiu+4mAT+ypMWORvsj6kaxHFaO06PKJd6x7cdvj8Mnwtk+8JyABhPiHVz/URVSsciu+UllyPU4KC00zWLGKEiY+fMdhs4/xC1HfQRvtUaVlS32mgjT1yP11Np9Z9p0nllcveIV9IfXucHEy1W/SVry5hYGm3llwm61snIBbrMP7Qx8TuLsO7Lve5IQTp5hcayBP/ODs0oVanIHHyD1JKPlYHjqJqbotNHNBbmcUifRnkGWC3bniyQevcaiwER+iJcnOpcAhaEXHzpBBpPFFo3HXK38Dl3j+Kzw9vUOqvOh99/Ou+otkGVLmu27Ljec4E0SvGp4RT+ykz6pGkCRrOXaiPAZfEnWnB5cq6cFGnT2SUISldowKQM0YdU9ArV/dOk0g72QFSC8LouqXt4e5zCCz98UdgIxC+Vm2ROHqlHLHQaIzf3cM/8+f4SzBKFNVwWv+3mx7ofqcVpFOB9DZ6fh2ti1K9w+DKM0YH93RnQSMCI/wxUJdcqsOnnbHM/+3Jb64SJvGmJiso4MCtvvOnsPKclVgse13h6fwdoomATA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199015)(36756003)(91956017)(86362001)(8676002)(6512007)(64756008)(4326008)(186003)(76116006)(66946007)(66556008)(41300700001)(2616005)(66446008)(26005)(66476007)(316002)(71200400001)(478600001)(6666004)(38070700005)(6506007)(110136005)(107886003)(6486002)(44832011)(122000001)(38100700002)(2906002)(5660300002)(83380400001)(8936002)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TY2MNWaLn+V2+6eLybfXiSPY3pbVRRdwopKyg/V6yY0YGwfBv6dC6zzMgw?=
 =?iso-8859-1?Q?0x/qw1QKBaZI/j+FqEJGM0za5KZzmNYZYeszjrLoAR7oVLzGYFHtIzHIxz?=
 =?iso-8859-1?Q?7ScU1EU5BOEb1VDIz9THdj4BphTb7EOaKvhjbpzIylZ7Zk/EUf1jHnm2rd?=
 =?iso-8859-1?Q?Z9GjezPi2YlRbdHCy1/W38Mb4kmnmW9QUxZzPKstFgk6wGbO3DPz42gYlU?=
 =?iso-8859-1?Q?qR9bKeTSR6luTVWb6aBfKeQIUb0usYLoU+qqawdqhdwl2e9T2yfW8DG2Ob?=
 =?iso-8859-1?Q?A8513k0unLhFgXP+4tj4xDYOGWU9/bEstkhTL4Ks0E+c3rC6Cc9IZiVFaj?=
 =?iso-8859-1?Q?EJQKtizSDDyIFgxXWDyK69fIYAt6uyI1eQAQXMQIH10tTZwnGQJf004yDk?=
 =?iso-8859-1?Q?3MQHTD5vzJMzW02WZJR5JKyiXlP4dGmHyHTFLfjg+NYtRLbMhhlPVYsI9U?=
 =?iso-8859-1?Q?ON+wMNQ+BpIckhD/SVBEWp2Gd4h5SyRWfn3/JmKbExRs0DrYvbJLXSUmhV?=
 =?iso-8859-1?Q?qt1eBY68xgAhVOUmCQESRFJC6sCeA2e+XYZpL9D7RLEf9HT7Zfm4pnRMJz?=
 =?iso-8859-1?Q?86nAb75Daql742aHTAu3ephIJAu+MwE21/FtyQlhLjM8ZR1DR57QQnK2ow?=
 =?iso-8859-1?Q?CPNqpLBZwhx54IFtv4SgXOlWYJvB+nNBw4kOIc4CIj3F3Ezdl+10iJ0QE9?=
 =?iso-8859-1?Q?yfQjUxZ9q99tUynaelhK3kjtt+LJ/40sLv61vxap33MzgwPM6NM9j313NG?=
 =?iso-8859-1?Q?xP1QQMyfzTCa1Y4xAbjxoy05bhjwsVkM2ZjhIOIHFWFylsFNZq8E0bFEhZ?=
 =?iso-8859-1?Q?hrDdgZZT0e750io0ce0ouV4v9cZayoOsIu0od87aLma+55mzrEqvLaMNH0?=
 =?iso-8859-1?Q?AEZF3pmd2UY36N3ie02+0NAKYRYL0LssgVkp7h9wxF7RUjyOUaqh6lUgu0?=
 =?iso-8859-1?Q?AWdcmg7ZW4jFg0cHio3yKjmAcP2Qi5DT2JTab+bYhFgwkzTE2TqJ4HaLW9?=
 =?iso-8859-1?Q?+TsQ6bSqpp3pfQ9T8EGbMYLbY3X7MBKZktfPoQ7hIsmVdthXI43cy4nULZ?=
 =?iso-8859-1?Q?+aITu8/OkUtxedevahdMbW+UztPfRYwy7DWDML+1KXzmCj4gKRUXjy126Q?=
 =?iso-8859-1?Q?728+g7w37p3N9gSYJx4a8vlcLfOPTejjlhlMv3vz/no9o06C3MyIjhRBoU?=
 =?iso-8859-1?Q?4A9nNP1DYFRpnDcvs0FSI9qpijgNwEKVugi8qy51TfxvdU55vXnJtoRVHK?=
 =?iso-8859-1?Q?vr9pJRitRRG7wvpVBGS0eNNUr3zKOosdIOc4oOfa5guqGmwdXNVuWhImAQ?=
 =?iso-8859-1?Q?EP+Dwz0AdYb5QjYUp+JV3u3cccFPYQtcT9zuNxp16eP43ulaIBCCT01l6z?=
 =?iso-8859-1?Q?MBN3pe51Jll1r6FajV8wUsFenqM5wHD/6c/I21qmUwCnrbq6nYE9pQF1qW?=
 =?iso-8859-1?Q?4tKT8aOR7V511F/dCuueuzFBNxGiRToCkz8UWyKOmCBOmUzjlP9/ScRsST?=
 =?iso-8859-1?Q?e9OPavYydtLcqoZ3QiSjOIQa+SKLc/PFcu8xlfnXzpMKG72FJAVKlxArPD?=
 =?iso-8859-1?Q?uqEgOuOYTTR4UJPnCxpK4+Yf7h2epY5of4N8wIkGalP1xCJVM2BbvA+EMr?=
 =?iso-8859-1?Q?4DSL1MszJQbGm73HoJ3c4ixxsNoUG9pJ5JQZ8kbybel8yC+8ukEhQbQw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: p3inVPFjdsAhjsJVv1O5gzTN6qscVCmevKvbey/atKYAgG7Fv3wU1dNXyl21cQi0bqAIofCOa78PAAzhqtfQBgEViyO62hF3deIuE8uo/+1CgGHAh6oi+bUJeamLgYCoc5IpKx566Yx57sNijirSQR1MzrzJLlF+Ssdtzas3wNfVO5Qxfd/UFQaMszHwgD5eEnPmdom5MN3aIOJ00SaBSGkwJKutODjRyHYiF4p7Rc5U4Q/22KcBKXyDJO4X+2Shh/nHJ4KKm63wRPZFCJDD1zOUr3Z1f6z9gHLcCLXowsaihSZqITIkOQvXBXqpzbTDlADYsnT6cIg7g5c5rL44+MptKB82pBLDdyZGf5lO4IcZ0h6nlN3yErKipF2v19RE2cyjvoZzjla6vKmtXm4tVFNhsdC1XzptD4L600O2yGWWjuA11FyzYcAL954+ZOEl1X6nKyOQyCLoSw3D3R3k9SqGiwZuS9BZ/8MJ4wO/Y09RStjGZjhVpjjPwx0fHG3NGqR6A4oFiF63Vo/iA6q4oLBjlwt3hrYEw/QBxrTgdYjdp6VyTUk1Xob72oJi9Z/qDot0b6gWVS0tXg9qVp3pyImgYUisOCjbJJc3lP/PLBZkz3N+iCbJxewi5EQUoYdPLY7UrUe+mC5KkYXW58LgwsqYaDTj+3fBA9lyAeYVDrrI+FXaw0VBlkmeLSgEv8iEyzk09n5cd+jTOwvN4qKWUIX+sul9W0aMs5H4vqFo9HfhuMfg8GNfHfYzudzMj65PI9vw8tlLZyISh4SHzwZrfmoSyWLD9hEIZwORiRuGACbhxMlMGx6hDaYMjAqKuyjFEwihGGbbh7CCb9k6psqujqRO7UuHLpKH22sB4LTURsjaW7sar88CB2gCOHh8LLMajqbyQXH5EXIclHtTsuuUjQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aabef1a-0148-454e-b6b7-08daf83357eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:18.7029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AlyW1qDCEIZrXWX5zgFDEZfXETQbGDpk1L5Q1pxUbV0ZSpPeX1KMQe4hqr0f9hrDi2+fIi3QTKX6fofPEG9vUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5538
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170017
X-Proofpoint-GUID: TuYrLwftZegv1NMdm8pSXSALdV1JK13x
X-Proofpoint-ORIG-GUID: TuYrLwftZegv1NMdm8pSXSALdV1JK13x
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@oracle.com>

Gain type safety in nommu by using the vma_iterator and not the maple
tree directly.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/nommu.c | 79 +++++++++++++++++++++---------------------------------
 1 file changed, 31 insertions(+), 48 deletions(-)

diff --git a/mm/nommu.c b/mm/nommu.c
index 5b83938ecb67..595f942c6101 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -544,19 +544,6 @@ static void put_nommu_region(struct vm_region *region)
 	__put_nommu_region(region);
 }
=20
-void vma_mas_store(struct vm_area_struct *vma, struct ma_state *mas)
-{
-	mas_set_range(mas, vma->vm_start, vma->vm_end - 1);
-	mas_store_prealloc(mas, vma);
-}
-
-void vma_mas_remove(struct vm_area_struct *vma, struct ma_state *mas)
-{
-	mas->index =3D vma->vm_start;
-	mas->last =3D vma->vm_end - 1;
-	mas_store_prealloc(mas, NULL);
-}
-
 static void setup_vma_to_mm(struct vm_area_struct *vma, struct mm_struct *=
mm)
 {
 	vma->vm_mm =3D mm;
@@ -574,13 +561,13 @@ static void setup_vma_to_mm(struct vm_area_struct *vm=
a, struct mm_struct *mm)
 }
=20
 /*
- * mas_add_vma_to_mm() - Maple state variant of add_mas_to_mm().
- * @mas: The maple state with preallocations.
+ * vmi_add_vma_to_mm() - VMA Iterator variant of add_vmi_to_mm().
+ * @vmi: The VMA iterator
  * @mm: The mm_struct
  * @vma: The vma to add
  *
  */
-static void mas_add_vma_to_mm(struct ma_state *mas, struct mm_struct *mm,
+static void vmi_add_vma_to_mm(struct vma_iterator *vmi, struct mm_struct *=
mm,
 			      struct vm_area_struct *vma)
 {
 	BUG_ON(!vma->vm_region);
@@ -589,7 +576,7 @@ static void mas_add_vma_to_mm(struct ma_state *mas, str=
uct mm_struct *mm,
 	mm->map_count++;
=20
 	/* add the VMA to the tree */
-	vma_mas_store(vma, mas);
+	vma_iter_store(vmi, vma);
 }
=20
 /*
@@ -600,14 +587,14 @@ static void mas_add_vma_to_mm(struct ma_state *mas, s=
truct mm_struct *mm,
  */
 static int add_vma_to_mm(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_end);
+	VMA_ITERATOR(vmi, mm, vma->vm_start);
=20
-	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
+	if (vma_iter_prealloc(&vmi, vma)) {
 		pr_warn("Allocation of vma tree for process %d failed\n",
 		       current->pid);
 		return -ENOMEM;
 	}
-	mas_add_vma_to_mm(&mas, mm, vma);
+	vmi_add_vma_to_mm(&vmi, mm, vma);
 	return 0;
 }
=20
@@ -626,14 +613,15 @@ static void cleanup_vma_from_mm(struct vm_area_struct=
 *vma)
 		i_mmap_unlock_write(mapping);
 	}
 }
+
 /*
  * delete a VMA from its owning mm_struct and address space
  */
 static int delete_vma_from_mm(struct vm_area_struct *vma)
 {
-	MA_STATE(mas, &vma->vm_mm->mm_mt, 0, 0);
+	VMA_ITERATOR(vmi, vma->vm_mm, vma->vm_start);
=20
-	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
+	if (vma_iter_prealloc(&vmi, vma)) {
 		pr_warn("Allocation of vma tree for process %d failed\n",
 		       current->pid);
 		return -ENOMEM;
@@ -641,10 +629,9 @@ static int delete_vma_from_mm(struct vm_area_struct *v=
ma)
 	cleanup_vma_from_mm(vma);
=20
 	/* remove from the MM's tree and list */
-	vma_mas_remove(vma, &mas);
+	vma_iter_clear(&vmi, vma->vm_start, vma->vm_end);
 	return 0;
 }
-
 /*
  * destroy a VMA record
  */
@@ -675,9 +662,9 @@ EXPORT_SYMBOL(find_vma_intersection);
  */
 struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 {
-	MA_STATE(mas, &mm->mm_mt, addr, addr);
+	VMA_ITERATOR(vmi, mm, addr);
=20
-	return mas_walk(&mas);
+	return vma_iter_load(&vmi);
 }
 EXPORT_SYMBOL(find_vma);
=20
@@ -709,9 +696,9 @@ static struct vm_area_struct *find_vma_exact(struct mm_=
struct *mm,
 {
 	struct vm_area_struct *vma;
 	unsigned long end =3D addr + len;
-	MA_STATE(mas, &mm->mm_mt, addr, addr);
+	VMA_ITERATOR(vmi, mm, addr);
=20
-	vma =3D mas_walk(&mas);
+	vma =3D vma_iter_load(&vmi);
 	if (!vma)
 		return NULL;
 	if (vma->vm_start !=3D addr)
@@ -1052,7 +1039,7 @@ unsigned long do_mmap(struct file *file,
 	vm_flags_t vm_flags;
 	unsigned long capabilities, result;
 	int ret;
-	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
+	VMA_ITERATOR(vmi, current->mm, 0);
=20
 	*populate =3D 0;
=20
@@ -1081,8 +1068,8 @@ unsigned long do_mmap(struct file *file,
 	if (!vma)
 		goto error_getting_vma;
=20
-	if (mas_preallocate(&mas, vma, GFP_KERNEL))
-		goto error_maple_preallocate;
+	if (vma_iter_prealloc(&vmi, vma))
+		goto error_vma_iter_prealloc;
=20
 	region->vm_usage =3D 1;
 	region->vm_flags =3D vm_flags;
@@ -1224,7 +1211,7 @@ unsigned long do_mmap(struct file *file,
 	current->mm->total_vm +=3D len >> PAGE_SHIFT;
=20
 share:
-	mas_add_vma_to_mm(&mas, current->mm, vma);
+	vmi_add_vma_to_mm(&vmi, current->mm, vma);
=20
 	/* we flush the region from the icache only when the first executable
 	 * mapping of it is made  */
@@ -1240,7 +1227,7 @@ unsigned long do_mmap(struct file *file,
 error_just_free:
 	up_write(&nommu_region_sem);
 error:
-	mas_destroy(&mas);
+	vma_iter_free(&vmi);
 	if (region->vm_file)
 		fput(region->vm_file);
 	kmem_cache_free(vm_region_jar, region);
@@ -1268,7 +1255,7 @@ unsigned long do_mmap(struct file *file,
 	show_free_areas(0, NULL);
 	return -ENOMEM;
=20
-error_maple_preallocate:
+error_vma_iter_prealloc:
 	kmem_cache_free(vm_region_jar, region);
 	vm_area_free(vma);
 	pr_warn("Allocation of vma tree for process %d failed\n", current->pid);
@@ -1334,20 +1321,18 @@ SYSCALL_DEFINE1(old_mmap, struct mmap_arg_struct __=
user *, arg)
  * split a vma into two pieces at address 'addr', a new vma is allocated e=
ither
  * for the first part or the tail.
  */
-int split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
-	      unsigned long addr, int new_below)
+int vmi_split_vma(struct vma_iterator *vmi, struct mm_struct *mm,
+		  struct vm_area_struct *vma, unsigned long addr, int new_below)
 {
 	struct vm_area_struct *new;
 	struct vm_region *region;
 	unsigned long npages;
-	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_end);
=20
 	/* we're only permitted to split anonymous regions (these should have
 	 * only a single usage on the region) */
 	if (vma->vm_file)
 		return -ENOMEM;
=20
-	mm =3D vma->vm_mm;
 	if (mm->map_count >=3D sysctl_max_map_count)
 		return -ENOMEM;
=20
@@ -1359,10 +1344,10 @@ int split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
 	if (!new)
 		goto err_vma_dup;
=20
-	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
+	if (vma_iter_prealloc(vmi, vma)) {
 		pr_warn("Allocation of vma tree for process %d failed\n",
 			current->pid);
-		goto err_mas_preallocate;
+		goto err_vmi_preallocate;
 	}
=20
 	/* most fields are the same, copy all, and then fixup */
@@ -1396,13 +1381,11 @@ int split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
=20
 	setup_vma_to_mm(vma, mm);
 	setup_vma_to_mm(new, mm);
-	mas_set_range(&mas, vma->vm_start, vma->vm_end - 1);
-	mas_store(&mas, vma);
-	vma_mas_store(new, &mas);
+	vma_iter_store(vmi, new);
 	mm->map_count++;
 	return 0;
=20
-err_mas_preallocate:
+err_vmi_preallocate:
 	vm_area_free(new);
 err_vma_dup:
 	kmem_cache_free(vm_region_jar, region);
@@ -1456,7 +1439,7 @@ static int shrink_vma(struct mm_struct *mm,
  */
 int do_munmap(struct mm_struct *mm, unsigned long start, size_t len, struc=
t list_head *uf)
 {
-	MA_STATE(mas, &mm->mm_mt, start, start);
+	VMA_ITERATOR(vmi, mm, start);
 	struct vm_area_struct *vma;
 	unsigned long end;
 	int ret =3D 0;
@@ -1468,7 +1451,7 @@ int do_munmap(struct mm_struct *mm, unsigned long sta=
rt, size_t len, struct list
 	end =3D start + len;
=20
 	/* find the first potentially overlapping VMA */
-	vma =3D mas_find(&mas, end - 1);
+	vma =3D vma_find(&vmi, end);
 	if (!vma) {
 		static int limit;
 		if (limit < 5) {
@@ -1487,7 +1470,7 @@ int do_munmap(struct mm_struct *mm, unsigned long sta=
rt, size_t len, struct list
 				return -EINVAL;
 			if (end =3D=3D vma->vm_end)
 				goto erase_whole_vma;
-			vma =3D mas_next(&mas, end - 1);
+			vma =3D vma_find(&vmi, end);
 		} while (vma);
 		return -EINVAL;
 	} else {
@@ -1501,7 +1484,7 @@ int do_munmap(struct mm_struct *mm, unsigned long sta=
rt, size_t len, struct list
 		if (end !=3D vma->vm_end && offset_in_page(end))
 			return -EINVAL;
 		if (start !=3D vma->vm_start && end !=3D vma->vm_end) {
-			ret =3D split_vma(mm, vma, start, 1);
+			ret =3D vmi_split_vma(&vmi, mm, vma, start, 1);
 			if (ret < 0)
 				return ret;
 		}
--=20
2.35.1
