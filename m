Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104656EE3AE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbjDYOKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234335AbjDYOKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:10:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE526A57
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:10:38 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDiYpM022658;
        Tue, 25 Apr 2023 14:10:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=p8bYlVicQX60f75L1bnEUO3IOESeVNSC3YS+Zx2A1Tk=;
 b=a0+PAvCLqVGO12lOtnY6YW3evh7AjfNdXSQ7u0q5uAOIfsDhEgFpubv7UU9IjkTmIRyg
 kOOLHptlyObOO2cdV3wLNglmqov4t4B40YpD69xJ+ivQbaeNFa4VW9DG89ux1tsA6bgN
 aJZdGvT9qGPanvuoO7IIDszI4Y/FKvmaXhTWUZFeae7ojH2I2WBIXsGduv7+QPkFmLhF
 7kBBmSyKcTKAEGXnGftTZkQD0OeM+ro6OjbvEBZa2FMqc3MMTCe6otDJobh9iOnyuquw
 3bjbxc1t8ZRbHLCsdCCrx9x5OpkBzAUDf3GAsCnX6ftZKqVD4r+XcoGzGxrngZwXVb78 rw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q484undrh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:10:27 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDSKCP007654;
        Tue, 25 Apr 2023 14:10:26 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4616gcp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:10:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=huN2vwlftAx7dUnrkHJxW8vADu/kqzmgrXdeYubBGPpDbB0AfeLxFC788CMs0u2Tyzz7wopY/kSBEo2Shr2WeHL5rM7SizoaWSuIuefGLbp0JbcIDi7IUBNzuhmcsrEhkQ9UQwRprfoTC3zNo8xNQAs7Ppl68IfLjCR9NpLfRtd7jpzAUBwCBGPo5zAp6keLhwQbOfNRgqXyMH+8bHxpzWiNGIf6XzdElMXedyRyVvzU4RHqCg45pLsDN43QHi+VBFmax/9vAsQnF7bn9FLK2q+19T1Du4ausG6Np9nzRThb/GVDwzF+GEJsj0oNHC/hzKZmLbEL6jNg6tuKDoerVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8bYlVicQX60f75L1bnEUO3IOESeVNSC3YS+Zx2A1Tk=;
 b=LzlbIagqO8CNwzO9e7cYDHi3e+Usey20RFwlHWehuWfniYnHDxbZWAqP1nQSgrq3bELFc9vBl+EcAFOKDVQfMTkB9FZ53AsCljhyEW275Z1BJE0u+u18nAT875L4A/AriRqLwDOY05ktamgn6XXjltEHE2VY1fpqdpTT8yzm21mlf8/UUK6oEADXiThw4btEw2UQmHmREtXDPs86N40Xm3pP3pzQh116CWy7W5HNrA1Xu2xGMb6iuJH4lzCuxwQLKrzUmglSx9F963V9X9fPkvoRnOchPTj27/2GDEjCblohFrb8z3r9N1sWSCalHyQXHoYIa5QLMic4Tz+P+qfvAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8bYlVicQX60f75L1bnEUO3IOESeVNSC3YS+Zx2A1Tk=;
 b=mVmyAEmIdO3bhQ+uziC8cS+XIeanSbjiVDZzMSeZQTWqJgu56qV5xfTYaGKxutz1VCkkbEhacFDxS+MNqF0JJhFAZX9HEz1gEGJNSJ2X5ZI9saSXsma/ZIbXSRRsQj4N5A7o5l6nCJRN/mwE+Sp2GH9W50ld15eMl78PU8tiyx4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB6081.namprd10.prod.outlook.com (2603:10b6:510:1fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 14:10:24 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 14:10:24 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 02/34] maple_tree: Clean up mas_parent_enum()
Date:   Tue, 25 Apr 2023 10:09:23 -0400
Message-Id: <20230425140955.3834476-3-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0108.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::25) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH7PR10MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: c9f6cae1-1b02-44ad-540d-08db4596d010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NvmkUF+okBTuFvhmt1zxExWSbMZVI3hSg5z6PlRwAlYMXp8bR9M6C54PQ3l8YJeYt4gdvIkuRWSeChLS0bgrx4kbRzTmvYWG5vk5NZPa36xzjo6v5Sw74eSvhetvYOpF8ayEk9fBtD1fRWo7YuXXqhPqw3Q9PCKH0eZLRxxmEa+eTZUyTVeYEBHDeUn0cqynjtELmGANfMcFCTrrjiieTWot989M2BNmQFcVwcbXwVJwG6V9nAnihMAZmhjblC8+vA5toWNIQn9rzhR6PjhhhoKLtEUUkvUQIk58wPqzDMTFjTvEvT/H3YK0OxfWpfQWfje6f9qzZcdcAmam3qZyBZojzp4kIcvbOmsNvfYgrbkSKKvU5ihlwNY2QSruIo0/sykj/RpJoOG6Yi7w8np8Y3AFn0q5TnUQ32vGStxNrp2rH8V3anoCqjSKYhcYDc1aEmavKq+HyUH6H0ERD+Qi729BE6/tBcG2qLSI9a8qi7wfDfA+/oiXmmQv0cyARDdrlQyxACE9oiw36Xw5JidvoZ6jze+VV7TaTdmYNL2Dxl86XwOrgOnBoFjmHS3MgSZY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(2906002)(66476007)(66556008)(66946007)(6916009)(4326008)(316002)(5660300002)(8936002)(8676002)(41300700001)(36756003)(86362001)(186003)(26005)(6512007)(1076003)(107886003)(38100700002)(478600001)(6486002)(83380400001)(2616005)(6506007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7zwgsBbXTWSrlWtkl+jeiZ/gHTyoOpLFRDRL/Kg9t5qdZ3W4wM7UuChET+Ea?=
 =?us-ascii?Q?apbzxZKXXTAIrouHbgdXimW/QhCkhDUA9JdetqNiKNdiwq1/C2s09KzsAfpK?=
 =?us-ascii?Q?fOT2WLlIG7MFAw0LjuK2hLG05z/p76Dh+J9sPRFWdEiq5SWZfyp7zYCPLdfz?=
 =?us-ascii?Q?9YW5eOI3pLQWqN5rMhmjsdigM5Wd4IJR6/Cj4vMLya2kaBLs7Vw9mt8TX0RR?=
 =?us-ascii?Q?e2qEGeAldzJBX1z1YEdn8qwfciMJzqwFCcO+/TygJWfnGCzXASk90UzGspte?=
 =?us-ascii?Q?Gzp0B+eyLkqf0ZsXDiEhXHCb46tMRtgApp7+PHZIq4ePqHVaWssGbTk61Sef?=
 =?us-ascii?Q?zVwIKkQxoQC+HHvcHM5OyNCsjXqNQXy0NZJDmHh81f9/4AmBGaWFnZYtXOjb?=
 =?us-ascii?Q?RlhHwavaJ8t0bOkRqt/byUwcCQmoVy6Hbja32GM0zZffJ6RnvavSsPyhXiWS?=
 =?us-ascii?Q?2LpTGQjhoa+GKk962GKDfEapuWq8bJFiqzZndadNahLrUl9VMlIGmR2HXtLx?=
 =?us-ascii?Q?XJKYkn5GTeHk3XWqF4lNJlYUnKY7KjqZ6lgye5CDA9bNFJccVPJTdBZ2fK6L?=
 =?us-ascii?Q?Pj53PggjQ13JkIIeNrbZ2lIZsTiR7RoijkG8roEbMOEhRlshpvwlheuuE7mV?=
 =?us-ascii?Q?mxaFnGZc3OsHqdXzQyXniaP/C3tlaWW0flIoiAcfElxXph5sd8pdhT/F8+85?=
 =?us-ascii?Q?77ZLVaJVboT8byJYodP5P1ABwWQ/ODpidpvXp76/xAVyuzpcIQ9C1e9cFoT0?=
 =?us-ascii?Q?14qvn1lSuNDAcC7gCAzAf1z3pZvVRLa8524a2tOnXr0QamkG0fpblRocsWap?=
 =?us-ascii?Q?0U9qAvAzjAo2qAiWO+ngATv7m7Qmt1/HPJLkAfqVL6+9AA4Rt8QHg3KDxLEt?=
 =?us-ascii?Q?BJHx/tFcfci3SouGe2AOne/VgGFfOF+H2WhCRDA/Bq2x57FNI6dy7Dyj9AsU?=
 =?us-ascii?Q?RS56aO/1HAw9MEcB8XKL0QN8e7XcZduUN6HAPa447LsAivfd3oFhsrhbUhvZ?=
 =?us-ascii?Q?hXxmNDS6EVWIXh78vUQKsSAIK6EnuCxc0Db3VRxUse78nNbtTYssXggZreGl?=
 =?us-ascii?Q?IN0MU2/S6xcmrXxmmO+1JrrbvJpOnxPIa53y87Ns6uODxxIvA6rNLi+FzPig?=
 =?us-ascii?Q?wvfBOtZehGHEf/1AbhbqAk5cAD7qQO1vg6cB3q2ToG/2TvDw1rfC3FMmLIn2?=
 =?us-ascii?Q?waR2MP0T/uLf6dcZOLf+UZUSfeECY2XMvErxnMVxm0YucVLvl+INC+L3rs7w?=
 =?us-ascii?Q?Axz0QzzM/R1s+WRvwf97Xhv9ey1Q2djxo+jKF8TKZ1p8dlDAGTXDMZPcx71Z?=
 =?us-ascii?Q?F0WK0HEnKd27zV+L9/hY15adctRa/J+4qLMZcOUVpxnj42v1njf9kt7GsMdN?=
 =?us-ascii?Q?pXg4SWXTH5tKU1etrDG0AMHNkHBAzy06iOkgQOayw8fLifzkT0kOSIA5QULy?=
 =?us-ascii?Q?NeHyrCKDMw0djMmqTv4CmiUZnzLyesYXtBRSATe9pgdgDjWoPs8G30axHNig?=
 =?us-ascii?Q?trAIUJbGOcBiB4y3gVcR/8Ia0Y2xRtEYMtyl8y8vGzjVqwyptGnWALgwfiMs?=
 =?us-ascii?Q?obd8vcbnVSrfzYgiBxPIY/alvbJiYlH6Fugn7xk2U9vY9j4kdMQo7AHtJvd0?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eRKCnrNQe0d6xf0g+j8A0/eHcmOe6KDPuFZBwIrvw7EEXZKsWm+FXJ3pWSvUrb76Ik2/yPwhV7qCDKLcebH7vRqEQ+Z+gI5e2eOceBhf9OzZWukpzSzWA9fyqTJwUrKDnW+inXD9o5fHdKVNABLSlkpihqGeojBXYDLlpEBjjVYltUMDoxKdSDPoTkG53QjSix0cMDGY94CLtNf1WIPhihX57To8nC/VuuxpmGgT4qZmER5imeHe7Fgw15OoENA6+mriBfXT+vYwYhlZhU1x+HTrrDIkUjYdIVrSMb0kVtLjAl83nhIj3JNd5Mi4xAq1xWhiA61FG7NBMMuU26g1GXIKf/mB0lDNrsAGbPq7ydqfSREDb7HeXkdvPRuLFf03pOK3aRquaAjmThswcyrsRnNcgAnf/BNN5PUY4QD2pm/5DZb/JelbtlFmkcf3PnW6bNrI1PGPUwNoaRzd6vDTtXFkSLB0lbIXIipncPCuOl5UNmXjumcTjjNdafojDaS4K657YRu8SId8dHolZgGxiJ0n0iWWtyfHoiE503Ypzaew87kcl37C1uWooItxJP5Xq6jZseovkllZDdmaUxPlR8ZAQDNmYawJqJrisaTNGzj44Bcz8iqmz5ped53WZaM3vbw+4ubM5ZqOcjw5NegjYs+tP2s/+dvFDFH3c4la0sATd3a5bbfVQEE4uHOBSiSMZRm081L6v3LXLUUj2t9h5N1Hro1vnF3cYDe/0nCfHfg0F7NpY7BT1K+XwGkCL2Fcd2nXD2tHlhWYtrUMc3DDxq7NdTfWTCe7DLh6lS0vrzvvahZyxkof4bgkQlquMJntChF0jtJ3sjZlwy5pmwpwNCJZFoy0CxK8lPBwizGr20pHacvZnrDxLYGeanvE/Mkpig+TnHfSO0QnS4s7kUNcvQsViW77dUhCHALkwsiexhI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f6cae1-1b02-44ad-540d-08db4596d010
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 14:10:24.1920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ALcmypgBA/367MnkhrdBJA1PxQuU12uRnhlt5kzYAbjVCwyjaThEaNtcavaZgFY7eyRMcMc8Mf1YfkEbv/YvBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_06,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304250128
X-Proofpoint-GUID: bptD89mFRTTn4pZQYcbisEMX_Wg-6fqM
X-Proofpoint-ORIG-GUID: bptD89mFRTTn4pZQYcbisEMX_Wg-6fqM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

mas_parent_enum() is a simple wrapper for mte_parent_enum() which is
only called from that wrapper.  Remove the wrapper and inline
mte_parent_enum() into mas_parent_enum().

At the same time, clean up the bit masking of the root pointer since it
cannot be set by the time the bit masking occurs.  Change the check on
the root bit to a WARN_ON(), and fix the verification code to not
trigger the WARN_ON() before checking if the node is root.

Reported-by: Wei Yang <richard.weiyang@gmail.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 9cf4fca42310c..ac0245dd88dad 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -428,25 +428,23 @@ static inline unsigned long mte_parent_slot_mask(unsigned long parent)
  * mas_parent_enum() - Return the maple_type of the parent from the stored
  * parent type.
  * @mas: The maple state
- * @node: The maple_enode to extract the parent's enum
+ * @enode: The maple_enode to extract the parent's enum
  * Return: The node->parent maple_type
  */
 static inline
-enum maple_type mte_parent_enum(struct maple_enode *p_enode,
-				struct maple_tree *mt)
+enum maple_type mas_parent_enum(struct ma_state *mas, struct maple_enode *enode)
 {
 	unsigned long p_type;
 
-	p_type = (unsigned long)p_enode;
-	if (p_type & MAPLE_PARENT_ROOT)
-		return 0; /* Validated in the caller. */
+	p_type = (unsigned long)mte_to_node(enode)->parent;
+	if (WARN_ON(p_type & MAPLE_PARENT_ROOT))
+		return 0;
 
 	p_type &= MAPLE_NODE_MASK;
-	p_type = p_type & ~(MAPLE_PARENT_ROOT | mte_parent_slot_mask(p_type));
-
+	p_type &= ~mte_parent_slot_mask(p_type);
 	switch (p_type) {
 	case MAPLE_PARENT_RANGE64: /* or MAPLE_PARENT_ARANGE64 */
-		if (mt_is_alloc(mt))
+		if (mt_is_alloc(mas->tree))
 			return maple_arange_64;
 		return maple_range_64;
 	}
@@ -454,12 +452,6 @@ enum maple_type mte_parent_enum(struct maple_enode *p_enode,
 	return 0;
 }
 
-static inline
-enum maple_type mas_parent_enum(struct ma_state *mas, struct maple_enode *enode)
-{
-	return mte_parent_enum(ma_enode_ptr(mte_to_node(enode)->parent), mas->tree);
-}
-
 /*
  * mte_set_parent() - Set the parent node and encode the slot
  * @enode: The encoded maple node.
@@ -7008,14 +7000,16 @@ static void mas_validate_parent_slot(struct ma_state *mas)
 {
 	struct maple_node *parent;
 	struct maple_enode *node;
-	enum maple_type p_type = mas_parent_enum(mas, mas->node);
-	unsigned char p_slot = mte_parent_slot(mas->node);
+	enum maple_type p_type;
+	unsigned char p_slot;
 	void __rcu **slots;
 	int i;
 
 	if (mte_is_root(mas->node))
 		return;
 
+	p_slot = mte_parent_slot(mas->node);
+	p_type = mas_parent_enum(mas, mas->node);
 	parent = mte_parent(mas->node);
 	slots = ma_slots(parent, p_type);
 	MT_BUG_ON(mas->tree, mas_mn(mas) == parent);
-- 
2.39.2

