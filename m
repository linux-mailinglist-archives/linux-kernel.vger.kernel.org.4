Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F8D700F4B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 21:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237586AbjELTaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 15:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjELTaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 15:30:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A0576BF
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 12:30:01 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF49bC017783;
        Fri, 12 May 2023 18:21:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=NfmDzbq7UFamW91OO64jYrReNxQsH1mzQQLxfjxVg/Q=;
 b=pktOGZFpvQyvLvUuJnYI+zQqMICwtUFJTHlN5A1Zh36PD8xw/LRDnCP+A75zYkLNduhs
 UFF/Y2MJUO9WUe1XK/D1GLVxjZElfpQybCNiNTbAMeHmpxAqB0xrAUAzcEs0NLK0mT46
 QpUtZoabbTul2GOxNxCW2oGKiJPzqBr3HxeXjFwlxVE+imyUbcTCQfrOmK4/K7Cks3bw
 pNVe2pGGq/n6Dnvp/l+mDhKjUVRwlG2Dg264lVSQaVwoto7lTCoV8qBKSxi8WsGoCtmK
 BX9f3EzvfBl4ne9xV6w2/EYVW7Whia/XQqVvOQHSTYjLPqp4/hN4j+3lQQuES2dfSBHU gQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qhje7j3m4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:54 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CH2DLG004439;
        Fri, 12 May 2023 18:21:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf7pnt5uj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4VGkofmS8VoxgYa9FXbDN1tbwLJCcdL31xsgWCKPcJCJ8M0dTX4G4q8OfMQEOetjsqzXWNcPZ1XKfxQG7Z/fuNDJWc5EiYij39rETe1Mcrtk2zvb75PVrhaW8QTyZKxJK5YtEEg9caDStxGNvUIn+au63Ppjs4HuqAsSnoo03H1r/aVrtR7h2442uo2mDMVrB7SzuXxSk/4ImIhDjhheZIWy6uJouU2mq/lb4rBQMi7SIcD0fWtvLNKb1rj7k0vU+tPopngob3/KXX4ypG9llyXTLsrredvFBBm6IRyT/F1kkUrA4pMOgO+M//0U421H2MAyodEY1WGi+nuQmsWgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfmDzbq7UFamW91OO64jYrReNxQsH1mzQQLxfjxVg/Q=;
 b=bhntlWJDtZ9uE1V/pD5syxoXlAOew8K9MxCiGc2uTauTV6WQorSum3GD9ZSTSpF3JQzPCq09734dkvk0yeVzvibUXL4QRoCqL5xxjkOQgwXxgDREcPQo5PdOqzn8EXR2Yy3x03Mv8PgAwsoDBwJ3qIecMzH/T3yJ4/PIP+bciI5JManNym+YfsZCOTv7QWsK68KXHLYV+bqn4tflc9muhCpDKG9h8wAIO/s4uwXbg51bs8VTC/pBHdwmYGu7BMXZkAkB8itt1o9NVh733gHjAy4liq7EoTFhRBD59lPjUTxE+lqFqO0qrHcVCFkxXKWHIVaBa6EUpkWgEJRjFTp06A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfmDzbq7UFamW91OO64jYrReNxQsH1mzQQLxfjxVg/Q=;
 b=FD/ZM4hOOquJu7M294YQvjkUqQFh3airf6YdJXbe9ED0mcDKRUSRHTMTHLhd+i3emuw+F91CjVIdPRaaUs/2dMpKFt0yFOeJvETvjOiBFI3tYJSrCCFgSHJr8rJYYldo40MsNULwyl0Rw8gajqk11nZR51YZQgi0mIe5U5IdT6E=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5211.namprd10.prod.outlook.com (2603:10b6:610:df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Fri, 12 May
 2023 18:21:52 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 18:21:52 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 24/35] maple_tree: Try harder to keep active node with mas_prev()
Date:   Fri, 12 May 2023 14:20:25 -0400
Message-Id: <20230512182036.359030-25-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512182036.359030-1-Liam.Howlett@oracle.com>
References: <20230512182036.359030-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0042.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::28) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: 31a0ac1a-28c0-4cca-a6cf-08db5315c205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7No1WzqyBCIm1ZX9aEdjxMaUIMd6pW5gIrq89XYaVHww/O+owLaYbUz24cTpQVcTsn0k01xhag8otSxC2a2S5AcputV6HoiFkEJm7+UZN6P9lLOVQDYSRghqpA2Sh27WCIY6Th0ugRGL9egCy9wdKgWtLhT0Rs1k26HX8/flSL9lzIyvQ64Ige9hKhVyeEk0ahykpYcV8YhDKO28p6b83VNbRd8fIKcQhhuExfGuqwTry2SDV+XgEl1l4RtzBKyYHZzpKmbnskfMPYxwFqfT80UJYF+Yg3HagLRfSG0BDnfrArsDrTbycKo4wrw99vrc4ELKLdG2H4Uau4TIp8AbFWSmRoNkoKwNb4eHCzv1tmfNbhBXkBW++o4dmRWrwcGYH+NcMao2oUuNNfTtDLG1zxt/bDaU2pNu9QzowqMN8ZZoT5QDQEk1dROm7xm9FA5G0QVVa/sY7Gf40O6qcLF03MSN86wZlgxRe3VTgaP40v/QCqvp26dPHzShT4lkez/5602mXM+w8ZDbhHmKK0961KRuK7fQggjenTFSGrLbzxFGatK6S1gwEEqHcR697juyk4iLlD9SdXQu68dZK+deytcu+5x8ByW47/FHDQZ2mawaVdpS9xLPK58CXbGuocleC/9qKAWZsjOfjysXXUgB5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(366004)(136003)(39860400002)(451199021)(2616005)(8936002)(8676002)(6506007)(38100700002)(26005)(6512007)(478600001)(1076003)(36756003)(186003)(4326008)(2906002)(66556008)(66476007)(6916009)(66946007)(83380400001)(5660300002)(6486002)(316002)(107886003)(6666004)(86362001)(41300700001)(34023003)(148693002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PMyQVSJLZNean4os2wslwCMIp+lK9zxo8tnRRpiXHd/ra/wytPuzf+QBf9XF?=
 =?us-ascii?Q?fB7llATi8IIS1Zg7y7VTdrmSUwWuHdCeE4lhvRbMjH40WCbP/5bgqup0N6lN?=
 =?us-ascii?Q?qsWqoolIEr5STctYCn7fbYGrGA+VwALlNqLTAKzHVnQ5W3xwBhTR/HksojJt?=
 =?us-ascii?Q?qd6Gd9Jw01oglv46sPcA3aLNBGBNH6EQky9Y5RsZ1veqmMb2MENFbpbWnDJs?=
 =?us-ascii?Q?WR+D6d9XTx8V0E14kBlklSdLlV/uOAn4h4QFRhpVrbvNNevDS4xhecG6bhj+?=
 =?us-ascii?Q?Ev4smTVMIiDJ2iRRz8xE3lFNQdceVue0ovf5SRlhz9IQRmpsJkJ35ctGDn8o?=
 =?us-ascii?Q?g6XjMSY4q9XrGXWXOXuhmgwj96mDdwOzOl1HUVENB24o6rVJj678mUs5B0HO?=
 =?us-ascii?Q?Swg9Gp+6Ynquc9bxPcOFsUudWL0Z5GRLIKt+gN7R2dMMXBQKQtGAwtrN15PS?=
 =?us-ascii?Q?IMQy3G9ivxiwMtkd5lGP7FuFzWJcZtVd9spQDqD3q7nx59BGxybURX0CGSZe?=
 =?us-ascii?Q?Px6qbzJJr/5zx/AOO90sMODeDWUXvgLHx6Uf11FtL2R3JZifHuEpAb9w3571?=
 =?us-ascii?Q?P2c/QRjI27XbVDmS38QnXPMqQfopoCdjYBPeiJ1m98mzn8rP7dli6TDt0G33?=
 =?us-ascii?Q?eIZFalEcVco66lukho7tuslv4jPUFhIotLyifTsTXSdxQCFy/KU+3A4FRhUn?=
 =?us-ascii?Q?Ap8v6gQNTxJp35kYgTJTkwYM6Kyx0CZNYagi9WgBH0wyturCwdVwQIUPjQEu?=
 =?us-ascii?Q?SCVxaCDr70XWF+VEqtKhLhCTo+2oPz/+jVeGS5XwpFH5FGDAFJCrhM6gF5Tj?=
 =?us-ascii?Q?F+q19LIoJWAFS2ccxx2XIvh3r4j7Q7JorMsMEquoUV4Mld1093YOHS0naCNU?=
 =?us-ascii?Q?p1rwymFsMy4d9ZOCHXpZoWGfNr+WaXaCd8fkNGi8mDc4iDoUEl3LTKvHeRCT?=
 =?us-ascii?Q?NiOJJARv5OlhN0haNsWdiQ/LML50c+8v++7EIkFGkTrReheHYi7X95ZGwGVb?=
 =?us-ascii?Q?boqnIYo3Hjen66h5Yttw7qL3sNraVKtFXXkgZNF2uQqLV22KGlxSqdvlp/bv?=
 =?us-ascii?Q?87py5dBBikaEjclRYKMpVWwZM4yL/iqMF7g1gVS0kmKWyTtXHw+Ag29BFJvv?=
 =?us-ascii?Q?1tm4aydEGsxrP42yimYI2xJsulehdSoCNImOz0t+lBgdVPbDkg49fgfeh4XO?=
 =?us-ascii?Q?GLvuLoZciu6WxH7Etj0UONYqg1IUdo99r1fNdnq6mQxmNd0uI1CTCNqV1RcK?=
 =?us-ascii?Q?qQIDo9T5XkSSOaKIT+cQL+BL5rXdlMwyHbBXct/YOTlrV6gMuUyg2bxDUAMv?=
 =?us-ascii?Q?0VQvZntdZRH2AwJkm43XazlV5UIWSfKNaASYXx6sWnUWUV37DeHg4Pe7s3pN?=
 =?us-ascii?Q?lqGR78k003JKQU5zK1ce7HETAYoeNu7hUkTsnTPFasdBQ+QdYHzuZmijEpKR?=
 =?us-ascii?Q?cdl+N/Pf3PUu1ab/eu1kIwZH6nwlpkV7B5LNb+MxxAY1GYlJLv4xxgKTeHid?=
 =?us-ascii?Q?b/vAq2pQgbR59ptIRbhUiPQ0PEvU0QGd2fh3bvrIIbauVh3u+2YYpxTvcfks?=
 =?us-ascii?Q?csqrmQVBaiH7tyJLzxH3v25vCfkJnOhkj5MrNOewt6fDYc1kotFhN3yryvhs?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HsAoCkLOHioLqYE+wV0FfIIbiseVLF70jeh+PhP/TCvr2SuEUUbn6bhvk9utrOBLuG4Hv3aoz0pSfS5GaoickQ124hrNDExvyYjIuuaIVEtPSTaiQskeOYHRmI8sdO7sQNe5dcVrL9RWMIdItafoL5OeYUtCdW6DzvcdZIdv3FWxMV2LpMeuzmyQhYucE8uUX2dCWYjadiWksfyR8t8h88EvujSW6dt8GE48z5cYlSRQz4kmKZQmpGjVup6lDLMWGEHhNVC+Oph/Y4c3eCriyBd3bgtnG5chLg1NhhWJD6yBLXmvy834omlJF1cfZEeXHP3frM2s03y+DtKKdgJFWT00KuyqGnx2Pt6X25PrSogWnspytAZY5BnceR0ABIqChzpQE7Z0BJi/y6UVWRfyEOvJTsqAMtUygMZyxvzKabidMmUeGX8Nw6j+ad1uRFzzAzpC3Cb1jalnCYj6DAyk0lEUfAxljHTh2c7SKz6Yn2geT+XXPvzBACLZAtq4oJlH1WeEnclK+1ITQ+R4S/tXSFrmGzC6FwhGskn3/iLmqV+taWk2AhtwV1l1xh3mFPbeBQLYHGZ+zKLv/3QBBbbOJX+etFE30ZqMWZSJXqbC7ofBos5kAzJZaLoAFrb+GivJCJsdk59nOPU+VitdiboWr3Wk9wQcAfa13AynOc6jVNLr4XyW5w9gVUsnpGR8IAQtziHgt4bYzSy0AjOB9vKEfI3XDvWu5o8bcODEoeFL7+HEki4d/beMGBL12G3qpIM0hqcPgyd+wvKLsX3n8+sZ5cHpYDCoYsERpR/JBMdXGpjSHAwE8m/CDXElhWFk3Z1rEZ76eKXRxnZjyChby6s5yndKQFY6LOctYuvMuhsiWEPTmn3GUBYIq5iE6lUc2AxaHHB18M0p80K/ZEJr0Ltqkg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a0ac1a-28c0-4cca-a6cf-08db5315c205
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 18:21:51.9579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oqDwQc0Mro7g0jqWdng/uKj7I2pPHt6khq/gVmhA0qM7nBdspAumOmUnt0VULO8yx+wYFEKLxRCv37M9jeBxSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5211
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120153
X-Proofpoint-ORIG-GUID: 61rSBAJWegmqykld0ybm1eYFSSGD8uF9
X-Proofpoint-GUID: 61rSBAJWegmqykld0ybm1eYFSSGD8uF9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep a reference to the node when possible with mas_prev().  This will
avoid re-walking the tree.  In keeping a reference to the node, keep the
last/index accurate to the range being referenced.  This means the limit
may be within the range, but the range may extend outside of the limit.

Also fix the single entry tree to respect the range (of 0), or set the
node to MAS_NONE in the case of shifting beyond 0.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 125 +++++++++++++++++++++++++++++++----------------
 1 file changed, 83 insertions(+), 42 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 09142af082148..425ad922bb2d6 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4827,7 +4827,7 @@ static inline void *mas_prev_nentry(struct ma_state *mas, unsigned long limit,
 				    unsigned long index)
 {
 	unsigned long pivot, min;
-	unsigned char offset;
+	unsigned char offset, count;
 	struct maple_node *mn;
 	enum maple_type mt;
 	unsigned long *pivots;
@@ -4841,29 +4841,42 @@ static inline void *mas_prev_nentry(struct ma_state *mas, unsigned long limit,
 	mn = mas_mn(mas);
 	mt = mte_node_type(mas->node);
 	offset = mas->offset - 1;
-	if (offset >= mt_slots[mt])
-		offset = mt_slots[mt] - 1;
-
 	slots = ma_slots(mn, mt);
 	pivots = ma_pivots(mn, mt);
+	count = ma_data_end(mn, mt, pivots, mas->max);
 	if (unlikely(ma_dead_node(mn))) {
 		mas_rewalk(mas, index);
 		goto retry;
 	}
 
-	if (offset == mt_pivots[mt])
+	offset = mas->offset - 1;
+	if (offset >= mt_slots[mt])
+		offset = mt_slots[mt] - 1;
+
+	if (offset >= count) {
 		pivot = mas->max;
-	else
+		offset = count;
+	} else {
 		pivot = pivots[offset];
+	}
 
 	if (unlikely(ma_dead_node(mn))) {
 		mas_rewalk(mas, index);
 		goto retry;
 	}
 
-	while (offset && ((!mas_slot(mas, slots, offset) && pivot >= limit) ||
-	       !pivot))
+	while (offset && !mas_slot(mas, slots, offset)) {
 		pivot = pivots[--offset];
+		if (pivot >= limit)
+			break;
+	}
+
+	/*
+	 * If the slot was null but we've shifted outside the limits, then set
+	 * the range to the last NULL.
+	 */
+	if (unlikely((pivot < limit) && (offset < mas->offset)))
+		pivot = pivots[++offset];
 
 	min = mas_safe_min(mas, pivots, offset);
 	entry = mas_slot(mas, slots, offset);
@@ -4872,32 +4885,33 @@ static inline void *mas_prev_nentry(struct ma_state *mas, unsigned long limit,
 		goto retry;
 	}
 
-	if (likely(entry)) {
-		mas->offset = offset;
-		mas->last = pivot;
-		mas->index = min;
-	}
+	mas->offset = offset;
+	mas->last = pivot;
+	mas->index = min;
 	return entry;
 }
 
 static inline void *mas_prev_entry(struct ma_state *mas, unsigned long min)
 {
 	void *entry;
+	struct maple_enode *prev_enode;
+	unsigned char prev_offset;
 
-	if (mas->index < min) {
-		mas->index = mas->last = min;
-		mas->node = MAS_NONE;
+	if (mas->index < min)
 		return NULL;
-	}
+
 retry:
+	prev_enode = mas->node;
+	prev_offset = mas->offset;
 	while (likely(!mas_is_none(mas))) {
 		entry = mas_prev_nentry(mas, min, mas->index);
-		if (unlikely(mas->last < min))
-			goto not_found;
 
 		if (likely(entry))
 			return entry;
 
+		if (unlikely(mas->index <= min))
+			return NULL;
+
 		if (unlikely(mas_prev_node(mas, min))) {
 			mas_rewalk(mas, mas->index);
 			goto retry;
@@ -4906,9 +4920,8 @@ static inline void *mas_prev_entry(struct ma_state *mas, unsigned long min)
 		mas->offset++;
 	}
 
-	mas->offset--;
-not_found:
-	mas->index = mas->last = min;
+	mas->node = prev_enode;
+	mas->offset = prev_offset;
 	return NULL;
 }
 
@@ -5957,15 +5970,8 @@ EXPORT_SYMBOL_GPL(mt_next);
  */
 void *mas_prev(struct ma_state *mas, unsigned long min)
 {
-	if (!mas->index) {
-		/* Nothing comes before 0 */
-		mas->last = 0;
-		mas->node = MAS_NONE;
-		return NULL;
-	}
-
-	if (unlikely(mas_is_ptr(mas)))
-		return NULL;
+	if (mas->index <= min)
+		goto none;
 
 	if (mas_is_none(mas) || mas_is_paused(mas))
 		mas->node = MAS_START;
@@ -5973,19 +5979,30 @@ void *mas_prev(struct ma_state *mas, unsigned long min)
 	if (mas_is_start(mas)) {
 		mas_walk(mas);
 		if (!mas->index)
-			return NULL;
+			goto none;
 	}
 
-	if (mas_is_ptr(mas)) {
-		if (!mas->index) {
-			mas->last = 0;
-			return NULL;
-		}
-
+	if (unlikely(mas_is_ptr(mas))) {
+		if (!mas->index)
+			goto none;
 		mas->index = mas->last = 0;
-		return mas_root_locked(mas);
+		return mas_root(mas);
+	}
+
+	if (mas_is_none(mas)) {
+		if (mas->index) {
+			/* Walked to out-of-range pointer? */
+			mas->index = mas->last = 0;
+			mas->node = MAS_ROOT;
+			return mas_root(mas);
+		}
+		return NULL;
 	}
 	return mas_prev_entry(mas, min);
+
+none:
+	mas->node = MAS_NONE;
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(mas_prev);
 
@@ -6111,8 +6128,16 @@ EXPORT_SYMBOL_GPL(mas_find);
  */
 void *mas_find_rev(struct ma_state *mas, unsigned long min)
 {
+	if (unlikely(mas_is_none(mas))) {
+		if (mas->index <= min)
+			goto none;
+
+		mas->last = mas->index;
+		mas->node = MAS_START;
+	}
+
 	if (unlikely(mas_is_paused(mas))) {
-		if (unlikely(mas->last == ULONG_MAX)) {
+		if (unlikely(mas->index <= min)) {
 			mas->node = MAS_NONE;
 			return NULL;
 		}
@@ -6132,14 +6157,30 @@ void *mas_find_rev(struct ma_state *mas, unsigned long min)
 			return entry;
 	}
 
-	if (unlikely(!mas_searchable(mas)))
-		return NULL;
+	if (unlikely(!mas_searchable(mas))) {
+		if (mas_is_ptr(mas))
+			goto none;
+
+		if (mas_is_none(mas)) {
+			/*
+			 * Walked to the location, and there was nothing so the
+			 * previous location is 0.
+			 */
+			mas->last = mas->index = 0;
+			mas->node = MAS_ROOT;
+			return mas_root(mas);
+		}
+	}
 
 	if (mas->index < min)
 		return NULL;
 
 	/* Retries on dead nodes handled by mas_prev_entry */
 	return mas_prev_entry(mas, min);
+
+none:
+	mas->node = MAS_NONE;
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(mas_find_rev);
 
-- 
2.39.2

