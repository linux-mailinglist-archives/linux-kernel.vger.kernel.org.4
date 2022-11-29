Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E6863C566
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236025AbiK2Qoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234899AbiK2Qoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:44:32 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75135421B9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:44:31 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGP2cP031397;
        Tue, 29 Nov 2022 16:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Y3yTzYobRiVKkYcwPyE7QTfd9+fEiEP874Vs7vrGzKc=;
 b=l8fzbzGKA9VeP807+HR0w3syK7SuKXZG0hK+52OzEel/88wPFgQF7mBYxK1Er6DWM5Am
 DPZEFTzyIMONqGFZzPLhOgIjkI2nsWqRjp8ni0V7yK2o+TqSKTSWoqKyGIu15jwc/TlX
 yZT4C1jlO50qgta84qJLDKijLlT731dN3SxB9T7cSqQxv4fNY1NsCUf2lC4dr2fiUa0N
 Pyezt8gs0W7D+ojuwrvxIMYjUDdfuBd9HrEOdzF7WL3D0mCF/MHxImZVpf+lhvVIXkYe
 eCyYEGTIK/tvR3xR1+kyyK6VeJ88BkGXYg7xCgl8xzjKeLcQthDvUKbx9WPQySpP0Fag AA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m40y3xarj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:27 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATG7rBb030968;
        Tue, 29 Nov 2022 16:44:26 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m398771pv-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDIIe/q1C9mzI1ONVbllfaBuf871C5cbcmWoe2ow8zx4kE8IwBtrnMJ2XwL1b3Sc03jx1balWj44B1+Fi361ozmUaEjRKkyu+eORuWAVxYxR9FpKub95ObH67QKlkoMmrmuJS5wkzXJnpqkmKP/WwAdyaqcDsRx/pHjGyjgssk6sCt9wZNAOXNmPeAbNMABT0rgw//qfXEQRKjRfdqhPmQSQ6yk14Olv50rmIuvQow0lyGLcXsCBbter6zRBb5pqkbd+ZxTZF3HznNQZoZLTd3kj4HKTrhcoI4YWqnTCiwQx8mxeXSg2g0wXutnsBmtSyc/aU8ktP2+aUdOco0Vd9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3yTzYobRiVKkYcwPyE7QTfd9+fEiEP874Vs7vrGzKc=;
 b=RSObpKpiIPpVr7GxwQXyPgzqNbo0bLqe9UI4sc08FUQklfZqJRDsnwVi0NqqNM2cOHODlL11ru3UNP4mRNdLD37pFWyDqJDBq6Vpmmop8aaSphW8L3eXRChbjoY0scgpbHWViwXpG9HFJCXHWIcCgiQoFiAfOUN3EZ69tRgDhyMsryI7vF5MIgrubZS9bQOg7MNeNr8xSqHlY4YRpq0CyyNqdHjuuVvLN1uL3fdLmReqIL/R3IAuAkS48D8WyVrdLo7v/LEmquIGyzJP1DRH8+9ELItYYTV2ZzEMcLMECEIK2bTbYEKo9/EwAPnto/Aw9re/LLpJmZL2A45db8WmYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3yTzYobRiVKkYcwPyE7QTfd9+fEiEP874Vs7vrGzKc=;
 b=WlFCCRDlehRGT4X1OhCKdNdngCKEfcH0WPyw5P8gW+ZHIaxCbZzwukHNrWX5qo18ZSwBHiGWczwkjPHWQvMYh8szVLe8L+MITOH6x41NMqkKTuySq/Sz1W/JjEhx4gUnGG9TJWQc2K8d7Y0IYOB6APhV6VvC9+9s85b4tbn+mS8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5321.namprd10.prod.outlook.com (2603:10b6:610:c9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 16:44:25 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:44:25 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 09/43] mm/mmap: Remove preallocation from
 do_mas_align_munmap()
Thread-Topic: [PATCH 09/43] mm/mmap: Remove preallocation from
 do_mas_align_munmap()
Thread-Index: AQHZBBHVxPIDFGM5WEet77BCeDVVHA==
Date:   Tue, 29 Nov 2022 16:44:23 +0000
Message-ID: <20221129164352.3374638-10-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CH0PR10MB5321:EE_
x-ms-office365-filtering-correlation-id: 45ce288b-7e37-4b77-9470-08dad228f96b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6WsBY74hgrIgLgMC22L3w/g/8CR8zCrNL0tWy2470ynowJkZP9vAVWq133YKZVgHgBKem1t3tcAXocAP4+TzbAdQqbZyPtXyuPjQeaRTsMxFiqaNIzBwjmUBWbV0loznVc1byKNumAQVVdTs8H5iv57zuRIG2NK8BbOtcPgw87ugbft7yHk1RzIq9R985suU7C45TrHC+Tj/lM1aIyBjhwzjusnUam75S7+kLTpneqTcNSWAiflJ0c0FZ3q4WKyLO0JvPYJNz3av5q13PX1A8D+59ynGM/babVcg5+dLsK24J1ZEuxSogldLqyjXFZqaSnmnYfZPz0tgjNM3VkHtPzMo+ZtR4iGe6GH0YBH/gDjxPkIuaB7DMC5UkPtDiiGfgQSA0UgiNxON+nizC/VDC9CwUQ4VPHmJA90Ctdg8sNksmacwQmGLXgBo2wcCtvylGfgWb/bzJauwb3YkTNaa/XrOmW5FuBjq3MG8VbHJ4vWvr8KlBNjbOU220cjptiJjirC+u/oDq0ggS2vXvh2FtvJJRssQRR53yCvTQ0tO+klHjRYgekH6/Rb5hL0fV8/z12lJ5pGuHctbM+OjtH5mmvXZPn4wg/og5vi5Zq5JVocCR2YAHZSz+SjZCL6aRl8dzHLrGCtuPUk1UtnaZOe491wEeDqP5PnkGhLwEV1wSM63nKlXQO9l2xk/2y7oqo0jN0dAZSM9lsYoiNMImCeuRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199015)(83380400001)(54906003)(71200400001)(6506007)(107886003)(110136005)(6486002)(86362001)(36756003)(38070700005)(6512007)(38100700002)(122000001)(2616005)(26005)(1076003)(186003)(8936002)(5660300002)(66446008)(478600001)(44832011)(8676002)(66946007)(66556008)(64756008)(76116006)(66476007)(41300700001)(4326008)(2906002)(91956017)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?byJRqC1P4vz429QosKeOAT7BL4YADTmRKj4DSIiPvIH4Q9OVaYw7IJzsGI?=
 =?iso-8859-1?Q?nOFb4Tmb7O8JUKBadzh9fa18rDK1Qcyb783TDT/LvdtkQGY6GqxFdBTKkw?=
 =?iso-8859-1?Q?juEWAi+L00TE5xNT19udwym7TMRSyKazQfewRAh05H9tiz54InrZ1/y8od?=
 =?iso-8859-1?Q?viWmj2TE94NliJUvle3wLOHPPbGnjUS060CpDH6ajpGQfrL7oLLx7oF6x1?=
 =?iso-8859-1?Q?WUpunDfV13dSTBT8xFRCSnFuHCrob/nNkVFoJTG3ZDfa76tDoGXtvsp6Gv?=
 =?iso-8859-1?Q?pKEoNAnDjVI49E6ZlSlugyOoG6FQCExrsUobBYNhe7ACLfrVNfi8SILAuk?=
 =?iso-8859-1?Q?d4b83VHIu73kJXVB9a9Tizk/leuVVmNqZyYeIJG0NQz2h96MUFYJ8OG//Y?=
 =?iso-8859-1?Q?QmbnZuPnnygVXK5PVB/Ggjw07Kpd9Z3FujV8GiGR0y63BfwdmIL/Haxfr/?=
 =?iso-8859-1?Q?6u98NgfQjbe18jlPTCsM+3w7VHtmfgWzvJ4i7yjh4kDR0svDNXy7GMhvYB?=
 =?iso-8859-1?Q?PsBx3wum1qoZghPC7VsssU/5kO7BFR3g4x9crTSRP2bOQTznA/wDCM+ETv?=
 =?iso-8859-1?Q?6juO7ERyu/KCRT1KbmWKrQbvSETAnrwAM6rIXh5SBW2wPQ7O+YedShHgxq?=
 =?iso-8859-1?Q?VUFQp9vzHM/fLWlFvCtY/YZWenak+x4BY8jH6XxWMr6RTCLQzzBhkldBQ8?=
 =?iso-8859-1?Q?w8yX8uEM2Kmv8ZFLFt6jSatuule7S3vugAEAYJjfA4MA++IEtOgGa5NaZg?=
 =?iso-8859-1?Q?/yk8iw7SXNQwh51lpy9ZmtJluyk/T3zKpJUYiRnFtbcO7yQ1hgHURdrJ5Z?=
 =?iso-8859-1?Q?k5Xa9cklzWU/qmOrZYpU9/xu7ZU++KnHnYG3kBpuTMAh+yyfH1JffXuBnf?=
 =?iso-8859-1?Q?lfOlCxdUqi9At+u/30QOqZFSwggv7wchMhtwMm65ocGpsbV7XF1yl1sNIV?=
 =?iso-8859-1?Q?E/yPCFbCEhlfZJ0vBMBeKC9+jLW3PtO1ng3lwy+IEolbXeVgD1Pvib2+2/?=
 =?iso-8859-1?Q?NNVJy+1lX/QFZrfY/KAHJyqFoA3mP7da+6EWsVCKOkdTQsK6q88VcnkwY9?=
 =?iso-8859-1?Q?1+hXZIjipBa9PTmI21qGtEVXL6SabfN8s+pNI1ahiRSfXgS2l8Vrzg57bW?=
 =?iso-8859-1?Q?f3hS/c9RPBn2WH49NjTqaO5FBkgKHI4ZAFl0mxAMDQZ6iy5K/38FK46W1m?=
 =?iso-8859-1?Q?HzAdMo0etuVD143we/D+PEtLwL+S5YsqT37fKc0WJhrcTU8uBshcM+WBZ0?=
 =?iso-8859-1?Q?/ASaLxinGikcSiKMFbMZo74OCAzY85naWst/LnQoRZF3I1xaH5WgaILZRv?=
 =?iso-8859-1?Q?lhaxea65gn/n7+Bo+Z682eeoKFnMRXXtPCc7OVwmS6qF387Xw1HIOCw3VV?=
 =?iso-8859-1?Q?9xjGtCQbyetVxppWzaWowuBOtdUePIf+QNhXGl6DP2U6p01HjcQmgBhu7O?=
 =?iso-8859-1?Q?Z3Gt30DcGYTTq/ycutAsHCKa9sH/meHSZ3bxFKcTSIQRnVQvXSnouQIWfk?=
 =?iso-8859-1?Q?G1zijjHxQa6s4S42ApCUuLsFAhKtsN2ViGczQTH3yHs+k6Ief5HAik7LBj?=
 =?iso-8859-1?Q?ZxEbQqkz3Sh7Li/NO6eoZ8xn+W9+y4TCgzsyuj3lzTuxmXLFegiIlGdx+q?=
 =?iso-8859-1?Q?LcEkD+orVHcqb3VvwhErJi1mYdOE+L3fYHQ+a2H+6+vIHf98wWOAjYtA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sfKGwvk/SfuCzlKise/d9mOgj7MnYWV0qdr+MYFm/4NK+tSTCQNfhFeYX1yIfhE0iI9Kc16i/VgwyRelKQ/+nLDTyTSc30rZ2vmYqaaywYeGv+F2BhcFE2K6St9kffZYvJ/ueFIo2CIyFk8jTGEbUDNFxQ6Pd/HYbuxKJSGTB3DPdmEFSNl85CBn+7TwHt64+YObu6/CfCznMWUV7sjlK4SasWVEVyZU+oKdNUM4HIm0JA0R7E1dAzQdO1uqSXvHOk9VK0+rZrCs5cTIbO5s2C1cFmGYV4WixDVkj+HY51CxonmuCiFSMAT14uaJjRAZAYjm2zoojCT4MzEH6n1OmDPaCMTWhrPhTcuMn7jQHqQHWVtCdMeQCX+osGCPr0sRMKUJrQ2jzmmnu1W9BGnoTV2KGCsFO+cbkV+UDjgVmz7lI+2ODkk54CdPb7mDMzMqvPY2ZcggYBb0C1vhvL7Vwd16KP9dAOUgRC111b4qFYxCgXcVrs46RU25lSEEUwsCDHAMNdyd1CehjsOmhFN6AFK6CNLLUT2WL18vv61NOI0XCYmcPqWhNKgssMUGWGBUOs/0Ia+SFypMIF41FmFrSloJDRRWsJv2p1UncD1s8SutpbIlPd5v19vukBCpuxsnffP2hn4jUshyoh3v6ygb0TXdRw6kPQPlS2aMS+JfHOlGQgoJ5XJjbN2lK/0BmSWM9V4aK7BgAtwd/08xcfmIBJ0YUKW/xqjBQSmRDpoDDY20JEOKLskL4IigL+b+8KFs501V3IVTnGS6vViVmYW80YqJribWhoF7N6OTux2s8fvyItbVSiXv8g/ZmgdntBTB+riYhYhNE1opXjxpu9uZlhpNWmNDz7x2JogG9WrbRPirCy9ebYEx0e1ZsS3Vp3Gbk4ZqE8Tgp56M94be/M7nPQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ce288b-7e37-4b77-9470-08dad228f96b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:23.2230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: thrNU89uUsNtN+gb0Oar8qYmEcB/AYlXxy1vStvvX+Eb6SMbwEAEMOgjocCEAFn0dJPPkIBc141AQ5q1qL+PBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5321
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211290093
X-Proofpoint-GUID: EuuLLvHrdjlbx6L0PBVookTm8wLaa6f2
X-Proofpoint-ORIG-GUID: EuuLLvHrdjlbx6L0PBVookTm8wLaa6f2
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

In preparation of passing the vma state through split, the
pre-allocation that occurs before the split has to be moved to after.
Since the preallocation would then live right next to the store, just
call store instead of preallocating.  This effectively restores the
potential error path of splitting and not munmap'ing which pre-dates the
maple tree.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index f4568a25d2dd..f601f7b7dce3 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2385,9 +2385,6 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 	mt_init_flags(&mt_detach, MT_FLAGS_LOCK_EXTERN);
 	mt_set_external_lock(&mt_detach, &mm->mmap_lock);
=20
-	if (mas_preallocate(mas, vma, GFP_KERNEL))
-		return -ENOMEM;
-
 	mas->last =3D end - 1;
 	/*
 	 * If we need to split any vma, do it now to save pain later.
@@ -2478,8 +2475,6 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 			goto userfaultfd_error;
 	}
=20
-	/* Point of no return */
-	mas_set_range(mas, start, end - 1);
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
 	{
@@ -2487,6 +2482,7 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 		struct vm_area_struct *vma_mas, *vma_test;
 		int test_count =3D 0;
=20
+		mas_set_range(mas, start, end - 1);
 		rcu_read_lock();
 		vma_test =3D mas_find(&test, end - 1);
 		mas_for_each(mas, vma_mas, end - 1) {
@@ -2496,10 +2492,13 @@ do_mas_align_munmap(struct ma_state *mas, struct vm=
_area_struct *vma,
 		}
 		rcu_read_unlock();
 		BUG_ON(count !=3D test_count);
-		mas_set_range(mas, start, end - 1);
 	}
 #endif
-	mas_store_prealloc(mas, NULL);
+	/* Point of no return */
+	mas_set_range(mas, start, end - 1);
+	if (mas_store_gfp(mas, NULL, GFP_KERNEL))
+		return -ENOMEM;
+
 	mm->map_count -=3D count;
 	/*
 	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
@@ -2531,7 +2530,6 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 	__mt_destroy(&mt_detach);
 start_split_failed:
 map_count_exceeded:
-	mas_destroy(mas);
 	return error;
 }
=20
--=20
2.35.1
