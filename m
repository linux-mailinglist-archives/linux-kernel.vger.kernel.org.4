Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BB266D467
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbjAQCgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbjAQCf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:35:26 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4172B638
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:34:33 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H09Vpd005559;
        Tue, 17 Jan 2023 02:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=fdS754oOP9KvyPGz3fj9korFEn8Y/p6HOE8wad5P+3g=;
 b=gGMMVUuaakxTjAGoYdjZO/9yU/g0Hf+aKBRc784AReeqIj6lQLcldb/hNodlNvsaiDhL
 15/jvMXgyCPUFcYtdoXUU6gofbXLbsM37888UGDfNv7vm7l14tPf7stXM6kpDPfJURmc
 ojv8UxqPKQkNN8bkQJM8xMposK5BQmkEwShwUxD1chZO9ZF70diElE6qT4ZVO+yZ4RK+
 tEwdshtuWk9Ezc3amb7a9mnVFALhKKTdwVKQKC9sLSXa7iX9FnqLexV9NfBPQ/Pw3MGe
 zghUf9wqnUXMJyFgqSayk3bYngfDzazhKktyyuDMiqIAOyaFvXnI3yE032IxXxFaq57X vQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n40mdb5eb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GNUM0X004833;
        Tue, 17 Jan 2023 02:34:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4qyy10f0-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAuQh6MS0oDUBUlq/VyW8OlMVMgdm8mmzWSl8D6gOozKX/Wg3AUr/LPCc/kIA3phjrtvGn6Denb7D6MhrlEWmYJ9pdip3boCAXtEAPQsrk4fEZMykqJtY1Z0lozFQcRj7vK+U56aEuZLYTwSDUTE0S+d6Jjz0ShQyU3NQZlSV+VB20YAY7uKnxHg7YuVr9LZBPF2Hg2RDpnbu5CfXYMUahjyKAaq0K66qv8V7ZOgyUvrAJnJJiHeuk27yJbdKuNP5wyQ9tJLGbvTKDjadFkQAVv1MldIdRLsTUAJCPioPgqg8b8MVtzuYMc4Vfd+kepKa9ih/lp/GSso1PK9stzRbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdS754oOP9KvyPGz3fj9korFEn8Y/p6HOE8wad5P+3g=;
 b=g//v3O4Hn8BtYwbzzi7X/dUdHCOz/iLbRhfxAlORDRtdWiI91ZkL7u0AdL48fJtJ0MWc5UXXguW5dei4pYb7drWO69+fDFzhwDxi4kDVHQD66J/Mm4S/7Jv+bAHk64ddAvzgo0docZmbWLS5fWJJkPbpBr9BawNIdrvTlBCp1CQtGSqY0aJZruxjfrxlRX9zhm/0cXQ4ChYyXpP/1FicDWNPYLpMfsDaz2kWee6rLYLrVvtb/oYqsxBRhbhQBJuGBnKa/IEB9BXRC3CgJKWto06+6SXNSR2fwKjIeWmbbt55Fbod66K1MzS9jhua8RTJWaBM29uIF+4+jS2P1fPZ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdS754oOP9KvyPGz3fj9korFEn8Y/p6HOE8wad5P+3g=;
 b=QWjLSXr62d6XhqzKPLIC+j2P/v0zX/nhFOcIYWeldD8l+IxXuvD1ITcY4sWFU+zFwpYzpf0buth+t6gFeOHEmLpz98uiFkjWQ/msezbe8+dGua2OBRUgzXUgN50zg3XoFxjOIdZ8/FaO6aMJdfb4zklijBmDCXAXrO4opzsB2v4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO6PR10MB5538.namprd10.prod.outlook.com (2603:10b6:303:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.9; Tue, 17 Jan
 2023 02:34:20 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:34:20 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 23/48] madvise: Use vmi iterator for __split_vma() and
 vma_merge()
Thread-Topic: [PATCH v3 23/48] madvise: Use vmi iterator for __split_vma() and
 vma_merge()
Thread-Index: AQHZKhwyWHT4gXLAZ0mTDAxyGiR4hQ==
Date:   Tue, 17 Jan 2023 02:34:17 +0000
Message-ID: <20230117023335.1690727-24-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CO6PR10MB5538:EE_
x-ms-office365-filtering-correlation-id: c65e6cac-2275-45df-a37d-08daf83356ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hoNZm6jkvRt7nWWdEHJ6DScaBdVCBKWdSWzAO6K/ynLG2htKh/Z0gvftqvwhGzHsJbpf1854d4tvYH0UZSCte7dLTHRx2A0bVZ34OAOLSLCDMV2bRrgAfwvX8CoAXQUlvpHGAbu1I2LCpZEDmHfOIcJ3bV/Mzq9AsgHPJtkek4J0KrL9Ufuo2vlpK7H3RR1BcAxuIbt9yoqBE2NMsXGXmsnNWyEFL3+FzglytyJPpOW5DLB31Yv9kbx8alNEXqyPVXHehtcuMmMjfRoPVUMHphx5CUQnmeb+c3wSkznSoqvG8wCaeNJ/OjH2/k76FZMsYDXqLONjqqAgzLMRnizjwy/I+sxRChSfgUhnRCMR1K7379lW6eTEjLEgJbWCv6UP9qayqEGzrLmwzsxUYwn8xRU+Ld5yGaec8YX5zuRcOcme0fkbl3lyMSBO5argR4Nv0phSnR/u7XmMHAMzNR2ihL2XLEfWng6gH6bndiOHf+vLROqPh4A/0d8V2QE4W6P74ISlmnber04jswBCEFZbBKJzPr2g8NsVavARcePt80BZZUgrLk4Ndt3oLP7mOwYNlHLJmwLLhtGNO5o6YY4WRR4kbAItTX+Yj1rXIFhMtE9VpZiZl1FEV3gdeOat1tjQHcVd5YM0TtG8O5MBUMpY4IYG7vKs514TUCRCfzSPHSlgP8Adlj4KBeyvvG4um3pEb/oikpgd+NBN9yJbNNH4yA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199015)(36756003)(91956017)(86362001)(8676002)(6512007)(64756008)(4326008)(186003)(76116006)(66946007)(66556008)(41300700001)(2616005)(66446008)(26005)(66476007)(316002)(71200400001)(478600001)(6666004)(38070700005)(6506007)(54906003)(110136005)(107886003)(6486002)(44832011)(122000001)(38100700002)(2906002)(5660300002)(83380400001)(8936002)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?k4F/QDuz7z0l3NCuYuKUyIvwYVux2JhxXxA1Ft/e0rSwANTHdzLEs6rf7n?=
 =?iso-8859-1?Q?SKml1Y/IN0fJt7NE9SShqUTtJrD1Aq7bi15Iis/G5BjssD8gwqDJOow+tw?=
 =?iso-8859-1?Q?D6LbZHge0+NZYlWkhQAWtfcg2jcBG5nUFZ6kX+O/SbWUT6v0wPMepzyRgT?=
 =?iso-8859-1?Q?0UGbHJVQBt7qSX9dQ3eFtn++bqcwmGczRHJwm80zfpgXJI6x7FYXGweNdE?=
 =?iso-8859-1?Q?9TMuhm03Fq4vYPduyzX1jgwb1kNjn6Mojywt/49vitZTxuluEmfWJ+7Vg6?=
 =?iso-8859-1?Q?P0jbXqYcU3LhhQQCiyvUqJnNLlb2CMs+93hdHrG/FI/1NWEVbx3UlLWQ/O?=
 =?iso-8859-1?Q?REgtMhpc5W70rPjtqDUz16ehzQsXODi6ojEb0LF1twEZF26RxW9dK8mlKX?=
 =?iso-8859-1?Q?UgZiSuSXntKOxSfmTFPOnEz8Rueh+RLhZwEDphp/mmCIDJVfoWb0VSX+6G?=
 =?iso-8859-1?Q?/7NSrnKN5XE73JK6MOKeEYD2ikbu/x568PCQwo3hKwWt2P2TtKwA2frNCn?=
 =?iso-8859-1?Q?qXSQmRCsMDoTasvZGCxscjMhZRXTeZ5Pj4xLFWseL80vzWfySwQGsrAHD2?=
 =?iso-8859-1?Q?jcAwsgIGWM0cb5XIgQo0AU3U2b8uAw+wUA1T69KwtCSJjiZkqK3Oejt10u?=
 =?iso-8859-1?Q?ot92HN56MCl67rojDtpzbh5JoVueWY5Y7tukvnNCWlCK9jegbaoIQJ9JTf?=
 =?iso-8859-1?Q?XxGu52LhglizKTU2EoLHNPZl5quJsYYPny3EMdcS/pgOLvCv8yol6TxTov?=
 =?iso-8859-1?Q?p7UGigSFs/dEflUEuPZHKX0VFvN7I2y6J8samvhHYSP4G1YKXce3aqm3f+?=
 =?iso-8859-1?Q?et2CvGVEsfVqcs7fCbx5koa4gP3Py0h+RV2O77PPhieRYezCfQNgBg6Pac?=
 =?iso-8859-1?Q?rAA8TP3/EBFMl/p9blq0fQg8qQUbGv9Qa2gllxKeum9Gcs8noiVOxuecAj?=
 =?iso-8859-1?Q?O8BOGomiRQCgy9GlksHdm3VFV0Ga3Oj0SI9+abjJMLtrwmm1ew+0klxfDf?=
 =?iso-8859-1?Q?71WHlHD582VDStzLvHZ9eWbQ1BtxP/h62Kv5YJTcgklMXbOZnoHblLBMTG?=
 =?iso-8859-1?Q?qqAvk0bwu2VMAkwm+CiYnokcDjPBsehgkPdrrCKDf35ALVna9Qn/9nQmDe?=
 =?iso-8859-1?Q?YE98ia66nEAi6ZqrfKFglOSCwXC1zHx9BFlNHv+4RY9M4WolEPX0Cmj6EA?=
 =?iso-8859-1?Q?iaZR2GlrmoMIgy14FFsPqxCpUeluRx5YdeqJ2eyG47aNjM3p4fI/a6kpbZ?=
 =?iso-8859-1?Q?BNu29xbTl1+Vzo/g9wLJbfXzYpCoNNIraEn7mB/ZRhsh7NDrvCfgZG9naw?=
 =?iso-8859-1?Q?r+EkffzMcn0sNeadPZZ+cO26sfP8BkkbcKcrmZ0Alv4uDYTAp+Dp7lQrpg?=
 =?iso-8859-1?Q?d8riPK8ILhAeoWeP8ytpj2VTRwd8aj7zo6LJTclrqC9FK+RRscI8VcrAw2?=
 =?iso-8859-1?Q?aksiMkQ9q9gZ/3atEXydiCYnkhDHeOTG5GH1waZh4muuDPNhCs6HijqL4c?=
 =?iso-8859-1?Q?1SCcAH4e2/erN/4L7KjwVGoyJxyU4aXcJY6/8Hj86pzYfanvSXbdq65bLD?=
 =?iso-8859-1?Q?cEPf7xky3tfLW+LKioBifeaQ8lHOUww0T3Ur6q9FmakpBwG2WbrrzXQxW9?=
 =?iso-8859-1?Q?E09XKeOF48pfHbhJgTQYVRPr2XJJq9mMSD+0xKFKsSFgR1iAzOP2m75g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lAxhqRmcFIP4A/roJcdKB6QdOJWTW+wRJkboTMA63Dcqeheu/RHklwvh6mCK8jffzoBS6eIJxlgTUons2aXgOA9x695c5XclOGvJZdmXdHcgjWVhQjAHovFO9segmBJWUa0BkRWZJa/uxlBQ6qFCLXF6dVsqlHuSGwfUe/4EBUuEVmBQI3X6e2rl6WTsUo6wSoTU6rrK+KGyHztaSJp0tl4xYc1nMIVW3KZEexbRaF0Tf7yDJWniEZaUR/wxiusWGcJZaen8oHhzCVSAUwDqDWYuvbL4BY07+6YjWA11JutECWnrKwejqcBRrM5FgA8kVIvA7PqL3buXNieXP6vbceG0Eu251ENY7DV3kafjvukp/3CWKoEwZaKpfIiJGy7x1jK8WcBEkV2l7TvMuaFKG/y/eV/ui1dh6hu5rFRrgxK2Hn2DFw2qedqq9P9stgc4q+cAWIG9v2X/dHiCnhbkLC4yGs705mzQPOpBaBKqLgrq4/EhsaFDN3vihjI3yJb0CWKbqTfuSlqywO022Vp091SjWrCaRODNo5/XO5mJzwYvsVr+4DeJJmhdVy7ri3QmxBDHvRL0vBf1Cfx5WCLbFPN0Am0mw+FCcNeFupS1g6clqMOu7SBtopZEoBAjGGeLOMZYuXaqaKPkvLJPjk+xcGVaezyDtW1wGA77HgcmHYvWLMykudTQuX4KU62FlbKFLdcpse1/ed2IjpsPTFkhCaaammE80CIsjHH7cUXgIjz7GLQsHLy/MOvSMIusybdsN4moqWN2lepct6eIMsgD+IQGFQ5+sBGyAig1f0Zz9nJUOt/MAwh61zatIUubhFsr98AmleNNjEJSLZxdxlyznOsCi8CHiDScFWcjX0uetIGuugtO1yqYntP9I4d/I9EYM09F03ixA4YGiHkW19HHNQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c65e6cac-2275-45df-a37d-08daf83356ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:17.5623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ODsJrJi+pCLXdOhizaEKCSh6EoKTfxPf4RKEgi9TCOlWjO+PKXVDu/237PCKfADCzxG7O4IWv6qN7aW28XgzWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5538
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170017
X-Proofpoint-ORIG-GUID: 8GiJQBU21AnSYVxcmDHwaJNWbFaEY1x3
X-Proofpoint-GUID: 8GiJQBU21AnSYVxcmDHwaJNWbFaEY1x3
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
