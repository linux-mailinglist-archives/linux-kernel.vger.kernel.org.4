Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53AD6114F9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiJ1Op5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiJ1Opt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:45:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215FA89959
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:45:45 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SBNwcj019014;
        Fri, 28 Oct 2022 14:45:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=4B1vbghS2Di3PGiZR5+Bi1wB0HyBMMsgbmSbEjfiSQ4=;
 b=HByTUVoNghSMpiI8JRkBDZGFt/6YZIXc5J80HfG+9NQMJzC+r2ycnrsvlxaZJ7aIDJ78
 2EIXW6zDWCJexLItoEG1/2MRrJZpe+TDjfzZSc0Jt088q3sKvc5ndKfM1ZIN9ssKOSKL
 naywujQyaWrdSZBz7u0oeo3uPlraiJUjPzt+nGX0BZbJhai4Ika5dRX2eZPokm7gQW0y
 A5yrGWBxDzOKoGbZCWUEx8Ll3Pt//HBs2JkoolRuSGOehNozJbYbtZXumVM9g9J5KSzO
 GVL4ZjemDTtCQWCGuObFP6vW7Z2Vh+3UB19wPGaXIZwELCdOkSutemd8f7MW0Oe3yNec 9Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfax7w06g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 14:45:37 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29SEXuUe017438;
        Fri, 28 Oct 2022 14:45:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfaghmx5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 14:45:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nocnbf8F2X9pmfpjUUG0ehwMbE7245g0HCm+VYkLnoRxIQt2mBTdS2BiVoedqDVHyYtgtTtJvPXiah1lHUK+Y2asgsd06PRSlh5KUQOrMMnOGYXjMr3brRjRCfJLPd5aUNLAkwaeyN1JYDZrlJCwj8EGMaJ0T4Gu6P4ZEYooad6Yietiafh+V/JQ6S7isrHe5BuVGU5mVIU7MWQIu6x44mr/QeVqsYlON/cE+M5zJVjc52LX7lPkA3X0mN/qPAWBmzW0YwAZ0KDOCZV6YBrgGMQZS3HRg2Kyelumy3tJkA9c1bf4QE7FNZxRIDt5ecNs6iIMjQSyrp5Y6g6qijlCgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4B1vbghS2Di3PGiZR5+Bi1wB0HyBMMsgbmSbEjfiSQ4=;
 b=eBc74y4X9PPJ1XVb2K/8Cml1W9nNU/xJUJ1VvkBHkJujBpxtrbPqHDLppPm8T3pMvjQ2v7wcNEd7vYnEZS2y26nZbOb92qtMzgIyieoJB0gBhCBd8m7WKmfz/cghv0OvKpfIa9ORQ+eX40+HlyusiJps24odk6dognp7NJpKXbUfAzd4srEK+5FEZ6QSRvLpfNAXFrpOsdP7fWrcQOi2sOGnGnlDS9FhEp4zd+aetpVqvJ923rCrbHy/7/L+yH/HYnecQPA6xJoIp2QtdjPUz5shHgpnY4RDAZsuMjkBI/sqCvHXzx/bJ1QRAakzZYP8BMaWNuLpgB/8x2oSIib7lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4B1vbghS2Di3PGiZR5+Bi1wB0HyBMMsgbmSbEjfiSQ4=;
 b=HyjIIn6FebGwH8OkV7gehSu1bIhg1Q0TFXdytwxc92owej8aEkXoawhRT0v91qjnGUgDAAE4GtHhbwXSz5GfdsfGALSS4raRXQPjlYLnU1GqpU8Ge97nf231eOYM8OXN14MVTUPJJ8Dtzxssn8XMMWK9rwBFdSYS2mPg1376GRE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4266.namprd10.prod.outlook.com (2603:10b6:5:210::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 14:45:34 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1%3]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 14:45:34 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] maple_tree: mte_set_full() and mte_clear_full()
 clang-analyzer clean up
Thread-Topic: [PATCH] maple_tree: mte_set_full() and mte_clear_full()
 clang-analyzer clean up
Thread-Index: AQHY6tvuNtufkpaiDESzLGWPWr2P+Q==
Date:   Fri, 28 Oct 2022 14:45:34 +0000
Message-ID: <20221028144520.2776767-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|DM6PR10MB4266:EE_
x-ms-office365-filtering-correlation-id: 72f0d14c-533c-4d65-78ab-08dab8f311d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cNtYZiwL6RXaYb3JftQehLW+C40fo+VSdbXSzLUFyrIyb3WH6Q/836mdOPOpnhJBk0au3knH9Le/B7lieP3lIu7Ft08ocMN+FAfg1Ed1nHyWGEDWaD3oeDDMnu4TRnino6CLj35esnEyf4mL1SqVUJYdqj7mpCNyu+hp7+oXHSLXUqVJzqrp2ZM+a8WteilHjqzeaSib50aF+LQGEk1rNTwbimEHZRRprRZG5PjBxQ7WUAblhDD7ObA1aCR3w7KWtQ6newdlb5JEaeLuZcUsLRMgYisum3c4tXFqKxbB9PeS06Y1JLhSw5+8vY/KoTwqlF4FeJ9bFafJuwv+tHMwhizIkoeqgmajHcUKtW0upCU1v5d9y5+/KngmGBmeXgClf7NoOvmzqdVNiSF41GwXHtnfeHCTgPn0LZ6EUG0tTVIydeJWfBio8aiQKlqoZ7p1Vw95ZLtRbbmKylfEBwan07PNtF4To1ACeTXs0tFdRe/arYDacpp2hzzYyWg9KB99mzMU1llxkCU73zDzxeVRljE8IBVzTGJ7NAW+1mylArIxTB/JV05UUDywDAnlkJ8K1oLSPXPsmDVqOqnNVUISoAHMT52emVuCDI4+e8r9b2mBDvUvkf1uhJvJ1TacJl7xvLkAxdR0TI6M0CmpyW2EzJpl4XZi0SuIKOwksnO2QeK9geXA4UsKyIQbPkmiNbjFDinAzcQCDSG7bbGE+liiAgAFsReulEd992uHKXt7iMZ0DRHXy5+8aZFCuUQ+MZzumvFjBjTqj+az238J1enCnB7aa9nH5rU70Whif9VgzsE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199015)(107886003)(316002)(110136005)(54906003)(91956017)(8936002)(5660300002)(4326008)(2616005)(186003)(1076003)(64756008)(8676002)(44832011)(36756003)(6506007)(76116006)(66446008)(66476007)(66946007)(66556008)(6512007)(26005)(41300700001)(83380400001)(86362001)(38100700002)(2906002)(6486002)(966005)(71200400001)(478600001)(122000001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aOjVnIENwsoXFN1zqbq8TzO/Mwe322Ogt1qFLva5QRwyjbsjOxs1pGeojx?=
 =?iso-8859-1?Q?yYRnixtBMRPCy/PHyd40hIp6EySkKtyOc9BZ2Kf2hj1Fe0zP6YJvPJuPQN?=
 =?iso-8859-1?Q?fkHF2lvLWNOI8r9IyI9OEnOKHu5ElmBmgGIHcuSYdsM2TCvLjfe+OtBM0V?=
 =?iso-8859-1?Q?6obKO8gsW6ONL4jeRXvq68wHp3aJy95CWtrcUhimYDW4NXrFlHqAjBlseU?=
 =?iso-8859-1?Q?dA/EYKgtHtS574cPEIFskJrtKzf67veMcqoN25DitVPPKV/l8d1KBNLx63?=
 =?iso-8859-1?Q?uhkhsY5JQLqo6JxiKG/eietyLnhitCjpCXyYxaA+BMDNMjbn3eN4zAfJvz?=
 =?iso-8859-1?Q?yjN6IhOpLoTVrSsgKHvdp4NB9sfq2JXznsummUNZmspBvB3cNczuWkLL0J?=
 =?iso-8859-1?Q?yJe4EaBZft6tYp/vdqTPQIFUsQMMxn0Nyj97CD/RJmEqKsOgOCeT7n0zok?=
 =?iso-8859-1?Q?XaLzojaFtiw8snKhnvavQowMNwhNUO9vAlMWOgsxpU5GC6h6EqUvrSRSXK?=
 =?iso-8859-1?Q?4iY7FP4guvxpvnlGomoHrF1p18PJBKW1jKSRVZVHHNDHXb9Y/urEMa5Klx?=
 =?iso-8859-1?Q?wa5XvrC07MM0I3xaA69vJYdrwecnijB1rh24/p7tNgYR04rblohpOZsGTT?=
 =?iso-8859-1?Q?9XZrI8KvH6Il8Y+ejY/vhQ41h/yc4orvSsl4gkgN3Uhtxyd3JyxIzMstyn?=
 =?iso-8859-1?Q?F0H32SXh9JrPOpcKBy8gcnReyFtdlzA4APyRyvQ+BuLPhSY1Q8My6EqDTL?=
 =?iso-8859-1?Q?ye8GhaqIlKN/wkFAXGe+ttVhyCmWRxdQhiJz7j1tgqAUdZZJSbKTRxnU8d?=
 =?iso-8859-1?Q?rWhqsMNjp/0ArzY69qaGlrbX0bB6Doc306crNum7N4VJ4maUBJqjb92O98?=
 =?iso-8859-1?Q?kXf5z0a3Kea/+5s/nM4KM2mA4hGFuhdUxvuUCi7XmqcF+5tkzledLb6NHC?=
 =?iso-8859-1?Q?I+aE54o02Uw0uZZ/rPEisfumRD3XNJXFqaCCtHBSNmtS76TdOFws2VumQK?=
 =?iso-8859-1?Q?pKbsq3PhkXk8OQigoS4iuewddrQMxOES3VBLDxgvj6pLEkzAL2n+3cUCmC?=
 =?iso-8859-1?Q?BIHG4Zvpc8btK3UAIUYpb6rt/uGAVS8ih/6vF7to4aZwRTL4wdiJvRTXOK?=
 =?iso-8859-1?Q?1TA34bU/jG9L5F7JwX7BfD1bW2lWQXcptZJOMQlHjPtwIwNtKE2VC8nRq7?=
 =?iso-8859-1?Q?kq/s2jicB+MS8/snvndkq3efTM3shgDmUewjhoKDOlrlOBu+KYCa84OAR9?=
 =?iso-8859-1?Q?1PejLrNI0GZA1Eaw/xUJekoDlf5nMJoRaGjnn+GGxIeNWrXgp2/7RDyGnC?=
 =?iso-8859-1?Q?YbUt+jdByViQK285FFpkCOVUY4oGcEi2I2x7bYORrcKXAcn2COyVAWQSM3?=
 =?iso-8859-1?Q?xKDgBeujBiXsDZ8IHm9cMaMap53JZDofKjz1+Lk807wblZailIw9UZZNZS?=
 =?iso-8859-1?Q?Rn3sXgbhUoS0nliDWNpyHs6o174bKmFb5I7mgu4r2nmsfed+PTGIGV6X6l?=
 =?iso-8859-1?Q?4ChlP2axCOT0asjGnAtEZ1c1pFrFgc9ASaKB8FD8+qF2PbkQjHpaAWNHNE?=
 =?iso-8859-1?Q?HGxibdMG/kQORmFu40mlLUi8zFJd6j7QdU9NgpgRPgrqlYPqvGe59QRhXB?=
 =?iso-8859-1?Q?v8UoszLj3jhJ3Aa2suz/kEG4ZlMsux0bHFGO00BNk5KtBEwWcq+1eAVw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f0d14c-533c-4d65-78ab-08dab8f311d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 14:45:34.1709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hR7x9J5BGNRyZZLEiIcgXRlMYF52zzpMxRHssg5iyjrwo69JRjAxfnMK051MIoGOJzP13O29GtKMPpRDX9tlrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4266
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210280092
X-Proofpoint-GUID: DLOIl9AMPgNSrhy_dosS2VMvZ6crlACF
X-Proofpoint-ORIG-GUID: DLOIl9AMPgNSrhy_dosS2VMvZ6crlACF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mte_set_full() and mte_clear_full() were incorrectly setting a pointer
to a value without returning a result.  Fix this by returning the
modified pointer to be use as necessary.  Also add a third function to
return if the bit is set or not.

Link: https://lore.kernel.org/lkml/20221026120029.12555-1-lukas.bulwahn@gma=
il.com/
Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 4b3d16ced024..a4416277581b 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -323,14 +323,19 @@ static inline void *mte_safe_root(const struct maple_=
enode *node)
 	return (void *)((unsigned long)node & ~MAPLE_ROOT_NODE);
 }
=20
-static inline void mte_set_full(const struct maple_enode *node)
+static inline void *mte_set_full(const struct maple_enode *node)
 {
-	node =3D (void *)((unsigned long)node & ~MAPLE_ENODE_NULL);
+	return (void *)((unsigned long)node & ~MAPLE_ENODE_NULL);
 }
=20
-static inline void mte_clear_full(const struct maple_enode *node)
+static inline void *mte_clear_full(const struct maple_enode *node)
 {
-	node =3D (void *)((unsigned long)node | MAPLE_ENODE_NULL);
+	return (void *)((unsigned long)node | MAPLE_ENODE_NULL);
+}
+
+static inline bool mte_has_null(const struct maple_enode *node)
+{
+	return (unsigned long)node & MAPLE_ENODE_NULL;
 }
=20
 static inline bool ma_is_root(struct maple_node *node)
--=20
2.35.1
