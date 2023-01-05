Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7B865F43D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbjAETRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235492AbjAETQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:16:25 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FE3EE1A
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:16:16 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305IUR2q002869;
        Thu, 5 Jan 2023 19:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=dwXa96mmtavLyIPWSQPEFi0lfaZOBC7s5fNRIY0AmIM=;
 b=PLcADLLO0+pyQdtXtFXHL4EsnE3qvx+YyM8bN/POfMUlVHRuecWCQ5Ak+M6NPLTqAMQw
 6Zq0yzNCYjw1bJPW1jhuNMcce5WJSPZOoU1P9fuv2NR2VgxWWKVHqIb2GPe0bYLzMbAt
 0efGvP16yqQ9SgkOtClkbUGHNl4elf9oq/X33EYiH0JpdpXSlQQ7X3KEhVvFWuHH2aLf
 AtgxF4YemIn0h/QMFag9soP+w/b1G+zPJtLxeJwWHvqx9BY1YPNjv/V6oDeKoOmGKMSh
 YeaK+TNSczr+VbtOqLhs+vpJ2oUmv8YhKcarhRiXLnIS8bBCQPu7D1ZOcswV/jWKG7Wo aw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbp11q06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:03 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305Hvlpl023372;
        Thu, 5 Jan 2023 19:16:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwept6m1t-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPHhQ1e6FZo3t7CH7DEJ1OGARdN+wd13ZjDbjhudfCXEiVRIFo0YYW3dqmIbuTl6sTsj/IRgrwUw//v+wTKFE1rF9qu87AXeBE/78iAhDIxtXKcyMBdx52sYpCA3/m1U6VdWo2VEu8aCG/MOtzSY/S0jyIfQkBwgAuTG/WoSWgyo20IlGvaKkCn1aiVO4bhhMHMws8VyAXPuajYUrYC/e59bnGflPgoCOtqUvZMbKEQIxNDU1Af0JudFuqrgkSspQPIJCSHopn8STdSgtVf2XdK6R/mqUnzz5LJkcU7xXaqMxeDN0nyyWz1ZzNCX/+aICP92z1EnmrVEMOrBZ48BVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwXa96mmtavLyIPWSQPEFi0lfaZOBC7s5fNRIY0AmIM=;
 b=UfXXUjwF0mM1KR/Hs3HTQVxhSMJa7pmYoMDAt3/yv3psmEp+EO7C+M5+c6oAMNlR8ub+qMcieYNwFQKHHfiO/c4j5SXJrzjJEvzqLerh00Z2AjPPnXr+eYWPk6XCdao6jIFrz8ulRZ5PBxknwjhNEAuLOcJLl7B4vYz9Cn7+B8IKtEf4SMxwyzKVKjWbNkR9aI+SurRyy435SiQkUrhHT0DJGGGEQLk0mOCSag1RMhqGGOTkxPCzV/bu/AVznZRj/V+HLuuZWRSlz4arJMoT2Rjb5z6NpQ2PnU8phZXWd5u3m8UyOzDGZHGNEKUCrijaXoYsLoY43zN1Nx6kX9TebQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwXa96mmtavLyIPWSQPEFi0lfaZOBC7s5fNRIY0AmIM=;
 b=GGohEQpruRew4yz3aNgTHFJgz1v3vWovL5Px0BsOWGA+JzOmWhhnaHWtux/rW1ri/QuWun9qqN1NgGk2lwKHz+1gJL62yxy6MEHg7vYph6L/LsTGSWN48SG7V07t/iANsnqBYyyEA+ydVC/PWDxDb8Nl6jf6ng7s5oIhXQrwQ1s=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6075.namprd10.prod.outlook.com (2603:10b6:208:3ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:15:59 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:15:59 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 14/44] userfaultfd: Use vma iterator
Thread-Topic: [PATCH v2 14/44] userfaultfd: Use vma iterator
Thread-Index: AQHZIToj7J344xy9ZUKngr7HlXXmkw==
Date:   Thu, 5 Jan 2023 19:15:56 +0000
Message-ID: <20230105191517.3099082-15-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|IA1PR10MB6075:EE_
x-ms-office365-filtering-correlation-id: a72267b2-f7a6-476d-7cf1-08daef514779
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V4DFrmGTUV/7q0fI1d4tBZ/LrsqS0vF78YgvHpb//SZkjF2hEgB9sn1+jVaCzjjem39e0ZRDFJU9eN2uxuxAgGhHLbAoJVt1TJQdvqEkrb5GucHT0OmUbVOxTngdZ/bcpvGZwyNVwrRLIV/SMIvam2M3fxbjBsacy4/iZSTnqRplsgnZh1K0UtG94UAJfZ1Br5i10PvaEMVrS4tAWwUOM1DkwOWUkaO3GxW7MMSFyrd78pEb4fthjSJx0TXswRfGgo6YeREmwetfumt06qYeAHXRdF2gQGIWPCxS4IDYfHkY1NUmkqZky4Q5+gGiy4DkIvIKV91e+uyWXrTb/tnXQsPYm6tqpyAiMCp3LBIwL84KKA/QHTcFdMTrygsN4WcTOXOnenQzEeJjEDZj6pdgnjQglrhsqmIpv2X/V4LC5WCxo0KPbpUxI2Z4bl5PEbGBCIQ0+wAJC+/BmCJD7HhQxkkCDPoRa79O7Wt+nFxKxEQqgW4YWoUV3okeyDbcROUz9EWx2xjYh+s2p5mrR17ert4bI2bhdZ+UiF/DmqEhSlgmSSe0WRq7oIfab48FljeFPpPDjY/OE5aby55vJMsHk3J+P/Ecz9UzTe/dJ0+QSb0qHetMyC23gxwn48oETsM9kDtP78JwRGGBZlvhFABP6lMf45q3ZEDEgKdyzSa3r3tYAk1rtOO+8vJKT5SaN3OGSCYROooNc2RsvrQ6hCNFpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199015)(38070700005)(122000001)(91956017)(86362001)(38100700002)(8936002)(2906002)(71200400001)(83380400001)(316002)(66946007)(41300700001)(5660300002)(44832011)(64756008)(1076003)(66446008)(6666004)(4326008)(6506007)(107886003)(186003)(2616005)(6512007)(66476007)(478600001)(8676002)(26005)(76116006)(66556008)(110136005)(6486002)(54906003)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1CGdb4qv35GxRokIflOpSYdMQpcbbCK29ZRk7v1BRTqMiB6N35eorPoXxM?=
 =?iso-8859-1?Q?/tegktEDVxn5nlsjrlBKzJUkPiodI//NTphqGi+Qu1dWAk4jqpuu5trzKo?=
 =?iso-8859-1?Q?JzuMHcYY31x6fE3t8tmfGpiBtnsjnHKqstAMlUqkxzZqkJUMOBk0ullukj?=
 =?iso-8859-1?Q?LVTamDNoaoN6s5mcbbjmPigDSS/geqKNrY0k99r0UfdP1w/S/o5UEOK/aN?=
 =?iso-8859-1?Q?dJr/f5mjcjGCPzuKHDjLYweV0LGnFhb0bNuapnKcMxY8v2PU8pbodEhKus?=
 =?iso-8859-1?Q?GoK+fS5ni4JjWal1cBor0RLnT2+FsoPcUi+2w22sO1jsIFYd/IMfRkIZ0L?=
 =?iso-8859-1?Q?JkYy1CTyX3Lk18BGGwazF8LXltaOWLBky8BNqLipxfpZp70QDzFfLAWHU7?=
 =?iso-8859-1?Q?MuII1Q7CaXLsZUaff4PbWHgzYv7hICKemJ7DVyWYdcX0V/pxrviOxoju2j?=
 =?iso-8859-1?Q?R4FmNBlpl/JKXoxZUIh+P8qMQpTOslH/oZD7I5hk7rsyskGs0tncAmXuS4?=
 =?iso-8859-1?Q?T9ptWp2bVtD3FgpfdQJZEykxYBJaW5cc6mrhY+aXli/89Y8G2o2wYgnXVR?=
 =?iso-8859-1?Q?GQ+bJh8TVunGIBb2ol8wG+Dp/yHFaZnI3I5g+lLKX+RFnG7st7+8VVkcEu?=
 =?iso-8859-1?Q?/nmwYTDhE4icCLJbI6+fOMC4IAUiZ38wGR8kNg8facv44WztIley7FIPXf?=
 =?iso-8859-1?Q?0jB1trn0jEYMc+arrRlugv0Nbt6zQeUYGngsNKv3pb1nVOgtnzHJg1P/cZ?=
 =?iso-8859-1?Q?LNF8tjK5iW9tYUGGfqKZHNKTYqseWU2SCuHYvkb+xh7jdaUcDHFBfX70go?=
 =?iso-8859-1?Q?2XS0nQi42YBqJRQ69X4AtOF9/edxI6f9bHOnBkXawescSdXcN53SQFRblv?=
 =?iso-8859-1?Q?fRnQveC7Pbma0tzXoCexNFC0U2XRAynS34Hp2EBNA+Vn8S+RAG9MM1Ch3C?=
 =?iso-8859-1?Q?RDLrnFFAX33GYElilDY7m9Ruihrk0TL9NVcx4pVcDx9rPqjwTlPsueBvTt?=
 =?iso-8859-1?Q?rJnozMQXX325wim9zEwNuQJ6jfgnTsquu2o8Ki7aXaqjKqkgnj/UfAOKnK?=
 =?iso-8859-1?Q?EW9xqh8ylEfygvZh+B+FvaNXcf3dHxcaeA5x96lsMhY5CUZdlF2w02gk20?=
 =?iso-8859-1?Q?+woOg05JzgkJDEQXN6FFlZMtisjlQbIR7qJ6dqSa/4lM83yARvYFK5P0Ei?=
 =?iso-8859-1?Q?HsSx+839Ke4gljyLqro8YoZuTpMnnTAlSqczt+nvhJlTEEkdW96hO4Fet5?=
 =?iso-8859-1?Q?seRx43LbovrtSvnqv2izpR76xqYZpUdsjc2/p+ivN1SI2IMb/sf2IdXUPT?=
 =?iso-8859-1?Q?zQ4wK2JUBGYbrqwh4xo/coe3lsHFAoJ/AyOQe5vjJLPB1fmpD1CgiOlJtm?=
 =?iso-8859-1?Q?lOSORtyNDkL4zKBDCPzaNVCICOqn3GaDxhm3pAYr3p7OgJtoEN3fxdT1VS?=
 =?iso-8859-1?Q?TB7JHERePkepJdiov5iXe4WdtJLMVA+WQsOC8xTqPGzGzy30GdGzi2bhW4?=
 =?iso-8859-1?Q?yFIPYYXoNyq/WSM4aEkzgi7+WcGg900zAHznVadFRTvgKa63+ucRZTAnzQ?=
 =?iso-8859-1?Q?+4FikQZKhJ0ata55lZ2emFEv3Cg8rQSinoAHU7HAJyDdKIRMFldWH31oST?=
 =?iso-8859-1?Q?AjHfVtaho6a++baTqC3fbGkHGXAjv2qMaMyZ51jqgGW2Ic1RUlkEkHqw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Eqne1y3o/cdIdlNVOp8qTpFYn9k9TI3ewcQ0lTKjpEOtJaPSDc/ZiJZwXOk/jN4KirY6wfL+fiea+Xpj+JNKGoz2VSCIX/Fzj57Mgr40AE9X/fuM1I0BW+pO0Ai5GCJZeM0OsSaSse245vZr5Ly7133wHIsczcv2odgkp7TnWmYd/gxo/5O5nKfmafgUujZ2NKbY4Sreqbv94oRdGYbqCK8ySOCBcipKMeBZJ+BiWtTI5NkjIdpFD1I+NuuM7p/o+3y8+zoLDAhBY4qKES1UEPu8bCSF58gCFpyYnvp78Lx1qbvROp+NfHhl2sk3oSESDR1kXOibmlmYdM+9dXdM0Ff87SIHmn6QCeoW2PExj3tkXi/y+9vc5v53CVjEZU6ErX2fa7koLfapMhyCurTSl56qaJpvdJl0cFGQI1MySPA+FWkyKgVPkUwZ7w6bwCgiiEDyAFDvBP87UQo4hloXO8g88E2HQiNSuGTJpxc4tATSYzIhJFfr6i/V26X9JL4KfspW3TLWNcxHYOSDrh3wm7dVw28t2gkOte6RQiDKHKo6waW0t9u8umi22ofwMpNzJkWyJI+Dvf6+7t0heczfoAMpU2Z88cEVMTO5DfVY4euJB+A2Bq+BmyrCPcuU52NwjdIHpXXzyFJhwKc1UQC2Sf5RbtW5WcUP1YWHsQ7bUxphXwqJDvGKoNUYdtRXl0VF5dikaXB7mpHtYhFUjZnLyrcXmHlW8Fo2zLGDqa4Z4PUvUFjIcUpICdaiASJDc4N0gCYKhGXTkXTVaLwVZGEfNoG9wLaNx07MIfQey9BXHQ+u1BaQAEwPF/9UklOfF/WDY+eieG5+16nUxOdZ640Ks3Vh6mfIGk4QvzskrnW3mNaR3iFqtHrO+uStcoO7E/vtyqgPj0iW2RlUGdklSyAN6g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a72267b2-f7a6-476d-7cf1-08daef514779
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:15:56.6725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B/7AxTu2T1WGR+5sJG5F2/Djr/XxJs/7HmPPxQ2idV7tmWxjNfiG2Wm/I2izm1A7/z+VRsNiCMj6Z3+sNRI6Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6075
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050152
X-Proofpoint-GUID: Kf5VJVqHXVNvfwtUZuQi_U42x4-pZhiu
X-Proofpoint-ORIG-GUID: Kf5VJVqHXVNvfwtUZuQi_U42x4-pZhiu
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
 fs/userfaultfd.c | 88 +++++++++++++++++++-----------------------------
 1 file changed, 34 insertions(+), 54 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 98ac37e34e3d..b3249388696a 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -857,7 +857,7 @@ static int userfaultfd_release(struct inode *inode, str=
uct file *file)
 	/* len =3D=3D 0 means wake all */
 	struct userfaultfd_wake_range range =3D { .len =3D 0, };
 	unsigned long new_flags;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	WRITE_ONCE(ctx->released, true);
=20
@@ -874,7 +874,7 @@ static int userfaultfd_release(struct inode *inode, str=
uct file *file)
 	 */
 	mmap_write_lock(mm);
 	prev =3D NULL;
-	mas_for_each(&mas, vma, ULONG_MAX) {
+	for_each_vma(vmi, vma) {
 		cond_resched();
 		BUG_ON(!!vma->vm_userfaultfd_ctx.ctx ^
 		       !!(vma->vm_flags & __VM_UFFD_FLAGS));
@@ -883,13 +883,12 @@ static int userfaultfd_release(struct inode *inode, s=
truct file *file)
 			continue;
 		}
 		new_flags =3D vma->vm_flags & ~__VM_UFFD_FLAGS;
-		prev =3D vma_merge(mm, prev, vma->vm_start, vma->vm_end,
+		prev =3D vmi_vma_merge(&vmi, mm, prev, vma->vm_start, vma->vm_end,
 				 new_flags, vma->anon_vma,
 				 vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
 				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
 		if (prev) {
-			mas_pause(&mas);
 			vma =3D prev;
 		} else {
 			prev =3D vma;
@@ -1276,7 +1275,7 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 	bool found;
 	bool basic_ioctls;
 	unsigned long start, end, vma_end;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	struct vma_iterator vmi;
=20
 	user_uffdio_register =3D (struct uffdio_register __user *) arg;
=20
@@ -1318,17 +1317,13 @@ static int userfaultfd_register(struct userfaultfd_=
ctx *ctx,
 	if (!mmget_not_zero(mm))
 		goto out;
=20
+	ret =3D -EINVAL;
 	mmap_write_lock(mm);
-	mas_set(&mas, start);
-	vma =3D mas_find(&mas, ULONG_MAX);
+	vma_iter_init(&vmi, mm, start);
+	vma =3D vma_find(&vmi, end);
 	if (!vma)
 		goto out_unlock;
=20
-	/* check that there's at least one vma in the range */
-	ret =3D -EINVAL;
-	if (vma->vm_start >=3D end)
-		goto out_unlock;
-
 	/*
 	 * If the first vma contains huge pages, make sure start address
 	 * is aligned to huge page size.
@@ -1345,7 +1340,8 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 	 */
 	found =3D false;
 	basic_ioctls =3D false;
-	for (cur =3D vma; cur; cur =3D mas_next(&mas, end - 1)) {
+	cur =3D vma;
+	do {
 		cond_resched();
=20
 		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
@@ -1402,16 +1398,14 @@ static int userfaultfd_register(struct userfaultfd_=
ctx *ctx,
 			basic_ioctls =3D true;
=20
 		found =3D true;
-	}
+	} for_each_vma_range(vmi, cur, end);
 	BUG_ON(!found);
=20
-	mas_set(&mas, start);
-	prev =3D mas_prev(&mas, 0);
-	if (prev !=3D vma)
-		mas_next(&mas, ULONG_MAX);
+	vma_iter_set(&vmi, start);
+	prev =3D vma_prev(&vmi);
=20
 	ret =3D 0;
-	do {
+	for_each_vma_range(vmi, vma, end) {
 		cond_resched();
=20
 		BUG_ON(!vma_can_userfault(vma, vm_flags));
@@ -1432,30 +1426,25 @@ static int userfaultfd_register(struct userfaultfd_=
ctx *ctx,
 		vma_end =3D min(end, vma->vm_end);
=20
 		new_flags =3D (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
-		prev =3D vma_merge(mm, prev, start, vma_end, new_flags,
+		prev =3D vmi_vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
 				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
 				 ((struct vm_userfaultfd_ctx){ ctx }),
 				 anon_vma_name(vma));
 		if (prev) {
 			/* vma_merge() invalidated the mas */
-			mas_pause(&mas);
 			vma =3D prev;
 			goto next;
 		}
 		if (vma->vm_start < start) {
-			ret =3D split_vma(mm, vma, start, 1);
+			ret =3D vmi_split_vma(&vmi, mm, vma, start, 1);
 			if (ret)
 				break;
-			/* split_vma() invalidated the mas */
-			mas_pause(&mas);
 		}
 		if (vma->vm_end > end) {
-			ret =3D split_vma(mm, vma, end, 0);
+			ret =3D vmi_split_vma(&vmi, mm, vma, end, 0);
 			if (ret)
 				break;
-			/* split_vma() invalidated the mas */
-			mas_pause(&mas);
 		}
 	next:
 		/*
@@ -1472,8 +1461,8 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 	skip:
 		prev =3D vma;
 		start =3D vma->vm_end;
-		vma =3D mas_next(&mas, end - 1);
-	} while (vma);
+	}
+
 out_unlock:
 	mmap_write_unlock(mm);
 	mmput(mm);
@@ -1517,7 +1506,7 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 	bool found;
 	unsigned long start, end, vma_end;
 	const void __user *buf =3D (void __user *)arg;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	struct vma_iterator vmi;
=20
 	ret =3D -EFAULT;
 	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
@@ -1536,14 +1525,10 @@ static int userfaultfd_unregister(struct userfaultf=
d_ctx *ctx,
 		goto out;
=20
 	mmap_write_lock(mm);
-	mas_set(&mas, start);
-	vma =3D mas_find(&mas, ULONG_MAX);
-	if (!vma)
-		goto out_unlock;
-
-	/* check that there's at least one vma in the range */
 	ret =3D -EINVAL;
-	if (vma->vm_start >=3D end)
+	vma_iter_init(&vmi, mm, start);
+	vma =3D vma_find(&vmi, end);
+	if (!vma)
 		goto out_unlock;
=20
 	/*
@@ -1561,8 +1546,8 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 	 * Search for not compatible vmas.
 	 */
 	found =3D false;
-	ret =3D -EINVAL;
-	for (cur =3D vma; cur; cur =3D mas_next(&mas, end - 1)) {
+	cur =3D vma;
+	do {
 		cond_resched();
=20
 		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
@@ -1579,16 +1564,13 @@ static int userfaultfd_unregister(struct userfaultf=
d_ctx *ctx,
 			goto out_unlock;
=20
 		found =3D true;
-	}
+	} for_each_vma_range(vmi, cur, end);
 	BUG_ON(!found);
=20
-	mas_set(&mas, start);
-	prev =3D mas_prev(&mas, 0);
-	if (prev !=3D vma)
-		mas_next(&mas, ULONG_MAX);
-
+	vma_iter_set(&vmi, start);
+	prev =3D vma_prev(&vmi);
 	ret =3D 0;
-	do {
+	for_each_vma_range(vmi, vma, end) {
 		cond_resched();
=20
 		BUG_ON(!vma_can_userfault(vma, vma->vm_flags));
@@ -1624,26 +1606,24 @@ static int userfaultfd_unregister(struct userfaultf=
d_ctx *ctx,
 			uffd_wp_range(mm, vma, start, vma_end - start, false);
=20
 		new_flags =3D vma->vm_flags & ~__VM_UFFD_FLAGS;
-		prev =3D vma_merge(mm, prev, start, vma_end, new_flags,
+		prev =3D vmi_vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
 				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
 				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
 		if (prev) {
 			vma =3D prev;
-			mas_pause(&mas);
 			goto next;
 		}
 		if (vma->vm_start < start) {
-			ret =3D split_vma(mm, vma, start, 1);
+			ret =3D vmi_split_vma(&vmi, mm, vma, start, 1);
 			if (ret)
 				break;
-			mas_pause(&mas);
 		}
 		if (vma->vm_end > end) {
-			ret =3D split_vma(mm, vma, end, 0);
+			vma_iter_set(&vmi, vma->vm_end);
+			ret =3D vmi_split_vma(&vmi, mm, vma, end, 0);
 			if (ret)
 				break;
-			mas_pause(&mas);
 		}
 	next:
 		/*
@@ -1657,8 +1637,8 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 	skip:
 		prev =3D vma;
 		start =3D vma->vm_end;
-		vma =3D mas_next(&mas, end - 1);
-	} while (vma);
+	}
+
 out_unlock:
 	mmap_write_unlock(mm);
 	mmput(mm);
--=20
2.35.1
