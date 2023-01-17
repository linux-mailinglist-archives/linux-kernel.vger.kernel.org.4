Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5195A66D474
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbjAQCj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235676AbjAQCie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:38:34 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFDF301BD
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:35:49 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H09j8f031135;
        Tue, 17 Jan 2023 02:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=GDIZnvT3c4nLUKTNTDe4tm/qdLfWeMn6rJBcSK7ia88=;
 b=VZy3cOwV+fA1ORkyOQf30GaZHfVklekmfPYvcdVdUU7Eho+ZkhxUW98u4Dog36xZKobE
 SXE4izrTM1QWCMI9mff2KVz8vfW1woTRXE0BFo58TgGpNrONrLzin1dr5z97UU5rBMcV
 njZ9mziiGBwazJFr+YFTrvQH2HDDOz9W0bgUgYzGGQZrOadjYdgQxH6CBDTQYiVUzuNm
 S8c9GYIL/12qd1RUd/paAtArLl820anH1HOZPDwSk3KS887ejLKZjqHYdlvphzBQykbo
 UArAUEpPlmTBOwgPUnG59TkkCz8HLBSdcq03SK4EcRE4wN9pyXqBPmClYhBqC4yYmukA hA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3mxt3pjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:35:04 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GNCpCR004918;
        Tue, 17 Jan 2023 02:34:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4qyy10ss-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdYivfXfBOqqyhcNyFtf6Dp4Z1EvEA7sGpzyCeqqzKtkbDjiZb/PC+ep3EpTkhMCz+6iQ+5Jx40pfraFFYTyHB/upQl6yWtUbc00iiGwis7cDswJqMWtODJlQ/CebkMMXwk11pDeR52EW+4xBdHNcfyADsYMXbi0daPVH5ITN03fDS8iXGZzqJBuZ2zH8hr7TaIKAvsWfpnfdaBXTgi8CHKZOUAl8twEHDGq57kBA0Ka5cjZP61hBQuqMReUKYJxUJtKS7yH4rFRV1DRDQf227n2U9b5JUlPv0ZdXPKmulerK5+y9A0VVGXz+FiouNlA2e99uVT/4X1B84N+tUvRQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDIZnvT3c4nLUKTNTDe4tm/qdLfWeMn6rJBcSK7ia88=;
 b=LDVxroXDLKo8YHtwNw40ZKlARib4G+vg6sUv0EodvWiCiqmSicO00gWEz3wZlcZL/RbeUdF7Z5zjxQpUk3e5J9C76nWcsnTmiNRHSQHnCA41mtEVBEB4+bHeGw4/j8jRE7b8W2uyVUrNyXMkoJqY5VXqn9nW9pXZFcSAXKbCr90horDyu3bw4WEQS/eTu/72sU0i87gszXA1PC1Co2fXIaqx4eD1xuV/ieJNMnr5cPGDDrQNLL1zfE3cpolylgIqjmjKB1nt/+ZkOD5qXSGvt8RCFqMNguKVSm5zE8u4GjePcok5HABLhtwCyQfpvCKJf0Jr36scgemMN+l5PIELSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDIZnvT3c4nLUKTNTDe4tm/qdLfWeMn6rJBcSK7ia88=;
 b=eA/xawwwVXQ17yD2RpdqHbotQTUZJNlfz5LiDnwsUDvI1X0lmnYr6fY6J+b8j4ENRvaLtjgrpXYkjZ9xNUQoAEUopy84d5JltVZwi34OjYl34J44Umc6Cg54tn181XDCuAiMU/0mks0F5I3ZHZWjUNwp7XyLqQHs45btEMkcT6g=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO6PR10MB5538.namprd10.prod.outlook.com (2603:10b6:303:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.9; Tue, 17 Jan
 2023 02:34:56 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:34:56 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 33/48] madvise: Use split_vma() instead of __split_vma()
Thread-Topic: [PATCH v3 33/48] madvise: Use split_vma() instead of
 __split_vma()
Thread-Index: AQHZKhw0odaop4BFt0iF6PG4SuZOXA==
Date:   Tue, 17 Jan 2023 02:34:20 +0000
Message-ID: <20230117023335.1690727-34-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CO6PR10MB5538:EE_
x-ms-office365-filtering-correlation-id: 37f02601-e9ef-43e9-c3fd-08daf8336bb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cuKp/1D7rQVz9bdNvFGOxruXYp9WhKwrBNCZQI4ZoMXEXDFCt1htmFwOk8spnaFbEOeMvUqolGYHqinzKiFsBMXflXEY6+tDmoQd920wqzlcj8ZBWbeyckttOZ6RQ5qq7ctd3Fppe49mmAl1xHmASLkQn62gzvXeVqcs+ydw+AtsyVpj+ji/TA+noJ7gbvxKss04EvTWdXAEWkumkuJd7y3T7JYKSRa0RvgvMpx9BsNah4Lx0ssWvp9O7qsw1kLxhFLRIK3HN2VsHBKzRNMmxEMe+gWTjcmif35uQ5pEcSU6JI7dpKl5MFBs/c+8urR99DYoG8iNB4eBa3Uwci33SHSkUQJ/WzfFoWwUwBZGWMtayiwVu7oDpS2PyPQEGUWSPYg4iyLf3hYRssnFbUSOV6TH0wrxrXCLpm6vySuua5ah4wbnGIt4VG/FyNT59jhNmvdSAcONRCoXrCsCCubZV/7xzE/i7/v3m9hTiW/YfXsqJw31Go9+MXoEkQRAxDwrTcUmKYujJU9pdvPtrU7CvOVALB0dWUWxJagdPsoW9u2e/2P3Llu/i7HE42KhGX6AAiJduEjwbDZ0G1kUla8Pkem6z8LkUt34kkSkM9cqQmNjwcqTREo6vxd08Uh/bXOt+m8pkZEJ3H3x3AcWG8effWUVe93ls04sF1LZ9+VJICkE4D5EFasvMO9WYaKVn42rW+7PX5NBDaT26qH4fiBLlQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199015)(36756003)(91956017)(86362001)(8676002)(6512007)(64756008)(4326008)(186003)(76116006)(66946007)(66556008)(41300700001)(2616005)(66446008)(26005)(66476007)(316002)(71200400001)(478600001)(6666004)(38070700005)(6506007)(54906003)(110136005)(107886003)(4744005)(6486002)(44832011)(122000001)(38100700002)(2906002)(5660300002)(83380400001)(8936002)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/IO9k9zNkxN7MmnVXhNYBo4vMZZhv8mCv3vSAg5Bn10K6QUsf0oemwbSfh?=
 =?iso-8859-1?Q?86Vd8J+Z6/YmnbUmF2s8jIJFcNy0QXNqEpD+LoMGy6QfT4UJS6/JaYU9r9?=
 =?iso-8859-1?Q?HRkmqpgBl38BrPt1Tz7zwy8dYUe8fhi78U1+7Kh075UcwXY0o5hjVNcZwx?=
 =?iso-8859-1?Q?pSEWkKJxkJrlqka8m8oZdY+7YT+evCHnd3pApoMAyxUkJXMZ5MwNZsOB3y?=
 =?iso-8859-1?Q?o7riXR8AthvztJ+ujZxrbGb+Vj0DZ9RVGicye9b1lke2D7o7tJkFjaVDdE?=
 =?iso-8859-1?Q?SZWdrnszeu596VKf5Z+KmAM/oXMtPz6FiAi4kGvuRDovwbKjnKQVd0cwTV?=
 =?iso-8859-1?Q?iCA9aswQNiDFUd0MV5mSD3HGOyMzYd97w7+N/Fldr2MIfaRb2aOuKApxzs?=
 =?iso-8859-1?Q?QfBuOvwEkxvvmiO+jnBasbnyDalkkTt3xOpu3fc7h+x6aXG9qJLLobW8cS?=
 =?iso-8859-1?Q?VV47Dw67Qe0ubJkr8NhMTrpHy1qB16TU4+aGhYd1kRngnpqkkJ44A4R/7y?=
 =?iso-8859-1?Q?66SkcEXTOn89gXWzgKK45Y5aHNGNGGzBsri8RT5dyt4vP/YWaXVILA/Uzy?=
 =?iso-8859-1?Q?/TruJgbrLbi5Mt3vPw8aKyz6B8LmuQQCuewRXJTGIAuKurTN7RDXCQEBHQ?=
 =?iso-8859-1?Q?Bmy3+DthEY6u6NpzVUZKQYksk+sY32bLm5G64gYofkmQT2enihfuMRM6CG?=
 =?iso-8859-1?Q?Wygw256u8JWE56RZDF62QgtTfaQZQdRvY72dfXbH6SpSQIVIgqvF0xmaj2?=
 =?iso-8859-1?Q?kSSgshUNfQmLcwNxDqrmR1XcV6ScQfTuU4VHMJikALhdrGsgaKM/MV+ULE?=
 =?iso-8859-1?Q?p7Z4MutJniZfNijxdIlgT4rW1epdgRCvFZfU7fzVHxuIWg4xJWU7HXcJf0?=
 =?iso-8859-1?Q?U/nsO4P/TroMhXAnaBNF4/k7wJV1S+eMTRL4me4BHSo5Aiy22gJ6rjXrLZ?=
 =?iso-8859-1?Q?n3Q8OvZebBEQXhunu8CPprZlcZADw+EsWhkB+FwytSOzk24kUTc5/sJRUU?=
 =?iso-8859-1?Q?xjA6j8sADHGSMFN8DskWBjn0lNlVoFM4MMNgk1DGxgrY/jzIgpSgj2e2Qj?=
 =?iso-8859-1?Q?FzFaCOoe59qPGpTqYop0FVaCOHnMrjQjWrWxMn56FBSo9CYlGQvcNY1OzV?=
 =?iso-8859-1?Q?k3UYmU6ocqu+slocfRiJpnXHwAsulQkfM0Zbx4qi6l5IRvVPvzcnezNAlp?=
 =?iso-8859-1?Q?D1DB2yNCpi+JCyGkUL3zUAPPB2DQ+w+pUtFhUPlOZDq4nm+oCehBOOkYu7?=
 =?iso-8859-1?Q?gR77Tiyv+g8Cy5RgMj/HwMSpcXJ3zMgbmjdMKlgulVm2FCwOw3XsRlDN76?=
 =?iso-8859-1?Q?zfaglscrbHMSfx5qtfqHyvhjI00O+kGMfoyHZU1Ufyu2mYWKnSvIFNdiEH?=
 =?iso-8859-1?Q?8plByYrg9AoRKr6oLAxWNlqkNotxyZa8rpavtQo6onzUGxkEKXSrSyzeGq?=
 =?iso-8859-1?Q?umIOod4c9a5cBpz2ABihK8ZBGylRJtSsZGxdaCgZ2j+jxSDMCDf7lXgBoL?=
 =?iso-8859-1?Q?al831+mJB6CO+7aLSdiJaRANR0f3w9mNJIGC7jVC1+Ka5n/7vz9fenFi1G?=
 =?iso-8859-1?Q?P7g1+HDYeAmb+mdH21wWhjWFHoGMTDcf/5SlbHykHwm5Go7swWEzMRJ0bs?=
 =?iso-8859-1?Q?wwnZjHynNwXp2Vvt086l5h9A+iBeNNB5i1r1cAoaDcTUS8VY72elMBUg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QnzlyLzNkAmciqpuwPcDNVALl6WbniwKGoN1RJsV+u6G7JTdpOCNzgF/xpEQPOFOra0ZvmBqgxF0AM0D5GvwAkGd5t+FhmNeBZjwdvKixiN0bVNQm1Dwx0lJ0lGc1PTUP9SPrxWBjfH+DNcYixhx7ifmz2Zcq8UmY/SEOWPrJVB75c53PKgz6Pbqly3KGHjkwYCQJlV+LF2KfF+FgvoYN1BC5908Pya9erJCKckP7ay0B7UK+kii2TKLtarTFdwaZlJ0CNDWyLNxE5BpnmvkSJs6TtqY5FLWpJOj1jfUKyfh21eoqHKCRc/c82ct5xzzfwDeNW6hF3ebvbatG09eHY8jQHFMfmg8nkc3h2iZ9T9sX/k8hG8U7oikjZa268KuDj67cQOMlgrp86XV2E1siiSOC0EqT0Wg+icQecZHI7JR5oM07KhjKHRragHALHr7Lc9GsO0EF9VO/nfVJPGSoAHKbGzOtTBLo9iGpqfPa9ES957g1OoRjaoGdRfXwo3je0YgQNX3pLuBRy8nOKszyILj/J2Ys6mN5+S+AjXYbY9G5ZodN1ASiLvnrnTrLcR+/Yp9a9DT0Q+AMOuOA5IA/OC/1d6f4lmmeUoaEkirbfwh2+ndCA0PFQOx79eguR2ZA3mEz7kiRKbiSYkTfPSXhQJ82/RY6qSaj8ZtVSxsB4yagsI+BhbaPfn9jASqobsOELE0nfAVIeYY61f4mTIv6smXkbswRP//Z/fEYfXU6L7PRqaU+Yb7WzpF303Bh+bJlZkgaIQsx46HFO9ufSV5vSmeE5wuheRtQKlN0u+TlBxD/QzW/U+m0wb5N5zx88j+d+e7F6Ax9mqVo4G2BHiZTwA/10RakoukyAzzJhE3qOCToQwAb9l9dJnpSsY703/1NKhnVi0gnVl7na2gehgeYA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f02601-e9ef-43e9-c3fd-08daf8336bb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:20.4996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GHH3mv5bO2maQBN/qefPtkn9DWwtWYF8294n4EOylbgWTMHIt6ppGDdcrzvvSdmS5BTFVQ+YkNF3fDtBezsPAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5538
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170017
X-Proofpoint-GUID: x2h5sSsNWN6q8hueSL1ImmIwLKiznXkp
X-Proofpoint-ORIG-GUID: x2h5sSsNWN6q8hueSL1ImmIwLKiznXkp
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
