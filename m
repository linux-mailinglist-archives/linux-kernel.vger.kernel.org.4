Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540C96F87EC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbjEERrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbjEERrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:47:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78F31E986
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:46:33 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhLXI028060;
        Fri, 5 May 2023 17:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=NuHwCjXvI30g9aIE3crnZm6Jgpwz65O34xwD74RRmY0=;
 b=DeYKuHFxfWwGKXYBNq49kiafpDJw5aseeYODeRVAKCeopBZrfJnbSAFAOi1HxFJ2L8uZ
 I+XpWetrNhGZHM5ALJxX/ExXCnOzZTtFd9NUuZbt7Cogmvp4sfahebSbolaSraqTZg9L
 TyDZs5uHXvsTv5xa2c8+mxx6rmBLYj19zp5QZUOZ47UWRd5Bap1+IsRAdYIB6ZAXaJSs
 /nzutXHyuEeOtd6hh6ncunip6seJS30CGNlR+vrxizeZTM7GcfdEX7bNrX2IstH4Yh8m
 9XQs52kJtQHfuglTCuP0RU3UbOwdj5rh+ofkx7Vn+ogi5XGkiiC1Zrkq2nGaxx5cevbn Rg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8t145jd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:28 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345HcUfm040467;
        Fri, 5 May 2023 17:44:27 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spa74bw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZVzvCqkEB/07IKAmAhqBFhXRx84JnNq3r6HtMkU+8l/tgl/LvtdikZblxj34fwy38UgwA93m5ENWTykYHdVWVpTU7duzjk5TncjDOZIKvNbCdaPffcSryVzXcslg3LKLbRAkh6Hzi/sovf6tGeV1ZKwSYujVGpqhqPViQQKkcYOdR9WdSpPGgB5UtjiD06JQDureZWEhbyVScXuGFzBBJmmc/ncL5J3I0i5ZEyODix+RPHlOdjCURRfVwb7eqUv3MkI5ixUEKaZGDsg1X3x5SGC400xEua1kNToM38h06TIG8e/0qDhnKzv+M+H7Am8dY9LXtqY2LZvXVDs5yZJPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NuHwCjXvI30g9aIE3crnZm6Jgpwz65O34xwD74RRmY0=;
 b=Cmok8GzGYZ1moaifGre0gyrUSwH+8btF8sXjncqbClp0wK0ACMO2fOlHPdmGBnNq49wQsS5f+ADkFkamtQ5b/v7v0FDfAf/lyuHURDWl0D09cQcDJ9smuw2Do9UQ0+99+aZKFqWWpCuMOTVgiZ7EMSQ3Dnn4gsOPBWFo8kvJSOgnGQhDZaoV8eU/00sE9dBSD4xYep4yYZqfLVWhkrZLrr3bX0poUQHLw6T2iIUDt8xdhKpHaRRPv+eVqyMpBv1mEZy0e3dCvAA5SStoE3L0ZmIyJ1gba9iFaF8rXfw7pSTIk9bny9DUnt3TUaYkCc5WjnB7qFC/DCc+78xOaorLPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuHwCjXvI30g9aIE3crnZm6Jgpwz65O34xwD74RRmY0=;
 b=px1QxLzIdzvpqWkhkLjGEidJy2xnIISmtQcKDa8fXPr8/FKNJ2Q7dHyXxUkvNyEs/AbTPR2PV3F5DdYuLd/O8S5AjyNgCPIb+k0yCZ2/C19KTnS2expfQMmhHUhr90ebQe7Feahb1VAky2MSaC7PI9Zs7Kfjs8ElrMkVe7MDvOI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL3PR10MB6089.namprd10.prod.outlook.com (2603:10b6:208:3b5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 17:44:25 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 17:44:25 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v2 18/36] mm: Update vma_iter_store() to use MAS_WARN_ON()
Date:   Fri,  5 May 2023 13:41:46 -0400
Message-Id: <20230505174204.2665599-19-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0042.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::23) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BL3PR10MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: e0b6c3a5-82f9-454d-beec-08db4d905e30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G8rtO0jO3/RpZyXLp+3jlyeJgG7BffmoUI+qVvlCiWfn7Fh1dtUHPYFLp9olvCxPNCttT1l7p41kdOHYoHWboWCTv6miMZ8Tz0uWh5EgfCvXF+u8mh0Mti/6JMD/6vimWJa1pv+Ba6U+3iUdyW/eRm7A9fBC9Mtrc/LNv/E7iyaE0m1hbto7mghaEV8sllQ4+f1fjarRwLnkW0Zh2qN3+PDrZNSwHreXHxsFRcpvAiSoUyE3uWRajXL4RwkarlXZwKcZBpWfQHDPcsI1KYqTNCvhEvspBMz/YTvFpF3D0aSzYWqgJKbwCa7rwlD6pF6fgN7H6rl375w2tgAxGqfgHO2nFfmlkshcYJ2A8zwACv07oXeX6iiYn7HRaANmzbotn4xCUJMSGtYbGGMYwEFm40UPfApV+rfJpsLXBy4Co+VhGSC3OKJs+WZUTi3i4mn6naP3TXp4YLdSpOXdgW7BzCD69z/IsEBkQ1C1QZRJvughMLw0y4d7lT7cXX05ZrAHdFUKzxYkeNv/vNVlkLaO8DTfkDdcnpDXnIDtcqYMHbYGJ4vZGIxMEQQeHtNipQmK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(66476007)(6916009)(4326008)(66946007)(66556008)(6666004)(478600001)(6486002)(316002)(54906003)(36756003)(86362001)(83380400001)(2616005)(6506007)(1076003)(26005)(6512007)(8936002)(5660300002)(8676002)(2906002)(15650500001)(41300700001)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VjvI3exbFocWp9BQ+jNQbnwtCyJgwAsk+2mYFBUfPb1hs11rLutSdclD/TWa?=
 =?us-ascii?Q?BuuajlX9axD+QuYLbXLUQIP1mD6GGWL5o6JHKCryUDDYCmZ1vT2Eug5CEd40?=
 =?us-ascii?Q?nrMC+CD/9FnvuKfKV3PtReT9CNJljBdBK12WCzrgB1twkIz6MDWSUdpmKOGf?=
 =?us-ascii?Q?7g8wq6cCPaQNFSLQ7SnEf5g6XmYO4AayvqYzcwiwLMG4hWL7LyzAAMk0GhWB?=
 =?us-ascii?Q?Ty+Z4IBs+eAC0NU5dfVyNV6plRf0kMw9Gf15NvOiVBJSAi5TVNdRUmRk/+NN?=
 =?us-ascii?Q?AqNNHryj3i3xM1xgpbOW2GTDiTLG0sRnD5TRnpgXOrCvuMtAJ3pirvtqcqug?=
 =?us-ascii?Q?SyjMokKCu0TCnCbo9vgIVPTzCfgkhfWeJ6zxd7XYDDyhzk5uYsTAZ7Zk6a9s?=
 =?us-ascii?Q?JfejhOYPGPZm4on8UHDpJxWGMXg/aQZnrouy0i38WEasSMuT3DsNDzdKN40/?=
 =?us-ascii?Q?B/R0DVfozbsKfgc5ie1Kg5TrPMAI9zbw7XT3Q4msRkW2Xg47efpxKG186VwI?=
 =?us-ascii?Q?9s7hXugbm+WAbIg82trXblWCx67Z7kYxKEMsbT8a0jq2Y6Sn5iFdZvxZ2CG8?=
 =?us-ascii?Q?eNDLptCLVOuPZmGzoHG3Gk38sVJGK2CM8fP606UAlKnef04oxz+9YJ+veNUP?=
 =?us-ascii?Q?Z+3KGgMZIAXWanEmdVYT9OCPcdbIWEjr34rvZI+nU+7O/Lel6h6LIB7sa98k?=
 =?us-ascii?Q?ZXASTMRRDrJYq6LTb8ARzb1ZUShm9H3LNkUQ0JV2aP/uUD6PslaWVRBPIUnT?=
 =?us-ascii?Q?eHw0G/ARcjT6f8a3oq8ToSSSJ09lYtzZ2kX9A1IrbJwYSrkTjDsrx4kE74IH?=
 =?us-ascii?Q?BfxpEuGkRXYEm8eLj88+kxQdpx6jAIX7WAlEpjJotxk+tQsE4d9EYOnvX192?=
 =?us-ascii?Q?83KVu1QQoLCVyl/V4fQX0qQOWUgj5YlvMK3xhZ2zoxG8v4DCbDbmRa/DNBZF?=
 =?us-ascii?Q?0ALdjJWFN/OzHxk2Z/R/+D2vdokMM3/DHwPRTQqM0MgP2i4fXOgNa/sq+jxM?=
 =?us-ascii?Q?fbxnh6DmpcC1kx4SjHxumrnecysvDZehGtXnwRp4eStFhAuE5ohwKQY0kNoc?=
 =?us-ascii?Q?yEe7Bx9feSHiK5Vo18xjV1UycjdbqhOqFo63CJcgWcheHQtlOFwmGgSU9JTJ?=
 =?us-ascii?Q?MA+iZ2v5A8T7Ibi7Fcz4fTWwypO3X94eg5WJlsQSjpLUy/OhSob1tbiXhrWY?=
 =?us-ascii?Q?JhmF+BwJk4VokMDDIGE2ZFJf3lkJXcfiOWPL5qo/Oq4XRakgol5gNqCI37he?=
 =?us-ascii?Q?kHT/CrtzGFHsTIntbHPnGBj3+oMTWoQQoG/kytKZdbI6IoAMxlDMcxhTJHT0?=
 =?us-ascii?Q?cOueOGMirAa3mCF8jJ+tifP00Jxs/6NR4fwsAo1rEAMwW4Pr4ZTA0cr1+/+b?=
 =?us-ascii?Q?xKaIL9s1ftk9vawqLoELGb7UA+aFk91MBjUFJrI61eiN+7sDMQBh/BtMDCqJ?=
 =?us-ascii?Q?9+fsLAADAq2fB1q5zCUMV/fCWuVDE6HzPBW6K1xBoj+T/QCAVKwLPB15l+dm?=
 =?us-ascii?Q?/HW16ZBeEOLLaV4MBSrrPl3XQXsED4uh3tiRJp4PFypWBvEoRagSuxhV4isI?=
 =?us-ascii?Q?UX1CcaZaaOR5Ammctr2bIF1GFljOXrecF+WZJVxsEQsyprRoIwJVA9qv433X?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0Bqx/PExt6CeimaIHC4OyySQLJLnhiOfCuGvpKsnBOrsT52Ln7UDnXvL1eLwIDh0Ca1cFSgyx9Fab81pYaWIWXWFwH8kphfcISMPQ3//5Dvoeqy+8nSOv465WsY5y/tHMMQgSlC88yKsfDxQmYXqH6wqvnUIUl9iIGP/21MUGYZSFi2LoiBXRtyo85e2Svut7OfhtSa64sNQSTCRrjQSlGGyVW+Iv+9m35IaAAn65HM/HlM0nyEfFrZjaFBC9rOqR1Wo5OhAhrHyyBv28AB+Tui95cmsfRifM+Vwqigts3u9kSXknepulkREYdrFesNqPVq4XFY0vSpyn6AmhSo3eM1qdA/SDV9LbHwe0oQAX59lGETuvsBZb8kzdnBuPBbzyOv6lgGQ/NbtB4SxY0zETpcmibkP2BHVJTXjKmxb+3vwMOPHVfZpyz2KbKmvziOp8m/69aM6Y5gJD/DTFDbGTDtRSAvojLmf9BCyeFzQ/xWG8gY/BXduPSk0sBHIAWrqk1YobiA7B3HbszUhFOyU2a9Fp8/Gz10+ZP2WErvTz54HoTSgpn5PSn8o+gvfAbDv+uLytIVjqNkpUOKwJc/ZVzjdTd/y3MDAbTHnk3tlkvUalieHsXtzLyZTiIurKPJY6okaN/MqAZRf6wd+iB5PexulcaLQX50MQi2jMx5rbkAbkY1/Hs2soPZ6rEX6TcK1OnMNmgvy3bduUMMWY/pRmQLCa5VKrcf4pD7qtTCh+SmWB3cUmh3NJlm/7fCbc4TMntjJL/kehx3vywftQaGeE+ZhsqeHHY/SAVqd1PLPHQwUrqc/aPt7w0EbCagjl1PHPpwbUtoMd/U7Rj0Uo4nJDJ4ClrwDTpOFMPreaIjP6GEGQCGjipRBtqrDLT7zRXJ/yQzMDR15E6csEJ1F+MVCGtdQJ9lg5LnhfLYHqVbFeFE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b6c3a5-82f9-454d-beec-08db4d905e30
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:44:25.5238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2GD9rHRB++dw+p/+70OvpC7WF2dXX+8Rd+SmtdweOVaPv0n+sd6SYzIgHkJs7hlrinrGOleoUodVnqxyMTMGMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6089
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_24,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050146
X-Proofpoint-GUID: doIPoNrvrcjG4tLVKVDZwZsGvm7XjGIN
X-Proofpoint-ORIG-GUID: doIPoNrvrcjG4tLVKVDZwZsGvm7XjGIN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAS_WARN_ON() will provide more information on the maple state and can
be more useful for debugging.  Use this version of WARN_ON() in the
debugging code when storing to the tree.

Update the printk to a pr_warn(), but this will only be printed when
maple tree debug is enabled anyways.

Making all print statements into one will keep them together on a busy
terminal.

Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/internal.h | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 8d1a8bd001247..6112108322461 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1047,18 +1047,23 @@ static inline void vma_iter_store(struct vma_iterator *vmi,
 {
 
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
-	if (WARN_ON(vmi->mas.node != MAS_START && vmi->mas.index > vma->vm_start)) {
-		printk("%lu > %lu\n", vmi->mas.index, vma->vm_start);
-		printk("store of vma %lu-%lu", vma->vm_start, vma->vm_end);
-		printk("into slot    %lu-%lu", vmi->mas.index, vmi->mas.last);
-		vma_iter_dump_tree(vmi);
+	if (MAS_WARN_ON(&vmi->mas, vmi->mas.node != MAS_START &&
+			vmi->mas.index > vma->vm_start)) {
+		pr_warn("%lx > %lx\n"
+		       "store of vma %lx-%lx\n"
+		       "into slot    %lx-%lx\n",
+		       vmi->mas.index, vma->vm_start,
+		       vma->vm_start, vma->vm_end,
+		       vmi->mas.index, vmi->mas.last);
 	}
-	if (WARN_ON(vmi->mas.node != MAS_START && vmi->mas.last <  vma->vm_start)) {
-		printk("%lu < %lu\n", vmi->mas.last, vma->vm_start);
-		printk("store of vma %lu-%lu", vma->vm_start, vma->vm_end);
-		printk("into slot    %lu-%lu", vmi->mas.index, vmi->mas.last);
-		mt_dump(vmi->mas.tree, mt_dump_hex);
-		vma_iter_dump_tree(vmi);
+	if (MAS_WARN_ON(&vmi->mas, vmi->mas.node != MAS_START &&
+			vmi->mas.last <  vma->vm_start)) {
+		pr_warn("%lx < %lx\n"
+		       "store of vma %lx-%lx\n"
+		       "into slot    %lx-%lx\n",
+		       vmi->mas.last, vma->vm_start,
+		       vma->vm_start, vma->vm_end,
+		       vmi->mas.index, vmi->mas.last);
 	}
 #endif
 
-- 
2.39.2

