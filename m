Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1ED66D47A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbjAQCkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235587AbjAQCjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:39:03 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C0D23115
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:36:02 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H090PL000919;
        Tue, 17 Jan 2023 02:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=1f6rY9qFttPrOxBZmRkBAKJVju4/6CJ8NXYhpVEaF2M=;
 b=fjtMgj/nVOh0UNL61/VD8SKAESl6/fl78R8Bsf50KigLabjJjha2Kske2U6XMzuj/D39
 Fl7kp/QKI89EyPcCRF4JDqBRCKEiwhP297rO1xgLaNdo1tiUkx8SzxOB7XQDANgZO92u
 tGw2rZDrQfSRqoKYMYM9Sduj1EUwL18Ukst6fIYWp/53tpmdENdyeUpk95BZri0/hL+t
 uY6iwmV306CgOMQuHlVqI+dHPUIX8BzLdt0/ATT1rTKH9gdJrg1eoTXvhooklOIHTO7n
 QBqK9mHzsLmcXyCa3P2XiiwT0Dh5/XI48yNIt41qlStWgNfeVAvbB/0kONxIM+L8x08F Kg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3medbqc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:35:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GMXP46028373;
        Tue, 17 Jan 2023 02:35:04 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4s2rfy4x-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:35:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DquEW4x3b3j35ixQ8gC5F9DxPf5HP5UIEUOVhmU5XzvFv1FIbq9WSphfS5+abF5unoAL1h71ZCQozr2aQNkzksHzMQb/M7dzgsRxCp+4rD8AXs0K5UW2KKifmFJS28VV3nM4vzyfHNymmisCHkk2LYXD6UqarEbOPqbS63b24I41QmV0O5jSB99HjUDhxDK76O5UKrE8A9pUEnNrTlUitGZg5C054rZPWDhum7qlIvEL/eMiTUDXMVoDJbl66/yVt7pSNlL2yWyqbOQrlNQMXYdBiV3NR4b3aBnR25PAPiqHbdSJanJx3LSEstVIlNUNIBLQ3Cwg08qUiAWFs+VLTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1f6rY9qFttPrOxBZmRkBAKJVju4/6CJ8NXYhpVEaF2M=;
 b=Ul+mT97XUdFHYh3HtTMXRoATZrKtf8937JhGTBTfYADjbCru58svDLU3Ohoj57Gn/87auxTg1k3RzL+ds3ZE1+gZraYgvMQ1xPQckCUfwdIAcSztN3JslLoJDrOkEOg1mM1aiJWMa9/iqLHZEENTUGHl3HR5D0x1NXzTfixpDqvTZdaR8mDeks+77IdsWOcdAzLCayskteRDNwSQGQAnP8yvI36swauSU5jUwp9MdGnbQ64W5fV2q+7nZ/nbp/6LVBoexKKY9rTxvR0MYtUbMBT9i8rJ4LXRZkfXY9Ikuzy/Jf5XZtMhkYFvbQQEt/0spzyX1Rd7QwV0nWLXqhX2WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1f6rY9qFttPrOxBZmRkBAKJVju4/6CJ8NXYhpVEaF2M=;
 b=QvPZuQMOWS5AgIdgjuMe0hvN7mrgCIBlVJlubSbbJXL+1t6EJF73MZPO8D9wDkh74N7WPkpeLA78aG79AUDHOQwV+8hG1DpAwtN0KBZ614cWj2pEcMmQ/ACIE8Drpr9/NOKr7CqJHtX0pFv8IwbXpaRDReO/Lzcz17HtKcfsRpA=
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
Subject: [PATCH v3 45/48] mm/mmap: Introduce dup_vma_anon() helper
Thread-Topic: [PATCH v3 45/48] mm/mmap: Introduce dup_vma_anon() helper
Thread-Index: AQHZKhw2qsa9amlaRUC8A0zX1St4PQ==
Date:   Tue, 17 Jan 2023 02:34:23 +0000
Message-ID: <20230117023335.1690727-46-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4814:EE_
x-ms-office365-filtering-correlation-id: 98b4ad58-6046-4fff-391e-08daf8336f68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KiujzPp8ZhVpYbT+xnnpDisHPxSDtHdtKHSOSC4xbhLAX506uPPhlk0f63MuD5qTiwRhFffOg5RxFaBH7jHTIewgy5GLr4ebdux+wMTh98eEYXpxl1nvCFqxCvA4AEhhR6xdAZGczsXoDBHUW73d2q4jxNlTd3/2DJsmQRBFiSLThWzj48YsDRK7/DxcAAg8SWOLGcEQzconaPZ1iD1kiY6M8HFdb4keeEev8JfnyxzpYMSmYlhu/NBGZ007EWnOZrz94KS05xM/4tdnNwCFb6u/mfwRekDcEHte38hdRDozRdsbH0TXKnNgl6xpblCZi7Hm2n7eFB/iNGaZrgET4QCjDQXXhwyS0YCd31DoAzQ3KMHOZXRaYgaUAxO9dn92bSEbt3TP0OAYXQ+ICcgz3vj8ExeXksp66EtWMt/he1aUwqxpYH9zQmkWyjBF9GamOWxubTBGE2buaRQNGqYX/aNZoGIyER7xpMkzhDAzJbYSlt6GjQG2orYP259r2L0L18AgnyXUlwL1745iEHOZjxNot33gt/9n5+QAYP3WZXoEPsJNKDMknZVhvtEupXdszKCXSL4ortq/xXarf7/66TWL5tiCS83lk50rl894Ly60cF0aBL82jpQoHbw8xZSJO1ienbybdx6UPF4qqpTHeFTih7DyIfzvj2tz0Z9YQ6tGpV62yFFUCUWWtep7uyRdL4PatRCVJUu/FgpyQrtX4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199015)(6486002)(6512007)(478600001)(186003)(26005)(6666004)(107886003)(71200400001)(6506007)(91956017)(66556008)(66946007)(2616005)(76116006)(66476007)(122000001)(110136005)(316002)(64756008)(8676002)(4326008)(54906003)(66446008)(36756003)(83380400001)(8936002)(41300700001)(1076003)(44832011)(2906002)(38070700005)(38100700002)(5660300002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ukHcNgaHNMU7CafEYPWUBa/FPiHqF1sa3d39ikk+misuBMNrodM6Gzo4eC?=
 =?iso-8859-1?Q?QD67vskSjRSN5jzF2bpmnNJLLQd13rYsOvHSpDV09LUK4PWC8WodwynXbf?=
 =?iso-8859-1?Q?6sCrbThq8C2QlWc33EHuNDvBrTnmHrQ+jobLtN/EoO0j/kj1afRXtlrHbP?=
 =?iso-8859-1?Q?LP/cL7ueR//3Lcw0ccQYJYEWt+0lMs7OJcrukAJBVRKx92S48etlw2M22N?=
 =?iso-8859-1?Q?aT0obESMrAefhWIIJQ6Jcsu4hORpHNieT4H3SIM53siGuGaEIEiUmYQkwR?=
 =?iso-8859-1?Q?NtQlVEbUTiFMm43tutkiJfn9A0X54PuxT2JEj+NFntFNI6WceR/Rd/lNpL?=
 =?iso-8859-1?Q?ev562PCo8RhTrldl+yB+yUS4IkpVQ4+HGNxCYA0M2WgoxaaUnqr8OIDzy5?=
 =?iso-8859-1?Q?5mKFQZuiXVpfRdVN99QeKZQNARt8iLUVxMEYM8MtzfZczlsPgjmpJFZLY0?=
 =?iso-8859-1?Q?pT55qbT9LhlzL4bo/G5axq+Z1Loai9BhnJ7niq1AthEY5PBJVOy+j/QNuP?=
 =?iso-8859-1?Q?41IE4P6wJEKCsQPRjbDz/t2B6lRk5FBVunTdQ0hu01PRInKrPWarvx9dWC?=
 =?iso-8859-1?Q?zjlx+5BGW0PtRIF+cwP2iify7Bt+3vcXHypOgBHl7YPAEjdxGyggrXKXvo?=
 =?iso-8859-1?Q?wqJB6Ctbuinnf7QnWpM09St9iS5SpTOEIo5YU0ab5gAab2x6MJZnM+okI5?=
 =?iso-8859-1?Q?1F2RqV1UD6R4b8JQ8MqvyuLvFJ7Z22FsrhCoODZhgGqVKPN7BlPVsw/TxU?=
 =?iso-8859-1?Q?8NI5KL2DIQXPxTk1AtFpBSkso84rENJKEu7LAEUWSc/8LAysMR7eFltajT?=
 =?iso-8859-1?Q?gEcCwoCRgfdmWbvLsKJ0vPu/ymTznTjymYjtYYDT69NWdLbtf+it8jYNl9?=
 =?iso-8859-1?Q?+KD5Q1j4sR3W5ai6QQsflWulooXqMsqZGExpOesN+y7110+FzaYBNZSPSK?=
 =?iso-8859-1?Q?iJTQzTCR5DkKncH0wwq5xDhcDKwUS19KL/OV+EzQy0pTcjCtWX0oSy/cTs?=
 =?iso-8859-1?Q?fn6JySWobozh3l8FuvNm7H1zIysstpfTjiNslBPHMaIR0terIMJ8ux5mdQ?=
 =?iso-8859-1?Q?1I1kx+iWvdAvnmMcJVSMqfXEPKIZnXReCC1Zp95ZemrEQglahzQnNGVkAT?=
 =?iso-8859-1?Q?+TV/1E7Q/v869OHprdAKoibrvAegNa7qMdzXeS937hP4EO/OLWiSjax5vq?=
 =?iso-8859-1?Q?3YLFKhQeG1QEKlTZp5Hn85IERaFTIRQHpmhHguy2eUuVFPX5zNB5pRcV0S?=
 =?iso-8859-1?Q?/vMEOFotj4WiDzRlg8p/8NWM047i+SLerxYrc9woV7JjWej3XYUOSrGNMg?=
 =?iso-8859-1?Q?rfrEmP7KWf3syc/AIQtUTxEpbKZnNlEx77KoqYGVkACyhmHCmwkz+liwqk?=
 =?iso-8859-1?Q?jH1K+1zo2FDcwLXzxh/2Tw6TViU0v93c2177dFevq7hT3+9bSPOQ1v3uPk?=
 =?iso-8859-1?Q?KGtlp3XdmhozgTzx8AuXgC1hg9TnJm4aJH49qUp1jtF2fOtgrbpnZMwgLA?=
 =?iso-8859-1?Q?QaOWiOITkz10NTmbBfuhTMRRrP6AWSI1g6o5ypF91J5rWA/ha8PzcTByJH?=
 =?iso-8859-1?Q?muJ/9oqBOXa0XFnytKsUgkCkbOq7hTdMqgeOsBnkW2tiOV4PoN6I+NyHG1?=
 =?iso-8859-1?Q?oSjyNQwnKH2HCdrL86nn4sD+7rPRc3cq9SAnVDBaeITydzfhgwQzQ87A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XsUGcjt3Ymm/E6X3xKN5oZZVfHwfKWUIU+UsyqHNKKLYXaLiWHIYkGG27iRhYi7PkbliR0NlPsrJnQgFhJQQKjpwqisPk5tnNSzIYGhIs+aXaC2yWZVYPTV1qgZxSvGfZf4QudxisjvqH0/PdYq8JI2q5vfkU7K6yTYNz68t0EPu6sH/oJiQ8HCdWvN4A6uNc72OQatGxzKmThPDaTCXSUTjZ2kXMRFo3WK5Ha3RpObaN86bjpnZsPOvq73KnYk7FKuZh/SajOF9s0pGqIKdsL2ArBCgUGUTmDUERmORxzPzOhJ38BZ4bWhbs7HRk0M88X17maplx5c3kI2alxjvPtjeORsNs87tG4iD6rtx+RmTc50jEBlcVDi7xOwUzi7+6AYb9rcGUQkE792f3bT3sACxJogca048MDFBGv9Yrth7nm+9FHcetQ6ZiQtBB8fxt+K0QCA7K2AOm+rJetYqoWb6viXlyHal1yFl8pBxmXFZSHDiEEE9DXcf7h+sPjCL7KoviUje4YNWobaf/yHNs1ckofmg+aB4AW3iNrAz41df2ULOL2fjDi+cFtWO6iKPZwCyyK8vG3AEVHRC0gYo927ucklIuFemaouAkWJEJxif4ejzxH3KC8bAG0GyDRq+xqfDsfrP8QCbOjaos4zTVdI6aw0dIF/gTp8+L29bAZPtLVHvLsxP8wHizBL3KSwWWkQRInrkNNpgMxWVgUHFsc9Jll2Ao49g9XLzIIsaHo+Qi6tVmEwou/wdyXXDC3MJiSnIXREOjrbM3o5PCiusARxfrIuaxworm1rEiuQPLaabYWYnDD8kJYCm9SeokVNj2ElHepj9mAN60eZx8zaBU5JDXBpWSX6lWa7t8xRDfuApT3Qcjn1LT7quXxDnHQQghZWuarjqbFUGSipOrV1Mgg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b4ad58-6046-4fff-391e-08daf8336f68
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:23.8431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e/mfqeE8dnFjSV8cWENhhE27+q2FB+b3BsO6PCvYcVnOcn0IKuF5umYjf8wF28F9OzTA1K7Ar2g62kW+UUEvsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4814
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170017
X-Proofpoint-ORIG-GUID: z7gl6yZ5DQSo1IVyXlm9vby9TWbnDUNl
X-Proofpoint-GUID: z7gl6yZ5DQSo1IVyXlm9vby9TWbnDUNl
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

Create a helper for duplicating the anon vma when adjusting the vma.
This simplifies the logic of __vma_adjust().

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 74 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 40 insertions(+), 34 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index a6e07edc15e9..a533e39a669c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -620,6 +620,29 @@ static inline void vma_complete(struct vma_prepare *vp=
,
 		uprobe_mmap(vp->insert);
 }
=20
+/*
+ * dup_anon_vma() - Helper function to duplicate anon_vma
+ * @dst: The destination VMA
+ * @src: The source VMA
+ *
+ * Returns: 0 on success.
+ */
+static inline int dup_anon_vma(struct vm_area_struct *dst,
+			       struct vm_area_struct *src)
+{
+	/*
+	 * Easily overlooked: when mprotect shifts the boundary, make sure the
+	 * expanding vma has anon_vma set if the shrinking vma had, to cover any
+	 * anon pages imported.
+	 */
+	if (src->anon_vma && !dst->anon_vma) {
+		dst->anon_vma =3D src->anon_vma;
+		return anon_vma_clone(dst, src);
+	}
+
+	return 0;
+}
+
 /*
  * vma_expand - Expand an existing VMA
  *
@@ -645,15 +668,12 @@ int vma_expand(struct vma_iterator *vmi, struct vm_ar=
ea_struct *vma,
 	struct vma_prepare vp;
=20
 	if (next && (vma !=3D next) && (end =3D=3D next->vm_end)) {
-		remove_next =3D true;
-		if (next->anon_vma && !vma->anon_vma) {
-			int error;
+		int ret;
=20
-			vma->anon_vma =3D next->anon_vma;
-			error =3D anon_vma_clone(vma, next);
-			if (error)
-				return error;
-		}
+		remove_next =3D true;
+		ret =3D dup_anon_vma(vma, next);
+		if (ret)
+			return ret;
 	}
=20
 	init_multi_vma_prep(&vp, vma, NULL, remove_next ? next : NULL, NULL);
@@ -742,10 +762,11 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_=
area_struct *vma,
 	struct file *file =3D vma->vm_file;
 	bool vma_changed =3D false;
 	long adjust_next =3D 0;
-	struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
 	struct vma_prepare vma_prep;
=20
 	if (next) {
+		int error =3D 0;
+
 		if (end >=3D next->vm_end) {
 			/*
 			 * vma expands, overlapping all the next, and
@@ -780,15 +801,14 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_=
area_struct *vma,
 					   end !=3D remove2->vm_end);
 			}
=20
-			exporter =3D next;
-			importer =3D vma;
-
 			/*
 			 * If next doesn't have anon_vma, import from vma after
 			 * next, if the vma overlaps with it.
 			 */
-			if (remove2 !=3D NULL && !next->anon_vma)
-				exporter =3D remove2;
+			if (remove !=3D NULL && !next->anon_vma)
+				error =3D dup_anon_vma(vma, remove2);
+			else
+				error =3D dup_anon_vma(vma, remove);
=20
 		} else if (end > next->vm_start) {
 			/*
@@ -796,9 +816,8 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_ar=
ea_struct *vma,
 			 * mprotect case 5 shifting the boundary up.
 			 */
 			adjust_next =3D (end - next->vm_start);
-			exporter =3D next;
-			importer =3D vma;
-			VM_WARN_ON(expand !=3D importer);
+			VM_WARN_ON(expand !=3D vma);
+			error =3D dup_anon_vma(vma, next);
 		} else if (end < vma->vm_end) {
 			/*
 			 * vma shrinks, and !insert tells it's not
@@ -806,24 +825,11 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_=
area_struct *vma,
 			 * mprotect case 4 shifting the boundary down.
 			 */
 			adjust_next =3D -(vma->vm_end - end);
-			exporter =3D vma;
-			importer =3D next;
-			VM_WARN_ON(expand !=3D importer);
-		}
-
-		/*
-		 * Easily overlooked: when mprotect shifts the boundary,
-		 * make sure the expanding vma has anon_vma set if the
-		 * shrinking vma had, to cover any anon pages imported.
-		 */
-		if (exporter && exporter->anon_vma && !importer->anon_vma) {
-			int error;
-
-			importer->anon_vma =3D exporter->anon_vma;
-			error =3D anon_vma_clone(importer, exporter);
-			if (error)
-				return error;
+			VM_WARN_ON(expand !=3D next);
+			error =3D dup_anon_vma(next, vma);
 		}
+		if (error)
+			return error;
 	}
=20
 	if (vma_iter_prealloc(vmi, vma))
--=20
2.35.1
