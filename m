Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C5065F435
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbjAETRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbjAETQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:16:15 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABAED2F1
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:16:14 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305IUIHk030165;
        Thu, 5 Jan 2023 19:16:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=7jgMvChxkwjpmNBsSLPkBEf800VrOzeU4TR5euk2NpY=;
 b=pGwAKfNe8ZUFAmc5AO6HNuUhtlelCvnviSt/xFncZ8D7Lfn1e2V7WvsRSbLQDRGmjjNX
 riTT9GfIR0unDSzHh7DkIwmomeVSK3Wm9fpiAcboPWQB89xLwHAqvdnJ9V+aaHN/UhSk
 X0l0gx5Cfq39sFtgGtbEGgTz8qw9LwLU6PTLE2/hIULwNMC/LNdNvL0MC0/cjKRA8mI3
 ZhTWnLvaKMUxzVGlJaxn5UFdpvbguN+CFMaGzp/eMgIyng0ukiPmX3gHdTOYe8A3L/F0
 aj/uqxEUaJwHe/YrFG3ARruRHtsn1inowHMN9oAzO1CbeJtY7Difb3DnaQb1uidNvEK0 yw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtcya9k9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:04 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305Hvlpq023372;
        Thu, 5 Jan 2023 19:16:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwept6m1t-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+OTktSWJDapqBpGxtrCu/OREZE72ma/4obSwxnycxlxjtfZWQILaSk9RWjVYdLAgbpmE4VUAxGLVtLfRF2MC5bLNfiokgRzhpvaDfHIVDOfdxEtvL+D+b3EGajBdjlmGWosfnUN3ErLNzu1ki/sqfftLr5Zr89z2M0BX9t7eKHzfb4HuAtlXsVzedIytZ0VIIeM59XIx8kmtmpIA8ID3WyUNjPj0qRrk2Rjglnuv1sqzCFL4zg53nzooTuOeXOt7uh+3yjGGVoPQKX+2dKe/41jSmoJt3EW1zYy+dhdJAx0QY8m3+aKWL/woMLuWCIIS1gXeLguca5ZFfepefhAfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jgMvChxkwjpmNBsSLPkBEf800VrOzeU4TR5euk2NpY=;
 b=cXjDrF2kajt/sStB/zSd8yZ0LtpuLm20ym6DqteaeAFM3+u7e3eZ8vYlPvGjGVw3mBp/87aQr9rSekKMSQzskPs4Q1U5H6OVdfT6PGeJEv3uCAvpVW/5eJsBHogXh7W3GiBQiExSWDIZj3+qbOeTZt2iX2zwdxiy0pg5AgA0gpwWbEhz0LdRqorjWhnbWiHD6gcjnHNhWVTpKO74BAdWu714PfHYwzI5nSvx7bAcsPb2eHcjPqgSdUaUXeVRnaqZ/rAIzGDViNQdo2ssrqCJOMgLauSdHbyn4IDxQuMXRshZ9ni7AK4epFgnqnQy15Jt+SzGJQGLGgEOUpg2Cylrkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jgMvChxkwjpmNBsSLPkBEf800VrOzeU4TR5euk2NpY=;
 b=Wa9tUizpINnKRyuDAK/cnw6muYg9KXR2mghQU6VanAllACD+b/+t+kdXZvxIZKemkGJVr0yXsIF90uobOk6Tr64DxBL0DOF69t50Z4ukdebvse9N77927S+XRtzDdTB5OKGMTWVo+blL6IJRKz/seZVmH3NuNkFBgoORaca3Dqo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6075.namprd10.prod.outlook.com (2603:10b6:208:3ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:16:01 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:16:01 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 17/44] coredump: Convert to vma iterator
Thread-Topic: [PATCH v2 17/44] coredump: Convert to vma iterator
Thread-Index: AQHZITojDS5jnae8Q0GVPtLwlCGoAg==
Date:   Thu, 5 Jan 2023 19:15:57 +0000
Message-ID: <20230105191517.3099082-18-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|IA1PR10MB6075:EE_
x-ms-office365-filtering-correlation-id: 3954ead0-7d07-4238-f874-08daef51485b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eR6lp+/Or8jF0+EVfDEmrUqFWBZIAVYs16xPKYl0DipaPiEqfOb1BWPbEZBTvLfvg+UtG/nN02wkRiqIG4JYFval/ii6HGLZTDSkvWYyDWEt8vh/X4EOSEbQplmgUtWy9+ksOiQ45+iKdEEHC+4pD7vuqypQig/4/ao+Ef/ATwBjHP82GTb8iSVR5xa9Y8ZnXkjNp3Tb1awF60F/H+qKZEGDjLuUWqAtv6qX8KvkWbZ2oaZXabq395x+l5Qe5E+YL1PkR/c9EAWFMFV98bM5+UVUANaGzfpu7kds3DhZ98HnZhLiYMRV7N38EipJVVdAYzHHtZRMWQ9fy7sLtonmGHe2KNO9NI091PYadbCZUtrCcHlIMMf2CyXasP57VF9MgbvC1JkESUbYSc+osfCw5n+SReGYv/iJbYTxSuTHvBHYXvCnCj12H0HG14+yLY7+FQzrJys9j/mlEhzLOUBskvVVbAC0TQYiTLzOLA3aiLltwqhmz0myX4yYvzmJwHM1KwAQXo7UE+ISxXg10BsidGFnO9LkqTE5S9y/nvlfQfOLwGXFti9cY6tVgS1G1PhYUxB1KYsCL2NTG/oEBX3YiNaQWGsVUzYmnuIhqqB61tkYDoN6UoD23hc9CktDoou8Hba/nuhsAYIdXyNUZ9t0KReoirgEFUtAIW+UHVdVdJYRdgyrHZsnMw0OCOE6uEvDKmn493OtDNxbpRV1W65/fw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199015)(38070700005)(122000001)(91956017)(86362001)(38100700002)(8936002)(2906002)(71200400001)(83380400001)(316002)(66946007)(41300700001)(5660300002)(44832011)(64756008)(1076003)(66446008)(6666004)(4326008)(6506007)(107886003)(186003)(2616005)(6512007)(66476007)(478600001)(8676002)(26005)(76116006)(66556008)(110136005)(6486002)(54906003)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TJZUuLADYzmWMlqhauk+zGLK4ccKCL4pRZiYcPrr2iKS7hKBZmOJVAfNb5?=
 =?iso-8859-1?Q?L0gFfmqSv1FPAWzqt7GFWnXR/FDsQeGCI2iEdH8LFrfNCWvV4GSaxDjWMb?=
 =?iso-8859-1?Q?SkrWTqo06cPt4wEMlmUhRz76rMrhfzz8mPP+WBZg1UMe4gazbrboUIChT+?=
 =?iso-8859-1?Q?zokB8/zsRwHulary0JPmsegsjuzeB6Ml6rkr9bxYE7VJsVQb1TiktYVQTc?=
 =?iso-8859-1?Q?GskzGf6nPuBb+ijpw/bCTBotwY3v+wAWbPgdSGxXRLAkgoPe7X8u7jKqnr?=
 =?iso-8859-1?Q?J58w9CQdcDRmIpQpT9NYjGxkAfaFNf+br2YoCrDaBSBk58cX7G41DBf17P?=
 =?iso-8859-1?Q?r2t9SINVp1szLl96g6feosNCWxzBeY4OF6+flcaWmlCxf2lXKnPWTJ5T9X?=
 =?iso-8859-1?Q?z2chNjsl2kd/UugI3ueuRVjKYOs41jnYqHQlp2U8zwqDr+8l6xvMpGyiAL?=
 =?iso-8859-1?Q?IixQ7j0PjmnPYPONvMak9+Bdc0aSM4ixiwo2681YpPa+mp3N2Oz4nsrHs7?=
 =?iso-8859-1?Q?g/Z+YT6qM93nPjf6KoK+nEGj81tD1Mv6IZDa/m/HjFb27DwHOx2hOhzApD?=
 =?iso-8859-1?Q?uCiwChs5bGfTB6rNQxa0P38zr48R54IrL9AqNZHeWvC5Kej1WZWHbgFEi/?=
 =?iso-8859-1?Q?qDoD/5r7LMkFjaKZmMI/6WD6eJe+DgK5Iai3hdhJX4bzGq+JkIlBnDw1/2?=
 =?iso-8859-1?Q?Jn64pbZavkXV+F5ieEaYOs1zaB5idPxvRDCSl/TwOw3MW1xVLxxLuD2HUK?=
 =?iso-8859-1?Q?0Ljm4vtiHc6Lj88SSFWFD8O6epS52xf1M45Y4rKO/1ziiYJOhRFimSIYHi?=
 =?iso-8859-1?Q?ZfNNnDrFQHeo9gb4bYQZs5g/gs47b7qng0dfhTIw/8D5tCfpiObsgZReXR?=
 =?iso-8859-1?Q?LJLqm3glwPqBJoSS2sYEYklc4FuNultBRP3zahf/GgxcpzQNYOVeMboQcx?=
 =?iso-8859-1?Q?mMJAZ40xIdbqoxYd6NodnUgJXy2Z2sOLZrBI2A4cuBQ2iGfi4BlNW/vdfn?=
 =?iso-8859-1?Q?dqmc+mPuLwDP9GXqC5If8BCbc7X65lWqDUGJlHnFIHmF/aSoVkFL2DZar3?=
 =?iso-8859-1?Q?9uFcl/krqdyVsUUOtfzRYnijaa7vKzmib+QA97Xly7CYN5snTsfOWQ0qI4?=
 =?iso-8859-1?Q?kYkouGJ8dVhZ2buTtNF9s8UASjNYnYMq4sGCxWeQsiztwUhHIwJzvglk9t?=
 =?iso-8859-1?Q?kXqlsNUzszVNFYQn/E9Q1i68TWSQsXblyCZXTtm7PFhsC8F8b/vhka7dW/?=
 =?iso-8859-1?Q?w7IUyRX9HDwHBdZ3hgl/YqLCb8ENMvVf/ho7y9uihWBSETPpKiMdvjdu0L?=
 =?iso-8859-1?Q?PDR2G68eLxN7SLIlIEcd24LPGpNGgK376PwciMnkrZxXLPhRdUuCjHJ+eB?=
 =?iso-8859-1?Q?QZER38vCW2Vsz5b0hH4hUeHldkwOtP65Kz/WxJTd40HgV3pbJDhmmeMLHi?=
 =?iso-8859-1?Q?95QpThLpOfO8TlL9/UMySRxP3mLWJYk3zRSQv99l4YUU2oPfhHfYPlCd/H?=
 =?iso-8859-1?Q?H+n8dm3d0PLK4lZ97tojtG5z303KnPjgdG088lnEIV2ooiAZ2l42JIU+L9?=
 =?iso-8859-1?Q?VZENWAg362ydnEevYKjuN9P8UkZGPFDX6uSwlPheRjgDM2gS1u1X0FQp84?=
 =?iso-8859-1?Q?vLZtCy0fPfVVDIZRCioatQHiMKXaEZEi9JM9ArE24A8OtXCB6eM543Sw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ao3lQANr1mxO5/uXIAPWWXZs3xbZorvZv9Bf1FXj1mYev+rKfX6Z8Bk33Zh/98SXYBQhU6CXvVewxjsd1zzLQtOe+6x9Nm7TV0OEZKvwF07wClhGzD5Y1CW1CKQErVRIJYWMAIEPpX+3VsEuJogmDAotmCEjnlWuJpeWvDJljGJHWdLiFCLyn7dLginK0Qdm4W0A0srrO+YnGaAzXv6Obe7XXEJ5enAC5mKzyCHdWl1If+DfoBzXW02WWXhWnzcfBjOvA/6R6x/ayIsLWNCJA/t1u7N6vpp2jJPCCaD2Grl5KrTE/TcrJyPJlwCHHElbel6Pji7fGEXrummfWk0+kCIPKRjf0PbFKpHrQnPcCaqdEn5cedfE9/ScGtmNTssSABpuwoLcbF17wn/RDYvgAkfqu5wA9REQwg9EDwsmDA9jBQloM/6QBvPj7MdWq3i1gOf3hB9tot28LrOfHIYFJx1TqrGl5L7+2XUYZpGRqUvKsvyn6nbZwb/iAuUg++khiYZytFTLu6mETSgJ4uMyjIUxQlUv6qc0nULFxcbo/DourDBtXd+rnwvaEsMeG1WIHpPennLamLyChwB4dblIuivTmD0pDeh/UKED73majxgldnWidUSuZMn2XHimigUPi8vAxjd1B3MSyttKTGpU9w3z63WtDyXGtC5oRgzTkCjOl6s7py7qd+ug1bl5CmJIL2A101omq0dmY7LlLwZWZJ/Z5ZYWV2R/1+tcri48nV7yQlC772S8ayfISN/uQ3BaXJEAfEjDb210gqCvoUTQhJ40NUJ1Sidtbb9Cgqd6J7nW3iwA28ql9d8sgdfuPtbYlhRKI+dfGduOIcozK64u8MaOCC/yKuPZhGyBXP3Jh/QF99qbgUe7tvHbcxBIsQD3tdJlJiQ8kD3dLRkYr+fEQw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3954ead0-7d07-4238-f874-08daef51485b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:15:57.6100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MtgraOol+xxlXLwDr4zmZyFPc3tLGrtXthu74+i06gUhlAGir19xvfX2K/mdgcSgvDEh3U8WVteRxAa9oGGd+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6075
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050152
X-Proofpoint-ORIG-GUID: MUMrhaSss9grnPS3DmuOJSTGbJhSc1c5
X-Proofpoint-GUID: MUMrhaSss9grnPS3DmuOJSTGbJhSc1c5
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
 fs/coredump.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index de78bde2991b..f27d734f3102 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1111,14 +1111,14 @@ static unsigned long vma_dump_size(struct vm_area_s=
truct *vma,
  * Helper function for iterating across a vma list.  It ensures that the c=
aller
  * will visit `gate_vma' prior to terminating the search.
  */
-static struct vm_area_struct *coredump_next_vma(struct ma_state *mas,
+static struct vm_area_struct *coredump_next_vma(struct vma_iterator *vmi,
 				       struct vm_area_struct *vma,
 				       struct vm_area_struct *gate_vma)
 {
 	if (gate_vma && (vma =3D=3D gate_vma))
 		return NULL;
=20
-	vma =3D mas_next(mas, ULONG_MAX);
+	vma =3D vma_next(vmi);
 	if (vma)
 		return vma;
 	return gate_vma;
@@ -1146,7 +1146,7 @@ static bool dump_vma_snapshot(struct coredump_params =
*cprm)
 {
 	struct vm_area_struct *gate_vma, *vma =3D NULL;
 	struct mm_struct *mm =3D current->mm;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	VMA_ITERATOR(vmi, mm, 0);
 	int i =3D 0;
=20
 	/*
@@ -1167,7 +1167,7 @@ static bool dump_vma_snapshot(struct coredump_params =
*cprm)
 		return false;
 	}
=20
-	while ((vma =3D coredump_next_vma(&mas, vma, gate_vma)) !=3D NULL) {
+	while ((vma =3D coredump_next_vma(&vmi, vma, gate_vma)) !=3D NULL) {
 		struct core_vma_metadata *m =3D cprm->vma_meta + i;
=20
 		m->start =3D vma->vm_start;
--=20
2.35.1
