Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4676565F431
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbjAETQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjAETQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:16:15 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301B6D2E7
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:16:14 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305IUJ5d030170;
        Thu, 5 Jan 2023 19:16:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=GOm614tl429iOQ+POVCVrJ+RGa5kuncI+Q8HcO7IgjY=;
 b=nFGiF70s8no7lzl5sYvcZYSomF2QqY9d8FoXMayBaOD7GqoyvltksVWqyeKn1tNym9PS
 SdH1sdwqjqtLjv0GsSWjF+o5m15nxz3FyNBnUaXe/LYKWRkSXvKZtngKnf6aMDIlIQim
 wdt4RosFNqOQj2qn6WQ9N18WtKr0QHtWburcSABJKVB7F1j8s9OtBOv5asO9sLxeM/kW
 GyFJZmP6nYTmi7V6fKRbZpl6iCX2SCBC3LQBXSn3bQ9hprOwKc4gzgKCT0oHSdKHK7Hj
 nEDUYq8zdX32U8FT4cNCCOBw+Nbpn3amxEKvOjQ2LSct7xNp7T+xaKKaGQ0JsNpwSmL6 HA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtcya9k9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:04 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305Hvlpo023372;
        Thu, 5 Jan 2023 19:16:03 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwept6m1t-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChHyF9oOCmFU6lkr23Hz8la72QALSrSwfqOAUwZX/33Y6eUR8DEOvPwMvLatRXZ/M5p/H+t9zW8p47X0+Od5EeJmcJxyif4oU+ikux5vsz0UE5lRWOkkX89lQfjdnZhGFFakWOoMMj+2GOUka+Ga3HhJSokViZQsBk+Sk3ldtoPS+0pKvU2x7/VpCvp7jwdrtDl5OtsFUUnxhwEOkEPHSsSyOa5SGJFF4f2LmhxEsrlN1W6GYhK+bFig6PNd1X41TcZ4Ag4QuOW0wVnZ2v+6uUjJmPF+gltsVLGlkX7vCMSExaTXjlfpg+7326n9rGqBf7iYA7nf7UFwu+Yay8XALg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOm614tl429iOQ+POVCVrJ+RGa5kuncI+Q8HcO7IgjY=;
 b=aWhCf4pvcWuZtAxJpYhJNsdGHRNcx4Xq2GIDgAp+YQEeaPXfXfYm3pfd9gFjduT5F7YS+G83RqsofFDKDdhgODOMDgs9VZlkBUI175q3OuNQsJKztox8EWaYkBL1e9XW4BIDAndGvsd4nNujVrCyrPz1FzFTERbdyOIdYX8hNBdIUJEZFFPuPBMM5f6JrclBj/JNeMvnvjTrlwYWQeO/Qr9JJskHe+VtnVq+REv+CDJWKGLXoj6mH4lpDGL6Swm5Yvb5snhe4cnjtCg/AmnujzYxIklfxesteVPfFsagluwixNkpAy/h1SJTFfq97ZC6mdqjaVpqGEMzROEQcZaZRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOm614tl429iOQ+POVCVrJ+RGa5kuncI+Q8HcO7IgjY=;
 b=xh9/F4dV8Q+6KGLyL2JqiiFElr9E5QDLwqYQYSjhIMwe35K9l/XpM1sAXaoa21tuNNBaYf2E1z4wqHv69qxHWhbbKHZL4mQA3LBgccycyCVjVq7rCAmDmPiUzk3l619NAWFecNmByYnUxF99UTlSf+pn0YSu4xkoxOkYqe/0UKs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6075.namprd10.prod.outlook.com (2603:10b6:208:3ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:16:00 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:16:00 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 16/44] mlock: Convert mlock to vma iterator
Thread-Topic: [PATCH v2 16/44] mlock: Convert mlock to vma iterator
Thread-Index: AQHZITojRp+rlyDyuU+9GjNxV6YrOA==
Date:   Thu, 5 Jan 2023 19:15:57 +0000
Message-ID: <20230105191517.3099082-17-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|IA1PR10MB6075:EE_
x-ms-office365-filtering-correlation-id: 85dca05d-b3f7-463a-10ca-08daef514812
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MygMY/kj2Nf5rt3LTfgn2mSk78g1w3UvaG5E61XgnX0SW5bUijhlVnKA5icbyDrurwVaozKgZy0BJ2VJJTLQ8w/+y6v+Gik6+lHL3P24921bJWsdJ2ZNbgsZsmIWxZQ1RJWhdMgpFCU7sZh056wGjmSgwzb3MTb4xgzTa95cMafqsTgIUVbS6AAG6XM1dRXOlpjCWcauA0kCYJ48R1XVi1lG1stWckFPSYwngB7sRMXb6K9uj3wG6s9auQ9J2NsN3Rh8zBLpsTZHpW3HQR9PmiylEx8+95gUyZ4Y0vHmG2IsDcTTIPBkmP023myQB3xQ5aS2KdLNPQEdMj65YECoYlno4MARkU50AvOVaIlWhEpSpba27glENNnkjqNEqboXUpsBySeCDFuv7RY/qaP3a5JNmTEnNSiTTBUO83b/Q/2UzyGg5rW/H3oakoHDYIPaOv2kxOdn+OppN0iTVUl+v6UTZkAD2xbz4zTGYhHxY2yoRpKLcHqIJnQm4WnhIYmvYAIHDCg/ocXrAcyIxaVN6tUIabsfpTQKfOJmzRPuuS/oGn34A4yAb0D9ltseu2aF9qrtDn1mlIn1WnhwKnjru4f/KWbrz7fHDBS4+mVf46LZDoE1GdK77kmSsLjiLhlRUO7SE+3YQVPRHTUXvgtQ2aumeh+4bZzYQZOc57nSNDGat5mt2fWQ1MFcicJ8DPe7fPZBCtEPh3UwDG+lgwBfzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199015)(38070700005)(122000001)(91956017)(86362001)(38100700002)(8936002)(2906002)(71200400001)(83380400001)(316002)(66946007)(41300700001)(5660300002)(44832011)(64756008)(1076003)(66446008)(6666004)(4326008)(6506007)(107886003)(186003)(2616005)(6512007)(66476007)(478600001)(8676002)(26005)(76116006)(66556008)(110136005)(6486002)(54906003)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TK8QCv5iWxa+J24swxMgongjgcVnPAc/z3dCdaJPK+85QOCT9aPNiz8bd9?=
 =?iso-8859-1?Q?Kv6IAPMGri43tYt1+uzWQCtxrFIJDr3dqAZDfo6ynUtQpSSj1B6hs0BrH+?=
 =?iso-8859-1?Q?ljVmrK/QA6fqMdB8sLlGa+5foFMHfpBzwvjpCdETzKUjhwvV9Xowjo9UP2?=
 =?iso-8859-1?Q?qzMbxVp10MJC6MXf8NswKPUR9js3eZLHL24R9Tl2FELU5lfV7piPqKIQHS?=
 =?iso-8859-1?Q?verS6TxnenJG/cMtz4tSnvkHmNb6Q15ZURhk7yaU8tcN+rJZgktyjHCQAR?=
 =?iso-8859-1?Q?VOnLWefHHcIzI6S6hYut+koPP4I+VFLM3Kvdrr29Qls2Cxgyjh89eKbzNL?=
 =?iso-8859-1?Q?WOTxb8vqGpCjLY2esZ/WgSApeX+lwzRLq+CQYgIB8J0ay/dFmgjWvVGEig?=
 =?iso-8859-1?Q?Ph+E2C3QLMCaZll9/hamTy1e/GG2ycIgyNET7DS5RQed9sYI3j9sPST2f7?=
 =?iso-8859-1?Q?YK/7uI4J5BetsOfxCUObkCqGmLPzH1HZpXPyV/VzgmifXk+2v5gRwJOFYw?=
 =?iso-8859-1?Q?r15IeHWw7Xox8SecHgE+btaMlqGsNh7dyGpmk2Jwd97eY8iJ7J00pnx4Yr?=
 =?iso-8859-1?Q?jazpjRsYzdU26G8OWR0OHz8DFxY6SvKfbHecf/2xOMi2+Nf06CSAsq4Kjm?=
 =?iso-8859-1?Q?+43q3dNbmZVhaa27wgY5lm+aCq+sgAn6sOqwGg1eQkruqhZ3SzCYi+iMOw?=
 =?iso-8859-1?Q?nZMW2HnfIcGa14dq0xbKgdYB/WX9g7SXj9mZAOr5yvmoO2VqmyI5S63alr?=
 =?iso-8859-1?Q?nM9nF2w518peF2sVDTYtmUSG9XIF1EZPBmojj90G/rcgFZREWwLFczjkk3?=
 =?iso-8859-1?Q?fMb4o51i18RcS12gEJEhxwhuNazFMK0kciXRuBYwAVJDHhpx1o5nrzmBYF?=
 =?iso-8859-1?Q?Tljuyls5zhKGssMgiOUUShDFhWIirl5KMKFHUO6g9ky+aEc2FwePE0B1v8?=
 =?iso-8859-1?Q?q/4trSya/IcvcInlBnmeiBVmhtpVLB1ZZLhGlC1Si+4jJ+OecXq4jWmSaq?=
 =?iso-8859-1?Q?HHySUn0U0QvPW5CzQrnmNkPrkQa+2e2bRWXgEnUNVUOMXY9W+v1uNOAOul?=
 =?iso-8859-1?Q?1SpOypJupSgWpn37q9CuYFSIkAjdlY4rSKZxfbu3uIvPWhk2byp7WL0d5P?=
 =?iso-8859-1?Q?wlY9doSTxP1v2fAC/cmtRCVCZR/m2bckwsr1ZF/pSM9zzCouiRj03K8Tte?=
 =?iso-8859-1?Q?BgTeMkQADvSNBu8iZoNknnVHoJpWlD0Xv4rAVfgh5txDQ/GlmXMbaMIDwD?=
 =?iso-8859-1?Q?IPDFcZ4hWrbs5lRuqnNfELgDJZw7UxPVSjt17UhvJC8Vog9HNS98tV0HZb?=
 =?iso-8859-1?Q?llvEmlys7pm1WJDT5/134qnVFx+3tdeu/PpQyrxyEtMtF/PpuvEO4Avffp?=
 =?iso-8859-1?Q?OKRUhlkE/n+vU+w2E0VcPEbIBNm4g0Zq3HxA66t2YUQETN71JQeKTS4hWe?=
 =?iso-8859-1?Q?KiEu/GwAG0rTZRO25+JVKV+pJapctry/8Fb12H5zqcnLW0RlQHZeIq2hWy?=
 =?iso-8859-1?Q?O8Bl4o7BFIFluwliU4RQ28IxmuAFdIV9Z51lRlWYf4LieqMIYToQIgrmP+?=
 =?iso-8859-1?Q?vxHR2IWMHak5gN6hX/Kfy6I2ReGvpZjmBb5xJDCxb4cSt1T3cJ79X3Lt65?=
 =?iso-8859-1?Q?9EYfjR6xRlisHag9OlawukElEi35C4t0qma5RBUmlqvkG+HTlr+o72TQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EgoUwO6bDm1yd6r6ifB1PFJDmfRDF+RQeKboOr50edALgHdOfxi1qaY4+3uQRsa/NlNZ7hMPL3TNTkD0/WPx2oHDaLUSVSbdzQclOPPW8uhbX8+MOpL7cvqEX+pXHNlHKEcn8S4OHqTRJeVHkFBvBIbg1wbJF31um/lbJ/rO9dcZrPhtMKK4DalGi66gxiitfwLQLurXXhEaY364V3H2tA3wR2zdqMlsBZ7H/slBU+Mwj+i389gAF8f3fmTQbj+kiR5M9x5pLife0L649uf+jfLqcr7ZylyUURM/9zvVYgbYS3JCfWtUCfYM2pWbk9ykGF1r7QXuGzhTelbwpfU10jjix4V6ilIyHCvkKlvzDaSNhQ/V2fQQlTh113J6p83zR1hpUvjQZfYFhP5Zi2GcJLGCQb0u5OU9eMm2NipdVEfDJsePUqJlVP2WCkEyj1Ui67HGDiQ4Nx2JvgA5TFtHJO0qm7ynpBMIWPiXwfZddWOKHR3c3Fj/aIyn6FWTeD/q3fYoRw0uJL6Gyi8PAyYriG/rnKYL0WEcWPGqIdtZbF3JRpvasVcFD3Uuojl60YZ5SmgNZVnHP6OWfE4ertlNUG9b6DGRdiJXvLMMaOVngStvz5Wgki9bDYjEUs+DuZP7GnQ9KpOM0IvSzzl2Rgiicj3ONp+6MmSf4AqJsLLWbL2pEQXzLSP0nVHaFWp5oCbSYmFsF6ksK1Ij0UWFNeqFtmofTBHnfcInC3mLNi2WUxJLY9NHifgAwNdPXOGbawJ/oHI1NeUJ1Lxhf6GByEOC0s8Nvf2LbrhNXFM07/DrrMInvc2GplL08WUx2GbSh7U9mfmOiBM4+9EfmcDtQs6SnIqwbOCmNRGqW5pBNZYcnQvAR5bHyX1GFASC3rgo6w2SmSLRlRhlp5pTG5DOKnABIw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85dca05d-b3f7-463a-10ca-08daef514812
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:15:57.3444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zDfNGMIb2+N+MeQjqFdw2+jwMU7InTBozQDJuOcmv2hMs5mv0a+KMHdtrJGMzKs5nzcnwUuAIPCmExDu0WOZzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6075
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050152
X-Proofpoint-ORIG-GUID: syyomKtQtid0ioaNdMUt3xTi5XW06ZtO
X-Proofpoint-GUID: syyomKtQtid0ioaNdMUt3xTi5XW06ZtO
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
 mm/mlock.c | 57 +++++++++++++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 7032f6dd0ce1..f06b02b631b5 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -401,8 +401,9 @@ static void mlock_vma_pages_range(struct vm_area_struct=
 *vma,
  *
  * For vmas that pass the filters, merge/split as appropriate.
  */
-static int mlock_fixup(struct vm_area_struct *vma, struct vm_area_struct *=
*prev,
-	unsigned long start, unsigned long end, vm_flags_t newflags)
+static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vm=
a,
+	       struct vm_area_struct **prev, unsigned long start,
+	       unsigned long end, vm_flags_t newflags)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
 	pgoff_t pgoff;
@@ -417,22 +418,22 @@ static int mlock_fixup(struct vm_area_struct *vma, st=
ruct vm_area_struct **prev,
 		goto out;
=20
 	pgoff =3D vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-	*prev =3D vma_merge(mm, *prev, start, end, newflags, vma->anon_vma,
-			  vma->vm_file, pgoff, vma_policy(vma),
-			  vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+	*prev =3D vmi_vma_merge(vmi, mm, *prev, start, end, newflags,
+			vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
+			vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 	if (*prev) {
 		vma =3D *prev;
 		goto success;
 	}
=20
 	if (start !=3D vma->vm_start) {
-		ret =3D split_vma(mm, vma, start, 1);
+		ret =3D vmi_split_vma(vmi, mm, vma, start, 1);
 		if (ret)
 			goto out;
 	}
=20
 	if (end !=3D vma->vm_end) {
-		ret =3D split_vma(mm, vma, end, 0);
+		ret =3D vmi_split_vma(vmi, mm, vma, end, 0);
 		if (ret)
 			goto out;
 	}
@@ -471,7 +472,7 @@ static int apply_vma_lock_flags(unsigned long start, si=
ze_t len,
 	unsigned long nstart, end, tmp;
 	struct vm_area_struct *vma, *prev;
 	int error;
-	MA_STATE(mas, &current->mm->mm_mt, start, start);
+	VMA_ITERATOR(vmi, current->mm, start);
=20
 	VM_BUG_ON(offset_in_page(start));
 	VM_BUG_ON(len !=3D PAGE_ALIGN(len));
@@ -480,39 +481,37 @@ static int apply_vma_lock_flags(unsigned long start, =
size_t len,
 		return -EINVAL;
 	if (end =3D=3D start)
 		return 0;
-	vma =3D mas_walk(&mas);
+	vma =3D vma_find(&vmi, end);
 	if (!vma)
 		return -ENOMEM;
=20
+	prev =3D vma_prev(&vmi);
 	if (start > vma->vm_start)
 		prev =3D vma;
-	else
-		prev =3D mas_prev(&mas, 0);
=20
-	for (nstart =3D start ; ; ) {
-		vm_flags_t newflags =3D vma->vm_flags & VM_LOCKED_CLEAR_MASK;
+	nstart =3D start;
+	tmp =3D vma->vm_start;
+	for_each_vma_range(vmi, vma, end) {
+		vm_flags_t newflags;
=20
-		newflags |=3D flags;
+		if (vma->vm_start !=3D tmp)
+			return -ENOMEM;
=20
+		newflags =3D vma->vm_flags & VM_LOCKED_CLEAR_MASK;
+		newflags |=3D flags;
 		/* Here we know that  vma->vm_start <=3D nstart < vma->vm_end. */
 		tmp =3D vma->vm_end;
 		if (tmp > end)
 			tmp =3D end;
-		error =3D mlock_fixup(vma, &prev, nstart, tmp, newflags);
+		error =3D mlock_fixup(&vmi, vma, &prev, nstart, tmp, newflags);
 		if (error)
 			break;
 		nstart =3D tmp;
-		if (nstart < prev->vm_end)
-			nstart =3D prev->vm_end;
-		if (nstart >=3D end)
-			break;
-
-		vma =3D find_vma(prev->vm_mm, prev->vm_end);
-		if (!vma || vma->vm_start !=3D nstart) {
-			error =3D -ENOMEM;
-			break;
-		}
 	}
+
+	if (vma_iter_end(&vmi) < end)
+		return -ENOMEM;
+
 	return error;
 }
=20
@@ -658,7 +657,7 @@ SYSCALL_DEFINE2(munlock, unsigned long, start, size_t, =
len)
  */
 static int apply_mlockall_flags(int flags)
 {
-	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
+	VMA_ITERATOR(vmi, current->mm, 0);
 	struct vm_area_struct *vma, *prev =3D NULL;
 	vm_flags_t to_add =3D 0;
=20
@@ -679,15 +678,15 @@ static int apply_mlockall_flags(int flags)
 			to_add |=3D VM_LOCKONFAULT;
 	}
=20
-	mas_for_each(&mas, vma, ULONG_MAX) {
+	for_each_vma(vmi, vma) {
 		vm_flags_t newflags;
=20
 		newflags =3D vma->vm_flags & VM_LOCKED_CLEAR_MASK;
 		newflags |=3D to_add;
=20
 		/* Ignore errors */
-		mlock_fixup(vma, &prev, vma->vm_start, vma->vm_end, newflags);
-		mas_pause(&mas);
+		mlock_fixup(&vmi, vma, &prev, vma->vm_start, vma->vm_end,
+			    newflags);
 		cond_resched();
 	}
 out:
--=20
2.35.1
