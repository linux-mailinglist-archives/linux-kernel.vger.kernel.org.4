Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5A565F43C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbjAETRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235486AbjAETQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:16:25 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D2CDE89
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:16:16 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305IT2Te020912;
        Thu, 5 Jan 2023 19:16:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=SJEJ71CHLPVQ9y9IwfIDwgRcUFzrXy+O3J54pk2rrrU=;
 b=HzfmVbi8TE0q3M0xIbZfuzAMDc8cpigX/8pJwUYk9s9Y92IS8Jtwqg2TQsc8Ja3oLbHv
 WxcFMveJWGBhdlo+kwt62n+xnpSCGS8ZW60dYeK6pTr9PstF9Nr9+o3f/ylhQVc83p/w
 aGthx1boIrOpFF9McS12GGYpUKSmNleaP91k9zrt1vjT+v0J2P5JcbC1Y2p0Fy+z510J
 2dA06D9Ki33JT7wF3St+A+Z+rNP80Yr7Di+Tbjnyz2shnKUol9RkkFbZ83pDfagD2n2w
 iUiFpGqYPwPkNXq7Q7E+VhT17fOsSCqI0ktV+nIKgvNB9nSR4tAvMB4GCjmFul6sDd1+ 2Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbgqsn92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:06 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305Hvlpu023372;
        Thu, 5 Jan 2023 19:16:05 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwept6m1t-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYsmTi9/usQuLyLfkv20tC+hdU57BGO28sdOsFFv8wXjroF2KjVd39AMEBDeD470dW6qEJljUUp3YyowaqsLNkEytrd7x38mwaiuOcP20mBLuEPaZ0vN5kOUvqxbuDHOUexr8oIfkn6HzRSFlakjnhztyWqAw6U6KR4bkz5BAxcMhw17Ur09E7tX0vm8WUL4CZkNniyeVVH85LQGb5axMrwcdxLslqNLhMOpUjPcoyZ56wtXdsfWu9OdEo9Rp4Vx/L1li+NYsfFkNmXf22ExCA8NFrg+qCnk3mCBpngDV5RSUa7WKakNlknWwgDFCWUJ1WFNDke3oDqylx6w+uxRng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJEJ71CHLPVQ9y9IwfIDwgRcUFzrXy+O3J54pk2rrrU=;
 b=JkDLMByySEWtcm4zYursBK73iLEYkalDAX7CcR+Kgmw7pjTG/NvMHqT3Af0gLTJnDj1jT8g8wHllwSwBnC51klUD1MSLPARkxl8c6TbTiOlnJ+uhpdPMquI4JaIc4cNETwnvPcaaPgMK4KA3stKOcuZa1QkNcFzJw9hQwn2RZt8OCORoB4faeMK/cbKA9r2Bm19OfqXwyEj+/mDhwhR0HxLEmleHzNnH/xpUYOK6hwYk5GmFsNFZkhS92KxmGozAYJ0uSMfnn+VHObAr/3lH/0z2UUch4cw5RNFdLZ6zwxRJ6NeGQSvjJuLmzFBuMYydXuBMC7vxLW7ohbskDOjkJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJEJ71CHLPVQ9y9IwfIDwgRcUFzrXy+O3J54pk2rrrU=;
 b=IMu9ICEgoZ7kcgFGKsY370/UIIXi6RI7twhKdFuIRaJmIsUItkRlRc4kME/ua+BXoB6gMqMLzG5W1wc/yk67bmTuuOWkDrc/AF3BaRCrqVWYdNDblAkifUcNiszctj8HL0SEr6pygAyKndBh8yGLpwdB0CMEp1QdsI4IoAT8hQ8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6075.namprd10.prod.outlook.com (2603:10b6:208:3ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:16:02 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:16:02 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 20/44] sched: Convert to vma iterator
Thread-Topic: [PATCH v2 20/44] sched: Convert to vma iterator
Thread-Index: AQHZITok5aEqa5uC1kuYn5v8YRb5DA==
Date:   Thu, 5 Jan 2023 19:15:58 +0000
Message-ID: <20230105191517.3099082-21-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|IA1PR10MB6075:EE_
x-ms-office365-filtering-correlation-id: a4cfce8d-190d-44fe-ff18-08daef514928
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aHvh4oi79VZO5K/EOZl35ERMSE9t0kwwBU2FTj4+amA7/6ML+bOsx6z1HmHRq6K3c8ORlbCILqb48QUSMV1KUPVijfGpTU+jv+b/Bi5U4BLtQxZu0rnUO5ICTjnoQLIudJGRe7UzDMM/Cyg6R4qD1iEk4WS8cPmHBAuT6n4DVukRWRGcT9Ub3hDcNqI4DYPyjkEhVQeOSoWKT1OgfEOhWC2WKm8sWaK81+ioFs4P6WoWFhKx9y/s+Gyq5DwWw3AccsFxXVM7Da5oLmt+FgyJsR9SuYx1DSRR+Bz9rN72bM/7xHSAfjpSnBh3IXXavB7fbiZa+uvp7aP62nFaWgJpnenOzj9VmX093ULQNuSnyi3nSaODVFPBvXTZNcLc/LTLK2L6aYy8c6nx5tGsLH43hmnscprpxgCq/EZS8BCzu/tcgbTzH02AVEDYlq9ilvOkc8/e+p8cjvat1MgDcl25skTgD3muR0vdeVzN1XtytvpiQxB/cbdInF0IQ9sZHTEuA515uPJiERpbF35gzl63FlangS3YUCa3K9wh+TC1YjN6Qg2MjJ9um0hKS5fvUk/V1z4RSlbTl/Tp0gRhgXgwM+mtCB9XNccepwhYYxKHv/628NdZEmIQjKk6Yrl7hLWlZfkXrquJ9YXec6nCEdwbc7oncSdGdIn25OC3OpFC4KoBFb5BS+AvjyvMQKHxrX+KzzwjtDhyEUQDx5rnn8Wa5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199015)(38070700005)(122000001)(91956017)(86362001)(38100700002)(8936002)(2906002)(71200400001)(83380400001)(316002)(66946007)(41300700001)(5660300002)(44832011)(64756008)(1076003)(66446008)(6666004)(4326008)(6506007)(107886003)(186003)(2616005)(6512007)(66476007)(478600001)(8676002)(26005)(76116006)(66556008)(110136005)(6486002)(54906003)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EknVxGuspgqGwaxIcRvU0fCBv6lbyGRMu8ZxHJiGF38D5RzPZBoLAwMiHY?=
 =?iso-8859-1?Q?AnNI28dgzGMXVcS4AplqMNzUhkq7HTRnvUJSlm0ouN4L3SJRjvn1gG2CRV?=
 =?iso-8859-1?Q?VMYFkTdEOAuMOZbxtMsn6d5R338oJeZC0m1xQNpHDniu805lv+3NPkZh6B?=
 =?iso-8859-1?Q?b0JZvaiDG4JJKvCFvOYJkeAITpoiB5pQrv8Y1aw4taXFU/E/P2TxTIenVi?=
 =?iso-8859-1?Q?RFB5Q6TRo1cn5lTWsdd9yl3dIbqZyCJP8Gltmu9XNbxA5+4gEL3uHpZ/c3?=
 =?iso-8859-1?Q?GqsVyY7mwB6asPDzsEsq7Yj4gclZmRZFuPnt931LJ1PpmSB/9VIJgSePMp?=
 =?iso-8859-1?Q?+V/X/sCyw9B4MzCPUw4fieqm+6bNvUbNjVIvqtPLfq2yqWTvVSa/O9hXox?=
 =?iso-8859-1?Q?YgAfm1+2hN8p++41/5cxPUYg8J3AloMP097+cfylv5iMDhc1cCgqaXMrEY?=
 =?iso-8859-1?Q?A7VQr0oMvLd7fvlDt3BlPlDnqPuh3d3seE+VgBwAabddz008fP8hCxpiLK?=
 =?iso-8859-1?Q?o597jJ3qMN0B73wYNuTLQjFf95zZelSYUUEtJWcEfm8EBJ7qcpA6B6RwEv?=
 =?iso-8859-1?Q?xeLStl+YpimGDFA+vvV/LhyltwdKi0ZfU8boek/92+NMuAOL/0iMMqq1M7?=
 =?iso-8859-1?Q?VtRxO5nya77EyIkfPSAK2QyWZnhNIv/8D5LtXso+gNFiPsKpMpSlO9Gp4B?=
 =?iso-8859-1?Q?7Nqxlzo8Ywd1z+Ly0GWDpLRE0XQLJAijAKdiqJX4TeqJiWB8xY0zpOqWm6?=
 =?iso-8859-1?Q?GRF0GwUZLDJ79Fq6zt3kv15/h4ZnGDE+vIkXxF9wzHnNd2BuVrj5RbNawL?=
 =?iso-8859-1?Q?hLIX7WR6a86tf/4ujq5nTq4Fm2qCSAZWWihNPWtOfd0fnCkZX57crttmSh?=
 =?iso-8859-1?Q?/xvJE9fgc3doM/oeIAC3BgSqIOc1UGINu073PApkwZRX6pEv69TJ0r2RLX?=
 =?iso-8859-1?Q?a0WHnxP+nRZ34/eb/a194c4zsvg9tVV8FXr9ibZUb3BYYX8+SchJ/3bpKR?=
 =?iso-8859-1?Q?duaRMhcn3G2j5Hx7a7EEMgEjcKnXG/LDJjSdCIhfAYmrSgd9WvHTycltGN?=
 =?iso-8859-1?Q?dMFm9PHJFx6q/0UsJxVmcj4n9ltIJeJigJ/g7GLA1g94miihvJPSXWKtir?=
 =?iso-8859-1?Q?drEWMYU/DxzCwPXf4V2oCtIe8QHiFrQJQQSDmCMhamA6rXzGZbkWGgdATT?=
 =?iso-8859-1?Q?NPja4R2iGf2Z4KlWuyJi5wCH3uufba9+OdG9jBqLLjwklgBI7YFU6XKjOR?=
 =?iso-8859-1?Q?6DGApUZ649MMgm24/4GXJX1PhF4vjRdmUoabYVWm2gqM587FaefAlTRrK4?=
 =?iso-8859-1?Q?bdDsMLKYAb+vgJ64XrbR7/IOCnPUSGcymVQSW6Jj6vvKtSAyxhKKRNEbP+?=
 =?iso-8859-1?Q?FFDQZqf2ULqQLbdcRYV4mkuetfNeO9aZx8vheU3VHTwtCV0t1tTlRQwtp7?=
 =?iso-8859-1?Q?ervI0T1zleq9U6seW5zx8fslbwQ27dDVJizP5nhkEbNHda13AxQyVVIqpD?=
 =?iso-8859-1?Q?lgJmnMhxdK34Ob7ozeroALab8g5W5aZXF9+RyEpLsKlojfdfKZYG/G6PHn?=
 =?iso-8859-1?Q?Q8hI7ecsNgoK/ALHnU4us1AfiDSWHyPL8ZyLVrARDGuVL/K1CTz+32t0K8?=
 =?iso-8859-1?Q?iFcyWUNEmXg4pZP+CGAnOQ9Zl1Ztebzm58ESDEeLUWDxWo0dhxigo9eg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kH+vNed8XORxG42MoHHM0EVG968ps2TswFMidgtASx46Km0r6ft9pW6PErooP9sZn8UhnX0CZnpTOQOsa569ORpTNAlGBaBbcWCikqdyOvvlS+L7RIBM9ZXPQDaufPhPMOmZevM9jBHeG4Qe4qGoyBIAYeIE+uEh+P/oj0tn2ULtq++E4oglGo+/Zsy6yms930bAMUcm+uINQvrKP9SH4hCSiW7rDnTmr4pJEG7w0kWBy9RnljD/fjuYsBngnt2CPonuVMeabUMs/y4i9XQSEWZIimqIzhyjT5VCM375d/px9hsUM6R6/oPRqgFRMJhJecJS/lrtvYeJ0BMHBwCNCTaR3CsJwQqbC4MeU1xkHA7HWb+PwP8MMJfEOqTksBGotfnO674VYhE32Sn4BQhZGZtHyg/XjXfEMDxiVKujEWZfY4kSDKAWhXCxhEj+arZlfTmHBl8l6gv6yl8PgiQ/Yx41lcqP7xwLUTvGU7mmdD7chw/OOIFImfCI3duDGzjdY41OIy3/p2A6dT/GaS7CLcSV35Ldp0f8PkPSd76eunDGK4wxcODOlr/u8reNulJy06c+ntycX7zHC+4bKYJjJ4syoroWkCKnGeR2VPujc4aBqgBx3unlzzlL2KhPpE5glgF0xM7gRq7J0jox1dK9ly2l9+H2yjl7ed9OgBMAAXNHx5ZThBO+RbX6Wo6YRTR+l1L+PRFfYsrGoIkCpHvcxbyq/kdSZrmQY0sMTG4hVKD/lbwVk+U8Ch/WPjJMO0+qL+E466UY7Shl/suw9CxREX3I6ttm8EZ5G3zgPdK1sAXGkYWwzmeeo1hBrPtxVoProlw4dh0Z6RLzhW7TZquq255grP5mW9S+lv9pAQa7nQIMbSg89ZRBy6zc20eiQIj36wBlM10lT8PPmqbhcLj+iA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4cfce8d-190d-44fe-ff18-08daef514928
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:15:58.4537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SVHGPHKlR5GbB4iivqLtbuOVkIby2tA6HZfPk2C7ybKg+eVxyFDvHau8++3r944fqV3YgqyfRYc5Doef8KhgqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6075
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050152
X-Proofpoint-GUID: UzfT66_nLoDkw6RIvhR1SF_OPtYq2nUj
X-Proofpoint-ORIG-GUID: UzfT66_nLoDkw6RIvhR1SF_OPtYq2nUj
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

Use the vma iterator so that the iterator can be invalidated or updated
to avoid each caller doing so.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 kernel/sched/fair.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c36aa54ae071..9c9950249d7b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2938,11 +2938,11 @@ static void task_numa_work(struct callback_head *wo=
rk)
 	struct task_struct *p =3D current;
 	struct mm_struct *mm =3D p->mm;
 	u64 runtime =3D p->se.sum_exec_runtime;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	struct vm_area_struct *vma;
 	unsigned long start, end;
 	unsigned long nr_pte_updates =3D 0;
 	long pages, virtpages;
+	struct vma_iterator vmi;
=20
 	SCHED_WARN_ON(p !=3D container_of(work, struct task_struct, numa_work));
=20
@@ -2995,16 +2995,16 @@ static void task_numa_work(struct callback_head *wo=
rk)
=20
 	if (!mmap_read_trylock(mm))
 		return;
-	mas_set(&mas, start);
-	vma =3D mas_find(&mas, ULONG_MAX);
+	vma_iter_init(&vmi, mm, start);
+	vma =3D vma_next(&vmi);
 	if (!vma) {
 		reset_ptenuma_scan(p);
 		start =3D 0;
-		mas_set(&mas, start);
-		vma =3D mas_find(&mas, ULONG_MAX);
+		vma_iter_set(&vmi, start);
+		vma =3D vma_next(&vmi);
 	}
=20
-	for (; vma; vma =3D mas_find(&mas, ULONG_MAX)) {
+	do {
 		if (!vma_migratable(vma) || !vma_policy_mof(vma) ||
 			is_vm_hugetlb_page(vma) || (vma->vm_flags & VM_MIXEDMAP)) {
 			continue;
@@ -3051,7 +3051,7 @@ static void task_numa_work(struct callback_head *work=
)
=20
 			cond_resched();
 		} while (end !=3D vma->vm_end);
-	}
+	} for_each_vma(vmi, vma);
=20
 out:
 	/*
--=20
2.35.1
