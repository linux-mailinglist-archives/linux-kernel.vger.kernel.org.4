Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F46700EAC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238514AbjELSWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238500AbjELSVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:21:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2812D42
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:21:27 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF4aQl021751;
        Fri, 12 May 2023 18:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=VFSQL5/0YuqNDgTT1gzifbZK16he4AsT0QLV48AYt1g=;
 b=V6E7n6im5d8omk5PtoFJzNeGmKm1DIBrNkYiZE/vV63L5bgezKE/6Uypn4DeQs9Eynib
 ty6xRHpzK5axWb4LkQKVk2vQ4T93JMrG4hdJnxkZsIMyMKULREkiWUILN2DGscrs1wSL
 ZzMAq7FSQIk7rhDPNMKUyimU7yBed6oNa1c9tPj3+4uGC/9r9lPMwtRhF6J6PvbH5aKy
 Rt8lOKdND+Ji9TpF9APRygP1js4CbECU2tvdDA39UXYlNb2PFHZZXI5p/Ke+umYkDiU+
 RoUn8q2XOHuqrAFg0z5u9rFZwExiuScs8yX3pIng7j6zBlVXJonJKPo5rmi2vbxMxrLr XA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf7793h1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:20 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CH5evd018237;
        Fri, 12 May 2023 18:21:19 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf77mjkgb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLK0A27ZZTmL9QMr4pr3Vq4HzWSd47yp/3HNaJzTKM6OJYLgOLcj1mHmGOrs+zE0PbGOdC0HtRlh6DdX43yBKBDiXZBCVIZ+y4OnL4C5H+cha6ZCWqS4fONDNzkXhpn1YSmuuoXhMuuLVh6+YAL3jNn4/1OVjQMqoQtbQ7tAg8S9c/GfNKi/hezHRk2AptuwAjuAKG6vd60XTno1MW693pPkFbBRUNupLLPm+W0BWfIMOaU6Xcp3eZAurtG+aQN3Dev835lxfePhy4qBYHquNbfk0dFiDkD7KzqwC7deGfxsfDD4033/+VdLSsX49LXeN0uuKLFxGTFBtJvwV+Pfqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFSQL5/0YuqNDgTT1gzifbZK16he4AsT0QLV48AYt1g=;
 b=CJzP7aXKNxFBzx6ZuB8rY8Kqld94wiZTPnqeKkxEnxfpGKv/2eHDYsefMOgEdiT3tcKUZ78ABJLc4L9jz15s87NA9jrdEZoWKeNHKDBHshh0YktplpZFeSJ4acTKpQzF17Z5frxOfYow9JLY+DIbt56f7Dwev2A5705tXY+bmkKezw63WRE6Ry2z8WIYNB+jJRQIhJZl1Q3FTWbDs++KQ7xHcl7F/sf4ArAx+9S2f1kNX75yRaG2yjtTqHpQL5TatHRPx+iphn5Ceb5nrpdrSko9oAftiw6kyKHA/Flq8SBbtXNAOtERjrDm09qbdGOaz2Ot8rXkj9PtlAy0Q/YnPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFSQL5/0YuqNDgTT1gzifbZK16he4AsT0QLV48AYt1g=;
 b=ofBVi7IA4dPY/YHK07DeND6MkK5tTxZdRiyuhhO4rSQYy17+qt55qpe7ys/sFk+T3DBrrAgSG+i7z0dLR/AFj5LBRTvu+fPwOt7qQmfA1Z4J1q3U1PxDy8JRHuCAOHLtoG+eYQS/DMCqgND+kgajhEseFylXiA9eZ9o+yNp7fy4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY5PR10MB6143.namprd10.prod.outlook.com (2603:10b6:930:35::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Fri, 12 May
 2023 18:21:16 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 18:21:16 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 10/35] maple_tree: Use MAS_BUG_ON() when setting a leaf node as a parent
Date:   Fri, 12 May 2023 14:20:11 -0400
Message-Id: <20230512182036.359030-11-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512182036.359030-1-Liam.Howlett@oracle.com>
References: <20230512182036.359030-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0146.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::25) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY5PR10MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ae5e4c6-b928-473a-1104-08db5315ace9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ELJb45EpXsGs4zIhLpfIY0cc312zgNb2d35a+OtmVIxNP7vkqUybi/YHFgnqID1gUDyKtRNafTWj/tLXqunX1rYMzDFwrdE2vBdGQdSBWF0FLL6ZlDhm2iEtqmARwZOU+7TAKQlNj3aUKzk2hZf5PnljJdwnPp+hBfLIhLUYWdyjVjo0102RTu3gdVccZJj7Uz93Av90ku3hgpNhJtYeGJbUQgRBfb+wx90x0BBUrP96TtSAn+hkG5/cS/nv/jW5tN6yMt4n60FdgUhWnKMk7hsRU6Q6sTtQTzzNyDb0SeEhxyW9yGfzBT7lz5n+8uCgNQdTYr5XSCpU0cFNguxjVHVJxBC/fVq+CiGjZPsf+5I422YIKu5VVwRYFmSLXmZDK0Z/7rsLwZTGGVr/eA880Rlqf06Puwy+2tzdusGCLe6ElO2Yps2PyS7TT3SsobJjvRwDX0zv0yY56x9NsWlarcDPzW/dW0CbrpWGkJlS3r38YtjOxP5t7D5Z892jlx79KwcpTxW3fvGG/19gizo111qIswEHv98gmyKTALLbn16mYau/JrD7vCYzVUTvfw37
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199021)(2906002)(6486002)(66946007)(41300700001)(316002)(66556008)(8676002)(5660300002)(36756003)(4326008)(8936002)(66476007)(6916009)(107886003)(1076003)(86362001)(6666004)(26005)(6512007)(186003)(83380400001)(6506007)(2616005)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u0co7WA51Z+EUZ1jLU/LA9flGSdKwipQpkJQg+ytXtjVg7CSjTx9LgFm+bgN?=
 =?us-ascii?Q?arsQJXKbfoRRPYgk0/LIWMkHizDPi1n4tE+cgdh7F45sIS1SCojr2k/DDe7y?=
 =?us-ascii?Q?buD1aOwmar+56yfgu23YmCsbMULB9oQMOZmbmoZv6f9Szssq2lqmtqBJRhGg?=
 =?us-ascii?Q?HJBSiBz1ixbEhHOfB/DmCocCmOvJTBaDRIFOQvjrc3rfVTd/ogdItiwNYd0Q?=
 =?us-ascii?Q?HjpVEfl5YLrxKQiUzUXHedZGTaxBO1DJh+ud51opdskPQ8XF9RlTjgalO831?=
 =?us-ascii?Q?tioglruZI7XKCI5n8xPI1QYiUaL2oG+1Xq42Fj+sq+nYgcerg1FnAwGb0C4P?=
 =?us-ascii?Q?HkfDXAsBaopudqN93JnYAX4DRCd0NAN5ACzJ4MAYZ0wIt5AUAxwQsFcgp6Lr?=
 =?us-ascii?Q?8NYtZHdNSufqouAkmhaK4YdIrLPXLXoh3lh/YH7ngLi4MA9+Tx0ZtnPd49LW?=
 =?us-ascii?Q?mQYjQVNmV+iIlUNUJPkEa4qX2EPTNFEnl/lnenGbgXr9onoqKp+Y3ZrrGv9z?=
 =?us-ascii?Q?MvJpn5ukzoPDID8MkqSlxHKNXn9LA0QD/POcra2ViM4fBwAyjXQikhsMYJZO?=
 =?us-ascii?Q?NigdhEJXwLgkVM6yMs/91ZWF31GIUdvbh3UVaJ24/aPgH+Juo8LmTWmHAQx9?=
 =?us-ascii?Q?2CUizzksNZE2xthRVFn6f4hfBJeBT9/PDL+J+KDaVcxijcUNsmQVmkxPG2qU?=
 =?us-ascii?Q?WMMZGFBaSevQbl5D/Q8Rj9TSDy8eXCiHhiJVqQypYtH5epkrVVxNJydpADyl?=
 =?us-ascii?Q?sxCXjgImDYalAqeyVknudD+d4+5VmPOTb7JTK5hVFZL5DOd8mzjmxJtqsi3I?=
 =?us-ascii?Q?nkqLy5EanhEx19nnJbZ1QHU9Kdi8zUvywgf8gkCpFYoYtG5Pp6MkqfZQercP?=
 =?us-ascii?Q?GSoBwtHUBwcHjSmbWQfSEQ0EvuZySTU1G39q1Jhnl0IPfzdNy0xAoX5CNABG?=
 =?us-ascii?Q?l8O0OjTspeLL/kmucNu7mIUTGg/cZj5qyKWVMaYIsPaq+kEuxnawO+kfme4Z?=
 =?us-ascii?Q?RUM5ZSUH6Romd/7lXolCnH0O0TFAeVlNXIRfqSu7zI5On2oKNUwzKK0dIihZ?=
 =?us-ascii?Q?57NlKPf3Mr09ioV4yAnt/AG5bWwVJbU4fg0TWNx/KSX/zab+SXw4Y2c5HnQq?=
 =?us-ascii?Q?4e6x0knnQOsueJovWofS95vTuRSckxJU+cezKpndOZ4N5ks9oHH7CHFzb65K?=
 =?us-ascii?Q?LJ3zP4qKA3aooZalH60bALSWZxCFGwNPsCTL3t6YxlXEuchS/Xcn9JPiPl1f?=
 =?us-ascii?Q?knzOUW7/PG9GfIwk4S/AoxZ5vgVdoudgGj0lCgzsOilj3ZEz5CgX72Cx8+j/?=
 =?us-ascii?Q?kFyXTf1y++Wp8w41UOSKeIEYUpN51qWbUsOzVikcrtEV7BDoohh7aIvQLTYU?=
 =?us-ascii?Q?R+FPp++ISxWFKTbpWbE/grJgxTCRvSLHj7gL82d5ElfOfwxDyq0sd32hcbRk?=
 =?us-ascii?Q?nfuR1uVfXfVsA3le/Wx777VXJPc0O1h4VBpACC2ehzgvxn+qRjd+hlglXwcI?=
 =?us-ascii?Q?qL2tohtOza/GyKOzatiz1VNWpDFeKeVftSZxKAGDzj5Sq2pbvVAm1/+ffbxU?=
 =?us-ascii?Q?ZlzmhLKvzsSa8jh2rRbpGyOx3h5WVnOl+TCgN6RQxQd0M1POaJ5giYvp5o9Y?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YhESO8BKUPmgnnwQDjzBS0iZDJZ6j/kApRBuf8Y1AVR+t2dk+ZuvePcXCj1LrragpJim5Z0gwtewMK0EH2dkh1JQ27UkU+XvaxySKxNfl34OEERcTkEMpZ7Cwz61s5+rjkawLP+Xi+wTNhmBWTRC/a2epe7gJoAAZL6Zau/VO9fqmeWdY+J3aZue+NmsDxTaQBCbksSkUgFjMke0inrzmzrM5VoJaqK+bDNa59cT3ShDFFxcXaqn1P5GGkCKoRb1KRwSdN5q7ASFZtaIoWafgAa4CMn9L386Tov7l81Kvnw2xfRX7dw6eu4hRkC3qsloKBoDJ0sHqOUUKwl8WqhEaI0h+re1F7xjvDpWB81/cmX3ifpMD96vRWXRFt2evi1QY+tpH5YJq/PEev3cxHQjkNNPkXylIE8nLtp8qzzkQZxXA4FywURsjwgNthCs0BgUgmWSfhmLSXVXr/DioAIHzyG24ujgB4pWyWWgMNL1P7I1SVPOkLF809ZBmj0eP5B6UID8Aagz3WFe9jfpxuxCQxWHX6cBkM01rgC239cC/lV7imMUXv93ToGiq2mBCW1MJoEIgui82oSeMNmGoJ3TGaWvE+yPNFYXTzqlP54u6PVgLUmx/KHEwPYIrNt5ADC/IpnYrM7A8Dz9mz/KLMgA/D6uGSXjqCvHZBG3T7ESGBR+jnS+JZlV7zOeOSCbl2rkwnSpOZH9R4OXDCcCmKXKqplD07AWtwvYkV4Fm163KcNqQTDbAGxkA9pgbGnNjLBiqXXqswU70NILg85HQXLMVEUw7doeK2ngm5Mcclf8vOxhUzQRvTa6Cv/VW81H1S06D6wHhCDlvbhOE8Pf9UydArFeXwim2b3ab/oNJuRdOcrBXGVR9VNHbXd7wEoQXJpjDJxfyeuCLwwcx0OoNkux3Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae5e4c6-b928-473a-1104-08db5315ace9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 18:21:16.4409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iPl+1ffQlYss0nzQzli7LFou9mVQhsEAIu3Qx0wtYlHCDaEhqs+5LwQyku3KvDR9r3+cA00N92TJpNy4QZ8ePw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6143
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120153
X-Proofpoint-GUID: -5AjdP6ZtjfubMHhkNA_MXYGoXjM4vh3
X-Proofpoint-ORIG-GUID: -5AjdP6ZtjfubMHhkNA_MXYGoXjM4vh3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use MAS_BUG_ON() to dump the maple state and tree in the unlikely event
of an issue.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 8fd83f21caf00..a594f1d88d062 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -453,7 +453,7 @@ enum maple_type mas_parent_type(struct ma_state *mas, struct maple_enode *enode)
 }
 
 /*
- * mte_set_parent() - Set the parent node and encode the slot
+ * mas_set_parent() - Set the parent node and encode the slot
  * @enode: The encoded maple node.
  * @parent: The encoded maple node that is the parent of @enode.
  * @slot: The slot that @enode resides in @parent.
@@ -462,16 +462,16 @@ enum maple_type mas_parent_type(struct ma_state *mas, struct maple_enode *enode)
  * parent type.
  */
 static inline
-void mte_set_parent(struct maple_enode *enode, const struct maple_enode *parent,
-		    unsigned char slot)
+void mas_set_parent(struct ma_state *mas, struct maple_enode *enode,
+		    const struct maple_enode *parent, unsigned char slot)
 {
 	unsigned long val = (unsigned long)parent;
 	unsigned long shift;
 	unsigned long type;
 	enum maple_type p_type = mte_node_type(parent);
 
-	BUG_ON(p_type == maple_dense);
-	BUG_ON(p_type == maple_leaf_64);
+	MAS_BUG_ON(mas, p_type == maple_dense);
+	MAS_BUG_ON(mas, p_type == maple_leaf_64);
 
 	switch (p_type) {
 	case maple_range_64:
@@ -1740,7 +1740,7 @@ static inline void mas_adopt_children(struct ma_state *mas,
 	offset = ma_data_end(node, type, pivots, mas->max);
 	do {
 		child = mas_slot_locked(mas, slots, offset);
-		mte_set_parent(child, parent, offset);
+		mas_set_parent(mas, child, parent, offset);
 	} while (offset--);
 }
 
@@ -2705,9 +2705,9 @@ static inline void mas_set_split_parent(struct ma_state *mas,
 		return;
 
 	if ((*slot) <= split)
-		mte_set_parent(mas->node, left, *slot);
+		mas_set_parent(mas, mas->node, left, *slot);
 	else if (right)
-		mte_set_parent(mas->node, right, (*slot) - split - 1);
+		mas_set_parent(mas, mas->node, right, (*slot) - split - 1);
 
 	(*slot)++;
 }
@@ -3104,12 +3104,12 @@ static int mas_spanning_rebalance(struct ma_state *mas,
 				mte_node_type(mast->orig_l->node));
 	mast->orig_l->depth++;
 	mab_mas_cp(mast->bn, 0, mt_slots[mast->bn->type] - 1, &l_mas, true);
-	mte_set_parent(left, l_mas.node, slot);
+	mas_set_parent(mas, left, l_mas.node, slot);
 	if (middle)
-		mte_set_parent(middle, l_mas.node, ++slot);
+		mas_set_parent(mas, middle, l_mas.node, ++slot);
 
 	if (right)
-		mte_set_parent(right, l_mas.node, ++slot);
+		mas_set_parent(mas, right, l_mas.node, ++slot);
 
 	if (mas_is_root_limits(mast->l)) {
 new_root:
@@ -3336,8 +3336,8 @@ static inline bool mas_split_final_node(struct maple_subtree_state *mast,
 	 * The Big_node data should just fit in a single node.
 	 */
 	ancestor = mas_new_ma_node(mas, mast->bn);
-	mte_set_parent(mast->l->node, ancestor, mast->l->offset);
-	mte_set_parent(mast->r->node, ancestor, mast->r->offset);
+	mas_set_parent(mas, mast->l->node, ancestor, mast->l->offset);
+	mas_set_parent(mas, mast->r->node, ancestor, mast->r->offset);
 	mte_to_node(ancestor)->parent = mas_mn(mas)->parent;
 
 	mast->l->node = ancestor;
-- 
2.39.2

