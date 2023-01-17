Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D54B66D46B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235515AbjAQChP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjAQCfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:35:34 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13822CFE8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:34:35 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H09ZtO011746;
        Tue, 17 Jan 2023 02:34:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=uGmdrfkYdVpaRyokuVBy46zsbVYlluoZIVaFM/I7OqY=;
 b=jJnuZOwB6MwjMnLzzG1wQbEbtzNu32T6bSeXD2AoAeaJ9b4vnIUyt25UpNfTGPj8fWgB
 YZO2L2LNARpLEVKasd+IO33KZjDGqD5QCsetxgPYpw1eeqs6G/y1xM5yGHr3SZuCmRCu
 TC9qc0HW4TyR6YwoiEBz4qdvwAI019pnDh0oKZGOpMnumC6trfc+rRKhEf02lhGW7oT2
 y5vrbTbxK2CLyyKHdBQOXa/74oE4KGRQKce1ilf44zQP8X57+XYMJIo24DphI9ezsDMC
 f7JN2eKhL/Dw/k8ETZrVb+lYeNe04lmvyAc1Da2/X0eeM9pmuagdIkIBUYOoBibgskEF DQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3k00urch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GNor97020620;
        Tue, 17 Jan 2023 02:34:21 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n4rq37hb5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UL+SFJV38lKEeBdFJzOh+o8AoOTZWV4PKohsk8qrNbvtifxnrV5DsaA3J1aNmfgAjTeQoQXXiP11Y1hlSvEwFbfxUysaUA6OgFQqZXkGGF+l4Cm3unsvft2Y2Tjc4EFrUuvGQsqvy84ytg6igsnGFuG9MbxWJzQ2ZvYAqQbdY7AkYnYmSyEwH9vBg64Wov7i8VtPu8Q3oNIrZcosAPZzd5Gh3NZDcDQgoQXQH4Rp+rZ2Vv5BfXI90nhRv/oUYvsbSLEF8GQX0k/WZVw4YTQR8RJyG/FSspJWUKjD1vwSzZnH3qJew8qWFELhwDbVvuUgEyrYGvYlqA55GS9K+QLhhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGmdrfkYdVpaRyokuVBy46zsbVYlluoZIVaFM/I7OqY=;
 b=c4Mm6KpgdsXe+vL12PtACcppc1Uj90j1vlaKt6/W9Roc6bmUNPHtfcYsDmJnU0wb+LlMlii6Nm524x4Mwr7z7CrZCx+jRSLFnNuick582WCjn415P6WqySibZphlKB/hpqE9incqrY8AWGqGojL5ehdCP9RTn/wV8CMMiXRXCk8KPi+yLrciscKyMgC1/hYikP4KNRMSvZU9CaOX5m8uuDizfzzuQJBeaoUtcq38zUUk3xb6GHNRHnhD71U4a3xqZY9MHnM/eEEbvOm1QXoUY9brTFJxAQAqT/LEOKzOWdpGm2MNg9CTkrjtwpi9xQrnp3GupKqMZ8/Hv2iYU3fgDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGmdrfkYdVpaRyokuVBy46zsbVYlluoZIVaFM/I7OqY=;
 b=loJZFZ/umIW1UXn9sXGInJHPNdROoQ5k4dP9gqi5g4pNfNjCWRA0lI+HegYQJ+qTOAgq3s8rDdlIVMErWO6XuXGwMVSLv+pF3r7b2TzCjd87e+NrW2K4yuwrOqgViSi+GRGq9NBU61XTobWnx5f+sCD4LN5SrwGvoemsXdm56C4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5356.namprd10.prod.outlook.com (2603:10b6:610:c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 02:34:17 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:34:17 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 18/48] mlock: Convert mlock to vma iterator
Thread-Topic: [PATCH v3 18/48] mlock: Convert mlock to vma iterator
Thread-Index: AQHZKhwxHE8qLVwDPEuCpPiq5mmYJA==
Date:   Tue, 17 Jan 2023 02:34:15 +0000
Message-ID: <20230117023335.1690727-19-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CH0PR10MB5356:EE_
x-ms-office365-filtering-correlation-id: 4909ffcb-a04f-49dd-37b8-08daf83354d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HhkfriAzp6BN2frYSJ9gIw0L1pGT71gQUUR8l5irLFfPIolvredYNn8Ghvc3uIItsTox+Ty0DOpCBmpGgnKAo1BcWak1ZEMu/gNL2WxmKWY5hRP6spmCN8bHcmeNNmXgNMFLk/nJIE5VNvqx6kHJucMnZ2qryYJAULRo9FF2Uae4igPSTeFcWIX0ZJVqrOHE2H2xKfV6xH2lsO8ZhHVbirg3Vv9RwVRNZmWxMREEUnlrfX27plGA7bs+pn5ParbRb8wH0Cj+RuTEdfMD/FUA0sh6Z1GGnHK/f7twINk5notgJjsAUt0jshrs6WrihR491+pPTpR5l8AIFf0nAuGPnzPD+bf+/w3fZMzcsW6hRla+5401sN5lSH3YnTrnZG37K90hxWOPN8FFmYdxxl4wQU8qvR7pWiEIOAa2FLnFfF9ZW5VbfaMHTswRYr6LRRZJiA6HArM6J036UOs2yLcQH0dHepf8bPv88XxA9HPQwkzF9VWfkCecOCnJqbqpsuYAM1G2EoyNBsQXRJ+yMgC3b9X/A1S6fmCbriLmsDd9HdeeMpOe2PHuBe+wQ46ViEVN5EZvjVzMXgQtt69RZFUBAa2bHtfMwB7NM4bdo5susxsaA+B4kEH/GrTmE16l6TaHILRvpsjFn5XekpLtL7yhKl4sjZLzZb7KUczHrD/Y2v+0Zy46CJtUWY8xuKHFoKhiONTgoGOybeAbNwIL2WKWtQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199015)(36756003)(38070700005)(5660300002)(8676002)(44832011)(8936002)(4326008)(76116006)(66946007)(64756008)(66556008)(66476007)(66446008)(2906002)(83380400001)(38100700002)(122000001)(478600001)(54906003)(71200400001)(316002)(107886003)(110136005)(6486002)(86362001)(1076003)(41300700001)(91956017)(2616005)(6512007)(186003)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2POpbGB2aBIApAocE6vtxfXw2ju7LaOH8PKVtrxcwE7F9c4u9cuYnXhdKH?=
 =?iso-8859-1?Q?K9VpFsCqE9KLbm/FOs0pdMEJgC81OykN7de8ad/wb1+/MaGDs08NesxY/l?=
 =?iso-8859-1?Q?DFaIjJeil9w/KlmMtCmipeyd/qzdOmgLvQ1bFFI49IgQTFkC1zFSVf+Aa4?=
 =?iso-8859-1?Q?PzfPqPhkis9uqIbSPyiJo0ytzBw1slEsRi9okc/izNrsp3KD/0iXf7LoWg?=
 =?iso-8859-1?Q?w8vgxMiCvGBKiN8n5Jk2BQMh4LeOMwqRk18/Kn4bZWEpGvOiOKsiou3WTl?=
 =?iso-8859-1?Q?bC4N9vwXvHIWmlS5ezDjL+o/TzRYsTrA1e1BtBxEL6w5XeYZlSkOJVOnYI?=
 =?iso-8859-1?Q?uAyA4ydEYk9JNatr3d76aqMLeeNmUvsndvhlkvEoONVhbSj3khPq7NTIve?=
 =?iso-8859-1?Q?/HBjzvCOkYHF1jmJgEPa8qLmugD+hTyb7EV9iR0jUtNekaY8X5K/9FiGiU?=
 =?iso-8859-1?Q?V/6jKXu+2/GhcEtl4FC9HfdiWz1PS2nG9NLluQ/DAOgVmG7DYvHZDSRg4m?=
 =?iso-8859-1?Q?gzKbu4lXxrXDox9lQyYW5dIuqU976xFxrBigxsJterRaEKdLLLwxd3j0sC?=
 =?iso-8859-1?Q?g/kiHKKvLlRANISjy68Y2PcyAzLYqPXKukOmtkGskgTymZmnDl3VR+bP0r?=
 =?iso-8859-1?Q?S8tmqVD5aRNWBae4nv610Dg5cvkodhjQhgEZD3ji8XfsBmO0Pyn8RdYJ3e?=
 =?iso-8859-1?Q?5Cz3+AULWeHIKZJkf94++5gclPQT6P++lEUnWqG90p0OtRrcvZfISRIc3M?=
 =?iso-8859-1?Q?UhqSgJgEWVO2HONBFFapkwE8JtKRii85N4YAmCdI+NqOxFrKoqFYqv/4sA?=
 =?iso-8859-1?Q?iV+8wRx87ojaKfiuTKD8jmALZexz3uAAHUjcFDJE+stESKohKrxBPOCmv/?=
 =?iso-8859-1?Q?wkDgfcICu6S1G/rdAI9P5tQv/LKPC0XWpCu2O3bfJsBkBKSF9jh0JWSn5r?=
 =?iso-8859-1?Q?U894hgZafJot+ACNvRLeRLQ+ypb5v0+jq0z8NWGQap7d95y9bD4qCLqQos?=
 =?iso-8859-1?Q?8olS/dXJTGLYzyBeWNxFIymFH+ikGK8qfV7dUhy4YytKRwxGBtE7swibq3?=
 =?iso-8859-1?Q?rNBl3OnSYqZnL0GZtkncrGZHrSJunZwRejf8XMl097Hq36KMH5WKg08ZlM?=
 =?iso-8859-1?Q?kBYm2TbxCyjgZl8oLj3umVaaeDBmgv6Gj6tIw3sIsHQPBAZCUPhy8bdPSZ?=
 =?iso-8859-1?Q?viqjoLKX2klX+JL99/9zv3FAX6kYwoAH/bO3tCYdhl6Hfe96AB12XJQ/eV?=
 =?iso-8859-1?Q?n5OA88fSJlguPUpY2BnF424Yar2SkmQmZLw86TkJKzHOaPRgaZGIwxubh/?=
 =?iso-8859-1?Q?QgjO03jrxEEfs5emlo6EiIiQjUoTqyPBWKYNsMgh28xY06jPFAOR3sNsMr?=
 =?iso-8859-1?Q?zgFQBd+AcOBufhREnjyayTc7DPpXV9sh7xUv2dYUJ8/o32+vuhHjCCV7QW?=
 =?iso-8859-1?Q?smxrvFPIG4ozDDgal+T4tFo3tzugx/qCyXSviz6bVkEbL0aTTa3svzZBvl?=
 =?iso-8859-1?Q?9ZYUIbbfNlLded1jDLFciyhX7aswP+sgTjKQVkB03fuwMPzTskQcLwW/nj?=
 =?iso-8859-1?Q?+wgwqj6MIlrOxb7bO5kL66bRpeh42s21txia59mPZakUJ5f7QDsomik/Hs?=
 =?iso-8859-1?Q?1bIgUQfErN4NZ0n1KUEWeS6gyuVGfGo5l3mxUnjQW1f58K/WYm1QjN/A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zDG40/q2FaGldPTgZ2JUnB0zTAZ2NwDumsNVMmi08Wz/+hyGhIY48dbyYoM6UQ7qCh5WOcpqE2PmUmgHUhVUlYYAIYy/QSqxI5baJkiIN62Lt2AW8uQTuv4ezPHZv4Vki2awtwin/LqntiQISxmCpbgl2RX4eH8N9ONeslyKwvYqNGgZJYQv0/zseui1d0WBHqYGs5QIhqcxqYTVbDBJ3sdg9ZVHgdhjP8S4Wem6zrsHNU7eXWlGNZEzi300FJjmcuXqGcfwZKQXWITdx6pJSsAOsH8vIgndxhaB6JOvQhu4hQkM2XE3jTrrVlXFe/7ZnEcOQVbnzL27UlySihjGcfKPt3OoN5J23sGjlTvENnAe0GuVRV7c1eexEQCJ2ApQj0TaErQFiw1Y/ZgRnl72GpDylJjcqFcK3pVEwOpsb+ixKV5o7B1ETWRW2tTE2eontPt9fDzquCnnXdTz8C03Lb2G2tQoLPf0X7E9hk+FkMuZC1Gv0nOenHlue6rvV9+mUoRdHPAf7xhq6DTytX3HN44fzNJvNWanCbE+/P6J/cqC5NuwC4Kqz9SvwneZODXDzGjIFOwtJjFxjtBHNzG/1nAO9fBPpVQhgjlSVE0wAhBY8L37MRgMeYQOXVjMSV1UeTn1ioVsQ6SJvYOohNS34c/fTmuU5oeB9q2dg8QVqKk2FxyUofuN5wNGYLBSXCoXYc4s5mN9c1bgaSYWnNvyDYhaO1Xo3SSpH5nczZf7yAJgM6q5PUxgr0rOJE8hHXaqUZqOYKWVgo5rWKwlDDYeXAvOmXuih19iotrBSF+YIBhAm99gvPlO8ao+0ylbBx49k4AwFxUSqXugXBTMDHlYEUQyzwox4kqdFOfAU68cwa8086lRIdc5F/OuKMDxHsYELkTA5Sd/R6dLbw6L5b/5HQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4909ffcb-a04f-49dd-37b8-08daf83354d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:15.8749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vQwaXcELtAjbP1199V+/rHd9DjZPsrIGBajUTWqIZfFOExLD2dn+gr4RA5G4leYy+qpTIzbZs1MepitjJ9ck4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5356
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170017
X-Proofpoint-GUID: g-dvshn0TXBAPJmCFYCyTDKRhF_fZDuv
X-Proofpoint-ORIG-GUID: g-dvshn0TXBAPJmCFYCyTDKRhF_fZDuv
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
 mm/mlock.c | 57 +++++++++++++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 7032f6dd0ce1..35764a4f0575 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -401,8 +401,9 @@ static void mlock_vma_pages_range(struct vm_area_struct=
 *vma,
  *
  * For vmas that pass the filters, merge/split as appropriate.
  */
-static int mlock_fixup(struct vm_area_struct *vma, struct vm_area_struct *=
*prev,
-	unsigned long start, unsigned long end, vm_flags_t newflags)
+static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vm=
a,
+	       struct vm_area_struct **prev, unsigned long start,
+	       unsigned long end, vm_flags_t newflags)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
 	pgoff_t pgoff;
@@ -417,22 +418,22 @@ static int mlock_fixup(struct vm_area_struct *vma, st=
ruct vm_area_struct **prev,
 		goto out;
=20
 	pgoff =3D vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-	*prev =3D vma_merge(mm, *prev, start, end, newflags, vma->anon_vma,
-			  vma->vm_file, pgoff, vma_policy(vma),
-			  vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+	*prev =3D vmi_vma_merge(vmi, mm, *prev, start, end, newflags,
+			vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
+			vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 	if (*prev) {
 		vma =3D *prev;
 		goto success;
 	}
=20
 	if (start !=3D vma->vm_start) {
-		ret =3D split_vma(mm, vma, start, 1);
+		ret =3D vmi_split_vma(vmi, mm, vma, start, 1);
 		if (ret)
 			goto out;
 	}
=20
 	if (end !=3D vma->vm_end) {
-		ret =3D split_vma(mm, vma, end, 0);
+		ret =3D vmi_split_vma(vmi, mm, vma, end, 0);
 		if (ret)
 			goto out;
 	}
@@ -471,7 +472,7 @@ static int apply_vma_lock_flags(unsigned long start, si=
ze_t len,
 	unsigned long nstart, end, tmp;
 	struct vm_area_struct *vma, *prev;
 	int error;
-	MA_STATE(mas, &current->mm->mm_mt, start, start);
+	VMA_ITERATOR(vmi, current->mm, start);
=20
 	VM_BUG_ON(offset_in_page(start));
 	VM_BUG_ON(len !=3D PAGE_ALIGN(len));
@@ -480,39 +481,37 @@ static int apply_vma_lock_flags(unsigned long start, =
size_t len,
 		return -EINVAL;
 	if (end =3D=3D start)
 		return 0;
-	vma =3D mas_walk(&mas);
+	vma =3D vma_iter_load(&vmi);
 	if (!vma)
 		return -ENOMEM;
=20
+	prev =3D vma_prev(&vmi);
 	if (start > vma->vm_start)
 		prev =3D vma;
-	else
-		prev =3D mas_prev(&mas, 0);
=20
-	for (nstart =3D start ; ; ) {
-		vm_flags_t newflags =3D vma->vm_flags & VM_LOCKED_CLEAR_MASK;
+	nstart =3D start;
+	tmp =3D vma->vm_start;
+	for_each_vma_range(vmi, vma, end) {
+		vm_flags_t newflags;
=20
-		newflags |=3D flags;
+		if (vma->vm_start !=3D tmp)
+			return -ENOMEM;
=20
+		newflags =3D vma->vm_flags & VM_LOCKED_CLEAR_MASK;
+		newflags |=3D flags;
 		/* Here we know that  vma->vm_start <=3D nstart < vma->vm_end. */
 		tmp =3D vma->vm_end;
 		if (tmp > end)
 			tmp =3D end;
-		error =3D mlock_fixup(vma, &prev, nstart, tmp, newflags);
+		error =3D mlock_fixup(&vmi, vma, &prev, nstart, tmp, newflags);
 		if (error)
 			break;
 		nstart =3D tmp;
-		if (nstart < prev->vm_end)
-			nstart =3D prev->vm_end;
-		if (nstart >=3D end)
-			break;
-
-		vma =3D find_vma(prev->vm_mm, prev->vm_end);
-		if (!vma || vma->vm_start !=3D nstart) {
-			error =3D -ENOMEM;
-			break;
-		}
 	}
+
+	if (vma_iter_end(&vmi) < end)
+		return -ENOMEM;
+
 	return error;
 }
=20
@@ -658,7 +657,7 @@ SYSCALL_DEFINE2(munlock, unsigned long, start, size_t, =
len)
  */
 static int apply_mlockall_flags(int flags)
 {
-	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
+	VMA_ITERATOR(vmi, current->mm, 0);
 	struct vm_area_struct *vma, *prev =3D NULL;
 	vm_flags_t to_add =3D 0;
=20
@@ -679,15 +678,15 @@ static int apply_mlockall_flags(int flags)
 			to_add |=3D VM_LOCKONFAULT;
 	}
=20
-	mas_for_each(&mas, vma, ULONG_MAX) {
+	for_each_vma(vmi, vma) {
 		vm_flags_t newflags;
=20
 		newflags =3D vma->vm_flags & VM_LOCKED_CLEAR_MASK;
 		newflags |=3D to_add;
=20
 		/* Ignore errors */
-		mlock_fixup(vma, &prev, vma->vm_start, vma->vm_end, newflags);
-		mas_pause(&mas);
+		mlock_fixup(&vmi, vma, &prev, vma->vm_start, vma->vm_end,
+			    newflags);
 		cond_resched();
 	}
 out:
--=20
2.35.1
