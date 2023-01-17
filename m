Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C721466D456
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbjAQCfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235342AbjAQCe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:34:26 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB5C29E16
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:34:24 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H090DK000916;
        Tue, 17 Jan 2023 02:34:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=36JAGIZf38/lpBpFg+73pEHL2NcMoDYWMP+UVv9tirM=;
 b=GcX/0dcuXe8O8i9/0nL+THgwL+0vU9KjEj6BVer+Q71VxVfWrY+ZxA7vsxRIILx6UaXV
 jLV9WLujASAijCn7bQCrzfZwfz813HUn9bag6xTK+wtEwF3OzcbUtFbUCbIhHYvXuS3q
 pZ9qaZdqkRf7RhatF36yIXVnTWzHxxVlJhJAGhh/NJrnZ9GSB2Y/0b0gXtErudUR04qt
 eUJGVExeWpXVXeNM56GhZ3nLbI3mQFChjBwakpNyn4etXRBlP6xF4C1EP+CtqgsJcCzv
 LY4UWIA5kulExRo2GJO7G8Yh9SlEAF03aRiO0BnmROamEfdb4LJrijfuKjP9PVbLcHIC lQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3medbqb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:15 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GMM4rd028480;
        Tue, 17 Jan 2023 02:34:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4s2rfxkx-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lG/tKZSMM5LWDFGrEvqtv9lDtpuMvFqIT9DDnqD0HTqjg9+cBiH2r3wZQnHGPrToHh/GLrkO9jreMIElgZi6g0z0WB6+KY+tbqswz9DSc1Y0iuPOTIJUX9FM3pa4pGMz2mqlGLGoGp5lT0+l/UwEKsW/xEcjLlPV4TpR9LP900xZF8NLuYjhONLHwoXGMIl3II/OepAca7FkrWnUD6cTGxFyC38fprWRgiP++EHD6H9zF0v8wRDwOynXGv0XEnV7BEov7bnVfDCsgH8YqBJf10IF0XnTJ4ZpR8njGb4/2Ts7MJB3BJyjBlCCdGLen4MwNcLfGVoIrt9I95NuPKclYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36JAGIZf38/lpBpFg+73pEHL2NcMoDYWMP+UVv9tirM=;
 b=cYhDzZ9Kv0x7zFhkFPNuaAnYJqeKp0wSlawl5J5q2FN+0POcfeTzZewbpHqskn/s9hizrYwPT/ExbOTgNhSCmvvscD9b68Bkrqv1rDq0LVqYnUVL7JPzuz3yMljcVhVkUm+dZTmi0p22KdbAOcMV8NmzSPu3nhzPUo5/ZadT+sVJzawqw19SLupZR3hvQOtsKd5R3No8ltSJC+kQFFVeSB9jFem6D/JzxIfopZRtqB6GxcruAqBEYO0gZV7vaaL+A6mqLQZRw8tpa9yaFvo8gfDlHAGeU58s4v+hXaz+yOtZJlKZBKTBoh6/XtRQj/ntImWZpp90b0jceYj4RvXwKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36JAGIZf38/lpBpFg+73pEHL2NcMoDYWMP+UVv9tirM=;
 b=RC/uU/AUmgf+AelqxHinV7tkyQB3jrj+4DFu7o1dHvMKK1v6DNFfxgi8N95hdMfK4oryAy/g4gAa/cGrNbT0X3xxwWmJUym5nsDKyOgczPkzCnwaCKMq3skw2vjq2WlfUDKjS9Tzifln6jUP0nRgSpq4IK28kNxEMrf0JEwnCyM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5356.namprd10.prod.outlook.com (2603:10b6:610:c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 02:34:12 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:34:12 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 07/48] mm: Expand vma iterator interface
Thread-Topic: [PATCH v3 07/48] mm: Expand vma iterator interface
Thread-Index: AQHZKhwuu0TfnkSVqkiRBkX6J0VWXA==
Date:   Tue, 17 Jan 2023 02:34:11 +0000
Message-ID: <20230117023335.1690727-8-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CH0PR10MB5356:EE_
x-ms-office365-filtering-correlation-id: e42f6d1a-6611-4710-b4c3-08daf83351fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ym9ZrrQxUKkV1FWzFt8iU2Ib9YZORkhRAIotQga+NxZ272/liW+78Kz2LgxDoLXi5rSzd6rOSfsoKJgRSVfPdUZzWTdQ6J838LeNm9anJN7Jp9ASZah3VMWoeQrz7Y6RV2reL60l5Hu24sYfjBltjqK7V5IPP4UBRcAwEO7fnBf0u2SiL2MksbEkvmbMtmzZi/Al81opJ6Slb+zls5T5HTrMaOIhqK5kG7VLpbVOBlYQ29NFJrWBuBCLw36VsOSssWkeekRSLD1X7TYNHkse9U0+fGySqyY3WYxk0jyv9b+JmXH4apG5O8hBo7IaDW8PDTJ/e9gUULpnVtyGHLMDwmPIOhCqgpZQeLA0kGQj17DU0eUmpfELVQLCcN+mhFwbEu2I27gyxtYUXYyGYQGEeXUkvK7Idc4C4Gpr+fQuuCSN6C9F0lvV6Pb7PUp2Q440ZNH0CQePSZE7WPWVk6egnEWou7TNiwViscKUrwdrq5RVrWyPr1bpgDTDbzFHUUrJcmitx0+6uNxGnga6RU4yL/ulpjtPk0wn4ubH6zYv1KlI8itZuX8hkcO2ZDucY3BXp41lx2MiaMn7kOU8xDJVEovM5I+SWmoMIbZaBZjEJN4gBx4F5Pd1XGPqeepyOOf+Xd2JS22hapX6/YXc62F+PU8jf24/91mZDFx0mDESw6xyUkkkHsvza+8NuBmu6eYvFy6Bf3RPt92QjIehHT5zEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199015)(36756003)(38070700005)(5660300002)(8676002)(44832011)(8936002)(4326008)(76116006)(66946007)(64756008)(66556008)(66476007)(66446008)(2906002)(83380400001)(38100700002)(122000001)(478600001)(54906003)(71200400001)(316002)(107886003)(110136005)(6486002)(86362001)(1076003)(41300700001)(91956017)(2616005)(6512007)(186003)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7jm9xFa95s5oaRvR33jHgKajAaJEWG2H+Doj/9FOroeKOGUA9mJXbxfpTg?=
 =?iso-8859-1?Q?r/9oCQSQpXbncD1wlCIJsTREyqWameAY9HpWYlBeCGtztObBqwOmsO6BOZ?=
 =?iso-8859-1?Q?wj5qq7gg5Eno+j59tPie18aIGpeMycTyyC9b38k7CHEF2e/cQgtI9ljKaT?=
 =?iso-8859-1?Q?KMpetbaU14egSVkBW5ABNNQCOlFoL3uqP/KRxSIY54t/Lhbpb3LF8+ReLs?=
 =?iso-8859-1?Q?pJRGA5GRjGDeRE8Vf2+Va5xjQvtxvf3neKomA9Cp441+0qPZ89ThXEGwqm?=
 =?iso-8859-1?Q?l4bYwfpAMwVj0mqKbrMW5lyqWJtCr5PNKO69ePQh22IKZqsDBvL+a9vWvb?=
 =?iso-8859-1?Q?r7ek5uokMUAcwR/ZjTl5vJatJLdaa6C5VB4FB/qxANIlQ8mWZNQhF8F8dr?=
 =?iso-8859-1?Q?0Mw2BQBqDX7ik9jp9kTcFXYmVFoZNjzPInZZkb2bfT1x5knJSylD6jO7CV?=
 =?iso-8859-1?Q?Awx2fKYd5Ak1JjqPj5pDoGoYbLtmp24s3yM7JVhWNhJrL4slml+c1o/mgw?=
 =?iso-8859-1?Q?UGINfrrAAfDFomgN7IRToz6fOZ/Oth4G9bbvGUjl+ZSyX1KkXloXlggQMp?=
 =?iso-8859-1?Q?F5/g8Zps4+SbwXYRBmpwRbmG3JbnnHLsTmaGzBcfLC10CIXogCIqB5xKhz?=
 =?iso-8859-1?Q?bLu1RtPB4DFuu7Kw5xFgl42bxP9G9kizq/pAPLsSfS6fidQn8Vt29/0ark?=
 =?iso-8859-1?Q?R/jnbFEfol8UZL6E4FeHQnlf0SXq1odWZGUcAhdeAKi/djzArzXquF3Rez?=
 =?iso-8859-1?Q?95GfuDDVfregrOLA1TusqybXoLyaioOud36m7J2OfB9OMPMw3yo1kX9b2n?=
 =?iso-8859-1?Q?sLdgqxKIHzspGXqE3P/rQVBt0XBuJG9xJgMZVrpW9nbw8wmOz2IT5bV9cY?=
 =?iso-8859-1?Q?I2PTW+FvhBF8TkhUmoypDQQpKMxEUBK1OItF7XK25ASE//m35COxa4AlEY?=
 =?iso-8859-1?Q?P0LJ1TW6cUzHz3ADukTPcokSFVePrvyDuR2XIAV4+chJuQSNU7bgSIYbRE?=
 =?iso-8859-1?Q?Bvu7W2L16T/EcKeqnJglesH3qYlDWhcFV2lf/SMGhwYGz59m/hmSs5LPhh?=
 =?iso-8859-1?Q?IUgjxDQEpDBmvXpngAKIaAFNXodWDrpC5mVLuRToDqAp+lIUWNwy0Hq2bW?=
 =?iso-8859-1?Q?NvH1vcKgkWn6OTfB+2Xe1utEGgCyRNc7cOUrN3nN/HsxdEtegDXP2A+XhD?=
 =?iso-8859-1?Q?5XBA+gNli0pTmQnlRG/RQf5eR/PuX38QJ1tq51QxngqSabumbYygBb+qf9?=
 =?iso-8859-1?Q?oRjFeXH/1+EJsBWFsTfyBPElDo8PQiLIakY5MG4asLDV2yltvlWgU+MkJp?=
 =?iso-8859-1?Q?S85wDT7Rj7993c6dg98zkQc+YwEViwrhYdNzh7iiwPYQ39x2THTMFRX38E?=
 =?iso-8859-1?Q?zppeQpzeBqnCpDon7jIqvA+if2HCf0kohgcxTvhvNhytq+wVNEfW+bGG6g?=
 =?iso-8859-1?Q?6G3tjCn9rEQOUTJywb1DN4k+IKAht/+y5aELyioJXgZzD+WGauWhfAkbDW?=
 =?iso-8859-1?Q?bKjoApeS38N918WkWvYlD0mbLxeHPQpli2GU+Mzv8tM5qc6MnCRb+yhfLQ?=
 =?iso-8859-1?Q?36bIBUZjFzdwENOyxYZZa4qmzC7GMAyxAW7KYUo2QPEyLGLSGomxUBno0k?=
 =?iso-8859-1?Q?K6DDFXEpI++uLnuIuGCf1yCm194uCaz2d9S2344t3NZVoT714l1myRdQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wP369BdOWKGEBgL9JwNGJ4WSHLL/gSOQDjjvvB64avxI6bzZ7WIZ4AVnkaXOMXFFUoLzWy7cSc1ZHZXDp8oDNruYYdOy+ejagncODcFSln08w8PLSPYb4EOgL8BykilfI1Z9WBQZWVXo3ZjMM4pD/buSeL7e42PO1sQor6sNvrJnBH/74wgkCD8Gqy8qxW+BgzG1s/qW/zdUEvzmRDWxJ549kasQEqUIF1DDRtzH4/WFjTLgKnKGRwyaIXodtzSez+b8RXBE2lQEVJU2ztQVd6orHSkB35XlL3wX2q38OZthJiC3lzucIHWGuVSfE/osDmRLRpF6xj9xa8Bk3rkFCk0A0sCzBdpidxFRCraQmXy9qgWYjac0H50/o4NgO6wzs7QvKw82aY9L0mdlCQn/RSp04lYU2r14EA4aN5PhwaEzKxuE/J4VQs3tLc8MSTCc9Cb9zwdqHx4QUQWZ4WnbHwlYuWbQaxKMUMKbzHjQi7BpVNGyBsAXaYD2RuokuAnuvqfoPR1owhhxWGLMm5emxwnL/kYaEwA3jQxP/DjjulrUZLHOzbpEjJjh3FuWcAd7fhWJEEZDw8rQ+Yab53JDgDkrE/zJM+tYUVS9BolbxZ913adyITIIP+gVM5Az6bXFm1m6jWr3VwvhAp6TbZKFNKbLG1jiO+EKsbuD74nV6TbgDTD2u0cn9/bUea9ZpZ55tFIYnRb+PQN4HU5CFwiXcpEyub2vxhyVeVX1XIe/8zmv2YsA8ETScbsOeDfACDy9ZijdJp/WpsJgdN2S/DUNvJFDB82ys9QggGwY+hS8/FKAeDgoapN8xUn7/LF2HKpCHa/OYSa6DfdiS+q3ekabtt6IcgrJlE+8hovVUM4tJxFBS2zGbqA1M5gKoAp0bhJvCSX7QJThz/qrQlwgc9+1bw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e42f6d1a-6611-4710-b4c3-08daf83351fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:11.9377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qgmeQvyMyF9Lgolv7K48AZyO5g578/dIQ+ZYZPRADRJHo7K5HBGCwLhfZ2hWVTE0G/SVtMYbolgXHrZ3AC+xcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5356
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170017
X-Proofpoint-ORIG-GUID: YpURCZzBbO_rDxZ7OCqe_vnvmRArCnXO
X-Proofpoint-GUID: YpURCZzBbO_rDxZ7OCqe_vnvmRArCnXO
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

Add wrappers for the maple tree to the vma iterator.  This will provide
type safety at compile time.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/mm.h       | 46 +++++++++++++++++++++++++---
 include/linux/mm_types.h |  4 +--
 mm/internal.h            | 65 ++++++++++++++++++++++++++++++++++++++++
 mm/mmap.c                | 18 +++++++++++
 4 files changed, 126 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f3f196e4d66d..f4b964f96db1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -665,16 +665,16 @@ static inline bool vma_is_accessible(struct vm_area_s=
truct *vma)
 static inline
 struct vm_area_struct *vma_find(struct vma_iterator *vmi, unsigned long ma=
x)
 {
-	return mas_find(&vmi->mas, max);
+	return mas_find(&vmi->mas, max - 1);
 }
=20
 static inline struct vm_area_struct *vma_next(struct vma_iterator *vmi)
 {
 	/*
-	 * Uses vma_find() to get the first VMA when the iterator starts.
+	 * Uses mas_find() to get the first VMA when the iterator starts.
 	 * Calling mas_next() could skip the first entry.
 	 */
-	return vma_find(vmi, ULONG_MAX);
+	return mas_find(&vmi->mas, ULONG_MAX);
 }
=20
 static inline struct vm_area_struct *vma_prev(struct vma_iterator *vmi)
@@ -687,12 +687,50 @@ static inline unsigned long vma_iter_addr(struct vma_=
iterator *vmi)
 	return vmi->mas.index;
 }
=20
+static inline unsigned long vma_iter_end(struct vma_iterator *vmi)
+{
+	return vmi->mas.last + 1;
+}
+static inline int vma_iter_bulk_alloc(struct vma_iterator *vmi,
+				      unsigned long count)
+{
+	return mas_expected_entries(&vmi->mas, count);
+}
+
+/* Free any unused preallocations */
+static inline void vma_iter_free(struct vma_iterator *vmi)
+{
+	mas_destroy(&vmi->mas);
+}
+
+static inline int vma_iter_bulk_store(struct vma_iterator *vmi,
+				      struct vm_area_struct *vma)
+{
+	vmi->mas.index =3D vma->vm_start;
+	vmi->mas.last =3D vma->vm_end - 1;
+	mas_store(&vmi->mas, vma);
+	if (unlikely(mas_is_err(&vmi->mas)))
+		return -ENOMEM;
+
+	return 0;
+}
+
+static inline void vma_iter_invalidate(struct vma_iterator *vmi)
+{
+	mas_pause(&vmi->mas);
+}
+
+static inline void vma_iter_set(struct vma_iterator *vmi, unsigned long ad=
dr)
+{
+	mas_set(&vmi->mas, addr);
+}
+
 #define for_each_vma(__vmi, __vma)					\
 	while (((__vma) =3D vma_next(&(__vmi))) !=3D NULL)
=20
 /* The MM code likes to work with exclusive end addresses */
 #define for_each_vma_range(__vmi, __vma, __end)				\
-	while (((__vma) =3D vma_find(&(__vmi), (__end) - 1)) !=3D NULL)
+	while (((__vma) =3D vma_find(&(__vmi), (__end))) !=3D NULL)
=20
 #ifdef CONFIG_SHMEM
 /*
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 3b8475007734..3cd8b7034c48 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -904,9 +904,7 @@ struct vma_iterator {
 static inline void vma_iter_init(struct vma_iterator *vmi,
 		struct mm_struct *mm, unsigned long addr)
 {
-	vmi->mas.tree =3D &mm->mm_mt;
-	vmi->mas.index =3D addr;
-	vmi->mas.node =3D MAS_START;
+	mas_init(&vmi->mas, &mm->mm_mt, addr);
 }
=20
 struct mmu_gather;
diff --git a/mm/internal.h b/mm/internal.h
index bcf75a8b032d..1c3eb70b7a7c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -848,4 +848,69 @@ static inline bool vma_soft_dirty_enabled(struct vm_ar=
ea_struct *vma)
 	return !(vma->vm_flags & VM_SOFTDIRTY);
 }
=20
+/*
+ * VMA Iterator functions shared between nommu and mmap
+ */
+static inline int vma_iter_prealloc(struct vma_iterator *vmi,
+				    struct vm_area_struct *vma)
+{
+	return mas_preallocate(&vmi->mas, vma, GFP_KERNEL);
+}
+
+static inline void vma_iter_clear(struct vma_iterator *vmi,
+				  unsigned long start, unsigned long end)
+{
+	mas_set_range(&vmi->mas, start, end - 1);
+	mas_store_prealloc(&vmi->mas, NULL);
+}
+
+static inline struct vm_area_struct *vma_iter_load(struct vma_iterator *vm=
i)
+{
+	return mas_walk(&vmi->mas);
+}
+
+/* Store a VMA with preallocated memory */
+static inline void vma_iter_store(struct vma_iterator *vmi,
+				  struct vm_area_struct *vma)
+{
+
+#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
+	if (WARN_ON(vmi->mas.node !=3D MAS_START && vmi->mas.index > vma->vm_star=
t)) {
+		printk("%lu > %lu\n", vmi->mas.index, vma->vm_start);
+		printk("store of vma %lu-%lu", vma->vm_start, vma->vm_end);
+		printk("into slot    %lu-%lu", vmi->mas.index, vmi->mas.last);
+		mt_dump(vmi->mas.tree);
+	}
+	if (WARN_ON(vmi->mas.node !=3D MAS_START && vmi->mas.last <  vma->vm_star=
t)) {
+		printk("%lu < %lu\n", vmi->mas.last, vma->vm_start);
+		printk("store of vma %lu-%lu", vma->vm_start, vma->vm_end);
+		printk("into slot    %lu-%lu", vmi->mas.index, vmi->mas.last);
+		mt_dump(vmi->mas.tree);
+	}
+#endif
+
+	if (vmi->mas.node !=3D MAS_START &&
+	    ((vmi->mas.index > vma->vm_start) || (vmi->mas.last < vma->vm_start))=
)
+		vma_iter_invalidate(vmi);
+
+	vmi->mas.index =3D vma->vm_start;
+	vmi->mas.last =3D vma->vm_end - 1;
+	mas_store_prealloc(&vmi->mas, vma);
+}
+
+static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
+			struct vm_area_struct *vma, gfp_t gfp)
+{
+	if (vmi->mas.node !=3D MAS_START &&
+	    ((vmi->mas.index > vma->vm_start) || (vmi->mas.last < vma->vm_start))=
)
+		vma_iter_invalidate(vmi);
+
+	vmi->mas.index =3D vma->vm_start;
+	vmi->mas.last =3D vma->vm_end - 1;
+	mas_store_gfp(&vmi->mas, vma, gfp);
+	if (unlikely(mas_is_err(&vmi->mas)))
+		return -ENOMEM;
+
+	return 0;
+}
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/mmap.c b/mm/mmap.c
index 87d929316d57..024fb46251e2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -144,6 +144,24 @@ static void remove_vma(struct vm_area_struct *vma)
 	vm_area_free(vma);
 }
=20
+static inline struct vm_area_struct *vma_prev_limit(struct vma_iterator *v=
mi,
+						    unsigned long min)
+{
+	return mas_prev(&vmi->mas, min);
+}
+
+static inline int vma_iter_clear_gfp(struct vma_iterator *vmi,
+			unsigned long start, unsigned long end, gfp_t gfp)
+{
+	vmi->mas.index =3D start;
+	vmi->mas.last =3D end - 1;
+	mas_store_gfp(&vmi->mas, NULL, gfp);
+	if (unlikely(mas_is_err(&vmi->mas)))
+		return -ENOMEM;
+
+	return 0;
+}
+
 /*
  * check_brk_limits() - Use platform specific check of range & verify mloc=
k
  * limits.
--=20
2.35.1
