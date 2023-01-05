Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7F965F44F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbjAETVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235674AbjAETUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:20:23 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA2719039
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:17:44 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305IT0r2006649;
        Thu, 5 Jan 2023 19:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=v7b7Y0VoKjU/443c479HAnuhJa8h7cdUlvoZe/Bl8Hg=;
 b=Y68xLo2cg20PIR5TQ3HaFtSIFiuCJ74Vv/yhTEdZZhKGzb8MtWWlpf6FbfWJfu/Psi+4
 yTs9kHzDXl/iXR3qhtNE9vhlw9d/hRXiY92mG4kCoeBOQUMpV78W6anp33UvnmagfVWx
 LRkAKZ3na1FVDY9yPyR5V8XRYCy5VJswa7aRtXn13NxQl/FAg322wT/BLKQ4N9Yz002f
 9gagkH7UJOeuyAzSKcauNRrTomNkBF/mPIXiqxa80S+QEDqj8yj29zNSbJOeDsfrc9Vn
 HnOEdhUuhqqbLw+FiTB7TicsBHJdBfjAeGzkif3TO8Pt6CWTe/VMMmHBg4oNzrP2IieR YA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtcpt9mth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305I1EPi033688;
        Thu, 5 Jan 2023 19:16:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwxkf7u5p-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yz/bOPaKG9GImPZ/sBR7Z4mUWYBx4YySmjL4dCEjvBYLT24NLTj5A3f9VivhT6x54fwPJOZVuVVhbt3CGO1l39+XB6HTXbW7wQXrfeel6QJLe6azbP+PkGyQbuFvNLeqb/fRIQXdusyOePM9QjXJTvyy7p+E9Y1y8BR1eS/DTjVFYL7wSout6/x5CbAKdfqDRWURGOuFrGUDDA3BirOLhTquFN76zic0E4brrm8vdMZWENCaMEgg1kkE4hgpv/qPQajweJWLM63JKmIGoH0wZfBEP1kmgxtMXPizV2f98zb3J80U28KzMcHKq2NMK7eG5aZ8CTwG3MMqH5ad6yKLsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7b7Y0VoKjU/443c479HAnuhJa8h7cdUlvoZe/Bl8Hg=;
 b=eNcBQT8YcwLrChCPQBoMHNHYRs3AUvq3LC1tbmBhgQ+NbJ1ABgEo/3GRpv1QmylruLbN+lLPFuL0pap5dEvJCPT4JUKMAg5zEuUiYq6zP7J3i8pV93Q8pGomKJDSXjFOuMdSWtoA051jT+GbikksTXPvWbDTXdGAhIj6lvsMoLP6Xcsy3OGyOlAdH/IBETmejtEi97R8Rp+TpstpK1EZime8LRmQqZHib9nJ4/AG7CltVlZE8+PDXQdhIcdIEaXTUXCqJ8Db3hpB3UfrJQ6yoIOcTAKX+eHsKfRCJcTQ07Uj7RL394r7cfnCXIy6jT5A3CptriMsQI+RB7Xs6yl96w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7b7Y0VoKjU/443c479HAnuhJa8h7cdUlvoZe/Bl8Hg=;
 b=Lqw+QsUklM09aABmH0YH1vZZz9Vhm/Lp5XHS/nvcly7cES3SMsBU4zGaY6oIKXVmenBV8K/BGjrX+qI5igqjWvbYF30JVv+iOII7c/jZSiNegmXIMsnL7xJbWsB0wvr9GlgSg2nJzSnxDeRm/pEKMza5pNqoUfOm2IZ6q6kFdIY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4791.namprd10.prod.outlook.com (2603:10b6:510:3a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:16:38 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:16:38 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 32/44] mm: Add vma iterator to vma_adjust() arguments
Thread-Topic: [PATCH v2 32/44] mm: Add vma iterator to vma_adjust() arguments
Thread-Index: AQHZITomrGfg1Vg77ES0gv5xU83u9g==
Date:   Thu, 5 Jan 2023 19:16:02 +0000
Message-ID: <20230105191517.3099082-33-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|PH0PR10MB4791:EE_
x-ms-office365-filtering-correlation-id: e5670280-e373-4eef-198d-08daef515e8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rxs4xqN9tCdx5cF3+sDF2vD+F3q1J9/bTAa0yKo92XDByqzn6qRFbBWSDgEXiy8UhFrYb9y/poPUShr5KWJWXSAfuR+gq+SeplqGuHzPzCPJBAlsXiT/UysqMyigStzxemxrsMOd0k2b+oUVDMxw0vc+WN9bxA7VB7+DD+smsq/zNillsFAC+nBiX0lKtpIsF/R2i8UGSNEP7rEnEJGZ9mGPRzXZRz43LLcc/KX6SumHc+aVre3pc1iQ4lPGb9sJ2XuVWV9/gY81TiH4SkEAFw664U7Dr1wqXkuDPUgdkH0TcFV0EViNwiApe9MTvkIfSDacLkjFQU8DpignmF2eJ68lYON90mfCMuTFZNsmfNGyPYQhas2PBoHfgkMCa7SbewJvm9Yw8t+qWmYG+a7qxaL8cDIPpoz+y1cqBrHGW9/fGWuOegXQmJntamo06RCpe+b7jbMuVenBx0VXcRTbuhLKVWsyOIPadogO2Bh67w8Cd37TGsIRwu+rfSHJM7y9o2EFIwVBftMv8965xpg0URaQp2nEk9iegnLrmqc1sdFSJ5J3ktyiOp0Q9LHQBMvC7kvAUPGQboNJSg3o61LtcDlU/pg7gb1KvJM//hOUsL1taDGym9SazCYXe0Qg+vrWvsqYqvOsJLI/H0V8Wf96x0bQlWj2/s6oU7YY2hfBaCk0YfPMQ2civaXRTcoycA6jTTXF7C99g7miWTV3irzn+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199015)(83380400001)(8936002)(5660300002)(38070700005)(44832011)(38100700002)(36756003)(122000001)(478600001)(107886003)(6666004)(6486002)(2906002)(54906003)(110136005)(6512007)(186003)(26005)(71200400001)(66476007)(64756008)(8676002)(4326008)(66946007)(66556008)(6506007)(91956017)(76116006)(2616005)(41300700001)(66446008)(316002)(86362001)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wp+a78ZNV5+HbI4HXkINuSWnOemy/QMXp8u2l0ef4eadEMFAtvq/iEMXoe?=
 =?iso-8859-1?Q?bsy6QQeIjvKnEagSxuuKkc8oCki7SxgKKNlBOYabK8v+Fueu5OLsA746s8?=
 =?iso-8859-1?Q?KDSuJKEclEAfS8nGwsBYTFaA3oCpyphpGo7Mdyef7IkgxLoc0D6SzofmtE?=
 =?iso-8859-1?Q?BZlYbCS1zrtZVXvVDuHLyBneBHIvRaOJ44QWVZtFFE8V2VW9RH4Za7pBcK?=
 =?iso-8859-1?Q?XgAbtavHnMQpHaNl49mPif/Vf/zcunfWEDPPwISCZgE6iL5vdHqRlVSZLz?=
 =?iso-8859-1?Q?piLQz+LprySQ2xME4UA8tjhen768Nmnw1EYCqU8hxBAMWqYYrl0DOkMHB+?=
 =?iso-8859-1?Q?ZkJrVUbLMR+Ok0po5Dkn5L8ql5wzWasf3TJ5SOK7RFdYiwpjTdOmbwVz7o?=
 =?iso-8859-1?Q?HJlSgP7gcODhGGg+VxmsLyJ6/hnSyFzUBJcegkmMmLr/5do2BPDpJeLd0A?=
 =?iso-8859-1?Q?o+9zj+hCNVptt/OLZNNEDPVp6SYleD3OqMlH8QvgsRUjqNsILqsa2EKn4e?=
 =?iso-8859-1?Q?TXTrB66uGqvvFnV8Zj4Bf4U0xtLaWt7JgXpwVqH4uW5FfepNHtglkjH/kF?=
 =?iso-8859-1?Q?9DJZtEG8wnXLAJ/yOa0mih1cH8l5g4yPllm+BOmf8AgcQDlfbBlt2TqOaL?=
 =?iso-8859-1?Q?Z5UgOGutPnAR7LJKOfMdLLoengZp8b3MqO4LcMbJmhvM5vosJYDlrX34k6?=
 =?iso-8859-1?Q?AS+JZst2nASugrXNoTAb2cDI/j0dafe3UgoeLlXxtmvibR2oit1PTiX7hM?=
 =?iso-8859-1?Q?sWP4Q4O9TCSk5AhlshPM0wya8ecJ68B7+rckRvwni5ouU+Zbkz4QNjA10V?=
 =?iso-8859-1?Q?h3AQCpo5U74gLb8oPNcpVTOAoN+KhFx3tmCgqbl6r8VtPprSMcqKV3AGqc?=
 =?iso-8859-1?Q?jsGwmZG5rpDWRoqXgjR0o2kS7tQWg7M68E0lAUUihNEH8JCBap9HA/w5pa?=
 =?iso-8859-1?Q?Dqk4ZW+xEc7aBZIL/c2BOf75QUfDUMeBrPLYlifZe0lmGsRF7lRYYl6w7w?=
 =?iso-8859-1?Q?AJbIHHTBTxWagYgbvnQjn4qESBd5bi6Ko5vZ5gHNoexW5iDXUle09gaRpM?=
 =?iso-8859-1?Q?nvOp7FnjZujLz561R9z6/udSSFclTn3+iLyBMecXPKSLLllVhEDdgJigIc?=
 =?iso-8859-1?Q?zP2qDyhEZtmLSSJRtkra1F1nq9xXq+e4j9goS2uAKiPNerIIQUc+zi9d2U?=
 =?iso-8859-1?Q?NRz9ltMhezMlAvrMnpGbVEN3/Gyw6KtC6xSh6A+1TpbMG7vzM2DSQQEIoa?=
 =?iso-8859-1?Q?fJe0uq+1SbCMBYGBSMJlMA/SRbZcDTxKX8EvkFr1xu5PUXSW0W5IEJp8A3?=
 =?iso-8859-1?Q?nrjTIrCwOcaUFcvsyo9ZuNHlTZbHwgGT/sHFBzvoR54sWnuXWY0oDDUt4f?=
 =?iso-8859-1?Q?4Zfz+A6TpvHQXOWQOq6dZwMgXY3VVjkVbnKHdHQVEbN4kxtzP4wH69ogEI?=
 =?iso-8859-1?Q?upeabNDxsF1uD2NMZcxD1lgXb6ssE8IS4h5K/JkgBsyjSKUn8uR4GCjhBL?=
 =?iso-8859-1?Q?MC53Gkw+36OFz7RndZ2zYPuXlf+wIa/5aT2jUIGjdZFLpcDRpI5clnEljZ?=
 =?iso-8859-1?Q?Wzv5Aphz/0fznaHmLl1bud11gcvXRzreSWBi++yYhkVe8CO7PHsvYvmhEs?=
 =?iso-8859-1?Q?h/DADAUnUnV3Ur/8GgvBPPoBtBr5B4a9T/f2s/4zuilf3ytxUipshAvQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PNuMrITuNc0zKQIMz/tNqxeVnBA3JYevNQ+CzJ1t8A+uTCrj8P3D6gFo5TfBuCeyhBII4sdxOovEVloJZBzaSS8W9NizbqhFjpieYvrp+HcwDSel9FnYT5/LQTV8hubITsZhsM6MguF0fJtHkkvJ+AdgBGDXEXT5XShhmmzX9gWgu9WtUFPyTmsJ40T5XWX4ff4OaPsr+zw7B/GJvXmqdEf4iVNYxsO6pMD+ggPBZO5aOIk2VNwoM7bz6uyFYTdUvcRuNkspLQfg03naqyKR6GhC3NiYkmlODOgguF9RKXyK8rtYFyImGcelmdWxnE72tJYrhRK4Muan1zvv79mqKKFFaOZI2YhJ/7FbyqlvRKCEX/ShvHpBye3z8Iver82Yu2lKF/lQT62Wtq8UqaI08mYdxd1Qwp3t14Mrf+mPUyFf9/atq4nxuTd0CPc1+/fxJ1QUkLz4Q2z4gIT8IbvekvhovwIfa9ygv/UYsyhKdkWWqSVZdToF190m1nAWWrYhV0WopxyXeUKSRTT6L7nU0rch5bH05b4p1k91R7C27VCMz2JsPfFL0f07yIfoKD59HON3H1wrxDHpbTXQwoWatbvrQAhQvuz62HTszRfLtL9rTiVgPe8d0q9Eq/2cwE/fvbq/YnHkzZsVXz7sjZGOXDvjPY2tRqV6SLaAn1iYvpRfVmIlLm6ecn0e4ngnZ+pLbUi7f5GY2+PlbvAO9vM8jOQScjXe5dRTpc2/5ODTQEt8SYvaTE1AO8ZFKFtdSdMnFnA0aBOqXmwmTzNubjQnKk+xY1eClsPu6hcrp0yomFePOCZrEFMMUK+9mM03AFWCV8Bw3CwNC4NlCMiYHAj+UcOElWOxJzCGjd5AWLZyDDFrpz27gPnOQK3rxNTZuUO5mx4Ah6lTUpz5yIrX6xnkqg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5670280-e373-4eef-198d-08daef515e8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:16:02.4690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DuKWcZTrfwVbuobjlTki6Bnz8SBtclYuOgcvuDfL+Q+6LRieL7/rVdfTk6RoWVfLRBJmbnKzyu9WRmESvevQ+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4791
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050152
X-Proofpoint-ORIG-GUID: M_ezwJCLR7JhoE-T98Y8nKceYJqz-p3P
X-Proofpoint-GUID: M_ezwJCLR7JhoE-T98Y8nKceYJqz-p3P
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

Change the vma_adjust() function definition to accept the vma iterator
and pass it through to __vma_adjust().

Update fs/exec to use the new vma_adjust() function parameters.

Revert the __split_vma() calls back from __vma_adjust() to vma_adjust()
and pass through the vma iterator.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 fs/exec.c          | 11 ++++-------
 include/linux/mm.h |  9 ++++-----
 mm/mmap.c          | 10 +++++-----
 3 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index b98647eeae9f..76ee62e1d3f1 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -699,7 +699,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 	/*
 	 * cover the whole range: [new_start, old_end)
 	 */
-	if (vma_adjust(vma, new_start, old_end, vma->vm_pgoff, NULL))
+	if (vma_adjust(&vmi, vma, new_start, old_end, vma->vm_pgoff, NULL))
 		return -ENOMEM;
=20
 	/*
@@ -731,12 +731,9 @@ static int shift_arg_pages(struct vm_area_struct *vma,=
 unsigned long shift)
 	}
 	tlb_finish_mmu(&tlb);
=20
-	/*
-	 * Shrink the vma to just the new range.  Always succeeds.
-	 */
-	vma_adjust(vma, new_start, new_end, vma->vm_pgoff, NULL);
-
-	return 0;
+	vma_prev(&vmi);
+	/* Shrink the vma to just the new range */
+	return vma_adjust(&vmi, vma, new_start, new_end, vma->vm_pgoff, NULL);
 }
=20
 /*
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 294894969cd9..aabfd4183091 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2825,12 +2825,11 @@ extern int __vm_enough_memory(struct mm_struct *mm,=
 long pages, int cap_sys_admi
 extern int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *v=
ma, unsigned long start,
 	unsigned long end, pgoff_t pgoff, struct vm_area_struct *insert,
 	struct vm_area_struct *expand);
-static inline int vma_adjust(struct vm_area_struct *vma, unsigned long sta=
rt,
-	unsigned long end, pgoff_t pgoff, struct vm_area_struct *insert)
+static inline int vma_adjust(struct vma_iterator *vmi,
+	struct vm_area_struct *vma, unsigned long start, unsigned long end,
+	pgoff_t pgoff, struct vm_area_struct *insert)
 {
-	VMA_ITERATOR(vmi, vma->vm_mm, start);
-
-	return __vma_adjust(&vmi, vma, start, end, pgoff, insert, NULL);
+	return __vma_adjust(vmi, vma, start, end, pgoff, insert, NULL);
 }
 extern struct vm_area_struct *vma_merge(struct vma_iterator *vmi,
 	struct mm_struct *, struct vm_area_struct *prev, unsigned long addr,
diff --git a/mm/mmap.c b/mm/mmap.c
index c10ab873b8e4..d7530abdd7c0 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2268,12 +2268,12 @@ int __split_vma(struct vma_iterator *vmi, struct vm=
_area_struct *vma,
 		new->vm_ops->open(new);
=20
 	if (new_below)
-		err =3D __vma_adjust(vmi, vma, addr, vma->vm_end,
-		   vma->vm_pgoff + ((addr - new->vm_start) >> PAGE_SHIFT),
-		   new, NULL);
+		err =3D vma_adjust(vmi, vma, addr, vma->vm_end,
+			vma->vm_pgoff + ((addr - new->vm_start) >> PAGE_SHIFT),
+			new);
 	else
-		err =3D __vma_adjust(vmi, vma, vma->vm_start, addr, vma->vm_pgoff,
-				 new, NULL);
+		err =3D vma_adjust(vmi, vma, vma->vm_start, addr, vma->vm_pgoff,
+				 new);
=20
 	/* Success. */
 	if (!err) {
--=20
2.35.1
