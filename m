Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85476759F3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjATQ3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjATQ3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:29:52 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE1E6E42B
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:29:09 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGBgNo011451;
        Fri, 20 Jan 2023 16:27:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=wtPp3eN9iK5NopTe9WlgicVNohmSkC3cxheIrIE/maw=;
 b=y+0jGYt46jBurJUHEwgqiT2SRKNI87uBcqy7XcZbeH5z1aT2kjZvXoSKmOQMz+eOCeOe
 voTcqZNBq/LTPekg5bILRQqtM26hS+Zl1OxkRkZSvsahjm57qHflUmZ1ki4A0cAz6sMt
 MON6TkoXGd7YnrbmenYcFNnukZthGYxwHQ/SulxzCi0Wg5e7kF4zGapojoRF7WpWpUWe
 As3JDvNU4golU+0zzpPtrBAVaFdC+sLWPYJckmFWH+j6l/H+opNcg/nsS6m1IGUyM/pn
 TjMtnYlZ8LetEuHhEZeeuQHDMmlATi+2N3+RFevPV+6Kg+XpuQN8i8bn4i5wsouGCRRf rw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n7895aqqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:27:57 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KGNKAa004680;
        Fri, 20 Jan 2023 16:27:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6r2w1fg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:27:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUBRLak9yXOzp2ayTdvQoBeEeW1oy17Lxg9iKyyaRcgiwGuZHUIz/xyIhjwmTu0aA/zPv+eFqugSI5s+XTCF02UHnZ1MG4oS1DzhaUKjvFoT2Zr5XSRueJOvJKOnMSpStuHn7XxMyP9IFam+fYHdBF6b/ucF813O31q6SdzH10AXJj24i/gLTMdwRRH9uQIowhblYC6jljnn5/qhRIwZRcV8ExXK6YpQPfbCfSd6E3JVV8GR5ciHfZeA6pBTMH8A86pqHG8IBSuXP3KjOqDgoSwLSfIjwksx+yWdE4lNrWNZDmxAfNkJcbgl7TsNbW7uLISJnudlYjPPm/h0NWoi1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtPp3eN9iK5NopTe9WlgicVNohmSkC3cxheIrIE/maw=;
 b=VFsYBKDxfJLYFob4VUmELIWengWQc8H2/7ifnEastdkg8yDXv2y45dEb3s1bnm7tCS0Cpdh1VcYa+9gHM1U41OHJ300s6B38ypFppV2eC/HLAG96oTGaHWxgwyG7MpU7s1mO6TF7tP3vQtJRPvAG/IlyidnAx5dkkCB9groxn+tI4Dg4pAkRDe/gOQek+Z7cQWKMUKYHg9/1DZXlfbTnAaYIKN6gsB8HZ7AzkPr/32DH+27BfZJ4IWCipNQOJCuUGjCf87BiadEBR3kk1KH7nWK2Rc1xkAxpmRiY/Jfs3zOyHHkosTmKyOj5h57yLvNpvezXofyDRo4QKLT8FbueJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtPp3eN9iK5NopTe9WlgicVNohmSkC3cxheIrIE/maw=;
 b=YYhzqJ+6qalHpNebx/Pvb1x3XNpQ9syPN44O1jDsXr4Kvjo8jtEKHP0xVWTF3Uy+KGTe1bE1K7foI/giD44jiaVWDAh9WgBOjn/1O9b1kZs1lNgTZy1jUmOy0xhqD7YcSdT5uRGBMe8o2CGFCDKtxA8QXyXkezpWXDiAhLzjKCk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6619.namprd10.prod.outlook.com (2603:10b6:806:2ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.7; Fri, 20 Jan
 2023 16:27:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:27:54 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 17/49] mm: Change mprotect_fixup to vma iterator
Date:   Fri, 20 Jan 2023 11:26:18 -0500
Message-Id: <20230120162650.984577-18-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0053.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::10) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: f8f828d7-8095-4dab-af8f-08dafb034724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MDZmWyhd84Pb7/yixS2jJ3jD4fbugUOXEWyhGzZgqrwEYm4I7IJe+6b/y7327ymTZ5Oipu9lFNJ5Pppjo8CdaRi05lTNHhguOpAcs5znsNFMz+h6eugW2qJnJANLKTWtuePp6JQkfeo37U+zU8BeP3JQo1C47WQ7IiX0WB8wLFUU5vAew/hUGu2b+tiC/4Ct6dFYNcjfYqC87SwyEBByWY4+W5mnP6EtZTvg++F+XR/UuHJq0whgMfHQqeOEdO3ErCbq9tuTf7Ba5POzuhDaaLK0ANeqS3wFeMesoztBDbGZOjf9xKO2bZ6nY1V32Yo0aF5NrSlp3bvaOurScwnMI2yOHRo9bMLUT8g7cwP1xrHArlb9ZKJoBuxfPZhwB5WiH2kndYqvTcM3zCkvmeMk68pTPSJlOe4nFcyPgAQHFSI/PofuXJAwqUQalshkFeB6d6dIR41F3S+ih07dyiMGBajxqB67PgSuKuaPEW4t/ArTykO25VWnn5QDoaGN04wXFNK1g3vb7Js3QA1ZU5bR44sP7f1pl5dC1t2zKPQDR94KXnwaqpIrlfqZetJyvyeJEeCAmkuj8nQKBEnrN56IVsJz6avTGZoHxHxnby9vlXKww4bb4uJHBv0jQdvKLC9VMaHbpZhWSS6BeGyQnE6+HQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199015)(83380400001)(54906003)(86362001)(5660300002)(6486002)(2616005)(38100700002)(8936002)(478600001)(6512007)(41300700001)(2906002)(107886003)(6666004)(4326008)(8676002)(66556008)(186003)(26005)(316002)(36756003)(1076003)(66476007)(6506007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zUEKC/rWe/a/xKFTvv+3aoPiuxmozMYJNEwvZsKRj0u1IK7zyd18sDkPUsqz?=
 =?us-ascii?Q?vBBLLsl46My+G+GjgV409rFRouYM46mYtXhVOKsR2dce1DW1TsDkgtAbm2pl?=
 =?us-ascii?Q?YcPBrTZZu85i6cSCSszrcGMWmsjMlYQWx7LTexv3Il0UoMvbK6/u3H+LX5DC?=
 =?us-ascii?Q?j5x0ObSNXR6WThnKywshvXDdpsBp1jHrzTHw7x249NqO8uGRXZvE1vKJD/U1?=
 =?us-ascii?Q?dBWZ/J9CIVcWhN/rzDKNp3krNAYUo1DcT/0bKYvIJkUP+aH5r2XeNKxxKaw8?=
 =?us-ascii?Q?K3Y/d1Litmw/22vxMTWK+rz5in0pjT64+Ob8iY488p2/FrPnfLIi/uztpK/t?=
 =?us-ascii?Q?ZK48B/tpqvNSXEkbGj5Ct/uBwSTo7qIBfADmnw4U17pr6lO6x3sGpRnje/0V?=
 =?us-ascii?Q?Bd/jwT0FlldSc5lEWp89XWzQpJZfXDnU7vZulZrFvr+0XkDfaHAikLbShENQ?=
 =?us-ascii?Q?lhK8h9hfvEb06vN5hIiPoXt7zcg9AKy+BI7eHVakAiAR/6RPTta4ZxjovEkt?=
 =?us-ascii?Q?ArKVvG0eT/FSzy7AW/1CohIhbYGiLJCOt4FkvR65v2Z+OumSXvQPY5BqZ9Hc?=
 =?us-ascii?Q?J6Xf0YDybADIm74YUNDCq9qu2wC7B1FCibQOG0PdHUh6fmAK+QTsTS72P3x8?=
 =?us-ascii?Q?Qu/dWc0XwoP7vDagl9hcdGWvq0Z+T2d0c5KdoA8RbIOx3nHiXYaxUvxWFXOl?=
 =?us-ascii?Q?sapDV2QMfC5v8ADG7Wpr/iGWHPDUry8mPrlX4f2j0UHXVVNhSOK4OXih3D5q?=
 =?us-ascii?Q?bPBxWRLvAjxxClUvnZpunC2QMbY1R/mlGVNZQX2T0YBWzKLxCrjmYJltXeqs?=
 =?us-ascii?Q?3mRSBtCAg21quFWSMX4tB0+ynVoHIvlBKlA5UZEddu+jyXeGus5rgrvtzzun?=
 =?us-ascii?Q?dXM4Mbb5wGH2Xtys4J4OF8fyfK4219PJWfIH1VlC+s5zOTpYOOvzczBMBKOE?=
 =?us-ascii?Q?6rCzIDA9ow2A5Tup92aPtFTu5hhpf/u0ADOyUmQDVyOzQeGUAVLiu6vMB6Q1?=
 =?us-ascii?Q?mUxUTsNSSioe31740aa/OK9ritcpAdINXsx3xuIsefikYUqv00aLbdSq8dXm?=
 =?us-ascii?Q?LLtdZwzJcD+Nhk/yIdhM6XJBaOaAs552QJebrEv+axRJpjVdxP7gsGkYMc4L?=
 =?us-ascii?Q?sZ+csDxpiHyXg1s5xZiJTYDbKAeEIu7e87Gzch9PQkAzJ/+8Uqv0uT1Gfolu?=
 =?us-ascii?Q?BGsqz9bOFq5dKwP3I926N+/5W/wSiGnSo930kd7uU9jtZfhA7rgjIiuMVCfl?=
 =?us-ascii?Q?yPrilpvNJKBuT2K61YSt4HkJ5PL4CjIOUAKn9H1pKGM8freHaCQWl/6nIrHU?=
 =?us-ascii?Q?QzGXr/7Cchloi0MVMynVBh2cqgZTKVgjsZT8cDo6VXKZDATUgz7bgSpN5a4S?=
 =?us-ascii?Q?4T7fQ533i48A8dHcsEBZ79t00novE6Y3tW68DHbZwhDZh3coBru4KOy0zXAH?=
 =?us-ascii?Q?rcTlxx/ZojQ6WxIIJylcOzMxQoI0hXBi3Hvc+xdmB1eIDEBw5McfEf+S8WZZ?=
 =?us-ascii?Q?FfDf8jPCP8DvvWrKIu/muEaFtm9iDhDWXPX2+sitrOKJSjuHV3WHlQC0Z4IO?=
 =?us-ascii?Q?oRQMIGU0W9FFuv6+vxDzm85OeyyNAXl/5h8+QQzzXhkljzm+lQbXTZUqQlbP?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2h6JVaKoibL/zcHIL0WXzMPfHgDAoHh+tyOzS6r0tyZMwunz/ph39su5IhPXj4mZA/iqwLwSnnkFF0ZOP4nz7K5Ulf47rCZh3hi8Ar1eoQZJbeX8yjm5J6Ru9Dj3sZozYPw5YDtDE3KfnrGeWx0xMz734u8bhUkAwdxTeTLX7PBiUS8/S1P/pel+fSMuz8bpxdUOfnP2zfEHAxwOnAVN1KtFHLvf2MLKrL/gU7Dy4AhVkxmUCYZvISF8eGGr3+Wbb5GK+Ut3hosSvtIjgV7V7085LricNu64qF2/SfjMoXj9Qt0zoALFnRXzP/4dGdPrMHNig19qLJ9wEJybPfLXHyoKX/YYTFEy8rU4vz+5CkY8+R8eFr3N48j9uhUg0cN2YlMvcLxSY/NQyXvUUz+s4Q/zZ8L/CnNvV+H3zg8W162NLElMyVakgHKXBy/SBv0GfguuNisl1VBYt1P15+ByE7i2y69RF9YEagUnuL+NnMJW7PUK3TSfKph5fYcNZvj6q12vsipzNxe8/ty0rVSveFznGpEDCxDqhLFAXXzfHbrt+Rv4SGapPyMz9gsajs9t9cmm+r0EIfKhiYqO2KgCljv06H2NYyO7yNSmcj9CB6xm1rhP19bSLfzvRWnTQRwwfsQuGprkBraupttk2GpT18K85N6zebMSOCNWakf3rbekWBzWR19CtTVD5XnWPvUy72OBZpEv7ipd2VC20PGdgm3riLuYTD9x4Ca2vRn4V/q3mNi3MnRgPPP5jThQSs8S18niI2vOwxJ0B5nM5kYgUEJZNKkpJYFZ7gT1KriP8zdd6YV4swYXVSC/2KvpEk/MY1cbP2Lli/pVLchTo1XbH+Fuu+R+4oHDbCNUGqSKYl9jFYESXvSkNOz+wworR6f6G4Xf9PJycsiIwJXlih0oGg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f828d7-8095-4dab-af8f-08dafb034724
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:27:53.9343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fngPoPCqB1K0KlLEdnb4KyD8+fhSuzFUnzWYVSAe49NZe+cB4mxpBz9hWgsoOVAQjSI1Y/FrKuThbG1shKszjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6619
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200157
X-Proofpoint-ORIG-GUID: LX4velZOPk1AdnYDc9MUz36b4KoaiUDT
X-Proofpoint-GUID: LX4velZOPk1AdnYDc9MUz36b4KoaiUDT
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
 fs/exec.c          |  5 ++++-
 include/linux/mm.h |  6 +++---
 mm/mprotect.c      | 47 ++++++++++++++++++++++------------------------
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index ab913243a367..b98647eeae9f 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -758,6 +758,7 @@ int setup_arg_pages(struct linux_binprm *bprm,
 	unsigned long stack_expand;
 	unsigned long rlim_stack;
 	struct mmu_gather tlb;
+	struct vma_iterator vmi;
 
 #ifdef CONFIG_STACK_GROWSUP
 	/* Limit stack size */
@@ -812,8 +813,10 @@ int setup_arg_pages(struct linux_binprm *bprm,
 	vm_flags |= mm->def_flags;
 	vm_flags |= VM_STACK_INCOMPLETE_SETUP;
 
+	vma_iter_init(&vmi, mm, vma->vm_start);
+
 	tlb_gather_mmu(&tlb, mm);
-	ret = mprotect_fixup(&tlb, vma, &prev, vma->vm_start, vma->vm_end,
+	ret = mprotect_fixup(&vmi, &tlb, vma, &prev, vma->vm_start, vma->vm_end,
 			vm_flags);
 	tlb_finish_mmu(&tlb);
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 956025940053..bd0017ab13f3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2197,9 +2197,9 @@ bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
 extern long change_protection(struct mmu_gather *tlb,
 			      struct vm_area_struct *vma, unsigned long start,
 			      unsigned long end, unsigned long cp_flags);
-extern int mprotect_fixup(struct mmu_gather *tlb, struct vm_area_struct *vma,
-			  struct vm_area_struct **pprev, unsigned long start,
-			  unsigned long end, unsigned long newflags);
+extern int mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
+	  struct vm_area_struct *vma, struct vm_area_struct **pprev,
+	  unsigned long start, unsigned long end, unsigned long newflags);
 
 /*
  * doesn't attempt to fault and will return short.
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 6ecdf0671b81..42ceb0548754 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -585,9 +585,9 @@ static const struct mm_walk_ops prot_none_walk_ops = {
 };
 
 int
-mprotect_fixup(struct mmu_gather *tlb, struct vm_area_struct *vma,
-	       struct vm_area_struct **pprev, unsigned long start,
-	       unsigned long end, unsigned long newflags)
+mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
+	       struct vm_area_struct *vma, struct vm_area_struct **pprev,
+	       unsigned long start, unsigned long end, unsigned long newflags)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long oldflags = vma->vm_flags;
@@ -642,7 +642,7 @@ mprotect_fixup(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	 * First try to merge with previous and/or next vma.
 	 */
 	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-	*pprev = vma_merge(mm, *pprev, start, end, newflags,
+	*pprev = vmi_vma_merge(vmi, mm, *pprev, start, end, newflags,
 			   vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			   vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 	if (*pprev) {
@@ -654,13 +654,13 @@ mprotect_fixup(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	*pprev = vma;
 
 	if (start != vma->vm_start) {
-		error = split_vma(mm, vma, start, 1);
+		error = vmi_split_vma(vmi, mm, vma, start, 1);
 		if (error)
 			goto fail;
 	}
 
 	if (end != vma->vm_end) {
-		error = split_vma(mm, vma, end, 0);
+		error = vmi_split_vma(vmi, mm, vma, end, 0);
 		if (error)
 			goto fail;
 	}
@@ -709,7 +709,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 	const bool rier = (current->personality & READ_IMPLIES_EXEC) &&
 				(prot & PROT_READ);
 	struct mmu_gather tlb;
-	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
+	struct vma_iterator vmi;
 
 	start = untagged_addr(start);
 
@@ -741,8 +741,8 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 	if ((pkey != -1) && !mm_pkey_is_allocated(current->mm, pkey))
 		goto out;
 
-	mas_set(&mas, start);
-	vma = mas_find(&mas, ULONG_MAX);
+	vma_iter_init(&vmi, current->mm, start);
+	vma = vma_find(&vmi, end);
 	error = -ENOMEM;
 	if (!vma)
 		goto out;
@@ -765,18 +765,22 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 		}
 	}
 
+	prev = vma_prev(&vmi);
 	if (start > vma->vm_start)
 		prev = vma;
-	else
-		prev = mas_prev(&mas, 0);
 
 	tlb_gather_mmu(&tlb, current->mm);
-	for (nstart = start ; ; ) {
+	nstart = start;
+	tmp = vma->vm_start;
+	for_each_vma_range(vmi, vma, end) {
 		unsigned long mask_off_old_flags;
 		unsigned long newflags;
 		int new_vma_pkey;
 
-		/* Here we know that vma->vm_start <= nstart < vma->vm_end. */
+		if (vma->vm_start != tmp) {
+			error = -ENOMEM;
+			break;
+		}
 
 		/* Does the application expect PROT_READ to imply PROT_EXEC */
 		if (rier && (vma->vm_flags & VM_MAYEXEC))
@@ -819,25 +823,18 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 				break;
 		}
 
-		error = mprotect_fixup(&tlb, vma, &prev, nstart, tmp, newflags);
+		error = mprotect_fixup(&vmi, &tlb, vma, &prev, nstart, tmp, newflags);
 		if (error)
 			break;
 
 		nstart = tmp;
-
-		if (nstart < prev->vm_end)
-			nstart = prev->vm_end;
-		if (nstart >= end)
-			break;
-
-		vma = find_vma(current->mm, prev->vm_end);
-		if (!vma || vma->vm_start != nstart) {
-			error = -ENOMEM;
-			break;
-		}
 		prot = reqprot;
 	}
 	tlb_finish_mmu(&tlb);
+
+	if (vma_iter_end(&vmi) < end)
+		error = -ENOMEM;
+
 out:
 	mmap_write_unlock(current->mm);
 	return error;
-- 
2.35.1

