Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAABE65F43E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbjAETRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235491AbjAETQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:16:25 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D28EE22
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:16:17 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305ITwdG029112;
        Thu, 5 Jan 2023 19:16:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ZOLjRMKcGRah0SkriUEnVf9iJfrlXmxLFviwP1H6bf0=;
 b=rlvmFaVbzYNK5FO4Uwc/Jy2DGVFcBNbXOhskfyWcL9cUhmBhDcIpNWRWEyxWSpC7GZPK
 84yjFFa+SaJeJvBPIJvlgBuFfMgLiLjVnaLjqRh0xk1Afy1GQ+aFSTmijRYrk7OiW1fI
 2lmvy80yobC8s0msugZjZlyR6igkA4BYI56Asmn4/nDKk1VcPLa0lpkqdAXOMfudVDgv
 DXBsJSVy79KtlMTClDhNbP1irDn5Q9QdK5gbmh/7On6oJ3x7TJXU9C4Dx379vHI+Kevo
 w08OBKNBdkMta/Ur3lRr/yg6EI1wTxyRzAFosPwTGNK6nBPWtu2kbkFYuy2YwYyFyi0G og== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtc0asrkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:05 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305Hvlps023372;
        Thu, 5 Jan 2023 19:16:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwept6m1t-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVRYt308hn4npSzEoswjGhwQY/sGj+N/VXX6XwZBSy14L5A5SogW8B5hfRrBT0u6+OgaGXUje6JJjv+iWcyeeldXh8KdH/Re5ifFMRkew3vBBTRJ8d/qFcum0fCl3K64fijBsatfmKlguxcDZg+/e2WD/+RR5/BXniwWICytGIoAryLCOtnZOwTIUyRJRMBDoV3Mw2adX05aFKt4orptCkbceT5EQTcd8hp4+U6yeqsKjYTzB0GuIGm085ZUiMcKAt+zFyLkwgXtYXYXP1yUPZdnotT3yT9iWFHAr5yfSiV4SWLM9RA9C1ymeLHuziAzb2D2Y1goafUETnP9s7O1Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOLjRMKcGRah0SkriUEnVf9iJfrlXmxLFviwP1H6bf0=;
 b=aBlrwJTioH3g3/HntOm2jWk0VJx5mOci9aKtF0lpDzQ310E/LvtNf3Y5Fy3kl79Ah4m+iXHJK6gQmL/7l0S1Kkm76MIt1jTyFvJuYdF2ll3SY316nBoshxoXqht0rAvPEP1Dg088IuZ2SHrJWox0bHZRT4hU66GrGOGU+6SkXt7aUR5vRSD9Vc88bMFhyleJDetvZsrmcD3BQtnsRBQrlAF3NCd4BiuVAa5gjI7PNOkMIfgsXL1Ip1AN4gpLYqBDZ9p7BubKBTcUZodudxY+jrZz/GerhHjPOpU1DOh3BUhFjZ6ap/4kVZHsLlyjyTFrMlQy9PLrRC1zWKO8MP0EhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOLjRMKcGRah0SkriUEnVf9iJfrlXmxLFviwP1H6bf0=;
 b=rpZx69ifClkH9uyz4MwVaArA7Qmsn0VYItX3sY3uXgNCpVemtvy3wTCyaf3ya0oj8vpGt+tCrTCsQ+ojnsCO6G78EdcSkYrRZsP+vT+kjk8M5bGIgGnCozkjn7dzSTtZRokn2oGghnARIihwIyj/dZ32hZEQL3IZ1bgWRDL2OJY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6075.namprd10.prod.outlook.com (2603:10b6:208:3ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:16:01 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:16:01 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 18/44] mempolicy: Convert to vma iterator
Thread-Topic: [PATCH v2 18/44] mempolicy: Convert to vma iterator
Thread-Index: AQHZITojQR0bNu46JEWQV7nrYFuiYA==
Date:   Thu, 5 Jan 2023 19:15:57 +0000
Message-ID: <20230105191517.3099082-19-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|IA1PR10MB6075:EE_
x-ms-office365-filtering-correlation-id: 33094665-4373-43d5-e008-08daef5148a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LQ3BCfPEculYXL9RpBB9tv+yVG0BMEraA7V1g+z5nQPsdoeeJtx7VWsOj0hGTjw6kPVAO8SZrYwYSGqSqJmMPR13Og11t58d3I/EJpC14tVGEvjc/uPup4670faaOdsxYumJkzhCxZDuBGoIOw/9r2dFy1HDM5e7dmcGCp3VuEAxwqkFtwmujoBjYiTUbuaUcldQ/Mk96bKpuWGg7Gx7igy+8iTAhLo4P1saAeLT9BtxN6rw9W2rLh6oXAj5hcHzx3g5zu22evdvzxmtF2r3ESFzDUT/yOgbybsnSzoflGR2kGBktAWPSsF3ql5HwPyuKx/vhz2GkdV63aXHixlGaBTXQRZ8SH864B4bVtSoZuvOxQYIeAWX9SHHlveF8y8ny4CHUqE6RoBwnVujBlfAxtegR3ydWJ5ILbXfYQkkAiFXbnD4s73Zb9UgqeSR1jGzJpjLtPAr6wEN+aUuudugRfNGHzqfxu5GkHK4zNmixoWkB7DuVREKLWz7zIo5ebmyDLAQuL4UtUH43aEJfE5vasgb1yssnSrdhKESijR7bqMB1hdQ7Iqx2I2QTClFM03/paTNt9M/LYcNseh66M0xzVZ+pCz4VOgo89XVqVCpH5G4QxZePPJzKy9J9heqPQj3qk1Epz7xxZDqMkbrf+NrrkBWv85CewiwuKmzKanu2kaMsqj7SGNAEDdNGpiyuOcI/1i5nfoIn5dDcNQq4Sksuw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199015)(38070700005)(122000001)(91956017)(86362001)(38100700002)(8936002)(2906002)(71200400001)(83380400001)(316002)(66946007)(41300700001)(5660300002)(44832011)(64756008)(1076003)(66446008)(6666004)(4326008)(6506007)(107886003)(186003)(2616005)(6512007)(66476007)(478600001)(8676002)(26005)(76116006)(66556008)(110136005)(6486002)(54906003)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CUy+QztiyZwJMqNvrEfWyHNklTuakB+xU33/vLXV2D2V194UM66K2QvYYH?=
 =?iso-8859-1?Q?9INWDeZBMTtKxV6dS4ZlF6TbkszyE8xTi+mbNhe3igJaYUIRgUf9zLljP3?=
 =?iso-8859-1?Q?z/t9zVYDyra+Zamnq0w4A7YXYC14kQ2RZ4K6x8dSqTV4uhYGxC16yhOp0f?=
 =?iso-8859-1?Q?jmDeO0xPDNALb75IpsErYBLiS/B49cQOOxMLUfc4UWVkssaT7mADMpsaFM?=
 =?iso-8859-1?Q?D3XnPLPnGZzzqEFF2OuDm3x5nCR6G9GbxG7bvoHpLH7a36unsGt0JLo8C4?=
 =?iso-8859-1?Q?UXX4+FSzIPYK6F37tJ4xd8X3Q289FgxJSajR+UDFWXhxFffvH8XQgSEPcN?=
 =?iso-8859-1?Q?9O3R7wCr+hv6/s1Y8FI+v0tWPaFqMBp3skH+iPJxho7c51nNQqftn8iBoV?=
 =?iso-8859-1?Q?knsWT6NpTdTc5gAQDxwklq5gfPU36mOI+lKCKSVx76XlrcTT4RIELbljzS?=
 =?iso-8859-1?Q?t8GK6YXecbhFH3hqsgUzN/jHZ3FevFLQkBL7hxIX4fAGJjzf3nb/MeHu7K?=
 =?iso-8859-1?Q?UDNG8aG3AS6UVfFjJlR/1zAGxuS+M/ZxlM5NF/bQb328gQavdb48NRQYij?=
 =?iso-8859-1?Q?x2u892gOpJghanl/BkI/jjNUnkbY00NDFUpyyLYCjayI4ktXaMg8t8znWw?=
 =?iso-8859-1?Q?EYsuBQE5zW4XP5D1dZeYJjgJMmrtQaN/dCrTbiw2O5B3LWopuA9ge0whgF?=
 =?iso-8859-1?Q?y4lHJRLciX+sqXtJeQOCyrmLw22S1pF3TvoFADnJ7SMth1NwOBcJTkxHWN?=
 =?iso-8859-1?Q?ZfwD68QbFoPC1Ly0rrCpTgvNcRUgXSyWCzSt8djSjwK1qQ0UT9aSqgqytv?=
 =?iso-8859-1?Q?p/80IO7VHmQnDV5zoK2EMDRtr0y1KWXTXReniIlTjx2x/AbKZj7ky+QbpV?=
 =?iso-8859-1?Q?UkBJZzcOr6boy++32we3WtBQ1eq8gmkmBhnA59wK49sB9iL/QxZmk/A1Ra?=
 =?iso-8859-1?Q?I0brRpTaLHrAk4UoqF4Eh9OYIbm2sTzzwoTVOe+kIqiWogBS0a29slAPBr?=
 =?iso-8859-1?Q?zH0gh3lSfL9fF3EgIFlBVWfzdEK+y9XNyD11Wlk3eqcZP7Phwaf6kNNVlr?=
 =?iso-8859-1?Q?KW5Gs/9/ERt2X6BtcshEB84tIDa+1M9prXR7nQbVQ25ecGkvmqFb8bDBSX?=
 =?iso-8859-1?Q?hBSobwNMmZsBnP8FuTvjoacBCwFZa9oxBM/Lf5QcieZo/c252y4UV0L7Jl?=
 =?iso-8859-1?Q?qmxd1rjAbnlQE69j3s2c4gjQk7zdlk//lV8EoiYMqoTXNmEJ5g3sLJrRHr?=
 =?iso-8859-1?Q?h9SgSDipihJWTm+01kf9xjqjfbnI9qZLPlM56BD4a5SUebccjJG8L8vYu+?=
 =?iso-8859-1?Q?UTg3GFz7P35vupDkOl2MJBu5LAxau8sl8ByhUm75/rjCDR3DMbW26IGQfr?=
 =?iso-8859-1?Q?eev6+Pj2EIvvRYNwWb93QJ+UhF2SLPpLNAaGCB7o/SfVoDBl5NR42oXn84?=
 =?iso-8859-1?Q?lms7+ZQuhNWBdSOGgXe82KNWa+AUdNkqK/2bNY6KTMuPZGW7f0bNdCSks+?=
 =?iso-8859-1?Q?YouEElHqYBsyReaL/c35eMmmmqNVJblualL9HGCcetRqZoc3lzummESPFm?=
 =?iso-8859-1?Q?2is1K2Xfi0GQ6XBXZ0D/nxvbLj9wFHhK4cmoIJ7scJltzPCmlEXsP3fs+1?=
 =?iso-8859-1?Q?QhGy1wA0xwPRdB7nny2XUpyzE1piRnh7SKNsZUfiynvGZguDXZNHLUhA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: X/hlp/36PCFPXA36Vs0RgvUaKFqT9/UrbLBbaqrKoxPdm7bRKxEmNlHWl6huuDdleOuCNmpbYsQSodhBl0wtbPuvEuzMyftZ+gGjOISV1cmrCYX4tnfBcj9WM9VTnkes4KEy3d6MlZPweLeKrEuPNIAEOQxOCIojBZXQUNI4+1LXMmP7J8miEa8sieT7cB4rSg3OWv40B2sn2hwrly3Xz88WwSBrYx0HWCrYOv6UKuS+5sRAnl1iX4uAi77ecez8CCfZ2Y6rnoKUm6gr9RCUq37XUW8Njoy19cqjMTAZ5ADdryyPKyr6UrrG0pE/bq1/J0LPRfrtwSY/YY4KTnyoXDiTRUA3Em6Rxo2OEfb/fn2J+rDc04bqIm+8OsmxLUwyy1bcYMqiJ6eufX8qMZqFdbuHRwAEfUbDWLx1Ix8YDqFKDK69NvY5ZN1jer/0gOOsLtclK+OQBfDBouyo/Ue80IiYyPVPunmCzWuFvTEKmpPqRqnEdzjQNdxmJc4yNvIhO/MoNrUzEhIycEw7dREp2mBPUesvpy8NnpxYIl/KU2VWyVBdP5YvjY5U7nrk+WrxcYLv8n6SVLqxlbEu1gwk291+Y8u72Hj9W0SB9AwN4p/2PtnqwfWjI3qD6tEzZ3J7myJuyZvES6st1kewgOg1xNN2fgAJFLmKmBArsC6TdHrH/9QEyPXlfLgZZz4nEryhqNj0pN2TUX06+xbI0qXfdqX0ZPCu8QQkORwKbob51F5zIGWpt39BBo9LaPsmkury8aG9Z6Nv+rfZEwA9vvSjZ2YU7MFQiWcdjlBUzO102rT3EebEBHl6mogdVpB3O5jL59WXa5YGLZJiu4rCCpK1y3uW/TqMXCBCZyQD2XhFh7Ow2WFkV7D2TtL9lwPX7tbKNbHj/QKFr8vheUREmhuqiA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33094665-4373-43d5-e008-08daef5148a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:15:57.8756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CA7cnuFRhyGQ5SaHWink6XGkSJHVzOzPT4ux2xlmyD2G2itaygw6gsmNrU0yecyPjc4k2MW4hiKBbzI3KPMPeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6075
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050152
X-Proofpoint-GUID: Y9ZUs5EXdjX9YmwDwncjXe50waS1pZ1D
X-Proofpoint-ORIG-GUID: Y9ZUs5EXdjX9YmwDwncjXe50waS1pZ1D
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
 mm/mempolicy.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 02c8a712282f..6f41a30c24d5 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -787,24 +787,21 @@ static int vma_replace_policy(struct vm_area_struct *=
vma,
 static int mbind_range(struct mm_struct *mm, unsigned long start,
 		       unsigned long end, struct mempolicy *new_pol)
 {
-	MA_STATE(mas, &mm->mm_mt, start, start);
+	VMA_ITERATOR(vmi, mm, start);
 	struct vm_area_struct *prev;
 	struct vm_area_struct *vma;
 	int err =3D 0;
 	pgoff_t pgoff;
=20
-	prev =3D mas_prev(&mas, 0);
-	if (unlikely(!prev))
-		mas_set(&mas, start);
-
-	vma =3D mas_find(&mas, end - 1);
+	prev =3D vma_prev(&vmi);
+	vma =3D vma_find(&vmi, end);
 	if (WARN_ON(!vma))
 		return 0;
=20
 	if (start > vma->vm_start)
 		prev =3D vma;
=20
-	for (; vma; vma =3D mas_next(&mas, end - 1)) {
+	do {
 		unsigned long vmstart =3D max(start, vma->vm_start);
 		unsigned long vmend =3D min(end, vma->vm_end);
=20
@@ -813,29 +810,23 @@ static int mbind_range(struct mm_struct *mm, unsigned=
 long start,
=20
 		pgoff =3D vma->vm_pgoff +
 			((vmstart - vma->vm_start) >> PAGE_SHIFT);
-		prev =3D vma_merge(mm, prev, vmstart, vmend, vma->vm_flags,
+		prev =3D vmi_vma_merge(&vmi, mm, prev, vmstart, vmend, vma->vm_flags,
 				 vma->anon_vma, vma->vm_file, pgoff,
 				 new_pol, vma->vm_userfaultfd_ctx,
 				 anon_vma_name(vma));
 		if (prev) {
-			/* vma_merge() invalidated the mas */
-			mas_pause(&mas);
 			vma =3D prev;
 			goto replace;
 		}
 		if (vma->vm_start !=3D vmstart) {
-			err =3D split_vma(vma->vm_mm, vma, vmstart, 1);
+			err =3D vmi_split_vma(&vmi, vma->vm_mm, vma, vmstart, 1);
 			if (err)
 				goto out;
-			/* split_vma() invalidated the mas */
-			mas_pause(&mas);
 		}
 		if (vma->vm_end !=3D vmend) {
-			err =3D split_vma(vma->vm_mm, vma, vmend, 0);
+			err =3D vmi_split_vma(&vmi, vma->vm_mm, vma, vmend, 0);
 			if (err)
 				goto out;
-			/* split_vma() invalidated the mas */
-			mas_pause(&mas);
 		}
 replace:
 		err =3D vma_replace_policy(vma, new_pol);
@@ -843,7 +834,7 @@ static int mbind_range(struct mm_struct *mm, unsigned l=
ong start,
 			goto out;
 next:
 		prev =3D vma;
-	}
+	} for_each_vma_range(vmi, vma, end);
=20
 out:
 	return err;
--=20
2.35.1
