Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7DE61FA1A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbiKGQi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiKGQit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:38:49 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9BC218
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 08:38:48 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7GT2S9007234;
        Mon, 7 Nov 2022 16:38:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=YA/ks+zj7IDZkHin8TFO8rZQSYwqvusTQU7+2+RdHzw=;
 b=gwFh6/osd3hVY4bnhUNOW6RO6HPgvP14RRchic52RqDlHdbuWgpfKuboRjQnE5ipFkT0
 bJHIRn/zd1cA88ZGBaWIH8E3or2j8vzDn/iVHGiZLfTdj0WYqt8ADlUEGjHKctxPCA1M
 aMg3W9uaV2UhKddUWG+tW4QBVnlDBWP1fdGqWEumx17QO2yTfn3uM0Xb0Z2m2PEgKM8/
 7jO4zyNjHwMGlQSKCXNTV5R5rOL/Mp22FHLxOAi7lrYPbgwtyS+GWBKAr+tKbP81AsNC
 ZMvP4UtoJPvG+v/0FQ4zY1gjKk6rK8t0+LmR7FpUnJVofXCip3eVO3tOb/cnpObF8COo 9Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngmj475p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Nov 2022 16:38:39 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7EhhHc030220;
        Mon, 7 Nov 2022 16:38:38 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpctjf8ek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Nov 2022 16:38:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRok4RNVsJWpNxdr482dU7Z+zILNZGqDuqYRBtqNF3L7ieaZdfMPCfk/U/W1xg8RxStQSxb5K/74V6/CZhCDP9ify/V2xB9zw7SFCh1g58lcwUUNiDHNwmXse0g9E8kWcsnIXPl33hexMiKuD0vd6YbNFx4LvZ/0nERpQlUHd8EfziqULNPk7jxGWW5PspdtU0NNCyUmUGrxpiIlrLubab4yYuPCp7ksaH0KpNcCV84faxZVQ0DBbQ0MxFXnt3+W/UxnJpKdgJxX8IpZIjEWDnH+g5WdJ7957oNUaI5D2mtH49loX83i6vjoamCTFuJXEjYz48BWsWLRw1jnIJ5yyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YA/ks+zj7IDZkHin8TFO8rZQSYwqvusTQU7+2+RdHzw=;
 b=efdJ2wr3fPdIlQtKn9VnYBc1WwxEdzu/2WJ/OFl6K80LoCqU1n+cGeh8mOk7anqoblanU9D5OzwYSOOzE1GuoiR6LfKHg4tCHbGTr5Tv5VdpZd4acDPM2Cxvqes+riiwF6B+8pm/GQwJ0nytBX8aiNjjgigBACbKOHisKEbQGnUrXJyEJLfY+Eajc7hPuJDFm1sH4fuw4SqVCzGFZZwFGkBt42TQ+LikZciOlqzbyLQrdllU0CTkX4faRs7lN8dX1vHd7LIfI4bFVoZONQyoGg2lqGfcWQLDGeO1BW2CUromC3MKlVvcx24Uim0WyTTbP5LJVT0BJWBQeLOfM807mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YA/ks+zj7IDZkHin8TFO8rZQSYwqvusTQU7+2+RdHzw=;
 b=UUx4YTmn3W20B8441Q1NxI7oljcIg0A32WvjvgzVdRq4H3v13XWreQfoFr5NkQgiG61mEBMyzWQOfyDxH7OQwxNC1RkGA1PtfcYheqOAnAsXXB+WtdmDoO04r6L8IYKdWgAYpAKDbXZgV61XExRyiYGmoUt52flVYUjpL2pBJos=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5742.namprd10.prod.outlook.com (2603:10b6:a03:3ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 16:38:36 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1%3]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 16:38:35 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Suren Baghdasaryan <surenb@google.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH] maple_tree: Fix depth tracking in maple_state
Thread-Topic: [PATCH] maple_tree: Fix depth tracking in maple_state
Thread-Index: AQHY8sdhjSuovy1fZU6O2Uf9+sMxcA==
Date:   Mon, 7 Nov 2022 16:38:35 +0000
Message-ID: <20221107163814.866612-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SJ0PR10MB5742:EE_
x-ms-office365-filtering-correlation-id: 05e181ed-669e-4cd3-a65f-08dac0de842e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3TAEcTv+AuufiW8nLEXq8R+CyVYrDtU+hn0+iHqmTtMV6sAFlWrXQqywmWzak35O+WdR2FWaHvoHIyHbtYetkxdjvNJ6IBiGstoSuCLHb3GeeeQkjSsMO2kRXIPv/A+vpOG3H3Ax9sjglsTvPWYw1pkQIQTLFxCKTPWnha1bXdhKh1+C0GId0sD7SemP88UaQamIoto7cqp4XAlyPP540zDU/7gA1O2CiL1T5kF/LbtVAfLygPRPgaFHcWJWTFL5uE3mpJyQStCs3PZQxhiEC58UUzoZ59yJNhBPE9yiUUBQthWegRjc7S4yLJSgtD7H1iB0i8q/MfprR2QEQYNYcc8+/ofYHNolqkHWyEH0g5TGKN+MRkVdDksTDriUrcjO9bG2JWyHSIJ5/4SM665joC6QBslCjsGpg+Mcc5kPhbKYVxgGmK1cKn2jC1+gxnLKaRe/98HM97Vn2BTcfuLHdUPNaNyMwAWwYH91x236wS8fnA0LwnDyfU/QVfaeh1eRG0OMIOx4s81cjo2ENstRJzpqi7n6HF3+ZjQIhyBU2WzwyTvO/rYGMIc/3gziKk0KrvA84RIG/snm8ZLbG6kB+jadVc5m9LVwqFYitQBBjDP3AEeA9IxwUvbbLV+LjnWMtU82Bn2ibPmMhdTFUU2918sjUXxU2snUoFg+jJxqkaxch9rF7TeXKDfJZrK4DSPKJsCb66RtzUKoPfDwXLfBDX4IhluNdxURd3e+dwRY2okzK1F3F0xrCeyXhv1KZ46RH3wLCQdK2kS/kCI8PO44aQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199015)(8936002)(5660300002)(44832011)(2906002)(186003)(91956017)(76116006)(66946007)(316002)(86362001)(36756003)(110136005)(478600001)(6486002)(38100700002)(122000001)(66556008)(38070700005)(64756008)(4326008)(71200400001)(66446008)(1076003)(8676002)(66476007)(41300700001)(83380400001)(2616005)(6506007)(26005)(6512007)(54906003)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vdAVsY8ayAwk0NUjq4lRcJJSx3RC6EH7etBuJLmrPvuyg8WpLSlaPPnQ7H?=
 =?iso-8859-1?Q?oUn8cXeqMpamAwYf2l9tw6TfgHbiWDv3UgAkILWN5BYcP1mrSslcr3TUz0?=
 =?iso-8859-1?Q?supAv93hnJCvce4wsAyBN8FqUaWSD1R9/+y/cL2cFabBMXTAvxPxENt9mz?=
 =?iso-8859-1?Q?QU0o5uSJpBG3yi08Ohb1R3OP4GNSGRVU6R3JEWKSNahu26XCdwpwa2+aQ/?=
 =?iso-8859-1?Q?v8Ye4Fbol/plImJnbc6JLfcMyS+GplE4akB+XI9aPoSzvJ3rrcembCoD6S?=
 =?iso-8859-1?Q?6eD1+C67M0aew0qv4/QTDUcoIeanVkcV2iARo/Z4A+ogbSOO18FJJO2fiG?=
 =?iso-8859-1?Q?Qz/gLLUbhSkPm2WkB6s43J5N3VLxzIktdFZmUOTWDV7hUuJMxQp+76GZ1G?=
 =?iso-8859-1?Q?zZFFoEwfWUtsnf4tb6HAuIGyl+KcoSNhaHCZNJ58nVdbnAgzrZvsFmTOJv?=
 =?iso-8859-1?Q?QF1PtzNdl/CPG1UdiQIr6+Wgu4ORjmKCjRpdfl/iHbsWB6yPlAn5XfBFrk?=
 =?iso-8859-1?Q?KQjZaJd/zEqlQb2cdHo1bz631B6IIU1mRLtTnnV9Ts9IHV0uv6m7FL3dj5?=
 =?iso-8859-1?Q?/7GTArK42e+fZS9xRJXkJnSeXilRWcGJOb3reWAD0c4tIe4GloCZHE4Z94?=
 =?iso-8859-1?Q?fMwvJ9sN9e3OSUMFMk0tS5vCCaL0h3DvnT2cwXStGonh5C66v52OW5yCRY?=
 =?iso-8859-1?Q?2XjlN/t/QatBdoCYS1fYpSnB8EEWAFon6YmBpHjfP7+EKyu36MQIcs3yAD?=
 =?iso-8859-1?Q?tktfSKLUh+dIh7obXFg1k/Gw97tMXZU0zSv8TX9h534nsBpUlNDw8Wodya?=
 =?iso-8859-1?Q?ibhpcjJibLQGRF6VLnGvhMCSX7ccFkoqHx+3OpwwGYpfiLQFRaMl4ZjYDc?=
 =?iso-8859-1?Q?fl1LzXXQGnnG7uO37ZI+uoK81HSz3VoR8h/OE3xoZSW1TagV5V8kBKkBrE?=
 =?iso-8859-1?Q?tO0ade2Ng4fNpdPT01PsM4udLh220zlOt/XFNkLSMr3OElr7BDiH3Kltce?=
 =?iso-8859-1?Q?wO68GUO5uSOFABgOpLVjjp27E32Rws47IuyZzbssWwrOI48mhzbwCIv4KN?=
 =?iso-8859-1?Q?1rb11OJpkCBQ56GdWNJ5RKxPFLwvg/hni8Qia2cj3miDGpzb61z1RJL/zm?=
 =?iso-8859-1?Q?Kpenlmpd/xLjZ2cIoeC7/vw8tX9DU23P8xq3dY4xU75DvDDnzdfFtNRrC7?=
 =?iso-8859-1?Q?0Mwmb7TdjIQAgui1s94NYH4iFjc5zl8J9EL5S3Ozy+EkUjW13m9h99JNwZ?=
 =?iso-8859-1?Q?OmVMGhRxSVlGn6PskqonXC/C1ZthlCigC41z7ivgr+Pz44k5NrZyqwlX0a?=
 =?iso-8859-1?Q?mMt5fhHhqrWHr7UHZ5uN1D0lsMfU6p612E5MVMRvdvd12xBlSKoJD9AUQV?=
 =?iso-8859-1?Q?eNXvC43KMEnk9kWwZc9y+cBhDs6SQ95IcC+7ziSUJALurIY9KYJK8NDiks?=
 =?iso-8859-1?Q?UX81q1ZMbpzzlKxH77h5git8O/zS5MVeDF0F0PyKl2st/QyaWZHaIUgkwm?=
 =?iso-8859-1?Q?q6XftiG6gAXG/capi7O2xYVqJ2syzcRrOErXnlBH1wBPqnBAUTZS6bRnTo?=
 =?iso-8859-1?Q?M5IKBLD06YIvK3C+ViVI3ANP1eWVt0x+6dTb3g5VXHA8p10ishT3itVFak?=
 =?iso-8859-1?Q?gr0BbXIWtE7gAbWZkR3IDVbrrVIy3Ql9eQYgUF0srpiaVp49NCuQkHiA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e181ed-669e-4cd3-a65f-08dac0de842e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 16:38:35.8956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8UVnBAMwv0RDrUezVpknCG/rblFmY6sM9f9wO9UIPE1GmuPmFGywm0Z04f21dEyj4hwLpftHKVPYUcSkuPhOSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5742
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_08,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211070133
X-Proofpoint-GUID: ovS_Wd5yxQt_0ZfUv4Z3u1zPiXRCY7hJ
X-Proofpoint-ORIG-GUID: ovS_Wd5yxQt_0ZfUv4Z3u1zPiXRCY7hJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible to confuse the depth tracking in the maple state by
searching the same node for values.  Fix the depth tracking by moving
where the depth is incremented closer to where the node changes level.
Also change the initial depth setting when using the root node.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 4c79c36868d8..acc7123347c7 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1356,6 +1356,7 @@ static inline struct maple_enode *mas_start(struct ma=
_state *mas)
 		root =3D mas_root(mas);
 		/* Tree with nodes */
 		if (likely(xa_is_node(root))) {
+			mas->depth =3D 1;
 			mas->node =3D mte_safe_root(root);
 			return NULL;
 		}
@@ -3732,7 +3733,6 @@ static bool mas_is_span_wr(struct ma_wr_state *wr_mas=
)
=20
 static inline void mas_wr_walk_descend(struct ma_wr_state *wr_mas)
 {
-	wr_mas->mas->depth++;
 	wr_mas->type =3D mte_node_type(wr_mas->mas->node);
 	mas_wr_node_walk(wr_mas);
 	wr_mas->slots =3D ma_slots(wr_mas->node, wr_mas->type);
@@ -3744,6 +3744,7 @@ static inline void mas_wr_walk_traverse(struct ma_wr_=
state *wr_mas)
 	wr_mas->mas->min =3D wr_mas->r_min;
 	wr_mas->mas->node =3D wr_mas->content;
 	wr_mas->mas->offset =3D 0;
+	wr_mas->mas->depth++;
 }
 /*
  * mas_wr_walk() - Walk the tree for a write.
--=20
2.35.1
