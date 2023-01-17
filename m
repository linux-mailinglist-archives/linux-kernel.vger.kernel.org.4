Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3529F66D458
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbjAQCfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235356AbjAQCe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:34:26 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E6E24490
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:34:25 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H09Urg005545;
        Tue, 17 Jan 2023 02:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=GRWePbNI4yMLl+8pCfpa5/+3hmk4mix7DdpU5vArRK8=;
 b=HJK73VUuvwSBoT71JG9uPEwcxD+vBs8QxfIhAp6UzS5JkXYvSvXkb9f362uCoZQlWbaC
 uSm7oHalbHRI9PelAb2m37+HjMNr/U7aTOfi9wmzW0yUKkO2jBKqWy1dxdI+YLUzpwqC
 xQO/ax0QrnSgyHdX+4Kz7AgOmaxSA+oyyxPULWFiqProW/RTGc7WCdlkyETkag7A44+/
 4lQpo9LtHCd87kZRMb4XgfcK+wYXQ3+Qgc2tYXY/zzAIDqiijyx1pwatF+egNb41aODg
 S2h5Hc8BWQLHEW92V8gz2fF/8FXRQOwQCOCrxPExRHIwAalADfLhRiSBccV8br1WK8Cw dg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n40mdb5e5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:18 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GMM4rg028480;
        Tue, 17 Jan 2023 02:34:16 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4s2rfxkx-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVsFWwN8Zns9WpGwHmFZxtiKO+a0RoOuq4bCsgUHrt0PpK+Z+EVz6CH27um6mp8uhTI1i2zjXEdo3XVjpY79WHb2xJRDpsP4bsZkunsh07SSC23EKSZtEVtGEVr+AEkXR0li7T9MsLNw9d+vCkfuEhVSb0DsODRbOIQ+fi+st1oZ4Vc5uhGOyn1sSJsfZcstZkjt9VH4PPRsx1DcSWtbh2izc3yUypgg0KYdAyQEHMaKvqFise2itHiI2MunheUKWCLihTght2HHyk8vs7WsioEg7zYFnnDzhBAQ+FcA6kjOye7GJSeZj1wcl4jySat80vCVpl2TsRg3ruix3iJKJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRWePbNI4yMLl+8pCfpa5/+3hmk4mix7DdpU5vArRK8=;
 b=iFxk+viXEYFxfDxFGsMkQl0TYN3zufWA201MRMcpeSrMcaVQHD30iMSchjOhwwrzX9mXEnIwRFwN0BTPZnXofBeMhEFPtkGfONhNCjVkjxcAM+nhO/gZ8hNUr9qfMc3GTigmlmkuKctqdi02tWMCxMsFzKj430zIiTUWRxsTlc8zahYIASEpXBioQiKzuPmPxQfAULlEFGFX2DtMpBgVstObUZLZqrAYimg1pm6SJDASb4J4YTcANwQd86KCviaRd/1cWtvFvnCYvEjTBHNGV5TWdChmhZFg9drw33nzm+6LU0bqKeuxm0AP53viDLR84EcE+IHRc7b/FeLM4zFVKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRWePbNI4yMLl+8pCfpa5/+3hmk4mix7DdpU5vArRK8=;
 b=gxGg3RHJqS10lRV8UqAXn/LHgvv7kPahTsge9AJOlp+EL20r/bp90Fa7+cHTpgUe5rDqeC1hp9AA4iNaGMxRSxtkl+OlxSl/mx8YIlDDOphJjoj7XL0vPuy35l/FUgjngTDiseCf4e0F/7cpie+kCr9cAdwAcIG2eXNI1wxKdHg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5356.namprd10.prod.outlook.com (2603:10b6:610:c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 02:34:14 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:34:14 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 10/48] mmap: Convert vma_link() vma iterator
Thread-Topic: [PATCH v3 10/48] mmap: Convert vma_link() vma iterator
Thread-Index: AQHZKhwvnvB3Qi1ye0Sk/QnMyt6tuA==
Date:   Tue, 17 Jan 2023 02:34:13 +0000
Message-ID: <20230117023335.1690727-11-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CH0PR10MB5356:EE_
x-ms-office365-filtering-correlation-id: 8fdf9bb9-a47c-4669-46b1-08daf83352b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jEB35gSK7m4W55PDtJpgAQF1KEetVU3gj3IybjN8+MRr9bIav9ZMd0LGwZcGg2JWzoXeiwXNZLygr4guOwodmh6p3pAYJZzzz+suP4BP+mxRAM2L3BZTF5wEaPryneRZ2Vw/FnbkFA+B94BPud+KPDNdhieoAyA6GBzTB3m5JDs0cn58+6A35L2wDxwtMxaamk00YKnlUi98Z+H/UTys0qraTLyEG2mPqYHw+4UCcesJ/Nl7T8I6qVZjJWpuGpeIKG8ZJER/2p3gAFG1lLk+DXERa5h6OY4Qej3cAHWnnWfZzUu6+IT8xA33BdxZIjV0IqvDOYuJujKDiHDRQJHVSrUz2DG7OaGoLN76v8BCqtSM9XjvbsutIDxRHpjBxQIyy1XwQklX2EaXioEuEQ/+YF/RP/W9moBDVIdfSh3m0afr+VdD9/EKn2cTuR+7XeBbga/zppF9uJC5QU5JDRBj1jHozPPykM7aNmMiCNFOjc+bjDdNomOe/WOmj+AxZy8SGtwmShfnic4/2MSjsAQzcNzmkHmKKvWhPYoYBqJGjrOuiIukF9H6p/ceJuPl0IwTjvc0zBgD0BxohB+Ha5h15ofS8K7b6yQMXsgF7a2rBQxIcE6dTTgKVUj7w6JRa4mdby+jiQinTCo1dOLl6IExm1eJU19n/3F6dfLAG2b+dta9MjqNykfVV98O6sUTNsvna1CbqIo1rkYigJ579DDSoQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199015)(36756003)(38070700005)(5660300002)(8676002)(44832011)(8936002)(4326008)(76116006)(66946007)(64756008)(66556008)(66476007)(66446008)(4744005)(2906002)(83380400001)(38100700002)(122000001)(478600001)(54906003)(71200400001)(316002)(107886003)(110136005)(6486002)(86362001)(1076003)(41300700001)(91956017)(2616005)(6512007)(186003)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?j3TJmm8Ztr90Vv6Ff4Yewnao1oTD/xwjT1OAY1sRtT4iVCcC3SdBdjogch?=
 =?iso-8859-1?Q?sSKfWC45HQ8ZiHU3IejKDyV8RDuP74G/qeKyFsMdKknG2U2/gb3CX9lstZ?=
 =?iso-8859-1?Q?HLvGQz0exqXQkPJUSNvcb0dPhvEU+ieDS5i9Uc9DF206FytMwyLbm8izWh?=
 =?iso-8859-1?Q?tvL/2nTLBuMjpt2nvfcrz4arZtcGaaOJOzpMaEGqcjPbgD+G3i+ihrnuBa?=
 =?iso-8859-1?Q?xsvmaLTiVHuyaArTWkDmMT61NAAJqzksa7+U5BIONk3VPm0I0lr4phZa1X?=
 =?iso-8859-1?Q?WhrAr1AbuDCts14ECM4ZCHPborwOcKoGx27zThNtPTZh7OtYX45/Wz6mhy?=
 =?iso-8859-1?Q?MMvU6MvHdsV3RXe3wY7LZMdPtBEI5a3DcZCY+lWMxIZjUB9B2GcWsbrasG?=
 =?iso-8859-1?Q?PuAcoryf3c0bjb3yFvPhzhzdyiJfvPGX3ud0YYN58OgnYsI1C+GGUySlg9?=
 =?iso-8859-1?Q?y8dEiaGpoY8rywalXmN79prMpufT7i4A/BBAUBbNEqYtW512rcZhoRQeme?=
 =?iso-8859-1?Q?+9S5KEu/wv1/C+6w1GPB7RcoYlFMBwwc9BtI47dSNkkOwULulQ50NycbEP?=
 =?iso-8859-1?Q?CKjkLZ0FEyXfVid9vS9z6YedfngYDCgns7N6EHa59d5FQ3RZnAwP2B1OIz?=
 =?iso-8859-1?Q?X75F9HyT9jOBSPWEkFa0bO5QEVl5rG/Li30izw4mfsJkXu/uCFY1HPk95r?=
 =?iso-8859-1?Q?u/TZrqS6xrrWO4FX5Tuo7U2V5g6HiyBO+ipXta1wDv5J7haciKqUjU3Iie?=
 =?iso-8859-1?Q?1LBFHhfzwz/LrAlItjDIoGT6JfC8lluCGqRKR6MGaYCaLIahUVUAFgWUwR?=
 =?iso-8859-1?Q?8hWS5B+NS6lbePrdjyGp9yTYrlNrGiZ6dRseoY6bEqCpTLeS6EjUYcDifS?=
 =?iso-8859-1?Q?1nJi9dg1AebKOIOO70IQcXjrvU3lRzwpAejPdu2bmwmejA6O8PyL7IRzhq?=
 =?iso-8859-1?Q?6gpNdoGd6kYlu3QgIfsC71aDjLyvo1CifW/80NRhwdqoO7sXHRGEreuH1R?=
 =?iso-8859-1?Q?ZjQQxlDYWumMzvd6DVS3/5nXWx7hc53JsgBpw4mfpvZrGV/OMRS480VvAI?=
 =?iso-8859-1?Q?o3DFYB//MunxLymybH1Q+XIUY9LFnBAhYrO9BrcfCNNnskJvReBGsEBDgT?=
 =?iso-8859-1?Q?003hWXkYjtJA9qME5Xe+uKz1nR2K+/icuPWVEBDRgXN/+Ni8sqqUnp/RWD?=
 =?iso-8859-1?Q?OD7uMifZGYzLjA04oPklMIvmNeMtmK1qcxJSveLGZXBmhWbLG8CTXG5LVx?=
 =?iso-8859-1?Q?WMi2C0tvlUkDi7iFV3Eo2Hxb1m4BhgTW/TU9U1sJB4AFrK/fBV+VKWSxaG?=
 =?iso-8859-1?Q?1bRJNXNnCzXpPybpHoP6sRw3PpG+Mx/WuzVXsc6VMRyWttoM6KBuofbPSP?=
 =?iso-8859-1?Q?J9TL5Bs+PM9KIPgz6fXmeF70NMyDOoyRi4+SDBig9muYCew1CEgm5Ae7zt?=
 =?iso-8859-1?Q?HA+S1sc8RFnM6mgZtGxP4kZNZxyAh1tFhZv4u/nnr/KuXahiCmac8QpS+K?=
 =?iso-8859-1?Q?atteSNYHAKn361Np1sQU+TiaidgJEzyMnAV8w7X1UY8LIYJQjSSwqkOP7R?=
 =?iso-8859-1?Q?TEI0X9VDlkMO/bvOJAbhMVWknYOBuliY70cSJ/Chw+FAZks7WhUNjLj4tO?=
 =?iso-8859-1?Q?WWKy3TEpQzzIWNMXrWsJRQqWnDyE0hu18r2319yhO0xrcmvm0oZT/68g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: huCFyngmivGGgN7qIyg/5wuJjnKMLVsUPIKr/U/2+FDS2+1h/jTDLvdMc2nb6uFR7iEJpUgXlRoE3PGLagBYdQ3kJGwcYGsM0gWMaKAVR5Bo8uD23PJ5l3JfyVHUFbKxvNltZxaDp1E3Ov4dXxIz//WSuTUdb8LyWqXEyr3P/CgEjLigStQrL5GluniF+SGuOru/UUeCafVyHCQyf60OS0TGWCP4O+wMJQRjLZjPbsoLPHvaPE0v2+rKovSKeJbf0Vq8/lk2JcWksva/0M/ue+lESVZ2oeOVqsAzbbtqUIJx2FgloE19H7GvN9cpQfklj9eI1c4hWyJVlpKABq/LwX+T/c3h5xrEU5Pi75Jw/E1o594QKTBYowA3GHjSHTgkVPrDLerEf53Lmd5p6H5vqmj/sLLtR1tnAYYRwTGDMKwnC9TOE6beAJzTtr20GFtwOV0BQ/jfrKsugwqGnxxBPNsI3t5aPGK6NMpZj59o7K5/UXndkOeiuvTr9jB+knrFiJVMrnUxTKQlbj8H4qA0rJIgOLF0oM1rfbzCnEooatcGKp9nSxEn3VLg3jTjtO0nCIErwalUOgKgrDMXLJDhFT/HzGVYJXvxn8ycxDzU9B2gvEylMXh0oNKYdD98TzQ40GzEyHU+bn+K05GJw254Z+TGruHVtEs/3tWuKx29yo9d29i4hcKNBoD3r3zyieybUERUIyd17inBoDS0EWikgqKEzXph8IvcHfHkced3mJw2mLtUZeH5c6wPGYkU2e6WWMzSuXNKuAA74DrNcpJFqSijwpJEqJzfGLy8jnmVhy6oRXq0BwxCPhDGeS+ZAXwK4YcDoiLJvo2AaaI3v62wF8u3+wKWUydFOveoyFVkY1daNT2TLKcpjxr/aGCpC2RBgwai3ceaO1esLVJrrn1oNQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fdf9bb9-a47c-4669-46b1-08daf83352b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:13.0782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AP1SPaiOpr+P9FjyCj8GnlN8Ix/yTqKgZ9YNoMdMB2aIOZeNuPJNHCeo4+iJg/kbuGq6SYiDmLKHe6tLOjAEiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5356
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170017
X-Proofpoint-ORIG-GUID: AAnTNXotSLvKjuxbdyd-qG0JWCnmQtJL
X-Proofpoint-GUID: AAnTNXotSLvKjuxbdyd-qG0JWCnmQtJL
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

Avoid using the maple tree interface directly.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 81ff47147317..fc279b6784c9 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -487,10 +487,10 @@ static inline void vma_mas_szero(struct ma_state *mas=
, unsigned long start,
=20
 static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	VMA_ITERATOR(vmi, mm, 0);
 	struct address_space *mapping =3D NULL;
=20
-	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+	if (vma_iter_prealloc(&vmi, vma))
 		return -ENOMEM;
=20
 	if (vma->vm_file) {
@@ -498,7 +498,7 @@ static int vma_link(struct mm_struct *mm, struct vm_are=
a_struct *vma)
 		i_mmap_lock_write(mapping);
 	}
=20
-	vma_mas_store(vma, &mas);
+	vma_iter_store(&vmi, vma);
=20
 	if (mapping) {
 		__vma_link_file(vma, mapping);
--=20
2.35.1
