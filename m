Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8354E66D470
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235505AbjAQCiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235634AbjAQCiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:38:20 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE00C2FCEF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:35:36 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H092Eq001912;
        Tue, 17 Jan 2023 02:35:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=erlJifL/pM9VZTLkd02b/p7GXfmghHwn4xCuNH74+sA=;
 b=gXkwSeoDOi4uiiGGpkQqFVXHdiEnGt0VECCcV+L4LHEy1wVmSYM6yFxv3xT+/Lt8L4Lc
 /nlbhqRlcuJA1yhm9OAcA9egUSbERpfjk8Rxaqf6xct1U8OPreIdj3VT3ejVY6e05Jq7
 VCDsLC5TxKkfGnGkxdRtIuacIFS4w9fxcwEERtuJKPyoohpWZhunckKRsP8fErt+nnVq
 Vt9QgME7VAig27WsjbnNnkDe7JAFqplcKJtRrBHO1QVSb6kutSP/0Mtp4oACCUcJST5Z
 FfNhn+EWejyGD4LtIJBdQ+diojgoaHBF2COKq0j03ouNHnlDO2rC/GRpuJemLBtifvrq KQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3k6c3pr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:35:00 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GNCpCU004918;
        Tue, 17 Jan 2023 02:34:59 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4qyy10ss-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvpfrGHzD1xQOm46PYgEEeZW8Sd0gRpJ3lljuCfqy/jmk0Pn4OVvUpE0Ej7Fw9U25UEcJcVKeMAuzHZsRgBr2A4uZP6PBMlSJcrYQuP2QuGV/Jj8qN9C67gDQYiCaQWxm0hbcb3igfZ33669ntvezLXMI9N4aaaOCMSkQ3X5lU1WSGPe7p+iBzy5RiJt5K1q0EGMAsg7oKv0AfmmdroAPEa7ObE7GtY/Hj+5fcSwBu4LfJi2gsWza/47kIK7L2lYzep9zPENaw+n6HQCqTDgAkndwbnUxtr2bb5JuJRCkzsvRz8d01ysjosuHkO5uFOvdtzBkclT5vjX6oo5zS117Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erlJifL/pM9VZTLkd02b/p7GXfmghHwn4xCuNH74+sA=;
 b=gZBUNJe7SIDoZ1Am+SxOH41tgDI4NNHBWDnEPTi10Kt6hGZvW5fSIdXIkIK4cEBEvifVu/HmWOP1MB+cFcJTU6SiBsfaSbp2DUwbUrJ1IS3HEjBCfEzm5/pv66lNGE+eedI16K0UtMAZg9KJ6zFNEoUl+cI1WRK2M17zDyZwEHAR7vzUnpyAOgf8KnRSW0s+MEGjf5dxA7ulUnIne6hgoc9Jw4Sqhphp46BGC6pQ8mJLwcqDSlgvtyhShx5g3T48lRvDr2cOwmo15a0l4Gofkl3XED121wNIIodvxK4jWN+8CgXN8ac3cKBg9qW14KxFWuR6cCgc73FcN7c6fOZEZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erlJifL/pM9VZTLkd02b/p7GXfmghHwn4xCuNH74+sA=;
 b=NqJS/zsyhykdxPwWQ46T9Q8f8clPOaUpfRK1VQP1GcOaA42rI//KH93CXFbToIr0ltjL9vaWI2Fqdk3z16V1mFISG9jFfz/0R1k6DW5EL7sFOyY1ZoaSzhnycEzNSF5UUGgFf3NwOJ8rd/9ZfMtVS843Yky/slDZpwiSplrAHWA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO6PR10MB5538.namprd10.prod.outlook.com (2603:10b6:303:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.9; Tue, 17 Jan
 2023 02:34:57 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:34:57 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 36/48] mm: Add vma iterator to vma_adjust() arguments
Thread-Topic: [PATCH v3 36/48] mm: Add vma iterator to vma_adjust() arguments
Thread-Index: AQHZKhw0VNTf0xRMOk2uOO/fsdAqCw==
Date:   Tue, 17 Jan 2023 02:34:21 +0000
Message-ID: <20230117023335.1690727-37-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CO6PR10MB5538:EE_
x-ms-office365-filtering-correlation-id: 732c5e0b-a938-4446-646d-08daf8336cbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zijx/42k8MpgfZNrmVPJHnieHTYa2dS/6PdCYqeKIR2LwUsrJhQl1a2SHIk0JQ7HD2mf5wydsKXM8wTHW3JptbsxU14004K72Za83Zs3nI11RgpFfb8znFWqGqbDJYdnmwD8iJeMa/Ws/zHulZxjlCfPC6RI6IDV8tboNzGqb1VqekByeKtTbGd/1HDf67HbMt4Tr8G8IUvKvULYqzQ06uarnWvTcULPh0LfS9IMYZ+zdDDLVrylOSi9n1srVeULRSjvmnj8wmggZgpTPivmKYdwgpju/AtogCueLdDFIXYXWvXqiI0+P/TmQdmeSj7MVSeBC1UuqJo+q61f0o4LUvESEHRcAkCunmNXZ3wzl4e/QoB1iocnC004IjW/1W3VsEaPOQimEQipeMlxWA02NuvM24bSzfQ1ALyoPHKzJ53XHtLeovE9IIw5sVzjRCCQm6dKEfr79CEjipukscj6Z53COir+S0/MD9CLn9deC77/XuoRE+TXFkxc6chDZ/0HbKmBBx/fuTA7ox/nPF5HMydUZatsCc3c1NO0VRkWDVpmPCO88SQXJSazDhwDifQTh8YYxm7XzU0NY04AEKGy0LCw46dXnrAf5V4hs21CmMxwhisSxXrYIwWg6gIScyD0pH3rm+IMxbGx5k8Uy/V5B4UBdLi+ZDabBBfQfAh6RfWwjcdp11jKcde77BGsFbYEfWVwxJRr/57aRbRd8FELog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199015)(36756003)(91956017)(86362001)(8676002)(6512007)(64756008)(4326008)(186003)(76116006)(66946007)(66556008)(41300700001)(2616005)(66446008)(26005)(66476007)(316002)(71200400001)(478600001)(6666004)(38070700005)(6506007)(54906003)(110136005)(107886003)(6486002)(44832011)(122000001)(38100700002)(2906002)(5660300002)(83380400001)(8936002)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/lnxc4t5yBFAKS2zD/sf7ASsnfgM0xzV/xRlyftkyeIMumts9SHbyMfgLV?=
 =?iso-8859-1?Q?HFO16MJmxZhh9u489N/2UZQgH6AGss0AF6DdrVmhn/L5WWn43iGgq4yGcT?=
 =?iso-8859-1?Q?q7e03/X6Ciz3iZz1m5kmtEwtcrTf9NxwDfokZIaL1K54dGvqLEktZJZZ+D?=
 =?iso-8859-1?Q?pKn8Fd/8Nfen8QKI5Y5vKJtTLFiwD4PEBXW2BfXPXWS/so4iS2gm8cC0Df?=
 =?iso-8859-1?Q?Ic2PxvX7obrA7HihlL6a3sMxjQ98T5kDt/d9OWjMB7gvjnNTE+fVlYU8hX?=
 =?iso-8859-1?Q?xO0HWjwWkOqC4zqJNWJ3PM6G8gyFYtxEETL6rfT8q00WLGev5n9ypHW+V6?=
 =?iso-8859-1?Q?oyv3IiiJzk7uZPN+S0zP4GRTbM/pCestp/y/CaFD29O49u4o7fMpgHJkNj?=
 =?iso-8859-1?Q?3au8VJc1h2H2PzMa5qVlfNYyi6tO2MMagekdmFvGOYi02W8+7a1ADr31aE?=
 =?iso-8859-1?Q?amDFE3y1/FmH8l2VE9c9yiu69wVAFC36cCcD8iCj20tPwo/CZlHqEnVAUv?=
 =?iso-8859-1?Q?4sqma2A9w9PoOKcFW1B23GIqpGJpy3t8fDNSVllIsZyKCCVkOCwceasypJ?=
 =?iso-8859-1?Q?5pECHX/e2akNBdFOWXxZkqIqhsPUbqrZzuO9d0jEPgIatdwPOILtslC50l?=
 =?iso-8859-1?Q?RFPT7U+GhFpwYQLgy3K7xFENxyV7M45+bHgBAjrlSh+0yIPhPDRCqdLziA?=
 =?iso-8859-1?Q?YCdtoZrF+bGQ8KnTlMVCoHCtsNKSIx+mzgXRu/WB32zowt8QiTMQA9uwlg?=
 =?iso-8859-1?Q?dJXUdw0kXa46Sv9FEY0sTZg7nGT9dzdEcW5cGgxIevburnidhTGybiOphs?=
 =?iso-8859-1?Q?StbUqdjJtn4HvrJQTZoaXwbZNS/AY/JcSaye2kiTM1YdObW69f0jRm3Ln2?=
 =?iso-8859-1?Q?xrSniMUyLYXPUeyaSKFFJsyhje0/UWZeCJ6S1m9jn8zF1GTjrxvRNWAv34?=
 =?iso-8859-1?Q?EjlEkupJnq8QI3d0hmmjrSKfBJuQPmN+K/NkGr617AMjlJvvXBvkc9FSwd?=
 =?iso-8859-1?Q?L9IY3wG5YmAIjV8EhIYC/vKtOlIpRBEAXbwINtaZ2tCY5lML9ZA+XPiDc7?=
 =?iso-8859-1?Q?LFqIhdJ0eDUXAZOyo4LGYe9StI7WRDiVFt66KZXE8t1202HBoPLo/szIku?=
 =?iso-8859-1?Q?u9xa5azP6PjNJ6KCVZH0nt9zomh0UxdXiwGga179kFzpe9rlvjP3iDJOh6?=
 =?iso-8859-1?Q?ySnWSOqiUDifGB324lD7j55wk6JCSFUyIUS/fBQgBQSDtg+GEIqvY5wKhJ?=
 =?iso-8859-1?Q?gQQotqRs8mQrNRq8mrT5vjDriHT6DkZkGP6EnMNhvEYsYOmmaBG/AgnI2E?=
 =?iso-8859-1?Q?m4+sgK+xGbA9Yq1htMn+6LyOXNae8hTzmze/QFunfwvXancyK7zjuUWXbf?=
 =?iso-8859-1?Q?4n2ItkS2P63i29YA0W6hQ5xohzFV3KOc78XOsxf3cbsTFJQKRReQIp4e/M?=
 =?iso-8859-1?Q?S50mmxsRMUefCezHK8GoZCctw1zRLz/nvfNu/emL3Lp/MGXd2bRmI6Bi8/?=
 =?iso-8859-1?Q?n/scLDy3yVTjF8yNH82tuvN/Tjzz+PWwakeWSx0JAh/BMlKAPOD4W8NJSv?=
 =?iso-8859-1?Q?37dXidixl7EGY852lF0FNmHNC4exwDLAeXc0mUS5z0v2tNcA24HzZ6/2tE?=
 =?iso-8859-1?Q?ZnjC79Z3EGBKF5fW5a3JccQFelKWQrUdwUNkOz0m8oxYZ8BdGo4JFZlg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aYE3J1cVFrU54+P9cEWQb8OyljE1yTwKMzXE2lWRvFmo+2W+kHkLzTuizIKHImE30k3fUlqc2SwsDLhfaACyF10vs8yXgtEzM43bEvbOpVHvfznU68XGTuQPE5Hc9+MJAPUZ7tDQJ3rFs8V999rUVlX+OaCF/D0zPv+rx5UJjJnSEI5cHIkUCsT01HVSmaZA+Iki/A0TjZK4kjQ3qb/c6bPo65twW0C2dIVFnvRECUZR04pyhS8/wRCB1Zj4lWxWXeXYYRTuKYZI6C1l60gKRpHlV5m5OZP4CRSNCKbSx1Qv0UKwgMkz3QlMZ6xP1nCfs55eFLCi76jr2dSxDKW00s8/OawcH6c9KkvB2jzQPCB0zzMsCKBGBGnehtw9pr/Qy8F+YgitFYJUnte4b+oqUlnbAinJ8tW+bKTm+un/3BVEUOPl1vU4xeaCF2wvcKFfaccEQq6fBHO7fif/e83zOziDVYfXE7DNyKICriLU4bBnuxIbNd+rYDTaVV6e2HMN88IFEAYAD9dqtyJDayN7eaR8liUjJiGWQU/Kbokke1hIkjw60gAmIsyAgwI45nh0vVHs4Fk7b/MWNHcJOEK2hAiskgpMZ6jMO+eMvpmyvLiLfIDIe4uJdZw2G9FyqAZCPW+2RIRF835jthDznBDvSvsrxo0z89mzXz3RTMfuxtU5BxlaXmcnpdGSI8bAQtSILtfg51eQZvT07J6c0KGjdz/DCfm03brRii7HjLwaGGqHP+hoZQccFuQeyV49pX14HFNPEUU11gIW+k8Dri6GNzeE0XCgNnasA++E2DcSs72qpRB1Kofr4xTymBqwkYVRdf+CVHzM3aq7lAi6K0vIx06E+23s6eggc+VQTTorm9rYVmNrhnMKpQk4VaL6e7KTCGCxSpQyDmH/VcQG4Vjsrg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 732c5e0b-a938-4446-646d-08daf8336cbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:21.2808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bRB6uezP7b57Ae9eqg6bNcSBTi0+n0p5g28MmioDTD8u+AEDKYeDD0g4Wsq67ieP7uaOsV6KHxrUtXuU0UoWpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5538
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170017
X-Proofpoint-GUID: iyFKIIPW9GIUOcbr5LtteDLKgNUCArNd
X-Proofpoint-ORIG-GUID: iyFKIIPW9GIUOcbr5LtteDLKgNUCArNd
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

Change the vma_adjust() function definition to accept the vma iterator
and pass it through to __vma_adjust().

Update fs/exec to use the new vma_adjust() function parameters.

Revert the __split_vma() calls back from __vma_adjust() to vma_adjust()
and pass through the vma iterator.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 fs/exec.c          | 11 ++++-------
 include/linux/mm.h |  9 ++++-----
 mm/mmap.c          | 10 +++++-----
 3 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index b98647eeae9f..76ee62e1d3f1 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -699,7 +699,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 	/*
 	 * cover the whole range: [new_start, old_end)
 	 */
-	if (vma_adjust(vma, new_start, old_end, vma->vm_pgoff, NULL))
+	if (vma_adjust(&vmi, vma, new_start, old_end, vma->vm_pgoff, NULL))
 		return -ENOMEM;
=20
 	/*
@@ -731,12 +731,9 @@ static int shift_arg_pages(struct vm_area_struct *vma,=
 unsigned long shift)
 	}
 	tlb_finish_mmu(&tlb);
=20
-	/*
-	 * Shrink the vma to just the new range.  Always succeeds.
-	 */
-	vma_adjust(vma, new_start, new_end, vma->vm_pgoff, NULL);
-
-	return 0;
+	vma_prev(&vmi);
+	/* Shrink the vma to just the new range */
+	return vma_adjust(&vmi, vma, new_start, new_end, vma->vm_pgoff, NULL);
 }
=20
 /*
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 294894969cd9..aabfd4183091 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2825,12 +2825,11 @@ extern int __vm_enough_memory(struct mm_struct *mm,=
 long pages, int cap_sys_admi
 extern int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *v=
ma, unsigned long start,
 	unsigned long end, pgoff_t pgoff, struct vm_area_struct *insert,
 	struct vm_area_struct *expand);
-static inline int vma_adjust(struct vm_area_struct *vma, unsigned long sta=
rt,
-	unsigned long end, pgoff_t pgoff, struct vm_area_struct *insert)
+static inline int vma_adjust(struct vma_iterator *vmi,
+	struct vm_area_struct *vma, unsigned long start, unsigned long end,
+	pgoff_t pgoff, struct vm_area_struct *insert)
 {
-	VMA_ITERATOR(vmi, vma->vm_mm, start);
-
-	return __vma_adjust(&vmi, vma, start, end, pgoff, insert, NULL);
+	return __vma_adjust(vmi, vma, start, end, pgoff, insert, NULL);
 }
 extern struct vm_area_struct *vma_merge(struct vma_iterator *vmi,
 	struct mm_struct *, struct vm_area_struct *prev, unsigned long addr,
diff --git a/mm/mmap.c b/mm/mmap.c
index a8908280671f..cc53f638187b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2209,12 +2209,12 @@ int __split_vma(struct vma_iterator *vmi, struct vm=
_area_struct *vma,
 		new->vm_ops->open(new);
=20
 	if (new_below)
-		err =3D __vma_adjust(vmi, vma, addr, vma->vm_end,
-		   vma->vm_pgoff + ((addr - new->vm_start) >> PAGE_SHIFT),
-		   new, NULL);
+		err =3D vma_adjust(vmi, vma, addr, vma->vm_end,
+			vma->vm_pgoff + ((addr - new->vm_start) >> PAGE_SHIFT),
+			new);
 	else
-		err =3D __vma_adjust(vmi, vma, vma->vm_start, addr, vma->vm_pgoff,
-				 new, NULL);
+		err =3D vma_adjust(vmi, vma, vma->vm_start, addr, vma->vm_pgoff,
+				 new);
=20
 	/* Success. */
 	if (!err) {
--=20
2.35.1
