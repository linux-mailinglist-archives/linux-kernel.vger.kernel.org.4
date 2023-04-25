Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8FD6EE3B7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbjDYOLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbjDYOLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:11:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0206D15440
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:10:54 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDi2Zp008719;
        Tue, 25 Apr 2023 14:10:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Kft5REKonD4Srs2Rad0KiajjvtvFMzXh9RlWg1rTwc0=;
 b=zdAb5kmUDIpWXTaQEWuke0WIsYGjPdIGzov/kjQ52yBXS5gd0ZZTo/c+c+9Kd9yTL4hV
 mBX3EajBSfOE7+CuNPxSe/ZZ9u1P/DZTJS48mixb7HrdHye8GHFXpB8OLDBMJQoBYON6
 ExOxMIDzIuWNf3jYPcSbfu0Uj6hhB0+hEewSGGoMJmlGaGIGmNuQPLyFGWtqetcYFzCa
 P7+8mlzq/oFH5UJbN+xfiervmxSoM7UNceBpjBc3+Q6uX61oZVTB8iC1zEi6JtaG1mTJ
 hiSCV/A+E9E7URcvq79eVWrFPCW0dzAYJreGGY55sJzgQ9xepP90rR+DRL3ojDONTM62 qA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q460d5e4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:10:47 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDJkRf032787;
        Tue, 25 Apr 2023 14:10:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4616qsr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:10:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMt6jEnHj4hTQXMbJXTjr6DMOYNSGu0xyrFe3DYLEaFLtgHeEzhbpkYSKMhUUjIXy7ZEOkksO6W2uobot36XaTpcbAEDuAavpxG4hqg8vZ9K9WbzEi7B0dKOWJzRghgTgsVWwf1Hq2m03OpZhhXngkTxgJRe0KwGdSov6FHeIIQvMsQRDwx9PgB/rwR1cHxBKK/HoBUNi5dy+m2ov77RkOrVM298YB64999VleO9gmmRzjz9mRsSAmTrqQajbyK+TP9Pnz/vEszqY+fMg4xWmkzWB3DY4VCnHFsdN0GqKQBYyzLqPJjxIZR8cyGvUPtuoX0FNA6lAoWfKOArNSDKlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kft5REKonD4Srs2Rad0KiajjvtvFMzXh9RlWg1rTwc0=;
 b=Fbc2K9JmgpIYp7C/KEkyTX4DuWHCg5Zk3j0KQ74cxCB5sTlf43nyIvRABFFt1ZBVYcL/W6ogtHnrG1jGgpAT9eN4UOs94xiG4jIZcaOzZewVqvskNViM5nrpGDoL+O0IGATkJrz4QaiJOsvtk8WM0FywPL5nk78QTRE1CmUAXIaeB56clmKii0DNhh6bgXVll9WD9693UMj3zgeDPxiuX+6XRFQzZZ7Z1tUCdvlyLxk7a2/fNnJeT9W7FcNoNT9OMYmSPjSAMdZ1g43SjI5NV0GHOLmdqHF1hFmZ400N55wwGDP/uYfSkJenOgPjh3Rt8lp22qbiXaRDY5GC8NjogQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kft5REKonD4Srs2Rad0KiajjvtvFMzXh9RlWg1rTwc0=;
 b=RMjzRY8uiUK9jV2+rgDxH92+P6FtAg2QwzwTRdzmc5weyIF7YSmdRC/rPSQUogEjB0xcMjdQcN7R1aqHl9JgHcYIHJyk0VpeON1fHPAwoEMecrqn0rF50LpxyD9ZeTzn6XDOdYjpi1aeEZAJv79KwcdrKyFC69wcO/yqk1oSc+U=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CYYPR10MB7650.namprd10.prod.outlook.com (2603:10b6:930:b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Tue, 25 Apr
 2023 14:10:44 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 14:10:44 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 11/34] maple_tree: Use MAS_BUG_ON() in mas_set_height()
Date:   Tue, 25 Apr 2023 10:09:32 -0400
Message-Id: <20230425140955.3834476-12-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::9) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CYYPR10MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: ddda0046-44f1-46d1-7909-08db4596dc56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JcFKy9KdOnTqTRWczZoXc0Wt9nPjLTFhWEspg7ZEVa7G0WZF59qX1+huAhHhB+JNVawYmX00jNZG0GLU3WcLqO5sPc6xGAmsTQJJFOXyuKisCpoUKNtIVIgEG0ExLwcGrlnKu1ltZ/e2iXsdT1HH1cQ4zmf6swdBaEe3ZSUyQqvTgvwQrHwwf+dkNuwN7G7kETAASKGOIJziqYQ7PogzgsioI6nFkYu7aY2QYExSIK0To+oEudN4QBoq3hutFSCK40K/6Pw2G1B6+6zrne80o/anyO6fOm/s7WWCz4FcWc/WtcWG8A0fFnppSDzykVKNVyBeClFhr2KDcMFtedC6xQ8EaMZm7PIpiYoXjpgdbFSvx6UCe/hxCxOWtPQ/aoFuTxjDayicZb9jxvEvgsPv4lPiVsTkvkv7K5VDrwAHZgqGO2YqZ3b2dqPtC4ydS2szosgIFCjsO8MgD5cX31O85vwuDPt2lBo6Scf3zBT3H8KD4aGgUFYJbxYeJwIjT7du+6V+cNzXkMzQ7xXZzBDjQ5bdQIGBPaMC8dToEl+C4hUpvFX7xyQ4aeHEvIR2eQ5k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199021)(316002)(6916009)(4326008)(38100700002)(41300700001)(5660300002)(8936002)(8676002)(36756003)(86362001)(2906002)(4744005)(66476007)(66556008)(6486002)(6666004)(6512007)(6506007)(1076003)(26005)(107886003)(478600001)(2616005)(83380400001)(186003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qNdUQDsn4vejCg/kY7jl5scHa+z1dlQXv+wFUYUer0lY7CeVZVf7GgP6t8ZQ?=
 =?us-ascii?Q?IbpnZRU5Girg1RJXbvXnqtVKr43Wpmx2nNnkqB4uMLqy9o0fufIRnoco5U7s?=
 =?us-ascii?Q?1pJFU2Vgm8UlFh3dLwqbew3b+yA9blqdc/QB9r8I/GBTolHPDu4I0xVeaODG?=
 =?us-ascii?Q?GJXfu1fGi1i22NVh+qDwTa7f4ncvtufGsSO8aY6+ymeHo2youknKAo0FhUza?=
 =?us-ascii?Q?5m5B3U4SBdagvMkkXO9fpt/bUq01jBNKPpaiEZuyBF6+EeLdX76FbNGJ34QG?=
 =?us-ascii?Q?+mRcsBYx5kdE0Mf7whwH1nqZuHn/DwLK91BFs2Mf6h0SS3htgtDksTrGAYs1?=
 =?us-ascii?Q?3kEKpKkeRiZzKM0sqBtIf2R/4s6Pth80gROGl3w2lOuYdPByje3UzYHqqMP1?=
 =?us-ascii?Q?nzaZwr0smXC3hetUDD1CubOSfEPUwTHVTGJ0VKPRayAW5sPKpMvJKmR+VVZ2?=
 =?us-ascii?Q?Dlr8XffZ4FI+F1k4e24ye61Okc1v+gCXTNKas3m2rQWfxyRxeuYNH+/NuOhF?=
 =?us-ascii?Q?B+6dd4VdNctlmPpzf4Uf5vIzCHZxpN43MpfYf9264hYg/zUYiQcln490sinP?=
 =?us-ascii?Q?C59qsrvpLCqKvOXGZ8B4vBzTpJwtVCG0YFH7Ur7yYMJQ9nm7KVlIpzuewlZ3?=
 =?us-ascii?Q?9LBFFWkXuQQUJAFdfegn9VsEPQA7Dv6KCm6JGNpYdq4xrUSdTjMr8AeS/WAQ?=
 =?us-ascii?Q?C93zWYmnWThh5JrYwpVhFxtuI0waFx2mhUcuzZg2rptLL492VYuhuA5G1uAU?=
 =?us-ascii?Q?1+QG26LYt3KAK4kmG/zwOYYP2zOwwvDacnjE+cBYGJd4fCZjczgXwkPV+w+4?=
 =?us-ascii?Q?1JqtGKg1I2iWw5lvtws6iRuPe1PtBwc0Ot7fCVukeTJS+KietAzuR6rJ/uaO?=
 =?us-ascii?Q?9DHVtGUoiRDwLw1joVSThPE3FHeXPoDPlskq8JgpOTPnHha9OrmXS1aRO+AC?=
 =?us-ascii?Q?lztB063WdytXTFfVUHEIKBsxPPGI9+3J+3X/QQ1E98qeCTlwG5xs918nBJts?=
 =?us-ascii?Q?t5DEw8QBtAHx8Vp0j1ftSy+h6jNJLz5usTUeLAppVj3noi2ayImkcZbwSPFQ?=
 =?us-ascii?Q?Nu8MSuvUIe7mRAHm+6ORhSY7zrDf6jxZzIEAxEH4Rnr67UVAs/M/8RuMNYwJ?=
 =?us-ascii?Q?c6IwO6Z2nJ81ICUzO7ClBqM0v/+tmlDYxfX6msEqCuxjh7GPmDIxZ4Zt7OFg?=
 =?us-ascii?Q?ICW5gJiTlKda8qeiP6NChHGSsztoNV7GZzzoeYv0ui4eOxbwojV+nqPVYQhW?=
 =?us-ascii?Q?tNi7Z4j/fL10vdrwMHkFqqhMyVPUnC/yopiRLJgjcPCaxWAyKk6yN3Dx+T/Y?=
 =?us-ascii?Q?0QJNWRrOtXoAt7u/V9c3fDUy+gUPgnzpQe13y+6UNDa+51bnYviT6W7wGNZp?=
 =?us-ascii?Q?E2qcKimUzQpHNIfYyvkbepq3cXWoaUmYxkYGFbfH7rcPS8oS3FsZOKXbCd65?=
 =?us-ascii?Q?Xw7zoaV3AHFa52e2vMovyHfFZHzU576UGi1KN5ThQInmo02kRU5VgIVDLdfR?=
 =?us-ascii?Q?tNcrcXaSLXGFo8zJ4zhVMacdhN0weQ/bK8KqjZCe1waq30prv/ZXNYPPkzyE?=
 =?us-ascii?Q?GhlVXzCasl9SdGTMno/2+S81+mvu5FE0mWNBr01DxVhb0uww14bK1873Xe5Z?=
 =?us-ascii?Q?0g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: R6h7xf+iM/jVjHCn3ZnV3MqmEx69BW/X30b0+EhDcYyqUtYg4ck3BGtEu+mIviTP6WoJGCvhecxJU0WY2aoXZhDs9k0UAufEav+FH+CLPpgcF5jy8kzvxsxTrSdJuznmvO7ltwiBA3gLuFXKOTawzIEOFLDPqcLP1mHA6Z23aoh3QUfTHHqpMFA/9VyL/MmwaVy9t5aDPMS4Be4/lbdRSPtYQ9qajolBHRCzOEdE0z5yyBRFkLvQWNqFGmIGE1d1Cv2zi0jZx2nDIn9JhIl9T1nSWmxLsGKLbgKU+a1yTabtLyhdR9N4KpIMTd4vjciqBfVY1hGRWN6L+Edp0dW2DM7zaL76oF0jQvmxLTXSwoWvLAxiehlQmmQ9F8QtGwn5WnVibGMKhjUmy/WjV+UPFGZhwsLh5I7M91hVcLZNn2yhWJOtfABZQQvpmlqGb+xEpEPJuQ81qX3ZnhXMY7W+JshM2fA7GxVBEIJEmibX6M/rHNVClQO9h3pBbcflBTCF4LvC3JWRbls5WPTJeFua3QAicYUh6nwbhR0Lb37OtkDrZoeAqYucRmDiT47OPxPm+/jerbletBLjNBXkanlqSnf2qsnMCJKDXtHDkq/wQ11MM3KgB3v5ZaCI7HEEjlAOfvd2s110cG969xS6iqnaeXAq9WmYhkV9jS05HGpBDLOnqPLxjvN0xV0X++YuAliC+OiAGZagOsmEJ5feGU8tNwfAD0hzPxiKMuKaKODK/g3mbNv4aD09/D0zyueUF3UqgMbw/eGiXK8JA5X3FYrvH0Hqhe2pR3q/rvCm8hXGtT4lD7EH73faRDktIQfdzPJI27Nir8/FHHQ43zDFL7QmexuDBv0vCWJ2SbAxpM/bwasKkPhpA37Acd87VANFBc8/fnmJmublQEu/Xjjn8zh3DQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddda0046-44f1-46d1-7909-08db4596dc56
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 14:10:44.8060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iedxUfOvok6JOIKU0WreE0PJzY7ptoLO4gjIJn0NiwEsKZd0YUKDelWhG+Cw+boDTCynAH4A9avLVCRY9N2M+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7650
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_06,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304250128
X-Proofpoint-GUID: 5eCsCrHMlg9rpdwdkJZY6_BwnNgZGZVi
X-Proofpoint-ORIG-GUID: 5eCsCrHMlg9rpdwdkJZY6_BwnNgZGZVi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use MAS_BUG_ON() instead of MT_BUG_ON() to get the maple state
information.  In the unlikely even of a tree height of > 31, try to increase
the probability of useful information being logged.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 441592be039a2..f1ce3852712db 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -194,7 +194,7 @@ static void mas_set_height(struct ma_state *mas)
 	unsigned int new_flags = mas->tree->ma_flags;
 
 	new_flags &= ~MT_FLAGS_HEIGHT_MASK;
-	MT_BUG_ON(mas->tree, mas->depth > MAPLE_HEIGHT_MAX);
+	MAS_BUG_ON(mas, mas->depth > MAPLE_HEIGHT_MAX);
 	new_flags |= mas->depth << MT_FLAGS_HEIGHT_OFFSET;
 	mas->tree->ma_flags = new_flags;
 }
-- 
2.39.2

