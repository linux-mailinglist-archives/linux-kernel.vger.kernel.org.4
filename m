Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0171A63C58B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbiK2Qrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236315AbiK2QrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:47:07 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF616C72A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:45:16 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGOf8w005619;
        Tue, 29 Nov 2022 16:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=6+stm1aUBeIdjSmqEZqbrP2RxWcWKKZx6ArgspYqK/U=;
 b=BTaN4uumeQNWIEGiv7s9O+FMCydW/a4mykUWmUrr+mbMF//goYHfU0D91gE2cz/Mn2DX
 eOuuN7l25t1xwoEXUD60o25APz8rJedg04BL/GD1H2/NqMgF1zOv7kZl3+U+4SZs9Go7
 jjBgy8IARjSGDQ8BTC21SHV3UDPCfUf3ZIP6nLEd6iWmCpeaBkcrUgfDQ5a8jvS6dNwB
 kdwv/Bwp4g0YY18VBIAXprzKeWqlp4RKTWt1e5L+Q1yvQGh/tabC5c0a8t6n0OLTwZoZ
 NhSk/sIPZl2HRY11YvZcN5CbuAsW77oJQknKY5Z/j7twGRsCqHVKdMTNN3loDZB7DGcW cw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m39k2qfcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:45:11 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATFkaU2026698;
        Tue, 29 Nov 2022 16:45:11 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m3c1vkkp0-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:45:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJXD7HWtJCSW3qvey5mDdi55dJERLrmjSqtVNcsdJN45ZU3sTcLR21B+kl60Vh0ezZfD8f/+dVOMYLMKjNIuviLhOKYdJUqfvRm7FyOOFmILpB2XSltghMhduaPLGDsGFWM7aaNi6dxVjOzPGtY6bRSWfyJqNjJ2XkwW1NJkVLkp+Xk0Wk0j7iJ/W6c+iVBq79WxqIcH8hNdq0wqvViDfF86Yh5PQFs6Exp5jp4bgMcMcncre+px+p4+jTyVBHbX74KwrFAEWk3POvPpvzBmQd9ZOcCFbUzxze/EKp1jYU0LvuRdyaO4V9SfcxC5DFoDImQFyl/168EXQKWjiv5Lnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+stm1aUBeIdjSmqEZqbrP2RxWcWKKZx6ArgspYqK/U=;
 b=C5Fjc52cyH+OJPhiYEBc89QFwGdt5HKXADGwKfWshcrQTtdrEIOv28L+ZkY0kUO3uaMyvm+cCSxVukMOgX+SYmW7cDaH2oZe7VoKhe4R50Jzx4IRFazby/QAVT+q/cdow7DS0ML1W4LUZG199u/wZb3+wQnuAmTT5ybQA17VhdPLwluPxi/8IZF7CDZAOJi3W9E1dq8sIm3lkjMLbR09363NllaoRUkP9ONxw/9LQU+GUdH+ja6rkl9MJ1Po4Ep83JSxHRfpPWbU91r8g64/jnzcBTQsZIVARQfFEsXXm+LAjfNo2s+ktuBgNq0g0q9Poku5+oG1UdV02xGe6X6QdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+stm1aUBeIdjSmqEZqbrP2RxWcWKKZx6ArgspYqK/U=;
 b=bMFB2VcaupwFcPFhNkW+ng3gu2Dy1G1irkeZaAAgdlOMxf/8XwLTcP6VYeUBvMSvDVFiVfz6xXad0DGm1o9hzFbp7EMLRIKs13CEiN53hDkes0lVtRrM+9lLAcPiEqDe7Vcwr7cUarDonBmx2kOva+9FpqknqOPzUvYmmfYyvrs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4792.namprd10.prod.outlook.com (2603:10b6:510:3d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 16:45:09 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:45:08 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 34/43] mm/mmap: move anon_vma setting in __vma_adjust()
Thread-Topic: [PATCH 34/43] mm/mmap: move anon_vma setting in __vma_adjust()
Thread-Index: AQHZBBHcT7O6YMI3JEK/tAVcMet8vA==
Date:   Tue, 29 Nov 2022 16:44:35 +0000
Message-ID: <20221129164352.3374638-35-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|PH0PR10MB4792:EE_
x-ms-office365-filtering-correlation-id: 73cc6c0e-4104-4622-9d91-08dad2291383
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6G1+ohNU+VLrTNxlg71pwhSofUGpsAsT9cRheA7ck0bcBaFc+fCaF0z1SczrmzVY5wzFwVcFmoQC3JHb+jm0oH6+2AdEcn4aFpNKxvB93dQVLrNJaxyUHRro7qJS7Q1H0/kqz6sNpCquHN05Zx5xBXnC41jtNRBxsTzw6arHBqRouHKozzBKfWm4DwiRq4/iUUViI5jmUFHVDLDByOQaBRF4X5dkDxKJhes2kjMMjnUt2TXinZlip5cAysWq4ME5LwhfZLsXXJ5lA//Y2mPt2ancz93T8UN2zhzvJUWGvMIC1NLloG8YJ/o9kpkOHfR+xf+7uVulgHNf7RlNAtmtwpMLtzbA1orzgCe/UaXop4E/ImgOCkHzkT+Rt/lqcMWA7csDv2y9HaaUGmuasIj18Dj1rTywpCEVR4JYwLrHnzGpZiscqslyJh6QkU5y31QfpF8bqfsKMXPg+znxfrwwal/xSC4+GjhoCe29FpI+YVtd8+EQ/t5qZv8OWCF1QcZqL4XcgN6ZsXs7EKa1a4v7TdpsPgJ3eeMbgG17SXcpuO5I8ZSEj4om/Iqvm4Sy1UJwlS9a5BfmRhA3ASneu6fCGhGg6CZztuvo2UaiHIVDThCfo34NPB8TRg9hnHKv2ICsrhWWGPRkVl6k4MSUDy4wMcUvJsF4SMyCmlob0mfTZ0rRBFFtJT8wSwNWGLMjKVSC7DlKzfQ8sWZb2hjjyax80Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199015)(38070700005)(2906002)(36756003)(86362001)(6666004)(6486002)(71200400001)(107886003)(478600001)(44832011)(41300700001)(316002)(76116006)(66556008)(66946007)(91956017)(5660300002)(66476007)(26005)(110136005)(66446008)(4326008)(54906003)(8936002)(8676002)(64756008)(6506007)(6512007)(186003)(122000001)(2616005)(38100700002)(1076003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5WCOpbUQ8g1RwMyT7lBbaY6bABu9AOzchGNc/l7+Gx/RCKqPqMRnhwFFX4?=
 =?iso-8859-1?Q?L4TnX7mEw5m0KUPTYW4mp5AdOdnRfD/pv34yB0pE1MQevmxb+CDGWJ9btG?=
 =?iso-8859-1?Q?liJopo14ZMuu47dB3gqBtsraD4liKCY3tuzZPiJUatzL5jyPWiwY9qpFGx?=
 =?iso-8859-1?Q?isl/L+fQmctHmbNTsSM1EnHjpUHTNtwCpP6+jvpLz3LGk2LEIgr0UcalGB?=
 =?iso-8859-1?Q?dgnWjm0gDiNmpPUUKVaBH4GJkmRt9L8F8+ScaCmOWTKsjPiwVV4XbSZXT3?=
 =?iso-8859-1?Q?7vzTqLWGoC9IncOnD19bQPcmwkfCNyKAKiovxSCwjRPZy98Wd4B+uW/pBa?=
 =?iso-8859-1?Q?0IgHfY91xhLN9vtSIefrwazFw0fj2sgePctA1wI0eSVwPvhpLRyQmT0Yin?=
 =?iso-8859-1?Q?waBDiVPCt+DQzCSXn8vxGlv87WWnXgVaYcEKeLtYZyUkedkzd3ALPEHdYN?=
 =?iso-8859-1?Q?ikX/WTtBQdrwiaHOgwd5sO8k8pmKR2kxRxxTbotGzFzm/+R0vIXTrIXPKY?=
 =?iso-8859-1?Q?sdo3Yc4D9LQlGr3SeLpQNHXHaC10QVWTah+Y/MDULADDYALJaZ4lEy7ScZ?=
 =?iso-8859-1?Q?Qq3b0+04rTAo2rPj9t0C194RMRXfAOMJBc1Mpx2z9EsV9jgias4VCVMOnY?=
 =?iso-8859-1?Q?tiflmxs7zrCt3VZsq2cmjhRoyyjzk1/p7AgJ/SFuxvcTlnUsMspbOWV8bq?=
 =?iso-8859-1?Q?8uz7FTvC0py91+pk5prL3e0ysIFgwlkGZ603KfArIf0WdtRr+E8JLEZ00f?=
 =?iso-8859-1?Q?pw6mbc5ZKvO4K4jfz3azZVcWdPtKZj/QEFIZAiFGKcnzeGTug5HHHB8MPy?=
 =?iso-8859-1?Q?R1jdOORdBDrh9+4m9QT1O0+S4cVYqfyZdUsShw5cZjcKm14anEfdKGf5/T?=
 =?iso-8859-1?Q?baVdvgPXiSv1bM0MhCCzdq5AfGjaL6FepYtdPlaPSNCK+0nzWcqCupwb7H?=
 =?iso-8859-1?Q?8+RvKnWK9AZTOddUbUmPFKcahYS6doM0mM6TgmllYshtinZ+yvUOxSI3XT?=
 =?iso-8859-1?Q?CSyoGzu3cqPgG1v/QUVsT4nMZPe4R7QbmFhbqZ+uMobnOpreTyRqaPSe1Q?=
 =?iso-8859-1?Q?YodyG92ivl5KAee8eIVON83kDHPsYL/3hu0oQKIaCaP/YSbGQjuDLmAp41?=
 =?iso-8859-1?Q?kvsibnHKOZLgpADkN7rkV4byrPBBYojl7Y58aXLM/lF9j5dmyfKaOWvtYE?=
 =?iso-8859-1?Q?VV59DBubY0thGJiTY1A9FFNz7QPzK9oqryvciapIMnNGXLex5e28IFJBcz?=
 =?iso-8859-1?Q?rf+Q14yuThq7C45aoQyJNvFE8wHc7aG+gdQY+/mV5GPxKesX3nsjs/Yyj/?=
 =?iso-8859-1?Q?zpBWtOtfwKte1P+MqsL6xIbX1hYGoLCeKTXEUJa3LDbvutlZymdCn3oVIS?=
 =?iso-8859-1?Q?FtNtG6eXYWw5ayBdEHkS5P3o3PogOqVBzFBfcJL3lOuoX2+QIQfaDnkcPX?=
 =?iso-8859-1?Q?MVdO/m+XOlL2EErhNIyUrnA2hQS9dsbikA3qDUNgOmrqNlZs+JQoJytC4t?=
 =?iso-8859-1?Q?7h0WCqxWtl6kkhdx+X9KZcUBObEoAl5EjTNtgT51zzDrlHB5jGTwNHfjOX?=
 =?iso-8859-1?Q?mHXVCWHGVoeDWgj8Evqo38ir/A4jgYo5+nSuA0cXxQ4Q0JvIbDOxrF2mBh?=
 =?iso-8859-1?Q?oKAmRPdz3EkuegE3vXZETnb5Y0Oce6zu+WJXemv2zpWFqjEiLCES59zA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nM5zw/jO3d11l+ojECGrO5rWUQvxXsG03UGaLjUn9ta/X9yRFY6RLMLq0Z58TLBOk4FYqEd3l81FEgC6KJIR7TqF9oDpQkfOTD/KKx4Jw62uERLBRRDeB1/EXjmUD8vw76nFkZiKXzQe/QjelAfatxDJ831QGDCxkvtQixjnxwBrAB4RPujHk0rCEfAEXeqZx0vo4Hilu9T8qsn2nvTqh5TEzDbgIMIg9F6j8eAhsT325DOTvyT5/+w3X5uCaSzx+GGUX4NrohC4B0bzXxequaM/mcQZ53O/UhcFm8jUevAJKS8T26wNHETsmWHEIjdS89VxfszxQsJA6boQ3XFtltbfYmXD8K/XELTX4MM+iu6oKT5QIBfC2GHYR6c14HTCaFmUeiugYO6Qzk1FC3a5gSofh2Q2uQSf7DWCUt3vnyKhk4vxZ0Dx27ZsvH/E+cffrmmZR/0He0BkURh1+DvEXPc3wANEwnBNy/Ra1u4OKouoLOF93udINJerQ3QNmCm/7dFxNlYrfRPqbb4YqzeBpedYJF0hCjhc0ik9fUMnlc1eTSNmaHJmg1ucAsMRsSKCiLrbh+nLqIjvH9ClPQT5f2cXmBrd7nLbx+hYKUDJY4LfEae1+S8hV8IDVX4OarutNWHhpqcX/TUYPMO/CA0i8tT8ewwj3A6irnS5JKW5aKi/ky74wpAqyl98W6EsQWj/YkVTayxHetqeeHwsxZpR+tah6c/CWA5xol5Vboy8JkjM58RED/J7QQvcAFBL4bcS87piEGXaIapDsvuFacK4PEeA315f5o9T9xRbmvIH8oBDPyIudS82fSGcGzKmVRieVf28I1JbuJJvXWquOa5yCfVrw/sZFfFNf0QYVXE2F7KqNhbL8GZfDiy5fbvXYCs5j1SDtZoqgRgmuVv+KxXkzg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73cc6c0e-4104-4622-9d91-08dad2291383
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:35.1441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zNQkodUNGT9js6E9rY+aXOBIWCPVN7bMzuD42K7oeQ07k/IdiMGwFLvQlZ4i4OOZnZJ3y/AY9W1U7y7cnV0REw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4792
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290093
X-Proofpoint-GUID: zqcZMA4-gAMR9rgLwanJlpLlgQWTNSSG
X-Proofpoint-ORIG-GUID: zqcZMA4-gAMR9rgLwanJlpLlgQWTNSSG
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

Move the anon_vma setting & warn_no up the function.  This is done to
clear up the locking later.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index e0e70b9bc391..5b5d5d856152 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -742,6 +742,14 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_a=
rea_struct *vma,
 	if (vma_iter_prealloc(vmi, vma))
 		return -ENOMEM;
=20
+	anon_vma =3D vma->anon_vma;
+	if (!anon_vma && adjust_next)
+		anon_vma =3D next->anon_vma;
+
+	if (anon_vma)
+		VM_WARN_ON(adjust_next && next->anon_vma &&
+			   anon_vma !=3D next->anon_vma);
+
 	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
 	if (file) {
 		mapping =3D file->f_mapping;
@@ -763,12 +771,7 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_a=
rea_struct *vma,
 		}
 	}
=20
-	anon_vma =3D vma->anon_vma;
-	if (!anon_vma && adjust_next)
-		anon_vma =3D next->anon_vma;
 	if (anon_vma) {
-		VM_WARN_ON(adjust_next && next->anon_vma &&
-			   anon_vma !=3D next->anon_vma);
 		anon_vma_lock_write(anon_vma);
 		anon_vma_interval_tree_pre_update_vma(vma);
 		if (adjust_next)
--=20
2.35.1
