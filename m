Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A6A65F455
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235783AbjAETWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235537AbjAETU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:20:28 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EC46E430
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:17:56 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305ITcfs025538;
        Thu, 5 Jan 2023 19:16:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=2xnT8FDEwDbbI1gHr/DU50xezL1IoQwENxQTeCIHSGI=;
 b=JEk8YkRnS1VSKYYyqtahkSA/3IQ9x9ED5s8fGQRVCecJU55ar4ZmaauwZVD1UIGmULHN
 gUAdRe+dg3Fc69kOHQ7wAkXKeS3O6M7Gb2k98pixxDjdlV5oYsX1YRdtv7YdynbjCgie
 ZVpWaapnQOvShV/QXqlSEee+A+KqlEjcyR7lJIArQ17dogofwi+UXfk6qRmmPlQylPvq
 VE6FL+tgwF3bxSnCG9pFEUxtZ1b/jENXh4Kum1ciPmnPm2THKGtn8OUsehyGfF74fwZU
 Aj9dumD38elqDz6cHzd42uF224J3L2oWTI0KH9RjXHQZwHWepDDJH+9bCxsPh7o4PbD2 eQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtdmtskwf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305I1EPq033688;
        Thu, 5 Jan 2023 19:16:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwxkf7u5p-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhsI0PqF3xAfvg/XVYJOsaoX2+H5fMVP74FyDAGvoT/MxzZvmI7VJilZ0LzbLDiRkHkx2cr7VsfJwkVDAuZ0m5hqsuFOE63zJjmwrYQ90ypddJ3hHVoF3t735DJCriPgiHkF4m/qSCOAbl76CaQgzeSo+T5K+EnFuugXzya7/Zq5h6RPS/3gVDEJDB3KeleJWr0ouaBBmhVfxQlysDlhXyLHAr8jhEOIuH8VvYjk/HnoK1MdhAH8wzAkFMK/JbEEwVorJeY9ugsBC49S85thxLW/hld6hmBTL4Sr7qEIYf1MS7BC8/UmI3+OJnC49sXfSZGP4PjjVz+qScFjXwLMuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xnT8FDEwDbbI1gHr/DU50xezL1IoQwENxQTeCIHSGI=;
 b=DC/q4ygMyoFAx+8KMKzflezsdrRhgyZdkn+LlFQxQ2OHtaMtneX5oXi0nq+VVSZ+8MVpa5S4B1E5gxBorTOUNHRxQI4AuQurNhtXnQz9jRoCGf8blKV0l5xwBa/27uNbTJUTnsIfXRbqN1/Nbm4TZTNNIvTOcMvNKGjfryFpjo8Gp7k4FyfRrqVENc52/CiONpCcjRZMs7G87YhwyzCLoimlhGRAY0GugHCYLylnkhtLALnrdkkgl3sw/WlzCx2a7DqJoRtiGqYPcpu6sJxtgNgBytXFmzNxlndZ77RW2HvhdPLN/14IVBhSJ1gpQdgal3qbuxcpCWJ1WXFa2eh4hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xnT8FDEwDbbI1gHr/DU50xezL1IoQwENxQTeCIHSGI=;
 b=AWYbyuDp8XB3OIlFBG/kHrHXCpeGAXZT7U6Hierl1G8Kt0hU7OvPG+cmykutIYR2TwczbmRF2J4sSySSQ+qDo+dj/HA/saDoQ5uMaQnAg9G22viBeiQotIf+8xMPgJx06NJxzzVWtejXeRSQuO/sud/v6qI7ZSGfB+UYeMRGsRk=
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
Subject: [PATCH v2 40/44] mm/mmap: Don't use __vma_adjust() in
 shift_arg_pages()
Thread-Topic: [PATCH v2 40/44] mm/mmap: Don't use __vma_adjust() in
 shift_arg_pages()
Thread-Index: AQHZIToopuk2mk6qoUWd7NiOUa1+Gw==
Date:   Thu, 5 Jan 2023 19:16:04 +0000
Message-ID: <20230105191517.3099082-41-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|PH0PR10MB4791:EE_
x-ms-office365-filtering-correlation-id: d1e5ce4b-5cf3-4797-4bdd-08daef51604d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aYIZfNlXES57fibzx5iXmV8rEa7iNPzEQv3Izhg7kWd9BFk7ruePb8+Yh0gaGsFstKMiyuML+MS8uUh2T0z8f/QxIOmCvZbMok0wGJKnpk1b9VYpUzKTAh3nFbfA6X2xoPpAd8iORy3GBLZgDs8Wdt852qshAAQVqdK2fpMQ6d9EeqU8y9hAcdqGeWqf6qqr5fdwE9I3b3zjDl1gJglu+su1C4QDSfs23enJjoTmIJFxMHewBg4WRHpbbT25eB6Vp+14LyrqdNbqWb44ZPx7QXpb26NTn11zIQgEH0Cacu+GtI1kktwZ+xf04ma2dkpAKQ8XnEw3lLBznD3B2eHNKq2XQyhbX2gjqWPqP4epRaw5s6tAtRqJlrpdTEmtw750sZSOV1v68q/Qp9OzLH4/lylOE/hiGegmQM8f3vRhG3I2C5nckGAJKP1UNSJHzaEZL8V69yvecvmu//7TWXlQZf4ZBS1MNss+2qv349wgkuVZvIwupwn0vd3Yvrnf7fgzNVAwg855xxms6imnyYDCXlcypBZoeOjikTnUp6/OJNPlSxCX696en1neP669L5wKFkZf31PX3eT3w9kg8I/4t1XiizN0T+Ndj0S0NiZ14AdV9etwj8kan3vg0vYwbr2uXdS3cLh6paTE0z/RvnjhQbrk2gYeYby9ZPMq7SRS39w6IDgEUmgOvxSufsmiZbDtSd8FJkJ72UO3cwsbUte6Sg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199015)(83380400001)(8936002)(5660300002)(38070700005)(44832011)(38100700002)(36756003)(122000001)(478600001)(107886003)(6666004)(6486002)(2906002)(54906003)(110136005)(6512007)(186003)(26005)(71200400001)(66476007)(64756008)(8676002)(4326008)(66946007)(66556008)(6506007)(91956017)(76116006)(2616005)(41300700001)(66446008)(316002)(86362001)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Wnqs0wyi70J7iggmclCAXKUGYikNKUVPxR1e4ugXOgKkdyglCAWuuxaSuu?=
 =?iso-8859-1?Q?QRCuj+kruxEV57SlRivWDLxZer5zSd5SuSMHl9De5DTjiMQ8atWzePRaaB?=
 =?iso-8859-1?Q?ikSX7XriznlOqT7H1Y+v4MrYxOsg/oVyKO+yuGTO6+aUP0jzhyley5KyGV?=
 =?iso-8859-1?Q?lEio9+uv6JFZe55SQ/FWYW40y4SxFGLWFj141+dsdFPc5yY1fytZOgI4+u?=
 =?iso-8859-1?Q?mLYoPgVT3oskMJti60PoB3CI1OlrhYHWk28rH+nwG1+skkuCPizUXJpNF5?=
 =?iso-8859-1?Q?RzkUULa2+d4Bk1h4cJqHQtQbryd1FkBQPisMBz1dm3QS6Z7psn3Xlu0B1R?=
 =?iso-8859-1?Q?iwFmwOy77WGU/Jej+iSiqgIvjqeD3T5QClvO9ujCzpROHtKewllKNZkHlW?=
 =?iso-8859-1?Q?9cKihvUqmlT2V5tv/K54w77dxNlUbRBnDDCe2suIuhgOEmtK7kQwxAycoS?=
 =?iso-8859-1?Q?4q835eQMVPnXGPUjREi2TKCFyL6f8DhuxIadSIJ7yebwHPOFqPGC8GRkWf?=
 =?iso-8859-1?Q?yEjQiQkpbnHOGTsFyqMbCu64XGiGaQO58Dwiy86/JacRnlfTStOBBDm8WU?=
 =?iso-8859-1?Q?girBv0R7zvU5qltF2O8HHM+JKUJbKI3tGkL2WH6Nn2eg3EszG0Q8XHqAwp?=
 =?iso-8859-1?Q?HmT20xH2NuhWVXHZahMY5ini5wvBTw2ss0wDhlT2f691Ls2EJXmubQFoqA?=
 =?iso-8859-1?Q?xrobL8N8EkW+ltW6tC28CmViUfGeVh/b6bbUqC59XHCXaVpTfR4Z4A+Tqm?=
 =?iso-8859-1?Q?StleEYaIWYY7UgJXZ+k1qhr/pR4ksYu30+sloCqmZ+kdrSGAv+0EgGQKa+?=
 =?iso-8859-1?Q?uL/62sPbAH8GPWG66jpXAjnx9YMv1DcT8LHGZeXEc/CQlL5MyUpNGCUH/I?=
 =?iso-8859-1?Q?akj4ADFZVai5gXAw8Y1F5OdFxjWspOMy4DL3rDXScq6hIO3YhcRhN0NrA9?=
 =?iso-8859-1?Q?pbCfeitm95hci0WB/Dla57b2x6TSgpSGyh3DUvFIwIgkIidkf8Qv4pmMC4?=
 =?iso-8859-1?Q?HaBiNQFJndDGAUJ+VMzQ6o0mGv7yEFSAQ7GgSJWOU0OPpYT+bCtcUooOZv?=
 =?iso-8859-1?Q?lxzwEBROLQQnHRsYdQreAm2f1TbNqWNb2jDjUg8xIQ7RgWj5XRN5bsgIP2?=
 =?iso-8859-1?Q?nPP5coGp7chyTt8F/wv0kr1K+wnnuLitKJAMv2dnO0EtwDBWl674ShPx8L?=
 =?iso-8859-1?Q?0n/toOUJSGtwI/5h2DAAH4fYtgVEpGJADDKpg1A7Z5hRIo/YA1NbbsZTL7?=
 =?iso-8859-1?Q?89P1bEBCmvWqcN+K3kpluunTjGLRNjBm/uGYdoa6o/FxbLM42c8tr5nj5F?=
 =?iso-8859-1?Q?2LTpB/OEJQ/dkpN+8Mhgs0RjYO5XKquneN+zHzoxSB5FFb+zhFS8/rfcBW?=
 =?iso-8859-1?Q?9sPOeMwz1f2JSA30G1e5lITW4g3McV+2cuVHOcHJAQbgad0eCKCMDepi6j?=
 =?iso-8859-1?Q?CIZOGZxR/2wHyoeFq4vgkV2x5Zj2blV7bsAwK56LEjFxnpiopoOt9EpDrp?=
 =?iso-8859-1?Q?xZ6l5Fs7x3voKm4RqZs2rytXYT8QJVZbBqG6IzJLvIETakAMOpfbyexLxT?=
 =?iso-8859-1?Q?nFyoZITecXrw0w18Hb0Bhqsos2fOE7HMjWekmGSjd1k5DTMuptrqGqTa/u?=
 =?iso-8859-1?Q?YoU3iPldJ5+3ExUy07qN0eQnvBtv2hJ29iBM7XRTIODq2VmjMTQBhWGQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UxocfaK7n5LAU65m3m56MUdXNb12ffJbOjz4TpjLN2nzgbgxeXrFHG44Zj4mTeSDw82DxOTTKo7cP8ciFfNV4a0GpAdqqhCbfz8zYZhcXoF3/XvSq4aRngGHfsdwqqbiJqKDr7b38f4+6Yu0NkBwuebVCVA3n9wc3ZhpS5vM30lnSdt+kAKek0+iU7Yt9CvTnoQRdobp2SZDEaDZJeeo8dSORKeVlXk4GEhrypYelBF9Orn+ThMWuvGxg8uouQYp8QcMOjqokaIZ2BvllWp/POqELzRHfgQpcRQ02kqTjBd0qvqXFnqcH3NZnsWMNPO6qnEBgvnwD3Wr6JOYSZfmPh+aMQAPl/IoJfk2HOt40om/JukCteZloiRDXJhyJemS1Yj77UinhhkwkI9X/+T+vijGGd6Ad0jzYEVF2n/CP+g+J/HPLAErsFoRiwNypEg++3S1uSjiIK1saeLnE7Em4zo/BfWPaRCHUFSKLXSUUE6xGo/s+EzRaS6vV+jTNNBvTvkUwZri1T1bIPIum+Fj220S8PWQJqLZKHd5QzV9G+Ms8Hr5DoTnwpNPRD75ECuWlGDz6mhSeiI6FzV2vC0SIfxyQ7HBU8N3mM6UURrxzNCkGr1VDtEXWLSNX+5UltnzuObUPZJSAanB7BYR0CylcmdzETtcnIlW91fMWqm6nNdtA2dT9PW4x4dWF7+D5xMSPJgW/8YRJ1eFYLLmTSLyg1v3FUP1AueXALySwJfdZraoX0DR2n/z5ueRFoOtza8CDwm/mvVH/sFxnKczQTJEVg4uNf/lYf8Q4JHkB0V0K6R73VI1zUhH+1PIlnQttHuKXJUIfPIVud4YQ6m38L69+6Bti7UAEqTXuUb7d3Xj2hUJJECrfbHm6nxdUpuZNYzQwB5TUQbDJRsVnYY1vlbPhg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e5ce4b-5cf3-4797-4bdd-08daef51604d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:16:04.8907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sgjWQgwwNcHF3538xNy+ap0e1x+abymr5fnvcTlIQBtKG/JSQ9Rwtk6J2Z3VX5v45LIarvbwdDbf4+IWoSStHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4791
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050152
X-Proofpoint-GUID: gwfEMqY_5xVYKdyp9DUmco-nviV0xl_s
X-Proofpoint-ORIG-GUID: gwfEMqY_5xVYKdyp9DUmco-nviV0xl_s
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

Introduce shrink_vma() which uses the vma_prepare() and vma_complete()
functions to reduce the vma coverage.

Convert shift_arg_pages() to use expand_vma() and the new shrink_vma()
function.  Remove support from __vma_adjust() to reduce a vma size since
shift_arg_pages() is the only user that shrinks a VMA in this way.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 fs/exec.c          |  4 ++--
 include/linux/mm.h | 13 ++++------
 mm/mmap.c          | 59 ++++++++++++++++++++++++++++++++++++----------
 3 files changed, 53 insertions(+), 23 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index d52fca2dd30b..c0df813d2b45 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -699,7 +699,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 	/*
 	 * cover the whole range: [new_start, old_end)
 	 */
-	if (vma_adjust(&vmi, vma, new_start, old_end, vma->vm_pgoff))
+	if (vma_expand(&vmi, vma, new_start, old_end, vma->vm_pgoff, NULL))
 		return -ENOMEM;
=20
 	/*
@@ -733,7 +733,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
=20
 	vma_prev(&vmi);
 	/* Shrink the vma to just the new range */
-	return vma_adjust(&vmi, vma, new_start, new_end, vma->vm_pgoff);
+	return vma_shrink(&vmi, vma, new_start, new_end, vma->vm_pgoff);
 }
=20
 /*
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a00871cc63cc..0b229ddf43a4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2822,14 +2822,11 @@ void anon_vma_interval_tree_verify(struct anon_vma_=
chain *node);
=20
 /* mmap.c */
 extern int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sy=
s_admin);
-extern int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *v=
ma, unsigned long start,
-	unsigned long end, pgoff_t pgoff, struct vm_area_struct *expand);
-static inline int vma_adjust(struct vma_iterator *vmi,
-	struct vm_area_struct *vma, unsigned long start, unsigned long end,
-	pgoff_t pgoff)
-{
-	return __vma_adjust(vmi, vma, start, end, pgoff, NULL);
-}
+extern int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma=
,
+		      unsigned long start, unsigned long end, pgoff_t pgoff,
+		      struct vm_area_struct *next);
+extern int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma=
,
+		       unsigned long start, unsigned long end, pgoff_t pgoff);
 extern struct vm_area_struct *vma_merge(struct vma_iterator *vmi,
 	struct mm_struct *, struct vm_area_struct *prev, unsigned long addr,
 	unsigned long end, unsigned long vm_flags, struct anon_vma *,
diff --git a/mm/mmap.c b/mm/mmap.c
index 3bca62c11686..dad5c0113380 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -696,10 +696,9 @@ static inline void vma_complete(struct vma_prepare *vp=
,
  *
  * Returns: 0 on success
  */
-inline int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma=
,
-		      unsigned long start, unsigned long end, pgoff_t pgoff,
-		      struct vm_area_struct *next)
-
+int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
+	       unsigned long start, unsigned long end, pgoff_t pgoff,
+	       struct vm_area_struct *next)
 {
 	bool remove_next =3D false;
 	struct vma_prepare vp;
@@ -745,6 +744,44 @@ inline int vma_expand(struct vma_iterator *vmi, struct=
 vm_area_struct *vma,
 nomem:
 	return -ENOMEM;
 }
+
+/*
+ * vma_shrink() - Reduce an existing VMAs memory area
+ * @vmi: The vma iterator
+ * @vma: The VMA to modify
+ * @start: The new start
+ * @end: The new end
+ *
+ * Returns: 0 on success, -ENOMEM otherwise
+ */
+int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
+	       unsigned long start, unsigned long end, pgoff_t pgoff)
+{
+	struct vma_prepare vp;
+
+	WARN_ON((vma->vm_start !=3D start) && (vma->vm_end !=3D end));
+
+	if (vma_iter_prealloc(vmi, vma))
+		return -ENOMEM;
+
+	init_vma_prep(&vp, vma);
+	vma_adjust_trans_huge(vma, start, end, 0);
+	vma_prepare(&vp);
+
+	if (vma->vm_start < start)
+		vma_iter_clear(vmi, vma->vm_start, start);
+
+	if (vma->vm_end > end)
+		vma_iter_clear(vmi, end, vma->vm_end);
+
+	vma->vm_start =3D start;
+	vma->vm_end =3D end;
+	vma->vm_pgoff =3D pgoff;
+	vma_complete(&vp, vmi, vma->vm_mm);
+	validate_mm(vma->vm_mm);
+	return 0;
+}
+
 /*
  * We cannot adjust vm_start, vm_end, vm_pgoff fields of a vma that
  * is already present in an i_mmap tree without adjusting the tree.
@@ -860,14 +897,7 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_a=
rea_struct *vma,
=20
 	vma_prepare(&vma_prep);
=20
-	if (vma->vm_start < start)
-		vma_iter_clear(vmi, vma->vm_start, start);
-	else if (start !=3D vma->vm_start)
-		vma_changed =3D true;
-
-	if (vma->vm_end > end)
-		vma_iter_clear(vmi, end, vma->vm_end);
-	else if (end !=3D vma->vm_end)
+	if (start < vma->vm_start || end > vma->vm_end)
 		vma_changed =3D true;
=20
 	vma->vm_start =3D start;
@@ -880,7 +910,10 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_a=
rea_struct *vma,
 	if (adjust_next) {
 		next->vm_start +=3D adjust_next;
 		next->vm_pgoff +=3D adjust_next >> PAGE_SHIFT;
-		vma_iter_store(vmi, next);
+		if (adjust_next < 0) {
+			WARN_ON_ONCE(vma_changed);
+			vma_iter_store(vmi, next);
+		}
 	}
=20
 	vma_complete(&vma_prep, vmi, mm);
--=20
2.35.1
