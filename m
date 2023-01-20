Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9276759DE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjATQ1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjATQ12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:27:28 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD53564A7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:27:27 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGBpcd001467;
        Fri, 20 Jan 2023 16:27:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=HOuP1wdPLGXr10HTf9kF8BkTzEesc6os/zC9AAnQSAM=;
 b=rJ5fOgH4lK8DOCGGb5jkRZA1DwWZfKe6aNhAw5+6QFP6RZ609MaxI2BGK+dKJuPVfIqr
 dA2zJkdL8k9XSPT1jLa4sQyWtiyfxsHApSnapNuF8y5FLh8iMNNlziA77jE0yPgJuPog
 JUNw4+PPnows1GgO4Ug9feZYGEzOqFPpMk/nGTSRgBPrjIgMe7Ot+CZ4VanzA3870zwB
 HGGvVol3Oi9Ly5Nf6nRiCL0vFSJZ3VOUUW7oQgWCzpE4jl1a4PB8aIiGSaT3krmTpLHr
 XvuBuXNSnhFd6tLZR3E+YxAVtnGk+r0meTiTBgpFeP7tM2AF6SF4I3L+/S1PT2hUtwZs Cw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3kaan2vk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:27:19 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KFYo78004648;
        Fri, 20 Jan 2023 16:27:17 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6r2w1ec2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:27:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buY+MVpj3QHbZCjprQLjqqgnd30aMXHqwmwwGiWWccNiq6mqLxtG1XRB4edCHi9k2s5qFWMJPRMN82A6fuvJXUCEufoKCt1CWcm+JBJgv/VaapSLMU9Az2so4fPbcA4STqLHd6WZ/d38OgnGRVsMK5bZLkKnQAAVs1yJSL6iXDX8bwtByKalnbKN0X/R+mcrtTOSWIl1KI2nQMsCowsPznvmRfIL0S+hDzaciy4zccGWMHsAOLQzEnCt8aO/HZOJbSA+Mc17mjJRu3yTaKObQDKYHBubTWW8+Q4uBs6zW4j/lvA84Jw77rnFJ0PtjZ3cesPpEPz5Hboa/+oY4nZKTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOuP1wdPLGXr10HTf9kF8BkTzEesc6os/zC9AAnQSAM=;
 b=n15EnipXUHiZhg+fFekyT6pGqeBmFgOWWaso+eCgXL18K3dYrlRiE2pc2kEsF7kC2nSUuuyNzkmKTD8sZur312SuzbCrfrvugRbBKnSQdOIyzkkyuqwBmJ2FAANt0/2CKhOY9IZzoNEaskdPD6DidhLYps00DqM2Nquu3ySOW96Vy43HP7cW++6jn98ObgouXEtDe7BJgmfHHiKS72ByhC4IZjtu8OzB5teWYs+MPnhcafbZeI8OX+avhFRlWC0FfEXqYChrXJmH4uy0Qn375Jg2G6ac9+7ZWBrxLJ45qR25jsuDxF8xJcDsOZNkelHkTd0Y0lT9fU9mrjZzdtY/NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOuP1wdPLGXr10HTf9kF8BkTzEesc6os/zC9AAnQSAM=;
 b=FzjLYM+5rFnIZ/Ela6oxZC3BCKNalKa/UtQJVG47APR3aE5rmWO7fcXdDKNHsjHPBOBNBpsUxz/W3/cZQa+Y/EDpwBE76bDSZ7bnNU7cuUK+uaTEDbISIVzjc+5pd7Mh0JIT2vlHM9Gwtlrc/YOe0FW9hdsHTha90b8eFkLK9TI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6026.namprd10.prod.outlook.com (2603:10b6:208:38a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.7; Fri, 20 Jan
 2023 16:27:15 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:27:15 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 02/49] maple_tree: Fix potential rcu issue
Date:   Fri, 20 Jan 2023 11:26:03 -0500
Message-Id: <20230120162650.984577-3-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::27) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB6026:EE_
X-MS-Office365-Filtering-Correlation-Id: c37b1635-cc0f-410a-a210-08dafb0330c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uQnWbXSWBhV61+mn8FoICi96sfJNnmKu5tVRhpQFTlhyBQ8x5NPlArhxyYGMkq9beWX38ER9q+RRUkAy//KcdslRm6/5jzh4LFnHLACqDLvjCpJwDAmZwK1trnDQm+a/Ao6dHjsUTKy73v9zWEEgtilbo34E4Tbl7HTqk9tiEbNOwIqMVkWSLHtgkgdqDRlEP5F79377t3KKpNl92xU4pnHWlcc+v8GCZPjkTLiNu2bxpnRhoK/yWMLKTvmSslN+paoPPxd2kbjhpye8v4X6sLtdZQP+8YQ6D12FA6RqQTnyu8IVsCPXxgPfkm50QQASxiPDI9O4U11Zx2T45V3hKcCyi2Ti9h6Gn8xTdbnUTHfAYiOy9uKlUA23aNffSJDXWxQnEdO3iS40wcdqXhrcreoIUEX63RsirZGWU9dm0CL22RB0ycI/0nzUUfa49sJmEY74kEBsiTB3glmlkpCmU0geCUrcR/Pfrx9pJZUUXUCKpZOnKODHq+w66oQiHJe7S0lkgeqLn4sMpfB/reWnGfgKcHkhaohHiQJ/D4m7I95f43rjxX5P9m/1Z27IPWuKA44KYg48nyNzYIIwTh34zyRFyi/l4+whBQpRXVjj05Mlft9OFSADkvCdI7yQef6DMcIX+dqmWFgSgEmfBjoafA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199015)(4744005)(5660300002)(8936002)(4326008)(66476007)(66556008)(8676002)(66946007)(36756003)(6666004)(107886003)(38100700002)(6506007)(26005)(6512007)(186003)(2906002)(54906003)(6486002)(478600001)(316002)(2616005)(83380400001)(41300700001)(86362001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lr0akurNueGXr/9gwsdILNXVoskfbc0rPzQkVhZ0xvBMKqN2SeJM9Wa9Z38q?=
 =?us-ascii?Q?cKedJfupruyTJVshy8WLKtWeNxIjtMgN5HBDyJygKPIt8wLdaTgt4GPa0X7W?=
 =?us-ascii?Q?yydKPFzZgJHFAO0KASyqUY8DEARgtzQ5NQE9Wy1GwbA9ppp2SViJ+vcbxGAX?=
 =?us-ascii?Q?GvpSsRI1NbIyGFx0B32dl1fP5ztUPclrFjA3e4w0VJgadx+tWe/TIpH2N7hV?=
 =?us-ascii?Q?/0xQixUSh4OwpVnfL1L7sGoWS/5BvKHezHD4wsyQTHgv42fHn6mPJ8zt6j5Y?=
 =?us-ascii?Q?TOD8GshL19vWIkhYZaqjHiPYxMHdriMs2iGDkdXMJSW9uNZuVeFsRnBxD356?=
 =?us-ascii?Q?Nh69GCL5oBeu2VXdjzb54Lk2qRE9RPHvrtiC7DGtm4cD2lXNuqgkaAqfDFxx?=
 =?us-ascii?Q?+Y36SkYbZPXEevpX3k9OdqsgVkUFhhZSgVK62Ls3YVSiov+TXUtnd5ssNOMV?=
 =?us-ascii?Q?AwP9Ts05p1M0EDuTpgThV7UTPUNyRlKjoTpWp8XNopUDxTAAu00joWBijaEH?=
 =?us-ascii?Q?OIWIgmPw8SZmZCYyC1D+M0lWTfzddBZCU7Jo/nSgkcpNXU26SYHkDOa2VPUh?=
 =?us-ascii?Q?cgeydwE2AoIwz9DXXfaANFVcjGPtNTDAAZ382Cs9MM7bjXuGsXCrjwINCi3A?=
 =?us-ascii?Q?QWjqPC/1IWC2SHoPZ7ks18im5PTox/SCn2i/n53PQc1MDa6xkvP7Ww3YeCLu?=
 =?us-ascii?Q?NC7j9lNcrvkiLDblJKrAZzRuIhkm/CdvucrfO44kny/QYxMfL8o2OZGpTJMh?=
 =?us-ascii?Q?F0sx/4y0SKclaZp4aUkYJVulNIzrIIRNhbBhOMNY8BgZIyVjdPJY+IFO6T/3?=
 =?us-ascii?Q?rblSHdzimDybORD69QtnvhXHJCseVmLKdiEksJpaEciYfjFKDs9BYIDKvTYN?=
 =?us-ascii?Q?KyM6AOvBcxJQAv7F+V3uegZtlf2kYO4SKjwOrTMZn3YTR2z0OszGt2FcIhmj?=
 =?us-ascii?Q?RQ7zLxiPmBw3aAL5MF0FLYLuSd8JZytvk793wxTTbN7shAFp2oglE3UQmRAE?=
 =?us-ascii?Q?nJKfQjiVNBkx3UO9TC1setcvUt7vXJpSwLpNTgpKAVBc/dKaE5Tf7jswmLrc?=
 =?us-ascii?Q?PQBDCGwm6tJDHKd/soPQK4Cvf7DW9c/15DJcrHMPT5D+NCUt+KPsI9Mvcc+q?=
 =?us-ascii?Q?Tzq2K/WAvIITVqkXInmMzmRlaDgVrb37pSvzo/cZN4NK5zsnzQHRjnWUDR0T?=
 =?us-ascii?Q?HWnlraHI6wJVyic0cCVZugLGx6WUhf/gyLkITo5yqqELv1/KKM/xwvMjoDnv?=
 =?us-ascii?Q?y4BJdsJP6Gk0sWJqj7jkIc8cZahr6c8dB41oAA+ouhqZrxzpMXv0s1oHATmy?=
 =?us-ascii?Q?IbcJf4KncDpC+Wn2qbjb31+Xlz7SFRzk7LxcB1NrMxhcAuzPkyDTlPPqD0FF?=
 =?us-ascii?Q?NhMRfocfCbdcD403HAFx+WY6cH4qzXWNgYUzUtD3T5bdQYrzvSHnFDKXR1Hv?=
 =?us-ascii?Q?C4Zzx5235dgg+twCEvEXynP7LNT/7GoAp8pNiPOPhdu9MrxXQ4LMMqBe/cgV?=
 =?us-ascii?Q?8dschbPqkL1EHPIrAMRzG3kN8/VqaP9cYh2MoMtlVW834z76MHi9PeO63q2A?=
 =?us-ascii?Q?I9YJGAbtaYZOdZ8e1s9ATa23/PComJ58X22XGbjMQsru3PsG9THJLgHl4pe0?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /nQVCW+Z3qOMcGnEnW0bmOdi7WPjoApyONnyOxdId0QIY1kPiLrRC82OnVuBhRroqJxgYMpMhIrRIRdjhbqztUd/zNd1QMa0K7Y9I/m7eCDXlh9YtVsMf1D0YZWxog571gPjUcfVgV+Q/x1WY75czV4zW+0pExr0KfviomQRyQqQZcDlrHRvTQhTsQGFS21ve66keMgDhkpL+bl/3YUilo4Fkep8Z7lfKvwXR3Kup3QIi4yoK+Ze2uvDNhTcxpJ+0WRevpNiUsAwuN8DVSa5S9CviA+rln82chIRX12WOgXpQ1sN8ZsSFga+5ktAsYRvIzsWBZGI4Y5FwVyJJq/QTlAwczLlQMVYpKcUm2jxvD1kBubQewUNm9diypI2o7hPELle3eND9FsFwIS6fe34q7gfPIbnJwX9Lk4/ZcOxY8xwOKV+LgI7vEMG/Sjr3rtVpeDE/kPf+UZZua2gAORzuawo60Q6e/8GDISy7SaeHo2Kwn/0qWnX3NW/jsau93hQ71aaZS2kxBpFZSmRZGgA60QFTcqrfclDxNGAq3UlR24Oa4IGZnjkXrADBUeE2PxNCQJ011AZXdd3C7SC4yDw/RM23hpKc4c4LATm1l15JMaPP2AdVYwu7L4xSexs5fHobzQoSyan8/1Nz+llifI7VuY5fp53Uy/o6agvcQSQaTUU1PFiTzRgc7HeR/DSfEmdCEsctDr1pFCy7IurSgTc1ue/4CuWwU+vHx9XvTbJ++kdKxdVB0ciu1UaHSup0Cbt7v3IaSrGv3IykneekmAFT/ukKgWi7PA5VqU+RfolJZspDhu0Ofr3j6YD9dR+okEuKlSreksEw6iu3pHczTU4SvjKyFkMZiG2bromcVhe2tGCmFFTPwJgGD9bvUDCQfaH2dXZqneBMUTA9KYXxwRbpg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c37b1635-cc0f-410a-a210-08dafb0330c8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:27:15.0306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r+L9sbhixdiCSmpLLH8cb4QHc8gUdyEBGI4ry6lynY2p+r/SLOm3aX0bSZtupnirN6j1gVYwPV0kspMA9S/RNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6026
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200157
X-Proofpoint-GUID: G57RChurIdEpAF8qOmehsOYComgZyq2S
X-Proofpoint-ORIG-GUID: G57RChurIdEpAF8qOmehsOYComgZyq2S
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

Ensure the node isn't dead after reading the node end.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index cb8c03c4dce7..cbb8bd9b9d25 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4654,13 +4654,13 @@ static inline void *mas_next_nentry(struct ma_state *mas,
 	pivots = ma_pivots(node, type);
 	slots = ma_slots(node, type);
 	mas->index = mas_safe_min(mas, pivots, mas->offset);
+	count = ma_data_end(node, type, pivots, mas->max);
 	if (ma_dead_node(node))
 		return NULL;
 
 	if (mas->index > max)
 		return NULL;
 
-	count = ma_data_end(node, type, pivots, mas->max);
 	if (mas->offset > count)
 		return NULL;
 
-- 
2.35.1

