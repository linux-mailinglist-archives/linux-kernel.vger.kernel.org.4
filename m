Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B0765F459
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235800AbjAETW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235737AbjAETUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:20:34 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205116F95A
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:18:00 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305ITchi025540;
        Thu, 5 Jan 2023 19:16:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Lb5D9dYmkvlyu/H9rhqwjZSUxhGiHpFzlJQ5XE2d2T4=;
 b=18kzBsQFINdzi/FKWbbU62S6Cgwal3UKM+e0RQkXydHNBjzxnEbMuv/HbQ6IKwkKEClY
 L5P9BI4PVnumNwqcwaDIMqZGtfM8qkor0VjDN4oFs2heS07VM+S9a78V/MNOGENxQP0l
 0HPfxGTP5nzAHrEWPp3M4pNlatN3ImQSjQwXTxm5jTIY0ZGXmkD0NiQ7Zw7hweYHAiRC
 Lpdm0CfQW7cegsbSs3KWL1NmTGJFMF/XRB3cU5o9+J/kiz7M5TpGLFjio9F+MbbR/B4j
 Mei3dsGpBjK6XfpS/IimoaEuJzzpZmM00me1bgFgdQXsCD0Vlt0T6jTSIA9pmYnvDj1q Bw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtdmtskws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:49 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305I9Tnn012151;
        Thu, 5 Jan 2023 19:16:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mwdf0u4xq-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ly1wm34HTV+j+cJfjIoZstZu8F3DUS0JdRl/9H0Vw3CVyLDuW/jPVR0Vlrkzmx9RYGI1SYPu/alOUCQY3mHUcvFUmuAMana1uPBErdIH3E1/51DG8ttxLDpya0h8fLSjxR/7BPawGCWwE0b5pCLT9iUSesTNmPlrS4P+SmzLw2H13h/Yk7NS/p37DvayoRydXceOt/fTkKczBLBqmt4zNUtxgg5kibVWxl1Oc95W3hT8PBQe+AhwFJxWXSjKjXkqiDtushSTHELqCKMldHNCF/+0umBqtoaVR8zUAUxrk10BHU2RbcqXcnKiAGP4M3JW9fj7Oda/ti83FPjM0dnfrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lb5D9dYmkvlyu/H9rhqwjZSUxhGiHpFzlJQ5XE2d2T4=;
 b=fZxGdVBcvI0usOzqzJnZgTatjPDlQZfoz9B6Avvt4IXb0z1UxDxjNPViazUEdALAiuQg0gmfwB1k5yNnluO0Ho9MN4GBxyelLUsEcJm+JA/18NIsrZeJhWFB32S1B5Iq5twZRydYjuNmfmxzysXA43BsCxfxJ0V8V0WxPqTBi/yQaUFse1X+SMR7Vye0od6L/t9gRi5xWx2MbVm2PqdlW09JHhxr60jYlED6neKxS1qwdrjIYJxFTBwfVpZLY+XmI7IZgCcFc6P0lAw7wbNuVrAiQZt5f8Rg2kp2kL3KjNQIkS5DsRiyc3ZpMbIjUckOWjoD4sIt3xeT2ypQmII0lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lb5D9dYmkvlyu/H9rhqwjZSUxhGiHpFzlJQ5XE2d2T4=;
 b=m3pUCj8DuZofBrw5djqddQXXkzZHwzClMe0xSvBsv9j2H2Z1podQi66BmtJukng8Wu2bDFJkKF905fHQHmVAbaDTb+h8skWPDKgtTshKw7O4VfT+dcUnVrmQxBpEdPa0hfwhj0Mrby26IAdKT7QKMrftlnWYbZ+415DHFyMYPsc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4791.namprd10.prod.outlook.com (2603:10b6:510:3a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:16:41 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:16:41 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 41/44] mm/mmap: Introduce dup_vma_anon() helper
Thread-Topic: [PATCH v2 41/44] mm/mmap: Introduce dup_vma_anon() helper
Thread-Index: AQHZITooigzqF61MskSaz0KIp/6GDQ==
Date:   Thu, 5 Jan 2023 19:16:05 +0000
Message-ID: <20230105191517.3099082-42-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|PH0PR10MB4791:EE_
x-ms-office365-filtering-correlation-id: bd052d10-48ef-4b2c-5c5f-08daef51607f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rL2Hk4UIkHYHxOPR1wqtdRYnllMslYymzvpLyu0mAF2dOolfjBmIrefCyG71c+7t0nTwc4eH458S+Wy+E6J0CZQf2+JZdMrfJznI+hag6T0drC8yNg/r4DK49Pwvw6aGmaBIVS0nXJi8GCCpk7G2yLQz2uUAM8NDqwYt+M4LFJ9UmF2ApukvGqaKi++0/qOviXDLv1PMQOdtcox4NZdwqv1LUW5M9VXY76TBq7DIV7DnokpHyvozGIOq/uetzcs1WAHM+77d+4qw+3EZu1aseQ5h2fpx1FFxb4egYwOdwBSAiw8QgtwdD7T6HPPky3nFUe1Rvgbgu2nCr7JZmIu2FjnJPqeHiSE289f06O0pL51SW5HBw+x/YQJZABOvY4xvFkRQ+2g9g42d882LHbk/vIe5cjySwCYIUVS6pdT8R/slEv9leUDkVwhHIZWWWu/D36f3UvwIU5OBJMzWVfDr9edy6QxkAXDkdK36/bpmMx/oaoJ0S72J8w5FSXYLJKgR4CQtb3YpZF5uso7E0cg0h+StCBvzin3Xf4lwergou90TH1W483pJQTLUns+SA7xDDP3GGgN+1+tN2eAWKle3zYSyIlXDxoNep4Si4QQdJWbWXEjJD1uIyPFxRtl66x9pv5QsmjUffkgcWvkthrDIgMzaBLdx2voRGbqQk+JiEdaRhiIvqhda7PfcpMvDkqBBVXxLuz5vYdr/Moefbmz2rw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199015)(83380400001)(8936002)(5660300002)(38070700005)(44832011)(38100700002)(36756003)(122000001)(478600001)(107886003)(6666004)(6486002)(2906002)(54906003)(110136005)(6512007)(186003)(26005)(71200400001)(66476007)(64756008)(8676002)(4326008)(66946007)(66556008)(6506007)(91956017)(76116006)(2616005)(41300700001)(66446008)(316002)(86362001)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hk/QqBVGOZC9/Gy2VqtQIldOt9L4j714Ng0Ob08Lysd9Paq3Um8IRzQ7IU?=
 =?iso-8859-1?Q?4APtB+QBQ7i4Hlc+zPXWQzeBDV9JuwQ0zeycSPqcrZJYzehZyCnaF73sE9?=
 =?iso-8859-1?Q?92IGR8t9OhhWLLpunadDn8s3EkbdmHUUrVtE9Qlc7WAFDiJezJfmCQWqZq?=
 =?iso-8859-1?Q?xUVwbEfnGumsLNCRO5tTUZpnfVhWDp6E/2Xh5i3VSxeXhD66+QItBRjgOm?=
 =?iso-8859-1?Q?Rdd09D8ZISJKSp6fGCmdq7HjEZ08ih7UmLqSInc9fYpIl3Y4IqbxcWFfYO?=
 =?iso-8859-1?Q?vdnMzaTiRSH8GTdZuNwXwE3qLVt++2y58/GsJdqTJvJ+lcObZJYs+CpgCo?=
 =?iso-8859-1?Q?Zch9KwoG/hOB/fTfwQzP+dZRZf3as6WbngU0cV5vCRExuQEoml7hj/XxoV?=
 =?iso-8859-1?Q?ZrKSWms5hfFvcriFuPkfg1jbXS0CD5TsDGFrt2pMipMQ/AGA1tj8f26KHv?=
 =?iso-8859-1?Q?7uFaCiT+DZ+DrgwQILsJ1b9fBINBrRL2v/brPvrLa17Lt+hGT+acBSwMl0?=
 =?iso-8859-1?Q?c0EeSYsgoDZyQyyei0iET4MOEcxZPoeSz35CTBK2W/BLthKA9qJjewWdeo?=
 =?iso-8859-1?Q?EDMa51IBtFUQohUbbMY9usAZoPFkjx4hqL1F0l+sMlA6/ifmg251ygfKPp?=
 =?iso-8859-1?Q?HKIRdE0O0b418dEqb65ej2zNiQU7bqwg3/9kXou9nars202KPS0vdbYdFt?=
 =?iso-8859-1?Q?ex3YQa3+gd0u8+ufufhzTKREDjavop9Ueu4hOJQl6ZiTO5K0T4pEOu2UfP?=
 =?iso-8859-1?Q?llze+20IipBiGYu6VYgsyUqKVJUgX6kEbTCBl/7dsyHpICi6JlGiW4mimz?=
 =?iso-8859-1?Q?4zeSQNNXPYpbaSVYV03TYyqsbizfLQfNBSBZEs034+tnnUeAtlMQ/j4E+f?=
 =?iso-8859-1?Q?snTnlOwVT3HTSb5gq/YGWw5vNohc5w42kuEPfoaFLDfMP3Pznyzsa1gmvh?=
 =?iso-8859-1?Q?KDhQHzW7wAkxAl3z9NJRX2i9YSizi+NGzZwd7NsCKDSYpGy0gNq3t+lDbO?=
 =?iso-8859-1?Q?TzkCAeaAOjRo4yQikK7lxTbwtnhWw2rCd9F9jvQekT4m5x0gR2Uli1FIS0?=
 =?iso-8859-1?Q?nfFib5bPoQ4HMUa9Gfin7QxZ+TLzf+YjhR54a28ELftxJU9+E+dZ87V0xV?=
 =?iso-8859-1?Q?TPvl0QWQF0vmRkA0Eh4pq0N3pBOirKhUXo0upAKSXl1DRaOLeuROEWhI4N?=
 =?iso-8859-1?Q?USvnFU9OT08La/Eba0dLOdxKnzZYIVTIWJrvDMR5CZfJ+O1/B9Mr0rs/Bc?=
 =?iso-8859-1?Q?fQmlxd9BqcUl5o+hB2BGmA7fU72TJoz02fSRYKCDBppvnDbP/+ivovXbs/?=
 =?iso-8859-1?Q?qdQLQVL6xzENaoIPSdEjsJPiUlpHadZx4yxqzuSHQdHFsvgyYcKvJB432B?=
 =?iso-8859-1?Q?gRCSdfb2LnV2cz3b6R9iJEQjr57XPQkZh6eKvDQ2KLltsMJof0PKj6M+8F?=
 =?iso-8859-1?Q?jyMsYaf0cHTQUOBsd1KaXoPEdLB0SejeA7ojLQoD2s07FU6zux5V5aWp9M?=
 =?iso-8859-1?Q?9tS8oGZyUNlTVPzQ2nzhMPgu10GrhLQxsZ15Bd7i4bDLDPVq+wZ9sFx6YB?=
 =?iso-8859-1?Q?Wm6mNiZD8e1EIxORiT+sY+0ywF/6P8Z4zUecmFQDg2SpLUCGeybNRbOyCF?=
 =?iso-8859-1?Q?8gH96tNviARBTL4w+huOPGPdOLaFEP5R8EGZOM2e2tENI8RT6tY/ntTw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1xCnvFcvJ5fWz3v/fE8gDhurzhfDgvaibAS84qHZtcgDUA/vQ9Mx/qgTokLf/iIPpVXtnkYUYGPsh7x3vv7Z017iZX5a7QgCntT0wo3q6bKrUQatj7p0xhkGKum32H6neTUzL03Maa1HCYlYb8BPcnGGk/iR1PoctfhyUEPGC8mn8uqdWKecOvfMcn1/yh9WtMjb+LoWwZjxWgYNrM/lJk2JBsqUuo0wbkBata/MLKlosLZMUOEqtoIFXG8e9A66plGgmiPbxgGZw2JmFMJOAG9xMMkWhvEdDjI+uB3/WEhKZIoMF7vKXo4Ru0QGq9+Oaw+fhIhMn+a0iRr16ytqUL1Su9avYAz6/x5XozNQUSCpfZdxnFPku266i/9umOVdz5wY0wAirFf9DoWHRfQhM58N7abIS7ht78iCPC6su+hfs4qodYhFmly8bz9TxGbfWjDCVF6e5W4/PD4x9qG/rStFxWfenn1yVcOK+oNKcPeralhw6xR5NULIIYHTywYz8pLTOMfAH/D1QkZKD9nfhuURYaqbYX9X1qmufNGylVzPe+gxUy/2mU4a7HNuy/yBQuHDI4l6Al5noR+4K9P4D7k++Kck943hs93WkKPGfnmZ9XF26xV0Ke3jssXdpuuc7uH/L06JUWur0pxoOWNqw5g+woS+xxNGyJhQVMX5+uxB76tO2iWrDYuQLGydxQqQz3XEh8vqL69j1fmA5gIRQVaHC5qQlWE8leTR8W1jOlc+rdOBIFRS++SH4R8zxPYim/QEYA+MrY4yNHVIgenpP1SidiO/DGV3u/zvn4u8DktUYmwld0L77mOIQ8Q+I+MQYwUJZuJQMM++CMVpfCig4a6avW933Qa/04LF9e4090cIpXounUcl0PJSuhz+vQP7P1v2vVbYhx7IK1ccQ/YqRQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd052d10-48ef-4b2c-5c5f-08daef51607f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:16:05.1563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XRH+3Q6gtXTY5zd3YJBL5IAMwwx9ZUClohfORGRI4ZoQfTRypxyLbJBwms3CDMO1Mp+cZyPdweMtRJe6WYhppg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4791
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301050152
X-Proofpoint-GUID: INjkCY-trUIadTSNtXuIJ2a8zSpL1GWC
X-Proofpoint-ORIG-GUID: INjkCY-trUIadTSNtXuIJ2a8zSpL1GWC
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

Create a helper for duplicating the anon vma when adjusting the vma.
This simplifies the logic of __vma_adjust().

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 74 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 40 insertions(+), 34 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index dad5c0113380..1e9b8eb00d45 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -679,6 +679,29 @@ static inline void vma_complete(struct vma_prepare *vp=
,
 		uprobe_mmap(vp->insert);
 }
=20
+/*
+ * dup_anon_vma() - Helper function to duplicate anon_vma
+ * @dst: The destination VMA
+ * @src: The source VMA
+ *
+ * Returns: 0 on success.
+ */
+static inline int dup_anon_vma(struct vm_area_struct *dst,
+			       struct vm_area_struct *src)
+{
+	/*
+	 * Easily overlooked: when mprotect shifts the boundary, make sure the
+	 * expanding vma has anon_vma set if the shrinking vma had, to cover any
+	 * anon pages imported.
+	 */
+	if (src->anon_vma && !dst->anon_vma) {
+		dst->anon_vma =3D src->anon_vma;
+		return anon_vma_clone(dst, src);
+	}
+
+	return 0;
+}
+
 /*
  * vma_expand - Expand an existing VMA
  *
@@ -704,15 +727,12 @@ int vma_expand(struct vma_iterator *vmi, struct vm_ar=
ea_struct *vma,
 	struct vma_prepare vp;
=20
 	if (next && (vma !=3D next) && (end =3D=3D next->vm_end)) {
-		remove_next =3D true;
-		if (next->anon_vma && !vma->anon_vma) {
-			int error;
+		int ret;
=20
-			vma->anon_vma =3D next->anon_vma;
-			error =3D anon_vma_clone(vma, next);
-			if (error)
-				return error;
-		}
+		remove_next =3D true;
+		ret =3D dup_anon_vma(vma, next);
+		if (ret)
+			return ret;
 	}
=20
 	init_multi_vma_prep(&vp, vma, NULL, remove_next ? next : NULL, NULL);
@@ -801,10 +821,11 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_=
area_struct *vma,
 	struct file *file =3D vma->vm_file;
 	bool vma_changed =3D false;
 	long adjust_next =3D 0;
-	struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
 	struct vma_prepare vma_prep;
=20
 	if (next) {
+		int error =3D 0;
+
 		if (end >=3D next->vm_end) {
 			/*
 			 * vma expands, overlapping all the next, and
@@ -839,15 +860,14 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_=
area_struct *vma,
 					   end !=3D remove2->vm_end);
 			}
=20
-			exporter =3D next;
-			importer =3D vma;
-
 			/*
 			 * If next doesn't have anon_vma, import from vma after
 			 * next, if the vma overlaps with it.
 			 */
-			if (remove2 !=3D NULL && !next->anon_vma)
-				exporter =3D remove2;
+			if (remove !=3D NULL && !next->anon_vma)
+				error =3D dup_anon_vma(vma, remove2);
+			else
+				error =3D dup_anon_vma(vma, remove);
=20
 		} else if (end > next->vm_start) {
 			/*
@@ -855,9 +875,8 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_ar=
ea_struct *vma,
 			 * mprotect case 5 shifting the boundary up.
 			 */
 			adjust_next =3D (end - next->vm_start);
-			exporter =3D next;
-			importer =3D vma;
-			VM_WARN_ON(expand !=3D importer);
+			VM_WARN_ON(expand !=3D vma);
+			error =3D dup_anon_vma(vma, next);
 		} else if (end < vma->vm_end) {
 			/*
 			 * vma shrinks, and !insert tells it's not
@@ -865,24 +884,11 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_=
area_struct *vma,
 			 * mprotect case 4 shifting the boundary down.
 			 */
 			adjust_next =3D -(vma->vm_end - end);
-			exporter =3D vma;
-			importer =3D next;
-			VM_WARN_ON(expand !=3D importer);
-		}
-
-		/*
-		 * Easily overlooked: when mprotect shifts the boundary,
-		 * make sure the expanding vma has anon_vma set if the
-		 * shrinking vma had, to cover any anon pages imported.
-		 */
-		if (exporter && exporter->anon_vma && !importer->anon_vma) {
-			int error;
-
-			importer->anon_vma =3D exporter->anon_vma;
-			error =3D anon_vma_clone(importer, exporter);
-			if (error)
-				return error;
+			VM_WARN_ON(expand !=3D next);
+			error =3D dup_anon_vma(next, vma);
 		}
+		if (error)
+			return error;
 	}
=20
 	if (vma_iter_prealloc(vmi, vma))
--=20
2.35.1
