Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFFF63C576
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236178AbiK2Qps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236051AbiK2Qom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:44:42 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B47450BC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:44:38 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGP2cV031397;
        Tue, 29 Nov 2022 16:44:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=iMSiY2Kgt8u88AkVi87ujqKYWqsXBtY0fjn9cNqk3nE=;
 b=gtgG+h2s0TvsEG2IADsyWl6XMHWU2iXBb9OR7xbT/l1JeNSPihto/0N2a6P/AM8/iWzX
 zuXLmu9nuyrZcbiVoBy2OYVMQGr4qKRz/C9zAqtj4OZN5PmAq2N8U9yNQieja6/A1Nw+
 bchpLHltiFUMPnv6DgRiMN5Bh1ydk/yl5Ydj8s0GSsnwscrkhOPCXVVpjTJwK2PcsYXm
 BCO6qnbSr5fiST+4QPSHNQZkuTNj+nBXGjFvftvcDjB7Jjn+EP0C/UaboJv1u67hoAqU
 YwfQWX8fZGXUbxE+gfYpd/rDTxhh9nxjiJu5hMhLzyHDrttrdCvx223hCg0LKkd054Cb lQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m40y3xaru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:32 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATFQMIa027905;
        Tue, 29 Nov 2022 16:44:28 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m3987f2a8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nt/R1xSwJk3ZTgG5E5cK9pRjMniIbkp2pvhjVCghQHzjx+yThYmD+SQ+q9JrbS+oAY1/TATONJQ8tI9XHzMYLxnHc9jQVl6tuHaJYffjrsS4QdR6h1E+toFsLsbJ9o69O4xqha3mF1OpN+5VKM6fe6L1Okpmh6+UcYUQUFzGAMzAT+jco/JGGj/7MZ3ZgD0vLQCC7+kyQbKvD1KRSTFU75s7IxgRG3vNjRvco1+fjdRLrB4nWgSZG+Yn9ZNdOZ8SsMouYMlhfVEwMdbs4oCSAA0MaTUz9rD8tv298HEiJawPKCpw/Cq3o9SD4KHiCaceKDahLen7WNHv/EjzazUiAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMSiY2Kgt8u88AkVi87ujqKYWqsXBtY0fjn9cNqk3nE=;
 b=cRzjf4W/fGovPmE17I9+PcHTjXtrAYB3cjTqXM1yXexJA6dpeQk2jOAHXxuVkTjAaDmI1W33nHEXtDpyk5VxmXcnviGcQePCkg2lkHfv4FZBAvdYp6lm7mX3i+hYEkVu1SLGfQcEIfIdLa6wcGFnD+agnPP+7SVpUT9LzpnwF0UkyEvnjI9gvViVX80AKFnQUmGG+OTtTNekVp11ANN86+XJhv2WPIzIlZKaNe+yBqFVWOycnDhlJliyJum7CMQlFE099Xn4HQcQUqVJQB6Xuczo2/iLnsvut3CfkhZ/LtkdeOPaAW5DD0HpJacSM86UuBY8q5iVU5GN6I3KqmXarw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMSiY2Kgt8u88AkVi87ujqKYWqsXBtY0fjn9cNqk3nE=;
 b=lCFNIz9XmnYmBB6tbdBU33IY0J88sa1dxT88VhCkakWQJK8W3mYHcdlArVUd4mJiJgMa0I4TQoqwszvzMELM7R/FRUcnNlVcGprUUmaMEbwN3KBVSpQhWUyEHyRLi6JavfbRFgg6+A6OWLZtkAK3Ovm1mMCOP/V+F/mMnB7vpbQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5321.namprd10.prod.outlook.com (2603:10b6:610:c9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 16:44:26 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:44:26 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 11/43] mmap: Convert vma_expand() to use vma iterator
Thread-Topic: [PATCH 11/43] mmap: Convert vma_expand() to use vma iterator
Thread-Index: AQHZBBHWGrAasNG0ZE2gooJ8S2qJig==
Date:   Tue, 29 Nov 2022 16:44:24 +0000
Message-ID: <20221129164352.3374638-12-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CH0PR10MB5321:EE_
x-ms-office365-filtering-correlation-id: 5ba2bd15-f94b-48ed-7839-08dad228f9f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 24/7pc8ix3rNoeEcLgFExK53zcpyD5mfWjttXCqL3XGZOqoirwGDkQbGAv0NDmUWaLS0en5+cKj2x4zsr9nYtfVEaQELmqeIzQsP43avRtkk9jvINBxTfHKOSAFKu4EmpAMgbAONlMye4K8ikl2CyMik3KDbc/Jqqd9B359k4lhE5mT2JZEcG/hQ98rx1fmKj4J7Yfoiv5zLaAxA/zEXt6ZSYl3v/fHRrpmxqiCjdkxNXp8MLtuvaM2HNE/adf5IsMQxJSluXJAc1LGADM3wM4P6GTALgKm2BscRYiQDrufODkoWPkMQo6iIzuUENLsCpFyvfhWGnUJz/lM60DD2rYn99wPtR+y173kvuqW0rRhbtakNyOdYcIgUPFKHfbLLj62nTjgBb5S7rDPlwhQNgfFkaoAT7YJBkEXE5op0wUV+BE9K97gTpvx35rApC3MOrQCrYuSWNqAOR0Pz2OhnWIMWmvbjB+adm0A0Fqo1A0+cdUE6G47Djx4ZZ5OZesI9XDQ0gk7vmpMr0zJzQ+hAIZAlNYWGAKSpApALrd8lJ/ugBjpsiJ7hUhP/3YIY/NtvkCPwzNFeo10nnO1bh8vEG6PJ4Tn01YtQTPcoCMVHaPf7j0NOm8ExyCVYffcwzXzQVL4HWJsv4oYNjerZE3mTkVPB+r1AAIfWVVC9aA/ZfXDIbgeJ8ZV4ubvOArK7New+7U+XFanUeohryw2s+wQHsg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199015)(83380400001)(54906003)(71200400001)(6506007)(107886003)(110136005)(6486002)(86362001)(36756003)(38070700005)(6512007)(38100700002)(122000001)(2616005)(26005)(1076003)(186003)(8936002)(5660300002)(66446008)(478600001)(44832011)(8676002)(66946007)(66556008)(64756008)(76116006)(66476007)(41300700001)(4326008)(2906002)(91956017)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?U4DhNDUqhg2ItnJO9mkE2ZlHFJ+TcG7k3ZExKOVH9v4lpbhTiBZo4ZCnmw?=
 =?iso-8859-1?Q?64v4283Lk7PSXLxseiUHY+6eSdBiU9ksWs0YxkI54hlxOXvwYPbqip+Iqt?=
 =?iso-8859-1?Q?o38b1E9ET9Fy2MMQT6yGzCn4SP5DVpZipCTaTCVpdcdVmZxJC+p7NYmSds?=
 =?iso-8859-1?Q?gpQKm02GO5Nr78fSGI8jUBGFtYbhSkSO8DB2vVlOLkSsh+QDYJ9SLxNdLd?=
 =?iso-8859-1?Q?wA3oMDrAfKMxPGWe1hlPa/KXmI2UHEqeM2dZIFqGbElSXZ4Ac0Wg9MLdgK?=
 =?iso-8859-1?Q?BVbRGjJfOeffg9vULN+3BdFXn22x+3TrwIy3iuloNEAnkok/mYLOKBlchy?=
 =?iso-8859-1?Q?NPOlZrtnnMew9auq1xeS9AXapgrtAJrCuxLG7M4uFTFvv3U8TgZ8yHYY60?=
 =?iso-8859-1?Q?jvvQ0jjnAonDa1cYpztmBJX/VOLLS+pRw6z/2L3JXVhdxq5zqrgrhf8+6J?=
 =?iso-8859-1?Q?ghVhDb+uqeb7abOnQKd46UlgSWR5JJzHJdWZx7q8FKG6PHA8Azq8mHLQoO?=
 =?iso-8859-1?Q?0Cn4poI2C5KLdJ7Rn5BcN6hrYjxqpSY4QtaEPlyGfAk36BSFygi3dOZtRS?=
 =?iso-8859-1?Q?Dr9l4Y23QyUeOgNKR7QmiAnktW/T1MXODr4zvsBcP9emghvFFBVqvDMsML?=
 =?iso-8859-1?Q?rZf8lWERUJ9vcxx1IL+6F+s4Mphjaz9u1/gyDx8ty4htOqfKUQLcCQ8IKP?=
 =?iso-8859-1?Q?9x8RnwqblziZ7PibKxOZWfrLz6knJV0OBovAJ6j5/bWxrR5+iD2Xz/Fev8?=
 =?iso-8859-1?Q?auXMVRBW7UpVlsfkdpj36ANc9yr2oaOKHvjPQdEURIMiCTZ8HQ1NWBEfPS?=
 =?iso-8859-1?Q?5ifu8FY7YY4VYIw/yMraAQD11Rb/t+7snFZ0kxnABEt6e1doXxF5SEIfqh?=
 =?iso-8859-1?Q?hXg7Ao1N+OrXC4imjg27r/O95IlMykyyN7a4j4fl27LiDx1uwdBUByS7Nc?=
 =?iso-8859-1?Q?DaNMZdfkWtN5ELgr11dBWtSXtWkEp3SnQu96r9nYMpQWR95lLfgtjcs41X?=
 =?iso-8859-1?Q?oSQpHVHxxxH+1unv9fPS3eViww9JmwMvbtTKZFUvPpIl2GQmqx4ByakpTq?=
 =?iso-8859-1?Q?KHGpUuRHJqyzLbZarPAXEZ8p7gnTQluJEdv0GWV2zqPUJyxauP93TZo3l6?=
 =?iso-8859-1?Q?vXfu8E2SEi+EFaODqk+uaGNYdRgtCSTBVxMeHMGztGvBj3wFlGig3NgJsA?=
 =?iso-8859-1?Q?PSlVM07pw1etznj8ROADHiLeSbjGUIGc6E4HzrxRDgPKq0Qzj0oOzxeM9J?=
 =?iso-8859-1?Q?Y7E/xcqYAmHZWrajDrhalQ/nJ8zumqT82Sb/gYhqgqAVgwORTMtEd/9hDk?=
 =?iso-8859-1?Q?uQiQsZvqpgCKOajzd2IUb1bJxMV8rucrEY2mszyguBbI7vRSyE7IuK/Xio?=
 =?iso-8859-1?Q?JTpTbwG5/tJYQxxbz58M1uEsM7SguB1biLDb/MRixOS426tjsr1gp5JfiT?=
 =?iso-8859-1?Q?CUZT3uEj4V6OCbqi88UNP9KW6VsotP1YLmgJE23rTy/VQGgcT6rcBi8olN?=
 =?iso-8859-1?Q?3I9ac4W3IqMU3bEPYejI+a3/cZTpE+ns8oIwuktsLcbSscPUPHjPNkRDYo?=
 =?iso-8859-1?Q?ju4Ajo7Wh09zU6PRp3T15QsAEqqcs0SIfqHkvrRB1lVcjLZqCdAwoSVzuW?=
 =?iso-8859-1?Q?OHWRDWe1ep+IQOGF0SjAyrTeZ9Qm7x0SOvJRBcbsi+r+f8ZRP14DlBsA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: m6czUX7qhtE9yBZp+4J2C9Y9dxdo2oNdNHSJ+vj39T/4cW6lg2XGlXgj1IVex/cxXc3nqRIgyalgkfcDWIC6e/c7ZGB5oJQdwJZTXf3oEcedAXwrCMqPix1sCpjB540qIYOfhGItcQ1a6edWdWZ+a6ohUfFz/ahlPGJmP89xNPgD5zttVK27AS1ZRf0mjv6DJUvdq5WQfLvng1eesSDppYY7z/O19T6eozD8P27dXHDQZhIkkNaL348DYjtgW+JDf2Ytx+mH/cuVm3cU0f4pf2Ee7rcnSTj3lqHL132mBqayCYQUxrBqOJ98AkWUvHF6dmA+cL7tZXE8PEdeJHEKRJTOD5u0Ia5Onx/mNqrDuhfUp6Y2t7F6unu6+Mf2KA2s/sIJ9N/AJ6j9q4M6V4beCiIfhPXPfl6KCz3C+TSzgM60FKVf0iSIP/GG5AdT3cxXh/okW71i05SbZR3BF8jkRl5CHbwc43OvayVDaYqkeGSWylKKTbt+pZUPc/zJnDM3Gp5xQmcCtYtB3frBFIISegOIIGPaIwPek/6z5bkhudnVccdB0EuIC+V9gN01PxdFWIPEYnes1YjAxwo7hso+nJix3winEnuBN8MYIZ1wyMSGWlGPM+mfA0YCNSwWi4MPxy9fTx9DTa+v+KG1R4zkT20FAOsvDJ++7j4ch7RwMVSWCrHLBtHTDRobCRoSirFPrMVAOzelkwJooYUAQA9EbFd4JOS0q8GsAL6Y+PpXjCnbxikWL1G4sVpIn9KbKEI9Gg880+Ib/EE5XVPWJRUIKkj4HB9HKGKwAq12fDqJNlwz6mVJwhh6xCgzTdSAfkvkOKFppFtuhHIpbkb51Xwd2Oys/KvyHNdxdNPFwvcGaVw5yArfcxWPqfM5n6BXOqpkVzyTXndtBRf4T4Bl7ShRMg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba2bd15-f94b-48ed-7839-08dad228f9f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:24.9261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tctl5q6tNbypH3Lrg/0gOAU20EYD9qXVCSI7wKGCUlTX3QBYibea+CZWoOWgtpRrI+5rcTE/31nNnPdLdnC4YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5321
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290093
X-Proofpoint-GUID: 7yXvXFOj9-zYp5TS_2Y3lyCsTI1fuw15
X-Proofpoint-ORIG-GUID: 7yXvXFOj9-zYp5TS_2Y3lyCsTI1fuw15
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

Use the vma iterator instead of the maple state for type safety and for
consistency through the mm code.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index e2701bc92c1e..fb9dd634b1ba 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -584,7 +584,7 @@ static int vma_link(struct mm_struct *mm, struct vm_are=
a_struct *vma)
  *
  * Returns: 0 on success
  */
-inline int vma_expand(struct ma_state *mas, struct vm_area_struct *vma,
+inline int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma=
,
 		      unsigned long start, unsigned long end, pgoff_t pgoff,
 		      struct vm_area_struct *next)
 {
@@ -613,7 +613,7 @@ inline int vma_expand(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 	/* Only handles expanding */
 	VM_BUG_ON(vma->vm_start < start || vma->vm_end > end);
=20
-	if (mas_preallocate(mas, vma, GFP_KERNEL))
+	if (vma_iter_prealloc(vmi, vma))
 		goto nomem;
=20
 	vma_adjust_trans_huge(vma, start, end, 0);
@@ -638,8 +638,7 @@ inline int vma_expand(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 	vma->vm_start =3D start;
 	vma->vm_end =3D end;
 	vma->vm_pgoff =3D pgoff;
-	/* Note: mas must be pointing to the expanding VMA */
-	vma_mas_store(vma, mas);
+	vma_iter_store(vmi, vma);
=20
 	if (file) {
 		vma_interval_tree_insert(vma, root);
@@ -2656,7 +2655,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
=20
 	/* Actually expand, if possible */
 	if (vma &&
-	    !vma_expand(&vmi.mas, vma, merge_start, merge_end, vm_pgoff, next)) {
+	    !vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next)) {
 		khugepaged_enter_vma(vma, vm_flags);
 		goto expanded;
 	}
--=20
2.35.1
