Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDF263C57F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236233AbiK2QqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236139AbiK2QpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:45:22 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFAF627C3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:44:45 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGPo8q012293;
        Tue, 29 Nov 2022 16:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=CU1PjIzJaxLqRHPRO7lWY5yWv2ZbpypHxHV5zOV9gkg=;
 b=ocAEzzVFfyX78R9BJHHUzupR3tbSB7wp6M1kzY9CC/NNfdhEtUHpAlDNJ0zaTL8DoXq0
 cycoAQewSo507gw8oTEYGMoWK90hzjiRYstBAKk94SUX7A90J97+7xjqZt5xaGX/TEym
 8wmg3Io6btc5DsqRUHnJiengNDaP+VbAjkN5XhGcg80qJfeOt/qucDoPl7Jk5+phk4ox
 ftpRVeUarKKuvqA9DW65GaDJ3fYRwmuqgSaPNfJIr6+wpJ4q39IJEDmr7Nf6GcCYhDbZ
 6phvrFxGRNJgu2UP9iU4/LhC2KESLJrUqyaSiEUrqqFJcBooXxG7kMYdDW39U6M5sS9I 6A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m4aemdn9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATGbKZR019412;
        Tue, 29 Nov 2022 16:44:37 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m398dr60s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4yxCw67AqdpeyvwhRcsB7F+nhj3WyFQuNmQtQhvDz8xCA21yO2DzG2VyEc8eB3N9ZvTocnyJVoWa1vocPWasKZP6k0iCDwUq57eizdHfJRPCPoQRblUq8hFoSLCfSaE/b2bx197/jmxR2bFh+7TnsFyAi7FD/9cksQuG+oHPrnC/1QV0hsXWQruYZKgaOKMuhgg8tgcg5sD3ta23O8yUa3BljQMwVEtYiM5OZ/7DNtniKEwuhqD2YifiF4Z7hwWoE3pDFuzdDNTXsJYRVVZ4elPE6BsYL2fCv53K76ABcWkPnIhXqjAg5EfKS3Cvhm+h/9Kwgr4RfK78Crmk6dpnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CU1PjIzJaxLqRHPRO7lWY5yWv2ZbpypHxHV5zOV9gkg=;
 b=X30NivgkPcmvVqZ+uIjsF2LbZULHUbzzZ3wu7MZ4fumZNJ48YeKO5ld9DftpufsN+abdt6Da6o0uCR2i3hjA42yraBjHP2uNhUMncnVPUnqYxUMjBmBTq3Zjb11cLQM/zl3eASxj58xfW48SHuEd/yXRiQumB8Hx7JOjGOWrb7NiuMY/TeK02eYrDd1VdiMU9C+fmm3OoLxPPxSD2MvY/yq7BGz2+J8xt1qmJ0HpA+HQRU1nVvPjATENXMLzMJHoUNw2waZr4VrqfSMHkHC3UZROmqJoyrvr5AFRg/Zi32FnNI1cVzaynwIz7qMqM970b8rHrJSVDckbWwt2Z93EIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CU1PjIzJaxLqRHPRO7lWY5yWv2ZbpypHxHV5zOV9gkg=;
 b=iC2pqSXk9bS7EZC09hYXgBYl9ovCVcdAteuV0PPxikhLhSKzGnRiTHw5dmpnRCC+UxPpM1OIM1sriuRDQVfv1OpJmuqSRlhBrSeDZpUHdTv0NkMZgxVCOihzRx5Oi1gb/lNZ4XF6LTlKNPC6bvXwyWyliac1ybRXiYZQk4T8Da8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5788.namprd10.prod.outlook.com (2603:10b6:a03:3df::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Tue, 29 Nov
 2022 16:44:35 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:44:35 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 28/43] madvise: Use split_vma() instead of __split_vma()
Thread-Topic: [PATCH 28/43] madvise: Use split_vma() instead of __split_vma()
Thread-Index: AQHZBBHbxBCbVR3dvEWVodnZgq9HJg==
Date:   Tue, 29 Nov 2022 16:44:33 +0000
Message-ID: <20221129164352.3374638-29-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SJ0PR10MB5788:EE_
x-ms-office365-filtering-correlation-id: f94cdee4-ed2e-4712-6d67-08dad228ff74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gy9nn4bSqbd+EDPH4ajV2OVWlXczBcmE514wU9ME3zSc92S3wq2PAyGsXlRnUuQIkhuZaD6t32iQ68JKbytoVELN4aGwUWx2fn6V0WKd1ONPR/XmOOwj18ceC4dbd1r5nORdgzna75XcoRk0zR3PrjgqsgZF+asngw8q79v6Q+T2VfRy1HTYsuX/I5D60NMiVO1GGA1MSYAcdQjRNqWuEpR6pwqemG5Z0ETpuIAIxQUnPVn4fVB5nscdanWfVGMPrDdSBLudCcWyQMWSa6/jvk31env41rNp5f2lGaVLyqXB9ou7taYNfjzS6aGl9Ecy+MuY+eb9tiRq1JCat4/4iqSxsSZIbdPRXxfY9CgIMnqCcSsFYQJCDucpEDDfoqxPflFdx5Gz4hXZYMJud231xxCDp7/OFSoHqaNHZdxexZiScWBtOZE8urMIAGA4UhubjUrInLenzZQ/sLL6ryHXgeAiiX4bQs2CYkqLHsDjTswEDUiR5XintyB41ot/Bhd4LtxhdHZdUI+cqBgDbjefjgVI7iVJQyG59scoD1Lsw/KSX9CiINps22nr5L6UouJF80LqcQ9/H8Khmp1Z376+UM0xM2ZRqHwEw7iP/Q6B17hjHUJlvvSfY3B4gq2qVbIdyBOD6ovDhJn/oKn0/pRNUM1baiI/aTXekNYgdtPqqZ7ExVWyEmpIeq3K+dmVXCDjgzRT48opSM2ZjeMpC4JUfQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199015)(2906002)(4744005)(44832011)(41300700001)(76116006)(5660300002)(36756003)(54906003)(316002)(66446008)(110136005)(6486002)(91956017)(66946007)(71200400001)(4326008)(64756008)(8676002)(66556008)(8936002)(66476007)(6512007)(6506007)(26005)(2616005)(107886003)(186003)(1076003)(478600001)(38100700002)(83380400001)(38070700005)(122000001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0DWkz9Uy49pxelDlW6OFAbp9mTjOmjHYpKOXYeCj1w+B4cz1LLf0s8bqQd?=
 =?iso-8859-1?Q?uOOfC0zsqXcLRce4URdX5LuVc/8Q68fDYOBFZ9IMHmncaF5Quw2mY/Sv9F?=
 =?iso-8859-1?Q?5BgZ9XJFVGhKNB9SBi7qHa2ZcXvdH/WOg6f/pgrK3G1yuA0PXuknVZJZDh?=
 =?iso-8859-1?Q?0Qp+NP6musr1Fp+KZu1ae+cdia6Cvg5SFEF/fVyGNqktMqUP3rEBu28odq?=
 =?iso-8859-1?Q?+nvn2xRQTah5Id2+UAOkNTux2v/Vstm+rC7KRPDFKZtVUgPlwYiQMI/xf6?=
 =?iso-8859-1?Q?LvMGOjjkeb4G1kjnQOwJkZfDleBTMjBEQbNGk6eKRbYAsMAJ9VmMaNRDy/?=
 =?iso-8859-1?Q?wgwLML8euggKZvNtJDy6gRY/GcksNBpu3epsy0BSduMdv6tls67FRgkJRB?=
 =?iso-8859-1?Q?q7w/9zTPo9gp/xOBHd7sVC2ee4H7CK6g+8zCcP7ZCMpTycFCV62ARN15cv?=
 =?iso-8859-1?Q?qzvEzpNe2nynT+ZdpeV5KpRl+7L7HYGg+sio/dozx3QIsVuwRrV+XlC58R?=
 =?iso-8859-1?Q?jW/w9G2xR/rjAhkK/Jof4XEqrtJszSxAch1bIhF1wLsElFcEDzvULGjfVf?=
 =?iso-8859-1?Q?VUVteGDXGiyBD2KaR9CgAYGgxbFN0G4S+nAA20gv97wxINduIrOzDcpiC8?=
 =?iso-8859-1?Q?YoD8aFlE6bxec0yQizN0TABe72bVLj29EMLLgK8ruUpxo+L4dZ004NbtVf?=
 =?iso-8859-1?Q?Xbc09h2Puo3KxulcS1sS0tJ+JnzLCZbj1Tievfv/GkcShMQ1QxUcbe6tpW?=
 =?iso-8859-1?Q?iNaLeY39/S41qjmBucgFwA1ToAdOwx4okjHSq0Q5rZ15qp4NSCPYUqziqr?=
 =?iso-8859-1?Q?DdQSsHFyQLqYd5w1mTMx9N5EPd3zl0x3ELlKDXYw/1SVIbOFZ8fgoPaVmo?=
 =?iso-8859-1?Q?ov7BD+7DopzL+Cum08HgFY25ICcQcrqdFB1/HxkMOwCiBUiug+2Kc9pkbe?=
 =?iso-8859-1?Q?3senKohUj5TrSbC09GdRcyL/LPrdHjsP211oK5isGx4Cwrcf15UGx8w73w?=
 =?iso-8859-1?Q?xVRltAx+N/MgdXLE8sait/5/1EUfIFeNhSiloIuOCNY/osKqi0lsA4pui6?=
 =?iso-8859-1?Q?wtz2T/desMU+R9WsCw213sU69JTUBpbDBT9GKZrjgpiVxbVRug/bqnLqg3?=
 =?iso-8859-1?Q?E9Ae5A6uZQeVCIIgjI+lM4kAhyPpWBzCFlaRpbpD2XNg5LvJJTKUpjNHsk?=
 =?iso-8859-1?Q?sOAA6ISnGpQF9yoOifIUscERrzNs5E8vqvMNDuIBAndhHyWD5cGZNC8Vjh?=
 =?iso-8859-1?Q?ofjJ79e54cPTcJomInuz4cheGw9S57ppyYyPk0qCFTosxkxQPncHrpNawM?=
 =?iso-8859-1?Q?mxd5CzihcMY1pHyiBTccA0d5+xn0lp0pL8VUioxJSXi50Z6s4eMBTYmkHT?=
 =?iso-8859-1?Q?HhJM6VP7EXdP//Jzjo8T9nYumaMgWrgtP0ma6CA518ZQHo7Q0hOMrsOqah?=
 =?iso-8859-1?Q?zpSosOEvXL/kmQV7AyB8x6OeKcxO+MbAFcjiEFBfi040JjXjOIBToUKaUP?=
 =?iso-8859-1?Q?J/gi/qdAfxfD8UXPqNT3PJ7CVLhK4ssxrdVXp44Wh9mso8Xi97r12cnbvR?=
 =?iso-8859-1?Q?hETwzuUAteHeBBg1d8O6dnUVj9/T1Kyem/KPeCS13LnaRinBL1ZaY6Rv4X?=
 =?iso-8859-1?Q?8AJnUflnAS0cYRHCXZ1Q7KcufUQvXplBu7LQ5PltfpLbjVoWZEEFP+oA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3PPk8UND+TJ+OjrjjPLmGU2gLMohOD838CPE2tzuZyDcez46YPF9P6QHWz1T903Sy3C2hw7JjTVY/cy93KyCM6RT1iD9DwGBzAumJ5n/c5+REYoT3j2eBmDYbLk4qcIuVavEv8Ex2GZHn3YvWMPXTmPO/QZMmy2eIgqLgpFuG/i4zBog5NE0ZVtTNpvWVvizDkdOXZZLwqaobutANAZv7rz1RmnVOnPNaXVa5t+UcvwGOrVva72WLa+JIL3fyVD2Fh+XJ0RdBp2l7/n01dkSWokLdX/UW255VCBSCU4uyHHNFavfQVL0ctOhF2QlEONvOBjUHll3YO/pSLgXM+3Jv4Z52fPMCsNatfeqXzL+o6VSB8v4Ii9kF4hEPQeiRX9aVtSwU9yrpnfdiSAwiJiUw1GKEoHhKW7c3nm5W5qvVc8OmixJcWZK1p5JTBWN2/oZMZcZL/ZOOWPlW2ru4EqVb4Sp4GaKL3L37tAchnjd+IurSeG4GL2gZrxrtZ81lxNxZjDVEIyvLADFmClZWuFxv1T+kJS3u4vcZrfBNzkNlUEkgLH0/8nVa4oKwMpZmfj1C6b/V5P/kJnSAlrdbFrF/MFWXNNfakoc3yeIe3RTzzCA6WEqbDEqCpVaGupW1M4vabqiknp1PCrBbanEoNaPIrW7ByolScFYyGV6+OLdgmwlgo0XACT7t12PzEpxQlGvfncZWZBJE4CtkvoLdzwT/KKb3TRObvVhp/KmpDlrwxZZ2M7dS29cxmEsEM0VeSP2xGDt+RJ4W/5tYFUm2XFRDyBGsubauYRir2rWVAnm+uTZPeqLNZtZrYvAakWxqE+8TD2jdsGI6BBAwLUTdlj6OsUC42h9uy8lZrIgv69UNkkBerAhNrWIwapeUMcfNTtPCuFuOm+RkqtH+1yZIn4gMw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f94cdee4-ed2e-4712-6d67-08dad228ff74
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:33.0036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tu69SA4wqRD7e7CjsGK2l0VjNTKCqNE/hyMKPD0BousOCPJMJQ/74tsQ76vjldlWLgnymOdoLi2LhvA0gBlQOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5788
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290093
X-Proofpoint-ORIG-GUID: SjHmrr-ovh08z_vnxoPw3wWPythRmVYb
X-Proofpoint-GUID: SjHmrr-ovh08z_vnxoPw3wWPythRmVYb
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

The split_vma() wrapper is specifically for this use case, so use it.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/madvise.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index bf23d64515e1..f29bfff3af1a 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -164,17 +164,13 @@ static int madvise_update_vma(struct vm_area_struct *=
vma,
 	*prev =3D vma;
=20
 	if (start !=3D vma->vm_start) {
-		if (unlikely(mm->map_count >=3D sysctl_max_map_count))
-			return -ENOMEM;
-		error =3D __split_vma(&vmi, vma, start, 1);
+		error =3D split_vma(&vmi, vma, start, 1);
 		if (error)
 			return error;
 	}
=20
 	if (end !=3D vma->vm_end) {
-		if (unlikely(mm->map_count >=3D sysctl_max_map_count))
-			return -ENOMEM;
-		error =3D __split_vma(&vmi, vma, end, 0);
+		error =3D split_vma(&vmi, vma, end, 0);
 		if (error)
 			return error;
 	}
--=20
2.35.1
