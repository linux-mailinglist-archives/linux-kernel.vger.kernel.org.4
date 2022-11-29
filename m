Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA7863C578
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236194AbiK2Qp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236064AbiK2Qou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:44:50 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00763627C2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:44:40 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGP27k031378;
        Tue, 29 Nov 2022 16:44:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=n+BdMqSBEKRAz23d5y9YNpH7yoNXn0z9m0ocO3Wp8wQ=;
 b=y3w+7L1xrYIfHzCxGhlZHlGxgacLvK325DQZCQZrw9smi+EmAjHjqBc6IiT71/ehKKCy
 aZD/OQSvbiH1TPl/XHyrpe7yOK4KfLZpNaY5uUCCYD28Nu6XLH1bbBHoszqxSAmFizWw
 fMRy1BgvF4AIwlo36pvgSIXtm/oGM2GYa/sa9qAaKLLuKzFdZa2A+2up9pV1HjZsPjf3
 eqwlrWQJQIDwS4a3XWQz3iSf3I9Ya6ikMF5K0Zrv0MpwP+nSmGaQTSiOlFgzE6rjpVMJ
 q8FWv+zHFc+GKJ2tXWU/bg3ZtUxLOE8IsGhqKHo/DVDVo5hlh7ZraGbAyGx4t0SJcua2 ww== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m40y3xasf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATFhsPo027963;
        Tue, 29 Nov 2022 16:44:34 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m3987f2au-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sse000ct5mtm9psaeQRP7q1Ih+Pdub8BBoKyYLYRpwwfjdpgMDa/uQ2gZYWyWgcYLK54+EMLVgsBqY1o2bKiB/cFPmJHBlpDrezy7+8i3iquZ1kCQ3za6m+D7Rv++fHxAcFjME2q5EyMamJ8GeAjZcRa2sAaloLcSCorSR/SiOLYRSrifQBatUo3s/IXJmAJEnG9yYFNKJ38Ep2CA/EUUfkVbk9Qot3KapuZJVDoYbZ6i2jBUp6AHz3LIHCXUQxsrPUPTfACILGn0HK6eC+hmecpRYIHPdpHEAnq7hGo8bPQKRQLEfdttGIUu9s2Due0h1F6WZ0GllHOjGL+sB/NTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+BdMqSBEKRAz23d5y9YNpH7yoNXn0z9m0ocO3Wp8wQ=;
 b=VPKf8+lnqO1+cuXd5S3cRU/dkUcBAL8pyBBN9lgIJ1/JRleLVHztuBm9jfwO9D3ry/KQsfCjef23a1tSqozdLvzlTih3Y6CZH9IyPqCI3NWAdeRPpBdxKzNUO9Ytg7mNUi8ceeV1BJW7g/3OR2reFmyrcLUwAAzK89qjIq9Vj4J3upXP1mYQ4jeP7ll8hCs6JtjLCyFS6q8Bq1HSdCg5JjV08rQrkm7bKyvgLoqptr7eOO2MV8TRpQHzEtqe867Jok9bUrqiA1fvJ8Mx8U/hlO1k/FWhHEzxDTQcP0v0fgeDAatBseSw+Bm7op0fVn36G1DT+b2DF4ACg+nwjP7GVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+BdMqSBEKRAz23d5y9YNpH7yoNXn0z9m0ocO3Wp8wQ=;
 b=N45GlAccv8v5qfHJgto0w54FzhzAYZhf1cH5fdKlHnqDPFa9zdH0sDrbTw2qAq13FAfktpoIL5FnHsosNpx0w61cmkjLPg4yF3PJ6R/NXaGbme0Jsqi+LOS7H9Kw2fao4j9zK/d8+4twIG5jmcuWvpNY7QBNsQKkxF9+uj/5rms=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5788.namprd10.prod.outlook.com (2603:10b6:a03:3df::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Tue, 29 Nov
 2022 16:44:32 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:44:31 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 22/43] mmap: Pass through vmi iterator to __split_vma()
Thread-Topic: [PATCH 22/43] mmap: Pass through vmi iterator to __split_vma()
Thread-Index: AQHZBBHZhKiCxadJgUC/0Bmp0ZJXfQ==
Date:   Tue, 29 Nov 2022 16:44:30 +0000
Message-ID: <20221129164352.3374638-23-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SJ0PR10MB5788:EE_
x-ms-office365-filtering-correlation-id: f89932f7-8d28-497f-7a75-08dad228fd71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8k8uiVm5a4yyoDv2n/lTneC/dTNWtK3wTRVxMeGEfTe3ujbtQvUev57lpKoW2pKVGfMFYrImSqFmclfVK+N1VFJZe+XK/fHHT6dFfUECV7cvBo/A8WOQvZ1hRp0F64X7wPJllFAky4kh73nTrtKnuBOtnvy0JRgrAj2NGdJHCCBoYqZNchT9O8xrFfOS07fqzoUO+Fp6mxGa6k049NTJ+WHJtV4m/2mJ/AszC8ECDdyYJyW5zKA+X0vcEKLoBbvVr+Auxdt8NWsP1SwF7RYmqvbJCu3xjsJajnrSSpKuXhsoRpsVv5M8Bt1U2J9XtRDWRIf3ehgNgtaprFoEr/HX/EVRuJ84rIgbK4CJhfeTPJ4VHnyepM2X8B6OVsIOlFERMZXXVZY4ELxwUPPmIZmsouaET3WrKsiVaGngpvbw/eM/MFY8kteCTK5zP9hDdmK5/kX9c8WUMyT2QQD6NvX4skILTeO7QvYsPTaLffo3OfuW1WD8ha6bmzagpsumUAWhpW1JcYdb+8tkxWBCUY2BVSmWV1ceA+IU/QoGZEsIKy8atA10+MKO4w5URB8WxpcMyllUtzh5Ieu7a6uSVpElSxCoAQ99B8EfJQd1GtquCuq0vLBc0gGhIJxj4gwymeZ6NUDsxVOibgscuz8W08S7kWyQeh5+b1xXZOqFd7kIFdZdq4luBh2MNZ48L3pHlBJK1CqxJBU7A1an4ff/ZZI6Fw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199015)(2906002)(4744005)(44832011)(41300700001)(76116006)(5660300002)(36756003)(54906003)(316002)(66446008)(110136005)(6486002)(91956017)(66946007)(71200400001)(4326008)(64756008)(8676002)(66556008)(8936002)(66476007)(6512007)(6506007)(26005)(2616005)(107886003)(186003)(1076003)(478600001)(38100700002)(83380400001)(38070700005)(122000001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+KdS8zFz36eQD5U8rQRIBdMCDxWxSDOch+L1LlyJiae8brWT5nCGhW102e?=
 =?iso-8859-1?Q?fbmh300NMZ8ewpnpdzJLHXap6erGDNna6HAwIAEB/n4I+DcYUoAnRMaLfN?=
 =?iso-8859-1?Q?zraq470sAvulMCdT6jGMEeF/bBLfCUxy88zn/w12G3tth5dl4CSKRis4sy?=
 =?iso-8859-1?Q?7xF/31LsuVGM+cEwIBijcN0gdp7Xve9vusrxcoKoo0CNFKy5+KHb1LDMDW?=
 =?iso-8859-1?Q?lS1TrBXHG0IwW7vxI12R4DFRQ6+VSNkU4FH4197OVNiCp/XalDRfTDD9Sf?=
 =?iso-8859-1?Q?hD65CLvaro6IF+VYcm2UvXFmr/JjqN6gg0wrJl6ep+SsI4IF9wW2wKynXW?=
 =?iso-8859-1?Q?kDFAOtcF7f0Jp0DN3YPxlV4OGal/H07i4vcrBDXZo5yVNSiwLXWiY7tM5b?=
 =?iso-8859-1?Q?+VXeNHjzOwbsHqM9uT5WsVcSOFFX/b/Dim/7QUcmogZMicaGCg7Yp5IfYL?=
 =?iso-8859-1?Q?cuRUyYq6gfgURhFVynr5PF1wzF3XUiH6XQlCjCdVUUJCrtmJVheXS2/Awf?=
 =?iso-8859-1?Q?fVxXDHRhuw1wS5E2ukpBDP65ikdriehiPJAUiOiL2i/5IFrHPD/eRgH4yt?=
 =?iso-8859-1?Q?Y9okQ+5JmJWhHlY0ZKFOQhcJWqDAVNHLyy7EH+BJyrbNwamc6pyZEj5G52?=
 =?iso-8859-1?Q?uD0l5eF92+9Oa7ym++hHmFJufXMfzEA2CJNRqXSaogeibax2vweyVaEsuk?=
 =?iso-8859-1?Q?wpmNgltVTBFAP1Kst0zQRmHpdBKwUsmb4+247o2SyWn3FHqNST67Yn2Lux?=
 =?iso-8859-1?Q?ImuHh+QulLVuP+SA3MkB87DohHjDn6TFlEaJsmNE2nH8huVJ0gY5wPjvu6?=
 =?iso-8859-1?Q?qy9zNOGRqUqEGn6N4IRZnscaTfWsK/GWU2B3f2TSnc/XeLIF43jhZb79UT?=
 =?iso-8859-1?Q?CR68dA24ep8/Ram9T5sI7juZ9QPXWINhLs4pHn2MpAcUV/kmIs6mN2Qqha?=
 =?iso-8859-1?Q?Ni+ge3c26wDo1Y/gUlMHJA/wcXrcirdEAGlkWmaHiEFUGufOrVY4IiOUG4?=
 =?iso-8859-1?Q?Uwr4eOkfdHo1Grh3ajGgQLJAh844Aw0XfdZbORfXIwkohdPA1jU2Vn+7yR?=
 =?iso-8859-1?Q?6hJdCmlBc6Qygtdb+bWaF8LD5DOb+R/1/mkXuv/wQ87AaSDe/SKOZ97QOZ?=
 =?iso-8859-1?Q?SjDCc4OkDAXi8BY8Id3bm65bWd7DH2/FvCXPQBDCBsHhX2K2YcrA2IKBWC?=
 =?iso-8859-1?Q?JI/O55s9j1CO3e3NQAT4tOSBqoxaWioZnUITOcmg8vfrvMH0mBchU/pwFF?=
 =?iso-8859-1?Q?LinrcXRufHuu3sBNNwD0Ca3fAqO1ecIfiI3keNk5FnKqpBJbNHB+oPiZCI?=
 =?iso-8859-1?Q?wFNntFiE+fFYRE0DaOCeY/JbibMSlwpOFTs1rHzgFCErIvedzLaa5GzH4N?=
 =?iso-8859-1?Q?ZIGJgkf8rqP8mmm4nSLgLOHdCSqGQUDQM8Zlb3yfMbI+D3bIwEkWo1SN6A?=
 =?iso-8859-1?Q?U1CPy8fmaLko0u3TkwSkEfQz3+1Z73g3ojcyDx1dvLtxgisU6A5odl61lT?=
 =?iso-8859-1?Q?Ub5sFv7efjBtSptP7lrseVlrtA57piLVFrc3SZjNlkAgW2UKOonm2cTzP5?=
 =?iso-8859-1?Q?sAtn55EzqbUH2aALm6zMwhpNEQxdMQVLX/g5I63wg18TiAdY3QtAbz8q/m?=
 =?iso-8859-1?Q?c+UnH/L1xoTb5j3tX8AxYO7YlJzfBzSTHwoE/gpO269zEeliTQsCUh4g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JmXvnmIIptMEvWSJEmvt3WBxQjnwCz+0cciPMUVVV7LMjvS8xwXcarBQrZxMZxe0CcGb1JXD5pALbfxhoenevrJzEfrDtkALcsKk0Ni3uoG/ONfk0OaUm7p13tcgLVAya7Ga6W+qgYCeX8cq3pz64oj4rzmTDnCFm3KP70/qU3FTnK4xGbDXsJ0lsL9mrOSE/Ne+O78DMylE6m4bokahl3Dy4g4AXN13Y5ncSpN7sbaOAURGVFtuGannP1r3ubk1KpHmLcEDYxr+iSA7b6iUMbULxuXN/zafaw+269tuN97w8XVcSn/mcQzImiYDQz/sgN9MbJGABUKKnAgSrAKzzlL9hdhECjHtnaBDPvH8WPj08aDi3MAVztm2cuEBYHuZYhpbKcnZcE5mso6WG4FR7pRuhradff8aS7bEKKybOoQJdga8gndIKkfHNe0aenSnNu0PU0lOStmo9pA2hITsx5dBqTarRceK3d4wDq10tspuNLuFOm0WvDWxq+rC2DDDFsLCFnpsmqib1JZudf2vV/uBLLWnZC1EwqSkXO/rBPYBghdNYEg8JEzpIY5FYjXYsO3m33WTft4Kc3rzqN1Dj6JFLCCAHDPGtB4/UquyQ/HlQfTtF+pjFBV+4JpFmbKuqsCIVDtGwDnirFGmZ2Yj0h31tyC2wv3HPaKIFhE1Aw7PNR2EwOPUvKgHmVKDspV7PIfWebm8IuG/f6Do/WFFRS7S9uO/AXrw4WW0chxsgNKNIRPszQTab70f80UBguUlPpeKkRmU1HgfbMZNUUg7TEBu9HYSbkrHqYiJTRF/CKEu/ZY57tMK6qoC1Uu/lq3M7RuwQE3iueer2JVM3yi00qWt09v8PPor6Q/HIIHH4auDNk1j9s3S46Tl58anOt2rY1b99z4KbtwDBkR9DyJe9w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f89932f7-8d28-497f-7a75-08dad228fd71
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:30.1132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bcN+xLgENNx/paSFdePwUC6nCr7Pwc04oGexfOAwB98OFTzCVzUvLYILCh6eSKuHTWV+ez8suxMOuG2sarijKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5788
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290093
X-Proofpoint-GUID: FbAJ6ILbhI8RTpXuBbCAXdDJ7lNZ48PU
X-Proofpoint-ORIG-GUID: FbAJ6ILbhI8RTpXuBbCAXdDJ7lNZ48PU
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
 mm/mmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 4102cb0c2793..4dda84378831 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2447,7 +2447,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct =
vm_area_struct *vma,
 		if (end < vma->vm_end && mm->map_count >=3D sysctl_max_map_count)
 			goto map_count_exceeded;
=20
-		error =3D __split_vma(mm, vma, start, 0);
+		error =3D vmi__split_vma(vmi, mm, vma, start, 0);
 		if (error)
 			goto start_split_failed;
=20
@@ -2468,7 +2468,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct =
vm_area_struct *vma,
 		if (next->vm_end > end) {
 			struct vm_area_struct *split;
=20
-			error =3D __split_vma(mm, next, end, 1);
+			error =3D vmi__split_vma(vmi, mm, next, end, 1);
 			if (error)
 				goto end_split_failed;
=20
--=20
2.35.1
