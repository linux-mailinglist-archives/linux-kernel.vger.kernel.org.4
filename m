Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135E963C567
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbiK2Qoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235927AbiK2Qod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:44:33 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225284218E
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:44:33 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGPpWJ012335;
        Tue, 29 Nov 2022 16:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=npaeva3yIdYG5SBveLvD0fvT3geOkeCIKlC3QjmSuE4=;
 b=aKtGEhtT1ioD0mPD1sj++CojNHLIZpi7nVjpXVORcc196ehkMEbIiIj/koI1/zf5IvS2
 n2Tt/C+3afToTqfFu+J1r1D/bsqcJLimktVWjp9CJqli+6R1Ug34frcQrG9MYJNGZlsX
 N+MPIvhtdf+FVkjrH8sHocyj6WD0pOwtL3KIBTwZ3dMpriGQMzwSezHg6NVLBGoJLJR+
 b6GX4HgviTvxZPAKprw+lNk46oK6na6KnU/qRCKpVuIlr+6YrNgygWFvXJLQShk9EXAg
 xPkvYsmpZrtEmyqqIm+N44lszTH0e7PNWXabdPVrWJbtgJGwx9u8eFQcN7CDL1ugTFuP xw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m4aemdn8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:26 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATG7rBZ030968;
        Tue, 29 Nov 2022 16:44:25 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m398771pv-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DL5w1iLytWiHuRPQNSXGAtW3ANgFzXC2hD2jYQBskU26kwjjOOJwp2ZcfIB2pRCSG5G8plgvxqy6KmwyP6WufS8Z16k7ixuooA6HXGAximmWa2s513OTxMU1Ketg6GOUOiKbkLH/4jL/FHRegruUA6BYxD5ACvoc1u1YRVWKKFlOAQwK2DMwhtI8fXu0Z+1ASHbmK1CsKL+7EB2RXJgoIVwirE4wPOc49rrg3Mx23O+4rr969d4ZDcLYn50EPjZLFyv8a/TZryJr0b0h6hhoYGwgFJPIRKIZA8ffXNJyX9A9vfWoZGTxlG+2LebevDjwpuzAZD7gZWUJO4/k6HplHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npaeva3yIdYG5SBveLvD0fvT3geOkeCIKlC3QjmSuE4=;
 b=S/7VXbx9VdrOp6OXho50J3hkNoEKQ2tlN1MF49GXnCvNY7JPz6Ting3CyQOFoi7CTRkTmZMg30vepSaZhpKqsWNGWKKxCrg5X9655E6HZprfHHD9Oomk1irNg1mN9/NcgbQmu5VZJdDGJSL8Laim/9rArP4cgW2VQvJalj/GRM8IY+aOOQhlhvOqjxYL/HBJqyeZ7Cr2V9/uIjGAYNO3c20C5Xut6sd8XC4ZtMpgvZV2PCFCer0fEcFvwkw2ZhIYMkU8QycBWcGNkcNXVOqLuuQvgTeDXuGloZtcWhOiMAATi1nMKx7AkMLbYDVsmEzxQExZonzmtOBEuJCRE/o3EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npaeva3yIdYG5SBveLvD0fvT3geOkeCIKlC3QjmSuE4=;
 b=lJVIUlB8v2EAZ2O/rWbOjYdvTeo3OeO8VRXg9czMQdCBgXLxUW0qB2dGbDB9Yx5Ck5v5DOtiGt2lb03IOh3TmG6MIsj/abmnDSZR0uSFJK+ohSVtnJJIT9X6kVPEVob+WIxDwi6HX0spV2bPWLoUtAUxQxLAMgnoQtWSKFH1zvs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5321.namprd10.prod.outlook.com (2603:10b6:610:c9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 16:44:23 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:44:23 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 07/43] kernel/fork: Convert forking to using the vmi iterator
Thread-Topic: [PATCH 07/43] kernel/fork: Convert forking to using the vmi
 iterator
Thread-Index: AQHZBBHV/4X7tCg9AUalJ/KmEgTD2Q==
Date:   Tue, 29 Nov 2022 16:44:22 +0000
Message-ID: <20221129164352.3374638-8-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CH0PR10MB5321:EE_
x-ms-office365-filtering-correlation-id: d96387f9-b395-459a-584d-08dad228f846
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oost/JN1CJPON6IWkTC5EZiXTyCaHR4+QmAsk1wNpqLRPnj6qwtnN7ix0N5xjNY4uBvyUiiygfT8DJUBfdWb30y8YDcw1/D59SLGOunLJ7hSI43wUWNuHowdhHfATyvAnBSTbSOuSnty2v6FTKGWykfWc4ye5xUcMu9lpfwkfSgvcIPqQcdDdK/5KacRPiB+uWvQlRaldmXYWeUThFmxX0Rw+HZrnYCsu2nan6sRjZJHjtnK9B+QVC2Av++RpYUHQBGxcMu7KBnF0VSXVT6iwP2gEtMwT+HlVGKde5lOlwbEigxMshnvx151i+NV8F+JEK/SDbUcNOKeubS6yYr0VXM3EPh/fyd2CgdyFfxrcj+mPZWE4k+o2+6WBRW61I8BCKPWHWEGVVZ7zOMXrVWxY40jDRF1A8HaUdTwsDi2Szb9ESnidj+9lOYTTbPzhhTJqftwuQpw18P707y9xi75BgsyiXJ2P33oNTKLFjyG2aWmWHKqpNWmHZYfFfrikH57+MZF6RpNmDl2mWx+t+0GLSm1Q/TNGrm4hyU1eDqYcI/6+kyONMbIST4Q+rXjR2n1HUhVc6bnEUBr3NgdoAph+7aA+rOz6FRGIQAub4YDL+EV0rwjb5XmNSM041mG9sfNYDuOBHCEbunEItgbicU+ehY0WKOJzNObcZG1QJOHv7FFKOIztaaS1YHp1tFdb+L5tremeNnjVfyzo6qXXBEPaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199015)(83380400001)(54906003)(71200400001)(6506007)(107886003)(110136005)(6486002)(86362001)(36756003)(38070700005)(6512007)(38100700002)(122000001)(2616005)(26005)(1076003)(186003)(8936002)(5660300002)(66446008)(478600001)(44832011)(8676002)(66946007)(66556008)(64756008)(76116006)(66476007)(41300700001)(4326008)(2906002)(91956017)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UQqTbqFU7kBz7JhGRgPxmJd0GKtfaGOQ/Jjn+meKWpLdT7g9KWIvhtPMV+?=
 =?iso-8859-1?Q?NgihQ2BCcIPD2X7n8UICDY6NFQGV9XtiGgMcZHpE5xcuyiwRDqWpeMuH4f?=
 =?iso-8859-1?Q?OneDb0wCyO/OFh93JqLToTPatmhYd7M8l202iiabHlZjAFL5n2ICU7ozOj?=
 =?iso-8859-1?Q?dc4v9cbjInlaL1YMPQ0UHoASPCeRzEcKGa2vVPJWosLsnzGgcUrusyBF+C?=
 =?iso-8859-1?Q?JeaxChbt70ut5iqMY7ZixbRkc7MAH3CS8OJJ4UEz0GzW4wFVjtxBut+7lu?=
 =?iso-8859-1?Q?RKrKhmr4T/uJpt6AWYasbr31WDNBrMJsuMsq5ZK7w8TyGrwYQmDpbJW1NI?=
 =?iso-8859-1?Q?NTjwAeGAixiqO5QRdKB2XOIrkbmJCfVMeJxUUQIXgr6+ECi+btLohTTjDJ?=
 =?iso-8859-1?Q?uvCdC5n1OmxkmJrfMLJTJ2WE9Ed1xDzu06JBqgUE6UXrgbI2BgeB66SvuH?=
 =?iso-8859-1?Q?Em+2uC773mWcHYBMK03wFZIChg7Pb05h6ONMTz/rPX2L5PVxg2/XKpUqmm?=
 =?iso-8859-1?Q?vpSNK0JCiVZKXDUETaqvwZ3LqU1hc/gymZ6shbrQBC++7q1V+z94eF5RbM?=
 =?iso-8859-1?Q?U+4C/15LQ/RbqxwSsAkvvDJ8bJUcSD8haaqYjCRaSBBZTeUxyhLtXAjoPN?=
 =?iso-8859-1?Q?ILADS4ha1TZzLbvbx9iNdGMQ+xPlkkZ9mGZ4TleQbVekvfstzzwkHD4WJS?=
 =?iso-8859-1?Q?WsI1PDSaaDgLr7UHZJFksOR6oonwDxLFbVG6crsU8Mm6AkRsj67Ar2lyor?=
 =?iso-8859-1?Q?YhaaxD50rp1rrayUvtWRPUFj26Txklf41DMfLsA7kfW7B5ATqxIQIZ4/QT?=
 =?iso-8859-1?Q?Nd1ydMLNbGNTbbB/CjRK/GOkznAGKAsYGbhdGHPKNmW0RP+yHoAGOyhQlP?=
 =?iso-8859-1?Q?zNUezN5dYrojH+O09zTG2ALczB0RcyV1X1Wf9KgG8XYQzQl/GSiFsUixiU?=
 =?iso-8859-1?Q?iRhfYZ5SKTl3SCEIyfTh5hFN0/4SJk2QHN7JubADMIR7l7ZPRmjAaLDVk9?=
 =?iso-8859-1?Q?MvtxP5gMYdRgJReirb3/H/YpjugBLFr4tG+oEV3bThI4l4PFNcSVymEsbB?=
 =?iso-8859-1?Q?MuUB+avbAK0ifdC7ocRxr/bITMPTtIYFVU8x37y8sUrR2ue6bd+DcOK6fm?=
 =?iso-8859-1?Q?89y74dizyLQdp8kipMqgbEJwmiFcbuTd63YUEY+jxCr1cJVfQm01LI7taP?=
 =?iso-8859-1?Q?3BQQt73DwzTenSp9YWUtOavCEBo84RmdUrl8Jg2MqO8fKW6RjrVsBMF9nS?=
 =?iso-8859-1?Q?brqQJHVRO2xfZMAN/zbkMxqDd7eEGYmcj+TOUDUzLgGLSOHUD/TDAl1SYD?=
 =?iso-8859-1?Q?xKsO1Pb0NVuVoS82joUVXfF7YJDhC9W22jVOOC+Y4K7t0QbDkcNXHqmVsZ?=
 =?iso-8859-1?Q?AK/tyi7WGuMClDhnvwIRlgka1DmoXdVIaAX9ssFZ3Du/yVctyKUK33uKX9?=
 =?iso-8859-1?Q?Kg1jAfFwckiMb0/jfxxBu2VsKC1WiSwTF3rjskG5w9/lZfKr2PKhESSpvw?=
 =?iso-8859-1?Q?hCddPTlINjKHnj+1z7N/5CPtZuJplUzeV3+mzDPiwGRwYbE3T9AoGTZZ4J?=
 =?iso-8859-1?Q?oCr9r4hQWkiC7Et7jQh9Mr25vMISoZAbqA/kqS9o/wT9kdG5Nl3C63CPJx?=
 =?iso-8859-1?Q?bzDwAIf5hmGXq5XT7c/0QtSLqjBUK53zQu6buIq9jMOY0CUIsHqAb+2Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oceUuwWq/2lYvphwiaJve5qCGLubNC94pW37IkxocFeAoRLzDL7RyfRjS23n85nOQB024/f7L/6ORy7t+2Q+gSANEJcFok6iIra0l45jwKfhP3BDNpWfqmWZbJbGuKwTXtmhyAMg9GuInNA1EQcTH32J7e2Mv2g/A6bTX6bb6IT4rxukC/HgDycKkpLce4tYfWnjnhzmEjCXIl9mwBVsDB1q9l/kqXMd0LRg5rPt72GcfI5GffAww+brGtIU8dQQzPzd/90G6CwvDl0vR8bp/8lcub881BcLnmDBz1SinuLc6J+wDUf/oQ5CwM1SNNcJeKq8POqqZUyMt1rUioCYcbhiTzAhmKkzRpbxOzhc20nPoyWpuXPwC3m95KYBD+AP6RR83wwte0TFJkkTXpzsrKvtX9HumrzaTjg4y2zW1NszaOgYY5mI4KQZR2paCRIo863dyVIKMIyAHnP2HrzDM4kRHCEz73wo608ZWgR4sjS2/E+nev0vIobrNhnTpGu4G+jpavt/To0/KtJYXKjVbm21I0s1R9dvNs7WqIhHJpeFafJxeE4FNJb8V9DcQkx3MGm7Hlf7y7T2/Yw6DCOAX10FR6WD2IEZONd+w4tjgo4ipyMqNyPRrWupeUia9SGQinC2QQy5S+Zv6qAGG8TGIyth1nsanZnu3f0SC6hdsbLHJxcZ/xy84qPrgDvV0EJGqxqdUdmMPrI4Drr5rAkj4aKi3whEFsMSxbGammawVErAzfx0xBe7yGQmcyHkcdtO2nk/tuBMIQUe5QmyTaYWOtn9lmEV30ijBiSDvXlVXyhL2Ae3v4v6D5hyQLCeAW1InSzpaMMtXgTOkAt7l+HYLSjTNyaBQmsBKOgYvqlspQ8X76BuiK+tEpVKElYNHVCts5FdN2m5VG26QeOyuex7gw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d96387f9-b395-459a-584d-08dad228f846
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:22.2700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YeMczfJzM9w0IfwVYBAAy9CkAwSro4c2HKMpgRAkc1ZUxfrAckGIJBGOUHcY5rTD4x0ZUm0ME6lg5o77a04Snw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5321
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211290093
X-Proofpoint-ORIG-GUID: YRiXdIcGMduUsBiMt76TWNkvxZkf0l_g
X-Proofpoint-GUID: YRiXdIcGMduUsBiMt76TWNkvxZkf0l_g
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

Avoid using the maple tree interface directly.  This gains type safety.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 kernel/fork.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 08969f5aa38d..12f59021ff5d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -582,8 +582,8 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 	int retval;
 	unsigned long charge =3D 0;
 	LIST_HEAD(uf);
-	MA_STATE(old_mas, &oldmm->mm_mt, 0, 0);
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	VMA_ITERATOR(old_vmi, oldmm, 0);
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	uprobe_start_dup_mmap();
 	if (mmap_write_lock_killable(oldmm)) {
@@ -610,11 +610,11 @@ static __latent_entropy int dup_mmap(struct mm_struct=
 *mm,
 		goto out;
 	khugepaged_fork(mm, oldmm);
=20
-	retval =3D mas_expected_entries(&mas, oldmm->map_count);
+	retval =3D vma_iter_bulk_alloc(&vmi, oldmm->map_count);
 	if (retval)
 		goto out;
=20
-	mas_for_each(&old_mas, mpnt, ULONG_MAX) {
+	for_each_vma(old_vmi, mpnt) {
 		struct file *file;
=20
 		if (mpnt->vm_flags & VM_DONTCOPY) {
@@ -680,11 +680,8 @@ static __latent_entropy int dup_mmap(struct mm_struct =
*mm,
 			hugetlb_dup_vma_private(tmp);
=20
 		/* Link the vma into the MT */
-		mas.index =3D tmp->vm_start;
-		mas.last =3D tmp->vm_end - 1;
-		mas_store(&mas, tmp);
-		if (mas_is_err(&mas))
-			goto fail_nomem_mas_store;
+		if (vma_iter_bulk_store(&vmi, tmp))
+			goto fail_nomem_vmi_store;
=20
 		mm->map_count++;
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
@@ -699,7 +696,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 	/* a new mm has just been created */
 	retval =3D arch_dup_mmap(oldmm, mm);
 loop_out:
-	mas_destroy(&mas);
+	vma_iter_free(&vmi);
 out:
 	mmap_write_unlock(mm);
 	flush_tlb_mm(oldmm);
@@ -709,7 +706,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 	uprobe_end_dup_mmap();
 	return retval;
=20
-fail_nomem_mas_store:
+fail_nomem_vmi_store:
 	unlink_anon_vmas(tmp);
 fail_nomem_anon_vma_fork:
 	mpol_put(vma_policy(tmp));
--=20
2.35.1
