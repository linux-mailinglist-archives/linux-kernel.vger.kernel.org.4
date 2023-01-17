Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80AD66D45B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbjAQCf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbjAQCew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:34:52 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7BC298DE
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:34:26 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H09iUV031115;
        Tue, 17 Jan 2023 02:34:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ZOLjRMKcGRah0SkriUEnVf9iJfrlXmxLFviwP1H6bf0=;
 b=L81Z1sss+ulkfhIq8Ux8Fl11r1bGyZGWy3eQzpWVevNXX4i4xIF4PBzONZriupFwttEO
 zzK8cu+TE0dhg+a6Dr3ga5bxZsneXqg4Yfy+zLFZQNlblWRGfoB5CzwyD4uQC3v3SHdl
 mLI+tgBuryHJ/8OPFybAjGs5AZIYYP8dvc66vym4SOPcHNzfxA9Q1JWMmgbgQ+GUN/T6
 pOpV8m2JU/kauB5ZeY0c1CQ0i9Eql5Ss2lS3McDMfWkUf5J+z9GFRX4xbCYVW8B3x0E1
 wCnzAVvSS/jPrciA9W/A7W0VFoAaHQ5QTWcsZtq3MRK9WAd+AkMlpGi4bUnKz5dwXDFy 9w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3mxt3phw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:22 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GNUM0U004833;
        Tue, 17 Jan 2023 02:34:21 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4qyy10f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewmKbytlWy4eONsj1lALgvf2Wltyi70lkDJH3aJMGLNmFRK9I4UHBtalzYsDcWivsbnwJ88x3PeyOsXsGVvah/xh5or3+5Ctq1VG3A0lJT/c68XNbjafTbwJ3NN1EvTE2phR3lFCc2BORE8/iAT2+OmlR0Ed2PRvc9lZlUJoCrLCpZ+ddce4VR2Xbl0mX2LH6AToxYkTq6zyf7dkzev7IcXHxVLcsRDKLKbkApOfp9S4upPqIUrL7LdSs1HUBH48qX6Ih0HJ8XBfkA6919sQfX3R0BFSxxBHxQkq6OIbNMeqXJc9TE4bIPP7xD6KQJ2cytivm1OW8xs6l3MRbQ3Eew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOLjRMKcGRah0SkriUEnVf9iJfrlXmxLFviwP1H6bf0=;
 b=iBOaY/aRxNwbwMSXnPlB67TURhn6jDX8l9VYPrs3DYl8APKNHCRoD3c31ncEbS/9WhKZ7cPUck8oXJNNDtv3wjFnmixm85pz45jF9bOWW7v879NgMrt2OSVG4MbE2LAENcas1oNJ0DThAVSoFbjEQYyqujYQCgoHh90yadATpgCA5VQoLOk4QGSBrOCakC/6/gohQA98m5AglYYXJs6RJWk7FP1/jloktUhthpGxm4TuXizzFdYH3RSMcVB50j0WGRCifycB5Wl5zfqr/8xPuRzmdv242TeHQUh0rK2OaZDS1hJWfKbuNjgsTT4HGipvayBdHPE6qoVkQ099osmHiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOLjRMKcGRah0SkriUEnVf9iJfrlXmxLFviwP1H6bf0=;
 b=xi7EvM8nablE83YSNHVfRHT5ADaxNxmwp9gM8y+AHxmnO+lAPn3742eR2nzisoZscPGhNHIQKstqQc3/9/+/zZb6y7q4bjEhdI6R3R5zT1F36CaCCLoPcGSuVGuCel/CiBD5sssvdmiype0qEDYjsVS7k2ia5SnMRbNbxz3rv14=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO6PR10MB5538.namprd10.prod.outlook.com (2603:10b6:303:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.9; Tue, 17 Jan
 2023 02:34:19 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:34:18 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 20/48] mempolicy: Convert to vma iterator
Thread-Topic: [PATCH v3 20/48] mempolicy: Convert to vma iterator
Thread-Index: AQHZKhwxmv5//sVHREG4W1ontpPDYQ==
Date:   Tue, 17 Jan 2023 02:34:16 +0000
Message-ID: <20230117023335.1690727-21-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CO6PR10MB5538:EE_
x-ms-office365-filtering-correlation-id: 6bd4196e-94d3-4660-a4a0-08daf8335565
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SkUe0vKK1q9hQaw4PyaQ01xEl/f/6QkDKL4R7ICTeSUWvWpy4WCdu2/TVu7BYJGMj0VShMv/fCKXBC8AtKoQHfjBUZ9rkyEwO2snEYJGYy/klDm/SLNmb6Ngk3osAXjUOWzlneCwJDl0ccGY9Yip3YBFG/c8gsfsPV1/eVXI5B6o05TtAQ1onBmU3tlt4SCtRgdQo94TvyQEhb5SFrdXwL0DwlOL4U0vcE2mHsoJJNiAia8ZRXM/5AQuKPbHTFS9uBp2t6u9R1nxtiCl3xGlj+hqMWZh5Vf9kD9SMfSrqqKz+5DZyERNly+49Stfa7u0Ce/kyQlUA9gv4SEJ6w7lL+tZ6lVxe6v6QwlpNog003SfbxldR5/K5S5/vy4ChVJUIgMLqssM4E+yTFdBG7gMgIptyRujptz/zs9xJaw8Cl7d0h12gdXH9IyE4mA6dSXn5oQqtTw4DtuknatvrZTYMldSTp853tAK4pVI9L6YnBjEE4PMTnQrNqmcuKodIRgZiw/FinTxYVnJb8I01GjAk182QwawTsjYKgGrzbeJsys4mjs6cAH2pgi66vy8T7JnA/+m/cgUGeux9VTHfIUef6AaO2a+Xg4iDldowsp+ohWanJE5yLL1jWj4/MbsaEFvnmzOtG49GxoZPxw1k0Lh9jxDwel84o0oo5UOTM/NPgXFQWIcGimDYAQyARGKecn6xPu0GwgG6HfR0UeJ3ZhQIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199015)(36756003)(91956017)(86362001)(8676002)(6512007)(64756008)(4326008)(186003)(76116006)(66946007)(66556008)(41300700001)(2616005)(66446008)(26005)(66476007)(316002)(71200400001)(478600001)(38070700005)(6506007)(54906003)(110136005)(107886003)(6486002)(44832011)(122000001)(38100700002)(2906002)(5660300002)(83380400001)(8936002)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Q/dbcQ2DO26m7pAVM0bYfCmaNPaH5nUN5/B7GGtikuqZ3q/eseF2M9YL06?=
 =?iso-8859-1?Q?fxq9MGojAuDEHSo1TGuvvBIdf6TH6GfqXJZS7BDuoi94YbtPQNjFdTxic6?=
 =?iso-8859-1?Q?R+rsV4KKRL+pcoykwFe+JCKavyDz3l+v9Nl0AIpEWmReyPS3otr0KSkuZH?=
 =?iso-8859-1?Q?wIHxoDlxxO/I6ZKcp5cD9Mc7EWUYBX82UYkHNVoe2QiWQ9oh6PjrEo7gIf?=
 =?iso-8859-1?Q?9MFETs+2V2WOJXrmhI/G8d+nZ+vcBQf6i3+eLFDxfh7PfJFk9lNayndzES?=
 =?iso-8859-1?Q?tVExvdQowgotAtL2Ylzz8cWIAiqxZaSw+yQ1ydYU/VCpI716yg4V4FoO++?=
 =?iso-8859-1?Q?iw6p+wjCXwbdHYhN8Xup5m5kZXAq51kiKhv9Tg5zZ7F0keiI1VOtJbfVzk?=
 =?iso-8859-1?Q?/El4eilk3iroi62i/L/ycxqnEZ9noL5MGDzeFhD/f6oxG/v2m1JmMz1q47?=
 =?iso-8859-1?Q?DLvRsmxmUDtTjFUxN5rm2t/0amRcWfMW+gVJzeOAM14CYXfmu6A36JzLdr?=
 =?iso-8859-1?Q?u+cVQ/VmTsCP2Nx5jhb3rYiv41DCECIZR6eMQx7UdSbRUdCKUv8wWHKNGP?=
 =?iso-8859-1?Q?u8QKSRpLdcCc07Cxw6ALnRnPZUFPTvO3Zxl4JTLBU7ZTymLegU3DK4mHTj?=
 =?iso-8859-1?Q?v9mfWX6uUwcqnM2KrSWfw5qYfLMu3vJYl7OfF0MpI73Se//B/vDIvXPVUH?=
 =?iso-8859-1?Q?p9PlZmiL6b2jcQXeWK3Eym2DalC7dCDof1riAzll7+eqR6MkHg8ZWneh7V?=
 =?iso-8859-1?Q?fBEiBN6ITfMHmiLzYKkvxbBeNUa6nDliX+pit9InSozpcJo3/XPUF+XGPi?=
 =?iso-8859-1?Q?E4tkA1IvwJ/oYtUjXUQaBs9XcMzo3TpPSCUCct8Zgt17kag7/x3Pn5vr7r?=
 =?iso-8859-1?Q?HH3L72U+r3e39qn/Ljdy/lVbUxZHgxiSFeNx4UNJhD2EeAo9CP5PkjMLCn?=
 =?iso-8859-1?Q?MJWGm1uFTPnWxtKKPzU4+ca0AICVCTGo9mxC/tp2XH2hwhNJeZfuQ8P/Bp?=
 =?iso-8859-1?Q?saLMJ68fU/oJV0ioxBfxof/5T9G9gaUWTBmmuvLFsRDct0ZiqvFmOvkIT/?=
 =?iso-8859-1?Q?04Kyk3SDohRX4BrVBf3mkAtbEp8GTA+0bFHmqrPeSeoHpgV2a/NClVSUyy?=
 =?iso-8859-1?Q?F2c3B9WPC54lJgi5flTloAqjC+OhyYdPO+XJvwktBfyUTLqJ5DgdGfdgpd?=
 =?iso-8859-1?Q?qk87IGn7PVAWWsakBRL2pYjOQSNcRaZronat6ngJL4yk3vcF97kEacJK2c?=
 =?iso-8859-1?Q?uTKAtnySq+Rrf06HWXm5w8W8lY9gFksOkzKzFIH7/EXv1P05eIjBSeaBjf?=
 =?iso-8859-1?Q?S99eOmJWlLFmFnBhi2XpYFYbEbnaUGDsgCcnkxj2118JtveCzu098M93i7?=
 =?iso-8859-1?Q?LAovdzz7NYgE1PK6j5LCk3M0hLCmHo/vikD18VMhOthfFtbrcEiPh23dce?=
 =?iso-8859-1?Q?mGpFJX72sVp3a1tzueZO1dmmbcETL6ekJ200C+QkA7/Xkecz9ZJQLU4pkY?=
 =?iso-8859-1?Q?UJJT3cQ/rkD8L5olAhSbhYq9Zwp65SPquc9om+/lplldomRJnyizL7Unsy?=
 =?iso-8859-1?Q?X5Svd6sa+1AUblExKweMMqPbb9sfYFYFFyO9yRE+5ryZ2Om0ls2Xinaj8K?=
 =?iso-8859-1?Q?HDPOqkjLW4i9XX92Hx2yRiHttJSu6USniNkQB2jIV2nYJ8NQB7W7Aw/g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XFWIhPx1fTqiwrz89cDyDJuF4MRoxSBehsTDfqtEkkWj4GiW4oJD3jZWmBUToGBt2t2E3I2TkHtBtq6vQPA4ueIBmkkgOGDMaAzrC4nQIRxCQ5OsRfC9EELSkfVJmrjJ5tu42Zz1c4L6+0eTkwItZgjrqlB1LJaF215XAXQ/Ytc/M1kfs00vN8Sw3I8BpisyAJa4m9sv1edC+rmCJTLDtWOHoxgsncbBeesNEnbrLxp5kfrnKyQ2QorxULnbpqwMauT5qOaX5dKtmvXQ65bV8N5IJDedXbk2AuKyneYrDJv6lNNudInZixmEuD+Xj7HtY5/Nlb9tDFi0jeBvJuLjkEN5oofT0Z5sGnZgSHP5aI1cWxJEU+lFVjOa7cKuvYVtqR+qo10b8Y0/a/b3ej/ojFV2tyZ2CrxlXkxrSVTn+Bs0AyXd4zlb2Ys0dnAKpMUYxr1hCCxRkaSBreJK8L0fP9x8o3gZzQMX7ltLh3h2eK+L8LwplYJtPWR7Vy1+7UmBPsMG+bMBJge8E1HnASMeE+6BUTIGLoTGGdYLojZWaF5Yi4K/KCJasQHuGmojLOcesi6mKf3mrhdCdJN6hQoZKQ2k8OozBeZyxnvOTcrzvDcRoxe7qkGR/HH/YdVdkO59522ywHMeiGKOo1gJPDqaYBoTq71GTRaGGJsRpouabx0at7GCNRqDATkMdSO+4pij7iUFRNM4v1e0hcjjJDue1eMEtSviqoQ+31VVhX881sAKRHZ4YmdlTj6rDG6ovhPeuJf6XRtDYxFiwhsrDdXbghJs9OsXFZ9o4/HJcm/5YmY2DA1FQOJO0HNUHTfm6mqBROaRSmdl5V5oIDOLif6OOsUj2f9B6bt9eS14Mq0asQliXDoQQoVMilOvfUn+5u8Nvy+Os8zG1I0xyInZ8hmxaA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd4196e-94d3-4660-a4a0-08daf8335565
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:16.6405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IQzMRIyJGAx9hEZN5Tm0zHGCqJSXRH25GQBGvZrxED8P/d2zDO1EVamILywVT6djJv7j5237rmBBtjb4sSIgKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5538
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170017
X-Proofpoint-GUID: t1iGQOv73cphk7fozzEhNfg_EGTHkaj_
X-Proofpoint-ORIG-GUID: t1iGQOv73cphk7fozzEhNfg_EGTHkaj_
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
