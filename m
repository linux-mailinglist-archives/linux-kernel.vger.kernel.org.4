Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B2A674427
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 22:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjASVR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 16:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjASVRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:17:17 -0500
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBDCA19AC
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:12:23 -0800 (PST)
Received: from pps.filterd (m0174681.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JGOmUN025449;
        Thu, 19 Jan 2023 21:11:26 GMT
Received: from eur01-he1-obe.outbound.protection.outlook.com (mail-he1eur01lp2058.outbound.protection.outlook.com [104.47.0.58])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3n74cd1vhb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 21:11:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPwiALO0aLJqlCIP8N8/9hakoTWz6+zxEqXUSM6erj6IRmS85XoF++u/0ceeogY3tCp8zrimDNBpNL2N9IzGiX1XmiPxXu1bNTYgDImahmEQ0D1vb9gGYQsnvjulV0u8Rnu9LkPMO2EFjQ4HIzNoMRosjY3xeruIfkzfWK4aGB6NRkKG28Il0WQWKVKt/egxVapi2aa88mb2U0pVg5STSHxCucAX00Eg6eSj4PaLE329BUTFgdBDi0c/79evTMCufUHPXYP3eP8sYmgJDVsDP6GE5+SRwyVyVBJWFulpJYK+Y8tcwa+UyfHvkFBVCt0M3DjQUfLvLazQcAAdFsZbzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbBOmXvNw+1mMey8yI7cqMPgGwSu1jVp5Matm0hB6G8=;
 b=h9R0FmybgXbi3PKWmXMGqcQt43eGIneli4HU98cB7M2pxIU9DJoza/WZ8eQbqXIgbHyqXYYk1fN6WfZ20gGZY/jxayr4B99I7BWZ0RktzX+/8mAjOoGpFgmOVa9150Tek7Rfu3TNuD3cG8u2eD7BI1vHrHSSrSSHXQcdQLfAX+Ojy0FAms1Bq9ScMPJC9LkVK5qZn/N2XurM2Es0VNctFvb2YBZDG7twLLe90rGWEysWynG82fsAQHqlviyyUbFZF0wOrBTrTPd7gL52NWvsVaiLv1VFkSaDjD4OY6ZEM5mSrY97IMrOB+cf4czR5IlFNMT2QLzx9SIwJ6IuLtFKNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbBOmXvNw+1mMey8yI7cqMPgGwSu1jVp5Matm0hB6G8=;
 b=U+xn9cDcV/H6CMh+xM1668lUTXtAy3r1SwiAlN8BECmiuwihJblNdEjDV8RQUH/2rwiYtLJqMyFw8Chk7hkBkiIWB8hIxIS7KuVDR0ExR6B/KCoTj3k/SGQ1gew3u/nG6ZLfKmNGUSUdWmdJzG7y7gZiCy+B0VU2VrQITncqbZqFfl7QXCq7CodYCKr9OwEmNfgdjX3Tz25X98lmNijn9JtHiIqicZHp9ogKRv7LjbUufBOeyf4R1rmHDu5Giox0OpKzYfA6bAgT75fxB52j4jttjswK9EK3rKm85ANqQJaBZsTgoHvuVIyN310Mz1Iyz82/Dd1taBO78HiL/cr33w==
Received: from VI1PR03MB3710.eurprd03.prod.outlook.com (2603:10a6:803:31::18)
 by AS8PR03MB6840.eurprd03.prod.outlook.com (2603:10a6:20b:298::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Thu, 19 Jan
 2023 21:11:21 +0000
Received: from VI1PR03MB3710.eurprd03.prod.outlook.com
 ([fe80::8b3:273:e51b:1023]) by VI1PR03MB3710.eurprd03.prod.outlook.com
 ([fe80::8b3:273:e51b:1023%7]) with mapi id 15.20.5986.023; Thu, 19 Jan 2023
 21:11:15 +0000
From:   Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
CC:     Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Subject: [PATCH] xen/pvcalls-back: fix permanently masked event channel
Thread-Topic: [PATCH] xen/pvcalls-back: fix permanently masked event channel
Thread-Index: AQHZLEqQuRGgM2P0bEiSEaENUdLo/Q==
Date:   Thu, 19 Jan 2023 21:11:15 +0000
Message-ID: <20230119211037.1234931-1-volodymyr_babchuk@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.38.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR03MB3710:EE_|AS8PR03MB6840:EE_
x-ms-office365-filtering-correlation-id: b08107ef-535e-4bf7-0817-08dafa61b36c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h3iGwIPyAsL6v8b4J8MaNg4OGRAEfnMh9DgOy2fZEu/eHqxmViygsV42/qQt6GTzzVA29K+MelotLTYfCjv+ZT5jqS7BkL3qbE4m+tZyDq9lqDuzw5aQh5aGBR3Jq2ZzQC62GH3Zy0dhAqMiKH9ci5UJEGvSZtifEpts7MPElH6hYtvoHcwV4cPA2/7Xxd2s1Tv3AYDa8eu0fXdX1zir3XcXiS9IA6wbaTG8HXSmztMB36XewnW6EDAn7dicKdonpyF2afqD8kZnEsbIvqruPC/YlmFGGgiTy9wfUzeP3VdDdoQUgk+PReYaJLGs9BjDYIeLfH3YWRv+NrRqlZswZgnyK9IkEUtW7vZbwpBVwggtK5lp08TckxGkWKEwTkAxxFDN4CaYgirg5KHsJK49Atuvap4+QNe1XoD3FhzeQuhXXlKlyVh1R+QHWA+3LH7dV5kC1jv4TSNO4E1xb6j3c4MpLDk3g48+F+alp6TbtSrLUbTIi4iY1Gobfx8rwonDJumnfYsMfPE3Mp89mKJOMCaAUCbojielZPtk2d3UrN/kwJQIm11fHjjUxUH58kk/TLe1KlnuAmXiGniaOBZPBnS8jAq1Eo6Fw3kn+ciojK1wAX4sc0+qE1tba4XRwQSl3gU3UfLR+7k8Ts51S9RlH5KvInassdz4NNq3ALnmAC5hQoVlS8Dqcse3z0tKz6bRxTF3zcjB+PDyaUXQ382Arw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB3710.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(451199015)(107886003)(86362001)(6506007)(55236004)(36756003)(6486002)(478600001)(71200400001)(8936002)(122000001)(316002)(5660300002)(66476007)(4326008)(66446008)(66556008)(91956017)(38100700002)(76116006)(8676002)(64756008)(6512007)(41300700001)(66946007)(26005)(186003)(38070700005)(2616005)(83380400001)(54906003)(110136005)(2906002)(1076003)(66899015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VQ7n0jlfBEMBPaKLUzK0wK5x7aDqgHSegP/Oc0YEb/hEGSEiFysf6hDZTR?=
 =?iso-8859-1?Q?nNO/8aYVey81i38+85fGNf6FC004w3HNiMvXQ8lgaemsk4kIy4a1x5Uahq?=
 =?iso-8859-1?Q?SN/g+hUhO/AcupuvSnyMLtGUnDHwyglVhSUMt20v+3LhogWyk3ykNcJR4u?=
 =?iso-8859-1?Q?mZhW07pJDHb7rBco68ZexPuBPMtuU25RcdpX02fT9N4x4iFH2QjrPRjAUk?=
 =?iso-8859-1?Q?boOn3u62B4ZlFGNHAlMtQdXxJ26e3DuGjw38sl1ScYrBbNNJ3xCm1EMzCR?=
 =?iso-8859-1?Q?LQD3uSBh238QnUcrWOVg115wm9vUKtbp1dD3MOpzgyvjrLU7WgHFyVQvso?=
 =?iso-8859-1?Q?ec8SQDHsjVeN826OmyTuexoGbLYcocp/E1YRGrGVt6+o9w7/7ecQzLFGlL?=
 =?iso-8859-1?Q?IhTcC2o0FNGTLYaeMSv3+1Hc71ps3fTwuJD5Ay/JtzVYoEmbF7z5YzqTKQ?=
 =?iso-8859-1?Q?ldRlbbvKctYczDQRG7tqaTqJPyiVC3crrfn+8OvcIYKfK82eGQ2cEP+v/9?=
 =?iso-8859-1?Q?qBIKtZ0g2U07uI6o6xr/Ckyq+SBZpOtXyk9SU3Jz0W6BTzNeWbFSDe1GzM?=
 =?iso-8859-1?Q?e8jC4g0xLZ48tAF4xGxvVBmzvnJzDoEnj6kkk0Y7SDBOAYHG5RlVQhXvvL?=
 =?iso-8859-1?Q?fRhKMtbLNMl9d8AIsAyeZkMldIbW4q2Fjbq83NCS7pS+2V4s1vMkCDQTaV?=
 =?iso-8859-1?Q?krjNA0T1CqB/I2cNX74n1+lEo7Uv7uEbCsNkZ57L4beQ4wiEKx9ntYyjqL?=
 =?iso-8859-1?Q?cTUDH2mS6NBNJggNrvKTJOavwOnqDaORS8QtzbOCWdX8tUzVyD17aKpE9e?=
 =?iso-8859-1?Q?n8K1TKv8IbwkDJ+SM5GILqv+6J2BXZoDtitlBwq0xhiFlRcs4cCqwKuHMh?=
 =?iso-8859-1?Q?F1ScAGdqfpTC0Su74CifP92OZW0llSnAFUUrOUoKnNO9ZZmba0cKekqvSA?=
 =?iso-8859-1?Q?+5Sp7+KDACSqnQcUU99zWFlDPBng0IlCzEgZEzQqTu0914FwgVWmqAbyVt?=
 =?iso-8859-1?Q?5F9X6Xls/HLW5hy4tID8r2p6kDuKSDLN+7xYaYjPuzT9EwfjiwqtB5qpA7?=
 =?iso-8859-1?Q?GQIVPcLx2B3yNXZeUBXhmjhr0LmeW6XbGttwfVuZxYeAYmfknWqCEvaIZO?=
 =?iso-8859-1?Q?NYaTdOXXfvl8Hscntrxwk51vVvP2pvKcotjPVVIWy2ZwkbZ5SPN7CvBCaI?=
 =?iso-8859-1?Q?196l7MIIW+FBooSmMzU62YomiakkIq5klETcayRvhV1V8t6+s/yCczcFZH?=
 =?iso-8859-1?Q?EaX3pwKnYUFSCNTSwN3W3eQIYx6qUPWqKgOPZJ8FwbjSovCHjv8Nz5ou6l?=
 =?iso-8859-1?Q?3LaC2yPwaBY4KgSseSdxDrhg6E61uZRxWJQhycMArokVIJO900+/tUL7+b?=
 =?iso-8859-1?Q?2Q50/dWYDIpRMpCiHV546F8L2gMLzUVW/op5fKuI1zA0uqEt8wJzmmLqJF?=
 =?iso-8859-1?Q?+4EniBrEIDYcsJ/DpT7UkEkesmjF8GqlL7tOTcilraCLQMOm2SQMJyGYfK?=
 =?iso-8859-1?Q?dMM9Jx7znD+kXx5L+plnJwvEAsG38dl0x5l23OSmX7Czb10EalBN8k7AFS?=
 =?iso-8859-1?Q?QedmCrTLm8Q3o65FTXaO/xXxdF4lpi/dF8C+Y8cLjtJLaRlA53x+9y3iXZ?=
 =?iso-8859-1?Q?SYe6kIxT0k+6Gwa8pK2OzZsMGKlEUweMuF4Oc4W7tbsGl5fde4RhlzPA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB3710.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b08107ef-535e-4bf7-0817-08dafa61b36c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2023 21:11:15.5007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NhCyDbiqHrNSxhseMNkqf4+1vs2rBVnWdBq84rVqsOOAYFJl7k5jyc8fKqxfNkl3fyYSMRtnPm5z1c2rdS40j6+ouB0m8pTkWdCkO6fazvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6840
X-Proofpoint-ORIG-GUID: ouClumBOzvn6CkxX3bejVPFm-vDk31IT
X-Proofpoint-GUID: ouClumBOzvn6CkxX3bejVPFm-vDk31IT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_14,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 clxscore=1011 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190177
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a sequence of events that can lead to a permanently masked
event channel, because xen_irq_lateeoi() is newer called. This happens
when a backend receives spurious write event from a frontend. In this
case pvcalls_conn_back_write() returns early and it does not clears the
map->write counter. As map->write > 0, pvcalls_back_ioworker() returns
without calling xen_irq_lateeoi(). This leaves the event channel in
masked state, a backend does not receive any new events from a
frontend and the whole communication stops.

Move atomic_set(&map->write, 0) to the very beginning of
pvcalls_conn_back_write() to fix this issue.

Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
Reported-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
---
 drivers/xen/pvcalls-back.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/pvcalls-back.c b/drivers/xen/pvcalls-back.c
index a7d293fa8d14..60f5cd70d770 100644
--- a/drivers/xen/pvcalls-back.c
+++ b/drivers/xen/pvcalls-back.c
@@ -173,6 +173,8 @@ static bool pvcalls_conn_back_write(struct sock_mapping=
 *map)
 	RING_IDX cons, prod, size, array_size;
 	int ret;
=20
+	atomic_set(&map->write, 0);
+
 	cons =3D intf->out_cons;
 	prod =3D intf->out_prod;
 	/* read the indexes before dealing with the data */
@@ -197,7 +199,6 @@ static bool pvcalls_conn_back_write(struct sock_mapping=
 *map)
 		iov_iter_kvec(&msg.msg_iter, READ, vec, 2, size);
 	}
=20
-	atomic_set(&map->write, 0);
 	ret =3D inet_sendmsg(map->sock, &msg, size);
 	if (ret =3D=3D -EAGAIN) {
 		atomic_inc(&map->write);
--=20
2.38.1
