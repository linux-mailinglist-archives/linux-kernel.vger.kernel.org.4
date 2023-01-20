Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5156759F9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjATQag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjATQaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:30:30 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A05D40C6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:29:58 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGDjgB014997;
        Fri, 20 Jan 2023 16:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=cnTBz+bBZ4OTmUg/Q/etSwIKDALuXQlZedjFF6uE7lQ=;
 b=sZW9qtbydKnUKi8p4YseADpJyw1wbu87HQNXXl7I6sXRYr+O7anTe16QbdEj9ujUyZ7Z
 xEzS1QtBHB0JXtG9GZrgZUUeH+cQXJPaNlEyf2ubKN7C9OnBFi+3gz4U907WHUJXOkJn
 CXKmtDoMLPyFYwReYuHE0VWFSX31RQwmy/pOoEICibA3qihlyqNtNM2PFJElGQku0Hub
 PpjTcE9dwG4sgcV5iykZFiUA0TmG4/dc0/erI4UWKSAvloId1xIhqtj/VAtuNPPFCzW6
 uU6COH/UCOpYmfTRXMTYk/lrpYzs5/VIcAI5qLtX02QPn2W9KaF9Gjg16y9XjDQ49xF7 tA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3mxtd243-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KFGYBd000868;
        Fri, 20 Jan 2023 16:28:33 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n74d2sw98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ek2XftSC9we/0Oc19JEx5Xc0+H38GyzHt5D9O8QQkyGvb6BDeNTLtajPuwTRz2UsiNvaf0OZayrXvCItVwA8/TvwvndVYVwRkpA1vEh5D00CeZHxkCRxuKQ6M2KsVsWH/GRSc+miMsN2GsrSNkB8QnFEC5p1t/0X5fW7e60VgX8AMFIjtB/VAyZDpaa55qtXGNCXo1IyDHt4tHes8FKlWgx4EgXP1hO8F6YrL7M3bCmszSqZFuevOXusz2BQKVdzJkmxoKb8KoFMhdIPrtzFdV4JN41K1ojjNQ9IkTLZoovRwXU9OIWSgg3evN26ZtrmADjeNMyOGg5c89URw3DKlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnTBz+bBZ4OTmUg/Q/etSwIKDALuXQlZedjFF6uE7lQ=;
 b=nnuqlxyo4aUrzpSDAkh1A6DVFt/D/hHNvYqvDend0iHFdW2aDRSi7cCW0R3tCdpbGJYTA4UyEtj7xhPQj08csKMxZUSJZmrpoDuIlEXMCofFcYl6ZYH4a4cLT4Nz2NteJZFnh+d96WmUTICPBg8VAo7r3/21E/ngLNLdA66p3yG1CGHmVAcsv28BcYLbg2KVJ9TZZUkeijCLOjd4USyU/i9RUrYX9SgqyHJ/Fyv55tAh7Rd3wjOsT0ufvB3/CVsenfTPP53YynIcqT92cfaOr8fw1OjVAfjvqR4JiP99Ghr+q5cTiUo543Lr9ZLTFMPOhXvwTvDHZw9B2pfRdMufvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnTBz+bBZ4OTmUg/Q/etSwIKDALuXQlZedjFF6uE7lQ=;
 b=co8R3+SjZfH/7NbyrDl8DkaGdcN5WT9EVTbJvPjpy3ZPeetfgVek/RrxwxwHkKdYlkW5I/tpL4c02nBht0AXXiaRK+EDsUje0IgcDBPUH2k7oKyBg8mwG6vUOP4YgYhsW/zOUEojGqGFuthoDd6GQsPny4ib8/Euk8MCaIjcYUQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6381.namprd10.prod.outlook.com (2603:10b6:806:26f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.5; Fri, 20 Jan
 2023 16:28:31 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:28:31 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 31/49] mmap: Convert __vma_adjust() to use vma iterator
Date:   Fri, 20 Jan 2023 11:26:32 -0500
Message-Id: <20230120162650.984577-32-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0152.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::9) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: 08f09c13-ed0a-4c9b-c555-08dafb035e2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3exNDx76DmK5MNpVdPsrRKl1x6LO76mEY+aLMZOSIgGDD51xhsvn8fxwj6B5rJ6ZPdGkagRpX6JjmTX/bN8bPEnZq4Mo/vnW8BXGWuqQeoX9XTe+Xme0gUbi8dIaJ5UIeCddz1hCckjVLr/uJj/+83vVxyXYrrN9B5VdGq0pdk8oXiU6MymjsZncUbu+IbpkXnnAcas85PqOJyGoFvTMTAMTVUvxuTP2d+eW0XZkE1FUr/gwPBiKGobItrymBkEfJKWLyHxZhjlcDFM3AurriCVeS/JathNZq4nT4FENt8U4WhkReTOujiFwrs7TegPH/J9j8m2qXs0j+zUCTrKp8qPgyqDlsTLDOUbq1up9SpW5u7LttegRRW2o38MoPVTkGp9f9ZyRfLel0Wz7guZmuI8JkSCqSCqYbyzSeKnXfQ9e+w5i+KP0bo7W0+4fQPphRabXCRCb0/5SVVbYjTU3XarcqIaL2IxJtXCsC0bLXULk1RJcoLAFyNujsco1JWA3ES4xji4oeP6HYsm0Nh80Rreibmluo4mEbbo+rxHyIk82fpdEQXusPMp7LSsJGyAwfUdPYzjjN1QfiVonQsd9dPESfl2wHmeaLEPVunbRkEl6WX9UPlRV0FVaDXzbKNZEJyOjNZTdYq9MJr6FiDyF8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199015)(316002)(26005)(54906003)(41300700001)(2616005)(4326008)(66946007)(66476007)(66556008)(36756003)(83380400001)(86362001)(8676002)(38100700002)(6486002)(107886003)(478600001)(6512007)(6506007)(1076003)(186003)(2906002)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WoRxMpaIUCn1pe7fs4LZtznFUqFzQ51YTl0PM9Lzvrq769vSgFaeMY0loRJ8?=
 =?us-ascii?Q?hfvzA/TQZ99HZYJc3etbQdTI/67yl9qQjvvstR1rgCWZvHRkzBsAavrNe4/0?=
 =?us-ascii?Q?SGP2PL1/57SyeJbJnUJBYiu7hQEe5dwvd2Ke+tG+iNt7QOIXGNGTdKgwdw/E?=
 =?us-ascii?Q?3Yb08GDv/IuHM0WgKD9aURKZqjyE3MYFzgYhLgfgSXNBOCbylKJF/KCpBK6Q?=
 =?us-ascii?Q?ywPWyt1TOkEDvE2Aii963T/EuLFv2Ni7houTOFzC/w2KbkFeUh0g+raI2Yp/?=
 =?us-ascii?Q?Zk7VxNeltqkjh9GZWHsGATWwpha/Rul7e2wtvrNZo9ZJRkbT0t85JE4/5N/g?=
 =?us-ascii?Q?Z8CsrciucvQWa8Aw9IcKnapsHWTopHNr9+JMk2M6CwzCE8BIjJVbNTjClyEV?=
 =?us-ascii?Q?QXv9lPr5X/TX66serqfxCc0dPbtJh0G31DdtCIgObNxEKarsB+2jhlHKD9Nm?=
 =?us-ascii?Q?79/nQD/rZXOsXgWtabFBjXWfpXIIQLxAl1ooyySTT0Y9hfngRfdiUv7Oh0/K?=
 =?us-ascii?Q?JIXAfRozJp4wnv97i2VJ1Gpomi61y2e91RSKr2JQvVgKqDA1f+/vW0lyiEmt?=
 =?us-ascii?Q?NRRWfn/uyQXKyvz0V9kDW0Z0YzuYyXzDkpRd1nO+v/D2iw/HsrMTQ/WXBuYT?=
 =?us-ascii?Q?19uSDj19gciXRpiXH9ph7oN5i1dVogqGJjpI9Jx9WGrngmfZLXcurCAbYn35?=
 =?us-ascii?Q?GHax/0VLJyfBlboLxc6o5Zt1lJ7YpteSBTK77Q3I7zruTJvyzDShqEEgSEgq?=
 =?us-ascii?Q?9HnPlR5yCA6eXLJ32mLcPUy2lIhEeSrZUgbAJ2JGk2M3OpzbDS/1bHBnxOP1?=
 =?us-ascii?Q?VKxRIXvnIyqehxPudKJH4waKFB44B7kWo8yEdEl/epCBDrK7ZeltcHsyeKGa?=
 =?us-ascii?Q?FNwY0Fzj3efywya1M3KlRkg2GeAqI7yURbbTQ5GqlGOhEMbsl/F6DvRy2woC?=
 =?us-ascii?Q?gWo4kd/Rno6/38RL5RlrFvXNxZLh20o/IQsEf8Dl0G6EDQH0XwrAopuR4vnM?=
 =?us-ascii?Q?7+GJuoOVKfyxD3ZvDXP4U6ReMGxdLw+ffZ6iVNqly4XIvbY2xV0UZz5pOlN6?=
 =?us-ascii?Q?0oziETwl2gjbhQFyul3Vn8m2feGooAkTY8d8Re28pkxX3qJP0cMCMLZVR1x5?=
 =?us-ascii?Q?ADdUg3yadm+hmwOMVD3QPUsDUN9ZkfwQbboZ7RKMOmFdht0D9WcWGOeJfGV7?=
 =?us-ascii?Q?CDIHM3F9vKKetBZdkOv1Pd8Q7HdDT0z2+f8xzv7P3/15hNlAWIzar13fqwyf?=
 =?us-ascii?Q?UyqcMD9vxh9DCGgyPh5tHyKSoq5Eg8pVSRAT5Oq3dEmS09dftRQF4VInD7UI?=
 =?us-ascii?Q?h7K5bL3Mfp1azKbfUYLgJ34Cmz9WwhUarCrZuydYjgxoceO1MHJ2Q5rs7LdI?=
 =?us-ascii?Q?Z6psMTJMJlEkdo5FWJzBXSWrTOTi4QbngbWNfoEpVatPW5B9NxI7G2qzcPEy?=
 =?us-ascii?Q?hDehfKSaAVLr8QuSIsIXgadfq1l8EgZdnGkwbPlZF4/7i+mel30M8z3yjuRS?=
 =?us-ascii?Q?Gku1LxkENVOG60db/YRhUWsXxKQSkSQiOvcB6trZf4J0Y2Di126kv5whq6Wx?=
 =?us-ascii?Q?jB08HzXx2YPR/pMun5H+5nbHVSXI3qYrxmhyvagJaPN2Eh4w1mJ2hbvq859L?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DT2tdUEuYAQnUOwwPO1WorOjtVOC4vtvFUBBjo1+ghPDTxGXqQx4bThgVR4wik4dTugMt+dstChubVqEubsneyJ8UBY95ZuTJtHCYd0eepsI5p6iJ5NC4b91l6F/N4f9gE64T3pXjSG0BUSEx/1D0uqBVcRu4WaF5hgYaxP4BD4gUn0i2JBs2MOVNQTFhlYy4srtVlW7pjK0bu5YuGGYIc5TDVaE9LQApj+jXuAL786Nyb0OooVwANoqbdTYI1EwAoIr1R+v2HiyUg3vzhw50rG2PIVNwjkBnhLzAgtPs7BTf/QFnwMIUnmdczmthAJwu0+pzXSDUEZR6G8XD80uaEllpt3DK8XdIRQlsE/AZldaG5JBF4gNazhdlsOjvZ5vK+rjXxbjaXC1olFrJfZVyDJKzTxBR59Z5RFFvc5zZurKfNA4+cWjKsLuAzb2vi9bDrfkkE9iQpX/xqZf2TuNppHRAlYzvjyojiW6c0lUnsP9fjZjArOvnEPxqWqQVaGzOUsFYQFVIk652saJO3xZnAzyt4qGTmGA2k9eGt4jtbWx4DghYTJ7QCdBy2FdlmiPbsvgscXpAj9YfZ+Q/VmTzxZX++DMTxGy1ggIDO8ppu1022APNquXgItLENkS0bM1xlrxwo7zoESZAZxsmtR4BKCPpiFLIk+pcKDw8FHeKE+Jcn6niC4Z8GlpAm6IHxz1fKLjP1QsHKTmYsMKv/UFTTq0sU4pGxTBcpMDZMJ+it09iaKhIACT2QeuOnkHPW5SaF6ciSB+OwDPi225o7HfxzxhR91nw2ksyl4C5ObYpAUM0XdYk9m+LGxk1oBtsN8+LiZauQ3oJ4GpZoStiFOXVy51YdLZeI75fs5KEq3hjqXbCU4/DY2aPMOzFYNnebw8sRIEl73rfRUYU5hCPsLW3w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f09c13-ed0a-4c9b-c555-08dafb035e2e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:28:31.2287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IwRJC1CnMdHeMRIwUf+oPsYbmA7DMTIEa6qn5NMUClSrvWlC/2NKrJrnmfX5ikC5q/dy0Ld/YwUqSe9J0GhV3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6381
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301200157
X-Proofpoint-GUID: 8AiYz9vkF5_zet9KPxqzVdmCcOEhTW6i
X-Proofpoint-ORIG-GUID: 8AiYz9vkF5_zet9KPxqzVdmCcOEhTW6i
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

Use the vma iterator internally for __vma_adjust().  Avoid using the
maple tree interface directly for type safety.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/mm.h |  3 --
 mm/mmap.c          | 75 ++++++++--------------------------------------
 2 files changed, 13 insertions(+), 65 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9f519c6ea006..170a06e46cc9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2856,9 +2856,6 @@ extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
 	bool *need_rmap_locks);
 extern void exit_mmap(struct mm_struct *);
 
-void vma_mas_store(struct vm_area_struct *vma, struct ma_state *mas);
-void vma_mas_remove(struct vm_area_struct *vma, struct ma_state *mas);
-
 static inline int check_data_rlimit(unsigned long rlim,
 				    unsigned long new,
 				    unsigned long start,
diff --git a/mm/mmap.c b/mm/mmap.c
index 4a5d5c9a8dc6..19e5a79d5ca7 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -435,56 +435,6 @@ static void __vma_link_file(struct vm_area_struct *vma,
 	flush_dcache_mmap_unlock(mapping);
 }
 
-/*
- * vma_mas_store() - Store a VMA in the maple tree.
- * @vma: The vm_area_struct
- * @mas: The maple state
- *
- * Efficient way to store a VMA in the maple tree when the @mas has already
- * walked to the correct location.
- *
- * Note: the end address is inclusive in the maple tree.
- */
-void vma_mas_store(struct vm_area_struct *vma, struct ma_state *mas)
-{
-	trace_vma_store(mas->tree, vma);
-	mas_set_range(mas, vma->vm_start, vma->vm_end - 1);
-	mas_store_prealloc(mas, vma);
-}
-
-/*
- * vma_mas_remove() - Remove a VMA from the maple tree.
- * @vma: The vm_area_struct
- * @mas: The maple state
- *
- * Efficient way to remove a VMA from the maple tree when the @mas has already
- * been established and points to the correct location.
- * Note: the end address is inclusive in the maple tree.
- */
-void vma_mas_remove(struct vm_area_struct *vma, struct ma_state *mas)
-{
-	trace_vma_mas_szero(mas->tree, vma->vm_start, vma->vm_end - 1);
-	mas->index = vma->vm_start;
-	mas->last = vma->vm_end - 1;
-	mas_store_prealloc(mas, NULL);
-}
-
-/*
- * vma_mas_szero() - Set a given range to zero.  Used when modifying a
- * vm_area_struct start or end.
- *
- * @mas: The maple tree ma_state
- * @start: The start address to zero
- * @end: The end address to zero.
- */
-static inline void vma_mas_szero(struct ma_state *mas, unsigned long start,
-				unsigned long end)
-{
-	trace_vma_mas_szero(mas->tree, start, end - 1);
-	mas_set_range(mas, start, end - 1);
-	mas_store_prealloc(mas, NULL);
-}
-
 static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
 {
 	VMA_ITERATOR(vmi, mm, 0);
@@ -644,7 +594,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 	bool vma_changed = false;
 	long adjust_next = 0;
 	int remove_next = 0;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *exporter = NULL, *importer = NULL;
 
 	if (next && !insert) {
@@ -729,7 +679,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 		}
 	}
 
-	if (mas_preallocate(&mas, GFP_KERNEL))
+	if (vma_iter_prealloc(&vmi))
 		return -ENOMEM;
 
 	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
@@ -775,7 +725,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 	if (start != vma->vm_start) {
 		if ((vma->vm_start < start) &&
 		    (!insert || (insert->vm_end != start))) {
-			vma_mas_szero(&mas, vma->vm_start, start);
+			vma_iter_clear(&vmi, vma->vm_start, start);
 			VM_WARN_ON(insert && insert->vm_start > vma->vm_start);
 		} else {
 			vma_changed = true;
@@ -785,8 +735,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 	if (end != vma->vm_end) {
 		if (vma->vm_end > end) {
 			if (!insert || (insert->vm_start != end)) {
-				vma_mas_szero(&mas, end, vma->vm_end);
-				mas_reset(&mas);
+				vma_iter_clear(&vmi, end, vma->vm_end);
+				vma_iter_set(&vmi, vma->vm_end);
 				VM_WARN_ON(insert &&
 					   insert->vm_end < vma->vm_end);
 			}
@@ -797,13 +747,13 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 	}
 
 	if (vma_changed)
-		vma_mas_store(vma, &mas);
+		vma_iter_store(&vmi, vma);
 
 	vma->vm_pgoff = pgoff;
 	if (adjust_next) {
 		next->vm_start += adjust_next;
 		next->vm_pgoff += adjust_next >> PAGE_SHIFT;
-		vma_mas_store(next, &mas);
+		vma_iter_store(&vmi, next);
 	}
 
 	if (file) {
@@ -823,8 +773,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 		 * us to insert it before dropping the locks
 		 * (it may either follow vma or precede it).
 		 */
-		mas_reset(&mas);
-		vma_mas_store(insert, &mas);
+		vma_iter_store(&vmi, insert);
 		mm->map_count++;
 	}
 
@@ -870,7 +819,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 	if (insert && file)
 		uprobe_mmap(insert);
 
-	mas_destroy(&mas);
+	vma_iter_free(&vmi);
 	validate_mm(mm);
 
 	return 0;
@@ -2002,7 +1951,8 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 				anon_vma_interval_tree_pre_update_vma(vma);
 				vma->vm_end = address;
 				/* Overwrite old entry in mtree. */
-				vma_mas_store(vma, &mas);
+				mas_set_range(&mas, vma->vm_start, address - 1);
+				mas_store_prealloc(&mas, vma);
 				anon_vma_interval_tree_post_update_vma(vma);
 				spin_unlock(&mm->page_table_lock);
 
@@ -2084,7 +2034,8 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 				vma->vm_start = address;
 				vma->vm_pgoff -= grow;
 				/* Overwrite old entry in mtree. */
-				vma_mas_store(vma, &mas);
+				mas_set_range(&mas, address, vma->vm_end - 1);
+				mas_store_prealloc(&mas, vma);
 				anon_vma_interval_tree_post_update_vma(vma);
 				spin_unlock(&mm->page_table_lock);
 
-- 
2.35.1

