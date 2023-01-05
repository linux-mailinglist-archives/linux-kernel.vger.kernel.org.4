Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9334565F42D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235478AbjAETQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235345AbjAETQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:16:08 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592D68FCE
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:16:06 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305ITwAl029120;
        Thu, 5 Jan 2023 19:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=AtQwHozD7Mms2T+KB+fR41DI5ZLtsKdl62R8KThpOeQ=;
 b=jmKsWUNa6o5cycWiWSFBw8D4gXy16xRbZefHKWSzKReOPri4sTgoOyOBO69NaiUkSpdU
 KXXZm0QEY5XMo8Q0NIMh0WK2DMJIO2TvQ3UCAWrnGq4ZJq8A5Ny8idmvRPAf9lSimkcJ
 WNTDjDjYLv2XkIN7oSXFfcRP3Fj5eQAM72I2g/sX3wJYLsyDVZoVaeCg8hmTcZZSFaBL
 h5vVET9V9mTbEC81/Da5qxwBtRL8sPI7s7uH6Aytk0nKU/7npQJaJeKOCHpd90ikl87i
 PTSOaeItBBPO+GchgFC//l6MagRZwBLUfQlt0wBrM1Hi1woadC0TfzjMq4GjGWpBFG4v /w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtc0asrk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:15:55 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305I0WPF023380;
        Thu, 5 Jan 2023 19:15:55 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwept6kx6-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:15:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxtPtkWl1e+YCaxnRoxg1igqX6ERNsT2KhJlbjIm6YnEAgGpjJxCfUH5puluBdMNcKGgpp0q0CFnN/dCgG+LhJXd24KQPHi7DIjnWaNiTwoZ0feXABYDMawKlggaAX+dm8j4gBzjg/YNNjoBf+dprA3OszZLPBp5i6Imb7cXA3gqlwrvwHOiUP2dodwyj7WBPHdHnSpIfN8SxC0ip2g+H5M9QzLr1Vd6z8ngIvSjavOZFRTX4MIMJJqypdXuM9rne+COXGmxwMYREuE2eZ+yHGrCAJ/fja7gZNIxrLEYxG/eVb8cMLLyje6BsD6PUoPe+6H4uSRd7DR2DZzFFn+23Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtQwHozD7Mms2T+KB+fR41DI5ZLtsKdl62R8KThpOeQ=;
 b=XQ15/a6mxNYQaB4QWgFHi4VYXgCmHM3L4GNmtIkGsDsVbVqtXoA4IF8W2lfizz2xpvQG4uLogfof0r/uzUYu04wmqtRXP5AkCVRAKGvUHzgRJYtm67U3feg3X/LpNsz5dpff/m49EH/zU5cXLqC2ZqiTR18t4ygq0jQ/c9g87baKvJD7/PWp3FwvSnH+pEi6EQi7w0z4iR3mqPiebRgwGwhr6ePWiGymd+zmBG44WYOJAJIjCqQtgy+otYNi7U8K55CdkhLTrD3vBpEVe0zOnCZ5pqgpwQZ5SClvl6GbHTs7TdiXbWUuGTZPgGy7KbMlMIOUT747YbJz2ugbh+bvsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtQwHozD7Mms2T+KB+fR41DI5ZLtsKdl62R8KThpOeQ=;
 b=FCtPmTdWX2g7KI0/XSXusspU8Ae+hsNWWSLkK8SSmyi+IOLDKfkIE2Spywv+IPheTG06d9o3PbrlcolxIJPBNOVm/7ywONplJAC3c2eNLddgZxgLnbDwDnkXv4DhOmi8pCa5SIGrXtnGuOInttQp+0Mru7j/GKaFL8qRNWdlK48=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5231.namprd10.prod.outlook.com (2603:10b6:5:3b1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:15:53 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:15:53 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 03/44] maple_tree: Reduce user error potential
Thread-Topic: [PATCH v2 03/44] maple_tree: Reduce user error potential
Thread-Index: AQHZIToh4iSN6+fCUkqyQ0xEo8BZ1Q==
Date:   Thu, 5 Jan 2023 19:15:53 +0000
Message-ID: <20230105191517.3099082-4-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|DS7PR10MB5231:EE_
x-ms-office365-filtering-correlation-id: 7ba49b5f-ab70-4ca4-b7f9-08daef5143d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OH0ADRyucPyvn7zwVFWLmjhLb6Wa9WbPRyyJ2+mPKpXoEVcBqKH4+TTyO8gruJYOSpws1ZV+GvdpTQABytsujIGQE/XiJ9pN+12cTFSPXF1JS2xPXht9Rmuv9MvbGC9Kjcx1eIXPfvceaSy4CtA0+DWSxogERuUqS2L1pyhdlTHLHN/TscmfBzix5Cfo23qtKQcBzNGHmbfXVbkHPbHefqzlx0S3B7AjM2mfXrluhFmyal85NH2JVNOeqqwgb2Z8oX4E5I2dKcTR+BnQ/0VuOfqsg5/3Xplrg+9ms+IuSQaLPhCWSW/m+Em4CJINSyfjo4F4+leriTR4usdXzyMbfwlDhNBwgRUo0lmWhrD37o32KcC0v9ZxnNqswHi7c+eyOpyBVGzu8BGvm5bJxZIdyMJTaOMqPuhC08TNjWqtJH5Yh9F7XgM4irIl3JTpHd4I3dDNf5E+2qk2fsyJHeUfWF+CP+By7GpF4tvjWRWH1bTrsKzpVOMFw2zkzdOXbrFS2x51b2dU1Oq4bBYgrBqah8sjGoI69G+TZQ0HNadheZjt+EvDyAAogAhUVuzJpKO+PTAaTQxGjEpxTePnXYlaVDeeKtye4hWa9xr9upmj74aXMxBdarztB1caONR3rXTAqwMRe7NYdYhY9Lcph/dgNMCdSvL1l0OfiY9aQAQeIMw+zfR8glAJUd2hDzWYMRovtazzZ3O0yK3fIb+rmRc3NQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199015)(110136005)(316002)(54906003)(6486002)(186003)(26005)(71200400001)(107886003)(91956017)(64756008)(66446008)(2616005)(6506007)(4326008)(66476007)(76116006)(478600001)(41300700001)(44832011)(8936002)(83380400001)(5660300002)(66556008)(66946007)(6512007)(2906002)(8676002)(38100700002)(1076003)(122000001)(38070700005)(86362001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gZSuhwrIiZmcQiA4mGSUBRjaOkTf9/9EftaXsqLxMyySJ93CFdYSj2IAuC?=
 =?iso-8859-1?Q?0EwumcQe1YA/tALOovzdNRKHVmrVEJXMxi8LTDUJNrjCyuIrPpvzHCNhHT?=
 =?iso-8859-1?Q?L9Z2V/FBVf8jdsnCpFKXABhQCKcFRduZZhxo0OSMBOoXZSRa6JGJekEhxH?=
 =?iso-8859-1?Q?sdJpgTTKIqD3j0Xs3GQAAE//nqULf/N15eED2SM2pdlOPJ0gK/lhCqPizA?=
 =?iso-8859-1?Q?tPJIHImc4IrKq6BpZoBkjNGzckjqrPvIWsfP28iE6j8SFiRr3ZQfJLYx8t?=
 =?iso-8859-1?Q?S19waSqpBVY4s+aRfttfiSEjR6w5zvq67RxxCyc3LWJ1MzXSMtAdR0vm5L?=
 =?iso-8859-1?Q?ny5eAwJRDZkg5P9IXAGWA+TfIYAP6mfuHfgNeQUYqhc1hAcodOOgRVhy0v?=
 =?iso-8859-1?Q?0OCYdgyMplXjKaRwEAMhgeI65Iqlh6RqevQdWF8wcrw0L7k5vcg7O1cxDw?=
 =?iso-8859-1?Q?UsE7xV0qvjtFr8PgIVg19w6pRp5yewi4WL9txdidI8biw3TIhibXFx8Kn6?=
 =?iso-8859-1?Q?l2DOMP7YwAkqlMYGcgUdvMMOREt5Zpkc0iB17BCFgpdExiE0jDY5+sln4J?=
 =?iso-8859-1?Q?OlsaHnXsrY973YzzNC4BDwFW9xCK7xZMissk7/YQmP3MdJy/CyvKpksc26?=
 =?iso-8859-1?Q?ERLfr11I1nRnVjVniEG/KHSytkSN4NKEtNQA/3mTlPsUzNNWGHNS+4EIOF?=
 =?iso-8859-1?Q?fMdXbYerYRZ2c7SnRb+PeqDIz6lQybRUQCZjvXMwxhgs6wKIhFtB7bk176?=
 =?iso-8859-1?Q?MWuGqPcs1k1r9Dc8UiM798OVV1Pb3GYyQKrNbCaK+Af0poGbH4Dpg7d9K0?=
 =?iso-8859-1?Q?UhD+YAwD9ngClh+4Xfoe2qYNT+9G3i0GfZC5Lja2pKtXP3lzPS5X9J4nEV?=
 =?iso-8859-1?Q?8/wRjUaDEdz8ip3CNEyPQfUqdGJNEXgcPtzB6uBDTpGMLqFfvnFKHBoAas?=
 =?iso-8859-1?Q?R4TYWnzzbrSpiXnp+Ffw4jwzDt13Wrk3IP0OvY+jtNfcjv6RDRwqfjmgOp?=
 =?iso-8859-1?Q?d+lTLkQVhAaSELiDh+ebBxXJoYkDSAyc6LgVM3a+xSrNch8uH9PKj0LEF0?=
 =?iso-8859-1?Q?64s5CzTzJ3CpFH/FbWoqiXIUAjrekF6XLFsjzwGfEi5oPK1PJwlvv34X6u?=
 =?iso-8859-1?Q?bCgQb9y5ztvpGCSIIanFxxikDwoVjvSsBxhkpci7Iy4zybegVHJZFJeKni?=
 =?iso-8859-1?Q?1Trb5LDcKJh5ssHsAq+092QlP2k+v6m4nVmqVHkfB9w8c3VVA9gwGXQSSd?=
 =?iso-8859-1?Q?IDLxUPD6zm223yNDF3XXMBG1PpzT6PlULW0151bukaP5Dhgmqb1SqFjRdm?=
 =?iso-8859-1?Q?DPmCPCc/U5/TrLUA42TJKUf0pZsm+3lzhlwhwMSag8SEUoent7M3DVILkx?=
 =?iso-8859-1?Q?xE8BkQ56f+5otzUYoPydZODAc6SbDtgpmJ7TXJv13ocu0hUV9cq3aitnjt?=
 =?iso-8859-1?Q?o2lTqXpFky0rwHDPfE+3ToYFvea5hlDsh0HZX4hK+ID6DvT5k50q9MZxJc?=
 =?iso-8859-1?Q?PRlJxLzNqJEwOuU7FHQgoNvl4W2qxh0ibD+nCV9MuobutvQ71S4/KXmsfY?=
 =?iso-8859-1?Q?7nJDX3mgZUzkjKOvEsOebEFxHGMhqn4ybeMoSgqn6x1L2AMkxbxyW/BNuR?=
 =?iso-8859-1?Q?lqC8UXOfG9A2BeRyqqT41PTpZZKgfzyMJCHMjRfJa34nWANmH6gj+nQg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /9oUu1drYhjr0NX0NgqqSXb+23UCVvf/YrI3uNOySma5FY2z2vQvdmqS6jAeXyfsc825PQVgAyShOH9WwxNM096Cpwcd0XrVbibt3D1vz4ZdKrGyDPYE1HiPmOyTeDZ5JxtukzxQ2AJWCMFzoJHHef+5BnR9fhLlZ+YFSJZInTSLV2JgzcfoTwK470roXx2CjvSunNfDgtYWc/kb1/bBn0CAVmCOjaCuq+eMwNrFIToCjEZYFdsbcFZFh4NZiFRntnwV4kTwiDIGPm+UITo7ML0DllJAXv77UQuMqNk4t8SPPCI3XKoD3DLsLwPI0MQPQrOUnwq2R0kZJxTxDZyQpXtwwi71g7ZUmVlWMDTjgao4HSHTyLV5k+ehr1roKyolNUHmazV65I+c/Q2i3WRgYCa/ajP6lGE2zjDymKmml1IIGbCR+bifmcnJ0MzrBfRK4xDsBrqXSvkFCN14qZu0tYqYAcEJo66HVvm86GecXCH+/3yAfKAQhYNo+cajzwvAL2v7jdX983O6pfdw7j+RWq2Q7JozTLgF0t9dqcFHwise9iwqEfM7H5Y56o+Q2djdGpYPytuZslPuo7IjXKvNGSfVOEzT3IOBsemDCPXhXt557Q9jSHptz/UxqMcs8Kuz/mVVhBTaAcQLPMBlp/VU0KnrjBYDI2FCBWtcdyUR0YGljY/IMszGmceASbA2sK8dsMF2Euv3KQdqMRZUiPyhpdgrfwelg4ZwnrTHLE9UkSkarKA+EWES3je55s4LSaSEmxY/bXlhMJLZKOgCaLYuKyH1iUTXnkg1lE3Aw87kuzk36dL202tCuuO9VhRKTcNc/JxiOaYjT966lDNuUeLtCYiPK9wOltAOCIqsZ751bPBumRhdjtsiz6LZ0aYhXeVNYhCONMqLOq0fvTcECAPsCg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba49b5f-ab70-4ca4-b7f9-08daef5143d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:15:53.2509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bW2SRiH28OT7l0bRJOmiBTwR4DNMmBNx/+vnz2LVQo+SpwVIhWGiWurH0ITzfS9XZleoy7Mj1UhZdmi0ia2gkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5231
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050152
X-Proofpoint-GUID: ddzLqBHdUSmzWE0SykCq2d-b65cmCCGa
X-Proofpoint-ORIG-GUID: ddzLqBHdUSmzWE0SykCq2d-b65cmCCGa
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

When iterating, a user may operate on the tree and cause the maple state
to be altered and left in an unintuitive state.  Detect this scenario
and correct it by setting to the limit and invalidating the state.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index f3c5ad9ff57f..14cff87cf058 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4742,6 +4742,11 @@ static inline void *mas_next_entry(struct ma_state *=
mas, unsigned long limit)
 	unsigned long last;
 	enum maple_type mt;
=20
+	if (mas->index > limit) {
+		mas->index =3D mas->last =3D limit;
+		mas_pause(mas);
+		return NULL;
+	}
 	last =3D mas->last;
 retry:
 	offset =3D mas->offset;
@@ -4848,6 +4853,11 @@ static inline void *mas_prev_entry(struct ma_state *=
mas, unsigned long min)
 {
 	void *entry;
=20
+	if (mas->index < min) {
+		mas->index =3D mas->last =3D min;
+		mas_pause(mas);
+		return NULL;
+	}
 retry:
 	while (likely(!mas_is_none(mas))) {
 		entry =3D mas_prev_nentry(mas, min, mas->index);
--=20
2.35.1
