Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D933663C59A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236263AbiK2QtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236267AbiK2Qra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:47:30 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09F66CA2A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:45:31 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGPi84017341;
        Tue, 29 Nov 2022 16:45:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=7KHVMi1t+M3SCAsyGgOyuruydr2QaleFx1gZsEpJNpY=;
 b=O5Y7pIAYS/VK+9fDEn6fugDmhzSB3qJtiWH0a8XwfmddG0DiFDk1Rnvz6QmR4ty2E8rV
 R8H8O8r7FBhAGpqR7NXJ4RR54k55eWUhl54eczKn5jfrVuRkAsoXDVSin9+BifrUKiYO
 g902Zg3v8nTjgI7O6SxeKOvNioa1AS+C4xu0c4QepuvpLiN/tFErGf852Oxc4d6/tTGu
 yuzaCYJ6K22mzrMqYRxQF34BmZLahqYEO9LTGjJb+vy0cGKmIui+k/y7rQ9Ec1bjwCn7
 SEkuf/xLVB1knNtDuU62Z3fLByf2KRkGdUE2TG+b9mOyrOT/HPlcvDXRvhsxGdqtp/gK lg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m3xht6hr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:45:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATFn6v1028010;
        Tue, 29 Nov 2022 16:45:19 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m3987f3xj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:45:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfvpnB1pPwKlWlAbYzCESaQguddpmlZu1ND8ZgHMCiE+WxwJ+SC3aZ0TYmxkre6ESYL69yIOe3Z/EPVYjHL3jcRuSJWbgyr8+x2/1T7UpRAlr5XcKKi364QCZkua6x8yNKpc7qYkEn8it/gouux2QqkJwdRbHSTH1eDqONtQ7zh+5hgQL4UFOFo0hpuU8WX9YHpszw6d7teR7FuJ+rOjyo+XFI5I62bMC2PpMipOjP+UDREbYQQ2US4zk5Tx/oJqnLcMLPZQXWYXZNbBjxSQlDTTbuF7ncTdwCF6D1KVeW4beJKJnQcbil7Frg2pY/Jv0UOE9W0211T3k9Q/Jh/BVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KHVMi1t+M3SCAsyGgOyuruydr2QaleFx1gZsEpJNpY=;
 b=SoPj1+MhXjJ8QxWJ8mlZh3gorn56Ivc2D3DwxMN6aRX728DiQRaWQhXAyt7o9rFJbzY4vSPwBGHjUdofVTRX/IDVs1cYQSmGarkpCXmLuqtc4JA7LaObmr7TKK1TLEryACd55Oh+plZ53vFz5/jqPEoqGaFOs9BJjyA6iSyW549EHsj0qI4KZ3M4c053EqjhJdhWU7clUnJC1iNryNaYx7Uzt6DdeVBnExRIKCKFrbquThnZow5KRs2pEuFKXJ7P8OypnKHKgR0AGgVUenoNOgpptaCjVeUEAjY/pH+s40IEnBu/nsBGXaqZUoOciL7uYCNQrD1/t7J0Iqw705pNjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KHVMi1t+M3SCAsyGgOyuruydr2QaleFx1gZsEpJNpY=;
 b=lALT1rvu5A4xr551AX6DZFNkHSII7GcKE8EsTqV4ObXwczAjshb5xzJ9UDdYkrx5aYcZb+L8l5NRNEUv0qKqA/of+Y0nC2IFa5XEu734TH21vk1GwnvWuxmvLLRLCVhXr+HwkpR4uR9iFAn3LE/wqS26LcWifcdoq8Im5FNHrmI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY5PR10MB5937.namprd10.prod.outlook.com (2603:10b6:930:2e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.18; Tue, 29 Nov
 2022 16:45:13 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:45:13 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 43/43] vma_merge: Set vma iterator to correct position.
Thread-Topic: [PATCH 43/43] vma_merge: Set vma iterator to correct position.
Thread-Index: AQHZBBHeQRDugZrqUUmfQ8gAkkJUNA==
Date:   Tue, 29 Nov 2022 16:44:38 +0000
Message-ID: <20221129164352.3374638-44-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CY5PR10MB5937:EE_
x-ms-office365-filtering-correlation-id: 353669cf-5ce1-4559-246a-08dad229161f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rfg48Ud/P7IIfUP5URbfkOCNGIn8ySDCVYQI/OSB1DvXzUp+80rH9PkO+V93DTFs7EKCye88Dt4Z5xrSuCCnc9x46odaLuQbVxUY/7b+YJ62AE9PuZdF5PTmH42+UnpQ2RCuBFjzBpDgKoL3FF3ZnaNQV7iYS2/l7bKylaaDyqzC/xMnuiKfvKtT10IfDR/bzJKI8UAXpWHDrmwQpmyugespET56xUwk6PzJQIqEIGsoW/sPQCpiVPpX5p2wVHAh0bbjxvwZAXqfgnzH4FtBk5fgJAFshVzMddidHxEk5pGsMESteGfxbLpCeA5O6ShzcrmN5Cs3iWK6dNdg1afxhdNr2ezVINzxxMmnIUTKBxOkjMx/vSBXVc3pnvyh0zrFLAeJtiVduVwPycunIYgU8vvmtk+bA71jpzjPG+gBMsMihdc1us+V2t0EQuCfZsB04/cd2+L7cgSMFEXpvuijg9fQYsxwMSB8tm+Gkoz8lDJvAfFA4qLrvZ2vhdMLGtZaY5LSqcrCP+n4ih+CHlw3NPp7E4r2Hc38TteB5H4SsyW8aSrgDCyFWLqGGbmpg1EfoBI3WDaWeFNxm83LtJcfbRsgf4JF5X5y08R7qaujWVPzac2qdoQMf9o9Wi5nKeQzFSDoRNEQYn3cEykXjdtOHZyVaRW2qoyapRXqEuTd9BltKSHfr5q6Dm00prilKS4n/ZP0sxatRYWeoZVfH4KIYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(396003)(366004)(136003)(451199015)(8676002)(66446008)(66946007)(86362001)(66556008)(66476007)(4326008)(64756008)(91956017)(2906002)(76116006)(110136005)(54906003)(41300700001)(38100700002)(122000001)(6512007)(83380400001)(186003)(8936002)(1076003)(36756003)(4744005)(2616005)(316002)(5660300002)(107886003)(26005)(44832011)(6666004)(6486002)(71200400001)(478600001)(6506007)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WkISHko2jHxQp5ZPsLiNjYq6iMxO0DQXjfnHX6i34cXBTfaCjcf360CF1i?=
 =?iso-8859-1?Q?4QoDemPGqfsSB2F66H8QnVlTBgvve/m1z8QfbV/FMX8RMx3eOBMhrq1aH/?=
 =?iso-8859-1?Q?3ks72jZ+agMzn0INaE2my59g44oGyd8I1kZuY5oHehirSoZTO+0ezRGJ8b?=
 =?iso-8859-1?Q?J+5HE1w2faCO7AoSClKBJoES+kuSTRoQ28BkIFqxhfpnFcE1kgiK6Zw0n0?=
 =?iso-8859-1?Q?UHuZ6sd2aJoL31awqxghXyOjcfm4VezSxVJ+XMmQe2LO+oRMjhBYLyAHoY?=
 =?iso-8859-1?Q?xDGXEKzH9XMO2aRhVpadhWNBxwRrlsDq1eaojz57TobBcR1BRTOqkZvSRY?=
 =?iso-8859-1?Q?HAjZQjumnjhkUtTm4Zx2s9r0+CH3yIMIog4Q0FmHUdK5LR3/iYMQtv/oNs?=
 =?iso-8859-1?Q?jMxHLOjlHzDOfx2UKITjX3fTBCMkApaY2/KDPlRJHsgf6301L32hXPHzXJ?=
 =?iso-8859-1?Q?8WrpC/B+FXizhuhuSET3h4zgiF4RBA89vQUZs1xGI1seNJIhe4zY7eeLNy?=
 =?iso-8859-1?Q?xnYPGsavRhDZGV9OPE++CQBGOl7IstfGWy3YHBon5qsaIp4meTLb5HCiWs?=
 =?iso-8859-1?Q?AdS0Nbs656DOxrk2m/yihCBe6v1BuXo1DxKAa5JMrqH+sUZthbro8HLqSD?=
 =?iso-8859-1?Q?gIGQ5mTUhr3yW+NMzsWTc0KDh4DCAQF1TxL/8BJCrewQe0Zgeg+cE4Nlrq?=
 =?iso-8859-1?Q?q9ieqF/tvT4KFwVUPHTfT9C3j3YAm5qxrUmq/ZKlZ5E/FhlI53IKj3i9CW?=
 =?iso-8859-1?Q?RspETtFPGmB0bZZWQxgtlDGGSqkWYIsLYpM30W3DHYhjTjvbMPsD6bx3S2?=
 =?iso-8859-1?Q?C5H42Ed4L7KByRTHppOPSXSBT5uTDWokSD/vmagOL5sBW6Lgje4BGW9DsA?=
 =?iso-8859-1?Q?m999c+qpZKEJ3bZHawX8dqHcp/TG7mXaJoKwa2DbS9pd/CJC53YvWi9Pub?=
 =?iso-8859-1?Q?n2cnIGI0XemEKuL6XT2bHEEuMrhQwn1J1YqMwxzOI/+FKCTsYk1ex5AY9E?=
 =?iso-8859-1?Q?cvbg7ZsUZWJP+RTL3an9+SFIQyo9R3OlyOciFQ3NaFVpyjYkP+n7X0W7so?=
 =?iso-8859-1?Q?Uacm6myy5DO5uDMl6Y3m7QBe/7h01DA0TJ3ZR4u4hUSzDLko/ZXqI6Eil+?=
 =?iso-8859-1?Q?9j/h5+jTFjajXl6GrnRzGKL3+ry/fwzUw+zcTSQm+QynoJ7lYizk41g85T?=
 =?iso-8859-1?Q?Qz5sDpyEXpUOG60VpQE59xvzaOLGfQ4zDvt1aYFC7BcBE+xqjuv7YT6UJZ?=
 =?iso-8859-1?Q?Gb1/9QHPUHmPuQlDvNkAfFhYvQuwPwYbxDpALAHgnDU0E1srY38FK9S2OG?=
 =?iso-8859-1?Q?JigH6/rg0iFM+ifJZ8NPIyZVJk9lxJyV/IojWDmG3d+0c/ETGfnuj8aFij?=
 =?iso-8859-1?Q?MMtasra89hSEof/Sniy8hVond06a3sKZaRtHWLWKhqGkcrE02BxSE42RAb?=
 =?iso-8859-1?Q?UET1MjFmr3VwXZWUMA0WH9sGF6IEhWPqxChPjjVjguOaXNjRUL2sH2bu+3?=
 =?iso-8859-1?Q?4ljobmAIuNfya3vTcMDZ0vdPNuLSUO/UEcT2hfCrCo24aLbrvBG24JD+m/?=
 =?iso-8859-1?Q?exhryFu2VJPQnWbw2SVKjcBp+IcQXZ8kgqa9w6QUKwIKh2X/PAd2kTsOlq?=
 =?iso-8859-1?Q?Ev4NEaa5mh68iDSIWEEwQ2xrn6jA9u/9wkWJc8Qm6ClnHZRgg2XP9JNA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: odlxoAfQSPbOcV1Xk2Ro3WuX8WiK7giz01Ck7zP59uN1m1dOZZV6Wq/ZCi6vlqTLNC5cYuvapOQtZkzJ1AiVFiIheL19E4X9vNXoQSyayUAU/cI/bFMJ+Jh9+09yVrCaBrU7BADWRd/VAMb6k81FOn8zd0elc6nR2yXegebyLvCKXTGQvzrP58v2dQdfmJs8qDafoKFcEsfcTmieFe5K/wx+sVlTRafjvenENLafmkONf7QDnPCRaocCy5lyVJPP7l2RfRY+h8wpHR3vqiNgYUJA7W9lciTrRzGQU1o6lC19x2S66cKx1DgFGl/tmrVaNle/X7EMm015ZcV1EB6zpwIYQTyUEZGjzjreQyMI7JNu+twYhCd6e0R3R9wWk2N1ViMewQgtDUH2l6fuS1+cUTtoUBrx/NpSEWZno04FN7wi+1/FqUQO2GgN2LsxwICG3qCdbHB2MBMsD8YbtRr3MkifWsw2PVju8KjIYikw0XD1W9Jo6K658TUwPV1xJXFIqyUe674nL1GYS5mTumdFj55+0qNVnoCXMjPDnXhJaYpfJvaPhO7Upj4CNtMeWC2SfoZK89t4bK3Ci0MRjNZvJdYSTImYWPv06zylXzdf4XZ1+6bx420UKwNUnn0gMrPiFrX1ZJ1iuhZCkQgir5BMLIRC5ShKbuEkpQ92ySarWv9pzAWmZ4D333JEwvY2w9m/QaLuTZA4MDx7wsJbOQ6JbN0xED83vUw430NrTAsU+FhvSJJO/PerRRdObwtVZLUP9/kCO+G9ayjZc5NN9+9LfpLstFpxZ0Y0/K4xJ6yM6XTLau8D4oTu2rwF/ER3ZYDoPeAMpIkgWavPgSCaJKlqQ8kxfmNxXk+35iPB1PNxlFpvL+OR50bl9KrO4t0bWsu7RNrw2L+jG7Jna3PzUzeQjQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 353669cf-5ce1-4559-246a-08dad229161f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:38.1439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wNSC3ACBQYKEV3dkq3uyTmt/X0lflFx92t/6gJyDj/naoXyUXvW0dOGhx4QLikfshtmnyYrMMa9RHxcwKV33kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5937
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=984
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290093
X-Proofpoint-GUID: 6MYWNRrWKV0Zx7-heKHFeRCtPkqJcHrY
X-Proofpoint-ORIG-GUID: 6MYWNRrWKV0Zx7-heKHFeRCtPkqJcHrY
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

When merging the previous value, set the vma iterator to the previous
slot.  Don't use the vma iterator to get the next/prev so that it is in
the correct position for a write.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index be01ffb96ecf..e14d8bc9c59f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -992,6 +992,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *v=
mi, struct mm_struct *mm,
 		    && can_vma_merge_after(prev, vm_flags, anon_vma, file,
 				   pgoff, vm_userfaultfd_ctx, anon_name)) {
 			merge_prev =3D true;
+			vma_prev(vmi);
 		}
 	}
 	/* Can we merge the successor? */
@@ -1083,9 +1084,6 @@ struct vm_area_struct *vma_merge(struct vma_iterator =
*vmi, struct mm_struct *mm,
 	validate_mm(mm);
 	khugepaged_enter_vma(res, vm_flags);
=20
-	if (res)
-		vma_iter_set(vmi, end);
-
 	return res;
 }
=20
--=20
2.35.1
