Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B23F65F440
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbjAETSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbjAETQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:16:36 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C646151
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:16:18 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305ISmCZ001344;
        Thu, 5 Jan 2023 19:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=fdS754oOP9KvyPGz3fj9korFEn8Y/p6HOE8wad5P+3g=;
 b=A4EIfExx3JHwO45BKQLFMD+e/ZK6yFf/Fw01MqlkwgtduiRm3Ey03ZS3LvU51iVnx6ik
 1qIc7Hw8yRHZB56HyTgPkY+yVanXp7grWvlX4E+36wO/ktEE56utBNpnZDgwGRLgLTxK
 WYn6I+Y4fkxqvhTEpQz5MSKC3f7aAkS44as0Nr6yUlBojdFaAAQ6gwXUvNlYHIL4rbSB
 JJfYN3tc6gvE6F4W4F+bWX5b54EeKZXbmNRXrPDlKbNTv7wTyoton55+W58r2qlyxU4n
 L9K9Dpnh03QN0WtRYxdGEtY6MpyvXmy+Re107Ja9t/TDDDAs32F8CsRtdFScE8FIIbGv Sg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtd4c9qvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:07 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305Hvlpv023372;
        Thu, 5 Jan 2023 19:16:06 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwept6m1t-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jh0e5Hrbhr6MD3Zwmr3fmq3vIvEMzC1YA+udUIefyH9vemyWBmNj8qfQdVEliZiFJXRYXAk0eCEG3+2PlZNkNh1xxCxJ38+dIy9nK1JN025jWQ0eoU69U2HLLBaQ6Lj2sBImbFyPCG+TxF3VuDvNwuqfwcwov0N5umFWknlnzFkfTgtmGcW5TeiOIup7V1DGSBhViQGw8dN0vmKI5/VQ/lrU+SqYyyNzIVSe9bfQOsMtwKD6nGN1pjYP0cTrYZRv1M3YmYVi44tbYNwx1QVEAoP/blwuSnhMuXSGBb0/mdskptySam/GUdG7M3VYA2F1XrJxRHflS1wOyVdGAGBj/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdS754oOP9KvyPGz3fj9korFEn8Y/p6HOE8wad5P+3g=;
 b=PLyRX1Ar+UsWa8TQKqYtT7XvxCSiXDSeL6DVURCp7WB42vrXbQdWvrS6H1t21zorCMYoNRqLjAGzZRl9wvwMcAhioCLYpkhe/c7jh7rWN64cWho6hOZxODJTzYb7n8HjaZa2qgxSckxjp+XtBVEEh4SUJRXr6ceVpA2NjKjKLoKsJP66RoDq34IcozJGZCT28Ovvq/b5wh3qxU1GgZDLal1ftTAi/aXQvqA/sCkrayMfFt+5GvMDDYt1eRpCinjZpzZ/58vs2L9Y9zKgATx6zuAZlBXJKJdAzs7nZgVKoc1Gfm1OOzY+qD3OVrnFD0949tBJOQuouvfpb3z9GAUUZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdS754oOP9KvyPGz3fj9korFEn8Y/p6HOE8wad5P+3g=;
 b=KlbWu7jS+pLpXNl6VxX9j/pSKKTqBduWZNIGnf0jNXrfP00oL/Tcxu8vHlGC/gXU+KX9MPyO0YBmWjNH2gwyELCQmB1HDRSRTu+9bs7dx6TLWSKJep1eAWm0pGXb7sM5zc1+zJ0VYmcsZvg8Bc13NeF6lWlPHRP4UB5Rt3AoRd0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6075.namprd10.prod.outlook.com (2603:10b6:208:3ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:16:03 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:16:03 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 21/44] madvise: Use vmi iterator for __split_vma() and
 vma_merge()
Thread-Topic: [PATCH v2 21/44] madvise: Use vmi iterator for __split_vma() and
 vma_merge()
Thread-Index: AQHZITokzaZrKFS83Uyh3Nq7XT2mSg==
Date:   Thu, 5 Jan 2023 19:15:58 +0000
Message-ID: <20230105191517.3099082-22-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|IA1PR10MB6075:EE_
x-ms-office365-filtering-correlation-id: 7fab28e7-2289-456e-6fee-08daef51497c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mzoEnhxOj3+ZPwfns/QA+puFI8DwKK6NMRiRNu/lWEHbbM2PIICWLZDb5DC0dRZemX6mo3SkYu+K571beuFlm7Yy0d2BxmoZ0Y2QPYksOUX2YNEPdCQ+Dsy74hNiMFh+gSBlmoQ4TilRlk/qW6mjzuMxUV1uOrZS/1nM8x5DM0sMqydttRudNF23jQRTSEzlA5h/gBMUVXZ7aPNVI6fke5UTkFvvGFs+tKY5Pwa2uodhSxFchYC2k3JL+pY8MmeVGN8cBJwPRgkB+P4egfIOHGadhbGQfYFHDicBeSObIY7kqKYW1DK4uDCKDxpXVgk/oGWx50jGzsOKv5QWyR1HblqdAhsQel02AZWvrPteyVZrJUoglhwgrubAp9mOZ/CknGIXE3zQ1ry34cZU2LIzq9WLZo1gi3WijC457VEUJaGJbLaR42FkPhwVr5zuFK5L4nGdRvKskZEEhVZvBte/TdcBVRuh9HBt2zY7/qKLrIhkd4pRpqqzA2/2vMwnGTso6B2osp/e23oA0P1jlV7m75HpQOmX+3aNQjdtbwf6CgqK55c4FNuauzqh0jUtZcVOzg1Q5LFvlWuUVK1GFoJzu9Iq9AGUtufJ4cryIDzxnWZOAYDcVFvba5nQpYRnj123Z+szCTsLaVcXVdTMYA2YZcCmcujabYCp2HbNd0zWF6XJnYAiBVpTFczeObaQQ0C9WPRhL8y3pz6d5tZNZ+bTrw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199015)(38070700005)(122000001)(91956017)(86362001)(38100700002)(8936002)(2906002)(71200400001)(83380400001)(316002)(66946007)(41300700001)(5660300002)(44832011)(64756008)(1076003)(66446008)(6666004)(4326008)(6506007)(107886003)(186003)(2616005)(6512007)(66476007)(478600001)(8676002)(26005)(76116006)(66556008)(110136005)(6486002)(54906003)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wxNlgEuahGB3yWCWcZx9Rgn47byyC3cAjOyKBHigh/3N/+fqvxjM7ocJUN?=
 =?iso-8859-1?Q?3U85syfJN6XBQkq728tqI8J0qJCGj1dWdEVfwqaSERAoxL5dJwGA2k+aPE?=
 =?iso-8859-1?Q?hP8H8H/rsoIs49Qj5F2H5LhyOl/zU+nATLkpyUtx+IJcJTMtQFDes+7BkZ?=
 =?iso-8859-1?Q?/wxe38yDmitVqBQIdwnpztHBIZJ5TjX7efbKh3CqUMMX3Nu/dqEmJyzeGT?=
 =?iso-8859-1?Q?KDEGTycLzQt1Sy1lXn7qR0NIOix1baiRsHoj+Fd7FEH5w56zl68h/awnN2?=
 =?iso-8859-1?Q?ORUiGUQXBJY6wKqkBzBOju9Rr0cyjQZ3glNaoJZbZce4eaE815JHuZhdP4?=
 =?iso-8859-1?Q?AOF+M7LEfwUZekwhJ1rPww1VHRrA7G/6ofupZ7ZV/mwjThi/Zs/aaIZwok?=
 =?iso-8859-1?Q?eA8Ds1OKhJcETy8jaCniJlvmZrx+AH/H6V6fqFX8XFNzKLAdv2bjEo9F3G?=
 =?iso-8859-1?Q?ynbffzpmBrsPv0Txo8aQUKNaZ7YE/xROBBRmq1QkOvdI0Fx0CmBtf39Z30?=
 =?iso-8859-1?Q?iQ2b0MefTJ6gBi4b2nhQiZBPfxEszS1JevkdsXFOcHN5vXbpPHp+RFsahP?=
 =?iso-8859-1?Q?hu3ta94VX8ZoJ9hT3st1S7yiY9Y+Q9LCpxulC5wRIzqQlPYMX01zwmF+4C?=
 =?iso-8859-1?Q?6Ezp2x0zgil2oFELBN2wd790jOF/AKP30m2ML1wmcy98bdd/oJEEXyYJbM?=
 =?iso-8859-1?Q?OP1IhMhk1UagcM/vGCPsW5TiS+oM3hBoxDn1T24hb2I1VHgqouTM2+yFOu?=
 =?iso-8859-1?Q?DrR4iKxqDFwkEQqg65VLw1m7Y31YmDngOdqt6fAA1/8hbOracDSEl1R0Ul?=
 =?iso-8859-1?Q?3emODWSW+4vB+DLchhYoJejCX/QIzmdl7kW+KDTIxOuENed2ii3ZaoysLR?=
 =?iso-8859-1?Q?OmLpsE9Nz6CuHzM2OfD/NF9a9LVoUeQYDmnr5whFg3sC64fUrH8KBIbO6t?=
 =?iso-8859-1?Q?p+yxtSRCt7MB1d+xYEcNVSql1wqjCWVlzMQFppxG2PJwxrGYMJfB5xYQrM?=
 =?iso-8859-1?Q?t+tvs048EQgl6kwrUPEgxQq/AxVdGrtaCNe3Xvtfk0h/0fQyTj+ALeogIy?=
 =?iso-8859-1?Q?AksFMXuSRUNaV7UvwC1JHjsU5JCaEm2ai0z0xQLBj52SkCMo2d0K+11hzW?=
 =?iso-8859-1?Q?LkQN/qSCLAe+BY5XexcRNl/Ap/Bnsa6rwO53FnMAXt0bUSONRZpt78mcBt?=
 =?iso-8859-1?Q?7un17uZ2DaMddsEiHxnGArS7ncfST/IhvQ2VWa0xKn1iVhRxbA7AdKL6FG?=
 =?iso-8859-1?Q?euY4SVp1xb6FHa4eJsrlx2gOUrBUDIxqXknslVvhACxWzUzqGQsAQ8kAng?=
 =?iso-8859-1?Q?qSv/ddcJMW/70EkZMC2/GW+rPRmIYBbP5n38W4a1Yf82DWEGqRDz5TL8y5?=
 =?iso-8859-1?Q?iuoWjEx1iXovu8eQLKuRERqJsMbdA9M0THLKGTEyCYQ9wOZZ9J0loyNr21?=
 =?iso-8859-1?Q?SSsPio4BcaoUAuLOr25cZt0yBCBQS0e13SnWP3317+Bad2uyQbh5Extepr?=
 =?iso-8859-1?Q?Eum+COYnmicA9+0IXjUZrTUkuYINjx+Ju/EGafxeBJg3QAkDHSE2U6idTN?=
 =?iso-8859-1?Q?CaDBfDnQOinCqjeoHE4x0riNmqtdbKOQguOswT2D/Val6TMHqK9IKHJiZ3?=
 =?iso-8859-1?Q?+tekbSBUIY/v0i6yW7Xlp22Ic6kluxYsHhLnEbCqy4bcR+OJMGmMHO8Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: evivAzzOuF9IHq/ltnsG+KyPpWsEa04j8JOj2O+NAU/O/IKAb1CLVfa2u8a08/dgkApcDbMR25CIvampxNWyU7ru7AefE9z8Zl/cQ1yMafrA8SXI/eOjJJzyoinDoKuPKSNe4S338a1aa5i5XvEUu5xqhbGO42DE3HEp4zqetT8dR7jiRrZkh4Wrg1eSjkqy6u8XWjlCk1+l8rmPQEAet01elaLQa0wNwAyUut4RoMz5MZ2omiG4Z0idNEiIxhGklk8xR16RUzAVCPJt5JuW01stnklcKQzOxB1u87VXZqjSpm3Ta7uUaerNrph0G+nvD8CVAfyRMUHR0yqO43zUrvxLDrmq2TYprnxMegJwwF8Z/fIrgr0eQEwDxiU1WOxSAdp4jvIzoPvJTkhMjPXMMiJCbXkE/MzJRSwvpdfAhFFcp/0fIoKAUiMDhbVHzHPBpW5GSGjphy5SkVwyIFPrS836u8+GZVFDGigTI7lKQ1oNl+NEnUMIGZD8wg7MyZBfh8rc6yDjiRi1awFcBaRSczL1/6nGwZrOb0g3Tb9mpvT7S2cf1J2CmZhjfYAobIkPsahh61dUYfjy4r4akBALhhXc9XfD7Yv8ZuRhM37+ukgu8vPQKvdesLAK7zCBZ0+Jw7/h9Pq+7rTumAWjq/Vi5qzLqdY+z8hwGd/jAbTsiH0lo9d+O2vjnqJnTv00+l42TXLZKgCcBS/dVSzi4ZD3eK0II/t8Td2LP1Wj6oIBRhDlZzBNT5gsQClYauWrMs9zCjxtWCh0rx6vTG85v4+gbznaVttNml93nqdtPj1GSDGJJ1qDpFg2zR0mNh8jk5w2kXp8EneuZNwG1MztCnQkxHVTJ0IdDCkcShPesT+KE2yY8AKUb6RjDEBNIRCW90RuKT5U21UIQB+Dv7MN2IE1ww==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fab28e7-2289-456e-6fee-08daef51497c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:15:58.7193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c/vqmP2o0+/8L3u6ZAKPtdCHpMaUMu6Ece+y9B331xTyzw15oA7G2BZjwzjq1LbDNQmRj3wHx+6S5eSlU/R7mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6075
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050152
X-Proofpoint-GUID: k6w8BHVENM-PUv65R33K8iO_q-AHn7_o
X-Proofpoint-ORIG-GUID: k6w8BHVENM-PUv65R33K8iO_q-AHn7_o
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
 mm/madvise.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index a56a6d17e201..4ee85b85806a 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -142,6 +142,7 @@ static int madvise_update_vma(struct vm_area_struct *vm=
a,
 	struct mm_struct *mm =3D vma->vm_mm;
 	int error;
 	pgoff_t pgoff;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	if (new_flags =3D=3D vma->vm_flags && anon_vma_name_eq(anon_vma_name(vma)=
, anon_name)) {
 		*prev =3D vma;
@@ -149,8 +150,8 @@ static int madvise_update_vma(struct vm_area_struct *vm=
a,
 	}
=20
 	pgoff =3D vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-	*prev =3D vma_merge(mm, *prev, start, end, new_flags, vma->anon_vma,
-			  vma->vm_file, pgoff, vma_policy(vma),
+	*prev =3D vmi_vma_merge(&vmi, mm, *prev, start, end, new_flags,
+			  vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			  vma->vm_userfaultfd_ctx, anon_name);
 	if (*prev) {
 		vma =3D *prev;
@@ -162,7 +163,7 @@ static int madvise_update_vma(struct vm_area_struct *vm=
a,
 	if (start !=3D vma->vm_start) {
 		if (unlikely(mm->map_count >=3D sysctl_max_map_count))
 			return -ENOMEM;
-		error =3D __split_vma(mm, vma, start, 1);
+		error =3D vmi__split_vma(&vmi, mm, vma, start, 1);
 		if (error)
 			return error;
 	}
@@ -170,7 +171,7 @@ static int madvise_update_vma(struct vm_area_struct *vm=
a,
 	if (end !=3D vma->vm_end) {
 		if (unlikely(mm->map_count >=3D sysctl_max_map_count))
 			return -ENOMEM;
-		error =3D __split_vma(mm, vma, end, 0);
+		error =3D vmi__split_vma(&vmi, mm, vma, end, 0);
 		if (error)
 			return error;
 	}
--=20
2.35.1
