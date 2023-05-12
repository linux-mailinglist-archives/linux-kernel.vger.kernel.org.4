Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C347D700E9E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbjELSVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbjELSVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:21:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70BF9ED2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:21:16 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF4iCj027798;
        Fri, 12 May 2023 18:21:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Bn7CJVTTzCGJHfmLE/+2NIyJatFk0uV6AOMMUMy4o98=;
 b=llkbrIyRCXH+BdPaINNFtWicEcSAqi0ff8ClKl6nzcpymEBvSVDSy3sZrClvEdEHUOr+
 1plgqAbHkT0UzIhc33F/2XV4ZxG9tqPB7iN7JlMg7GZ0M/pXjTOumWQee9EEMr/PcdtO
 QEtDmpAKx9NYCqTRzTRtRIOJ+fNSZszzOs1rWBQjEPIZx9/Hfv5cYlkY+XwWon7MOHC9
 DZdcSA4HjO29RhvcYjxL4EpkvgnARI6z6CMeck+AFJvoquDwsb27UnU3PuEQ8n75g7x3
 Bb/ZxEnij5L+Lo3+65JA4IFlF9X45+jjkreuxL42BwmcQXLa6XkI3C7H1bq8HjjDJzyx iw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf77cbpt1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CHGYhf004650;
        Fri, 12 May 2023 18:21:08 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf7pnt53f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLMwixrSzq0m21NMABgo2mapxIiBI7kOEYEqHHFAXDfBzc4mJLe4NRm1oUch2UoWtTA7BMhNYkH23rxmkfbWOjGM40TZqfDC85dPOLxRkODwErWYbPS0dcWAGHA397NcmnXZmNMprneAvWDUpzrrJFY093KCDV+NLUkRXsAUMnNSPA6w2L96TFRX2edxfYZc7tNKeHqvZtC42Xacn8QXgxEMQ1P6oBMdxr3RhLDq2A5m1xGdylzzk81IEC+BDjMjvnUxMUUW5KWwbrdPpoItqDM5oMnBtjcwzINWIsJiu7Br2BvlBpXojlrPfdYcAD8qVMj2RbF6F1UfaVTLoZW33A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bn7CJVTTzCGJHfmLE/+2NIyJatFk0uV6AOMMUMy4o98=;
 b=nB8WAhxxSO9gAaSv4EZdy/sgJegnEdneUsg3LA0AtcZcUlswVvfHfsdK8qah2oOeeKK01fNz5KvjhUAddlVHYvKpxdqn3dFb53teUUWrsu3m80eK+lqxCm+IUiUa8gnnqPX9m3ltLSjMR/B+fq6YsD3/QNiMvtxd1Zg+oHn7bAfj3LgoKUH4hgY9MBYozUe1EKvKDU3NKQCWCeulwvdp4FMN1T1WzS65NhHlbBH5hO4bsvf4VDop7L8rMZYMlJKoPAo/6x0jdjyBiSsL/jNEJRIVPzlgyKMgZYPzLMImlDzwk/dSZYzouXZ9OvSJQ+Vud/8jv8UVOiqZ6N19GbBb0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bn7CJVTTzCGJHfmLE/+2NIyJatFk0uV6AOMMUMy4o98=;
 b=qb9IXBhpiWPP5o0CVvQjZWj1/1D32WQsU53aCVuJugiVqwMt0LGmK1fuk9ED4bcSV5Ec+JXYqT39nPISniglIgJ2dCBQOZtowM++dEQKCroZMKmaaQDdXShp3zGOa82MP7GKlft5Rgv7JoC0n1NzJw1UqSZ88xQ+ErpYtcBR3hE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY5PR10MB6143.namprd10.prod.outlook.com (2603:10b6:930:35::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Fri, 12 May
 2023 18:21:05 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 18:21:05 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 06/35] maple_tree: Add debug BUG_ON and WARN_ON variants
Date:   Fri, 12 May 2023 14:20:07 -0400
Message-Id: <20230512182036.359030-7-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512182036.359030-1-Liam.Howlett@oracle.com>
References: <20230512182036.359030-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0059.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::16) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY5PR10MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: ebdc38a5-731e-4b06-7b16-08db5315a65f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xou2A/NpUFZCA0jRyaS+/SyGkbFvNezKoK7wkE0wzgC489rGan0kWyzO6om3XBvWwT+sxmXjwPNzgqftnEBgH15vilKgjjGTy7ExuD/FdgEFGztmnwy3dJxD+8mbzH3xTvZ9+yb3hIzsH2mSwCtHQCzIuTz6lcL7f8vjLyU2LzbWOc1tBEidItom40qNATLxfHXw6bFiB7nA91Bmsxxm7bsCv7Qz6gPixIaD8PiKOAwoZjzb/AHKzUppbEP2BIQIX+botoK04lPcyqIRcxkDUrl5K6AFN//jV37xRbNTkppD66+ag+lxiPHruNO0DgRtz/Nml4NszKA0QqC71VmxhanB4Ghqe1MD6SdsiHrfIrbuTxBXCY38n5NTXSU7dUprFkCec2FkbbrevsOiOW4n9DWvrsXGvQV0/PJBO19xDy26G+1p1bIH1E+Di8NDzv81DWB4DAUP7ow4SkKMQqcW5wHwZObe2QeqzXLeNc+9LuGNVZoua3DrQcbtj66IjUatOhw9AQ7r8xL1pC4Ywwbja4FUouxmj7+3GTvU5Ce/mABpMdXYadfpAK/P5ml3eG05
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199021)(2906002)(6486002)(66946007)(41300700001)(316002)(66556008)(8676002)(5660300002)(36756003)(4326008)(8936002)(66476007)(6916009)(107886003)(1076003)(86362001)(26005)(6512007)(186003)(83380400001)(6506007)(2616005)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?skr3lahF67KW61NYIrjvxd9aAR8HT5KIkv8XBFVquDnT8JVrFfEKWhq+2bZX?=
 =?us-ascii?Q?JhgiT37t6zsk1EVg5L46JEfqWX3wqvZqGGiNT3EdKRqIhh+0JuKELV9SFGPs?=
 =?us-ascii?Q?jZCs5+qYhj7hImTrkKxQMHEe8PzBbbDntyyrNbVrqUMOPKwwQU2xx8ceF3fe?=
 =?us-ascii?Q?9XK7E3tljyt+INqZ6v4MFPwnwvx4+/ZZbVc7SLEpPyV6M9OVAEeGI7VhS/ZM?=
 =?us-ascii?Q?JuJZyNDhpOhUdkwZoPMzjAFDUGczxvzczkeJZkllsfny1UPdP10uEO7mxdVA?=
 =?us-ascii?Q?75aTtmRkiUJ+unELhTFds+LdoGCdv9n8PbQXLogGd8QdtLpnQJU6D+76aL26?=
 =?us-ascii?Q?8SDAWsR3uR1/1TfQaAuobsLR26g7VrrkEIDd7UeRYe9SYuccwYcTJHp5OVxB?=
 =?us-ascii?Q?g67dfQRrWS3/3SF+s258gOdTYLLI7uWtzRMft96lDmlcTWi4puAstT2zTpWv?=
 =?us-ascii?Q?kSh7mpdjUniGvoHRz+3JhI7y3Z1aSuE20lKo0Uaj2A2AcGkVQLSTpkG/0ixz?=
 =?us-ascii?Q?evFi7YURfyYu++KxvjntVcdJOs16T8CGG/0Y5hS5hGtzDWCSApi4W4SAROld?=
 =?us-ascii?Q?33X1/SDVrEOeZRj3wJLwMiduKJQoakVwBLbqwOiqGtq4ka/K1lEAqUNZMSoc?=
 =?us-ascii?Q?iT8BfyLlgtOkf0yGKBj2fmbrmB78dohci4RtGqoqhYhJve8C1VjNzOZH4H/J?=
 =?us-ascii?Q?EM9lbbbY35uyeXyveWDuwAvQHhmFpQhRRglRUEZP1ektk49TSA4saEbj7qrM?=
 =?us-ascii?Q?0XJKDZPKxRj66j1OkH/6eInsc20gM4nVE2qM0xdzmjZ4FD9/Y5+D6Jd/6iwY?=
 =?us-ascii?Q?G9s9benFDivI7xsdeODcw6AV56tqiv8AFc28XJYPoutC13udIFt5u9Jd57iL?=
 =?us-ascii?Q?VWBvMY5zFPKMrxu16DKJHAllZrjB8XaeDutY9v+8RUbmuIZ2tRJzx7jP+bSD?=
 =?us-ascii?Q?785oq0d/aww87BNbqZCIO2YTmLG4iqQjfqyJDUeTG0Yjik5b8/gqrF+csSaB?=
 =?us-ascii?Q?vfhgEjZPF/qUIbRCPjmJmmu4f+o3DegF2aaQr2adlttdyxMVPL7iizmNAQE1?=
 =?us-ascii?Q?Jm2QFXw0BYzLFg39rhDnN9824ge3cZAdPlQ56Vj/g2AlzppU+A5UxQEqB3qn?=
 =?us-ascii?Q?wv0i3aNuCre+0d/qguZwFqDqSsTzMB30UHDfZKS7qpXvwiQsBnNKTbP+78JK?=
 =?us-ascii?Q?ZLZ4dpjCMBFqq9IEJQm3oQ9xZpUqm4uI94rQmX2E1wibR+zp7Miydwz7tV8p?=
 =?us-ascii?Q?70m07F2Vo5ByxDvD7LXdU1UHuRsZP+EYfalbgFgxJwGqfAaIxmst2UQYEvxb?=
 =?us-ascii?Q?fDJu+GGzPVAQZbqBNPjnG4IaPp5tYPhMGNUorjORbVF3VjDzlJgX+0Mh9bn0?=
 =?us-ascii?Q?qcOMHBN7vJYyEjaiaFNrKMYQ3jqii3TDdLuVlOAu9clLLPm28MOmx0ov9+8L?=
 =?us-ascii?Q?/PUUP+Co9XI4lWSsYndgaE85Lmga/SJCSL1XB17Mc3iSSzzdbrwQYnDP17U+?=
 =?us-ascii?Q?BYPnBkvkhfYHDWN/GgQM6KA+XAvieCmZhpehrYN3uzDaV+KvtAgtkSr2jhOD?=
 =?us-ascii?Q?78DL5I/EWsRIJnmboXCaMhbwsmeRL9jco4Woxl8aeA6oDEh1vmQp0j2UFFWr?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7wm7vctDWvBX97SiE2z0jAIXFNixZ9t8gJLGKSiHHYexeLaO3TXX2dqq4vrcl+r8n6WT3RtxN40V590zVs3A1TULwL8QATGRA2l5PUb6Z9RXJMaXT8B8LsX6Ersjz4Fa1yIlDRmfUPSwKN+tZguWG97Us6B4fX1vvFflnRuaRg/EO4UM5266ROGtNwaanzfbJqY3F3Cat5EVrs4tJsup4mHbbrUnOdMWK+nKX7hP42CLQyqh8wh4H3MDDI1Zh1pG8uf3SZHlSSY3lTJsJ9Dmy4z/PCNX3GqU5U4m2dJxICUzsr5471FodtH/SNOZQ+K8+lCK7G+MMZuXHCOK/POCIh25owtNWOK8MuIX3I04bKXOONKSYvBmeGkwz9YCBEkvhhL0UfKKqPeEuLjayaBKVQhlxF7+uEt13ObCCJstHxWKJiBnJ/RMqFoz5L5vEV7+BMN4NYTi16+bXueT3g8RWJzjobgAmMcifovacoNJCHiOeQ7BnPoR5JTis4WMvrrDV/7rH69FsQBtAbjHgq1KC1G6scl8MkeYkvcknaF3Y9yjgnSQgTZ+7Dpe6ORMIF48WD9eY9/W+t2Y10iLNAkh1T14Mkdjf8kcSt8ei0au/e9M0tdQJK5rEXuEo4t5nRdDspk4p/DEs+VD4oa2aCaP9bdsTUt+G4TRsTgcu0RRv4eCsTqGNPzKARqxipFy8EfZQc49oLEoHICSP5Dev19U8MdxdiW+oZ/GD/l2jzyxOTlw/cx85O8bueyAlWTmW+5J1ug/l0QWSXm/5uWzx6gmtcERFue6gm9y3/1r9x167lJx/AX2P0n/yCTxEOHBYFvO13VhEV3Lzxini3Vgz2WyNN7YpKsLa6PRgQ1UqB0e3JJ7iNEeA/meGLg7EIRhadMH+rfkoOrV5yipIFnZgQpDKw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebdc38a5-731e-4b06-7b16-08db5315a65f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 18:21:05.5259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pz8S4yrZRJmkwK7NF/wYfTajyZYdr/DSQzbL9gDTKrF/WpazFg6T2C3yxt+FSkhcSlW0pPswscCtujy0dQUl6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6143
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120153
X-Proofpoint-GUID: 8zqhkb90_gDpdslMKymobieXa5nx6S7v
X-Proofpoint-ORIG-GUID: 8zqhkb90_gDpdslMKymobieXa5nx6S7v
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add debug macros to dump the maple state and/or the tree for both
warning and bug_on calls.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h | 100 +++++++++++++++++++++++++++++++++++--
 lib/maple_tree.c           |  34 ++++++++++++-
 2 files changed, 129 insertions(+), 5 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 140fb271be4a4..204d7941a39ec 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -482,13 +482,13 @@ static inline void mas_init(struct ma_state *mas, struct maple_tree *tree,
 }
 
 /* Checks if a mas has not found anything */
-static inline bool mas_is_none(struct ma_state *mas)
+static inline bool mas_is_none(const struct ma_state *mas)
 {
 	return mas->node == MAS_NONE;
 }
 
 /* Checks if a mas has been paused */
-static inline bool mas_is_paused(struct ma_state *mas)
+static inline bool mas_is_paused(const struct ma_state *mas)
 {
 	return mas->node == MAS_PAUSE;
 }
@@ -679,6 +679,8 @@ extern atomic_t maple_tree_tests_run;
 extern atomic_t maple_tree_tests_passed;
 
 void mt_dump(const struct maple_tree *mt, enum mt_dump_format format);
+void mas_dump(const struct ma_state *mas);
+void mas_wr_dump(const struct ma_wr_state *wr_mas);
 void mt_validate(struct maple_tree *mt);
 void mt_cache_shrink(void);
 #define MT_BUG_ON(__tree, __x) do {					\
@@ -695,8 +697,100 @@ void mt_cache_shrink(void);
 		atomic_inc(&maple_tree_tests_passed);			\
 	}								\
 } while (0)
+
+#define MAS_BUG_ON(__mas, __x) do {					\
+	atomic_inc(&maple_tree_tests_run);				\
+	if (__x) {							\
+		pr_info("BUG at %s:%d (%u)\n",				\
+		__func__, __LINE__, __x);				\
+		mas_dump(__mas);					\
+		mt_dump((__mas)->tree, mt_dump_hex);			\
+		pr_info("Pass: %u Run:%u\n",				\
+			atomic_read(&maple_tree_tests_passed),		\
+			atomic_read(&maple_tree_tests_run));		\
+		dump_stack();						\
+	} else {							\
+		atomic_inc(&maple_tree_tests_passed);			\
+	}								\
+} while (0)
+
+#define MAS_WR_BUG_ON(__wrmas, __x) do {				\
+	atomic_inc(&maple_tree_tests_run);				\
+	if (__x) {							\
+		pr_info("BUG at %s:%d (%u)\n",				\
+		__func__, __LINE__, __x);				\
+		mas_wr_dump(__wrmas);					\
+		mas_dump((__wrmas)->mas);				\
+		mt_dump((__wrmas)->mas->tree, mt_dump_hex);		\
+		pr_info("Pass: %u Run:%u\n",				\
+			atomic_read(&maple_tree_tests_passed),		\
+			atomic_read(&maple_tree_tests_run));		\
+		dump_stack();						\
+	} else {							\
+		atomic_inc(&maple_tree_tests_passed);			\
+	}								\
+} while (0)
+
+#define MT_WARN_ON(__tree, __x)  ({					\
+	int ret = !!(__x);						\
+	atomic_inc(&maple_tree_tests_run);				\
+	if (ret) {							\
+		pr_info("WARN at %s:%d (%u)\n",				\
+		__func__, __LINE__, __x);				\
+		mt_dump(__tree, mt_dump_hex);				\
+		pr_info("Pass: %u Run:%u\n",				\
+			atomic_read(&maple_tree_tests_passed),		\
+			atomic_read(&maple_tree_tests_run));		\
+		dump_stack();						\
+	} else {							\
+		atomic_inc(&maple_tree_tests_passed);			\
+	}								\
+	unlikely(ret);							\
+})
+
+#define MAS_WARN_ON(__mas, __x) ({					\
+	int ret = !!(__x);						\
+	atomic_inc(&maple_tree_tests_run);				\
+	if (ret) {							\
+		pr_info("WARN at %s:%d (%u)\n",				\
+		__func__, __LINE__, __x);				\
+		mas_dump(__mas);					\
+		mt_dump((__mas)->tree, mt_dump_hex);			\
+		pr_info("Pass: %u Run:%u\n",				\
+			atomic_read(&maple_tree_tests_passed),		\
+			atomic_read(&maple_tree_tests_run));		\
+		dump_stack();						\
+	} else {							\
+		atomic_inc(&maple_tree_tests_passed);			\
+	}								\
+	unlikely(ret);							\
+})
+
+#define MAS_WR_WARN_ON(__wrmas, __x) ({					\
+	int ret = !!(__x);						\
+	atomic_inc(&maple_tree_tests_run);				\
+	if (ret) {							\
+		pr_info("WARN at %s:%d (%u)\n",				\
+		__func__, __LINE__, __x);				\
+		mas_wr_dump(__wrmas);					\
+		mas_dump((__wrmas)->mas);				\
+		mt_dump((__wrmas)->mas->tree, mt_dump_hex);		\
+		pr_info("Pass: %u Run:%u\n",				\
+			atomic_read(&maple_tree_tests_passed),		\
+			atomic_read(&maple_tree_tests_run));		\
+		dump_stack();						\
+	} else {							\
+		atomic_inc(&maple_tree_tests_passed);			\
+	}								\
+	unlikely(ret);							\
+})
 #else
-#define MT_BUG_ON(__tree, __x) BUG_ON(__x)
+#define MT_BUG_ON(__tree, __x)		BUG_ON(__x)
+#define MAS_BUG_ON(__mas, __x)		BUG_ON(__x)
+#define MAS_WR_BUG_ON(__mas, __x)	BUG_ON(__x)
+#define MT_WARN_ON(__tree, __x)		WARN_ON(__x)
+#define MAS_WARN_ON(__mas, __x)		WARN_ON(__x)
+#define MAS_WR_WARN_ON(__mas, __x)	WARN_ON(__x)
 #endif /* CONFIG_DEBUG_MAPLE_TREE */
 
 #endif /*_LINUX_MAPLE_TREE_H */
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 084868865849c..a28b021f740f1 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -240,12 +240,12 @@ static inline void mas_set_err(struct ma_state *mas, long err)
 	mas->node = MA_ERROR(err);
 }
 
-static inline bool mas_is_ptr(struct ma_state *mas)
+static inline bool mas_is_ptr(const struct ma_state *mas)
 {
 	return mas->node == MAS_ROOT;
 }
 
-static inline bool mas_is_start(struct ma_state *mas)
+static inline bool mas_is_start(const struct ma_state *mas)
 {
 	return mas->node == MAS_START;
 }
@@ -7251,4 +7251,34 @@ void mt_validate(struct maple_tree *mt)
 }
 EXPORT_SYMBOL_GPL(mt_validate);
 
+void mas_dump(const struct ma_state *mas)
+{
+	pr_err("MAS: tree=%p enode=%p ", mas->tree, mas->node);
+	if (mas_is_none(mas))
+		pr_err("(MAS_NONE) ");
+	else if (mas_is_ptr(mas))
+		pr_err("(MAS_ROOT) ");
+	else if (mas_is_start(mas))
+		 pr_err("(MAS_START) ");
+	else if (mas_is_paused(mas))
+		pr_err("(MAS_PAUSED) ");
+
+	pr_err("[%u] index=%lx last=%lx\n", mas->offset, mas->index, mas->last);
+	pr_err("     min=%lx max=%lx alloc=%p, depth=%u, flags=%x\n",
+	       mas->min, mas->max, mas->alloc, mas->depth, mas->mas_flags);
+	if (mas->index > mas->last)
+		pr_err("Check index & last\n");
+}
+EXPORT_SYMBOL_GPL(mas_dump);
+
+void mas_wr_dump(const struct ma_wr_state *wr_mas)
+{
+	pr_err("WR_MAS: node=%p r_min=%lx r_max=%lx\n",
+	       wr_mas->node, wr_mas->r_min, wr_mas->r_max);
+	pr_err("        type=%u off_end=%u, node_end=%u, end_piv=%lx\n",
+	       wr_mas->type, wr_mas->offset_end, wr_mas->node_end,
+	       wr_mas->end_piv);
+}
+EXPORT_SYMBOL_GPL(mas_wr_dump);
+
 #endif /* CONFIG_DEBUG_MAPLE_TREE */
-- 
2.39.2

