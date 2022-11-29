Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CFC63C581
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbiK2Qqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236143AbiK2QpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:45:23 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469FD54B36
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:44:46 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGPitf017353;
        Tue, 29 Nov 2022 16:44:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=XK+SWl8VPkKYLUcRoYE4/SOdllcXeYEOwMDiLDbC6Vo=;
 b=kSH0wy1zjn8Sjb7VzTyTtQTAQ9n6c1swSGpu0fBN6SJwT8nkzlc0uZr+RfDInYmuLo5q
 2ZHyYNjyAM1njdLG7LC1QCGB3l/SOcCKZHkJ3be6owb5SmrugypM948Zrx6cJ7gXAl58
 eUyphsg37zuXP4e1vETWiTK6GcRwwOVAcPUFDMei14jrNFacIzMNGAJiNQgs6QnlfSeM
 cflG1VlZmdnoIhaARp/4wrjrCzNUxirk8cT4+RfeWrN5qCut/L1mp6b/rUsyVmnofHpf
 DM84uda6VOdleoPBdsYa/fK3AwsGrYUmIDn9JXt/mdguOVUKeYuULct9PGhGDkdrRVpy 5g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m3xht6hn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:39 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATFhsPq027963;
        Tue, 29 Nov 2022 16:44:35 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m3987f2au-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MskjC76/FdKRwxLhUo/Ix0wivLhN3FrVLQVZwUdpe4WFIM82cuAnI+Eq84Mqqe5L7VEfHQDvrtua6H45wOnAMM791Av3lAF6orwiIc3gZi4+8KQ5YpAwPGkC1lKKJGIVUv1T4fyjpMOfPAXVi0WoS7mL7K5QNWCVZJjBc78sDe9nnolp+c3iWRfe6QZQTy+U5E8afs8gIAKDDwYDEDvD8QsVjYLgA17Zq/5URWsgbiQuH9mJTc2B4zvwsA2k+X3IgU589wNr4LdSdDhsNjUsA/i8ULSpOqOerhXEDhUGpU2mAi5aDZkp7GpzfL1gLxn7KFm2UwsECqHzbq0kQItwvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XK+SWl8VPkKYLUcRoYE4/SOdllcXeYEOwMDiLDbC6Vo=;
 b=WjvWFDPq4UX7o58QJvAirU30ZFKrJP9EoReVdmlXB+6DACa/E5NuSX/1A97Gc6ejK/lmKoXyYrRfDL4v7XdMV8KhXgiJ2Wp8s6ZiG1PkjEjOC6FImTgSvOSQsB45TOYYJfVWdPgPOzt/ikumMJY7iFsISC1k48FxXd8kFMSDwdmF5isNbGIlh3CXSVIjmjXSEedmE+9mmOznTjh2sv9yzwaKKZKmPq3uvFldkOJsHKGTBD0qvocXgwo3FLXLt0ED8pglNl/Dk5lnbN4IvbwuWUPoUF4fnOpSeFWoi/KMNCb/y4gS6BJKDqMsXbFC/doKM19ab1EbxLaWyI9RBNuDiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XK+SWl8VPkKYLUcRoYE4/SOdllcXeYEOwMDiLDbC6Vo=;
 b=0ECCfO6OZUhZL2gQ2zT8BdzbqNzqQrPb98z2mmY5xeDQvwd3lt0tZYYrFdiNMH38AoImyufy6IWoYQ5aTgVKs3sbizfxQF8IMAVYk4tjDRTj2OmnOmUxWlYm3o7KsXRzRf2VOOKGzgacQ/MnwWNp/S52BUR0+aPSCZWNYQe6ErY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5788.namprd10.prod.outlook.com (2603:10b6:a03:3df::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Tue, 29 Nov
 2022 16:44:33 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:44:33 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 24/43] mm/mremap: Use vmi version of vma_merge()
Thread-Topic: [PATCH 24/43] mm/mremap: Use vmi version of vma_merge()
Thread-Index: AQHZBBHa+cUerEdvF0eS+Eo2Wg1pFw==
Date:   Tue, 29 Nov 2022 16:44:31 +0000
Message-ID: <20221129164352.3374638-25-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SJ0PR10MB5788:EE_
x-ms-office365-filtering-correlation-id: 97c1cff8-5325-4a2a-f7de-08dad228fe34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ST/c4dhHWrkZDhf/xEq1emPIoektgK/k7qHR4dsFupNG/OE7ON4feMwXQyahHKCojbX9AIQ5IIdbcLlp+wRDqndJCGzMxrsxcMFLoGhKdpK9uMf6oDMybIE/J0mrD6MPwpUw+oEPJHTMppWwwsr/zEI7HLKE6c8Pgkdms9RsOf49Yvf/r1qcUGn+cwP2IYfkKARAga8QatDuG0IEOdCwjlwi5kNXMwjvG8W4i0zbHDrwPKAE4sLp0AMrt386kpU2OKio5a7zBgWwaqTTAVfEI6WiASHRfWHSZQLRq6ZEw6StnCo5DgcMK0oFGb0yYz/4UxJakUV3Gjk7Er6eNoiGKwunR7pL+jU2WZzaeVXFH4EPtzWBamBMZ+ejEKHxFZ8LXIgswfw08sOm/Ke5JiKOYxVYlHxxBplGaN4ZhRMigdsHCxM/Yk60Mgv+XJZRhArLG0UNlku8KFC5UMQfS3qfOp0D24JxnIJeExAckRbudXWf4Leu3OTAvxPNypuQb6AG8r0OiJdGEMmVM0c+zLa2Qes2PX/Oo2CyFlOw8pRd8gH0enxfWg250QUi3GaXXgjXTPIt/yHwEAwA81q2BhAbfPPjIBNpWGQAIXqK6Y6rjFSnrTqNnJ270K1VoY2pCUwQacLiNz70TTZBi0sKwe7QcV9N3st0s2i0nNx6MTceuXVflFpcqWSOv5Dg+VY9QTTdKb+v9nBxbrZaHg4zUsdCzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199015)(2906002)(44832011)(41300700001)(76116006)(5660300002)(36756003)(54906003)(316002)(66446008)(110136005)(6486002)(91956017)(66946007)(71200400001)(4326008)(64756008)(8676002)(66556008)(8936002)(66476007)(6512007)(6506007)(26005)(2616005)(107886003)(186003)(1076003)(478600001)(38100700002)(83380400001)(38070700005)(122000001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CRRAHvKofV9VnTGwQed+vr3F/Gw1lkdV/mt3EmtMOr/0TLaEGZIFX9e53B?=
 =?iso-8859-1?Q?LH9XuQ4Z7Wryuu/tZV9OH1XFrp0yeGkg+wbI1ytwRX8ojAmRzQju2SKok+?=
 =?iso-8859-1?Q?vb7s+OEl5icUhk5ruCLaWhISN+JdVDB4psOdLMfbKRfzW7N0Mgkg0ZIWwh?=
 =?iso-8859-1?Q?f0uX9aIiGhkpjFZqub4haMlzVVovpqOutzboMrZEyCd1stFBbEGq2HCAiO?=
 =?iso-8859-1?Q?NFRju07cVKSOBxbyv7WZO2EiuptGaHvFWd8woGQ1BulnaZghWacf/nMGKB?=
 =?iso-8859-1?Q?I+LFwLUVpmZ3PxBkfNcGtuRItBCAmnf4OymBxo4GkPjqGEOKeemT13f/3l?=
 =?iso-8859-1?Q?tVFT6LlAd3HCcfnUo5zxv1NXtB7pE7zFg/Hqyv+VVr4nNrE+mJEZUpjxr7?=
 =?iso-8859-1?Q?X6u/8LU3SSuCnL8pPBEPeHctImKYW21R1KnRehMaldM12mac0MCG7XHuE9?=
 =?iso-8859-1?Q?+5o621HL0RlriP1Z8tuvtmKg3sebfEgQhsYQwmKr5nGWF4sTzTNvaky/k5?=
 =?iso-8859-1?Q?k8rWS/ltQqtCerEGfathYRfjgBBESUQfv63zu4zJ3yTV490rUD7B2Eyx5J?=
 =?iso-8859-1?Q?0FG3ko5t/MxB8joWHIaVFyofdPXO1cMF6FZmDDuNMUJeyJPACotQp8f/ys?=
 =?iso-8859-1?Q?uwvmsatEZeNLfcj+FmHy2owduQeezDL/ibIlLHf7+Bjpv7dJSOKwgTJ9K7?=
 =?iso-8859-1?Q?egoQcITg2Mg+COy5O1mc5k6GkQkF/f1NKLhUQ3V9GX7DnYkDiGGnzZXxzU?=
 =?iso-8859-1?Q?ZfE2zh03YghfPkiVAIQj9ZH2eV7AXuqon/AgYkxUzn5cU3h3tsjAG78kiT?=
 =?iso-8859-1?Q?CLj7FwhFyLmXmmKgVkx2JhWNmtFwkO/5xMD/iLdy3X6cpaDlS8/YT2J1KP?=
 =?iso-8859-1?Q?ZgoM2A3IPNhwrlGtS58ux3OF5JI5WIZYtgEnxuvrCa9KOrRxhx4bRqtr0M?=
 =?iso-8859-1?Q?Dl4liWxn6YSJrUqdOkFeiajNjon1ekc1XVofPoHfbHKb2SD8LUGcR5Aiu5?=
 =?iso-8859-1?Q?u6JuKSaPSwwyt5pts5Ss5tVJe/gudGhdZXucR38ukNcjA4p9zDm+Ox0LI0?=
 =?iso-8859-1?Q?gdVWEsWyD1sWnQJ3ZSeEE4gCVQBgHPo9wxCN0KcGf4QM+RA2i4z+VzmrJi?=
 =?iso-8859-1?Q?xxd1PTeMywdBO7QrmyE4hrTeJKrHfytsT79aq5z6+764yERXvfkdr3yuL+?=
 =?iso-8859-1?Q?gcTDWoT21kKsPwVjRZNQxMsutAGWaFv30pjCDbJYsDxM2TfA6oRzplIw5U?=
 =?iso-8859-1?Q?4RL5dsY8b354NTiEjdi8jiojvBkX0PjxlJS6XAQeyyfRO+7V1uTXmV+x/F?=
 =?iso-8859-1?Q?pHbzoQrrIb4yF4Lg0G30KZUT/3eMSxusRUT43ZF8Kk+XS8nCO5fAez9g7m?=
 =?iso-8859-1?Q?6EoauFhuNADtrk2TWAT2sbBwSh0IgW9uEFJPOibJMGlk/cyWPHv34duxXq?=
 =?iso-8859-1?Q?FKcR5kVQUhoUJO3UT0k5t9EIqQ8VYb7UlPiAkLY4BtvjaiPEeKznc8Rj8j?=
 =?iso-8859-1?Q?DFp1sds/Z1UOMKuOsTXGebm+N/DhX+wNb6V3HNzrL8NDcD2GCXI3OIr/ye?=
 =?iso-8859-1?Q?k85tr4clT/RFAXIswzW+rgQvXzRhNzbxEyKQZ5+AoaFt/f9vXNLHcZwDFj?=
 =?iso-8859-1?Q?ub+c5GcLi/tgWc3UlwEo8mLU1khqKCYbXATGxZikv6hXuKI32tAdYm2w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9MrnhmS7q/Fn896j14ypTK4HnlwYFshJijaAQCkYJncDaV4IMtQXkk8WMQ0iw66pW+heG4EDPVkb/hqFeJ+hfqkl30d6xNRue4vGLmhE79nycph8wVskQVa5ON+ic4XSbCJxxjQfPET133Z7x7oqMU2OdBz8Qcw+rmUcQUN5LKhSZjRF2pgIpwjGYGTDOZOCVHmFEtqAc7mi0vrYYntJl8LWe99S7I01E3026jaIH+yEu/E+4+XN9OBsGgBH7E9IM75QDnDsommnPD6Ltx3eWau2iVxbv5MHbWeUoNXgxZYnUev1nCzSnVs0E7JRnQpGy4VS+YfxocQC9Y8pBHk7qbeEVhCRN1HHo5lGn+mSHRJuWEuOqDhq+cfY/5G0bLNC+bbvo0J66FVs5o+/NUZNkvByLxN44g75pTXc3sa4/A9L1kMd9wQKjthCCvuoFjjDmJIN9bJXGtoTfAKXRE+/gZ5kpKySdvOg/5mF+wzb7W/+ypVIm2aIuk0DUVBq+Dg1D6aIz3UEwJqZVGehFtzVnMzFV331mCY1VE6xolneRbEUgvnnFRxkK5HibhQx83pbaIw41YdFfKMY3yOpqMpueitNDCeIqyVYNA2LqNwy6+LsRqnzaZd23EkxX1b/JNpTlRdPncsPdRjxhEcnIipsoULuS1f1e+NUHOPoLQuyBHz7x317+dqQRV2exfYaxHVg54CGYOD3WXE1NWUTfotscOq1Xn9Ahkh2stgWq0LydS1lUhYWNgkOMrIh8SvR3n1t0jMVKm/I1ghaXnLRfFaTeHoOCpPnUguUp858kHZrVAQybsZjjnoT/Iy3XBdI889Yc4olF5RBmPcKtOTWQPokoYAMKnXevM4WQmtN6VGfDuYc7P09bONPWAmj467vM9QwAFoNU7Y40GuRjTKOK6d8vw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c1cff8-5325-4a2a-f7de-08dad228fe34
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:31.0663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hMdEL/Rl7D8Tb6zEVGAYzN8TEZhPwi3adYdyHFPzgXFJPmmXy8ygesj8qL/TNHzsY61+6a2G0GsB6e2cN5Mobw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5788
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290093
X-Proofpoint-GUID: wFcge61FZHgMrvavmI-aZWitDGfNwN2U
X-Proofpoint-ORIG-GUID: wFcge61FZHgMrvavmI-aZWitDGfNwN2U
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
 mm/mremap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 841fcc70e017..7302a71058ce 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1017,6 +1017,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned=
 long, old_len,
 			unsigned long extension_start =3D addr + old_len;
 			unsigned long extension_end =3D addr + new_len;
 			pgoff_t extension_pgoff =3D vma->vm_pgoff + (old_len >> PAGE_SHIFT);
+			VMA_ITERATOR(vmi, mm, extension_start);
=20
 			if (vma->vm_flags & VM_ACCOUNT) {
 				if (security_vm_enough_memory_mm(mm, pages)) {
@@ -1032,10 +1033,10 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsign=
ed long, old_len,
 			 * with the next vma if it becomes adjacent to the expanded vma and
 			 * otherwise compatible.
 			 */
-			vma =3D vma_merge(mm, vma, extension_start, extension_end,
-					vma->vm_flags, vma->anon_vma, vma->vm_file,
-					extension_pgoff, vma_policy(vma),
-					vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+			vma =3D vmi_vma_merge(&vmi, mm, vma, extension_start,
+				extension_end, vma->vm_flags, vma->anon_vma,
+				vma->vm_file, extension_pgoff, vma_policy(vma),
+				vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 			if (!vma) {
 				vm_unacct_memory(pages);
 				ret =3D -ENOMEM;
--=20
2.35.1
