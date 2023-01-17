Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0309066D459
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbjAQCfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbjAQCea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:34:30 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D579229E3C
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:34:24 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H092ro007573;
        Tue, 17 Jan 2023 02:34:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=achDkf1FEZpqOQkM+iZMPfX2tkpkKZnH7dkp0tHtHbs=;
 b=fYyNK8OFUyixmDD+zHGYNWLebr9vapQANnv6GauFVRacF+a5sAS98vJaJGh32z78zLCq
 2V8DD7xHrvQ4nLXopzIXiFdKm8wyZHL9jCggo9UnBUctyr3/GoZDvB4mcpsiTJQ+GDo8
 J528YoZlrzRInYputjQlSVUPwS7L9itlwDjThRmeKxRC8MFH9J6F9nIN7GU+2fsDs3MK
 uv8gRvLNlYzmasLVRFKPmLMDg9aPiuJ2MEmH1hhaYeVMOEx1w+cggneWR0m9YuhFHHh6
 6X5ln1Xdzc5tOpNrqh2fCeAazi8b2TsYwbVGA9RO+9FNjqFhmLNrJ3LIFEZY81jFWHMW Sg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3m0tkp01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:16 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GMM4re028480;
        Tue, 17 Jan 2023 02:34:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4s2rfxkx-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTyrhP5HTJ9/c44bAAsu3q9xOeM7LQWa+ixL0lH6LItCZuedVXnWd0tRicw4oM8+1eYauUmdSZKYz4eG8WLuzCbVDZUuk//MvTHMkltdZJfzGE+fyT+UpZqe1fa33w6SfvfKKXh0sbmwOc6LTQv1mGueBXbM5zgjHwjJuCtb736zZ/e7T08uyJkzjlYrUYMUX4l8NZ9ZRGZcnnVUYuoaP4wC/VshZo0wlhO+6EyCtEzFDW+KSIKz+jret7eJtzBaGnsPsUivmxH9ipjYOqPsOxED3XGNxi9V/+03gGPx4s0XlXJOzJ+KksNqJtVYoFjGbcnCP1tm40QjrhCbK6W9jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=achDkf1FEZpqOQkM+iZMPfX2tkpkKZnH7dkp0tHtHbs=;
 b=KkhMtGV4IxyxJg8TKcgeWD1IAF0x3p3ZacpLBM3gddn5Wp/z/YZGZx8EVjL1tPG8mA+xng4P2dIK+w+dBDLpScbM2AskYM5pv/NSg9wNCV2FofY9eOF6vOosImD+rOf1pdzWQTIBryPnPwahiZv+xx+ZpuPKpbJugXuK/pA/OSPv/5wZ8Q32lSSX/Qn0kWoAmkSTPfsLv8UTwUmfXDU69e/M5gukZL4cCYIOS+O9O3+ogda3xxAWEplfAyu5Km3Ecpdlj3UN9gsYuZOq+v1Qi1BQB9YQE+4FTPQRhQmTGWw1+kqFumfet+JIBFBvLsM2yNtYCjqVkmCCzlqFQ5F3FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=achDkf1FEZpqOQkM+iZMPfX2tkpkKZnH7dkp0tHtHbs=;
 b=hWQgOZi5UcOFAC9vyA6offyRXGEqqpwKYSHXA9ftpY7tpubOINjAYxWTJ/oELcVniTah8FHTh+GtThT9KY3NY5VgLF8AtVYHvdtvep1wIMjczXdkiDlVzphQuhKlmPB/RqgsvGZQk5nRVOD2ZUnSyzdvrNQSDd4NqeDtbrFmv88=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5356.namprd10.prod.outlook.com (2603:10b6:610:c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 02:34:13 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:34:13 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 08/48] mm/mmap: convert brk to use vma iterator
Thread-Topic: [PATCH v3 08/48] mm/mmap: convert brk to use vma iterator
Thread-Index: AQHZKhwvS+P7uMU/SUqGMBeDCDB8nQ==
Date:   Tue, 17 Jan 2023 02:34:12 +0000
Message-ID: <20230117023335.1690727-9-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CH0PR10MB5356:EE_
x-ms-office365-filtering-correlation-id: 519c5fe3-cbd2-456c-b0db-08daf8335238
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b/7wBQWO2fyc4PZNA66ExANWahSqEDDI2nK27oc2CeY7kMCvb7WkEVpXinGQWVm7P8c8KxnyLpf+EoHMNcbqbd5/UiEy2c0cJoA3zjvxyZCP245gMzIJdg1lf1nbNcm4KNeeq4u/MbOIMtnQaD7Xd3gmMaRTFPn16Jc9X7Ht8emfc3CSHWd8tFfzNhOkRJu+9FZRKkofIWvAzxSXsmtRyCT9zH/WquEATorJe3OGzeYY7Zb/LsNI1n/oejpbE1j5rD4lfAfyt0Uq/dM02hio4qhIPG5RLeorexvwobKLmustMMSArb3FkP+oQ/7uEwFFlafTpiGm+LifhEGSAhnO3IEHZEaMt9MWjvTfIXtoh/zEQ94jcpTCzUYvrvYvL7ZfUknIsKX6WlXg3CjhkSL0/B20XApC0QrOzkCdb4GK2vaO3P1ciDPqlMSz3+tkxmI7SUvc4/mn4K1NG3Nhr+B3abTPUFXlVpcyVp9KRgTR781vs3A+SRpeSQw7IA0bDcVUWtBf9TLEBLqZryJ4lwIFLbRJeU2TjKu6hhErfQOXNuSJC9AXosqaxAEA8MHuUe6aTmqQyNdc/4mXvRUPJQg91w3U4PU2YZZfc96PGdsfwLzyLp/AecSnIPCtSbfnPlx5LoydvKCVnBG7XAQDqnFJY4boPLCuEKuFHyJgfdEnDrV7w8E5OioIjETXGEGbvq2b8xwXzm/dezr+2pxiQLWr2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199015)(36756003)(38070700005)(5660300002)(8676002)(44832011)(8936002)(4326008)(76116006)(66946007)(64756008)(66556008)(66476007)(66446008)(2906002)(83380400001)(38100700002)(122000001)(478600001)(54906003)(71200400001)(316002)(107886003)(110136005)(6486002)(86362001)(1076003)(41300700001)(91956017)(2616005)(6512007)(186003)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Pf0YPBi29Cg+v3KVTxx1IpZChnKNZXfB4dQlNsq123Chbiw+uvi2sTvSIR?=
 =?iso-8859-1?Q?RpsGeIRF7/WnoJTz6swf7q1vf0QdDOD/GiV1pXMMOsf6Je4DUpbiclfjk2?=
 =?iso-8859-1?Q?5Ouxy6sMGykxx+KOCrDB62fRpua6tj1/eQ0EifnNVPKSKXC0Q/HDAoiOJB?=
 =?iso-8859-1?Q?w36U/svjyGSPfpNaN/p0Z+CfuipY+zBVS1uTPO21/BNM51TeshOHr6QERs?=
 =?iso-8859-1?Q?7/bFViFL4n0v2rKu37C7vsMGDjTTmwFwqeh81me0NOPVlsNH44p0NXtsh+?=
 =?iso-8859-1?Q?ZsB0MjnnhzC1TKe1K5Nrl2pFAdUWsNBzAZgN0bOzIvQ5j10BrxbmABMidt?=
 =?iso-8859-1?Q?29cTMPUxjLMSUHW8kJTv8bHb57C/fA3CNFgFhI4EwPdmfFlBc78YR3VhO8?=
 =?iso-8859-1?Q?gzHgKensG2xJKOgKhl+eXI7j/Q92laxR0GUzBwOB9WoQZb0v52kB5oN+fh?=
 =?iso-8859-1?Q?jnlRgecuX4OrXRBmb9Lb7vE40rhwSmm6fd89VbzM9YGL5ebz7r9xtZcW1B?=
 =?iso-8859-1?Q?8CpMfkLC+Y5Lle4f2HZ8kWj6iqvDBu22M7+Zz6AgJmowIFr34smOXiQc70?=
 =?iso-8859-1?Q?2qk32M24Xj5Rquhf6zcF1ceAfqHtvLdPBnAprHJM4GjeguKFnqe/vO5feb?=
 =?iso-8859-1?Q?4O7m11dqAPlttF/T2orW6dkeEBeHrmWZlaZN6P06h15DPN3qT3qKNqe70p?=
 =?iso-8859-1?Q?FOf83oJtLiMTDyEkHPp3wE7Jatu34HsqYqp660C4LkFhW901f1Y/ULPWHn?=
 =?iso-8859-1?Q?CxErihvUBG4UEervps6dmapxmMtn9sfeIFd8xkQzjuulimt7aZA46zal/n?=
 =?iso-8859-1?Q?vxsZ4OaPqjH/oEVsSDQY2mWcczUxj6WEaJJYAXHDrdo6rkhxFDpSb5cgou?=
 =?iso-8859-1?Q?VHtJ7XcrbodEnNkz4xsE0PyilzUHlWG7WR0+Wfti3gV6CvULn9WFCjjUeB?=
 =?iso-8859-1?Q?uiHk0jgrtsC9YrcMIJh3E9uHcGzDowBMi5WGnyWmenmJt21n97tiKfyk8w?=
 =?iso-8859-1?Q?kW/ZhGaPK8un1RrL1U5oDCaz8YkbNjdUieIptPwAlcraKfA8n8gJnYFPic?=
 =?iso-8859-1?Q?R40LaCM7KOxku6ufdSdlkqu8c+dmNrTcq2l6QgMt++3oa3JziiiC2PZgt4?=
 =?iso-8859-1?Q?KtVL/Hek3BRmM3aP9+PN9gxGvs6ZitfY8ZUggwAZmLD+nU27KP+yew3Akj?=
 =?iso-8859-1?Q?EMmxLkYj+CF586NgnmmkRCvdHtHUeM543EFhePi0IL8MFfntnBjiYZoDBw?=
 =?iso-8859-1?Q?iW24t9uoWat4tRZr8LHStHcmswhJwNxA7iyaT7RKVBzpqYGW0z2qZlvV57?=
 =?iso-8859-1?Q?S1GEcM4QBQQPPQhZwtWQcxBY/6A/maqXufq3whO2og5x22h4HPpP0WF9vF?=
 =?iso-8859-1?Q?dcJXOr3iRpOKXaIa1/O4vzhCqc4bZNls95wBo6BklBmx9/77nQQL+MI9U9?=
 =?iso-8859-1?Q?JrXWyACpK+RTz9TVic9BCbwyh31O+nLYBhUemW6n/gMwfuMf7Xo9V0spbi?=
 =?iso-8859-1?Q?CcRJ2QxnREgmXlf3cac7OIw3qVAWR8Q0bJwTOTph1ssSc/LHCCoX5e+7rY?=
 =?iso-8859-1?Q?AdKAyLArOMJ30hOUhxZiMQz8dftEnxrHbyD9/Tnxlf2Skp3vKn/5fd9Zkc?=
 =?iso-8859-1?Q?koWpMS+mSZQtDtD6opzDGZoEVbn3W7d8mB7dQbzYRdp2XERvGSedwqzQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: m0yK44LypjK1ywd9ScZCAAeBLTpJblycxS/WQHiXxyO4CQ2Tf76PSiI3EMl3cuFLI8hy2aTlUUGYJdMWcG8Q+kCZyiSj5v1blLVtdSbKqWaPcljcS/P84wOkdiIhihy9YFHpq8IR4e4vk9Jh2IAZHZmoxAsO9Xj2bsnr5nrEjpFNYA5lDOBfYGP5DGfkRvk1mM9m9EpblWZQnzFnt7AGRUioFtOSoTiApZQwUVZEIdg1QyHpU90qkhIgVh4GtPuOj1EpTm/F7PVZKyTi1uZAGKVNF1aWr9Ne9HvCaA5Z2Kyjp2HQHLfgfnXSslwF1uN/Z6MB1PJ3O9shQE06wuwEmoTtho0gjcSx12rvMLq8WJNkl4vVi0oWp1tuXyOQWmu4xOv3bBEfEJGZcsjHemTf5tDgbwsP3vLEV4SyP21W9xHepTB2YkA3/SRG5H6bWFDGtNnPfh2apFit5rLYnh8T3d/fn2WimZ+vC4ouJNe4/ue4/nPRHiz38k9IKUll0/j/S4u40sVthIy5GUb71eE92cEIZ1AzHDT/dYrfosKd5ZoHHf0by7+D+YhtM8DOFfbMjOoKQQE09z6B6TpG1FUMxQLeZ8infh1ahY7u9XhGTOXeEN+gxZh/D1IPLlsAI+Kcbr6W3SMHBeItR4x+aoWuAN+FGf928514NYpo9PI6VoQR6koKFF4tfPHqTMf5Ws4qtxoPAwjCgSiLdAzWOOs2g2pkKBBD+J/FE75kcMq6WsB0QlISVm6yS+Q/mP2606dBDGQNmRMYekYN2OXem8aCOx5Hkdsiad8O4pt9sLV9knJp/hKt/msQG6RRWxp0GgnI178up+1dyqfIiNxCPXKzoSZPiuNcQGpoTFeoTUJBxv14QsUTMfMdXuH6R+yNQ2WRDfwGGYfOT5OzhQNYajAdjw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 519c5fe3-cbd2-456c-b0db-08daf8335238
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:12.3283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N50VSqtBnq71JmdiP+YPbT3kY6Zz7AfVWwqgeXt0+ZtbRX9Gc+sGTbY0jcJRphVa2zqThiHKeOMMYpCOz/XMEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5356
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170017
X-Proofpoint-GUID: thmWD9AAPc0iwQyoviaCNtKGuSkzjx3k
X-Proofpoint-ORIG-GUID: thmWD9AAPc0iwQyoviaCNtKGuSkzjx3k
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

Use the vma iterator API for the brk() system call.  This will provide
type safety at compile time.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 46 ++++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 024fb46251e2..81ff47147317 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -180,10 +180,10 @@ static int check_brk_limits(unsigned long addr, unsig=
ned long len)
=20
 	return mlock_future_check(current->mm, current->mm->def_flags, len);
 }
-static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+static int do_brk_munmap(struct vma_iterator *vmi, struct vm_area_struct *=
vma,
 			 unsigned long newbrk, unsigned long oldbrk,
 			 struct list_head *uf);
-static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *brkvm=
a,
+static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *b=
rkvma,
 		unsigned long addr, unsigned long request, unsigned long flags);
 SYSCALL_DEFINE1(brk, unsigned long, brk)
 {
@@ -194,7 +194,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	bool populate;
 	bool downgraded =3D false;
 	LIST_HEAD(uf);
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	struct vma_iterator vmi;
=20
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
@@ -242,8 +242,8 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 		int ret;
=20
 		/* Search one past newbrk */
-		mas_set(&mas, newbrk);
-		brkvma =3D mas_find(&mas, oldbrk);
+		vma_iter_init(&vmi, mm, newbrk);
+		brkvma =3D vma_find(&vmi, oldbrk);
 		if (!brkvma || brkvma->vm_start >=3D oldbrk)
 			goto out; /* mapping intersects with an existing non-brk vma. */
 		/*
@@ -252,7 +252,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 		 * before calling do_brk_munmap().
 		 */
 		mm->brk =3D brk;
-		ret =3D do_brk_munmap(&mas, brkvma, newbrk, oldbrk, &uf);
+		ret =3D do_brk_munmap(&vmi, brkvma, newbrk, oldbrk, &uf);
 		if (ret =3D=3D 1)  {
 			downgraded =3D true;
 			goto success;
@@ -270,14 +270,14 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	 * Only check if the next VMA is within the stack_guard_gap of the
 	 * expansion area
 	 */
-	mas_set(&mas, oldbrk);
-	next =3D mas_find(&mas, newbrk - 1 + PAGE_SIZE + stack_guard_gap);
+	vma_iter_init(&vmi, mm, oldbrk);
+	next =3D vma_find(&vmi, newbrk + PAGE_SIZE + stack_guard_gap);
 	if (next && newbrk + PAGE_SIZE > vm_start_gap(next))
 		goto out;
=20
-	brkvma =3D mas_prev(&mas, mm->start_brk);
+	brkvma =3D vma_prev_limit(&vmi, mm->start_brk);
 	/* Ok, looks good - let it rip. */
-	if (do_brk_flags(&mas, brkvma, oldbrk, newbrk - oldbrk, 0) < 0)
+	if (do_brk_flags(&vmi, brkvma, oldbrk, newbrk - oldbrk, 0) < 0)
 		goto out;
=20
 	mm->brk =3D brk;
@@ -2904,7 +2904,7 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, star=
t, unsigned long, size,
=20
 /*
  * brk_munmap() - Unmap a parital vma.
- * @mas: The maple tree state.
+ * @vmi: The vma iterator
  * @vma: The vma to be modified
  * @newbrk: the start of the address to unmap
  * @oldbrk: The end of the address to unmap
@@ -2914,7 +2914,7 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, star=
t, unsigned long, size,
  * unmaps a partial VMA mapping.  Does not handle alignment, downgrades lo=
ck if
  * possible.
  */
-static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+static int do_brk_munmap(struct vma_iterator *vmi, struct vm_area_struct *=
vma,
 			 unsigned long newbrk, unsigned long oldbrk,
 			 struct list_head *uf)
 {
@@ -2922,14 +2922,14 @@ static int do_brk_munmap(struct ma_state *mas, stru=
ct vm_area_struct *vma,
 	int ret;
=20
 	arch_unmap(mm, newbrk, oldbrk);
-	ret =3D do_mas_align_munmap(mas, vma, mm, newbrk, oldbrk, uf, true);
+	ret =3D do_mas_align_munmap(&vmi->mas, vma, mm, newbrk, oldbrk, uf, true)=
;
 	validate_mm_mt(mm);
 	return ret;
 }
=20
 /*
  * do_brk_flags() - Increase the brk vma if the flags match.
- * @mas: The maple tree state.
+ * @vmi: The vma iterator
  * @addr: The start address
  * @len: The length of the increase
  * @vma: The vma,
@@ -2939,7 +2939,7 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
  * do not match then create a new anonymous VMA.  Eventually we may be abl=
e to
  * do some brk-specific accounting here.
  */
-static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
+static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *v=
ma,
 		unsigned long addr, unsigned long len, unsigned long flags)
 {
 	struct mm_struct *mm =3D current->mm;
@@ -2966,8 +2966,7 @@ static int do_brk_flags(struct ma_state *mas, struct =
vm_area_struct *vma,
 	if (vma && vma->vm_end =3D=3D addr && !vma_policy(vma) &&
 	    can_vma_merge_after(vma, flags, NULL, NULL,
 				addr >> PAGE_SHIFT, NULL_VM_UFFD_CTX, NULL)) {
-		mas_set_range(mas, vma->vm_start, addr + len - 1);
-		if (mas_preallocate(mas, vma, GFP_KERNEL))
+		if (vma_iter_prealloc(vmi, vma))
 			goto unacct_fail;
=20
 		vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
@@ -2977,7 +2976,7 @@ static int do_brk_flags(struct ma_state *mas, struct =
vm_area_struct *vma,
 		}
 		vma->vm_end =3D addr + len;
 		vma->vm_flags |=3D VM_SOFTDIRTY;
-		mas_store_prealloc(mas, vma);
+		vma_iter_store(vmi, vma);
=20
 		if (vma->anon_vma) {
 			anon_vma_interval_tree_post_update_vma(vma);
@@ -2998,8 +2997,7 @@ static int do_brk_flags(struct ma_state *mas, struct =
vm_area_struct *vma,
 	vma->vm_pgoff =3D addr >> PAGE_SHIFT;
 	vma->vm_flags =3D flags;
 	vma->vm_page_prot =3D vm_get_page_prot(flags);
-	mas_set_range(mas, vma->vm_start, addr + len - 1);
-	if (mas_store_gfp(mas, vma, GFP_KERNEL))
+	if (vma_iter_store_gfp(vmi, vma, GFP_KERNEL))
 		goto mas_store_fail;
=20
 	mm->map_count++;
@@ -3028,7 +3026,7 @@ int vm_brk_flags(unsigned long addr, unsigned long re=
quest, unsigned long flags)
 	int ret;
 	bool populate;
 	LIST_HEAD(uf);
-	MA_STATE(mas, &mm->mm_mt, addr, addr);
+	VMA_ITERATOR(vmi, mm, addr);
=20
 	len =3D PAGE_ALIGN(request);
 	if (len < request)
@@ -3047,12 +3045,12 @@ int vm_brk_flags(unsigned long addr, unsigned long =
request, unsigned long flags)
 	if (ret)
 		goto limits_failed;
=20
-	ret =3D do_mas_munmap(&mas, mm, addr, len, &uf, 0);
+	ret =3D do_mas_munmap(&vmi.mas, mm, addr, len, &uf, 0);
 	if (ret)
 		goto munmap_failed;
=20
-	vma =3D mas_prev(&mas, 0);
-	ret =3D do_brk_flags(&mas, vma, addr, len, flags);
+	vma =3D vma_prev(&vmi);
+	ret =3D do_brk_flags(&vmi, vma, addr, len, flags);
 	populate =3D ((mm->def_flags & VM_LOCKED) !=3D 0);
 	mmap_write_unlock(mm);
 	userfaultfd_unmap_complete(mm, &uf);
--=20
2.35.1
