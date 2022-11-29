Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A788463C589
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbiK2Qro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236314AbiK2QrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:47:07 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4766C727
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:45:16 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGNtDk022642;
        Tue, 29 Nov 2022 16:45:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=RHghaLX6pv2sfyk/b5fhnEpZNLjyUuZzYJY4y227BYk=;
 b=SVmuSpq/t54Bw1wtsarDlx/VAN1fmhhNANx4g9uUHHX0OHiLAz/VzKCOtuBvYFjISsMU
 skMmdXc3Tehbqv7XHg2HtNIZSMYhw4mxLK5f5B7i/fM+ctq2XtzX25mvUNAb2kyh+oJ7
 IyJV4XxR4OOdmgcB8j4RLfwPiikK7cOpXelzqH9rAqdZFaZGK4iq0NtSLXSFpvUrR/4U
 yt4dfbRIl3mHbZSV5QSgQh47RB665J3+s+2VRkcgv+MbB1rSMYhcx4pAoWCP1yBj5jvL
 XGR/26hHEWpiabNOtdcUoQpPSIlua6CKdhZcyq3IOadv6SWdSltMoyQ/D62IQMz9snSx gw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m397ffc6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:45:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATFkaTu026698;
        Tue, 29 Nov 2022 16:45:08 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m3c1vkkp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:45:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVTC+gE6iKqNDocXxG/R7AyHY3WIpxiY8s89gvB3kW5+nTQ308xMYhTLfpqHX/EgrTkXNQsKJZPgMb02j1XXHkWB5VaJhn6uaYIPIX1EIJtE7QYPOXxclfe2/GPqYmqJpCUgJKoBl96e5dKWfR6lAgMgwSpuMVkG+25Q8eumNrnumprDFl1G5GbRKajwJlX5Ba63v10rouML4T8JI0DjMaD1+jwIuCIMPtqwNDEaY5ayvnkRx9XpOS6/F1mNP/fNw1btgSS5Rhm6qoJNpczFtIQMJxeraegh8nPNRsC5Fv8jWdecax7kzcV6zmmlgLZGJ0KywX4+t/elc1SkXNvhOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHghaLX6pv2sfyk/b5fhnEpZNLjyUuZzYJY4y227BYk=;
 b=eCpHw5tHhGkQhbPpmUoyx0h1sK9mu7qunSyhuXISuaduSKOJ3hORbH+30FKIG2XR3pWDs1TA+q4tDqbqNL669nZGi828msgJ6eP1P29oBS0ye0owGGbF0zmLXEbqMii07/DyTninNMuFW1HwaGitrU1Ow5kaU3JYhAS9i0n4ULnBrPGdDO12R19v0dWkrADOPVoArKzxdM1SIXdWnWKNbRCjy+RxPAQ9umYYRmx4e902dot7GrG1O88tur1QQVMaNCMixVeV6ibdbUr8dckvdGvd8Q9SqrzMVnnfa9xYxfsc1GduDtkGELTx1/2s7c5XHzF+mWA91JuIyP2TMGuHow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHghaLX6pv2sfyk/b5fhnEpZNLjyUuZzYJY4y227BYk=;
 b=L3AloWIGdZUSyGnhylQu0ilm33cHaMxjOG+M6wib/mfmRWZhgEvGqkjYGGV9+vXiJkJ6Q9GxZyI5lDsKwEX974RwIokIq5A3ZhchgqVnKQ+28tL0btxb2vXHPZ6LyTXiuJrZ7bchLyKzEUiHtg8uDafXl1THMfc/s5fpVy+7+Nw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4792.namprd10.prod.outlook.com (2603:10b6:510:3d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 16:45:06 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:45:06 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 30/43] mm: Pass vma iterator through to __vma_adjust()
Thread-Topic: [PATCH 30/43] mm: Pass vma iterator through to __vma_adjust()
Thread-Index: AQHZBBHcOZh/mBGarEuk1bDv/0GJYA==
Date:   Tue, 29 Nov 2022 16:44:33 +0000
Message-ID: <20221129164352.3374638-31-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|PH0PR10MB4792:EE_
x-ms-office365-filtering-correlation-id: 5c35bcdb-709a-4d1a-f27e-08dad22911eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FQQydSipldy5iJDm/vz4nlhgBIaLjkyvIlZli2YZBM6bSw8s18BimX00ok7OWHyKoMwvBaITFICB5KA3XlOPC2ynI2faMRYVcl+HQZojY3rMEnFc8cDLs8u8I9Cwmo/jwarSPZ6CMmICD8DPxP5GmMO0XeRkp8P8ek57JvXX3Xzz8WPt03+YsFSot/sQ0TStMqqklOVVCwuKlGlwt0eMG8Z8PZn3sa6FSC6xD6Q7WeyFfaQ/XweYc2pw4FYs2r7Lz7i0w6rGz7N2mbujym7HK8e2t7Z+3fka025BrbW2JLg16kSEBkppxgiexyRQe1y+zBUIRICayonCKWnzmCwBAioeaDK0ZLBOnNWYqEFiFmxZG0smuWXonVb0ky8T/Y3tWiCCaD7mflFtIg9Y6ObN3QYv0osFdSWKZxICsnR6Trv7Xf4D6o/VIGzWdh9E2OeEu4/+EUaTyctF9Pbh1V3Up2FBgdkTzvdjDv0QrwiTcDEg1BCqGFDMAUROMN14m6U6rNpO6NfFhElZj+3GdDIHNev3DSwjcNT9OaGbc9os/uTzW0jWV3/PTGprDVkp66JHm3Nzs0Mr4k9MDcOQPr79dx4YAzZOdsP9pJEqFGC/db0G/x2zgBuIiTV0LtYuNihchZQt5y+DEEMouHb4jaN+x9C1TyyDiEWwFqzGG7GtgkfsNeqm9nVJrN1HR7kbMr5xA65Gq8HZr4N2eFzKWsu31w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199015)(38070700005)(2906002)(36756003)(86362001)(6666004)(6486002)(71200400001)(107886003)(478600001)(44832011)(41300700001)(316002)(76116006)(66556008)(66946007)(91956017)(5660300002)(66476007)(26005)(110136005)(66446008)(4326008)(54906003)(8936002)(8676002)(64756008)(6506007)(6512007)(186003)(122000001)(2616005)(38100700002)(1076003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?D+kXn9MZFlybRfRrQ9QQtW39yi/H/sl1rsfnDSvwbDCyotmb6FtQ8YzMRL?=
 =?iso-8859-1?Q?Fzy0MVbfD28jGMsazYEefGRa4zk1qFc9DzQEQt5i3gCtmr4Bkun80YFqVz?=
 =?iso-8859-1?Q?EY4Jbibt1g3IAlJ0bIsZa8b8wm4CwcpojuvK6eNbUDDhGFAab/A8xQ1REb?=
 =?iso-8859-1?Q?yFL7gss3plT2udVYI2x7DyiwoKH3an2dlP97vnfrnLfLTEq6y2KgPxIAsP?=
 =?iso-8859-1?Q?DiddqNsdM3rFw5nJ9Y2K4JJZCOs1My5bEiujusqpeNdqukt5auJSV+dD4h?=
 =?iso-8859-1?Q?c+FGTgt6HRV2nCNECtBL4AYsxFnAXWbt3IarsBAVAMEbLmyPhOlbpf4Qrr?=
 =?iso-8859-1?Q?YWTkIjqM9V/w/Q3iQ86IPwQdkuYBA7dfqiyA1XISrDc5uOlAs6Z8R59nIO?=
 =?iso-8859-1?Q?7OHg2h6EohrBobOl1HoZjgS2iHHq3SGEgpNDHAUGWGNg7cP957CCiiDg2T?=
 =?iso-8859-1?Q?HDCn8eBKEKv93PfFqNiHZTldc1dK3Vag/IUp6Mcp+7ZBcrmLclIDvvYyuo?=
 =?iso-8859-1?Q?t6DQPAEpkFh2bGpQQhE3nYBiA+kMXGPXtfRKwB4cUbLlyX+36SA0ZHxIZO?=
 =?iso-8859-1?Q?/7iAfXsI2aW2SBvmIuYXPRrj67ejGQ3QAvDoQDMp6ZUURFVNn/kmtMy5yO?=
 =?iso-8859-1?Q?i5NDMOTOznEsqD01qeBDf2intufBs602SJchsp+g490ds6Yg1WI5dtJX+e?=
 =?iso-8859-1?Q?AsCGSGThhPvHicVR3UKyYBW0njWQUWfAGG0JWofx9uvXQTsKnUJcFks0WL?=
 =?iso-8859-1?Q?KTSiKVqrMr6z46gAOgs5oJKTFul/IQ3EqVtvA9q64fiV4Xzw4LEofi0LLR?=
 =?iso-8859-1?Q?2I5wAzFNVe0TbxSGboC3La+hOmDJiW3tPKJCRv61l1kBrjmbbm5A+2+6yE?=
 =?iso-8859-1?Q?29cyUeqFTrT89AF4XTG7/Hhh9Gjkfi30LB9FGAg5Oucevxiz9y1YQqiH/L?=
 =?iso-8859-1?Q?qkktUEYko2FTUczkdlTf/BIo2VMEnhvro1mIz9WNXAhPRhro2Jui9pWRUL?=
 =?iso-8859-1?Q?+Iv2qny5EcndIuu+Owi76a71nCAor2ilwpGV0K3oIHZ86kicwSjCXrCO5i?=
 =?iso-8859-1?Q?jSw7vfV6zqgx6fDJqU9dVSu2KInT/o6zp3hSJl8rCZgGtC3vGSxtcIRsVK?=
 =?iso-8859-1?Q?fksPMYaVP1/wCZNt7wCz0vbwyG010jpxY41Kf/Po7eurDCH1n69B0LyzTa?=
 =?iso-8859-1?Q?gCAhEFAhXav1cTs3vUT+EnoFl11pvEe/mH++8VIf0fCDDG/BIDPUv3lMYM?=
 =?iso-8859-1?Q?/nObU5LkV6Kg2y1kygJcDlX1U6b3imzrkMjshUb+zvM2TnAPK3m87bAMkB?=
 =?iso-8859-1?Q?ZZcc/HniM1qp95q67IW98q6zeq7z3Yd8jBa1RtbBYqsZ1NX/1UMSmxYt0q?=
 =?iso-8859-1?Q?v+Y0BCTolO4k6Dax02l7/MSvpHqtzlpgD9K6+CC6/9m/EuKBG7StP0W0B5?=
 =?iso-8859-1?Q?DiLkzdI47K5G2Dps8bdD5nuuUUbrKVmYJryvQBt5j+Z3SP0UyTJGTJ/f5Q?=
 =?iso-8859-1?Q?FTsQ6YlmMmK+62tl+egyj2FwcnBaAZOs3u2TUsg/iDCSWH07B20W9HpRlp?=
 =?iso-8859-1?Q?6ReMoZSiTjH++SFG9L9sGpPDJBovmG/XcaSMJok4t0q1M4R/Fsp48c5ov0?=
 =?iso-8859-1?Q?/tVf2iWtwhsfKixZEJ7lOY3BbOFGQIGUnmvhtVbAiDfKZ5oCr4hAEhLw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sBwMmRy87ExDwzgKNm2M+h5PQ4q7s9hU0KLuVdSHA6ZGb+PR0+s++/k61Tfo5hikWiVt/8DCRKT1k0skPsuPUm2H0vt+YB0VmdWn53UfgfOCzKhqFbNncEe5ZVCQgAuifPpb98QScM8+egTH9lQOo46/b8SsaS6VWIFyJDenE1hBUUeV8sgQF++k9aXDGgas/sV7L/9IPlvCmv0BpJDE8kNBvDBHWnfhFSUVfyfFqjW+sFm7yzFr93YllwhKZqwlHwMOoLAI0U11DcU+2X5Dm64RZ+1hKSlFcY3msoKGPAuto2YvObNcaqq1AE7dRr6G9LvoYX8VLr1vK6L9xHyDqJcRckdCrqSt9eKGenS5kD+tKUEk3icEZdFjy36W2AxJcCr3rab4/616shOPKzw9/BAxBawpcEBbNJMBFGRmegCcq2H/fESDpFS2ay4bfuL5EttoqZhlMtTTq383FN9iOjn9Qtyqrjmf5GQ3ja9RRiLw7YC8mcuddrOpYv5376VXxQ1EZus6ZSxWnwiRbF2rDtoqjaOHO0oN9ctW6GSudrYsDS1TgQwBq5yVqXcft6KlfFNyelVn06HPKQwhFUYJnPqKQKAA57LpNXXfINKPYuALvkA+Zwkqz/5OmH8IP3zBtA5EeGMo0T5EpG1ikdtijGHFs5kW/jcmFXVgvnyO7pRqNVztWtzsMvcjmzrJh4QLhUXD9L/jRnYvgIuEJ9GSNcC4VBYLBRkC62LhlB1RI3hiinM6V8X8XGReFvxv9sJJWLZt9YHg82YUEAe7toBAQF/IZXi+N7zJZGnhWAx4PbsY+iUdX5TEW8k1wGZm/R4KILSrgRulDUsjtqJxfZ67gCY50IJMl1VACXCUam8fYzNAHANQJ9FdfDjtX49KfBVMsbm2vQJY/eJzo7gTiVwCWw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c35bcdb-709a-4d1a-f27e-08dad22911eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:33.8161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MgMyw8mTRG6aOvGiihGQ09pDdb1oZpx7kL0KTmjW6yF+s9O/ijnUgE2O8PUZevIUXV7ConVPfMrY6o1aiYBE+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4792
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290093
X-Proofpoint-ORIG-GUID: TqjeCmm0Wy-MdAZ9wTHyZIeWZ2XVieKz
X-Proofpoint-GUID: TqjeCmm0Wy-MdAZ9wTHyZIeWZ2XVieKz
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

Pass the iterator through to be used in __vma_adjust().  The state of
the iterator needs to be correct for the operation that will occur so
make the adjustments.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index f37a6b5a40d6..b1d17eb5fe59 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -585,6 +585,10 @@ inline int vma_expand(struct vma_iterator *vmi, struct=
 vm_area_struct *vma,
 		vma_interval_tree_remove(vma, root);
 	}
=20
+	/* VMA iterator points to previous, so set to start if necessary */
+	if (vma_iter_addr(vmi) !=3D start)
+		vma_iter_set(vmi, start);
+
 	vma->vm_start =3D start;
 	vma->vm_end =3D end;
 	vma->vm_pgoff =3D pgoff;
@@ -2223,13 +2227,13 @@ static void unmap_region(struct mm_struct *mm, stru=
ct maple_tree *mt,
 /*
  * __split_vma() bypasses sysctl_max_map_count checking.  We use this wher=
e it
  * has already been checked or doesn't make sense to fail.
+ * VMA Iterator will point to the end VMA.
  */
 int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		unsigned long addr, int new_below)
 {
 	struct vm_area_struct *new;
 	int err;
-	unsigned long end =3D vma->vm_end;
=20
 	validate_mm_mt(vma->vm_mm);
=20
@@ -2265,14 +2269,17 @@ int __split_vma(struct vma_iterator *vmi, struct vm=
_area_struct *vma,
 		new->vm_ops->open(new);
=20
 	if (new_below)
-		err =3D vma_adjust(vma, addr, vma->vm_end, vma->vm_pgoff +
-			((addr - new->vm_start) >> PAGE_SHIFT), new);
+		err =3D __vma_adjust(vmi, vma, addr, vma->vm_end,
+		   vma->vm_pgoff + ((addr - new->vm_start) >> PAGE_SHIFT),
+		   new, NULL);
 	else
-		err =3D vma_adjust(vma, vma->vm_start, addr, vma->vm_pgoff, new);
+		err =3D __vma_adjust(vmi, vma, vma->vm_start, addr, vma->vm_pgoff,
+				 new, NULL);
=20
 	/* Success. */
 	if (!err) {
-		vma_iter_set(vmi, end);
+		if (new_below)
+			vma_next(vmi);
 		return 0;
 	}
=20
@@ -2367,8 +2374,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct =
vm_area_struct *vma,
 		if (error)
 			goto start_split_failed;
=20
-		vma_iter_set(vmi, start);
-		vma =3D vma_find(vmi, end);
+		vma =3D vma_iter_load(vmi);
 	}
=20
 	prev =3D vma_prev(vmi);
@@ -2388,7 +2394,6 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct =
vm_area_struct *vma,
 			if (error)
 				goto end_split_failed;
=20
-			vma_iter_set(vmi, end);
 			split =3D vma_prev(vmi);
 			error =3D munmap_sidetree(split, &mas_detach);
 			if (error)
@@ -2632,6 +2637,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 		goto unacct_error;
 	}
=20
+	vma_iter_set(&vmi, addr);
 	vma->vm_start =3D addr;
 	vma->vm_end =3D end;
 	vma->vm_flags =3D vm_flags;
--=20
2.35.1
