Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E38865F454
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235778AbjAETV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235461AbjAETU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:20:28 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06F66E420
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:17:54 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305ITcEw025581;
        Thu, 5 Jan 2023 19:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Zf4dD/GIxBl0AjcjR6WG+8X+eKixuRYpeZDz4C5cHuo=;
 b=wzyrOu3TvymQC4Ju81t45lovevGkVs7eM3Za3hOZnngACL9DdlZ3QgTIFWTsWuRCTNby
 0gCNZ5dz3fSRFs4jAxh72JoNtIS/GA9GtfJTULHBmSWPm4G4+E8J+UExNvtszrnk9JSY
 Olf/n+mIN4YMllQyWohTt8o2LQyQyP+4FEFA8mMgun3gF6IuOIPLbNZwDLVzNoKvtkU1
 Of3oHJnAiAflVZa9k5WRNUORRo/hY9c5sHSSO9LbMFipCn6gVUz9Ds/nLrGArxqeXHma
 gwpSGR1Ko8EI2mWbcKw0h27pDWvdQ489FCiKeJ0sJbocb/gKKZHzwqtonQWpAsoG2GKQ 8A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtdmtskwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:43 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305I1EPn033688;
        Thu, 5 Jan 2023 19:16:43 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwxkf7u5p-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fh8POAou9iBg3oJaMaB8nQBDZXRhjNBWs/qZXq5olSEestBhXzf4fUOtvWKGXyKz9f++tajyGI7akY2owljkYRItmtkGYX+otpcN7+SFyFJpdLTBuzUAgOlgKcVIHUE9QUCScuoCIluofzPEO52p+Enb9Kya1Gjd4Hyyv6WDU6BSmgmyCn7e9q4nSk+tHkeIcAYxN2Et8dPainWxmuEje0u7PiK7F3QlUI/9MdZAhYvKtu2d9eC79D4JE+iZXoHamzsAcPtkYuN2l5RQvwyQEFYcca1381lIK1YzdY+mPBUrH+Ht9XipvF8r3jXJM3z9HiYDAwr8mMSsrNiZyeZLCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zf4dD/GIxBl0AjcjR6WG+8X+eKixuRYpeZDz4C5cHuo=;
 b=dIuztHbkyQb99mKm7794VjQHBHU9I7UR8Mv4J+NsEpY6jng6pXZY+quHigT22NSrM0qTaTpdCJmVJzox0HACqV10gJ5h/xpAKnLlkliud4tdaSlGqhXRcUhF21NUKIB6M02ifMYnl3ka1A/k14RK3Hucs3eAGp3+vDcveyuvEJ0nW0j9t3dL3hrIdZmGrimdmDKgwJY/53zhtoTDfJrSv0QR/5KZlXLpmEXGRdYQic3E8gSpkcCrId3zqlBztWERY5dtkIC9882H5+BJXCMrJCduchMWebU43fOhB4FpDbXs705+aJG+q411ll2FabWLorsJae7ljsHQh947eeAwDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zf4dD/GIxBl0AjcjR6WG+8X+eKixuRYpeZDz4C5cHuo=;
 b=dXz4K/G2noiMyALULzvQ4MEDMkRXwofEQT+lMKIMTUFMWzwEIRCWGqp/9keZ+7ytKYl95JfoBb60ibFXQ2qiULYdl+2/hy9kyAQYVW/FD4XExEy3y5q3uZsDvQWDkDq4M+KaUIoo/eMSdB8Atho8pg4KM5o/GlrGBzgtvHmYVbI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4791.namprd10.prod.outlook.com (2603:10b6:510:3a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:16:40 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:16:40 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 37/44] mm/mmap: Use vma_prepare() and vma_complete() in
 vma_expand()
Thread-Topic: [PATCH v2 37/44] mm/mmap: Use vma_prepare() and vma_complete()
 in vma_expand()
Thread-Index: AQHZITonLQpgwctfXES3nm/KnMoahA==
Date:   Thu, 5 Jan 2023 19:16:03 +0000
Message-ID: <20230105191517.3099082-38-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|PH0PR10MB4791:EE_
x-ms-office365-filtering-correlation-id: 2fc8801d-1167-418a-1c60-08daef515f98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QH3F3XS2z41HSv3z1+vEXBxGKI76q8tfkY/iujycsNG5Jz+9nknqMQKFIZwF9MbNWR5mYD6ryCiKwGvadgfC5AK/PhPjUf/yJGrtLD2LeFkoVSiCiXDqxTkORE/IvQffoZ7Gf2/SyhOGwDLej+Fqjmqjz6gKCT83yxLpUoZccbbmPBewg/eLMhgfQs8SyLdNv2CQlWf9shd9+Rda00rcKqulqHC1ygArugtPqCLV0mF+gvJoX9Bw27W6sA7nGt3EYOusrVHYalF7cj77dTEG2Xs/IutKAbjvOmTUG743Bjr/E2YPd7sd2lWHUX9J9T7H2B+YzJcfoZZrWvvtgeIGZ4fYDqJbSPE8cOWO6l7z7MwW3+riJrH1jVhKSEIfGzPvczLfrl3qDrprVnljSZOKYBcGWk1ar1dcrz8v4Jlqo68M2yE18J+KOz3E88PNXB6gMBh3GRxFZEnWYVJ8CSbb3/vFUuQ6y/d0m6TdLfuxjdFxZB42tUPmuuKoQEBy24PajjkRuifemgp4cVVVLR7feV+A/fHg8FjReKRPH+LkivAcuys7rJzMMiGpA2cmV5pmhexbMsb6/5UZueO2fQGzncFhuhgyOBQiejK61NYuzG8eRUfu6t4NIhOa6lVex8eOSpRLgqOxH9g+YHkv/Wn1O4nNY7axoi/BMjHrWsmpcQxEoKpQfuhBWrB0g7ITrDU8RIJV+fj970iv33w/kMpXzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199015)(83380400001)(8936002)(5660300002)(38070700005)(44832011)(38100700002)(36756003)(122000001)(478600001)(107886003)(6666004)(6486002)(2906002)(54906003)(110136005)(6512007)(186003)(26005)(71200400001)(66476007)(64756008)(8676002)(4326008)(66946007)(66556008)(6506007)(91956017)(76116006)(2616005)(41300700001)(66446008)(316002)(86362001)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qxc4Zk/d1z1zlvx2Zx6Eh13ejwJ7CpKl1SQIOgm8/9Rc7qb/2UT0Yg+itJ?=
 =?iso-8859-1?Q?NrdnlF0yBZWloUSzTCtRUa5O9HcpKMyH+tdNI/ybdt8AftKCT7e5J70Taj?=
 =?iso-8859-1?Q?1sbw+sxyTFPMK9b5MR7gxO8qWUAgbEasBcOUIdUUp1MneShQ+NPxT/vtHR?=
 =?iso-8859-1?Q?XCFlcN3UEvbI7OE2xr4I0e7q0Ejxj1GvRaDjbQOtW8jlwZCB8Q0HmPyWLA?=
 =?iso-8859-1?Q?SjqL4E0QSGlL9REUrQxnNiK5AR7L0DAcUd3HXKdRHTEvP1hZjmQnXOmz7k?=
 =?iso-8859-1?Q?9SBjFnALsVsMpjp1YaWw5wiYfLyFd4VnVa5vQpKHzavWBHGkH/xGt35Ccf?=
 =?iso-8859-1?Q?VQ0EE5S2XF2+3sTbDabmNFfW4ZkEWyutj3XD7sdwHMW+/hOR5QbfTY9e7w?=
 =?iso-8859-1?Q?T/pQF/RK4ad69Db6feonY8Uts//hcr1UeVwt4pVAKgixu8jPmAsKBYZ7U8?=
 =?iso-8859-1?Q?hxu2H27X6KiJkRVXRNqUj6v63ZFQFGWRCicDb3nUEBcR17h97RmksYJk9r?=
 =?iso-8859-1?Q?lsd98FG6cGJP97mztYfh6oQ6K8gklAvwJ4cFdWqC/Znn41/jiAxVgA+p1U?=
 =?iso-8859-1?Q?hF8BmcHx3janOyl2ZMjeULdp6fASf1fwA+ns68kITFgUfZ7RxldXszPpGo?=
 =?iso-8859-1?Q?jYarwti4Qdq35jdrVV5zKg4E7Qhp5SatEbR2gCsJMrko5BkUX3XuMPWgzN?=
 =?iso-8859-1?Q?WkmkuNhyJVFxYAEIJTgRchSqnQ4SxFt5diMu0rwOqAEwiTbivnTFCgU5rm?=
 =?iso-8859-1?Q?j+6BHwh0vzZP/7wd/BhPTqRMruW2ILIdXMcAVwrQzXNZlxK3/MTE/RnGHw?=
 =?iso-8859-1?Q?MK4/Xp7NMr86CrED0DRDbbEgeJJXc6670dWnMol+avZjGYHunoheC73RYC?=
 =?iso-8859-1?Q?q0h/v07KZv6C1aFEz7G+I496Bj2vdc0uTNk/g7i3Elai4VBnFOODQfHOB1?=
 =?iso-8859-1?Q?sO2n4HmmI3VT3IruA9PqrxV29p9tiY18CbIGjE6tywZ4m/y258M4pW8EvE?=
 =?iso-8859-1?Q?uK+P1bA8xklvRGD88tGItIlwkNwBb60oz4T3DDP63imVrHPtSgtk6yk9Bb?=
 =?iso-8859-1?Q?IWQ7wBfJohap8Zq0nRsfqwlxzeL5iBTE/KQy7Uv/gn+nS7oLTW5QTvhx6J?=
 =?iso-8859-1?Q?6dulK4FWls69t3XwDBdpgR1uDp8adTX5zd1yaqRi5TEOTU6UVUc3KHiC1P?=
 =?iso-8859-1?Q?StH52Vq8pdXOFcvjTTq58SGTjdhWjeFwhRYT5+z04RI5M62Hta4tES/jO+?=
 =?iso-8859-1?Q?U6ugOi56IDPzJ8QSAsbXQimjQc+y27+CT2kPbwctbYVM8bObMqSCsdYmPX?=
 =?iso-8859-1?Q?emk1mbk9OAO4C/lS9jreTD2grTOiuPx2rjIowXEFkgS7rYMcYpcCXiVOwD?=
 =?iso-8859-1?Q?iV5UMkY7+cP0Gg4zJyEsgL3vfvfApMGqpAR+d4c3SuU3KxDpEvwM4FChn/?=
 =?iso-8859-1?Q?hRE7joNXSVQpnQTe0UtILi74Rq1XgJWOspAVZVHDn0y3exeKy/iGhrurdq?=
 =?iso-8859-1?Q?bIa+hjcMH2/vqKbvQ2CBNCYsAfpJOTHYz055nA+RI44wukXJdsoWTEY52F?=
 =?iso-8859-1?Q?yW5wmpsbeUJBwBoe6MkxdzyGBUx/lnLUu/k46VrwbttdwErQZHCBddy6zH?=
 =?iso-8859-1?Q?V6K8AGTXgk23nRHupz8JytSavnW5UlGqMZn7DrcALxBfEpBG/lN78BpA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Kr65AdlNmtZ2gslox8aNIhCEU3CS8EOiSEvxoWDafx4W2sLdi7sbjuIEmPjovKNOmnkjeFqOXrWI/+TEzAFCMK19+LronSE8BYlvf4T3DtnEFqaauvPv4xDVZq3KDItBkYhChU0FrfkgUnltauRz++ADuf9rK3WJZR97h/4I8v/GIXlZiCRBuJWpmi5lXDKTWAVFyAyFlI9Mlq4plP851/stAII8RJNn5/nk1g5KqbmaKP+U4vm9MgGodCLUakLxfTQPS2UEkX3twvVsAV334WvJTUgHNcwHQv2RwGezItHTLI6LSZJE0nJVzZ8HXb67xwbPthV7n849WcdOAxYMyH2F7GY7Nh02IeSBaHvzPwQq+hSuTpO7s31Lg+6X/uoPuzyWKgsbpHtHMuO5XbXBcziHP73repwUWUiaIg5htcEfOVIEbHYPXGvmO4MgLnl1aaHtbyynUFtvZ1TIcfCMZEDOhYT7ea1hseljjebGQlxrIHY9kIOH9iDDQfxRW2cOTLYxfg7K4uKpoHqp1/Ug+47hNL9QW0xOsq8IWQktWQRkB5im7L3pJWYiJZo0V6B76HnP5Q4hSKIB8UKFnAV5bgX4vfwc8bYrzTnrXUEOMhGjBjSNCH/pjbpItPt3DN2AUlXzeGEiHk/miR8/qVFjKmNbjIW9XPGndfkU+8ujopRCrIZgnFauC+VrW8xwst2eOgeT9L+IscSdpiZ1zIPTVbNj8FcKrQ9iBI9uze7b5idIY6m3IbDf2tmKwSaj2BrbUScC3o9oJOzz4kJt8XZ8/i9A5zygYuI4T3crocLgYcQG7ZpU14xLnERR+NrJWE5LEAzhBvO8pW0pcxtBdFUyOLBauze35jvHkF8zIfvm1aPli84My/HFyN1twymwLULbWp+VVG+QsYOL8lVEo2h0JA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc8801d-1167-418a-1c60-08daef515f98
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:16:03.8596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DEQUtjx6u6a6nKhIidI2C98lumIEDP5rYaixxnluCYO30XDQqtTupyHftO38Shurw98cdN/GAmO8vAH7KqYkwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4791
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=960 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050152
X-Proofpoint-GUID: tFyoK741CmEyMMLafXrZL__8h0qZJ5Q3
X-Proofpoint-ORIG-GUID: tFyoK741CmEyMMLafXrZL__8h0qZJ5Q3
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

Use the new locking functions for vma_expand().  This reduces code
duplication.

At the same time change VM_BUG_ON() to VM_WARN_ON()

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 189 +++++++++++++++++++++---------------------------------
 1 file changed, 73 insertions(+), 116 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 3cf08aaee17d..9546d5811ca9 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -519,122 +519,6 @@ static int vma_link(struct mm_struct *mm, struct vm_a=
rea_struct *vma)
 	return 0;
 }
=20
-/*
- * vma_expand - Expand an existing VMA
- *
- * @mas: The maple state
- * @vma: The vma to expand
- * @start: The start of the vma
- * @end: The exclusive end of the vma
- * @pgoff: The page offset of vma
- * @next: The current of next vma.
- *
- * Expand @vma to @start and @end.  Can expand off the start and end.  Wil=
l
- * expand over @next if it's different from @vma and @end =3D=3D @next->vm=
_end.
- * Checking if the @vma can expand and merge with @next needs to be handle=
d by
- * the caller.
- *
- * Returns: 0 on success
- */
-inline int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma=
,
-		      unsigned long start, unsigned long end, pgoff_t pgoff,
-		      struct vm_area_struct *next)
-{
-	struct mm_struct *mm =3D vma->vm_mm;
-	struct address_space *mapping =3D NULL;
-	struct rb_root_cached *root =3D NULL;
-	struct anon_vma *anon_vma =3D vma->anon_vma;
-	struct file *file =3D vma->vm_file;
-	bool remove_next =3D false;
-
-	if (next && (vma !=3D next) && (end =3D=3D next->vm_end)) {
-		remove_next =3D true;
-		if (next->anon_vma && !vma->anon_vma) {
-			int error;
-
-			anon_vma =3D next->anon_vma;
-			vma->anon_vma =3D anon_vma;
-			error =3D anon_vma_clone(vma, next);
-			if (error)
-				return error;
-		}
-	}
-
-	/* Not merging but overwriting any part of next is not handled. */
-	VM_BUG_ON(next && !remove_next && next !=3D vma && end > next->vm_start);
-	/* Only handles expanding */
-	VM_BUG_ON(vma->vm_start < start || vma->vm_end > end);
-
-	if (vma_iter_prealloc(vmi, vma))
-		goto nomem;
-
-	vma_adjust_trans_huge(vma, start, end, 0);
-
-	if (file) {
-		mapping =3D file->f_mapping;
-		root =3D &mapping->i_mmap;
-		uprobe_munmap(vma, vma->vm_start, vma->vm_end);
-		i_mmap_lock_write(mapping);
-	}
-
-	if (anon_vma) {
-		anon_vma_lock_write(anon_vma);
-		anon_vma_interval_tree_pre_update_vma(vma);
-	}
-
-	if (file) {
-		flush_dcache_mmap_lock(mapping);
-		vma_interval_tree_remove(vma, root);
-	}
-
-	/* VMA iterator points to previous, so set to start if necessary */
-	if (vma_iter_addr(vmi) !=3D start)
-		vma_iter_set(vmi, start);
-
-	vma->vm_start =3D start;
-	vma->vm_end =3D end;
-	vma->vm_pgoff =3D pgoff;
-	vma_iter_store(vmi, vma);
-
-	if (file) {
-		vma_interval_tree_insert(vma, root);
-		flush_dcache_mmap_unlock(mapping);
-	}
-
-	/* Expanding over the next vma */
-	if (remove_next && file) {
-		__remove_shared_vm_struct(next, file, mapping);
-	}
-
-	if (anon_vma) {
-		anon_vma_interval_tree_post_update_vma(vma);
-		anon_vma_unlock_write(anon_vma);
-	}
-
-	if (file) {
-		i_mmap_unlock_write(mapping);
-		uprobe_mmap(vma);
-	}
-
-	if (remove_next) {
-		if (file) {
-			uprobe_munmap(next, next->vm_start, next->vm_end);
-			fput(file);
-		}
-		if (next->anon_vma)
-			anon_vma_merge(vma, next);
-		mm->map_count--;
-		mpol_put(vma_policy(next));
-		vm_area_free(next);
-	}
-
-	validate_mm(mm);
-	return 0;
-
-nomem:
-	return -ENOMEM;
-}
-
 /*
  * vma_prepare() - Helper function for handling locking VMAs prior to alte=
ring
  * @vp: The initialized vma_prepare struct
@@ -756,6 +640,79 @@ static inline void vma_complete(struct vma_prepare *vp=
,
 		uprobe_mmap(vp->insert);
 }
=20
+/*
+ * vma_expand - Expand an existing VMA
+ *
+ * @vmi: The vma iterator
+ * @vma: The vma to expand
+ * @start: The start of the vma
+ * @end: The exclusive end of the vma
+ * @pgoff: The page offset of vma
+ * @next: The current of next vma.
+ *
+ * Expand @vma to @start and @end.  Can expand off the start and end.  Wil=
l
+ * expand over @next if it's different from @vma and @end =3D=3D @next->vm=
_end.
+ * Checking if the @vma can expand and merge with @next needs to be handle=
d by
+ * the caller.
+ *
+ * Returns: 0 on success
+ */
+inline int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma=
,
+		      unsigned long start, unsigned long end, pgoff_t pgoff,
+		      struct vm_area_struct *next)
+
+{
+	struct vma_prepare vp;
+
+	memset(&vp, 0, sizeof(vp));
+	vp.vma =3D vma;
+	vp.anon_vma =3D vma->anon_vma;
+	if (next && (vma !=3D next) && (end =3D=3D next->vm_end)) {
+		vp.remove =3D next;
+		if (next->anon_vma && !vma->anon_vma) {
+			int error;
+
+			vp.anon_vma =3D next->anon_vma;
+			vma->anon_vma =3D next->anon_vma;
+			error =3D anon_vma_clone(vma, next);
+			if (error)
+				return error;
+		}
+	}
+
+	/* Not merging but overwriting any part of next is not handled. */
+	VM_WARN_ON(next && !vp.remove &&
+		  next !=3D vma && end > next->vm_start);
+	/* Only handles expanding */
+	VM_WARN_ON(vma->vm_start < start || vma->vm_end > end);
+
+	if (vma_iter_prealloc(vmi, vma))
+		goto nomem;
+
+	vma_adjust_trans_huge(vma, start, end, 0);
+
+	vp.file =3D vma->vm_file;
+	if (vp.file)
+		vp.mapping =3D vp.file->f_mapping;
+
+	/* VMA iterator points to previous, so set to start if necessary */
+	if (vma_iter_addr(vmi) !=3D start)
+		vma_iter_set(vmi, start);
+
+	vma_prepare(&vp);
+	vma->vm_start =3D start;
+	vma->vm_end =3D end;
+	vma->vm_pgoff =3D pgoff;
+	/* Note: mas must be pointing to the expanding VMA */
+	vma_iter_store(vmi, vma);
+
+	vma_complete(&vp, vmi, vma->vm_mm);
+	validate_mm(vma->vm_mm);
+	return 0;
+
+nomem:
+	return -ENOMEM;
+}
 /*
  * We cannot adjust vm_start, vm_end, vm_pgoff fields of a vma that
  * is already present in an i_mmap tree without adjusting the tree.
--=20
2.35.1
