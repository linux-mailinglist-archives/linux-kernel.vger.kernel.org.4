Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA4161FA20
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbiKGQjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbiKGQjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:39:21 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8458C2623
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 08:39:20 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7GTEmP027572;
        Mon, 7 Nov 2022 16:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=BieaS6O+7ZpW06a1Om4qbElH7CnF/igHUVwIvQxfJ4c=;
 b=kS5S6wOBUySIQxzHjGAOMwnpxtCiFud8NXYUnNZOFsfEJlltnpukembB+D+lIlOdzsSm
 X538/TDB4cuaNTFxXrkoo9xEmMd15REsCKQC6K/9gY51WTPHEOtQS+O8wq/uAnEqej3z
 VyqYaKd74ZS7gaMPrnf+Cqdn7NPlN9Dzgej+u9sFcHrY6aveTDYM4ekeIOv0Vm+mpqLp
 AeZVysKuVMrUEnVZ8bOQvtpcgleEN+lyqMLG4qgP9t/mG6mVpucpckqc30k3tLkwRAnH
 huOhOfN1HSDTSCmzDQi9smFdgPKDJnz5HM454DhRwkz20gcFwGsfNR0q/DwwynaQX+xA Zg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngk6ckvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Nov 2022 16:39:13 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7GZ8T4025518;
        Mon, 7 Nov 2022 16:39:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcqf0kg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Nov 2022 16:39:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GnK+aASMSvjOpVZidIR8BKjrxDq9AXVFxE9fwKcq1+RCcGqeaPPQadU/okL76rdA/BKIqRMzls6lPuywLornPWrEsW3WmSq3449IL0M3oLLc58vysQ9mPDDaVK2NHq7bW3qG6qdPCup3rK2aS23VwZmGFUTi4RmQ54xt0Pf1CMLIx4AiZc0WxpAPPrGsC7Dil3kuZ1qsgUqDUjIwKdnIsUQCh30urohM00EzP848uZqbWr7xsscYroITMgsmRK2Z9HHB/XPgp4Hl2x/5y0Rp/wz0piQ74r9AeTcWG5z6oGXKKcgXViBV4/9I0546RdygmcUV/qVSisHX4pJoUtZ9Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BieaS6O+7ZpW06a1Om4qbElH7CnF/igHUVwIvQxfJ4c=;
 b=G1d2ZNnoYWze6U4eiTUY+DURGjkePYLUev5RAVbLia0YdS6+fa9sTx6MAqHdP4MR3xxML85y8b0ZyAZqgTSATXahGvqAGyyDwnEgM6EpwWGmQJBG5Ax+eoflo1yeQbp8J07HAHD9Un3eOmnmD8TTMmGucwWLbX5pfPmzKiNtovqX6VOo7UPG+OR4rSyVwpKhWL3JSQu5ObUaJR+HtsJ2OhVBH5JchRua7Y93zrtOny89UCuJHYGxLNWKY5DkAimeIg5INhD+zI/678llTLUhzaCT2oOZf78qXDPbcLbRnbhlYldizN6+YKq24f71f8O5P5FNnYCLZt/1Ul4V1L+r1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BieaS6O+7ZpW06a1Om4qbElH7CnF/igHUVwIvQxfJ4c=;
 b=mJZLtWonIYEWTEH3Ym4e1v+Yn+Zenont2vTUQDblZRxZLvEL09aOGWrlCEq815JMhrd44OUq4i9oPlVSyNf9EE/u4VmNRtMobuqsdX1yC+wn/r0HUqLHbyWHT2GZ1TepFtBx6y0m2dq89vmOrup3gnhRsSvcrtVzO3/7OOpCnOI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5742.namprd10.prod.outlook.com (2603:10b6:a03:3ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 16:39:02 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1%3]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 16:39:02 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Suren Baghdasaryan <surenb@google.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH] maple_tree: Don't set a new maximum on the node when not
 reusing nodes
Thread-Topic: [PATCH] maple_tree: Don't set a new maximum on the node when not
 reusing nodes
Thread-Index: AQHY8sdx6kV0d8YE1EidAw//IAAPLg==
Date:   Mon, 7 Nov 2022 16:39:02 +0000
Message-ID: <20221107163857.867377-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SJ0PR10MB5742:EE_
x-ms-office365-filtering-correlation-id: 9a6e2daa-00d5-4b19-e345-08dac0de93c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lX8ypq2uTF3dTInPXV3YwgR2GIkwdL0sU+oIUcemsCB6HSzcnp+f2e8qYqRGLaB93AgKoaHFhSjwX7UHUSmUKBpeQw/FFesrAwis69lKsSa+uqyAzOG3UfMxSne8GvkcsgzNxrXyV2J+2Ffcll3p8W8sTQKDWorSzDVnebO8QlxVBWemxIaCMsXcxk1+OgNiOhEu4UaEQUYn3YK8hgPo95mmtlLYq4Ur5hmhwJTsMtJcABxZ/ZvB0prK8GrUX3htgLh4pHDUyBnTQJxyi29jM+OJxCeJrcQHt207otOPUnwYVICPMr0uZLPf6NDkb32XLo3MDifC+8s1UQoktIqZaEh8gk68Dut9pm4FEQ6mG6T+AgQo1IW/6nuwRiN4RU4rpz91grvDO1w0q46q4aDA8A1ODxnZCgi/ovG+X04xasv4ZhdLVYHO4AX8ZpGNhSjDlQy1/RkPwBcbL+QmidW43rMXI6rHHdtR+g4/1W8MfhxZb5XbqtLXppK6SHhdLpkIpEKjfDxm/x67jR/P+2n2OfEHjqql/pSnUMrV+6twGvV/Zbznfz2G6ypDdpU75OP+c2v/MPO9x8CNgnVMChsh4tP9xxrOn8K+U1hbzLebW0z93jS1JzZ4KKiPX5g071RnACkxExVPFhETxMAjXsqrOZfuKjXAW+oTz22AYcjeA5YkRI+pKsaIvAVbrK7dOrn3LY1x75jkEO8UcraVsltTaReQ6672wTQYgNEmFX8tXi9ybp8hx6JCM8I8I7CKnrFC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199015)(4744005)(8936002)(5660300002)(44832011)(2906002)(186003)(91956017)(76116006)(66946007)(316002)(86362001)(36756003)(110136005)(478600001)(6486002)(38100700002)(122000001)(66556008)(38070700005)(64756008)(4326008)(71200400001)(66446008)(1076003)(8676002)(66476007)(41300700001)(83380400001)(2616005)(6506007)(26005)(6512007)(54906003)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?t2v9LGFo99djyI2gyNdg/BpLZPRJfUGH2+gXHgjhq6fApZQPO/H/Ql4IVC?=
 =?iso-8859-1?Q?PH6/WQhtdvJFXG9COBOgF/LTZSb78R1obPN2N6/A8z5JYyf6HV6S2Si+Z6?=
 =?iso-8859-1?Q?nb8tiiveLcOxHMeFrR37YO1To8LRpRusvVMe8uhF8Ln9ilj43EbYzjW9J/?=
 =?iso-8859-1?Q?SV0jlaDMhDqSCAFox3k8nUZmzSLTcxwC9bWRlQkBkWiOAbGodaWCWflQS1?=
 =?iso-8859-1?Q?Xrx4vTY4zG1MmTz4gPCLo6YIgBxKQxT5RT85zUonpZ2Isf5pg6eNXso89A?=
 =?iso-8859-1?Q?RSXsXegbqgJclYEvryd6oxd9hdH+8IcQaAc3QttAzkWd62AeXSapsq7B26?=
 =?iso-8859-1?Q?L/AMfns7a+9cgi+YU7YpVlKWWb6o37ii7NQu8WeSjqp5va0IGdqgu1dYZO?=
 =?iso-8859-1?Q?Ud9wus0Xak6ltsA0aX+PGH3zyUUE4MX2+4pO5nMif9FU2a8JLvxIkgITrr?=
 =?iso-8859-1?Q?6tKUPMz77VU24TuiHY7DsggwlJKPZkrNjnB9MpPxml5IB9iMMci9Tdzumy?=
 =?iso-8859-1?Q?QcYE/svtEsvXpmYVU5eHxzDQxRwObIM0Iau2KOsfYJ1b2CU1HSK9Np0/Vy?=
 =?iso-8859-1?Q?cQOTGT5ELQv0iWlgMl9b40bALHGKhKp7zqr0ibEwALw9AxQ+BLFh5Guj5L?=
 =?iso-8859-1?Q?QMRf2d12Pcgx6sbIz7CtzEKgfsAelIGxh47CLOvpgZBeaAheqnVN2lNr5a?=
 =?iso-8859-1?Q?jXgy8aPLFwVJ45bzN9tnDsEnRb1bp30vji8O7htyt77/HJ76ln5GFnnRP4?=
 =?iso-8859-1?Q?oYzKvpTMZzKGDSJ6My0p04CYPVSqz/VdYhYtDE0pZW2RhbmK742iSycWZL?=
 =?iso-8859-1?Q?AEpwquFrOvQl9DhrieRDrVnEb09zXTVS5Cja8Ns1raUDsCVCpu2+lXpuuA?=
 =?iso-8859-1?Q?3NzUgUuaNlz1dIB5JP+Zg2mXeKhhs4Sar+f1gh4cxm5hXCRgSVNT+z3HN0?=
 =?iso-8859-1?Q?tNsJqtyQWVhW9r0NLBhqd8cWtl/Uw7vmrPvNLmtB/pcMBpkdgr2ME7/e63?=
 =?iso-8859-1?Q?eSg7fChh68uvrXCJu6ODuYxWBcTmoOdvtGZ8M7zBl/ceCAibCEvQzlAtxS?=
 =?iso-8859-1?Q?ttxakX2DL4fDZfYTAWZNPoahm0MrHHEUSOTnhs6L9o1xpUFSQgbKid248K?=
 =?iso-8859-1?Q?23/sPBpzbpLkdBnv1qjQH/mhPIEYJxzUAdyLPcIFS9t94ivyfbYZl50GdI?=
 =?iso-8859-1?Q?eSnH/Zex3eLZ1CD80AWW8W3Z0Pi7FXzxdoXyS8GeUT3q5rz9v38M+ksQkR?=
 =?iso-8859-1?Q?b9DyW3RzKsg1zHTCsACXWTclJ2tyI5qQU+XZP7tkjFrEeCv4eezFiqCKqL?=
 =?iso-8859-1?Q?qaTpOCAxYgACm4uRNgJoCiBM54dInHHXDmRX69bLMWIRypkbmuIUtPgs/j?=
 =?iso-8859-1?Q?BKhaWBCN5+ELtqMx6j01J/F0NSz5Zv8iTpUq50svixNViRDeP0YOG2JcVa?=
 =?iso-8859-1?Q?ce0t90koRhOB72YmZYxJw1xFydR0V1jTMM8w160izAMP5l03m0eq1vcZn4?=
 =?iso-8859-1?Q?bAfyoZAtPPNUw6gUpQzJBr+ph8Vf+yWkpSFTm7YnUSKWO7G5wYuA+JiO48?=
 =?iso-8859-1?Q?QdzQM3PbwYTMEoag6XqF13K4xNWBL2TJPGSm5SK4QYV6zSGGJNcYXVMfZP?=
 =?iso-8859-1?Q?MDB1L1hv+Yy3Y8xP1dXDMGL67SzPBYl3JTs6vqp9HtUdXaexpCeEU7hw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a6e2daa-00d5-4b19-e345-08dac0de93c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 16:39:02.0657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: USRZLMW+hUme0xWpX2p9C8Q5vxHu0Ilkrz3hAoLnz8XShy91EGlAU4JJ0CMdt1ymcaPDU3vzJ81yQvP/K9BIzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5742
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_08,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211070133
X-Proofpoint-ORIG-GUID: ChhtOdHeKJNfigK0RnYCf1xLcTS_hZIg
X-Proofpoint-GUID: ChhtOdHeKJNfigK0RnYCf1xLcTS_hZIg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In RCU mode, the node limits were being updated to the last pivot which
may not be correct and would cause the metadata to be set when it
shouldn't.  Fix this by not setting a new limit in this case.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index acc7123347c7..221f66d7cb3c 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3608,8 +3608,7 @@ static inline int mas_commit_b_node(struct ma_wr_stat=
e *wr_mas,
 	node =3D mas_pop_node(wr_mas->mas);
 	node->parent =3D mas_mn(wr_mas->mas)->parent;
 	wr_mas->mas->node =3D mt_mk_node(node, b_type);
-	mab_mas_cp(b_node, 0, b_end, wr_mas->mas, true);
-
+	mab_mas_cp(b_node, 0, b_end, wr_mas->mas, false);
 	mas_replace(wr_mas->mas, false);
 reuse_node:
 	mas_update_gap(wr_mas->mas);
--=20
2.35.1
